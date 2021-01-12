;;;; py-alike.lisp

(in-package #:py-alike)

(defun clip-to-list ()
  (mapcar (lambda (a-str) (string-trim " " a-str))
          (uiop:split-string (trivial-clipboard:text) :separator '(#\Newline))))

(defun list-to-clip (a-list)
  (trivial-clipboard:text (format nil "~{~A~%~}" a-list)))

;; (uiop:getenv "HOME")
;; (uiop:run-program (list "firefox" "http:url")) - sync
;; (uiop:run-program "ls" :output *standard-output*) - print output
;; (uiop:run-program "ls" :output :string) - return as str
;; uiop:launch-program for async calls, see https://lispcookbook.github.io/cl-cookbook/os.html#asynchronously


;; set operations, over lists: intersection set-difference union set-exclusive-or
;; https://lispcookbook.github.io/cl-cookbook/data-structures.html#set
;; (remove-duplicates '("foo" "foo" "bar") :test #'string-equal)

;; (uiop:read-file-string "file.txt")
;; (uiop:read-file-lines "file.txt")

;; https://github.com/rpgoldman/xmls


;; (length (remove-if-not (lambda (item) (search "to-be-found" (alexandria:assoc-value item "A-Key" :test #'equal))) *some-list-of-data*))
