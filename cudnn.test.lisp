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
(foreign-funcall "cudnnCreate"
		 :pointer *handle*
		 cudnnStatus_t)

;; should be CUDNN_STATUS_SUCCESS if you set
;; CUDA_VISIBLE_DEVICES to something invalid it will return
;; CUDNN_STATUS_NOT_INITIALIZED

(defparameter *A* (cffi:foreign-alloc :pointer)) ;; input
(defparameter *B* (cffi:foreign-alloc :pointer)) ;; output
(defparameter *filter* (cffi:foreign-alloc :pointer)) ;; the conv filter

(princ (foreign-funcall "cudnnCreateTensorDescriptor"
			:pointer *A*
			cudnnStatus_t))

(princ (foreign-funcall "cudnnSetTensor4dDescriptor"
			:pointer *A*
			:int (foreign-enum-value 'cudnnTensorFormat_t :CUDNN_TENSOR_NCHW)
			:int (foreign-enum-value 'cudnnDataType_t :CUDNN_DATA_DOUBLE)
			:int 1  ; N
			:int 1  ; C
			:int 10 ; W
			:int 10 ; H
			cudnnStatus_t))

cudnnTensorDescriptor_t output_descriptor;
checkCUDNN(cudnnCreateTensorDescriptor(&output_descriptor));
checkCUDNN(cudnnSetTensor4dDescriptor(output_descriptor,
                                      /*format=*/CUDNN_TENSOR_NHWC,
                                      /*dataType=*/CUDNN_DATA_FLOAT,
                                      /*batch_size=*/1,
                                      /*channels=*/3,
                                      /*image_height=*/image.rows,
                                      /*image_width=*/image.cols));


;; (cffi:defcfun ("cudnnSetTensor4dDescriptor" cudnnSetTensor4dDescriptor) cudnnStatus_t
;;   (tensorDesc :pointer)
;;   (format cudnnTensorFormat_t)
;;   (dataType cudnnDataType_t)
;;   (n :int)
;;   (c :int)
;;   (h :int)
;;   (w :int))
