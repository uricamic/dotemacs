(add-to-list 'load-path "~/.emacs.d/3dparty")
(let ((default-directory "~/.emacs.d/3dparty"))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes/solarized-emacs")


;;(ignore-errors (load-file "~/.emacs.d/secrets.el"))
;;(ignore-errors (load-file "~/.emacs.d/pre-startup.el"))

(load-file "~/.emacs.d/startup.el")

;;(ignore-errors (load-file "~/.emacs.d/post-startup.el"))

(setq custom-file "~/.emacs.d/customizations.el")
(load custom-file 'noerror)
(put 'set-goal-column 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
