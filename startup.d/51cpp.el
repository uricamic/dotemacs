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
                         (or (getenv "CFLAGS") "-g -ansi -Wno-long-long -Wall")
                         file
                         (file-name-sans-extension file)
                         )
                 )
  )
)

;; (defun ska-skel-cc-class (name)
;;   "Insert a C++ class definition.
;;  It creates a matching header file, inserts the class definition and
;;  creates the  most important function templates in a named after the
;;  class name. This might still be somewhat buggy."
;;   (interactive "sclass name: ")
;;   (let* ((header-file-name (concat (downcase name) ".hh"))
;;          (header-include-string (upcase (concat name "_HH_INCLUDED")))
;;          (def-file-name    (concat (downcase name) ".cc")))

;;     ;; ;; write header file
;;     ;; (set-buffer (get-buffer-create header-file-name))
;;     ;; (set-visited-file-name header-file-name)
;;     ;; (c++-mode)
;;     ;; (turn-on-font-lock)
;;     ;; (insert (concat
;;     ;;          "// -*- C++ -*-\n"
;;     ;;          "// File: " header-file-name "\n//\n"
;;     ;;          "// Time-stamp: <>\n"
;;     ;;          "// $Id: $\n//\n"
;;     ;;          "// Copyright (C) "(substring (current-time-string) -4)
;;     ;;          " by " auto-insert-copyright "\n//\n"
;;     ;;          "// Author: " (user-full-name) "\n//\n"
;;     ;;          "// Description: \n// "
;;     ;;          ;; get this point...
;;     ;;          "\n\n"
;;     ;;          "# ifndef " header-include-string "\n"
;;     ;;          "# define " header-include-string "\n\n"
;;     ;;          "# include <iostream>\n\n"
;;     ;;          "class " name ";\n\n"
;;     ;;          "class " name " {\n"
;;     ;;          "public:\n"
;;     ;;          name "();" "\n"
;;     ;;          name "(const " name "& src);\n"
;;     ;;          "~" name "();" "\n"
;;     ;;          name "& operator=(const " name "& rv);\n"
;;     ;;          "\nprivate:\n"
;;     ;;          "void init();\n"
;;     ;;          "void reset();\n"
;;     ;;          "void init_and_copy(const " name "& src);\n\n"
;;     ;;          "protected: \n\n"
;;     ;;          "};"
;;     ;;          "\n\n# endif"))
;;     ;; (beginning-of-buffer)
;;     ;; (while (and (not (eobp)) (forward-line))
;;     ;;   (indent-according-to-mode))

;;     ;; create CC file
;;     (set-buffer (get-buffer-create def-file-name))
;;     (set-visited-file-name def-file-name)
;;     (switch-to-buffer (current-buffer))
;;     (c++-mode)
;;     (turn-on-font-lock)
;;     (insert (concat
;;              "// -*- C++ -*-\n"
;;              "// File: " def-file-name "\n//\n"
;;              "// Time-stamp: <>\n"
;;              "// $Id: $\n//\n"
;;              "// Copyright (C) "(substring (current-time-string) -4)
;;              " by " auto-insert-copyright "\n//\n"
;;              "// Author: " (user-full-name) "\n//\n"
;;              "// Description: \n// "
;;              "\n# include \"" header-file-name "\"\n\n"
;;              name "::\n" name "() {\ninit();\n}\n\n"
;;              name "::\n" name "(const " name "& src) {\ninit_and_copy(src);\n}\n\n"
;;              name "::\n~" name "() {\nreset();\n}\n\n"
;;              "void\n" name "::\ninit() {\n\n}\n\n"
;;              "void\n" name "::\nreset() {\n\n}\n\n"
;;              "void\n" name "::\ninit_and_copy(const " name "& src) {\n\n}\n\n"
;;              name "&\n" name "::\noperator=(const " name "& src) {\n\n}\n\n"
;;              ))
;;     (beginning-of-buffer)
;;     (while (and (not (eobp)) (forward-line))
;;       (indent-according-to-mode))
;;     (beginning-of-buffer)
;;     (search-forward "Description:")
;;     )
;;   )
