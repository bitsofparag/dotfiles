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
     (auto-completion :variables
                      auto-completion-enable-sort-by-usage t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-complete-with-key-sequence `"jk"
                      auto-completion-complete-with-key-sequence-delay 0.1
                      :disabled-for erc)
     ;; better-defaults
     (c-c++ :variables c-c++-enable-clang-support t)
     colors
     cscope
     csv
     dash
     django
     docker
     git
     gnus
     html
     (javascript :variables javascript-disable-tern-port-files nil)
     markdown
     major-modes
     nginx
     org
     php
     plantuml
     python
     ranger
     react
     rust
     selectric
     shell-scripts
     (shell :variables
             shell-default-shell 'eshell
             shell-default-height 30
             shell-default-position 'bottom)
     ;; spell-checking
     spacemacs-prettier
     sql
     (syntax-checking :variables syntax-checking-enable-by-default nil)
     terraform
     version-control
     xkcd
     yaml
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(org-autolist
                                      ox-gfm
                                      )
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
   dotspacemacs-themes '(solarized-dark
                         niflheim
                         material
                         sanityinc-solarized-dark
                         misterioso
                         spacemacs-dark
                         spacemacs-light
                         solarized-light
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
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
  ;; timestamping
  (add-hook 'before-save-hook 'time-stamp)

  ;; Show 80-column marker
  (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
  (setq-default fci-rule-column 120)
  (global-fci-mode 1)

  (add-hook 'text-mode-hook 'auto-fill-mode)

  ;; add autolist to org mode
  (add-hook 'org-mode-hook (lambda ()(org-autolist-mode) )
            )

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

  ;; ------------------------ ORG Mode ------------------------------
  ;;         Following are settings for ORG mode
  ;;-----------------------------------------------------------------

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

  ;;; org capture mode settings
  (global-set-key (kbd "C-c c") 'org-capture)

  ;;; org mode fast todo selection settings
  (setq org-use-fast-todo-selection t)
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)

  ;;; some capture mode templates
  (setq org-capture-templates
      (quote (("t" "todo" entry (file "~/Workspace/_/notebooks/personal/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/Workspace/_/notebooks/personal/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/Workspace/_/notebooks/personal/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/Workspace/_/notebooks/personal/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/Workspace/_/notebooks/personal/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/Workspace/_/notebooks/personal/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/Workspace/_/notebooks/personal/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/Workspace/_/notebooks/personal/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

  ;;; org highlighting
  (setq org-latex-listings 'minted
        org-latex-packages-alist '(("" "minted"))
        org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  ;;; org remove bindings to auto-create agenda files as it mangles
  ;;; my preferred directory structure
  '(define-key org-agenda-files (kbd "C-[") nil)
  '(define-key org-agenda-files (kbd "C-]") nil)

  ;;; org mode publishing files
  (setq org-publish-project-alist
        '(("mgatebackend_markdown"
           :base-directory "~/Workspace/_/notebooks/nbt/metr/mgate_backend/"
           :base-extension "org"
           :publishing-directory "~/Workspace/work/mgate_backend/docs/"
           :publishing-function org-md-publish-to-md)

          ("mgatebackend_images"
           :base-directory "~/Workspace/_/notebooks/nbt/metr/mgate_backend/"
           :base-extension "jpg\\|gif\\|png"
           :publishing-directory  "~/Workspace/work/mgate_backend/docs/"
           :publishing-function org-publish-attachment)

          ("mgate_md"
           :base-directory "~/Workspace/_/notebooks/nbt/metr/mgate/"
           :base-extension "org"
           :publishing-directory "~/Workspace/work/mgate/docs/"
           :publishing-function org-md-publish-to-md)

          ("mgatebackend_docs" :components("mgatebackend_markdown" "mgatebackend_images"))
          ) ;; end of alist
        )

  ;;; org eval of code blocks
  (with-eval-after-load 'org
    '(require 'ox-gfm nil t)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((python . t)
       (emacs-lisp . nil)
       (shell . t)
       (js . t)
       (sql . t)
       (org . t)
       (dot . t)
       (awk . t)
       (haskell . t)
       ))
    )
)


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Info-fontify-angle-bracketed-flag nil)
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(company-clang-prefix-guesser (quote company-mode/more-than-prefix-guesser) t)
 '(compilation-message-face (quote default))
 '(css-indent-offset 2)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(eshell-highlight-prompt nil t)
 '(eshell-hist-ignoredups t t)
 '(eshell-history-size 350 t)
 '(eshell-plain-echo-behavior t t)
 '(eshell-prompt-function (quote epe-theme-lambda) t)
 '(evil-want-Y-yank-to-eol t)
 '(exec-path-from-shell-check-startup-files nil)
 '(exec-path-from-shell-variables (quote ("PATH")))
 '(explicit-shell-file-name "/bin/zsh")
 '(fci-rule-color "#eee8d5")
 '(flycheck-clang-include-path (quote ("~/.virtualenvs/mgate/include/python3.6m")))
 '(flycheck-eslintrc "~/.eslintrc")
 '(global-flycheck-mode t)
 '(global-whitespace-mode nil)
 '(global-whitespace-newline-mode nil)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(hl-sexp-background-color "#1c1f26")
 '(indent-guide-delay 0.3)
 '(indent-guide-global-mode t)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
 '(js2-indent-level 2)
 '(magit-diff-use-overlays nil)
 '(magit-repository-directories (quote (("~/Workspace/" . 2))))
 '(magit-revision-show-gravatars (quote ("^Author:     " . "^Commit:     ")))
 '(neo-auto-indent-point t t)
 '(neo-autorefresh t)
 '(neo-banner-message "Press ? for neotree help" t)
 '(neo-create-file-auto-open t t)
 '(neo-show-hidden-files t t)
 '(neo-show-updir-line nil t)
 '(neo-smart-open t t)
 '(neo-window-width 32 t)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-agenda-files
   (quote
    ("~/Workspace/_/notebooks/personal/" "~/Workspace/_/notebooks/nbt/")))
 '(org-babel-load-languages
   (quote
    ((python . t)
     (emacs-lisp)
     (shell . t)
     (js . t)
     (sql . t)
     (org . t)
     (dot . t)
     (awk . t)
     (haskell . t)
     (plantuml . t))))
 '(org-default-notes-file "~/Workspace/_/notebooks/personal/refile.org")
 '(org-directory "~/Workspace/_/notebooks")
 '(org-export-backends
   (quote
    (ascii beamer html icalendar latex md odt confluence)))
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(org-highlight-latex-and-related (quote (latex script entities)))
 '(org-imenu-depth 8)
 '(org-latex-minted-langs
   (quote
    ((emacs-lisp "common-lisp")
     (cc "c++")
     (cperl "perl")
     (shell-script "bash")
     (caml "ocaml")
     (shell "bash")
     (ipython "python"))))
 '(org-link-translation-function (quote toc-org-unhrefify))
 '(org-plantuml-jar-path "/usr/local/opt/plantuml/libexec/plantuml.jar")
 '(org-src-block-faces (quote (("python" nil))))
 '(org-src-preserve-indentation t)
 '(org-src-tab-acts-natively t)
 '(org-startup-truncated t)
 '(org-startup-with-inline-images t)
 '(org-support-shift-select t)
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
     (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))
 '(package-selected-packages
   (quote
    (org-category-capture alert log4e gntp ox-gfm plantuml-mode helm-cscope xcscope disaster company-c-headers cmake-mode clang-format yapfify xkcd selectric-mode pyvenv pytest pyenv-mode py-isort pony-mode pip-requirements org-autolist live-py-mode hy-mode helm-pydoc cython-mode company-anaconda anaconda-mode pythonic zenburn-theme yaml-mode xterm-color ws-butler wolfram-mode window-numbering which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toml-mode toc-org thrift terraform-mode tagedit stan-mode sql-indent spacemacs-theme spaceline solarized-theme smeargle slim-mode shell-pop scss-mode scad-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe restart-emacs rbenv ranger rainbow-mode rainbow-identifiers rainbow-delimiters racer quelpa qml-mode pug-mode projectile-rails popwin phpunit phpcbf php-extras php-auto-yasnippets persp-mode paradox orgit org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree multi-term move-text monokai-theme mmm-mode minitest matlab-mode markdown-toc magit-gitflow macrostep lorem-ipsum livid-mode linum-relative link-hint less-css-mode julia-mode js2-refactor js-doc intero insert-shebang info+ indent-guide ido-vertical-mode hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-dash helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md flycheck-rust flycheck-pos-tip flycheck-haskell flx-ido fish-mode fill-column-indicator feature-mode fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help enh-ruby-mode emmet-mode elisp-slime-nav dumb-jump drupal-mode dockerfile-mode docker diff-hl define-word dash-at-point csv-mode company-web company-tern company-statistics company-shell company-ghci company-ghc company-cabal column-enforce-mode color-identifiers-mode coffee-mode cmm-mode clean-aindent-mode chruby cargo bundler auto-yasnippet auto-highlight-symbol auto-compile arduino-mode aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(plantuml-jar-path (quote /usr/local/opt/plantuml/libexec/plantuml\.jar))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(prettier-mode t t)
 '(prettier-show-errors (quote echo))
 '(python-check-command "flake8")
 '(shell-file-name "/bin/zsh")
 '(show-trailing-whitespace nil)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(toc-org-max-depth 10)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(vc-follow-symlinks t)
 '(web-mode-auto-quote-style 2)
 '(web-mode-code-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-markup-indent-offset 2)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(whitespace-action (quote (auto-cleanup)))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 4096)) (:foreground "#c6c6c6" :background "#303030")) (((class color) (min-colors 256)) (:foreground "#c6c6c6" :background "#303030")) (((class color) (min-colors 89)) (:foreground "#c6c6c6" :background "#303030"))))
 '(org-block ((t (:background "gray6" :foreground "gray79")))))
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
 '(Info-fontify-angle-bracketed-flag nil)
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(company-clang-prefix-guesser (quote company-mode/more-than-prefix-guesser) t)
 '(compilation-message-face (quote default))
 '(css-indent-offset 2)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(eshell-highlight-prompt nil t)
 '(eshell-hist-ignoredups t t)
 '(eshell-history-size 350 t)
 '(eshell-plain-echo-behavior t t)
 '(eshell-prompt-function (quote epe-theme-lambda) t)
 '(evil-want-Y-yank-to-eol t)
 '(exec-path-from-shell-check-startup-files nil)
 '(exec-path-from-shell-variables (quote ("PATH")))
 '(explicit-shell-file-name "/bin/zsh")
 '(fci-rule-color "#eee8d5")
 '(flycheck-clang-include-path (quote ("~/.virtualenvs/mgate/include/python3.6m")))
 '(flycheck-eslintrc "~/.eslintrc")
 '(global-flycheck-mode t)
 '(global-whitespace-mode nil)
 '(global-whitespace-newline-mode nil)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(hl-sexp-background-color "#1c1f26")
 '(indent-guide-delay 0.3)
 '(indent-guide-global-mode t)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
 '(js2-indent-level 2)
 '(magit-diff-use-overlays nil)
 '(magit-repository-directories (quote (("~/Workspace/" . 2))))
 '(magit-revision-show-gravatars (quote ("^Author:     " . "^Commit:     ")) t)
 '(neo-auto-indent-point t)
 '(neo-autorefresh nil)
 '(neo-banner-message "Press ? for neotree help")
 '(neo-create-file-auto-open t)
 '(neo-cwd-line-style (quote button))
 '(neo-show-hidden-files t)
 '(neo-show-updir-line nil)
 '(neo-smart-open t)
 '(neo-window-width 32)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-agenda-files
   (quote
    ("~/Workspace/_/notebooks/personal/" "~/Workspace/_/notebooks/nbt/")))
 '(org-babel-load-languages
   (quote
    ((python . t)
     (emacs-lisp)
     (shell . t)
     (js . t)
     (sql . t)
     (org . t)
     (dot . t)
     (awk . t)
     (haskell . t)
     (plantuml . t))))
 '(org-default-notes-file "~/Workspace/_/notebooks/personal/refile.org")
 '(org-directory "~/Workspace/_/notebooks")
 '(org-export-backends
   (quote
    (ascii beamer html icalendar latex md odt confluence)))
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(org-highlight-latex-and-related (quote (latex script entities)))
 '(org-imenu-depth 8 t)
 '(org-latex-minted-langs
   (quote
    ((emacs-lisp "common-lisp")
     (cc "c++")
     (cperl "perl")
     (shell-script "bash")
     (caml "ocaml")
     (shell "bash")
     (ipython "python"))))
 '(org-link-translation-function (quote toc-org-unhrefify))
 '(org-plantuml-jar-path "/usr/local/opt/plantuml/libexec/plantuml.jar")
 '(org-src-block-faces (quote (("python" nil))))
 '(org-src-preserve-indentation t)
 '(org-src-tab-acts-natively t)
 '(org-startup-truncated t)
 '(org-startup-with-inline-images t t)
 '(org-support-shift-select t)
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
     (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))) t)
 '(package-selected-packages
   (quote
    (nginx-mode org-category-capture alert log4e gntp ox-gfm plantuml-mode helm-cscope xcscope disaster company-c-headers cmake-mode clang-format yapfify xkcd selectric-mode pyvenv pytest pyenv-mode py-isort pony-mode pip-requirements org-autolist live-py-mode hy-mode helm-pydoc cython-mode company-anaconda anaconda-mode pythonic zenburn-theme yaml-mode xterm-color ws-butler wolfram-mode window-numbering which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package toml-mode toc-org thrift terraform-mode tagedit stan-mode sql-indent spacemacs-theme spaceline solarized-theme smeargle slim-mode shell-pop scss-mode scad-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe restart-emacs rbenv ranger rainbow-mode rainbow-identifiers rainbow-delimiters racer quelpa qml-mode pug-mode projectile-rails popwin phpunit phpcbf php-extras php-auto-yasnippets persp-mode paradox orgit org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree multi-term move-text monokai-theme mmm-mode minitest matlab-mode markdown-toc magit-gitflow macrostep lorem-ipsum livid-mode linum-relative link-hint less-css-mode julia-mode js2-refactor js-doc intero insert-shebang info+ indent-guide ido-vertical-mode hungry-delete htmlize hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-dash helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md flycheck-rust flycheck-pos-tip flycheck-haskell flx-ido fish-mode fill-column-indicator feature-mode fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help enh-ruby-mode emmet-mode elisp-slime-nav dumb-jump drupal-mode dockerfile-mode docker diff-hl define-word dash-at-point csv-mode company-web company-tern company-statistics company-shell company-ghci company-ghc company-cabal column-enforce-mode color-identifiers-mode coffee-mode cmm-mode clean-aindent-mode chruby cargo bundler auto-yasnippet auto-highlight-symbol auto-compile arduino-mode aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(plantuml-jar-path (quote /usr/local/opt/plantuml/libexec/plantuml\.jar))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(prettier-mode t t)
 '(prettier-show-errors (quote echo))
 '(python-check-command "flake8")
 '(shell-file-name "/bin/zsh")
 '(show-trailing-whitespace nil)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(toc-org-max-depth 10 t)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(vc-follow-symlinks t)
 '(web-mode-auto-quote-style 2)
 '(web-mode-code-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-markup-indent-offset 2)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(whitespace-action (quote (auto-cleanup)))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 4096)) (:foreground "#c6c6c6" :background "#303030")) (((class color) (min-colors 256)) (:foreground "#c6c6c6" :background "#303030")) (((class color) (min-colors 89)) (:foreground "#c6c6c6" :background "#303030"))))
 '(org-block ((t (:background "gray6" :foreground "gray79")))))
)
