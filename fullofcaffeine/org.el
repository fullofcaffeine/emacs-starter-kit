(setq load-path (cons (concat dotfiles-dir "org-mode/lisp")  load-path))
(setq load-path (cons (concat dotfiles-dir "org-mode/contrib/lisp")  load-path))


;;(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))


(eval-after-load 'org-install
  '(progn
    ;; The following lines are always needed.  Choose your own keys.
    (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
    (global-set-key "\C-cl" 'org-store-link)
    (global-set-key "\C-ca" 'org-agenda)
    (global-set-key "\C-cb" 'org-iswitchb)
    (global-font-lock-mode 1)                     ; for all buffers
    (add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only
    (transient-mark-mode 1)
    )
  )


;;this should be moved to a custom-conf file, as this file is only a
;;def/conf:
(org-remember-insinuate)
(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/gtd/GTDinbox.org"))
(define-key global-map "\C-cr" 'org-remember)



;;(setq org-agenda-files (list "~/org/gtd/GTD.org" "~/org/gtd/"))
(setq org-agenda-files (list "~/org/gtd/GTD.org" "~/org/wiki/"))

(global-font-lock-mode 1)                    ; for all buffers
(add-hook 'org-mode-hook 'turn-on-font-lock) ; Org buffers only

; I prefer return to activate a link
(setq org-return-follows-link t)

(org-add-link-type "freemind" 'org-freemind-open)

; I prefer return to activate a link
(setq org-return-follows-link t)


(defun org-freemind-open (file)
(let ((outbuf (get-buffer-create "*Org Shell Output*"))
(cmd (concat "freemind /home/marcelo/org/maps/" (shell-quote-argument file) ".mm &")))
(with-current-buffer outbuf (erase-buffer))
(shell-command cmd outbuf outbuf)))


(setq org-remember-templates
    '(
     ("NextAction" ?t "*** TODO %^{Brief Description} %^g\n%?\nAdded: %U" "~/org/gtd/GTD.org" "Single Step Projects")
     ("Inbox" ?i "\n* %^{topic} %T \n%i%?\n%a" "~/org/gtd/GTDInbox.org")
     ("Someday" ?s "\n* %^{topic} %T \n%i%?\n" "~/org/gtd/GTDSomedayMaybe.org")
     ("Reference" ?r "\n* %^{topic} %^g %T \n%i%?\n" "~/org/gtd/ReferenceNotes.org" "Reference")
     ("Project" ?p "*** TODO %^{Brief Description} %^g\n%?\nAdded: %U" "~/org/gtd/GTD.org" "*Projects*")

     


      ))

(defun gtd ()
   (interactive)
   (find-file "~/org/gtd/GTD.org")
)

;;(global-set-key "g" (find-file ""))
;Notes, ideas and other unprocessed stuff -- quickly capture from within emacs
(defun inbox ()
  (interactive)
   (find-file "~/org/gtd/GTDInbox.org")
)

;Someday Maybe
(defun someday-maybe ()
  (interactive)
  (find-file "~/org/gtd/GTDSomedayMaybe.org")
)


(global-set-key "g" (quote gtd))
(global-set-key "i" (quote inbox))
(global-set-key "s" (quote someday-maybe))
(global-set-key "c" (quote checklists))

;;a little elisp func to rgrep through all my org directory
(defun org-rgrep (REGEXP1) "Searches through all my org/PIM files" (interactive "sSearch PIM for: ") (rgrep REGEXP1 "*.org" "~/org" ))
;;bind the previous function to windows_key + o
(global-set-key [?\s-o] 'org-rgrep)
 



;; Insert immediate timestamp
  (define-key global-map (kbd "<f9>")
              '(lambda () (interactive)
              (when (eq major-mode 'org-mode)
              (org-insert-time-stamp nil t t)
              (insert "\n"))))


(setq org-agenda-custom-commands
      '(
        ("O" "Office next-actions"
         ((agenda)
          (tags-todo "OFFICE")
          )
         )

        ("H" "Office and Home Lists"
          ((agenda)
           (tags-todo "OFFICE")
           (tags-todo "HOME")
           (tags-todo "COMPUTER")
           (tags-todo "DVD")
           (tags-todo "READING")))
         
         ("D" "Daily Action List"
          (
           (agenda "" ((org-agenda-ndays 1)
                       (org-agenda-sorting-strategy
                        (quote ((agenda time-up priority-down tag-up) )))
                       (org-deadline-warning-days 0)
                       ))))
         
         )
      )

;;MOBILEORG CONF

(setq org-mobile-directory "/Volumes/orgmms")


(defun dpush nil nil (interactive) (org-mobile-push) (org-mobile-push))
(global-set-key (kbd "<f9>") 'org-mobile-push)









;;I still don't know how to format the below function well, there are
;;lots of code that don't relate with what I want to do, but
;;surprisignly, it works very well for what I want...




;;extension to PeepOpen to allow specifyin a project root

(defun peepopen-goto-file-gui-manual (arg)
  "Uses external GUI app to quickly jump to a file in the project."
  (interactive)
  (defun string-join (separator strings)
    "Join all STRINGS using SEPARATOR."
    (mapconcat 'identity strings separator))
  (let ((root arg))
    (when (null root)
      (error
       (concat
        "Can't find a suitable project root ("
        (string-join " " *textmate-project-roots* )
        ")")))
    (shell-command-to-string
     (format "open -a PeepOpen '%s'"
             (expand-file-name root)))))


(defun find-wiki () "Find files in the wiki dir" (interactive) (peepopen-goto-file-gui-manual "~/org/wiki"))

(global-set-key (kbd "s-w") 'find-wiki)
(global-set-key (kbd "s-g") 'find-gtd-file)


(org-add-link-type "freemind" 'org-freemind-open)

(defun org-freemind-open (file)
(let ((outbuf (get-buffer-create "*Org Shell Output*"))
(cmd (concat "freemind ~/org/maps/" (shell-quote-argument file) ".mm &")))
(with-current-buffer outbuf (erase-buffer))
(shell-command cmd outbuf outbuf)))

;;(setq org-mac-mail-account "OneLog.in")

;;import flagged mai
(defun my-mail-import ()
  (let ((org-mac-mail-account "OneLog.in"))
    (org-mac-message-insert-flagged "GTDInbox.org" "Flagged mail")))

(setq org-agenda-custom-commands
      '(("F" "Import links to flagged mail" agenda ""
         ((org-agenda-mode-hook
           (my-mail-import))))
        ("P" "List of Projects" tags ":PROJECT:"))

        )

;;
(setq org-combined-agenda-icalendar-file
      "/Library/WebServer/Documents/orgmode.ics")


 (add-hook 'org-after-save-iCalendar-file-hook
  (lambda ()
   (shell-command
    "osascript -e 'tell application \"iCal\" to reload calendars'")))

(setq org-hide-leading-stars t)


(require 'org-install)

(defun org-mobile-pullpush nil nil (org-mobile-pull)
                                    (org-mobile-push))


;;(run-at-time "00:59" 3600 'org-mobile-pullpush)


(provide 'starter-kit-orgmode)


;; on mac apple is meta
;(setq mac-command-modifier 'meta)
;(setq mac-option-modifier 'super)



(provide 'fullofcaffeine/org)