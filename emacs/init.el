;; -*- coding: utf-8; lexical-binding: t; -*-
;; No startup screnn
(setq inhibit-startup-message t)

;; Disable useless things
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;;(global-hl-line-mode t)

;; utf-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 120)
(setq-default tab-width 4
	      indent-tabs-mode nil)

;; files and backups
(setq make-backup-files nil)
(setq backup-by-coping t)
(setq create-lockfiles nil)
(setq auto-save-default nil)

;; basic UI
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(blink-cursor-mode 0)
(setq use-dialog-box nil)

;; for macOS
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)

(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

;; Custom code in separate file
(setq custom-file "~/.emacs.d/custom-file.el")

;; Custom file code must be executed before the code
(load-file custom-file)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(use-package doom-themes
	     :ensure t
	     :preface (defvar region-fg nil)
	     :init (load-theme 'doom-one t))

(use-package all-the-icons
  :ensure t
  :commands (all-the-icons-octicon all-the-icons-faicon all-the-icons-fileicon
				   all-the-icons-wicon all-the-icons-material all-the-icons-alltheicon
				   all-the-icons-install-fonts)
  :config
  (setq all-the-icons-scale-factor 1.0))

(use-package all-the-icons-dired
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))
  ;; (set-face-attribute 'all-the-icons-dired-dir-face all-the-icons-octicon "directory"))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package evil
  :ensure t
  :defer .1 ;; don't block emacs on start, load immediately
  :init
  (setq evil-want-integration nil) ;; for evil-collection
  (setq evil-want-keybinding nil) ;; for evil-collection
  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode)

  ;; vim-like keybindings everywhere in emacs
  (use-package evil-collection
    :after evil
    :ensure t
    :config
    (evil-collection-init))

  ;; gl and gL operators, like vim-lion
  (use-package evil-lion
    :ensure t
    :bind (:map evil-normal-state-map
                ("g l " . evil-lion-left)
                ("g L " . evil-lion-right)
                :map evil-visual-state-map
                ("g l " . evil-lion-left)
                ("g L " . evil-lion-right)))

  ;; gc operator, like vim-commentary
  (use-package evil-commentary
    :ensure t
    :bind (:map evil-normal-state-map
                ("gc" . evil-commentary)))

  ;; gx operator, like vim-exchange
  ;; NOTE using cx like vim-exchange is possible but not as straightforward
  (use-package evil-exchange
    :ensure t
    :bind (:map evil-normal-state-map
                ("gx" . evil-exchange)
                ("gX" . evil-exchange-cancel)))

  ;; gr operator, like vim's ReplaceWithRegister
  (use-package evil-replace-with-register
    :ensure t
    :bind (:map evil-normal-state-map
                ("gr" . evil-replace-with-register)
                :map evil-visual-state-map
                ("gr" . evil-replace-with-register)))

  ;; * operator in vusual mode
  (use-package evil-visualstar
    :ensure t
    :bind (:map evil-visual-state-map
                ("*" . evil-visualstar/begin-search-forward)
                ("#" . evil-visualstar/begin-search-backward)))

  ;; ex commands, which a vim user is likely to be familiar with
  (use-package evil-expat
    :ensure t
    :defer t)

  ;; visual hints while editing
  (use-package evil-goggles
    :ensure t
    :config
    (evil-goggles-use-diff-faces)
    (evil-goggles-mode))

  ;; like vim-surround
  (use-package evil-surround
    :ensure t
    :commands
    (evil-surround-edit
     evil-Surround-edit
     evil-surround-region
     evil-Surround-region)
    :init
    (evil-define-key 'operator global-map "s" 'evil-surround-edit)
    (evil-define-key 'operator global-map "S" 'evil-Surround-edit)
    (evil-define-key 'visual global-map "S" 'evil-surround-region)
    (evil-define-key 'visual global-map "gS" 'evil-Surround-region))

  (message "Loading evil-mode...done"))

(use-package dired
  :after evil
  :ensure nil
  :commands (dired dired-jump)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))

(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands
  (lsp-ui-mode))
