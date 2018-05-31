(ql:quickload "cffi")

(defpackage :cudnn
  (:use :common-lisp :cffi))

(in-package :cudnn)

(define-foreign-library cudnn
  (t (:default "libcudnn")))
(use-foreign-library cudnn)

(load "cudnn.lisp")



;;cudnnHandle_t hCudNN = NULL;
;;cudnnTensor4dDescriptor_t pInputDesc = NULL;
;;cudnnFilterDescriptor_t pFilterDesc = NULL;
;;cudnnConvolutionDescriptor_t pConvDesc = NULL;
;;cudnnTensor4dDescriptor_t pOutputDesc = NULL;
;;cudnnStatus_t status;
