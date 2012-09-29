

;;(setq gdb-non-stop-setting t)

;;(load "cdb-gud")
;;(load-library "multi-gud.el")
;;(load-library "multi-gdb-ui.el")

;; http://code.google.com/p/my-emacs-config/source/browse/trunk/settings/cc-dev-settings.el?r=2

(add-hook 'gdb-mode-hook '(lambda ()
                            (gdb-many-windows t)
                            ;; (tabbar-mode nil)
                            (tool-bar-mode t)
                            (fullscreen)
                            ;; (menu-bar-mode nil)
                            )
          )


;;;;; new

(defun gdb-run ()
  "If gdb isn't running; run gdb, else call gud-go."
  (interactive)
;;  (sr-speedbar-close)
  (compile (concat "g++ " (buffer-name (current-buffer)) " -g -pg -o debug_main"))
  (gdb "gdb -i=mi ./debug_main")
  )


(defun gdb-or-gud-go2 ()
  "If gdb isn't running; run gdb, else call gud-go."
  (interactive)
                                        ;(sr-speedbar-close)
  (if (and gud-comint-buffer
           (buffer-name gud-comint-buffer)
           (get-buffer-process gud-comint-buffer)
           (with-current-buffer gud-comint-buffer (eq gud-minor-mode 'gdba)))
      (gud-call (if gdb-active-process "continue" "run") "") ;;then part
    ;;else part
    (gdb-run)
    );;end:if
  )

(defun gdb-or-gud-go ()
  "If gdb isn't running; run gdb, else call gud-go."
  (interactive)
  (if (and gud-comint-buffer
           (buffer-name gud-comint-buffer)
           (get-buffer-process gud-comint-buffer)
           (with-current-buffer gud-comint-buffer (eq gud-minor-mode 'gdba))) ;;if part
      ;;then part
      (funcall (lambda ()
                 (gud-call (if gdb-active-process "continue" "run") "")
                 (speedbar-update-contents)
                 )
               )
    ;;else part
    (funcall(lambda ()
              (sr-speedbar-close)
              (gdb (gud-query-cmdline 'gdba)))
            )
    );;end:if
  )

(defun gud-break-remove ()
  "Set/clear breakpoin."
  (interactive)
  (save-excursion
    (if (eq (car (fringe-bitmaps-at-pos (point))) 'breakpoint)
        (gud-remove nil)
      (gud-break nil))))


(defun kill-other-buffers (buffer-list)
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer
        (delq (current-buffer)
              (remove-if 'buffer-file-name (buffer-list)))))

(defun gud-kill ()
  "Kill gdb process."
  (interactive)
  (tool-bar-mode -1)
  (with-current-buffer gud-comint-buffer (comint-skip-input))
 (kill-process (get-buffer-process gud-comint-buffer))
;;  (sleep-for 1)

  (kill-buffer (buffer-name gud-comint-buffer))
  (delete-other-windows)
;;  (if need-restory-nextide-panel (nextide-panel-toggle))
;;  (speedbar-change-initial-expansion-list "files")

  (defvar buffer-list nil)

  (dolist (item  '("*gud-" "*stack frames of "  "*locals of " "*threads of " "*input/output of " "*breakpoints of "))
    (setq buffer-list (cons (concat item "debug_main*") buffer-list))
    )

  (setq buffer-list (cons "*Buffer List*" buffer-list))
  (setq buffer-list (cons "*compilation*" buffer-list))

  ;;   (message "%S" buffer-list)
  ;;  (funcall kill-other-buffers 'buffer-list)
;;  (apply 'kill-buffer buffer-list)
;;  (mapc 'kill-buffer
;;        (delq (current-buffer)
;;              (remove-if 'buffer-file-name (buffer-list))))

  (mapc 'kill-buffer buffer-list)
  )

(defun gdb-key-settings ()
  "If gdb isn't running; run gdb, else call gud-go."
  (interactive)
  (global-set-key [f5] 'gdb-run)    ;;F5
  (global-set-key [S-f5] 'gud-kill)       ;;shift+f5

  (global-set-key [(f8)] 'gud-until)      ;;F8

  (global-set-key [f1] 'gud-watch)        ;;f9
  (global-set-key [f9] 'gud-break-remove) ;;f9
  (global-set-key [f10] 'gud-next)        ;;f10 next
  (global-set-key [f11] 'gud-step)        ;;f11:setup-into
  (global-set-key [S-f11] 'gud-finish)    ;;shift+f11:setup-out
  (global-set-key [(f12)] 'speedbar-update-contents)      ;;F12 speedbar
  )

(add-hook 'c++-mode-hook 'gdb-key-settings)
(add-hook 'cc-mode-hook 'gdb-key-settings)
(add-hook 'c-mode-hook 'gdb-key-settings)
(add-hook 'gdb-mode-hook 'gdb-key-settings)

;; (defvar gud-overlay
;;   (let* ((ov (make-overlay (point-min) (point-min))))
;;     (overlay-put ov 'face 'secondary-selection)
;;     ov)
;;   "Overlay variable for GUD highlighting.")

;; (defun gud-kill-buffer ()
;;   (if (eq major-mode 'gud-mode)
;;       (delete-overlay gud-overlay)))

;; (add-hook 'kill-buffer-hook 'gud-kill-buffer)


(defun kill-buffer-when-gdb-command-quit ()
  "Close current buffer when `shell-command' exit."

  (defvar buffer-list nil)

  (dolist (item  '("*stack frames of "  "*locals of " "*threads of " "*breakpoints of " "*compilation of "))
    (setq buffer-list (cons (concat item "debug_main*") buffer-list))
    )

  (let ((process (ignore-errors (get-buffer-process (current-buffer)))))
    (when process
      (set-process-sentinel process
                            (lambda (proc change)
                              (when (string-match "\\(finished\\|exited\\Debugger\\)" change)   ;;(when (string-match "\\(finished\\|exited\\)" change)
                                (tool-bar-mode -1)
                                (gdb-many-windows nil)
                                (kill-buffer (process-buffer proc))
                                )
                              )
                            )
      )
    )

  (funcall kill-other-buffers buffer-list)
  )


;;(add-hook 'gdb-mode-hook 'kill-buffer-when-gdb-command-quit)
;;(add-hook 'c-mode-hook 'kill-buffer-when-gdb-command-quit)
