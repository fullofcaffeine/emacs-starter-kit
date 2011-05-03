;;I'm still not sure what would be the best place to define
;;custom-shortcuts. This seems to be a good place, and also the local
;;system configuration .el

(global-set-key (kbd "C-x C-r") 'rgrep)
(global-set-key (kbd "s-r") 'revert-buffer)

                                        ;allow to use the meta key without using alt
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-linum-mode 1) ; always show line numbers

(server-start)

;;inf-ruby keybinding

;;trigger inf-ruby
(global-set-key (kbd "s-i") 'inf-ruby)
(global-set-key (kbd "s-b") 'indent-buffer)

;;send block of code to inf-rubt

(require 'org-mac-protocol)
(require 'iimage)
                                        ;(color-theme-railscasts)
;(zenburn)

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

(global-set-key [f11] 'toggle-fullscreen)

                                        ; Make new frames fullscreen by default. Note: this hook doesn't do
                                        ; anything to the initial frame if it's in your .emacs, since that file is

                                        ; read _after_ the initial frame is created.
(add-hook 'after-make-frame-functions 'toggle-fullscreen)


(set-cursor-color "red")

(setq c-basic-indent 2)
(setq tab-width 4)
(setq indent-tabs-mode nil)

(setq-default fill-column 90)


;;encryption stuff
(require 'epa)
(epa-file-enable)

(setq epg-gpg-program "gpg")



(global-set-key (kbd "<mouse-6>") 'scroll-right)
(global-set-key (kbd "<mouse-7>") 'scroll-left)

(set-face-font 'default "-apple-inconsolata-medium-r-normal--18-0-72-72-m-0-iso10646-1")

;;asciidoc mode:


(require 'doc-mode)
(add-to-list 'auto-mode-alist '("\\.doc$" . doc-mode))

(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key "fullofcaffeine@gmail.com")


(provide 'fullofcaffeine/meta)
