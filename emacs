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

;; M-up M-dow to move lines up and down
(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;; setup archives for packages
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

;; install all missing packages
(setq package-list
      '(s
        markdown-mode
        helm
        projectile
        helm-projectile
        scala-mode
        gradle-mode
        groovy-mode
        rust-mode
))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))




;; set up dockerfile-mode
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; set up helm config
;; guid https://github.com/emacs-helm/helm
(require 'helm-config)

(helm-mode 1)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap execute-extended-command] 'helm-M-x)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))


;; set up projectile
;; guide in https://projectile.readthedocs.io/en/latest/usage/
(projectile-global-mode 1)
;; Addede by package

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (groovy-mode gradle-mode scala-mode helm-projectile projectile helm markdown-mode+ markdown-mode haskell-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
