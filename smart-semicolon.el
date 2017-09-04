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

(defcustom smart-semicolon-backspace-commands
  '(backward-delete-char delete-backward-char c-electric-backspace)
  "List of commands that are treated as backspace command.")

(defvar smart-semicolon--last-change nil)
(defvar smart-semicolon--last-command nil)

(defun smart-semicolon-revert-move ()
  "Revert smart-semicolon behavior by `backward-delete-char'.
if `backward-delete-char' is called after."
  (when (and smart-semicolon--last-change
             (memq this-command smart-semicolon-backspace-commands))
    (pcase-let ((`(,ch ,origin ,dest) smart-semicolon--last-change))
      (when (eq (point) dest)
        (goto-char origin)
        (insert ch))))
  (unless (eq this-command smart-semicolon--last-command)
    (setq smart-semicolon--last-change nil)))

(defun smart-semicolon-post-self-insert-function ()
  "Insert semicolon at appropriate place when it is typed."
  (setq smart-semicolon--last-change nil)
  (when (and (eq (char-before) last-command-event)
             (memq last-command-event smart-semicolon-trigger-chars))
    (let ((origin (point))
          (ppss (syntax-ppss))
          dest)
      (unless (elt ppss 4)
        (goto-char (line-end-position))
        (skip-chars-backward "[[:blank:]]")
        (setq dest (1- (point)))
        (if (eq (char-before) last-command-event)
            (goto-char origin)
          (insert last-command-event)
          (save-excursion
            (goto-char origin)
            (delete-char -1))
          (setq smart-semicolon--last-change
                (list last-command-event (1- origin) dest))
          (setq smart-semicolon--last-command this-command))))))

;;;###autoload
(define-minor-mode smart-semicolon-mode
  "Minor mode to insert semicolon smartly."
  :lighter " (;)"
  (if smart-semicolon-mode
      (progn
        (add-hook 'post-self-insert-hook
                  #'smart-semicolon-post-self-insert-function nil t)
        (add-hook 'post-command-hook
                  #'smart-semicolon-revert-move nil t))
    (remove-hook 'post-self-insert-hook
                 #'smart-semicolon-post-self-insert-function t)
    (remove-hook 'post-command-hook
                 #'smart-semicolon-revert-move t)))

(provide 'smart-semicolon)
;;; smart-semicolon.el ends here
