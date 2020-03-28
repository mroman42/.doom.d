;;; ~/.doom.d/+mail.el -*- lexical-binding: t; -*-

(after! mu4e
  (setq! mu4e-maildir (expand-file-name "~/.mail") ; the rest of the mu4e folders are RELATIVE to this one
         mu4e-get-mail-command "mbsync -a"
         mu4e-index-update-in-background t
         mu4e-use-fancy-chars t
         mu4e-view-show-addresses t
         mu4e-view-show-images t
         mu4e-compose-format-flowed t
         ;mu4e-compose-in-new-frame t
         mu4e-change-filenames-when-moving t ;; http://pragmaticemacs.com/emacs/fixing-duplicate-uid-errors-when-using-mbsync-and-mu4e/
         mu4e-maildir-shortcuts
         '( ("/inbox" . ?i)
            ("/gmail.all" . ?a)
            ("/gmail.drafts" . ?d)
            ("/gmail.trash" . ?t)
            ("/gmail.sent" . ?s))

         ;; Message Formatting and sending
         mu4e-compose-signature-auto-include nil
         message-signature-file "~/.doom.d/.mailsignature"
         message-send-mail-function 'smtpmail-send-it
         message-citation-line-format "On %a %d %b %Y at %R, %f wrote:\n"
         message-citation-line-function 'message-insert-formatted-citation-line
         message-kill-buffer-on-exit t

         ;; Org mu4e
         org-mu4e-convert-to-html t
         ))

(set-email-account! "mromang08@gmail.com"
                    '((user-mail-address      . "mromang08@gmail.com")
                      (user-full-name         . "Mario Román")
                      (smtpmail-smtp-server   . "smtp.gmail.com")
                      (smtpmail-smtp-service  . 587)
                      (smtpmail-stream-type   . starttls)
                      (smtpmail-debug-info    . t)
                      (mu4e-drafts-folder     . "/gmail.drafts")
                      (mu4e-refile-folder     . "/gmail.all")
                      (mu4e-sent-folder       . "/gmail.sent")
                      (mu4e-trash-folder      . "/gmail.trash")
                      (mu4e-update-interval   . 1800)
                      ) nil)
