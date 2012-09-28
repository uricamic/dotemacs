
(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/3dparty/emacs-clang-complete-async/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
)

;;(defun my-ac-config ()
  (add-hook 'c++-mode-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t)
;;)

;;(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;(my-ac-config)
