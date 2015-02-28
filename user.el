;;;    ~/.emacs.d/user.el
;;;    Author: Chris Dugan

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Startup Configuration    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Remove splash screen
; Start in *scratch* buffer
(setq inhibit-splash-screen t)

; Remove menubar and toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

; Set colors
(global-font-lock-mode t)

; Enable line and column numbers in the mode line
(line-number-mode 1)
(column-number-mode 1)

; Set standard indent size and tab width to 4 spaces
(setq standard-indent 4)
(setq tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(setq ruby-indent-level 4)
(setq python-indent-level 4)

; Smooth Scrolling
(setq smooth-scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

; Change yes-or-no to y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

; Turn off alarm bell
(setq ring-bell-function 'ignore)

; evil-leader setup
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode 1)

; Set <leader>key combos
(evil-leader/set-leader ";")
(evil-leader/set-key
 "e" 'ido-find-file
 "w" 'save-buffer
 "q" 'save-buffers-kill-terminal
 "b" 'ido-switch-buffer
 "k" 'ido-kill-buffer
 "u" 'new-upcase-word
 "SPC" 'evil-search-highlight-persist-remove-all)

; Paredit mode
(require 'paredit)
(paredit-mode 1)

; Wrap lines at the end of a word
(global-visual-line-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Evil Mode Config    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Start emacs in evil-mode
(evil-mode 1)

; Key chord setup
(require 'key-chord)
(key-chord-mode 1)
(setq key-chord-two-keys-delay 0.5)

; Set "jk" to jump out of insert and visual modes
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-normal-state)

; Set j and k keys to move by visual line
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

; evil-mode plugins
(require 'evil-matchit)
(require 'evil-surround)
(require 'evil-search-highlight-persist)
(require 'evil-org)
(global-evil-matchit-mode 1)
(global-evil-surround-mode 1)
(global-evil-search-highlight-persist t)

; Cursor doesn't move back a space when exiting from insert mode to normal mode
(setq evil-move-cursor-back nil)

; Change cursor color depending on mode
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("blue" box))
(setq evil-insert-state-cursor '("green" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

;;;;;;;;;;;;;;;;;;;;;;;;
;;    Key Bindings    ;;
;;;;;;;;;;;;;;;;;;;;;;;;

; Key bindings for smex
(global-set-key (kbd "M-x") 'smex)
; Rebind the "old" M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

; Bind f1 to find-file
(global-set-key (kbd "<f1>") 'find-file)
; Bind f2 to "C-x 1"
(global-set-key (kbd "<f2>") 'delete-other-windows)
; Bind f3 to "C-x 2"
(global-set-key (kbd "<f3>") 'split-window-below)
; Bind f4 to "C-x 3"
(global-set-key (kbd "<f4>") 'split-window-right)
; Bind f5 to save-buffer
(global-set-key (kbd "<f5>") 'save-buffer)
; Bind f10 to calender
(global-set-key (kbd "<f10>") 'calendar)

; Change behavior of return key
(global-set-key (kbd "RET") 'newline-and-indent)

; Join line below to currently selected line
(global-set-key (kbd "M-j")
		(lambda ()
		  (interactive)
		  (join-line -1)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;    File Handling    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

; Disable creation of backup files
(setq make-backup-files nil)

;;;;;;;;;;;;;;;;;;
;;    Themes    ;;
;;;;;;;;;;;;;;;;;;

; Set emacs theme at startup
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")

(load-theme 'cyberpunk t)

; Set the default font
(add-to-list 'default-frame-alist
	     '(font . "Anonymous Pro 13"))

;;;;;;;;;;;;;;;;;;
;;    Defuns    ;;
;;;;;;;;;;;;;;;;;;

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let((name (buffer-name))
       (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
	(error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
	(if (get-buffer new-name)
	    (error "A buffer named '%s' already exists!" new-name)
	  (rename-file filename new-name 1)
	  (rename-buffer new-name)
	  (set-visited-file-name new-name)
	  (set-buffer-modified-p nil)
	  (message "File '%s' successfully renamed to '%s'"
		   name (file-name-nondirectory new-name)))))))

; Keybinding for rename-current-buffer-file defun
(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)

;;;;;;;;;;;;;;;;;;
;;    Macros    ;;
;;;;;;;;;;;;;;;;;;

; Inserts a newline below current line.
(fset 'newline-below
   "\C-e\C-j")

; Keybinding for newline-below macro
(global-set-key (kbd "C-S-o") 'newline-below)

; Uppercases previous or current word from anywhere in word
(fset 'new-upcase-word
   "\342\365")

; Keybinding for new-upcase-word
(global-set-key (kbd "C-c u") 'new-upcase-word)
