;;; package -- init.el (For more snippets, check here: http://whattheemacsd.com/)
;;; Commentary:
;;; Code:
(defun add-to-load-path (filename)
  (add-to-list 'load-path
               (concat  "~/.emacs.d/" filename)))

;; === Turn off mouse interface early in startup to avoid momentary display ===
;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
;;(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; === No splash screen please ... jeez ===
(setq inhibit-startup-message t)

;; === initialize the package list ===
(require 'package)
(dolist (source '(("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t)
  )
(package-initialize)


;; === load $PATH from user shell ===
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;=== refresh automatically ===
(global-auto-revert-mode t)

;; === ido mode ===
;; (ido-mode 1)
;; (ido-everywhere 1)
;; (defvar ido-enable-flex-matching)
;; (defvar ido-create-new-buffer)
;; (defvar ido-enable-tramp-completion)
;; (defvar ido-enable-last-directory-history)
;; (defvar ido-confirm-unique-completion)
;; (setq ido-enable-flex-matching 1)
;; (setq ido-create-new-buffer 'always)
;; (setq ido-enable-tramp-completion nil)
;; (setq ido-enable-last-directory-history nil)
;; (setq ido-confirm-unique-completion nil)
;; (add-hook 'ido-setup-hook
;;  (lambda ()
;;    ;; Go straight home
;;    (defvar ido-file-completion-map)
;;    (define-key ido-file-completion-map
;;      (kbd "~")
;;      (lambda ()
;;        (interactive)
;;        (if (looking-back "/")
;;            (insert "~/")
;;          (call-interactively 'self-insert-command))))))

;; === show matching parens ===
(show-paren-mode t)

;; === trailing whitespace is unnecessary
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; === stop creating ~ (backup) files ===
(setq make-backup-files nil)

;; === Set cursor style to bar ===
(setq-default cursor-type 'bar)

;; === Enable Upper case with C-x C-u ===
(put 'upcase-region 'disabled nil)

;;=== replace highlighted text with what I type rather than just inserting at point ===
(delete-selection-mode t)

;;=== Keep a long log history ===
(setq message-log-max t)

;; === Remove GUI toolbar ===
(when (and (featurep 'tool-bar)
           window-system)
  (tool-bar-mode -1))

;;=== Replace all freakin' ^M chars in the current buffer ===
(fset 'replace-ctrlms
   [escape ?< escape ?% ?\C-q ?\C-m return ?\C-q ?\C-j return ?!])
(global-set-key "\C-cm" 'replace-ctrlms)

;;=== move code region up or down ===
(defun move-region (start end n)
  "START Move the current region up or down by N lines.  END"
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

(defun move-region-up (start end n)
  "Move the current line up by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) -1 (- n))))

(defun move-region-down (start end n)
  "Move the current line down by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-region-up)
(global-set-key (kbd "M-<down>") 'move-region-down)


;; === delete line without sending to kill ring ===
(defun delete-line-no-kill ()
  (interactive)
  (delete-region
   (point)
   (save-excursion (move-end-of-line 1) (point)))
 (delete-char 1)
)
(global-set-key (kbd "C-k") 'delete-line-no-kill)

;; === set tabs to nil ===
(setq-default indent-tabs-mode nil)



;; === Line number in margin ===
;;(add-to-load-path "elpa/nlinum-1.5")
;;(autoload 'nlinum-mode "nlinum-1.5")
(global-linum-mode t)


;; === YAS Snippets ===
;;(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0/")
;;(require 'yasnippet)
(yas-global-mode 1)


;;(require 'recentf)
(recentf-mode 1)


;;=== Circe is yet another Client for IRC in Emacs ===
;;(add-to-load-path "user/circe/lisp")
;;(autoload 'circe "circe" "Connect to an IRC server" t)



;; ========= Web mode (primarily for jsx) ====================
(add-to-load-path "user/web-mode")
(autoload 'web-mode "web-mode")
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.styl\\'" . web-mode))

;;======== Customization for web-mode --------------
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (defvar web-mode-markup-indent-offset)
  (defvar web-mode-css-indent-offset)
  (defvar web-mode-code-indent-offset)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)

  (defvar web-mode-style-padding)
  (defvar web-mode-script-padding)
  (defvar web-mode-block-padding)
  (setq web-mode-style-padding 1)
  (setq web-mode-script-padding 1)
  (setq web-mode-block-padding 0)

  ;; Auto pairing
  (defvar web-mode-enable-auto-pairing)
  (setq web-mode-enable-auto-pairing t)

  ;; Highlight current HTML element (see web-mode-current-element-highlight-face)
  (defvar web-mode-enable-current-element-highlight)
  (setq web-mode-enable-current-element-highlight t)

  ;; auto indentation
  (local-set-key (kbd "RET") 'newline-and-indent)

)
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-hook 'local-write-file-hooks
            (lambda ()
               (delete-trailing-whitespace)
               nil))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-delay 0.5)
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes (quote ("e80932ca56b0f109f8545576531d3fc79487ca35a9a9693b62bf30d6d08c9aaf" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(fci-dash-pattern 0.25)
 '(fci-rule-character-color "gray96")
 '(fci-rule-color "Yellow")
 '(fci-rule-use-dashes nil)
 '(fill-column 71)
 '(helm-buffers-fuzzy-matching t)
 '(helm-mode-fuzzy-match t)
 '(helm-persistent-action-use-special-display t)
 '(helm-projectile-fuzzy-match nil)
 '(helm-recentf-fuzzy-match t)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(next-line-add-newlines nil)
 '(recentf-mode t)
 '(undo-limit 1000000)
 '(undo-strong-limit 1500000)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-error ((t (:foreground "red" :slant italic))))
 '(js2-external-variable ((t (:underline (:color "red1" :style wave))))))


;; === expand region ===
;;(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; === js refactor ===
;;(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")

;; === jsx settings ===
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))
(defvar jsx-indent-level)
(setq jsx-indent-level 2)



;;=== //TODO Load themes on demand ===
;;(defun load-theme (name)
  ;;(interactive "sTheme name:")
  ;;(add-to-load-path "user/color-theme-6.6.0")
  ;;(require 'color-theme)
  ;;(color-theme-select 'name)
;;)


;; === List all packages from elpa and melpa ===
(defun list-all-packages ()
  (interactive)

  (list-packages)
)
(global-set-key (kbd "C-c C-p") 'list-all-packages)


;; === Add new *scratch* buffers ===
;; (add-to-load-path "user/multi-scratch")
;; (require 'multi-scratch)

;; === Adding auto complete for emacs ===
(require 'auto-complete)
(require 'auto-complete-config)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(global-auto-complete-mode t)
(set-default 'ac-sources
             '(ac-source-imenu
               ac-source-dictionary
               ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-words-in-all-buffer))

;; === fiplr settings ===
;;(setq fiplr-ignored-globs '((directories (".git" ".svn" "node_modules" "dist" ".tmp"))
;;                            (files ("*.jpg" "*.png" "*.zip" "*~"))))
;;(global-set-key (kbd "C-x f") 'fiplr-find-file)


;; === js2 mode settings ===
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(defvar js2-highlight-level)
(setq js2-highlight-level 3)


;; === jshint mode with flycheck ===
(require 'flycheck)
;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'js-mode-hook
          (lambda () (flycheck-mode t)))
;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))
;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)



;; === jsxhint with flycheck ===
;; (flycheck-define-checker jsxhint-checker
;;   "A JSX syntax and style checker based on JSXHint."

;;   :command ("jsxhint" source)
;;   :error-patterns
;;   ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
;;   :modes (web-mode))
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (equal web-mode-content-type "jsx")
;;               ;; enable flycheck
;;               (flycheck-select-checker 'jsxhint-checker)
;;               (flycheck-mode))))



;; === js-beautify ===
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))


;; === tern settings ===
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

(defun delete-tern-process ()
  (interactive)
  (delete-process "Tern"))

;; --- using tern with jsx ---
(add-hook 'jsx-mode-hook (lambda () (tern-mode t)))



;; === multiple cursors ===
(require 'multiple-cursors)
;;When you have an active region that spans multiple lines, the following will add a cursor to each line:
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;;When you want to add multiple cursors not based on continuous lines, but based on keywords in the buffer, use:
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; === smart mode line ===
(setq sml/theme 'dark)
(sml/setup)

;; === fill column mode ===
(add-hook 'js-mode-hook (lambda () (fci-mode t)))
(add-hook 'js2-mode-hook (lambda () (fci-mode t)))

;; === collapse tags to one line ===
(global-set-key (kbd "M-j")
  (lambda ()
    (interactive)
    (join-line -1)))

;; === helm settings ===
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(defun pl/helm-alive-p ()
  (if (boundp 'helm-alive-p)
      (symbol-value 'helm-alive-p)))

(add-to-list 'golden-ratio-inhibit-functions 'pl/helm-alive-p)

(global-set-key (kbd "C-;") 'ac-complete-with-helm)
(define-key ac-complete-mode-map (kbd "C-;") 'ac-complete-with-helm)

(helm-mode 1)

;; === open into this default directory ===
(cd "~/Workspace/projects/pm/studiov2")

(provide 'init)
;;; init.el ends here
