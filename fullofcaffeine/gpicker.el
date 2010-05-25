;;Configuration for gpicker
;;
;;Why Peeopen *and* gpicker?
;;
;;While peepopen is more polished and opens faster, gpicker works
;;better in overall, besides, gpicker keeps a global context, which
;;can be good to setup for the most visited project, and peeopen for
;;context-based file picking
;;
;;Also, as of May/23th/2010, peepopen doesn't update its list of files
;;in real-time, gpicker does.
;;
;;gpicker also makes an awesome documentation browser. Through the
;;supermegadoc script (http://github.com/alk/supermegadoc).

;;<gpicker configuration>

;;(autoload 'gpicker "gpicker" "gpicker" t)

(require 'gpicker)

(global-set-key [8388710] 'gpicker-find-file)
(global-set-key [?\C-x ?4 8388710] 'gpicker-find-file-other-window)
(global-set-key [?\C-x ?5 8388710] 'gpicker-find-file-other-frame)

;;</end>

(provide 'fullofcaffeine/gpicker)

