(global-set-key [f5] 'run-current-file)
(global-set-key [f6] 'compile)

(add-hook 'c++-mode-hook
          (lambda ()
            (unless (file-exists-p "Makefile")
              (set (make-local-variable 'compile-command)
                   (let ((file (file-name-nondirectory buffer-file-name)))
                     (format "%s -c -o %s %s %s"
                             (or (getenv "CC") "g++")
                             (file-name-sans-extension file)
                             (or (getenv "CFLAGS") "-ansi -pedantic -Wall -g")
                             file
                     )
                   )
              )
            )
          )
)

(defun run-current-file ()
"Compile and exec the standalone C program in current buffer."
(interactive)
;(let ((x (shell-quote-argument (buffer-file-name))))
;(let ((x (buffer-file-name)))
;(shell-command (concat "g++ -o " x "  " x " && ./" x)))

(let ((file (file-name-nondirectory buffer-file-name)))
  (shell-command (format " \"%s\" -o %s %s %s && ./%s"
                         (or (getenv "CC") "g++")
                         (file-name-sans-extension file)
                         (or (getenv "CFLAGS") "-ansi -Wno-long-long -Wall")
                         file
                         (file-name-sans-extension file)
                         )
                 )
  )
)


(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
