;;; starter-kit-registers.el --- Set up registers
;;
;; Part of the Emacs Starter Kit

;; Registers allow you to jump to a file or other location
;; quickly. Use C-x r j followed by the letter of the register (i for
;; init.el, r for this file) to jump to it.

;; You should add registers here for the files you edit most often.

(dolist (r `((?i (file . ,(concat dotfiles-dir "init.el")))
             (?b (file . ,(concat dotfiles-dir "starter-kit-bindings.el")))
             (?r (file . ,(concat dotfiles-dir "starter-kit-registers.el")))
             (?l (file . "~/workspace/code/yourtruelife/book_notes.org"))
             (?h (file . "~/org/gtd/horizons_of_focus.org"))
             (?c (file . "~/org/gtd/calendar.org"))
             (?j (file . "~/org/data/blog/journal.org"))
             (?o (file . "~/.emacs.d/fullofcaffeine/org.el"))
             (?s (file . "~/org/gtd/someday_maybe.org"))
             (?z (file . "~/workspace/code/zenorg_docs/zenorg.org"))
             (?y (file . "~/workspace/code/booksfy_docs/docs/Projeto.org"))
             (?m (file . "~/org/data/dynamic_reference/MediCenter.org"))

             

             ))
  (set-register (car r) (cadr r)))

(provide 'starter-kit-registers)
;;; starter-kit-registers.el ends here
