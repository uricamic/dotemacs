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


;;;;;;;;;;;;;;;;;;;;;;
(setq c-default-style "linux" c-basic-offset 4)

(require 'google-c-style)

(add-hook 'c-mode-common-hook 'google-set-c-style)
