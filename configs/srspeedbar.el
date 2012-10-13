
;; sr-speedbar instalation
(require 'sr-speedbar)
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

;; default to a small font so that one can get a better overview over large code bases easily
(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Inconsolata-10")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

;; ;; keep speed bar window width after resizing
;; ;; http://www.emacswiki.org/emacs/SrSpeedbar#toc2
;; (with-current-buffer sr-speedbar-buffer-name
;;   (setq window-size-fixed 'width))

;; suppose 2 windows opened, in either of them ^ X 1,
;; there is still chance to select the SPEEDBAR window to be active,
;; which is not usually the user want – the user want the original window be selected
(defadvice delete-other-windows (after my-sr-speedbar-delete-other-window-advice activate)
  "Check whether we are in speedbar, if it is, jump to next window."
  (let ()
	(when (and (sr-speedbar-window-exist-p sr-speedbar-window)
               (eq sr-speedbar-window (selected-window)))
      (other-window 1)
	)))
(ad-enable-advice 'delete-other-windows 'after 'my-sr-speedbar-delete-other-window-advice)
(ad-activate 'delete-other-windows)
