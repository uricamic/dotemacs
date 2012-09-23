(require 'whitespace)
;(set 'whitespace-style '(trailing tabs lines-tail indentation::space face))
;(setq whitespace-global-modes
;      '(c-mode c++-mode emacs-lisp-mode
;               python-mode lisp-mode))

(setq whitespace-style
  '(empty lines-tail tabs tab-mark trailing))

(global-whitespace-mode 1)


;; http://habrahabr.ru/post/151653/
;; space mode
(setq indent-tabs-mode nil) ;

;; устанавливаем ширину таба в 4 символа
(setq tab-width 4)
(setq c-basic-offset 4)
(setq sgml-basic-offset 4)

; ширина таба 4, индентация табами
(add-hook 'python-mode-hook
  (lambda()
    (setq tab-width 4)
    (setq indent-tabs-mode t)
))
