(setenv "PYMACS_PYTHON" "python")

(require 'pymacs)

(require 'python)

(require 'pysmell)
(add-hook 'python-mode-hook (lambda () (pysmell-mode 1)))

(require 'helm-config)

;(setq python-shell-interpreter "ipython")

;(load-file "~/.emacs.d/vendor/cedet/cedet-devel-load.el")
;(load-file "/usr/local/share/emacs/24.0.92/lisp/cedet/cedet.el")

;(require 'cedet)

;(require 'ecb)

;(require 'ecb-autoloads)


(setq
python-shell-interpreter "ipython"
python-shell-interpreter-args ""
python-shell-prompt-regexp "In \\[[0-9]+\\]: "
python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
python-shell-completion-setup-code
  "from IPython.core.completerlib import module_completion"
python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
python-shell-completion-string-code
  "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;(require 'python-mode)
;(setq py-shell-name "ipython")

;(setq
;python-shell-interpreter "ipython"
;python-shell-interpreter-args ""
;python-shell-prompt-regexp "In \[[0-9]+\]: "
;python-shell-prompt-output-regexp "Out\[[0-9]+\]: "
;python-shell-completion-setup-code ""
;python-shell-completion-string-code
;"';'.join(__IP.complete('''%s'''))\n")


;(setq ipython-command "/usr/bin/ipython")
;(require 'ipython)
;(setq python-python-command "ipython")
;(defadvice py-execute-buffer (around python-keep-focus activate)
;  "return focus to python code buffer"
;  (save-excursion ad-do-it))

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(pymacs-load "ropemacs" "rope-")
(setq ropemacs-codeassist-maxfixes 5
      ropemacs-guess-project t
      ropemacs-enable-autoimport t
      ropemacs-completing-read-function 'completing-read)

(defun try-complete-ropemacs (old)
  (save-excursion
    (unless old
      (he-init-string (he-dabbrev-beg) (point))
      (when (not (equal he-search-string ""))
        (setq he-expand-list
              (sort (all-completions
                     he-search-string
                     (delete-duplicates
                      (mapcar
                       (lambda (completion)
                         (concat he-search-string
                                 (replace-regexp-in-string
                                  "^[\r\n\t ]+\\|[\r\n\t ]+$" ""
                                  (nth 0 (split-string completion ":")))))
                       (ignore-errors
                         (rope-completions)))
                      :test 'string=))
                    'string-lessp))))
    (while (and he-expand-list
                (he-string-member (car he-expand-list) he-tried-table))
      (setq he-expand-list (cdr he-expand-list)))
    (if (null he-expand-list)
        (progn (if old (he-reset-string)) ())
      (progn
        (he-substitute-string (car he-expand-list))
        (setq he-tried-table (cons (car he-expand-list)
                                   (cdr he-tried-table)))
        t))))


(remove-hook 'python-mode-hook 'ac-ropemacs-setup)
(setq ac-ropemacs-completions-cache nil)
(setq ac-source-ropemacs
  '((init
     . (lambda ()
         (setq ac-ropemacs-completions-cache
               (delete-duplicates
                (mapcar
                 (lambda (completion)
                   (concat ac-prefix
                           (replace-regexp-in-string
                            "^[\r\n\t ]+\\|[\r\n\t ]+$" ""
                            (nth 0 (split-string completion ":")))))
                 (ignore-errors
                   (rope-completions)))
                :test 'string=))))
    (symbol . "p")
    (candidates . ac-ropemacs-completions-cache)))

(remove-hook 'python-mode-hook 'wisent-python-default-setup)

(defun python-setup ()
  (set (make-local-variable 'hippie-expand-try-functions-list)
       '(yas/hippie-try-expand
         try-complete-file-name
         try-complete-ropemacs))
  (setq ac-sources
        '(ac-source-ropemacs ac-source-yasnippet ac-source-filename)))

(add-hook 'python-mode-hook 'python-setup)

(setq pdb-path '/usr/lib/python2.7/pdb.py
      gud-pdb-command-name (symbol-name pdb-path))

(defadvice pdb (before gud-query-cmdline activate)
  "Provide a better default command line when called interactively."
  (interactive
   (list (gud-query-cmdline
          pdb-path (file-name-nondirectory buffer-file-name)))))

;; MY

(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()"))

(add-hook 'python-mode-hook 'annotate-pdb)

(defun python-add-breakpoint ()
  (interactive)
  (py-newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

;(define-key py-mode-map (kbd "C-c C-t") 'python-add-breakpoint)
