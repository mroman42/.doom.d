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
    (setq org-ref-notes-directory "~/org/")
    (setq org-ref-bibliography-notes "~/org/Math.org")
    (setq org-ref-default-bibliography '("~/org/Math.bib"))
    (setq org-ref-pdf-directory "~/pdf/"))


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


;; Org-mode agenda
(load! "+agenda")
