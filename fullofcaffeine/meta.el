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

;;send block of code to inf-rubt
(global-set-key (kbd "C-u")  'ruby-send-block)


(require 'org-mac-protocol)

(color-theme-railscasts)

(provide 'fullofcaffeine/meta)
