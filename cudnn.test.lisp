(ql:quickload "cffi")

(defpackage :cudnn
  (:use :common-lisp :cffi))

(in-package :cudnn)

(define-foreign-library cudnn
  (t (:default "libcudnn")))
(use-foreign-library cudnn)

(load "cudnn.lisp")

(print (format t "~A ~D.~%"
	"Your version of CuDNN is"
	(convert-from-foreign (cudnnGetVersion) :unsigned-int)))

(defparameter *handle* (cffi:foreign-alloc :pointer))
(princ (foreign-funcall "cudnnCreate" :pointer *handle*
		 cudnnStatus_t))

(princ *handle*) ;; should be CUDNN_STATUS_SUCCESS if you set
;; CUDA_VISIBLE_DEVICES to something invalid it will return
;; CUDNN_STATUS_NOT_INITIALIZED

