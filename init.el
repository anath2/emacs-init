;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/")t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    projectile
    flycheck
    web-mode
    js2-mode
    company
    yaml-mode
    haskell-mode
    dockerfile-mode
    cyberpunk-theme
    neotree
    real-auto-save
   )
)

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(electric-pair-mode 1) ;; Pair braces and parens
(set-frame-font "Hack 12" nil t) ;; Set 'Hack' as the default font
(setq-default line-spacing 9)
(setq inhibit-startup-message t) ;; hide the startup message
(setq select-enable-clipeboard t) ;; Enable use of external clipboard
(setq visible-bell 1) ;; Disable bell
(setq real-auto-save-interval 5) ;; Save all files after 5 seconds
(setq create-lockfiles nil) ;; Prevent emacs creating lockfiles
(setq global-auto-revert-mode t) ;; Refresh buffers automatically when files are changed on the buffer
(setq tab-width 4) ;; Set tab width to four cols
(load-theme 'cyberpunk t) ;; load cyber punk theme
(global-linum-mode t) ;; enable line numbers globally
(setq make-backup-files nil) ;; Do not make backup files
(setq auto-save-default nil)

(elpy-enable)

(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"
   python-shell-interpreter-args "--simple-prompt -i")) ;; Use ipython when available

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (web-mode dockerfile-mode elpygen elpy material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Modes by file extension
;; Enable yaml mode for file ending in .yml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Enable web mode for selected file extensions
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; Enable javascript mode for selected files
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-mode))


;; Hooks
;; Save file hooks

;; Delete trailing whitespaces before saving file
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'prog-mode-hook 'real-auto-save-mode)
(global-set-key [f8] 'neotree-toggle)
