;;; ~/.doom.d/+latex.el -*- lexical-binding: t; -*-

;; Keybinding for previewing formulas in latex.
(global-set-key (kbd "C-ñ") 'org-latex-preview)

;; Zooming.
(setq! org-format-latex-options (plist-put org-format-latex-options :scale 1.2))

;; Abbreviations on 'latex-math-mode'. They require Latex to use
;; =latex-math-mode=. It is activated by default.
(setq! LaTeX-math-abbrev-prefix "ç")
(setq! LaTeX-math-list
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

;; PDF generation process.
;; This is the script Emacs will run when generating a PDF file from
;; an org mode file.
(setq! org-latex-pdf-process
  '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    "bibtex %b"
    "makeindex %b"
    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; Auctex configuration
;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;(add-hook 'org-mode-hook 'LaTeX-math-mode)
(add-hook! 'org-mode-hook #'turn-on-org-cdlatex)

;; cdlatex helps writing faster
(define-key key-translation-map (kbd "ç") (kbd "`"))
(setq! cdlatex-math-symbol-prefix "ç")
(setq! cdlatex-math-symbol-alist '((setq! cdlatex-math-symbol-prefix ?ç)
        (?% ("\\widehat{?}" "\\hat{?}"))
        (?' ("^{\\prime}" "\\prime"))
        (?* ("\\times" "\\otimes" "\\star"))
        (?+ ("+" "\\oplus"))
        (?- ("\\vdash" "\\setminus" "\\triangle"))
        (?. ("\\sq" "\\circ" "\\cdot"))
        (?0 ("\\emptyset" "\\circ"))
        (?\; ("\\col"))
        (?\: ("\\colon"))
        (?< ("\\leftarrow" "\\leftharpoonup" "\\xleftarrow"))
        (?> ("\\rightarrow" "\\rightharpoonup" "\\xrightarrow"))
        (?B ("\\bullet"))
        (?C ("\\widecheck{?}" "\\check{?}"))
        (?F ("\\Phi" "\\Varphi"))
        (?M ("\\begin{bsmallmatrix}?\\end{bsmallmatrix}"))
        (?P ("\\Prod{?}" "\\Pi" "\\partial"))
        (?S ("\\Sum{?}" "\\Sigma" "\\arcsin"))
        (?\"("^{\\prime\\prime}" "\\prime\\prime"))
        (?a ("\\alpha" "\\cap" "\\sqcap"))
        (?c ("\\cat{?}" "\\catn{?}"))
        (?e ("\\varepsilon" "\\epsilon" "\\exp{?}"))
        (?i ("\\iota" "\\in"))
        (?j ("\\theta"))
        (?J ("\\Theta"))
        (?r ("\\rho" "\\varrho" "\\restrict{?}"))
        (?u ("\\upsilon" "\\cup" "\\sqcup"))
        (?{ ("\\subseteq" "\\subsetneq"))
        (?} ("\\supseteq" "\\supsetneq"))
        ))

;; Some packages must be added at the latex preview alist.  In
;; particular, this adds preview of commutative diagrams with the
;; 'tikz-cd' package.
(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))

;; Sets the backend for latex. Imagemagick works best with tikzcd.
(setq! org-preview-latex-default-process 'imagemagick)

;; No default packages should be loaded.
(setq! org-latex-default-packages-alist '())


;; Exporting to latex.
;; Presentations
;; Exporting ignores headlines.
(use-package! ox-latex)
(use-package! ox-beamer)
(use-package! ox-extra)
(ox-extras-activate '(ignore-headlines))


;; Classes for latex exporting
;; Exports to beamer. It needs to first define the beamer class.
(add-to-list 'org-latex-classes
      '("beamer"
	"\\documentclass\[presentation\]\{beamer\}"
	("\\section\{%s\}" . "\\section*\{%s\}")
	("\\subsection\{%s\}" . "\\subsection*\{%s\}")
	("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))

(with-eval-after-load "ox-latex"
    (add-to-list 'org-latex-classes
      '("scrbook" "\\documentclass{scrbook}"
       ("\\part{%s}" . "\\part*{%s}")
       ("\\chapter{%s}" . "\\chapter*{%s}")
       ("\\section{%s}" . "\\section*{%s}")
       ("\\subsection{%s}" . "\\subsection*{%s}")
       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
       ("\\paragraph{%s}" . "\\paragraph*{%s}"))))

(with-eval-after-load "ox-latex"
    (add-to-list 'org-latex-classes
      '("jfp" "\\documentclass{jfp}"
       ("\\section{%s}" . "\\section*{%s}")
       ("\\subsection{%s}" . "\\subsection*{%s}")
       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
       ("\\paragraph{%s}" . "\\paragraph*{%s}")
       ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(with-eval-after-load "ox-latex"
    (add-to-list 'org-latex-classes
      '("tac" "\\documentclass{tac}"
       ("\\section{%s}" . "\\section*{%s}")
       ("\\subsection{%s}" . "\\subsection*{%s}")
       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
       ("\\paragraph{%s}" . "\\paragraph*{%s}")
       ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(with-eval-after-load "ox-latex"
    (add-to-list 'org-latex-classes
      '("amsart" "\\documentclass{amsart}"
       ("\\section{%s}" . "\\section*{%s}")
       ("\\subsection{%s}" . "\\subsection*{%s}")
       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
       ("\\paragraph{%s}" . "\\paragraph*{%s}")
       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
       )))

  (with-eval-after-load "ox-latex"
    (add-to-list 'org-latex-classes
      '("ociamthesis" "\\documentclass{ociamthesis}"
       ("\\chapter{%s}" . "\\chapter*{%s}")
       ("\\section{%s}" . "\\section*{%s}")
       ("\\subsection{%s}" . "\\subsection*{%s}")
       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
       ("\\paragraph{%s}" . "\\paragraph*{%s}")
       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
       )))

  (with-eval-after-load "ox-latex"
    (add-to-list 'org-latex-classes
	       '("scrreprt" "\\documentclass{scrreprt}"
		 ("\\part{%s}" . "\\part*{%s}")
		 ("\\chapter{%s}" . "\\chapter*{%s}")
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		 ("\\paragraph{%s}" . "\\paragraph*{%s}"))))

  (with-eval-after-load "ox-latex"
    (add-to-list 'org-latex-classes
	       '("myifcolog" "\\documentclass{myifcolog}"
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		 ("\\subsubsubsection{%s}" . "\\subsubsubsection*{%s}")
		 ("\\paragraph{%s}" . "\\paragraph*{%s}")
		 ("\\paragraph{%s}" . "\\paragraph*{%s}"))))

;; Exports minted code in latex.
(setq! org-latex-listings 'minted)
