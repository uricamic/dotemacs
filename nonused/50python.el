;(setenv "PYMACS_PYTHON" "python2.7")

(require 'pymacs)
(require 'python)

(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

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


(setq py-load-pymacs-p nil)

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

;(autoload 'pymacs-load "ropemacs" "rope-")
;(setq ropemacs-enable-autoimport t)

(setq python-check-command "pyflakes")


;(require 'auto-complete)
;(global-auto-complete-mode t)


(require 'pysmell)
(add-hook 'python-mode-hook (lambda () (pysmell-mode 1)))