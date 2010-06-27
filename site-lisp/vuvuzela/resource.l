; -*- mode: lisp; package: vuvuzela -*-

;;; vuvuzela/resource.l
;;
;; Copyright (c) 2010 MIYAMUKO Katsuyuki.
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;;; Code:

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "vuvuzela/package")
  )

(in-package :vuvuzela)

(defconstant +vuvuzela-default-wav+
  "Vuvuzela_single_note.wav")

(defconstant +vuvuzela-toolbar-bmp+
  "toolbar-vuvuzela.bmp")

(defun vuvuzela-toolbar-bmp ()
  (find-resource +vuvuzela-toolbar-bmp+))

(defun vuvuzela-wav ()
  (if *vuvuzela-wav*
      (ensure-file-exist *vuvuzela-wav*)
    (find-resource +vuvuzela-default-wav+)))

(defun find-resource (file)
  (or (find-resource-from *etc-path* file)
      (find-resource-from-load-path file)
      (plain-error "�t�@�C����������܂���: ~A" file)))

(defun find-resource-from (etcpath file)
  (let ((file (merge-pathnames file etcpath)))
    (when (file-exist-p file)
      file)))

(defun find-resource-from-load-path (file)
  ;; *etc-path* �� 1 �����ݒ�ł��Ȃ��B
  ;; NetInstaller �ŃC���X�g�[�������ꍇ�͗ǂ����A
  ;; �J�����̏ꍇ�� (system-root)/etc �Ƀt�@�C�����R�s�[����̂��ʓ|�Ȃ̂�
  ;; *load-path* ����̑��΃p�X�Ńt�@�C����T���B
  (dolist (loadpath *load-path*)
    (let* ((etcpath (merge-pathnames "../etc" loadpath))
           (resource (find-resource-from etcpath file)))
      (when resource
        (return resource)))))

(defun ensure-file-exist (file)
  (unless (file-exist-p file)
    (plain-error "�t�@�C�������݂��܂���: ~A" file))
  file)


(provide "vuvuzela/resource")

;;; End