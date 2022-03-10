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
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ansible
     (auto-completion :variables
                      company-emoji-insert-unicode t)
     ;; better-defaults
     (c-c++ :variables
            c-c++-lsp-enable-semantic-highlight 'rainbow
            c-c++-dap-adapters '(dap-lldb)
            c-c++-enable-organize-includes-on-save t
            c-c++-enable-clang-format-on-save t
            c-c++-adopt-subprojects t
            c-c++-backend 'lsp-clangd)
     csv
     django
     (docker :variables docker-dockerfile-backend 'lsp)
     emacs-lisp
     emoji
     git
     (go :variables
         go-tab-width 4
         go-format-before-save t
         go-backend 'lsp)
     (haskell :variables
              haskell-completion-backend 'dante
              haskell-enable-hindent t)
     html
     (javascript :variables
                 javascript-backend 'lsp
                 javascript-disable-tern-port-files nil
                 javascript-fmt-on-save t
                 javascript-fmt-tool 'prettier)
     (latex :variables latex-backend 'lsp)
     (lsp :variables
          lsp-ui-sideline-show-symbol t
          lsp-navigation 'peek)
     (markdown :variables
               markdown-live-preview-engine 'vmd)
     nginx
     (nim :variables
          nim-backend 'lsp)
     (shell :variables
             shell-default-height 30
             shell-default-position 'bottom)
     php
     restclient
     (rust :variables
           lsp-rust-server 'rust-analyzer
           cargo-process-reload-on-modify t)
     (spell-checking :variables spell-checking-enable-by-default nil)
     (sql :variables
          sql-backend 'lsp
          sql-lsp-sqls-workspace-config-path 'workspace)
     syntax-checking
     systemd
     templates
     (terraform :variables terraform-auto-format-on-save t
                terraform-backend nil)
     themes-megapack
     typescript
     version-control
     (yaml :variables yaml-enable-lsp t)
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;;
   ;; To add your own package:
   ;; ('my-package :location local) - then scroll down to user-config
   dotspacemacs-additional-packages '(
                                      code-review
                                      org-journal
                                      (org-download :location (recipe
                                                               :fetcher github
                                                               :repo "abo-abo/org-download"))
                                      org-pomodoro
                                      ox-pandoc
                                      platformio-mode
                                      pdf-tools
                                      (svelte-mode :location (recipe
                                                              :fetcher github
                                                              :repo "leafOfTree/svelte-mode"
                                                              :depth 1))
   )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

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
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(farmhouse-dark
                         dracula
                         nord
                         subatomic
                         afternoon
                         sanityinc-tomorrow-eighties
                         sanityinc-tomorrow-bright
                         sanityinc-tomorrow-night
                         spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   ;; Previous font used: "IBM Plex Mono"
   dotspacemacs-default-font '("Jetbrains Mono"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state t
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
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
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
   ;; Set to nil when you want to disable showing the scrollbar while scrolling
   dotspacemacs-scroll-bar-while-scrolling nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (require 'org-protocol)

  ;; Nord theme settings
  (setq nord-region-highlight "frost")

  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; If my-package has been installed locally, then load it here like so:
  ;; (require 'my-package)

  (with-eval-after-load 'org
    ;;(require 'org-journal) ;; already loaded from private/local

    ;;; Set variables and functions
    ;;(setq org-agenda-files (directory-files-recursively "~/Workspace/_/notebooks/agenda" "\.org$"))
    (setq org-use-fast-todo-selection t)
    (setq org-treat-S-cursor-todo-selection-as-state-change nil)
    (setq-default fill-column 100)

    ;;;; Adjust display on some Emacs properties
    (add-to-list 'font-lock-extra-managed-props 'display)
    (font-lock-add-keywords 'org-mode '(("\\(\{\{\{\\)" 1 '(face nil display "❴"))))
    (font-lock-add-keywords 'org-mode '(("\\(\}\}\}\\)" 1 '(face nil display "❵"))))


    ;;; ===== hooks =====
    (add-hook 'text-mode-hook 'auto-fill-mode)
    (add-hook 'before-save-hook 'time-stamp)
    (add-hook 'doc-view-mode-hook 'auto-revert-mode)
    (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)

    ;;; ===== global key-bindings =====
    ;;; e.g (global-set-key (kbd "TAB") 'hippie-expand)
    (global-set-key (kbd "C-c c") 'org-capture)
    (global-set-key "\C-ca" 'org-agenda)
    (global-set-key (kbd "C-c w") 'hs-toggle-hiding)

    ;;; Org function to clear logbook
    (defun my-org-clear-logbook ()
      "Delete logbook drawer of subtree."
      (interactive)
      (save-excursion
        (goto-char (point))
        (when (save-excursion
                (save-match-data
                  (beginning-of-line 0)
                  (search-forward-regexp org-drawer-regexp)
                  (goto-char (match-beginning 1))
                  (looking-at "LOGBOOK")))
          (org-mark-element)
          (delete-region (region-beginning) (region-end))
          (org-remove-empty-drawer-at (point)))))

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
    ;;; org capture templates
    (setq org-capture-templates
          '(("c" "org-protocol-capture"
             entry (file "~/Workspace/_/notebooks/inbox/web-captures.org")
             "* TODO %:description, %:link :%^{tag1}:%^{tag2}:\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%i"
             :prepend t :empty-lines 1)

            ("k" "org-protocol-store-link"
             entry (file "~/Workspace/_/notebooks/agenda/bookmark-captures.org")
             "* [[%:link][%:description]] :%^{tag1}:%^{tag2}:\n"
             :prepend t :immediate-finish t :empty-lines 1)

            ))

    ;;; org refile targets
    ;; TODO: revisit later
    ;; (setq org-refile-targets '(("~/Workspace/_/notebooks/agenda/2020.org" :maxlevel . 3)
    ;;                            ("~/Workspace/_/notebooks/agenda/2020-completed.org" :maxlevel . 3)
    ;;                            ("~/Workspace/_/notebooks/agenda/work.org" :level . 1)))

    ;;; ===== Org Journal =====
    ;;; Org journal function to create date-format when creating a new journal
    (defun my-org-journal-date-format-func (time)
      "Custom function to insert journal date header,
and some custom text on a newly created journal file."
      (when (= (buffer-size) 0)
        (insert
         (pcase org-journal-file-type
           (`daily "#+TITLE: Daily Journal\n\n")
           (`weekly (concat"#+TITLE: Weekly Journal " (format-time-string "(Wk #%V)" time) "\n\n"))
           (`monthly "#+TITLE: Monthly Journal\n\n")
           (`yearly "#+TITLE: Yearly Journal\n\n"))))
      (concat org-journal-date-prefix (format-time-string "%A, %x" time)))

    ;;; ===== Org Protocol =====

    ;;; ===== org-download =====
    ;;(require 'org-download)
    ;;(add-hook 'dired-mode-hook 'org-download-enable)

    ;;; ===== org mode babel =====
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((haskell . t)
       (http . t)
       (js . t)
       (latex . t)
       (python . t)
       (restclient . t)
       (shell . t)
       (sql . t)
       ))
    )

  ;;; ======= Org LaTeX ==========
  (with-eval-after-load 'ox-latex
    (setq org-latex-listings 'minted
          org-latex-packages-alist '(("" "minted"))
          org-format-latex-options (plist-put org-format-latex-options :scale 1.2)
          org-src-fontify-natively t ;; should be already set via customize
          org-latex-pdf-process
          '("pdflatex -shell-escape -output-directory %o %f"
            "biber %b"
            "pdflatex -shell-escape -output-directory %o %f"
            "pdflatex -shell-escape -output-directory %o %f"))

    (add-to-list 'org-latex-classes
                 '("org-plain-latex"
                   "\\documentclass{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
    )
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
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
 '(compilation-message-face 'default)
 '(css-indent-offset 2)
 '(custom-safe-themes
   '("16ab866312f1bd47d1304b303145f339eac46bbc8d655c9bfa423b957aa23cc9" "0d75aa06198c4245ac2a8877bfc56503d5d8199cc85da2c65a6791b84afb9024" default))
 '(doom-ephemeral-region-highlight '\'frost)
 '(evil-want-Y-yank-to-eol nil)
 '(exwm-floating-border-color "#d3c5a0")
 '(frame-brackground-mode 'dark)
 '(global-hl-line-mode t)
 '(helm-ag-use-agignore t)
 '(helm-ag-use-grep-ignore-list t t)
 '(highlight-parentheses-background-colors '("#2492db" "#95a5a6" nil))
 '(highlight-tail-colors ((("#eee4b4" "#f3f3c1") . 0) (("#e8e5bb" "#eff3cf") . 20)))
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(jdee-db-active-breakpoint-face-colors (cons "#f0f0f0" "#a89984"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#f0f0f0" "#79740e"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#f0f0f0" "#928374"))
 '(js-chain-indent t)
 '(js-indent-level 2)
 '(json-reformat:indent-width 2)
 '(lsp-clients-python-library-directories '("/usr/" "$HOME/.pyenv/versions"))
 '(lsp-pyls-plugins-pydocstyle-enabled t)
 '(lsp-pyls-plugins-yapf-enabled t)
 '(magit-diff-use-overlays nil)
 '(markdown-fontify-code-blocks-natively t)
 '(notmuch-search-line-faces
   '(("unread" :foreground "#aeee00")
     ("flagged" :foreground "#0a9dff")
     ("deleted" :foreground "#ff2c4b" :bold t)))
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(objed-cursor-color "#9d0006")
 '(org-agenda-files
   '("~/Workspace/_/notebooks/agenda/2018.org" "~/Workspace/_/notebooks/agenda/2019.org" "~/Workspace/_/notebooks/agenda/2020.org" "~/Workspace/_/notebooks/agenda/Bookmarks.org" "~/Workspace/_/notebooks/agenda/To-Read.org" "~/Workspace/_/notebooks/agenda/common.org" "~/Workspace/_/notebooks/agenda/finances.org" "~/Workspace/_/notebooks/agenda/learning.org" "~/Workspace/_/notebooks/agenda/work.org" "/Users/parag/Dropbox/Documents/org/journal/20210111-journal.org"))
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-todo-headline nil)
 '(org-fontify-whole-heading-line t)
 '(org-journal-dir "~/Workspace/_/notebooks/agenda/journal")
 '(org-journal-enable-agenda-integration t)
 '(org-journal-file-format "%Y%m%d-journal.org")
 '(org-journal-file-header "#+roam_tags: daily todos")
 '(org-journal-file-type 'weekly)
 '(org-journal-prefix-key "C-c j")
 '(org-pomodoro-keep-killed-pomodoro-time t)
 '(org-src-fontify-natively t)
 '(org-startup-folded t)
 '(org-startup-with-inline-images t)
 '(package-selected-packages
   '(nord-theme typescript-mode import-js grizzl toml-mode ron-mode racer flycheck-rust cfrs cargo rust-mode phpunit phpcbf php-extras php-auto-yasnippets helm-gtags ggtags geben drupal-mode dap-mode posframe bui counsel-gtags company-phpactor phpactor composer php-runtime company-php ac-php-core xcscope php-mode sqlup-mode sql-indent web-mode tagedit slim-mode scss-mode sass-mode pug-mode impatient-mode helm-css-scss helm helm-core haml-mode emmet-mode counsel-css company-web web-completion-data add-node-modules-path yapfify yaml-mode xterm-color web-beautify terraform-mode hcl-mode systemd smeargle shell-pop pyvenv pytest pyenv-mode py-isort pony-mode pip-requirements orgit org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download nginx-mode multi-term mmm-mode markdown-toc markdown-mode magit-gitflow magit-popup livid-mode skewer-mode simple-httpd live-py-mode js2-refactor yasnippet multiple-cursors js2-mode js-doc jinja2-mode hy-mode dash-functional htmlize gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md flyspell-correct-ivy flyspell-correct flycheck-pos-tip pos-tip flycheck evil-magit magit git-commit with-editor eshell-z eshell-prompt-extras esh-help dockerfile-mode docker transient tablist json-mode docker-tramp json-snatcher json-reformat diff-hl cython-mode csv-mode coffee-mode auto-dictionary ansible-doc ansible anaconda-mode pythonic ws-butler winum which-key wgrep volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline smex restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint ivy-hydra indent-guide hydra lv hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-make google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu elisp-slime-nav dumb-jump popup f dash s diminish define-word counsel-projectile projectile pkg-info epl counsel swiper ivy column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed async aggressive-indent adaptive-wrap ace-window ace-link avy))
 '(pdf-view-midnight-colors (cons "#282828" "#fbf1c7"))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(pyvenv-mode t)
 '(pyvenv-virtualenvwrapper-python "~/.pyenv/shims/python")
 '(rustic-ansi-faces
   ["#fbf1c7" "#9d0006" "#79740e" "#b57614" "#076678" "#b16286" "#427b58" "#282828"])
 '(sml/active-background-color "#34495e")
 '(sml/active-foreground-color "#ecf0f1")
 '(sml/inactive-background-color "#dfe4ea")
 '(sml/inactive-foreground-color "#34495e")
 '(vc-annotate-background "#fbf1c7")
 '(vc-annotate-color-map
   (list
    (cons 20 "#79740e")
    (cons 40 "#8d7410")
    (cons 60 "#a17512")
    (cons 80 "#b57614")
    (cons 100 "#b3620e")
    (cons 120 "#b14e08")
    (cons 140 "#af3a03")
    (cons 160 "#af472e")
    (cons 180 "#b0545a")
    (cons 200 "#b16286")
    (cons 220 "#aa415b")
    (cons 240 "#a32030")
    (cons 260 "#9d0006")
    (cons 280 "#9a2021")
    (cons 300 "#97413c")
    (cons 320 "#946258")
    (cons 340 "#504945")
    (cons 360 "#504945")))
 '(vc-annotate-very-old-color nil)
 '(warning-suppress-types '((\(yasnippet\ backquote-change\))))
 '(web-mode-css-indent-offset 2)
 '(web-mode-markup-indent-offset 2)
 '(weechat-color-list
   '(unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(highlight-parentheses-highlight ((nil (:weight ultra-bold))) t)
 '(hl-line ((t (:extend t :background "SlateGray4"))))
 '(org-block ((t nil)))
 '(org-block-begin-line ((t (:foreground "gray23"))))
 '(org-block-end-line ((t (:foreground "gray23"))))
 '(org-drawer ((t (:foreground "gray23"))))
 '(org-special-keyword ((t (:foreground "systemIndigoColor")))))
)
