;;; supermegadoc.el --- launcher for erlang html documentation

;; Copyright (C) 2009 Aliaksey Kandratsenka

;; Author: Aliaksey Kandratsenka <alk@tut.by>
;; Keywords: convenience, docs

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:
(require 'ffap)

(defvar *supermegadoc-index-dir* (expand-file-name "~/.supermegadoc/ri.cdb"))
(defvar *supermegadoc-errors-log* (expand-file-name "~/supermegadoc-errors.log"))
(defvar *supermegadoc-browse-url-function* 'w3m-browse-url)

(defun supermegadoc-grab-stdout (&rest call-process-args)
  (with-temp-buffer
    (unwind-protect (let ((status (apply #'call-process
                                         (car call-process-args)
                                         nil
                                         (list (current-buffer) *supermegadoc-errors-log*)
                                         nil
                                         (cdr call-process-args))))
                      (if (eql status 0)
                          (buffer-string)
                        (message "%s exited with status %s" (car call-process-args) status)
                        (save-excursion
                          (set-buffer "*Messages*")
                          (goto-char (point-max))
                          (insert-file-contents *supermegadoc-errors-log*))
                        nil))
      (condition-case nil
          (delete-file *supermegadoc-errors-log*)
        (error nil)))))

(defun supermegadoc-run (cdb-path)
  (setq cdb-path (expand-file-name cdb-path *supermegadoc-index-dir*))
  (let ((rv (supermegadoc-grab-stdout "/usr/local/bin/supermegadoc"
                                      "--for-emacs"
                                      (concat "--init-filter=" (ffap-string-at-point))
                                      cdb-path)))
    (and (not (string-equal rv ""))
         rv)))

(defun supermegadoc-html (cdb-path)
  (let ((url (supermegadoc-run cdb-path)))
    (when url
      (let* ((bf *supermegadoc-browse-url-function*)
             (browse-url-browser-function (or (and bf
                                                   (indirect-function bf))
                                              browse-url-browser-function)))
        (when (and (listp browse-url-browser-function)
                   (eql (car browse-url-browser-function) 'autoload))
          (load (cadr browse-url-browser-function))
          (setq browse-url-browser-function (indirect-function bf)))
        (browse-url url)))))

(defun supermegadoc-erlang ()
  (interactive)
  (supermegadoc-html "erdoc.cdb"))

(defun supermegadoc-ri ()
  (interactive)
  (let ((url (supermegadoc-run "ri.cdb")))
    (when url
      ;; eat initial "ri:"
      (ri (substring url 3)))))

(defun supermegadoc-devhelp ()
  (interactive)
  (supermegadoc-html "devhelp.cdb"))

(defun superwoman ()
  (interactive)
  (require 'woman)
  (let ((url (supermegadoc-run "man.cdb")))
    (when url
      ;; eat initial "man-file:"
      (woman-find-file (substring url 9)))))

(provide 'supermegadoc)
;;; supermegadoc.el ends here