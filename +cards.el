;;; ~/.doom.d/+cards.el -*- lexical-binding: t; -*-

(use-package! hydra)
(use-package! org-fc
  :custom (org-fc-directories '("~/fc-test/"))
  :config (require 'org-fc-hydra))
