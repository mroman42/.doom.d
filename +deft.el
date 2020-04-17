;;; ~/.doom.d/+deft.el -*- lexical-binding: t; -*-

;; Deft.
;; The first element of ~deft-extensions~ is the default extension for new files.
(use-package! deft
  :bind ("C-c C-d" . deft)
  :commands (deft)
  :config
    (setq deft-directory "~/deft")
    (setq deft-extensions '("org" "md" "txt"))
    (setq deft-recursive t)
    (setq deft-current-sort-method 'title)
    ; Decouples the display from the actual filename.
    (setq deft-use-filter-string-for-filename t)
    ; Deft will replace all slashes and spaces with hyphens and will convert the
    ; file name to lowercase.
    (setq deft-file-naming-rules
      '((noslash . "-")
        (nospace . "-")
        (case-fn . downcase))))
