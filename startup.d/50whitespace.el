(require 'whitespace)
;(set 'whitespace-style '(trailing tabs lines-tail indentation::space face))
;(setq whitespace-global-modes
;      '(c-mode c++-mode emacs-lisp-mode
;               python-mode lisp-mode))

(setq whitespace-style
  '(empty lines-tail tabs tab-mark trailing))

(global-whitespace-mode 1)
