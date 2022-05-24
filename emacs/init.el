;;; init.el --- -*- lexical-binding: t -*-
;;; Commentary
;; My personal Emacs config
;;; Code:

(setq custom-file "~/.emacs.d/custom-file.el")

(load-file custom-file)

;; packages
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))


;; misc settings without corresponding packages
(use-package emacs
  :preface
  (defvar olexenn/indent-width 4)
  (defun olexenn/split-and-follow-horizontally ()
    "Split window bellow."
    (interactive)
    (split-window-bellow)
    (other-window 1))
  (defun olexenn/split-and-follow-vertically ()
    "Split window right."
    (interactive)
    (split-window-right)
    (other-window 1))
  :config
  (setq frame-title-format '("Yay-Evil")
        ring-bell-function 'ignore ; reduce distactions
        frame-resize-pixelwise t
        default-directory "~/")

  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (blink-cursor-mode 0)

  ;; better scrolling
  (setq scroll-margin 0
        scroll-conservatively 101
        scroll-preserve-screen-position t
        auto-window-vscroll nil)

  ;; always use spaces
  (setq-default indent-tabs-mode nil
                tab-width olexenn/indent-width)

  ;; utf-8 as default encoding
  (set-language-environment "UTF-8")
  (set-default-coding-systems 'utf-8-unix)

  ;; no startup screen
  (setq inhibit-startup-screen t)
  (global-set-key (kbd "C-x 2") #'olexenn/split-and-follow-horizontally)
  (global-set-key (kbd "C-x 3") #'olexenn/split-and-follow-vertically))


;; built-ins
;; custom-file
;;(use-package cus-edit
;;  :ensure nil
;;  :config
;;  (setq custom-file (concat user-emacs-directory "custom-file.el")))

;; replace selected region by typing text
(use-package delsel
  :ensure nil
  :config (delete-selection-mode +1))

;; no scroll-bar
(use-package scroll-bar
  :ensure nil
  :config (scroll-bar-mode -1))

;; column numbers
(use-package simple
  :ensure nil
  :config (column-number-mode +1))

(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode)
  :config
  (setq-default display-line-numbers-width 3))

;; files
(use-package files
  :ensure nil
  :config
  (setq confirm-kill-processes nil
        create-lockfiles nil
        make-backup-files nil))

;; auto-refresh buffer
(use-package autorevert
  :ensure nil
  :config
  (global-auto-revert-mode +1)
  (setq auto-revert-interval 2
        auto-revert-check-vc-info t
        global-auto-revert-non-file-buffers t
        auto-revert-verbose nil))

;; Eldoc short delay
(use-package eldoc
  :ensure nil
  :diminish eldoc-mode
  :config
  (setq eldoc-idle-delay 0.4))

;; unique file names in status bar
(use-package uniquify
         :ensure nil
         :config
         (setq-default uniquify-buffer-name-style 'forward))

;; c default indent settings not GNU
(use-package cc-vars
  :ensure nil
  :config
  (setq-default c-basic-offset olexenn/indent-width)
  (setq c-default-style '((java-mode . "java")
                          (awk-mode . "awk")
                          (other . "k&r" ))))

;; python indents
(use-package python
  :ensure nil
  :config (setq python-indent-offset olexenn/indent-width))

;; mosue wheel speed
(use-package mwheel
  :ensure nil
  :config (setq mouse-wheel-scroll-amount '(2 ((shift) . 1))
                mouse-wheel-progressive-speed nil))

;; show matching parens
(use-package paren
  :ensure nil
  :init (setq show-paren-delay 0)
  :config (show-paren-mode +1))

;; frame settings
(use-package frame
  :preface
  (defun olexenn/set-default-font ()
    (interactive)
    (when (member "FiraCode Nerd Font" (font-family-list))
      (set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 115))
    (set-face-attribute 'default nil
                        :height 120
                        :weight 'normal))
  (defun olexenn/system-is-mac ()
    (interactive)
    (string-equal system-type "darwin"))
  (defun olexenn/mac-frame ()
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . 1))
    (add-to-list 'default-frame-alist '(ns-appearance . dark))
    (setq ns-use-proxy-icon nil
          frame-title-format nil))
  :ensure nil
  :config
  (setq initial-frame-alist '((fullscreen . maximized)))
  (olexenn/set-default-font)
  (if (olexenn/system-is-mac)
      (olexenn/mac-frame)))

;; ediff for comparing
(use-package ediff
  :ensure nil
  :config
  (setq ediff-window-setup-function #'ediff-setup-windows-plain)
  (setq ediff-split-window-function #'split-window-horizontally))

;; auto-pairs
(use-package elec-pair
  :ensure nil
  :hook (prog-mode . electric-pair-mode))

;; clenup whitespaces on save
(use-package whitespace
  :ensure nil
  :hook (before-save . whitespace-cleanup))

;; theme
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold nil)
  (setq doom-gruvbox-dark-variant "hard")
  (load-theme 'doom-gruvbox t))

(use-package highlight-symbol
  :hook (prog-mode . highlight-symbol-mode)
  :config
  (setq hightlight-symbol-idle-delay 0.3))

(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))

(use-package highlight-escape-sequences
  :hook (prog-mode . hes-mode))


;; vim keybindings
(use-package undo-fu
  :config
  (setq undo-fu-ignore-keyboard-quit t))

(use-package evil-leader
  :init
  (setq evil-want-C-u-scroll t
        evil-want-keybinding nil
        evil-shift-width olexenn/indent-width
        evil-undo-system 'undo-fu)
  :config
  (global-evil-leader-mode +1)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
   "s" #'counsel-grep-or-swiper
   "w" #'save-buffer
   "f" #'counsel-projectile-find-file
   "F" #'projectile-ripgrep
   "o" #'other-window
   "<tab>" #'olexenn/lsp-execute-code-action
   "TAB" #'olexenn/lsp-execute-code-action))

(setq evil-want-keybinding nil) ;; for evil-collection
(setq evil-want-integration nil) ;; for evil-collection

(use-package evil
  :after (undo-fu evil-leader)
  :hook (after-init . evil-mode)
  :config
  (setq evil-insert-state-cursor '(bar . 1))

  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t))

(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-company-use-tng nil)
  (evil-collection-init))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode +1))


;; project managments
(use-package ivy
  :hook (after-init . ivy-mode)
  :config
  (setcdr (assoc t ivy-format-functions-alist) #'ivy-format-function-line)
  (setq ivy-height 15)
  (setq ivy-display-style nil)
  (setq ivy-re-builders-alist
        '((counsel-rg            . ivy--regex-plus)
          (counser-projectile-rg . ivy--regex-plus)
          (swiper                . ivy--regex-plus)
          (t                     . ivy--regex-fuzzy)))
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil)
  (define-key ivy-minibuffer-map (kbd "TAB") #'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "<tab>") #'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "<backtab>") #'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "<C-return>") #'ivy-immediate-done)
  (define-key ivy-minibuffer-map (kbd "C-c m") #'ivy-mark)
  (define-key ivy-minibuffer-map (kbd "C-c u") #'ivy-unmark))

(use-package counsel
  :hook (ivy-mode . counsel-mode)
  :config
  (setq counsel-rg-base-command "rg --vimgrep %s")
  (setq counsel-fzf-cmd "fd -H -c never \%s\"")
  (global-set-key (kbd "C-S-p") #'counsel-M-x))

(use-package counsel-projectile
  :config
  (counsel-projectile-mode +1))

(use-package swiper
  :after ivy
  :config
  (setq swiper-action-recenter t)
  (setq swiper-goto-start-of-match t))

(use-package projectile
  :config
  (setq projectile-sort-order 'recentf)
  (setq projectile-indexing-method 'hybrid)
  (setq projectile-completion-system 'ivy)
  (setq projectile-mode-line-prefix " ")
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") #'projectile-command-map))

(use-package wgrep
  :commands wgrep-change-to-wgrep-mode
  :config
  (setq wgrep-auto-save-buffer t))

(use-package prescient
  :config
  (setq prescient-filter-method '(literal regexp initialism fuzzy))
  (setq prescient-sort-length-enable nil)
  (prescient-persist-mode +1))

(use-package ivy-prescient
  :after (prescient ivy counsel)
  :config
  (setq ivy-prescient-sort-commands
        '(:not swiper
               counsel-grep
               counsel-rg
               counsel-projectile-rg
               ivy-switch-buffer
               counsel-switch-buffer))
  (setq ivy-prescient-retain-classic-highlighting t)
  (ivy-prescient-mode +1))

(use-package company-prescient
  :after (prescient company)
  :config
  (company-prescient-mode +1))


;; programming

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((c-mode          ; clangd
          c++-mode        ; clangd
          c-or-c++-mode   ; clangd
          js-mode         ; ts-ls
          js-jsx-mode     ; ts-ls
          typescript-mode ; ts-ls
          web-mode        ; ts-ls/html/css
          ruby-mode       ; solargraph
          ) . lsp-dererred)
  :preface
  (defun olexenn/lsp-execute-code-action ()
    "Execute code action with pulse-line animation"
    (interactive)
    (olexenn/pulse-line)
    (call-interactively 'lsp-execute-code-action))
  :custom-face
  (lsp-headerline-breadcrumb-symbols-face                ((t (:inherit variable-pitch))))
  (lsp-headerline-breadcrumb-path-face                   ((t (:inherit variable-pitch))))
  (lsp-headerline-breadcrumb-project-prefix-face         ((t (:inherit variable-pitch))))
  (lsp-headerline-breadcrumb-unknown-project-prefix-face ((t (:inherit variable-pitch))))
  :commands lsp
  :config
  (global-unset-key (kbd "<f2>"))
  (setq lsp-auto-guess-root t)
  (setq lsp-log-io nil)
  (setq lsp-restart 'auto-restart)
  (setq lsp-enable-links nil)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-lens-enable nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-signature-render-documentation nil)
  (setq lsp-eldoc-enable-hover nil)
  (setq lsp-eldoc-hook nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-headerline-breadcrumb-icons-enable nil)
  (setq lsp-semantic-tokens-enable nil)
  (setq lsp-enable-folding nil)
  (setq lsp-enable-imenu nil)
  (setq lsp-enable-snippet nil)
  (setq lsp-enable-file-watchers nil)
  (setq read-process-output-max (* 1024 1024)) ;; 1MB
  (setq lsp-idle-delay 0.25)
  (setq lsp-auto-execute-action nil)
  (add-to-list 'lsp-language-id-configuration '(js-jsx-mode . "javascriptreact")))

(use-package lsp-ui
  :commands lsp-ui-mode
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  :config
  (with-eval-after-load 'evil
    (add-hook 'buffer-list-update-hook
              #'(lambda ()
                  (when (bound-and-true-p lsp-ui-mode)
                    (define-key evil-motion-state-local-map (kbd "K")
                      #'(lambda () (interactive) (lsp-ui-doc-glance) (ian/pulse-line)))))))
  (custom-set-faces '(lsp-ui-sideline-global ((t (:italic t)))))
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-doc-use-childframe t)
  (setq lsp-ui-doc-position 'at-point)
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-border (face-foreground 'default))
  (setq lsp-ui-sideline-show-code-actions nil)
  (setq lsp-ui-peek-always-show t)
  (setq lsp-ui-sideline-delay 0.05))

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.2)
  (setq company-tooltip-minimum-width 60)
  (setq company-tooltip-maximum-width 60)
  (setq company-tooltip-limit 12)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t)
  (setq company-frontends '(company-pseudo-tooltip-frontend ; show tooltip even for single candidate
                            company-echo-metadata-frontend))
  (define-key company-active-map (kbd "C-j") nil) ; avoid conflict with emmet-mode
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "TAB") 'company-select-next)
  (define-key company-active-map (kbd "<tab>") 'company-select-next)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous))

(use-package flycheck
  :hook ((prog-mode . flycheck-mode)
         (markdown-mode . flycheck-mode)
         (org-mode . flycheck-mode))
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled newline))
  (setq flycheck-display-errors-delay 0.1)
  (setq-default flycheck-disabled-checkers '(python-pylint))
  (setq flycheck-flake8rc "~/.config/flake8")
  (setq flycheck-checker-error-threshold 1000)
  (setq flycheck-indication-mode nil)
  (define-key flycheck-mode-map (kbd "<f8>") #'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "S-<f8>") #'flycheck-previous-error)
  (flycheck-define-checker proselint
    "A linter for prose. Install the executable with `pip3 install proselint'."
    :command ("proselint" source-inplace)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": "
              (id (one-or-more (not (any " "))))
              (message) line-end))
    :modes (markdown-mode org-mode))
  (add-to-list 'flycheck-checkers 'proselint))

(use-package typescript-mode
  :mode ("\\.tsx?\\'" . typescript-mode)
  :config
  (setq typescript-indent-level olexenn/indent-width))

(use-package json-mode)

(use-package cmake-font-lock)

(use-package rjsx-mode
  :mode ("\\.jsx?\\'" . rjsx-mode)
  :custom-face
  (js2-error   ((t (:inherit default :underscore nil))))
  (js2-warning ((t (:inherit default :underscore nil))))
  :config
  (define-key rjsx-mode-map "<" nil)
  (define-key rjsx-mode-map (kbd "C-d") nil)
  (define-key rjsx-mode-map ">" nil))

(use-package format-all
  :preface
  (defun olexenn/format-code ()
    "Auto-format whole buffer."
    (interactive)
    (let ((windowstart (window-start)))
      (if (derived-mode-p 'prolog-mode)
          (prolog-indent-buffer)
        (format-all-buffer))
      (set-window-start (selected-window) windowstart)))
  (defalias 'format-document #'olexenn/format-code)
  :config
  (global-set-key (kbd "<f6>") #'olexenn/format-code)
  (add-hook 'prog-mode-hook #'format-all-ensure-formatter)
  (add-hook 'python-mode-hook #'(lambda ()
                                  (setq-local format-all-formatters '(("Python" yapf)))))
  (add-hook 'sql-mode-hook #'(lambda ()
                               (setq-local format-all-formatters '(("SQL" pgformatter))))))

(use-package rainbow-mode
  :config
  (bind-key* (kbd "C-c r") #'rainbow-mode))


(use-package hl-todo
  :custom-face
  (hl-todo                        ((t (:inverse-video nil :italic t :bold nil))))
  :config
  (add-to-list 'hl-todo-keyword-faces '("DOING" . "#94bff3"))
  (add-to-list 'hl-todo-keyword-faces '("WHY" . "#7cb8bb"))
  (global-hl-todo-mode +1))


;; dired
(use-package dired
  :ensure nil
  :hook ((dired-mode . dired-hide-details-mode)
         (dired-mode . hl-line-mode))
  :config
  (setq dired-listing-switches "-lat")
  (setq dired-kill-when-opening-new-dired-buffer t)
  (put 'dired-find-alternate-file 'disabled nil))


;; misc
(use-package company-box
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-scrollbar nil)
  (setq company-box-frame-behavior 'default))

(use-package all-the-icons
  :if (display-graphic-p)
  :config
  (setq all-the-icons-scale-factor 0.8))

(use-package all-the-icons-ivy-rich
  :after counsel-projectile
  :init (all-the-icons-ivy-rich-mode +1)
  :config
  (setq all-the-icons-ivy-rich-icon-size 0.8))

(use-package ivy-rich
  :after all-the-icons-ivy-rich
  :init (ivy-rich-mode +1))

(use-package all-the-icons-dired
  :if (display-graphic-p)
  :config
  (add-hook 'dired-mode-hook #'all-the-icons-dired-mode)
  (setq all-the-icons-dired-monochrome nil))

(use-package which-key
  :config
  (setq which-key-idle-delay 0.4)
  (which-key-mode +1))
