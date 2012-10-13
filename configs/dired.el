;; Extracted from http://www.emacswiki.org/emacs/dired-extension.el
(defun dired-gnome-open-file ()
  "Opens the current file in a Dired buffer."
  (interactive)
  (gnome-open-file (dired-get-file-for-visit)))

(defun gnome-open-file (filename)
  "gnome-opens the specified file."
  (interactive "fFile to open: ")
  (let ((process-connection-type nil))
    (start-process "" nil "/usr/bin/gnome-open" filename)))

(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key "E" 'dired-gnome-open-file)))

;; single dired buffer
;;(eval-after-load 'dired '(progn (require 'joseph-single-dired)))
(add-hook 'dired-mode-hook
 (lambda ()
  (define-key dired-mode-map (kbd "<return>")
    'dired-find-alternate-file) ; was dired-advertised-find-file
  (define-key dired-mode-map (kbd "^")
    (lambda () (interactive) (find-alternate-file "..")))
  ; was dired-up-directory
 ))
;; instill dired+
(require 'dired+)


;; allow dired to be able to delete or copy a whole dir.
;; “always” means no asking. “top” means ask once. Any other symbol means ask each and every time for a dir and subdir.
(setq dired-recursive-copies (quote always))
(setq dired-recursive-deletes (quote top))

;; copy from one dired dir to the next dired dir shown in a split window
(setq dired-dwim-target t)
