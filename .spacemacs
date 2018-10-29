;; FROM: git@github.com:designgeef/dotfiles.git
;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   ;; A layer is a unit of configuration that you can turn on or off
   dotspacemacs-configuration-layers '(
     ansible
     (auto-completion :variables
                      auto-completion-enable-sort-by-usage t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-complete-with-key-sequence `"jk"
                      auto-completion-complete-with-key-sequence-delay 0.1
                      :disabled-for erc)
     (syntax-checking :variables syntax-checking-enable-by-default nil)
     ;; better-defaults
     (c-c++ :variables c-c++-enable-clang-support t)
     (clojure :variables clojure-enable-fancify-symbols t)
     colors
     cscope
     csv
     django
     docker
     git
     gnus
     (go :variables go-use-gometalinter t)
     html
     (javascript :variables javascript-disable-tern-port-files nil)
     latex
     (markdown :variables markdown-command "pandoc")
     ocaml
     (org :variables
          org-enable-github-support t
          org-enable-reveal-js-support t)
     nginx
     parinfer
     plantuml
     python
     react
     reason
     (rust :variables
           rust-format-on-save t)
     selectric
     shell-scripts
     (shell :variables
             shell-default-shell 'eshell
             shell-default-height 30
             shell-default-position 'bottom
             shell-enable-smart-eshell t)
     ;; spell-checking
     sql
     terraform
     version-control
     xkcd
     yaml
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(vue-mode
                                      cheat-sh
                                      yasnippet-snippets
                                      editorconfig
                                      platformio-mode
                                      irony
                                      irony-eldoc
                                      flycheck-irony
                                      arduino-mode)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

;; Configurations that are common to make
(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner nil
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         zenburn
                         solarized-dark
                         material
                         sanityinc-solarized-dark
                         misterioso
                         spacemacs-light
                         solarized-light
                         monokai)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 11
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing
   ))

;; Runs at the same time as dotspacemacs/init but it has my config variables
(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
)

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  (add-hook 'text-mode-hook 'auto-fill-mode)

  (add-hook 'term-mode-hook 'toggle-truncate-lines)

  ;;--------- Helm (workaround) settings ----------
  (with-eval-after-load 'helm
    (defun helm-persistent-action-display-window (&optional split-onewindow)
      "Return the window that will be used for persistent action.
If SPLIT-ONEWINDOW is non-`nil' window is split in persistent action."
      (with-helm-window
        (setq helm-persistent-action-display-window
              (cond ((and (window-live-p helm-persistent-action-display-window)
                          (not (member helm-persistent-action-display-window
                                       (get-buffer-window-list helm-buffer))))
                     helm-persistent-action-display-window)
                    ((and helm--buffer-in-new-frame-p helm-initial-frame)
                     (with-selected-frame helm-initial-frame (selected-window)))
                    (split-onewindow (split-window))
                    ((get-mru-window))
                    (t split-window (get-mru-window nil t)))))))

  ;;---------- Arduino settings -------------
  (require 'platformio-mode)
  (add-to-list 'auto-mode-alist '("\\.ino$" . arduino-mode))

  ;; Enable irony for all c++ files, and platformio-mode only
  ;; when needed (platformio.ini present in project root).
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'c++-mode-hook (lambda ()
                             (irony-mode)
                             (irony-eldoc)
                             (platformio-conditionally-enable)))
  ;; Use irony's completion functions.
  (add-hook 'irony-mode-hook
            (lambda ()
              (define-key irony-mode-map
                [remap completion-at-point] 'irony-completion-at-point-async)
              (define-key irony-mode-map
                [remap complete-symbol] 'irony-completion-at-point-async)
              (irony-cdb-autosetup-compile-options)))
  ;; Setup irony for flycheck
  (add-hook 'flycheck-mode-hook 'flycheck-irony-setup)

  ;;--------- Utils -------------
  ;; function to add date format
  (defvar current-date-format "%Y-%m-%d %a"
    "See help of `format-time-string' for possible replacements")

  ;; ag search settings. Ignoring some folders
  (setq helm-ag-base-command
    "ag --nocolor --nogroup --ignore=node_modules/* --ignore=*.pyc --ignore=*.lock --ignore=*.tmp")
  '(helm-ag-show-status-function (quote spaceline--helm-ag-update) t)
  '(helm-ag-use-grep-ignore-list t)

  ;; web-mode, css, js indenting rules
  (setq web-mode-block-padding 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-block-face t)
  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-markup-indent-offset 2)
  (setq css-indent-offset 2)
  (setq js-indent-level 2)
  (setq json-reformat:indent-width 2)
  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))

  ;; User config for long lines
  (setq-default
   whitespace-line-column 100
   whitespace-style '(face lines-tail))
  (add-hook 'prog-mode-hook #'whitespace-mode)

  ;; live reload of pdf previews
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)

  ;; add autolist to org mode
  ;;(add-hook 'org-mode-hook (lambda ()(org-autolist-mode) )
  ;;          )

  ;; Highlighting
  (add-hook 'after-init-hook #'toggle-crosshairs-when-idle 1)
  (add-hook 'after-init-hook #'crosshairs-mode)
  (setq col-highlight-vline-face-flag t
        col-highlight-face hl-line-face)

  ;; ------------------ Artist Mode -----------------------------
  ;; artist mode hooks
  (add-hook 'artist-mode-hook
            (lambda ()
              (local-set-key (kbd "<f2>") 'artist-select-op-pen-line) ; f2 = pen mode
              (local-set-key (kbd "<f3>") 'artist-select-op-line)     ; f3 = line
              (local-set-key (kbd "<f4>") 'artist-select-op-square)   ; f4 = rectangle
              (local-set-key (kbd "<f5>") 'artist-select-op-ellipse)  ; f5 = ellipse
              (local-set-key (kbd "C-z") 'undo)
              ))

  ;; artist mode in org-mode
  (global-set-key (kbd "C-}") (lambda()
                                   (interactive)
                                   (show-all)
                                   (artist-mode)))

  ;; ----------------------- Gmail -----------------------------------
  ;; TODO


  ;; ------------------------ ORG Mode ------------------------------
  ;;         Following are settings for ORG mode
  ;;-----------------------------------------------------------------

  (with-eval-after-load 'org
    ;;; set org agenda files
    (setq org-agenda-files (quote ("~/Workspace/_/notebooks/agenda")))
    (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))

    ;;; org use python3 for python mode
    '(org-babel-python-mode (quote python3))

    ;;; Standard key bindings
    (global-set-key "\C-cl" 'org-store-link)
    (global-set-key "\C-ca" 'org-agenda)
    (global-set-key "\C-cb" 'org-iswitchb)
    (define-key evil-insert-state-map (kbd "M-RET") 'org-meta-return)
    (define-key evil-insert-state-map (kbd "<return>") 'org-return)

    ;;; org remove bindings to auto-create agenda files as it mangles
    ;;; my preferred directory structure
    '(define-key org-agenda-files (kbd "C-[") nil)
    '(define-key org-agenda-files (kbd "C-]") nil)

    ;;; org mode fast todo selection settings
    (setq org-use-fast-todo-selection t)
    (setq org-treat-S-cursor-todo-selection-as-state-change nil)

    ;;; Org task state management
    (setq org-todo-keywords
          (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                  (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))
    (setq org-todo-keyword-faces
          (quote (("TODO" :foreground "red" :weight bold)
                  ("NEXT" :foreground "blue" :weight bold)
                  ("DONE" :foreground "forest green" :weight bold)
                  ("WAITING" :foreground "orange" :weight bold)
                  ("HOLD" :foreground "magenta" :weight bold)
                  ("CANCELLED" :foreground "forest green" :weight bold)
                  ("MEETING" :foreground "forest green" :weight bold)
                  ("PHONE" :foreground "forest green" :weight bold))))
    (setq org-todo-state-tags-triggers
          (quote (("CANCELLED" ("CANCELLED" . t))
                  ("WAITING" ("WAITING" . t))
                  ("HOLD" ("WAITING") ("HOLD" . t))
                  (done ("WAITING") ("HOLD"))
                  ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                  ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                  ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

    ;;; some capture mode templates
    ;; <See here for ref: http://doc.norang.ca/org-mode.html#CaptureTemplates>

    ;;; Set latex process
    (setq org-latex-pdf-process
          '("xelatex -interaction nonstopmode %f"
            "xelatex -interaction nonstopmode %f"))

    ;;; org highlighting
    ;; (setq org-latex-listings 'minted
    ;;       org-latex-packages-alist '(("" "minted"))
    ;;       org-latex-pdf-process
    ;;       '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    ;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

    (org-babel-do-load-languages
     'org-babel-load-languages
     '((python . t)
       (emacs-lisp . t)
       (shell . t)
       (js . t)
       (sql . t)
       (org . t)
       (dot . t)
       (awk . t)
       ))
    )
)


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck-irony yapfify yaml-mode xterm-color xkcd ws-butler winum which-key web-mode web-beautify vue-mode edit-indirect ssass-mode vue-html-mode volatile-highlights vi-tilde-fringe uuidgen use-package toml-mode toc-org terraform-mode hcl-mode tagedit sql-indent spaceline powerline smeargle slim-mode shell-pop selectric-mode scss-mode sass-mode restart-emacs rainbow-mode rainbow-identifiers rainbow-delimiters racer pyvenv pytest pyenv-mode py-isort pug-mode psci purescript-mode psc-ide popwin pony-mode plantuml-mode pip-requirements persp-mode pcre2el paradox ox-reveal ox-gfm orgit org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download org-bullets open-junk-file ob-elixir org-plus-contrib nginx-mode neotree multi-term move-text mmm-mode markdown-toc markdown-mode magit-gitflow lorem-ipsum livid-mode skewer-mode simple-httpd live-py-mode linum-relative link-hint less-css-mode js2-refactor js2-mode js-doc insert-shebang indent-guide hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make projectile helm-gitignore request helm-flx helm-descbinds helm-dash helm-css-scss helm-cscope xcscope helm-company helm-c-yasnippet helm-ag haml-mode google-translate golden-ratio go-guru go-eldoc gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md fuzzy flycheck-rust flycheck-pos-tip pos-tip flycheck-mix flycheck-gometalinter flycheck-elm flycheck-credo flycheck flx-ido flx fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit magit git-commit ghub let-alist with-editor evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eshell-z eshell-prompt-extras esh-help emmet-mode elm-mode dumb-jump dockerfile-mode docker json-mode tablist magit-popup docker-tramp json-snatcher json-reformat disaster diminish diff-hl define-word dash-at-point cython-mode csv-mode company-web web-completion-data company-tern dash-functional tern company-statistics company-shell company-go go-mode company-c-headers company-auctex company-anaconda column-enforce-mode color-identifiers-mode coffee-mode cmake-mode clojure-snippets clj-refactor hydra inflections edn multiple-cursors paredit peg clean-aindent-mode clang-format cider-eval-sexp-fu eval-sexp-fu highlight cider seq spinner queue clojure-mode cargo rust-mode bind-map bind-key auto-yasnippet yasnippet auto-highlight-symbol auctex-latexmk auctex anaconda-mode pythonic f alchemist s company dash elixir-mode pkg-info epl aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core async ac-ispell auto-complete popup zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
