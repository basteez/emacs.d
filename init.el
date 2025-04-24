(use-package package
  :config
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/"))
  (package-initialize))

(use-package use-package
  :custom
  (use-package-always-ensure t)
  (package-native-compile t)
  (warning-minimum-level :error))

;;; Personal configuration -*- lexical-binding: t -*-

;; Save the contents of this file under ~/.emacs.d/init.el
;; Do not forget to use Emacs' built-in help system:
;; Use C-h C-h to get an overview of all help commands.  All you
;; need to know about Emacs (what commands exist, what functions do,
;; what variables specify), the help system can provide.

;; Load a custom theme
(load-theme 'misterioso t)

;; Use whatever the default monospace font is
(setq font-use-system-font t)

;; Disable the menu bar
(menu-bar-mode -1)

;; Disable the tool bar
(tool-bar-mode -1)

;; Disable the scroll bars
(scroll-bar-mode -1)

;; Disable splash screen
(setq inhibit-startup-screen t)

;; Enable line numbering by default
(global-display-line-numbers-mode t)

;; Automatically pair parentheses
(electric-pair-mode t)

;; Miscellaneous options
(setq-default major-mode
              (lambda () ; guess major mode from file name
                (unless buffer-file-name
                  (let ((buffer-file-name (buffer-name)))
                    (set-auto-mode)))))

;;(setq confirm-kill-emacs #'yes-or-no-p)
(setq window-resize-pixelwise t)
(setq frame-resize-pixelwise t)
(defalias 'yes-or-no #'y-or-n-p)

;; remember and restore the last cursor location of opened files
(save-place-mode t)

;; remember commands history
(setq history-length 25)
(savehist-mode t)

;; remember recent edited files
(recentf-mode t)

;; Don't pop up UI dialogs when prompting
(setq use-dialog-box nil)

;; Autorefresh buffers when related file is changed
(global-auto-revert-mode 1)

;; Autorefresh Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; Store automatic customisation options elsewhere
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
