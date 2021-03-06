;;; ~/.doom.d/+capture.el -*- lexical-binding: t; -*-

;; Org protocol intercepts calls from emacsclient. This allows us to trigger
;; actions, such as org-capture.
(use-package! org-protocol)

;; Agenda directory
(setq! mroman/org-agenda-directory "~/org/agenda/")

;; Capture templates.
(setq! org-capture-templates
      `(("i" "inbox" entry (file ,(concat mroman/org-agenda-directory "inbox.org"))
         "* TODO %?")
        ("e" "email" entry (file ,(concat mroman/org-agenda-directory "inbox.org"))
         "* TODO Email: %a" :immediate-finish t)
        ("l" "Link" entry (file ,(concat mroman/org-agenda-directory "inbox.org"))
          "* TODO Link: %a \n %?\n %i" :immediate-finish t)
        ;("l" "link" entry (file ,(concat mroman/org-agenda-directory "inbox.org"))
        ; "* TODO %(org-cliplink-capture)" :immediate-finish t)
        ("c" "org-protocol-capture" entry (file ,(concat mroman/org-agenda-directory "inbox.org"))
         "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)))

