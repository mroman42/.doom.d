;;; ~/.doom.d/+clock.el -*- lexical-binding: t; -*-

;; After using org-clock, we save buffers to ensure the tracking
;; information is saved.  If we do not do this, we could close Emacs and
;; lose clocking information.
;; http://fdavidcl.me/blog/2017/11/30/time-tracking-org/
(add-hook 'org-clock-in-hook 'save-buffer)
(add-hook 'org-clock-out-hook 'save-buffer)
(setq org-clock-mode-line-total 'current)

;; Effortlessly clock in/out of org-mode tasks, with completion and
;; persistent history
;; https://github.com/unhammer/org-mru-clock
(use-package! org-mru-clock
    :bind* (("C-c C-x i" . org-mru-clock-in)
            ("C-c C-x TAB" . org-mru-clock-in)
            ("C-c C-x C-j" . org-mru-clock-select-recent-task))
    :init
      (setq org-mru-clock-how-many 100
          org-mru-clock-completing-read #'ivy-completing-read))

;; This saves clock history, even if we restart Emacs while clocking.
(setq org-clock-persist t)
(org-clock-persistence-insinuate)
