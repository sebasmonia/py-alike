;;;; package.lisp

(defpackage #:py-alike
  (:nicknames :pya)
  (:use #:common-lisp #:uiop)
  (:import-from :alexandria)
  (:import-from :uiop)
  (:import-from :yason)
  (:import-from :trivial-clipboard)
  (:import-from :py-configparser)
  (:export
   #:clip-to-list
   #:list-to-clip))

(in-package #:py-alike)
