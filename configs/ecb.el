
(add-to-list 'load-path "~/.emacs.d/3dparty/ecb-2.40")
(load-file "~/.emacs.d/3dparty/ecb-2.40/ecb.el")

(setq ecb-tip-of-the-day nil)
(setq stack-trace-on-error t)

(require 'ecb)
;;(require 'ecb-autoloads)

;; Shift + Down moves to the buffer below http://www.emacswiki.org/emacs/WindMove
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

;;(defconst ecb-cedet-required-version-max '(1 1 3 3))
