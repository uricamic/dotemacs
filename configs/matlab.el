;; http://blogs.mathworks.com/community/2009/09/14/matlab-emacs-integration-is-back

(load-library "~/.emacs.d/3dparty/matlab-emacs/matlab-load.el")
(require 'matlab-load)

(custom-set-variables
 '(matlab-shell-command-switches '("-nodesktop -noslpash -nojvm")))

(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list
 'auto-mode-alist
 '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")

(matlab-cedet-setup)

;; User Level customizations (You need not use them all):
(setq matlab-indent-function-body t)  ; if you want function bodies indented
(setq matlab-verify-on-save-flag nil) ; turn off auto-verify on save
(defun my-matlab-mode-hook ()
  (setq fill-column 76))       ; where auto-fill should wrap
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
(defun my-matlab-shell-mode-hook ()
  '())
(add-hook 'matlab-shell-mode-hook 'my-matlab-shell-mode-hook)

(global-font-lock-mode t)

;;  To get hilit19 support try adding:
;; (matlab-mode-hilit)

;; Jimmy's configuration
;; ;; --- MATLAB MODE ---
;; (load-library "~/.emacs.d/3dparty/matlab-emacs/matlab-load.el")

;; (when (fboundp 'winner-mode)
;;   (winner-mode 1))
;; (put 'erase-buffer 'disabled nil)

;; (setq tags-revert-without-query 1)
;; ;;(defalias 'yes-or-no-p 'y-or-n-p)

;; ;; (setq tags-table-list
;; ;;       '("/home.stud/prittjam/src/cvtk2" "/home.stud/prittjam/src/cvdb" "/home.stud/prittjam/src/wbs" "/home.stud/prittjam/src/repeat" "/home.stud/prittjam/src/repeat" "/home.stud/prittjam/src/courses/w2010/ae4m33tdv"))

;; (require 'ctags-update)
;; (ctags-update-minor-mode 1)

;; ;;;---------------------------------------------------------------------
;; ;;; display-buffer

;; ;; The default behaviour of `display-buffer' is to always create a new
;; ;; window. As I normally use a large display sporting a number of
;; ;; side-by-side windows, this is a bit obnoxious.
;; ;;
;; ;; The code below will make Emacs reuse existing windows, with the
;; ;; exception that if have a single window open in a large display, it
;; ;; will be split horisontally.

;; (setq pop-up-windows nil)

;; (defun my-display-buffer-function (buf not-this-window)
;;   (if (and (not pop-up-frames)
;;            (one-window-p)
;;            (or not-this-window
;;                (not (eq (window-buffer (selected-window)) buf)))
;;            (> (frame-width) 162))
;;       (split-window-horizontally))
;;   ;; Note: Some modules sets `pop-up-windows' to t before calling
;;   ;; `display-buffer' -- Why, oh, why!
;;   (let ((display-buffer-function nil)
;;         (pop-up-windows nil))
;;     (display-buffer buf not-this-window)))

;; (setq display-buffer-function 'my-display-buffer-function)
