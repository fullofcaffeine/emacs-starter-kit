;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;
;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

;; Benchmarking
(defvar *emacs-load-start* (current-time))

;; Load path etc:

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session:

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; Load up ELPA, the package manager:

(require 'package)
(package-initialize)
;;(require 'starter-kit-elpa)

;; Load up starter kit customizations:

(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)
(require 'starter-kit-lisp)
(require 'starter-kit-ruby)
;;(require 'starter-kit-js)

(regen-autoloads)
(load custom-file 'noerror)

(user-login-name)

;; You can keep system- or user-specific customizations here:


(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el"))

;;reversed in order to keep private data on system-specific-config
;;so, user-specific data will load my specific mods and then private
;;data is loaded from a system file (macbook.local.el, not under
;;version control)
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p system-specific-config) (load system-specific-config))
;; Benchmarking
(message "My .emacs loaded in %ds"
         (destructuring-bind (hi lo ms) (current-time)
           (- (+ hi lo) (+ (first *emacs-load-start*) (second
                                                       *emacs-load-start*)))))


(put 'narrow-to-region 'disabled nil)
;;This is the place for customizations specific to my macbook (local environment)

;;disable the visible bell, which doesn't work well on emacs 23 ns for OSX
(setq visible-bell nil)

;;I like using C-k for killing lines and regions
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key "\C-w" 'backward-kill-word)

(gpicker-visit-project "~/Projetos/onelogin")

(put 'downcase-region 'disabled nil)


(provide 'init)
;;; init.el ends here
