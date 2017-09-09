(require 'f)

(defvar smart-semicolon-support-path
  (f-dirname load-file-name))

(defvar smart-semicolon-features-path
  (f-parent smart-semicolon-support-path))

(defvar smart-semicolon-root-path
  (f-parent smart-semicolon-features-path))

(add-to-list 'load-path smart-semicolon-root-path)

;; Ensure that we don't load old byte-compiled versions
(let ((load-prefer-newer t))
  (require 'undercover)
  (undercover "smart-semicolon.el")

  (require 'smart-semicolon)
  (require 'espuds)
  (require 'ert))

(Setup
 ;; Before anything has run
 (setq debug-on-error nil)
 )

(Before
 ;; Before each scenario is run
 (switch-to-buffer
  (get-buffer-create "*smart-semicolon*"))
 (smart-semicolon-mode 1)
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )
