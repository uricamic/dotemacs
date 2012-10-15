
(setq py-install-directory "~/.emacs.d/3dparty/python-mode/")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)
(setq py-load-pymacs-p t)


(require 'auto-complete-config)
(ac-config-default)

;; doen't work autocompletion
;; (require 'ipython)
;; (setq py-shell-name "/usr/bin/ipython")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'pysmell)
;; (add-hook 'python-mode-hook (lambda () (pysmell-mode 1)))

;; (require 'helm-config)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter-args ""
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;  python-shell-completion-setup-code
;;  "from IPython.core.completerlib import module_completion"
;;  python-shell-completion-module-string-code
;;  "';'.join(module_completion('''%s'''))\n"
;;  python-shell-completion-string-code
;;  "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; ;; (setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.complete('%s')[1])) #PYTHON-MODE SILENT\n")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq
;;  python-shell-interpreter "ipython"
;;  python-shell-interpreter-args ""
;;  python-shell-prompt-regexp "In \[[0-9]+\]: "
;;  python-shell-prompt-output-regexp "Out\[[0-9]+\]: "
;;  python-shell-completion-setup-code ""
;;  python-shell-completion-string-code
;;  "';'.join(__IP.complete('''%s'''))\n")


;; (setq ipython-command "/usr/bin/ipython")
;; (require 'ipython)
;; (setq python-python-command "ipython")
;; (defadvice py-execute-buffer (around python-keep-focus activate)
;;  "return focus to python code buffer"
;;  (save-excursion ad-do-it))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; http://pymacs.progiciels-bpi.ca/pymacs.html

;;(setenv "PYMACS_PYTHON" "python2.7")
;; (setenv "PYMACS_PYTHON" "python2.7") helped to fix problem with
;; pymacs helper didn't start within 30 minutes
(require 'pymacs)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;; (pymacs-load "ropemacs" "rope-")
(setq ropemacs-codeassist-maxfixes 5
      ropemacs-guess-project t
     ropemacs-enable-autoimport t
      ropemacs-completing-read-function 'completing-read)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ; AV: save place and rope-goto-definition
;; (defun rope-goto-definition-save-place ()
;;    """ save current place as 'save-place' bookmark and rope-goto-definition """
;;    (interactive)
;;    (bookmark-set "save-place" 1)
;;    (rope-goto-definition)
;; )

;; ; AV: return to saved place of rope-goto-definition-save-place
;; (defun rope-return ()
;;    """ save current place as 'save-place' bookmark and rope-goto-definition """
;;    (interactive)
;;    (bookmark-jump "save-place")
;; )

;; (global-set-key [(M return)] 'rope-goto-definition-save-place)
;; (global-set-key [(M shift return)] 'rope-return)


;; (defun try-complete-ropemacs (old)
;;   (save-excursion
;;     (unless old
;;       (he-init-string (he-dabbrev-beg) (point))
;;       (when (not (equal he-search-string ""))
;;         (setq he-expand-list
;;               (sort (all-completions
;;                      he-search-string
;;                      (delete-duplicates
;;                       (mapcar
;;                        (lambda (completion)
;;                          (concat he-search-string
;;                                  (replace-regexp-in-string
;;                                   "^[\r\n\t ]+\\|[\r\n\t ]+$" ""
;;                                   (nth 0 (split-string completion ":")))))
;;                        (ignore-errors
;;                          (rope-completions)))
;;                       :test 'string=))
;;                     'string-lessp))))
;;     (while (and he-expand-list
;;                 (he-string-member (car he-expand-list) he-tried-table))
;;       (setq he-expand-list (cdr he-expand-list)))
;;     (if (null he-expand-list)
;;         (progn (if old (he-reset-string)) ())
;;       (progn
;;         (he-substitute-string (car he-expand-list))
;;         (setq he-tried-table (cons (car he-expand-list)
;;                                    (cdr he-tried-table)))
;;         t))))


;; (remove-hook 'python-mode-hook 'ac-ropemacs-setup)
;; (setq ac-ropemacs-completions-cache nil)
;; (setq ac-source-ropemacs
;;       '((init
;;          . (lambda ()
;;              (setq ac-ropemacs-completions-cache
;;                    (delete-duplicates
;;                     (mapcar
;;                      (lambda (completion)
;;                        (concat ac-prefix
;;                                (replace-regexp-in-string
;;                                 "^[\r\n\t ]+\\|[\r\n\t ]+$" ""
;;                                 (nth 0 (split-string completion ":")))))
;;                      (ignore-errors
;;                        (rope-completions)))
;;                     :test 'string=))))
;;         (symbol . "p")
;;         (candidates . ac-ropemacs-completions-cache)))

;; (remove-hook 'python-mode-hook 'wisent-python-default-setup)

;; (defun python-setup ()
;;   (set (make-local-variable 'hippie-expand-try-functions-list)
;;        '(yas/hippie-try-expand
;;          try-complete-file-name
;;          try-complete-ropemacs))
;;   (setq ac-sources
;;         '(ac-source-ropemacs ac-source-yasnippet ac-source-filename)))

;; (add-hook 'python-mode-hook 'python-setup)

;; (setq pdb-path '/usr/lib/python2.7/pdb.py
;;       gud-pdb-command-name (symbol-name pdb-path))

;; (defadvice pdb (before gud-query-cmdline activate)
;;   "Provide a better default command line when called interactively."
;;   (interactive
;;    (list (gud-query-cmdline
;;           pdb-path (file-name-nondirectory buffer-file-name)))))

;; ;; MY

;; (defun annotate-pdb ()
;;   (interactive)
;;   (highlight-lines-matching-regexp "import pdb")
;;   (highlight-lines-matching-regexp "pdb.set_trace()"))

;; (add-hook 'python-mode-hook 'annotate-pdb)

;; (defun python-add-breakpoint ()
;;   (interactive)
;;   (py-newline-and-indent)
;;   (insert "import ipdb; ipdb.set_trace()")
;;   (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

;;                                         ;(define-key py-mode-map (kbd "C-c C-t") 'python-add-breakpoint)


;; ;; python code navigation

;; (defun py-to-start-of-class()
;;   (interactive)
;;   (py-beginning-of-def-or-class 'class)
;;   )

;; (defun py-to-end-of-class()
;;   (interactive)
;;   (py-end-of-def-or-class 'class)
;;   )

;; (add-hook 'python-mode-hook
;;           '(lambda ()
;;              (local-set-key [(s menu)] 'rope-code-assist)
;;              (local-set-key [(s up)] 'python-move-to-start-of-class)
;;              (local-set-key [(s down)] 'python-move-to-end-of-class)
;;              (local-set-key [(meta down)] 'py-end-of-def-or-class)
;;              (local-set-key [(meta up)] 'py-beginning-of-def-or-class)
;;              (local-set-key (kbd "C-c C-a") 'py-to-start-of-class)
;;              (local-set-key (kbd "C-c C-e") 'py-to-end-of-class)
;;              (local-set-key (kbd "s-q") 'py-shift-region-left)
;;              (local-set-key (kbd "s-w") 'py-shift-region-right)
;;              )
;;           )
