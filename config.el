;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Mario Román"
      user-mail-address "mromang08@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Iosevka42" :size 27)
      doom-variable-pitch-font (font-spec :family "Iosevka42" :size 27))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


;; Org mode packages.
(use-package! org
  :mode ("\\.org\\'" . org-mode)
  :init
  (map! :leader
        :prefix "n"
        "c" #'org-capture)
  (map! :map org-mode-map
        "M-n" #'outline-next-visible-heading
        "M-p" #'outline-previous-visible-heading)
  (setq org-src-window-setup 'current-window
        org-return-follows-link t
        org-babel-load-languages '((emacs-lisp . t)
                                   (python . t)
                                   (dot . t)
                                   (R . t))
        org-confirm-babel-evaluate nil
        org-use-speed-commands t
        org-catch-invisible-edits 'show
        org-preview-latex-image-directory "/tmp/ltximg/"
        org-structure-template-alist '(("a" . "export ascii")
                                       ("c" . "center")
                                       ("C" . "comment")
                                       ("e" . "example")
                                       ("E" . "export")
                                       ("h" . "export html")
                                       ("l" . "export latex")
                                       ("q" . "quote")
                                       ("s" . "src")
                                       ("v" . "verse")
                                       ("el" . "src emacs-lisp")
                                       ("d" . "definition")
                                       ("t" . "theorem"))))

;; Org-ref manages bibliography.
(use-package! org-ref
  :config
    (setq org-ref-notes-directory "~/org/"
          org-ref-bibliography-notes "~/org/Math.org"
          org-ref-default-bibliography '("~/bibliography/latex.bib")
          org-ref-pdf-directory "~/pdf/"))


;; Select citations
(use-package! ivy-bibtex
  :config
    ;; Points where your pdfs etc are stored and the bibtex file.
    (setq bibtex-completion-library-path "~/pdf/")
    (setq bibtex-completion-bibliography "~/latex/bibliography.bib")
    (setq bibtex-completion-notes-path "~/org/Math.org")

    ;; Cite completion with C-c ñ
    (global-set-key (kbd "C-c ñ") 'ivy-bibtex)
    (setq ivy-bibtex-default-action 'ivy-bibtex-insert-citation))

;; Org mode speed keys
;; Quickly jumps between headers.
;; https://emacs.stackexchange.com/a/32625/12208
(setq org-goto-interface 'outline-path-completion)
(setq org-outline-path-complete-in-steps nil)
(setq org-goto-max-level 2)

;; Speed commands work on headers. Pressing =n= there, for instance,
;; jumps to the next header.
(setq org-use-speed-commands t)

;; These are basic keybindings for the agenda and org-capture.
(setq org-export-coding-system 'utf-8)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; Navigation between headings made easier.
(add-hook 'org-mode-hook
  (lambda ()
       (local-set-key "\M-n" 'outline-next-visible-heading)
       (local-set-key "\M-p" 'outline-previous-visible-heading)))

;; When set to t, asks for confirmation each time it executes an elisp
;; block.
(setq org-confirm-elisp-confirm-function nil)

;; Pretty entities automatically draws '\alpha' as α when set as t.
(setq org-pretty-entities nil)

;; Hierarchical statistics for checkboxes. checkboxes in subheaders
;; are considered for statistics when this is set as t.
(setq org-checkbox-hierarchical-statistics t)

;; Sets a single bullet in org mode whose symbol is the asterisk. That
;; feels more sensible than having a list of different symbols.
(use-package! org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-bullets-bullet-list '("*"))

;; Hides emphasis markers while writing when set to t.
(setq org-hide-emphasis-markers t)


;; These options set where it will store the pdf and the location of
;; the notes.  They are the same ones that the Interleave package used,
;; keeping compatibility with it.
(setq org-noter-property-doc-file "INTERLEAVE_PDF")
(setq org-noter-property-note-location "INTERLEAVE_PAGE_NOTE")

;; Org-id automatically provides an ID for each header when necessary:
;; for example, when creating a link.
(use-package! org-id)

;; We only want it to work if no custom id has been already created.
(setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)


;; Deft.
;; The first element of ~deft-extensions~ is the default extension for new files.
(use-package! deft
  :bind ("C-c C-d" . deft)
  :commands (deft)
  :config
    (setq deft-directory "~/org/deft")
    (setq deft-extensions '("org" "md" "txt"))
    (setq deft-recursive nil)
    (setq deft-current-sort-method 'title)
    ; Decouples the display from the actual filename.
    (setq deft-use-filter-string-for-filename t)
    ; Deft will replace all slashes and spaces with hyphens and will convert the
    ; file name to lowercase.
    (setq deft-file-naming-rules
      '((noslash . "-")
        (nospace . "-")
        (case-fn . downcase))))


; We ask the operative system to change Caps to Ctrl. This is a possible
; solution to the Emacs pinky (http://ergoemacs.org/emacs/emacs_pinky.html).
; It becomes a systemwide option, but I prefer this to be systemwide anyway.
(shell-command "setxkbmap -option ctrl:nocaps")

;; Edit with multiple cursors at the same time.
(use-package! multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
        ("C->" . mc/mark-next-like-this)))

;; It is possible to change windows in Emacs using 'C-x o', but
;; sometimes 'C-tab' still feels more intuitive to me.
(global-set-key [C-tab] 'other-window)
(global-set-key [C-iso-lefttab] (lambda () (interactive) (other-window -1)))

(use-package! windmove
    :config
      (windmove-default-keybindings 'super)
      (setq windmove-wrap-around t))


;; Configuration packages.
(load! "+agenda")
(load! "+refile")
(load! "+latex")
(load! "+capture")

