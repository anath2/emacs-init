;;; Package -- summary

;;; Commentary:

;; Emacs configuration

;; Ensure the file goes into text mode unless
;; any other mode is explicitly specified

;;; Code:

;; Set command key as option on mac
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

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
