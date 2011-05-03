(grep-compute-defaults)


(setq load-path (cons (concat dotfiles-dir "vendor/org/lisp")  load-path))
(setq load-path (cons (concat dotfiles-dir "vendor/org/contrib/lisp")  load-path))

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
    (add-hook 'org-mode-hook 'iimage-mode)
    (transient-mark-mode 1)
    )
  )



;;this should be moved to a custom-conf file, as this file is only a
;;def/conf:
(org-remember-insinuate)
(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/gtd/GTDinbox.org"))
(define-key global-map "\C-cr" 'org-remember)


;;import flagged mai
;(defun my-mail-import ()
;  (let ((org-mac-mail-account "OneLog.in"))
;    (org-mac-message-insert-flagged "in.org" "Flagged mail")))



;;(setq org-agenda-files (list "~/org/gtd/GTD.org" "~/org/gtd/"))
;;(setq org-agenda-files (list "~/org/gtd/gtd.org"
;;"~/org/gtd/calendar.org")) Now set in custom.el

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
        
     ("OneLogin-Bug" ?b "*** TODO %^{Description} :ONELOGIN:BUG:\nAdded: %U" "~/org/gtd/gtd.org")
     ("NextAction" ?t "*** TODO %^{Brief Description} %^g\n%?\nAdded: %U" "~/org/gtd/gtd.org")
     ("TaskForToday" ?d "*** TODO %^{Brief Description} %^g\nSCHEDULED: %t" "~/org/gtd/gtd.org")
     ("Inbox" ?i "\n* %^{topic} %T \n%i%?\n%a" "~/org/gtd/in.org")
     ("Someday" ?s "\n* %^{topic} %T \n%i%?\n" "~/org/gtd/someday_maybe.org")
     ("Reference" ?r "\n* %^{topic} %^g %T \n%i%?\n" "~/org/gtd/reference.org" "Reference")
     ("Project" ?p "*** TODO %^{Brief Description} %^g\n%?\nAdded: %U" "~/org/gtd/gtd.org" "*Projects*")
     ("AppleScript remember" ?y "* %:shortdesc\n  %:initial\n   Source: %u, %c\n\n  %?" "~/org/gtd/in.org" "Remember")
     ("AppleScript note" ?z "* %?\n\n  Date: %u\n" "~/org/gtd/in.org" "Notes")
     ("ThinkingOuttaBoxCollector" ?o "** %^{Description} :THINKINGOUTTABOX:NOTE:\nAdded: %U" "~/workspace/code/thinkingouttabox/notes.org", "Notes")
     )
    )

(defun gtd ()
   (interactive)
   (find-file "~/org/gtd/gtd.org")
)

;;(global-set-key "g" (find-file ""))
;Notes, ideas and other unprocessed stuff -- quickly capture from within emacs
(defun inbox ()
  (interactive)
   (find-file "~/org/gtd/in.org")
)

;Someday Maybe
(defun someday-maybe ()
  (interactive)
  (find-file "~/org/gtd/someday_maybe.org")
)


(global-set-key "g" (quote gtd))
(global-set-key "i" (quote inbox))
;;(global-set-key "s" (quote someday-maybe))
(global-set-key "c" (quote calendar))


;;a little elisp func to rgrep through all my org directory
(defun org-rgrep (REGEXP1) "Searches through all my org/PIM files" (interactive "sSearch PIM for: ") (rgrep REGEXP1 "*.org" "~/org" ))
;;bind the previous function to windows_key + o
;;(global-set-key [?\s-o] 'org-rgrep)
 
(defun tags-rgrep (REGEXP1) "Searches the dynamic data for documents tags" (interactive "sSearch TAGS:") (rgrep (concat "^* tags.*" REGEXP1 ".*$") "*.org" "~/org/data/dynamic_reference"))

(global-set-key (kbd "C-t") 'tags-rgrep)


;; Insert immediate timestamp
  (define-key global-map (kbd "<f9>")
              '(lambda () (interactive)
              (when (eq major-mode 'org-mode)
              (org-insert-time-stamp nil t t)
              (insert "\n"))))


(setq org-agenda-custom-commands
      '(
        ("O" "OneLogin Next-Actions"
         ((agenda)
          (tags-todo "ONELOGIN")
          )
         )
        
        ("N" "Personal Next-Actions"
         ((agenda)
          (tags-todo "PERSONAL|FREETIME")))

        ("L" "OneLogin Projects"
         ((agenda)
          (tags "PROJECT+ONELOGIN|FEATURE")
          )
         )

        ("B" "OneLogin Outstanding Bugs"
         ((agenda)
          (tags-todo "ONELOGIN+BUG")
          )
         )

        ("P" "Personal Projects"
         ((agenda)
          (tags "PROJECT-ONELOGIN")
          ))

        ("w" "Pending Tasks (WAITING-FOR)"
         ((agenda)
          (todo "WAITING-FOR"))
         )

   ("c" "Checklists"
         ((agenda)
          (tags "CHECKLIST"))
         )
        
        ("r" "Books I am reading"
         ((agenda)
          (todo "READING"))
         )
         
         ("D" "Daily Action List"
          (
           (agenda "" ((org-agenda-ndays 1)
                       (org-agenda-sorting-strategy
                        (quote ((agenda time-up priority-down tag-up) )))
                       (org-deadline-warning-days 0)
                       ))))

        ; ("F" "Import links to flagged mail" agenda ""
        ;                ((org-agenda-mode-hook
        ;                  (my-mail-import))))

         )
      )

;;MOBILEORG CONF

;;(setq org-mobile-directory "/Volumes/orgmms")
(setq org-mobile-directory "~/Dropbox/MobileOrg")

(setq org-mobile-files-exclude-regexp "reference.org")




(defun dpush nil nil (interactive) (org-mobile-push) (org-mobile-push))
(global-set-key (kbd "<f9>") 'org-mobile-push)

(add-to-list 'org-agenda-custom-commands
            '("x" "PROJECT+N/A" tags-tree "PROJECT|TODO=\"TODO\""
              ((org-show-siblings nil)
               (org-show-entry-below nil))))





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


(defun find-wiki () "Find files in the wiki dir" (interactive) (peepopen-goto-file-gui-manual "~/org/data"))
(defun find-onelogin() "Find files in onelogin" (interactive) (peepopen-goto-file-gui-manual "~/workspace/code/onelogin"))


(global-set-key (kbd "s-o") 'find-onelogin)
(global-set-key (kbd "s-w") 'find-wiki)
(global-set-key (kbd "s-g") 'find-gtd-file)


(org-add-link-type "freemind" 'org-freemind-open)

(defun org-freemind-open (file)
(let ((outbuf (get-buffer-create "*Org Shell Output*"))
(cmd (concat "freemind ~/org/maps/" (shell-quote-argument file) ".mm &")))
(with-current-buffer outbuf (erase-buffer))
(shell-command cmd outbuf outbuf)))

;;(setq org-mac-mail-account "OneLog.in")


;; (setq org-agenda-custom-commands
;;       '(("F" "Import links to flagged mail" agenda ""
;;          ((org-agenda-mode-hook
;;            (my-mail-import))))
;;         ("P" "List of Projects" tags ":PROJECT:")
;;         ("C" "View Checklists" tags ":CHECKLIST")
;;         )
;;       )

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

;; on mac apple is meta
;(setq mac-command-modifier 'meta)
                                        ;(setq mac-option-modifier 'super)

;; backward-compatibility alias
(defface org-gtd-default-category-face
  '((((class color) (background light)) (:foreground "#7C95F6" :bold t :underline t))
    (((class color) (background dark)) (:foreground "#7C95F6" :bold t :underline t))
    (t (:bold t :underline t)))
  "Used by org-color-by-tag for items tagged with :CATEGORY:")


;; (defvar org-action-todo-verbs 
;;   '(
;;     (("TODO" "NEXT") . 
;;      ("Address" "Ask" "Avoid" "Buy" "Change" "Clarify" "Collect" "Commend" "Confront"
;;       "Consider" "Create" "Decide" "Defer" "Develop" "Discard" "Do Again" "Download"
;;       "Enter" "File" "Follow Up" "Hire" "Improve" "Increase" "Inform" "Inquire"
;;       "Maintain" "Measure" "Monitor" "Order" "Paint" "Phone" "Prioritize" "Purchase"
;;       "Question " "Reduce" "Remember" "Repair" "Reply" "Report" "Research" "Resolve"
;;       "Review" "Schedule" "Sell" "Send" "Service" "Specify" "Start" "Stop" "Suggest"
;;       "Tidy" "Train" "Update" "Upgrade" "Write"))
;;     (("PROJECT") . 
;;      ("Finalize" "Resolve" "Handle" "Look-Into" "Submit" "Maximize" "Organize"
;;       "Design" "Complete" "Ensure" "Research" "Roll-Out" "Update" "Install"
;;       "Implement" "Set-Up"))
;;     )
;;   "org-action todo keywords to apply to incorrect action verb overlay to.")

;; (defun org-font-lock-add-action-faces (limit)
;;   "Add the special action word faces."
;;   (let (rtn a)
;;     ;; check variable is set, and buffer left to search
;;     (when (and (not rtn) org-action-todo-verbs)
;;       ;; for each todo/action verb set
;;       (dolist (todo org-action-todo-verbs)
;;         ;; build regexps
;;         (let ((todo-keywords-regexp
;;                (concat "^\\*+[ 	]+" 
;;                        (regexp-opt (car todo) 'words)))
;;               (todo-action-verbs-regexp
;;                (concat "[ 	]+" (regexp-opt (cdr todo) 'words))))
;;           ;; while we can find a todo keyword
;;           (while (re-search-forward todo-keywords-regexp limit t)
;;             ;; check for action verb
;;             (if (looking-at todo-action-verbs-regexp)
;;                 nil
;;               ;; not an action verb, reset match data to next word
;;               (if (looking-at "[ 	]+\\(\\<\\w\\w+\\>\\)")
;;                   ;; apply new overlay
;;                   (let ((overlay (make-overlay (match-beginning 1) (match-end 1) nil t nil)))
;;                     (overlay-put overlay 'face 'org-gtd-default-category-face)
;;                     ;;(overlay-put overlay 'mouse-face mouse-face)
                    
;;                     (overlay-put overlay 'org-action-overlay t)
;;                     (overlay-put overlay 'evaporate t)
;;                     (overlay-put overlay 'help-echo "mouse-2: correct word at point")
;;                     overlay)))
;;             ;; reset search point?
;;             (backward-char 1)))))
;;     rtn))

;; (defun org-mode-action-verbs-hook ()
;;   "Initalise org-action-verbs."
;;   (interactive) 
;;   (font-lock-add-keywords nil '((org-font-lock-add-action-faces)))
;;   )

;; ;; Turn on action verb font locking.
;; (add-hook 'org-mode-hook 'org-mode-action-verbs-hook)

;;(provide 'org-action-verbs)
;;; org-annotate-file.el ends here

;; Show all future entries for repeating tasks
(setq org-agenda-repeating-timestamp-show-all t)

;; Show all agenda dates - even if they are empty
(setq org-agenda-show-all-dates t)

;; Sorting order for tasks on the agenda
(setq org-agenda-sorting-strategy
      (quote ((agenda habit-down time-up priority-down effort-up category-up)
              (todo priority-down)
              (tags priority-down))))

;; Start the weekly agenda today
(setq org-agenda-start-on-weekday nil)

;; Disable display of the time grid
(setq org-agenda-time-grid
      (quote (nil "----------------"
                  (800 1000 1200 1400 1600 1800 2000))))

;; Display tags farther right
(setq org-agenda-tags-column -102)


;;better checklist handling. Automatically unchecks checkboxes when
;;checkist is done
;;(load "~/git/org-mode/contrib/lisp/org-checklist")

;;The following setting hides all blank lines inside folded contents of a tasks:

(setq org-cycle-separator-lines 0)

;;The following setting prevents creating blank lines before list items and headings:

(setq org-blank-before-new-entry (quote ((heading)
                                         (plain-list-item))))


;;To create new headings in a project file it is really convenient to use C-S-RET. This inserts a new headline. With the following setting
;;Org adds the new heading after the content of the current item. This lets you hit C-S-RET in the middle of an entry and the new heading is added after the body of the current entry.

(setq org-insert-heading-respect-content t)

;;These notes are saved at the top of the task so unfolding the task shows the note first

(setq org-reverse-note-order nil)

;I have org-mode show the hierarchy of tasks above the matched entries and also the immediately following sibling task (but not all siblings) with the following settings:


(setq org-show-following-heading t)
(setq org-show-hierarchy-above t)
(setq org-show-siblings nil)


;This keeps the results of the search relatively compact and mitigates accidental errors by cutting too much data from your org file with C-k. Cutting folded data (including the …) can be really dangerous since it cuts text (including following subtrees) which you can't see. For this reason I always show the following headline when displaying search results. 




;Org-mode allows special handling of the C-a, C-e, and C-k keys while editing headlines. I also use the setting that pastes (yanks) subtrees and adjusts the levels to match the task I am pasting to. See the docstring (C-h v org-yank-adjust-subtrees) for more details on each variable and what it does.

(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-yank-adjusted-subtrees t)

;;journal quick access
;;(global-set-key (kbd "C-x j")  (lambda()  (interactive) (find-file "~/.org")))

(define-key org-mode-map (kbd "<f1>") 'org-advertized-archive-subtree)

 ;; Insert immediate timestamp
 (define-key global-map (kbd "<f4>")
   '(lambda () (interactive)
      (when (eq major-mode 'org-mode)
        (org-insert-time-stamp nil t t)
        (insert "\n"))))


(setq font-lock-verbose nil)

(setq org-return-follows-link t)
(setq org-open-non-existing-files t)

;;Create a new "wiki page"
(defun create-wiki-page (filename) "Creates a new dynamic ref. data page"
  (interactive "sEnter filename:")
  (with-temp-buffer
    (when (file-writable-p filename)
      (write-region (point-min) (point-max) (concat "~/org/data/dynamic_reference/" filename ".org"))))
  )

 (defun write-string-to-file (string file)
   (interactive "sEnter the string: \nFFile to save to: ")
   (with-temp-buffer
     (insert string)
     (when (file-writable-p file)
       (write-region (point-min)
                     (point-max)
                     file))))

;;extension: makes the index.org read-only when visiting

(global-set-key (kbd "<f3>")  (lambda()  (interactive) (find-file "~/org/index.org")))

(defun set-index-read-only () ""
  (if (equal (buffer-name) "index.org")
      (toggle-read-only)
      
    )
  )




(add-hook 'find-file-hook 'set-index-read-only)



(provide 'fullofcaffeine/org)
