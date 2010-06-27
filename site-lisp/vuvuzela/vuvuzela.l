; -*- mode: lisp; package: vuvuzela -*-

;;; vuvuzela/vuvuzela.l
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
  (require "vuvuzela/resource")
  )

(in-package :vuvuzela)

(export '(*vuvuzela-wav*
          *vuvuzela-play-hook*
          *vuvuzela-stop-hook*

          vuvuzela-play
          vuvuzela-stop
          toggle-vuvuzela-repeat
          vuvuzela-repeat-p
          ))

(defvar *vuvuzela-wav* nil)

(defvar *vuvuzela-play-hook* nil)

(defvar *vuvuzela-stop-hook* nil)

(define-history-variable *vuvuzela-repeat-p* nil)

(defparameter *vuvuzela-play-p* nil)


(defun vuvuzela-play ()
  (interactive)
  (when (sound-play-async (vuvuzela-wav)
                          :nowait t :nodefault t
                          :loop (vuvuzela-repeat-p))
    (setf *vuvuzela-play-p* t)
    (run-hooks '*vuvuzela-play-hook*)))

(defun vuvuzela-stop ()
  (interactive)
  (when *vuvuzela-play-p*
    (sound-stop)
    (setf *vuvuzela-play-p* nil)
    (run-hooks '*vuvuzela-stop-hook*)))

(defun toggle-vuvuzela-repeat (&optional (on-or-off nil on-or-off-supply-p))
  (interactive)
  (let ((on (if on-or-off-supply-p
                on-or-off
              (null *vuvuzela-repeat-p*))))
    (message "ブブゼラ リピート ~[On~;Off~]" (if on 0 1))
    (setf *vuvuzela-repeat-p* on)))

(defun vuvuzela-repeat-p ()
  *vuvuzela-repeat-p*)

(defun vuvuzela-unregister-history-variable ()
  (unregister-history-variable '*vuvuzela-repeat-p*))


(provide "vuvuzela/vuvuzela")

;;; End
