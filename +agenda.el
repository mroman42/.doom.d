;;; ~/.doom.d/+agenda.el -*- lexical-binding: t; -*-


;; Agenda commands.  Builds the personal agenda.
(setq org-agenda-custom-commands
  '(("c" "Complete agenda dashboard"
     ;; Today
    ((agenda ""
             ((org-agenda-span 'day)
              (org-agenda-start-day "0d")
              (org-deadline-warning-days 365)
              (org-agenda-skip-function '(org-agenda-skip-entry-if 'regexp ":habit:"))))
     ;; To Refile
     (todo ""
           ((org-agenda-overriding-header "To Refile")
            (org-agenda-files '("~/org/agenda/inbox.org"))))
     ;; High priority tasks
     (tags-todo "-habit-notask+TODO=\"TODO\"-WAITUNTIL>\"<today>\"+PRIORITY=\"A\""
                ((org-agenda-overriding-header "Priority")))
     ;; TODO To Refile
     ;; General to-do's
     (tags-todo "-habit-notask+TODO=\"TODO\"-SCHEDULED>\"<today>\"-WAITUNTIL>\"<today>\"-PRIORITY=\"A\"-PRIORITY=\"C\"" (
                (org-agenda-overriding-header "Tasks")))
     ;; Non-priority tasks
     (tags-todo "-habit-notask+TODO=\"TODO\"-SCHEDULED>\"<today>\"-WAITUNTIL>\"<today>\"+PRIORITY=\"C\"" (
               (org-agenda-overriding-header "Non-priority")))
     ))))

(map! :map org-agenda-mode-map
      "i" #'org-agenda-clock-in
      "r" #'org-agenda-refile
      "R" #'org-agenda-refile
      "c" #'org-capture)

;; Agenda filters.
(setq org-agenda-tag-filter-preset '("-notask"))
(setq org-agenda-files '("~/org/GCalendar.org" "~/org/agenda" "~/org/math/notes"))
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-todo-ignore-scheduled 'past)
(setq org-agenda-show-future-repeats nil)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-start-on-weekday nil)

;; Blocked tasks become invisible.
;; https://orgmode.org/manual/TODO-dependencies.html#TODO-dependencies
(setq org-agenda-dim-blocked-tasks 'invisible)

;; Extensible dependencies for the org-mode agenda.
(use-package! org-edna :config (org-edna-load))

;; Show only today's habits.
(setq org-habit-show-habits-only-for-today t)

;; Prefix format for the Emacs agenda.
(setq org-agenda-prefix-format
    '((agenda . " %i %-12:c%?-12t% s")
     (todo . " %i %-12:c")
     (tags . " %i %-12:c")
     (search . " %i %-12:c")))

;; This makes the q command bury the agenda buffer when you've finished
;; with it, rather than close it. The result of this is that the agenda
;; will reappear immediately when you next ask for it, but it won't have
;; been updated since you last saw it. If you want it updated you can
;; always press g in the agenda to rebuild it properly.
;; https://emacs.stackexchange.com/a/861/12208
(setq org-agenda-sticky t)

;; The block separator in the agenda. It has to be declared as a number.
;; For instance, 32 is the whitespace.
(setq org-agenda-block-separator 32)

;; I prefer the mini-calendar prompt to start on Monday.
;; https://emacs.stackexchange.com/questions/42571/org-agenda-date-prompt-mini-calendar-start-week-on-monday
; (setq calendar-week-start-day 1)

;; Pregenerates an agenda buffer whenever Emacs is idle for more than 5
;; seconds. The next time the agenda command is run, generation takes
;; less than a second, since the org buffers have already been loaded.
;; https://emacs.stackexchange.com/a/820/12208
;; Currently disabled because it blocks Emacs too often.
; (run-with-idle-timer 5 nil (lambda () (org-agenda-list) (delete-window)))
