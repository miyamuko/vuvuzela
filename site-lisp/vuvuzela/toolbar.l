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

(defvar *vuvuzela-toolbar-name* "ブブゼラ(&V)")

(defconstant +vuvuzela-toolbar-sym+ :vuvuzela-toolbar)

(defun repeat-button-status ()
  (if (vuvuzela-repeat-p) :check nil))

(defun vuvuzela-toolbar ()
  (create-tool-bar
   +vuvuzela-toolbar-sym+ (vuvuzela-toolbar-bmp)
   '(("鳴らす" 0 vuvuzela-play)
     ("止める" 1 vuvuzela-stop)
     ("ループ" 2 toggle-vuvuzela-repeat repeat-button-status)
     )))
;; create-tool-bar に指定したシンボルの symbol-function が show-tool-bar で呼ばれる。
;; 独自パッケージ内のシンボルを指定するとアンインストールした後に delete-command-bar しようとしても
;; パッケージが存在しないのでエラーになる。
;; というわけで、create-tool-bar に指定するのはキーワードにして
;; キーワードの symbol-function を明示的に指定する。
;; これで (delete-command-bar :vuvuzela-toolbar) として削除できる
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

;; require 時にツールバーをインストールする
;; 表示→ツールバー→ブブゼラか M-x vuvuzela-show-toolbar で表示できる
(vuvuzela-install-toolbar)


(provide "vuvuzela/toolbar")

;;; End
