(add-to-list 'load-path (concat emacs-home "js"))

(vendor-require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; http://code.google.com/p/js2-mode/issues/detail?id=50#c7
;; hack to parse json properly
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

(defadvice js2-reparse (before json)
  (setq js2-buffer-file-name buffer-file-name))

(ad-activate 'js2-reparse)

(defadvice js2-parse-statement (around json)
  (if (and (= tt js2-LC)
	   js2-buffer-file-name
	   (string-equal (substring js2-buffer-file-name -5) ".json")
	   (eq (+ (save-excursion
		    (goto-char (point-min))
		    (back-to-indentation)
		    (while (eolp)
		      (next-line)
		      (back-to-indentation))
		    (point)) 1) js2-ts-cursor))
      (setq ad-return-value (js2-parse-assign-expr))
    ad-do-it))
(ad-activate 'js2-parse-statement)


(defun js2-round-to-multiple (n m)
  (* (+ (/ n m) (if (> (mod n m) 0) 1 0)) m))
q
(defadvice js2-multiline-decl-indentation (around multiline)
  (let* ((original-indent ad-do-it)
        (new-indent (when original-indent (js2-round-to-multiple original-indent js2-basic-offset))))
    (setq ad-return-value new-indent)))

(ad-activate 'js2-multiline-decl-indentation)



(setq js2-consistent-level-indent-inner-bracket-p t)
(setq js-indent-level 8)
(add-hook 'js2-mode-hook (lambda ()
			   (setq indent-tabs-mode nil)))

(require 'js-comint)
(setenv "NODE_NO_READLINE" "1")
(setq inferior-js-program-command "node")
(add-hook 'js2-mode-hook '(lambda ()
			    (local-set-key "\C-x\C-e" (lambda ()
							(interactive)
							(if (region-active-p)
							    (js-send-region (region-beginning) (region-end))
							  (js-send-last-sexp))))
			    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
			    (local-set-key "\C-cb" 'js-send-buffer)
			    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
			    (local-set-key "\C-cl" 'js-load-file-and-go)))

(yas/advise-indent-function 'espresso-indent-line)


(vendor-require 'jquery-doc "jquery-doc.el")

(defun pretty-function ()
  (font-lock-add-keywords
   nil `(("\\<function\\>"
          (0 (progn (compose-region (match-beginning 0) (match-end 0)
                                    "ƒ")
                    nil))))))

(add-hook 'js2-mode-hook #'pretty-function)

(vendor-require 'jade-mode)


(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))


;; (require 'js2-highlight-vars)
;; (add-hook 'js2-mode-hook (lambda ()
;; 			   (if (featurep 'js2-highlight-vars)
;; 			       (js2-highlight-vars-mode))))

(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode t)
                           (setq flycheck-check-syntax-automatically '(save mode-enabled))))

(flycheck-def-config-file-var flycheck-jscs javascript-jscs ".jscs.json"
  :safe #'stringp)

(flycheck-define-checker javascript-jscs
  "A JavaScript code style checker.

See URL `https://github.com/mdevils/node-jscs'."
  :command ("jscs" "--reporter" "checkstyle"
            (config-file "--config" flycheck-jscs)
            source)
  :error-parser flycheck-parse-checkstyle
  :modes (js-mode js2-mode js3-mode)
  :next-checkers (javascript-jshint))

(add-to-list 'flycheck-checkers 'javascript-jscs)

(vendor-require 'tern "tern/emacs")

(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))


(provide 'init-js)
