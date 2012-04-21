


;; versiontaken from https://github.com/emacsmirror/ecb.git
(add-to-list 'load-path "~/.emacs.d/vendor/ecb")



;;(load-file "ecb.el")
;;;(require 'ecb)

;;;only for emacs24, cite: http://lists.gnu.org/archive/html/help-gnu-emacs/2011-09/msg00192.html

;(setq ecb-cedet-required-version-max '(1 1 0 0))
;; disable tip of the day
(setq ecb-tip-of-the-day nil)

(setq stack-trace-on-error t)
(require 'ecb)
(ecb-activate)
;(ecb-byte-compile) ;; this need only for the first run.
; it's better to do it from emacs, not by uncomenting this line

;; Shift + Down moves to the buffer below http://www.emacswiki.org/emacs/WindMove
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))




;; this doesn't work
;(set-face-foreground (quote ecb-default-highlight-face) "DimGrey")
;(set-face-background (quote ecb-default-highlight-face) "grey70")


;(add-to-list 'load-path "/usr/share/emacs/site-lisp/ecb")
;(require 'ecb)
;(require 'ecb-autoloads)
;(setq stack-trace-on-error t)