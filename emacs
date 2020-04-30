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

;; scroll one line at a time (less "jumpy" than defaults)    
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; clipboard 
(setq x-select-enable-clipboard t)
(setq default-buffer-file-coding-system 'utf-8-unix)
(global-linum-mode t)
(add-hook 'term-mode-hook 'my-inhibit-global-linum-mode)
(defun my-inhibit-global-linum-mode ()
  "Counter-act `global-linum-mode`."
  (add-hook 'after-change-major-mode-hook
            (lambda () (linum-mode 0))
            :append :local
   )
)

(setq-default indent-tabs-mode nil) ; always replace tabs with spaces
(setq-default tab-width 2) ; set tab width to 4 for all buffers

(global-auto-revert-mode t)

;; verify if configDirectory is defined
;; if not set it to cwd

(if (boundp 'configDirectory)
    t (setq configDirectory "~")
    )

(setq ring-bell-function 'ignore) ; Disable bell on esc
(add-to-list 'load-path (concat configDirectory "/lisp/"))

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
(defvar melpaUrl (concat (if (string-equal system-type "windows-nt") "http" "https") "://stable.melpa.org/packages/"))

(add-to-list 'package-archives
               (cons "melpa-stable" melpaUrl) t)

(package-initialize)

;; install all missing packages
(setq package-list
      '(s
        markdown-mode
        helm
        projectile
        helm-projectile
        gradle-mode
        groovy-mode
        rust-mode
        yaml-mode
        neotree
        scala-mode
        ensime
        sbt-mode
        web-mode
        cmake-mode
        terraform-mode
        json-mode
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


;; set up neotree
(setq neo-autorefresh nil)
(setq projectile-switch-project-action 'neotree-projectile-action)

;; remove error message on tramp ssh session on ls dired
(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))
