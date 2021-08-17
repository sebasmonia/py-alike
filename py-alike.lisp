;;;; py-alike.lisp

(in-package #:py-alike)

(defun clip-to-list ()
  "Read from the clipboard a list of lines."
  (mapcar (lambda (a-str) (string-trim " " a-str))
          (uiop:split-string (trivial-clipboard:text) :separator '(#\Newline))))

(defun list-to-clip (a-list)
  "Send to the clipboard a list of strings as a single chunk of text."
  (trivial-clipboard:text (format nil "~{~A~%~}" a-list)))

(defun counter (sequence &key (test #'equal) (key #'identity))
  "Python's Counter, a bit less featurefull of course."
  (let ((counting-table (make-hash-table :test test))) ;; use the same test that we'll use to compare
    ;; coerce in case sequence is a vector. Probs defgeneric would be better?
    (loop for elem in (coerce sequence 'list)
          do (incf (gethash (funcall key elem) counting-table 0))
          finally (return (values counting-table
                                  (counter-most-common counting-table))))))

(defun counter-most-common (counter-ht &optional (how-many 3))
  "Python's most_common from Counter."
  ;; Quite inefficient, but I'm not counting millions of items anyway
  (let ((counts-only (sort (loop for v being the hash-values of counter-ht collect v)
                           #'>))
        (test-func (hash-table-test counter-ht))
        (output-alist nil))
    ;; from the # of counts, get only as many items as we need to fulfill how-many
    ;; and also reverse the list so that output-alist is correctly sorted
    ;; (I could also nreverse the alist- I think)
    (loop for count in (nreverse (subseq counts-only
                                         0
                                         (min how-many (length counts-only))))
          do (loop for item-key being the hash-key
                     using (hash-value item-count) of counter-ht
                   if (and (= count item-count)
                           (not (assoc item-key output-alist :test test-func)))
                     do
                        (push (cons item-key item-count) output-alist)
                        (loop-finish))
          finally (return output-alist))))

(defgeneric deep-copy (an-object)
  (:documentation
   "My limited, incomplete, but useful to me, version of copy.deepcopy()"))

(defmethod deep-copy ((an-object hash-table))
  "For hashtables, we create a shallow copy with Alexandria, then iterate
and call deep-copy on each value in the new table."
  (alexandria:copy-hash-table an-object :key #'deep-copy))

(defmethod deep-copy ((an-object vector))
  (coerce (loop for element across an-object
                collect (deep-copy element))
          'vector))

(defmethod deep-copy ((an-object string))
  "New string returned."
  (format nil "~a" an-object))

(defmethod deep-copy ((an-object list))
  "Walk list and deep-copy each element. Put them in a new list. "
  (mapcar #'deep-copy an-object))

(defmethod deep-copy ((an-object t))
  "Everything else: return as is. At least for now...
NOTE: All objects inherit from t."
  an-object)

(defun print-as-json (some-object)
  "Uses shasht to output pretty-printed JSON.
Seems that Jonathan doesn't support this."
  (format t "~a" (shasht:write-json some-object  nil)))

(defun to-adjustable-vector (fixed-vector)
  "Converts a fixed vector (usually from py4cl) to an adjustable vector."
  ;; see https://stackoverflow.com/a/41772190/91877 for the original setup
  (let ((adjustable-vector (make-array (length fixed-vector) :adjustable t)))
    (map-into adjustable-vector #'identity fixed-vector)))


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
;; (alexandria:write-string-into-file content "file.txt")

;; https://github.com/rpgoldman/xmls


;; (length (remove-if-not (lambda (item) (search "to-be-found" (alexandria:assoc-value item "A-Key" :test #'equal))) *some-list-of-data*))

;; substrings
;; lower("ABC") in lower("some big abc string")
;; char= is case sensitive
;; (search "ABC" "kjfauiabckdjflkj" :test #'char-equal)

;; capture strings that match regex
;; (ppcre:scan-to-strings "token=.*?," input-string)
;; --see also split-string above--

;; files & dirs
;; os.listdir(".")
;; (uiop:directory-files "./")
