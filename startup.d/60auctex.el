
(load "auctex.el" nil t t)
;;(load "tex-site.el" nil t t)
;;(load "tex-style.el" nil t t)
(load "preview-latex.el" nil t t)

(require 'tex-mik)
;;(require 'tex-site)
;;(require 'tex-style)

(require 'auto-complete-auctex)
;;(setq ac-l-dict-directory "~/.emacs.d/3dparty/auto-complete/ac-dict/")
;;(add-to-list 'ac-modes 'foo-mode)
;;(add-hook 'foo-mode-hook 'ac-l-setup)


(setq TeX-auto-save t)
(setq TeX-parse-self t)

; ——————————————————————————————————————
; master file
; ——————————————————————————————————————
(setq-default TeX-master nil)


(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; (setq TeX-output-view-style
;;       (quote
;;        (("^pdf$" "." "evince -f %o")
;;         ("^html?$" "." "iceweasel %o"))))

;; (Set TeX-output-view-style
;;       (cons (list "^pdf$" "."
;;                   "emacsclient -n -e '(find-file-other-window \"%o\")'")
;;             TeX-output-view-style))

;; install ac-math


; ——————————————————————————————————————
; AC-MATH
;
(require 'ac-math)

(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of {{{latex-mode}}}

;; (defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
;;   (setq ac-sources
;;      (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
;;                ac-sources))
;; )

(defun ac-latex-mode-setup ()
  (setq ac-sources
     (append '(ac-source-math-latex  ac-source-latex-commands ac-source-math-unicode )
               ac-sources))
)

(add-hook 'LaTeX-mode-hook 'ac-latex-mode-setup)

;; activate unicode input (ac-source-math-unicode)
;;(setq ac-math-unicode-in-math-p t)


;; ;;; ———————— Template ——————————-
;; (setq load-path (cons (expand-file-name “~/.emacs.d/lisp”)
;; load-path))
;; (require ‘template)
;; (template-initialize)
;; ;;;; If you don’t want to use yasnippet, look download the tarball here :
;; ;;;; voir http://emacs-template.sourceforge.net/


; ——————————————————————————————————————
; Smart quotes
; http://www.emacswiki.org/emacs/AUCTeX#toc20
; ——————————————————————————————————————
(setq TeX-open-quote "<<") (setq TeX-close-quote ">>")


;; ; ——————————————————————————————————————
;; ; Wrapping the region in double quotes
;; ; http://www.emacswiki.org/emacs/AUCTeX#toc20
;; ; ——————————————————————————————————————
;; (defadvice TeX-insert-quote (around wrap-region activate)
;;   (cond
;;    (mark-active
;;     (let ((skeleton-end-newline nil))
;;       (skeleton-insert `(nil ,TeX-open-quote _ ,TeX-close-quote) -1)))
;;    ((looking-at (regexp-opt (list TeX-open-quote TeX-close-quote)))
;;     (forward-char (length TeX-open-quote)))
;;    (t
;;     ad-do-it)))
;; (put 'TeX-insert-quote 'delete-selection nil)


;; ; ——————————————————————————————————————
;; ; Automagic detection of master file
;; ; http://www.emacswiki.org/emacs/AUCTeX#toc20
;; ; ——————————————————————————————————————
;; (setq TeX-master (guess-TeX-master (buffer-file-name)))

;;  (defun guess-TeX-master (filename)
;;       "Guess the master file for FILENAME from currently open .tex files."
;;       (let ((candidate nil)
;;             (filename (file-name-nondirectory filename)))
;;         (save-excursion
;;           (dolist (buffer (buffer-list))
;;             (with-current-buffer buffer
;;               (let ((name (buffer-name))
;;                     (file buffer-file-name))
;;                 (if (and file (string-match "\\.tex$" file))
;;                     (progn
;;                       (goto-char (point-min))
;;                       (if (re-search-forward (concat "\\\\input{" filename "}") nil t)
;;                           (setq candidate file))
;;                       (if (re-search-forward (concat "\\\\include{" (file-name-sans-extension filename) "}") nil t)
;;                           (setq candidate file))))))))
;;         (if candidate
;;             (message "TeX master document: %s" (file-name-nondirectory candidate)))
;;         candidate))
