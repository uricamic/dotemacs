;; ;; predictive install location
;; (add-to-list 'load-path "~/.emacs.d/predictive/")
;; ;; dictionary locations
;; (add-to-list 'load-path "~/.emacs.d/predictive/latex/")
;; (add-to-list 'load-path "~/.emacs.d/predictive/texinfo/")
;; (add-to-list 'load-path "~/.emacs.d/predictive/html/")

;; (require 'predictive)

;; predictive install location
(add-to-list 'load-path "~/.emacs.d/3dparty/predictive/")
;; dictionary locations
(add-to-list 'load-path "~/.emacs.d/3dparty/predictive/latex/")
(add-to-list 'load-path "~/.emacs.d/3dparty/predictive/texinfo/")
(add-to-list 'load-path "~/.emacs.d/3dparty/predictive/html/")
;; load predictive package
;(autoload 'predictive-mode "~/.emacs.d/predictive/predictive"
; "Turn on Predictive Completion Mode." t)

(require 'predictive)

;;I prefer loading libraries when I use them, not when I start Emacs.
;(autoload 'predictive-mode "predictive" "predictive" t)

;;I don’t understand why this variable is “buffer-local whenever it is set.” This confused me to no end when I tried to get it to work.
(set-default 'predictive-auto-add-to-dict t)


(setq predictive-main-dict 'rpg-dictionary
      predictive-auto-learn t
      predictive-add-to-dict-ask nil
      predictive-use-auto-learn-cache nil
      predictive-which-dict t)

(setq auto-completion-mode t)
(setq predictive-mode t)

;;
;;predictive-main-dict
;;I don’t want to use the default dictionary. I created it using ‘M-x predictive-create-dict rpg-dictionary RET ~/elisp/rpg-dictionary RET’ (where ~/elisp is on my ‘load-path’, obviously).

;;predictive-auto-learn
;;Yep, learn as I type.

;;predictive-add-to-dict-ask
;;I might switch this on again later when the dictionary is 99.5% complete. It’s a trade-off: Learn typos, or aggravate me? Maybe it should only learn if ispell doesn’t know the word…

;;predictive-use-auto-learn-cache
;;When I started using it, I had a hard time verifying that it worked. This setting can probably be removed after a while. Then again, I’m not sure whether Emacs on IRC is considered idle for long enough…


;;predictive-which-dict
;;Another debugging aid. This makes sure you see what dictionary Predictive Mode is using. Just wanting to make sure it’s using my new dictionary and not the default English dictionary. This setting can probably be removed after a while.
