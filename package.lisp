;;;; package.lisp

(defpackage #:py-alike
  (:nicknames :pya)
  (:use #:common-lisp #:uiop)
  (:import-from :alexandria)
  (:import-from :uiop)
  (:import-from :shasht)
  (:import-from :trivial-clipboard)
  (:import-from :py-configparser)
  (:export
   #:deep-copy
   #:counter
   #:counter-most-common
   #:to-adjustable-vector
   #:print-as-json
   #:clip-to-list
   #:list-to-clip
   #:naive-pickle
   #:naive-unpickle))

(in-package #:py-alike)
