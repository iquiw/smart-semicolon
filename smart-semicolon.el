;;; smart-semicolon.el --- Insert semicolon smartly -*- lexical-binding: t -*-

;; Copyright (C) 2017 by Iku Iwasa

;; Author:    Iku Iwasa <iku.iwasa@gmail.com>
;; URL:       https://github.com/iquiw/smart-semicolon
;; Version:   0.0.0
;; Package-Requires: ((emacs "25"))

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This is a minor mode to insert semicolon smartly, like Eclipse does.
;;
;; When `smart-semicolon-mode' is enabled, typing `;' inserts
;; semicolon at the end of line if there is no semicolon there.
;;
;; If there is semicolon at the end of line, typing `;' inserts
;; semicolon at the point.
;;
;; To enable it, add `smart-semicolon-mode' to some major mode hook.
;;
;;     (add-hook 'c-mode-common-hook #'smart-semicolon-mode)
;;

;;; Code:

(defgroup smart-semicolon nil
  "Smart Semicolon"
  :group 'editing)

(defcustom smart-semicolon-trigger-chars '(?\;)
  "List of characters that trigger smart semicolon behavior.")

(defun smart-semicolon-post-self-insert-function ()
  "Insert semicolon at appropriate place when it is typed."
  (when (and (eq (char-before) last-command-event)
             (memq last-command-event smart-semicolon-trigger-chars))
    (let ((beg (point))
          (ppss (syntax-ppss)))
      (unless (elt ppss 4)
        (goto-char (line-end-position))
        (skip-chars-backward "[[:blank:]]")
        (if (eq (char-before) last-command-event)
            (goto-char beg)
          (insert last-command-event)
          (save-excursion
            (goto-char beg)
            (delete-char -1)))))))

;;;###autoload
(define-minor-mode smart-semicolon-mode
  "Minor mode to insert semicolon smartly."
  :lighter " (;)"
  (if smart-semicolon-mode
      (add-hook 'post-self-insert-hook
                #'smart-semicolon-post-self-insert-function nil t)
    (remove-hook 'post-self-insert-hook
                 #'smart-semicolon-post-self-insert-function t)))

(provide 'smart-semicolon)
;;; smart-semicolon.el ends here
