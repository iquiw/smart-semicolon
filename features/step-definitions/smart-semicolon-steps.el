;; This file contains your project specific step definitions. All
;; files in this directory whose names end with "-steps.el" will be
;; loaded automatically by Ecukes.

(When "^I go to cell (\\([0-9]+\\), *\\([0-9]+\\))$"
  "Go to the specified (LINE, COLUMN)."
  (lambda (line column)
    (goto-char (point-min))
    (forward-line (- (string-to-number line) 1))
    (move-to-column (string-to-number column))))

(When "^I add \"\\(.\\)\" to trigger characters$"
  "Add CH to smart-semicolon-trigger-chars."
  (lambda (ch)
    (add-to-list 'smart-semicolon-trigger-chars (string-to-char ch))))

(When "^I add \"\\(.\\)\" to block characters$"
  "Add CH to smart-semicolon-block-chars."
  (lambda (ch)
    (add-to-list 'smart-semicolon-block-chars (string-to-char ch))))

(Then "^the cursor should be at cell (\\([0-9]+\\), *\\([0-9]+\\))$"
  "Checks that the cursor is at a specific (LINE, COLUMN)."
  (lambda (line column)
    (should (equal (cons (string-to-number line) (string-to-number column))
                   (cons (line-number-at-pos) (current-column))))))
