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
    yaml-mode
    haskell-mode
    dockerfile-mode
    material-theme))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(setq x-select-enable-clipboard t) ;; Enable use of external clipboard
(setq indent-tabs-mode nil) ;; disable tab indenting
(setq visible-bell 1)
(setq electric-pair-mode 1) ;; Turn on electric pair mode, for autopairing parens etc
(setq create-lockfile nil) ;; Prevent emacs creating lockfiles
(setq tab-width 4) ;; Set tab width to four cols
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(elpy-enable)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dockerfile-mode elpygen elpy material-theme better-defaults))))
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

;; Hooks
;; Save file hooks
;; Delete trailing whitespaces before saving file
(add-hook 'before-save-hook 'delete-trailing-whitespace)
