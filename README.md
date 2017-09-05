Smart Semicolon
===============

[![Build Status](https://travis-ci.org/iquiw/smart-semicolon.svg?branch=master)](https://travis-ci.org/iquiw/smart-semicolon)
[![Coverage Status](https://coveralls.io/repos/github/iquiw/smart-semicolon/badge.svg?branch=master)](https://coveralls.io/github/iquiw/smart-semicolon?branch=master)

About
-----

This is a minor mode to insert semicolon smartly, like Eclipse does.

When `smart-semicolon-mode` is enabled, typing <kbd>;</kbd> inserts
semicolon at the end of line if there is no semicolon there.

If there is semicolon at the end of line, typing <kbd>;</kbd> inserts
semicolon at the point.

After smart semicolon insert, backspace command reverts the behavior as if
<kbd>;</kbd> is inserted normally.


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

To enable the same behavior for other character than semicolon, add the
character into `smart-semicolon-trigger-chars`.

``` emacs-lisp
(add-to-list 'smart-semicolon-trigger-chars ?:)
```

To treat some command as backspace command, add the command to
`smart-semicolon-backspace-commands`.

```
(add-to-list 'smart-semicolon-backspace-commands 'my-backspace)
```

License
-------

Licensed under the GPL 3+ license.
