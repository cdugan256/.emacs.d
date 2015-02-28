;;;    init.el
;;;    Author: Chris Dugan

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    PACKAGE MANAGEMENT    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Require package.el and add marmalade, elpa, and melpa to package archives.
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
	     '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

; Add ~/.emacs.d/elpa/ to load-path so that installed packages are initialized.
(add-to-list 'load-path "~/.emacs.d/elpa")

(ido-mode t)
(autopair-global-mode 1)
(setq autopair-autowrap t)
(global-auto-complete-mode t)

(load "~/.emacs.d/user.el")
