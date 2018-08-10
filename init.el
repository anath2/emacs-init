;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/")t)


(setq package-enable-at-startup nil) ; To avoid initializing twice
(package-initialize)


(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    projectile
    helm
    flycheck
    web-mode
    js2-mode
    anaconda-mode
    company
    company-anaconda
    yaml-mode
    haskell-mode
    dockerfile-mode
    cyberpunk-theme
    zenburn-theme
    monokai-theme
    neotree
   )
)

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(eval-after-load "company"
 '(add-to-list 'company-backends 'company-anaconda))


;; Setting up helm with the required keybindings

(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(electric-pair-mode 1) ;; Pair braces and parens
(set-frame-font "Hack 12" nil t) ;; Set 'Hack' as the default font
(setq inhibit-startup-message t) ;; hide the startup message
(setq select-enable-clipboard t) ;; Enable use of external clipboard
(setq visible-bell 1) ;; Disable bell
(setq create-lockfiles nil) ;; Prevent emacs creating lockfiles
(setq global-auto-revert-mode t) ;; Refresh buffers automatically when files are changed on the buffer
(setq tab-width 4) ;; Set tab width to four cols

(load-theme 'monokai t) ;; load monokai punk theme
(global-linum-mode t) ;; enable line numbers globally
(setq make-backup-files nil) ;; Do not make backup files
(setq auto-save-default nil) ;; Do not autosave

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
(global-set-key [f8] 'neotree-toggle)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'projectile-global-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
(add-hook 'python-mode-hook 'anaconda-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm monokai-theme web-mode dockerfile-mode elpygen material-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
