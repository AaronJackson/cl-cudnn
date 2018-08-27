#!/usr/local/sbcl --script

(asdf:load-system :cl-cudnn)

(in-package #:cl-cudnn)

(define-foreign-library cudnn
  (t (:default "libcudnn")))
(use-foreign-library cudnn)


(format t "~A ~D.~%"
	"Your version of CuDNN is"
	(convert-from-foreign (cudnnGetVersion) :unsigned-int))

(defparameter *handle* (cffi:foreign-alloc :pointer))
(foreign-funcall "cudnnCreate"
		 :pointer *handle*
		 cudnnStatus_t)

(defun Tensor4D (a b c d)
  (let ((*tensor* (foreign-alloc :pointer)))
    (foreign-funcall "cudnnCreateTensorDescriptor"
		     :pointer *tensor*
		     cudnnStatus_t)
    (foreign-funcall "cudnnSetTensor4dDescriptor"
		     :pointer (mem-aref *tensor* :pointer)
		     :int (foreign-enum-value 'cudnnTensorFormat_t :CUDNN_TENSOR_NCHW)
		     :int (foreign-enum-value 'cudnnDataType_t :CUDNN_DATA_FLOAT)
		     :int a ; N
		     :int b ; C
		     :int c ; H
		     :int d ; W
		     cudnnStatus_t)
    *tensor*))

(defun Filter4D (batch-size channels width height)
  (let ((*desc* (foreign-alloc :pointer))
	(*convolution* (foreign-alloc :pointer)))
    (foreign-funcall "cudnnCreateFilterDescriptor"
		     :pointer *desc*
		     cudnnStatus_t)
    (foreign-funcall "cudnnSetFilter4DDescriptor"
		     :pointer (mem-aref *convolution* :pointer)
		     :int (foreign-enum-value 'cudnnDataType_t :CUDNN_DATA_FLOAT)
		     :int (foreign-enum-value 'cudnnTensorFormat_t :CUDNN_TENSOR_NCHW)
		     :int batch-size
		     :int channels
		     :int width
		     :int height
		     cudnnStatus_t)

(defun SpatialConvolution 

(defvar tensor1 (Tensor4D 100 100 100 100))
(print tensor1)


;; (print (foreign-funcall "cudnnCreateFilterDescriptor"
;; 			:pointer *convA-filter-desc*
;; 			cudnnStatus_t))

;; (print (foreign-funcall "cudnnSetFilter4dDescriptor"
;; 			:pointer (mem-aref *convA-filter-desc* :pointer)
;; 			:int (foreign-enum-value 'cudnnDataType_t :CUDNN_DATA_FLOAT)
;; 			:int (foreign-enum-value 'cudnnTensorFormat_t :CUDNN_TENSOR_NCHW)
;; 			:int 1    ; N
;; 			:int 128  ; C
;; 			:int 3    ; H
;; 			:int 3    ; W
;; 			cudnnStatus_t))

;; (print (foreign-funcall "cudnnCreateConvolutionDescriptor"
;; 			:pointer *convA-desc*
;; 			cudnnStatus_t))




;; (print (foreign-funcall "cudnnDestroyTensorDescriptor"
;; 			:pointer (mem-aref *A* :pointer)
;; 			cudnnStatus_t))
