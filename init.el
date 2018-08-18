;;; Package -- summary

;;; Commentary:

;; Emacs configuration

;; Ensure the file goes into text mode unless
;; any other mode is explicitly specified

;;; Code:

(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'text-mode-hook-identify)
(add-hook 'text-mode-hook 'turn-on-auto-fill)


;; Comparing windows, compares the text in two
;; windows side by side
(global-set-key "\C-cw" 'compare-windows)

;; Find occurrences of a regex pattern within text
(global-set-key "\C-co" 'occur)

;; Unset binding for fill mode, in order to avoid accidental
;; trigger using find file command
(global-unset-key "\C-xf")

;; Rebind list-buffers to buffers-menu
(global-set-key "\C-x\C-b" 'buffer-menu)

;; Init packages and add melpa to the list
;; of available package repositories
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/")t)

;; Start package.el
(setq package-enable-at-startup nil)
(package-initialize)

;; Exec from shell
(add-to-list 'load-path (expand-file-name "~/.emacs.d/exec-path-from-shell"))
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;Basic Convenience settings
(electric-pair-mode 1) ;; Autocomplete parens, braces
(global-linum-mode t) ;; enable line numbers globally
(global-auto-revert-mode t) ;; Update buffers everytime the file changes

(setq inhibit-startup-message t) ;; Disable startup message
(setq visible-bell t) ;; Disable bell
(setq select-enable-clipboard t) ;; Enable system clipboard
(setq create-lockfiles nil) ;; Desable creating lockfiles
(setq make-backup-files nil) ;; Do not make backup files
(setq auto-save-default nil) ;; Do create autosave files
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Setup projectile
(require 'projectile)
(setq projectile-enable-caching t) ;; Cache open files in projectile
(setq projectile-indexing-method 'alien) ;; Set projectile indexing method
(setq projectile-keymap-prefix "\C-c\C-p") ;; Setup projectile keymap
(add-hook 'after-init-hook 'projectile-mode)

;; Eshell
(global-set-key "\C-c~" 'eshell)

;; Magit setup
(require 'magit)
(global-set-key "\C-xg" 'magit-status)
(global-set-key "\C-x\M-g" 'magit-dispatch-popup)

;; Setup theme and global fonts
(require 'monokai-theme)
(load-theme 'monokai t)
(set-frame-font "Hack 11" nil t)

;; Flycheck mode
(require 'flycheck)
(add-hook 'after-init-hook 'global-flycheck-mode)

(require 'flycheck-color-mode-line)
(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

;; Setup company mode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(define-key company-mode-map "\M-/" 'company-complete)
(define-key company-active-map "\M-/" 'company-other-backend)
(define-key company-active-map "\C-p" 'company-select-previous)
(define-key company-active-map "\C-n" 'company-select-next)
(setq-default company-dabbrev-other-buffers 'all
	      company-tooltip-align-annotations t)

(require 'company-quickhelp)
(add-hook 'after-init-hook 'company-quickhelp-mode)

;; Setup python
(require 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

(require 'company-anaconda)
(add-hook 'python-mode-hook 'company-anaconda)


;;Setup pyvevn
(add-to-list 'load-path (expand-file-name "~/.emacs.d/pyvenv"))
(require 'pyvenv)
(setq eshell-modify-global-env t)

;; Getting eshell to play well with pyvenv
(defun smf/post-venv-hook ()
  "Append exec path to eshell path environment."
  (setq eshell-path-env (mapconcat 'identity exec-path ":")))

(add-hook 'pyvevn-post-activate-hooks 'smf/post-venv-hook)
(add-hook 'pyvevn-post-deactivate-hooks 'smf/post-venv-hook)


;; INSTALL PACKAGES
;; --------------------------------------



;; (add-to-list 'package-archives
;;        '("melpa" . "http://melpa.org/packages/")t)

;; (package-initialize)
;; (when (not package-archive-contents)
;;   (package-refresh-contents))

;; (defvar myPackages
;;   '(better-defaults
;;     elpy
;;     pipenv
;;     projectile
;;     flycheck
;;     magit
;;     web-mode
;;     js2-mode
;;     company
;;     yaml-mode
;;     haskell-mode
;;     dockerfile-mode
;;     monokai-theme
;;     neotree
;;     exec-path-from-shell
;;    )
;; )

;; (mapc #'(lambda (package)
;;     (unless (package-installed-p package)
;;       (package-install package)))
;;       myPackages)

;; ;; BASIC CUSTOMIZATION
;; ;; --------------------------------------
;; (electric-pair-mode 1) ;; Pair braces and parens
;; (set-frame-font "Hack 11" nil t) ;; Set 'Hack' as the default font
;; (setq inhibit-startup-message t) ;; hide the startup message
;; (setq select-enable-clipboard t) ;; Enable use of external clipboard
;; (setq visible-bell 1) ;; Disable bell
;; (setq create-lockfiles nil) ;; Prevent emacs creating lockfiles
;; (setq global-auto-revert-mode t) ;; Refresh buffers automatically when files are changed on the buffer
;; (setq tab-width 4) ;; Set tab width to four cols
;; (load-theme 'monokai t) ;; load cyber punk theme
;; (global-linum-mode t) ;; enable line numbers globally
;; (setq make-backup-files nil) ;; Do not make backup files
;; (setq auto-save-default nil)
;; (setq insert-directory-program "/usr/local/bin/gls") ;; Remove ls error in dired


;; (elpy-enable)
;; (global-flycheck-mode)


;; ;; Projectile and helm settings
;; (projectile-mode)
;; (setq projectile-enable-caching t)
;; (setq projectile-indexing-method 'alien)


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(package-selected-packages
;;    (quote
;;     (helm exec-path-from-shell neotree monokai-theme dockerfile-mode haskell-mode yaml-mode js2-mode web-mode flycheck projectile elpy better-defaults))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )


;; ;; Modes by file extension
;; ;; Enable yaml mode for file ending in .yml
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; ;; Enable web mode for selected file extensions
;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; ;; Enable javascript mode for selected files
;; (require 'js2-mode)
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-mode))


;; ;; Hooks
;; ;; Save file hooks

;; ;; Delete trailing whitespaces before saving file
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (global-set-key [f8] 'neotree-toggle)
;; (delete-region (point) (line-end-position))
;; (global-set-key (kbd "C-S-w") 'delete-region)
;; (global-set-key (kbd "C-x g") 'magit-status)
;; (global-set-key (kbd "C-`") 'eshell)


;; ;; Activate virtualenv if `venv` folder present in the
;; ;; project directory

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(package-selected-packages
;;    (quote
;;     (company-anaconda anaconda-mode yaml-mode web-mode pipenv neotree monokai-theme magit js2-mode helm-pydoc helm-projectile haskell-mode flycheck-color-mode-line elpy dockerfile-mode company-quickhelp better-defaults))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
