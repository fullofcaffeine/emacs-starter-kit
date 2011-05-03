;;git.el related configuration goes here

(require 'git)


;;additional custom conf goes here

(global-set-key (kbd "C-x C-g") '(lambda () (interactive) (git-status "~/workspace/code/onelogin")))



(provide 'fullofcaffeine/git)
