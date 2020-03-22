;;; ~/.doom.d/+latex.el -*- lexical-binding: t; -*-

;; Keybinding for previewing formulas in latex.
(global-set-key (kbd "C-ñ") 'org-toggle-latex-fragment)

;; Zooming.
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.2))

;; Abbreviations on 'latex-math-mode'. They require Latex to use
;; =latex-math-mode=. It is activated by default.
(customize-set-variable 'LaTeX-math-abbrev-prefix "ç")

(setq LaTeX-math-list
    (quote
      ((";" "mathbb{" "" nil)
       ("=" "cong" "" nil)
       ("<right>" "longrightarrow" "" nil)
       ("<left>" "longleftarrow" "" nil)
       ("C-<right>" "Longrightarrow" "" nil)
       ("C-<left>" "Longleftarrow" "" nil)
       ("^" "widehat" "" nil)
       ("~" "widetilde" "" nil)
       ("'" "\partial" "" nil)
       ("0" "varnothing" "" nil)
       ("C-(" "left(" "" nil)
       ("C-)" "right)" "" nil)
       )))

;; Auctex configuration
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'org-mode-hook 'LaTeX-math-mode)
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; Some packages must be added at the latex preview alist.  In
;; particular, this adds preview of commutative diagrams with the
;; 'tikz-cd' package.
(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))

;; Sets the backend for latex. Imagemagick works best with tikzcd.
(setq org-preview-latex-default-process 'imagemagick)

;; No default packages should be loaded.
(setq org-latex-default-packages-alist '())
