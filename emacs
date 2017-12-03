(setq c-offsets-alist
      '((substatement-open . 0)))
(setq mac-option-key-is-meta t)
(setq mac-option-modifier 'meta)
(setq mac-command-key-is-meta nil)
(setq mac-command-modifier nil)
(setq default-frame-alist
      (append default-frame-alist
              '((foreground-color . "white")
                (background-color . "black")
                (cursor-color . "blue")
                )
              )
      )

(setq x-select-enable-clipboard t)
(setq default-buffer-file-coding-system 'utf-8-unix)
(global-linum-mode t)

(setq-default indent-tabs-mode nil) ; always replace tabs with spaces
(setq-default tab-width 2) ; set tab width to 4 for all buffers

(global-auto-revert-mode t)

(setq ring-bell-function 'ignore) ; Disable bell on esc
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; set default font
(set-frame-font "Source Code Pro for Powerline 14" nil t)


;; set up ido mode
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; setup archives for packages
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)

;; install all missing packages
(setq package-list
      '(s markdown-mode))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))




;; set up dockerfile-mode
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; Added by package

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (markdown-mode+ markdown-mode haskell-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
