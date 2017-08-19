Smart Semicolon
===============

About
-----

This is a minor mode to insert semicolon smartly, like Eclipse does.

When `smart-semicolon-mode` is enabled, typing <kbd>;</kbd> inserts
semicolon at the end of line if there is no semicolon there.

If there is semicolon at the end of line, typing <kbd>;</kbd> inserts
semicolon at the point.

Setup
-----

### Depends ###

* Emacs 25

### Installation ###

Clone the repository from GitHub.

``` console
$ git clone https://github.com/iquiw/smart-semicolon.git
```

Add the directory to `load-path` and require `smart-semicolon`.

``` emacs-lisp
(add-to-list 'load-path "/path/to/smart-semicolon")
(require 'smart-semicolon)
```

### Configuration

Add `smart-semicolon-mode` to some major mode hooks where you want to
enable `smart-semicolon`.

``` emacs-lisp
(add-hook 'c-mode-common-hook #'smart-semicolon-mode)
```

License
-------

Licensed under the GPL 3+ license.
