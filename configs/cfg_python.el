;;; python-mode site-lisp configuration

(require 'compile)


(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.doctest$" . doctest-mode))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(autoload 'doctest-mode "doctest-mode" "Editing mode for Python Doctest examples." t)
;; (require 'pycomplete)


;; pymacs & rope
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

;; AV: save place and rope-goto-definition
(defun rope-goto-definition-save-place ()
  """ save current place as 'save-place' bookmark and rope-goto-definition """
  (interactive)
  (bookmark-set "save-place" 1)
  (rope-goto-definition)
  )

;; AV: return to saved place of rope-goto-definition-save-place
(defun rope-return ()
  """ save current place as 'save-place' bookmark and rope-goto-definition """
  (interactive)
  (bookmark-jump "save-place")
  )

(global-set-key [(M return)] 'rope-goto-definition-save-place)
(global-set-key [(M shift return)] 'rope-return)

;; (require 'gpycomplete)

;; pylint
(require 'python-pylint)
(global-set-key (kbd "C-c p l") 'pylint)

;; pep8
(require 'python-pep8)
(global-set-key (kbd "C-c p 8") 'pep8)

;; moving blocks around
(defun unindent-dwim (&optional count-arg)
  "Keeps relative spacing in the region.  Unindents to the next multiple of the current tab-width"
  (interactive)
  (let ((deactivate-mark nil)
        (beg (or (and mark-active (region-beginning)) (line-beginning-position)))
        (end (or (and mark-active (region-end)) (line-end-position)))
        (min-indentation)
        (count (or count-arg 1)))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (add-to-list 'min-indentation (current-indentation))
        (forward-line)))
    (if (< 0 count)
        (if (not (< 0 (apply 'min min-indentation)))
            (error "Can't indent any more.  Try `indent-rigidly` with a negative arg.")))
    (if (> 0 count)
        (indent-rigidly beg end (* (- 0 tab-width) count))
      (let (
            (indent-amount
             (apply 'min (mapcar (lambda (x) (- 0 (mod x tab-width))) min-indentation))))
        (indent-rigidly beg end (or
                                 (and (< indent-amount 0) indent-amount)
                                 (* (or count 1) (- 0 tab-width))))))))

(defun indent-dwim ()
  "Reverse back unindent-dwim"
  (interactive)
  (unindent-dwim -1)
  (unindent-dwim)
  )


(defun py-to-start-of-class()
  (interactive)
  (py-beginning-of-def-or-class 'class)
  )

(defun py-to-end-of-class()
  (interactive)
  (py-end-of-def-or-class 'class)
  )

(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key [(s menu)] 'rope-code-assist)
             (local-set-key [(s up)] 'python-move-to-start-of-class)
             (local-set-key [(s down)] 'python-move-to-end-of-class)
             (local-set-key [(meta down)] 'py-end-of-def-or-class)
             (local-set-key [(meta up)] 'py-beginning-of-def-or-class)
             (local-set-key (kbd "C-c C-a") 'py-to-start-of-class)
             (local-set-key (kbd "C-c C-e") 'py-to-end-of-class)
             (local-set-key (kbd "s-q") 'py-shift-region-left)
             (local-set-key (kbd "s-w") 'py-shift-region-right)
             )
          )


(fset 'macro-ugettext_new
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 114 105 97 right right right] 0 "%d")) arg)))



(fset 'macro-ugettextlazy
      [?_ ?\( ?\C-s ?\' ?\C-s right left ?\) left left ?\C-r ?\' left left])

(fset 'python-move-to-start-of-class
      [(menu-bar) Python Go\ to\ start\ of\ class])

(fset 'python-move-to-end-of-class
      [(menu-bar) Python Move\ to\ end\ of\ class])


                                        ;; folding?
                                        ;; this get called after python mode is enabled
;; (add-hook 'python-mode-hook 'outline-minor-mode)
;; (setq outline-minor-mode-prefix (kbd "C-;"))
