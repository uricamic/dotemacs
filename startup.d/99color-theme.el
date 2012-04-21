;(when (boundp 'custom-safe-themes)
;  (load-theme 'misterioso t))


;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-tm)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/solarized-emacs")
(require 'solarized-theme)
(load-theme 'solarized-dark t)