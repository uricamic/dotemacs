(add-to-list 'load-path "~/.emacs.d/3dparty/python-mode") 
(setq py-install-directory "~/.emacs.d/3dparty/python-mode")

(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(setq py-shell-name "ipython")

(setq py-shell-name "/usr/bin/ipython")

(setq py-load-pymacs-p nil)

(require 'python-mode)

;(pymacs-load "ropemacs" "rope-")
;(setq ropemacs-enable-autoimport t)