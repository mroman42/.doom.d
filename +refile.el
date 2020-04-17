;;; ~/.doom.d/+refile.el -*- lexical-binding: t; -*-

;; https://www.reddit.com/r/emacs/comments/4366f9/how_do_orgrefiletargets_work/czg008y/

(setq org-deft-files (directory-files "~/deft" 'full "org"))

(setq org-refile-targets '(
   (nil :maxlevel . 2)
   (org-agenda-files :maxlevel . 2)
   (org-deft-files :maxlevel . 1)
   ("~/org/Someday.org" :maxlevel . 2)
   ("~/org/agenda/Tasks.org" :maxlevel . 2)
   ("~/org/Reference.org" :maxlevel . 2)
   ("~/org/Notes.org" :maxlevel . 2)
   ("~/org/agenda/inbox.org" :maxlevel . 1)
   ("~/org/agenda/archive.org" :maxlevel . 1)
   ("~/org/math" :maxlevel . 1)))

(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling
(setq org-refile-allow-creating-parent-nodes 'confirm)

;; From this post, how to refile to the top level.
;; https://blog.aaronbieber.com/2017/03/19/organizing-notes-with-refile.html
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)

;; Save all buffers after refiling or archiving.
(advice-add 'org-refile :after (lambda (&rest _) (org-save-all-org-buffers)))
(advice-add 'org-archive-subtree :after (lambda (&rest _) (org-save-all-org-buffers)))

;; Stores org files in ~/org. Defines location of index, agenda and todo files.
(setq org-directory "~/org")
(setq org-archive-location (concat "~/org/Archive" "::* From %s"))
