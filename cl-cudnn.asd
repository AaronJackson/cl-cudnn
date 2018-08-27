(asdf:defsystem #:cl-cudnn
  :description "cudnn in lisp"
  :author "Aaron Jackson"
  :depends-on (#:cffi)
  :serial t
  :components ((:file "package")
               (:file "cudnn")))
