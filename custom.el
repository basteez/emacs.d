;; --- Directories principali ---
(setq org-directory "~/Documents/org-roam")
(setq org-roam-directory "~/Documents/org-roam")
(setq org-default-notes-file (concat org-directory "/inbox.org"))

;; Crea cartelle se non esistono (solo la prima volta)
(dolist (dir '("daily" "projects" "people" "zettels" "templates"))
  (let ((full-path (expand-file-name dir org-roam-directory)))
    (unless (file-exists-p full-path)
      (make-directory full-path t))))

;; --- Org-roam ---
(use-package org-roam
  :ensure t
  :custom
  (org-roam-database-connector 'sqlite)
  (org-roam-completion-everywhere t)
  (org-roam-dailies-directory "daily/")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-setup))

;; Open daily journal on startup
;(add-hook 'emacs-startup-hook
;          (lambda ()
;(org-roam-dailies-capture-today)))

;; --- Org-roam dailies ---
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?\nEntered on %U\n"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n#+filetags: :journal:\n\n"))))

;; --- Org-capture templates ---
(setq org-capture-templates
      `(("t" "Task" entry
         (file+headline ,(expand-file-name "inbox.org" org-directory) "Tasks")
         "* TODO %?\n  %U\n  %a\n  %i"
         :prepend t)

        ("i" "Idea" entry
         (file+headline ,(expand-file-name "inbox.org" org-directory) "Ideas")
         "* %?\n  %U\n  %a\n  %i"
         :prepend t)

        ("m" "Meeting" entry
         (file+datetree ,(expand-file-name "meetings.org" org-directory))
         "* MEETING %?\n  %U\n  %a\n"
         :tree-type week)

        ("r" "Reading Note" entry
         (file ,(expand-file-name "reading.org" org-directory))
         "* %^{Titolo} :reading:\n  %U\n  %^{Fonte} \n\n%?"
         :empty-lines 1)))

;; --- UI moderna per Org-mode ---
(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode))

;; --- Consult-org-roam per ricerche veloci ---
(use-package consult-org-roam
  :ensure t
  :after org-roam
  :init
  (require 'consult-org-roam)
  :custom
  (consult-org-roam-grep-func #'consult-ripgrep)
  (consult-org-roam-buffer-narrow-key ?r)
  (consult-org-roam-buffer-after-buffers t)
  :config
  (consult-org-roam-mode))

;; --- Grafo visivo (browser) ---
(use-package org-roam-ui
  :ensure t
  :after org-roam
  :hook (after-init . org-roam-ui-mode)
  :custom
  (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  (org-roam-ui-open-on-start nil))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit consult-org-roam org-roam-ui org-modern)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
