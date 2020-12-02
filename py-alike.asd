;;;; py-alike.asd

(asdf:defsystem #:py-alike
  :description "Py-alike: utilities to help me use CL like I use Python"
  :author "Sebastián Monía <seb.hoagie@outlook.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:alexandria
               #:uiop
               #:yason
               #:trivial-clipboard
               #:py-configparser)
  :components ((:file "package")
               (:file "py-alike")))
