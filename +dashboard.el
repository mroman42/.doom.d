;;; ~/.doom.d/+dashboard.el -*- lexical-binding: t; -*-

;; Dashboard.
(use-package! dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                          (agenda . 5)
                          (bookmarks . 5)
                          (projects . 5)
                          (registers . 5)))
  (setq dashboard-set-footer nil))
