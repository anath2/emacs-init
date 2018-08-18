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
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Setup projectile
(require 'projectile)
(add-hook 'after-init-hook 'projectile-mode)

;; Setup theme
(require 'monokai-theme)
(load-theme 'monokai t)

;; Flycheck mode
(require 'flycheck)
(add-hook 'after-init-hook 'global-flycheck-mode)

(require 'flycheck-color-mode-line)
(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

;; Setup company mode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(define-key company-mode-map (kbd "\M-/") 'company-complete)
(define-key company-active-map (kbd "\M-/") 'company-other-backend)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(setq-default company-dabbrev-other-buffers 'all
	      company-tooltip-align-annotations t)

(require 'company-quickhelp)
(add-hook 'after-init-hook 'company-quickhelp-mode)
