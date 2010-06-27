; -*- mode: lisp; package: vuvuzela -*-

;;; vuvuzela/toolbar.l
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
  (require "vuvuzela/vuvuzela")
  (require "vuvuzela/resource")
  )

(in-package :vuvuzela)

(export '(vuvuzela-show-toolbar
          vuvuzela-hide-toolbar
          ))

(defvar *vuvuzela-toolbar-name* "�u�u�[��(&V)")

(defconstant +vuvuzela-toolbar-sym+ :vuvuzela-toolbar)

(defun repeat-button-status ()
  (if (vuvuzela-repeat-p) :check nil))

(defun vuvuzela-toolbar ()
  (create-tool-bar
   +vuvuzela-toolbar-sym+ (vuvuzela-toolbar-bmp)
   '(("�炷" 0 vuvuzela-play)
     ("�~�߂�" 1 vuvuzela-stop)
     ("���[�v" 2 toggle-vuvuzela-repeat repeat-button-status)
     )))
;; create-tool-bar �Ɏw�肵���V���{���� symbol-function �� show-tool-bar �ŌĂ΂��B
;; �Ǝ��p�b�P�[�W���̃V���{�����w�肷��ƃA���C���X�g�[��������� delete-command-bar ���悤�Ƃ��Ă�
;; �p�b�P�[�W�����݂��Ȃ��̂ŃG���[�ɂȂ�B
;; �Ƃ����킯�ŁAcreate-tool-bar �Ɏw�肷��̂̓L�[���[�h�ɂ���
;; �L�[���[�h�� symbol-function �𖾎��I�Ɏw�肷��B
;; ����� (delete-command-bar :vuvuzela-toolbar) �Ƃ��č폜�ł���
(setf (symbol-function +vuvuzela-toolbar-sym+) #'vuvuzela-toolbar)

(defun vuvuzela-show-toolbar ()
  (interactive)
  (show-command-bar +vuvuzela-toolbar-sym+))

(defun vuvuzela-hide-toolbar ()
  (interactive)
  (hide-command-bar +vuvuzela-toolbar-sym+))

(defun vuvuzela-install-toolbar ()
  (define-command-bar +vuvuzela-toolbar-sym+ *vuvuzela-toolbar-name*))

(defun vuvuzela-uninstall-toolbar ()
  (delete-command-bar +vuvuzela-toolbar-sym+))

;; require ���Ƀc�[���o�[���C���X�g�[������
;; �\�����c�[���o�[���u�u�[���� M-x vuvuzela-show-toolbar �ŕ\���ł���
(vuvuzela-install-toolbar)


(provide "vuvuzela/toolbar")

;;; End