;; debug by printing to console
(require 'll-debug)
(setcdr (assq 'c++-mode ll-debug-statement-alist)
        (cdr (assq 'c-mode ll-debug-statement-alist)))


(global-set-key [C-f5] 'run-current-file)
(global-set-key [C-f6] 'quick-compile)

;;------------------------------------------------------------------------------
;; compile-command
;;------------------------------------------------------------------------------
;;'(compile-command "scons")  ;;'(compile-command "make")
;;(setq compile-command "gcc -g -Wall ")
;;(setq compile-command "scons")

(defun quick-compile ()
    "A quick compile funciton for C++"
    (interactive)
    (compile (concat "g++ " (buffer-name (current-buffer)) " -g -pg -o main"))
)

(defun kill-buffer-when-compile-success (process)
    "Close current buffer when `when-compile-success'."
    (set-process-sentinel process
    (lambda (proc change)
        (when (string-match "finished" change)
        (delete-windows-on (process-buffer proc))))
    )
)
(add-hook 'compilation-start-hook 'kill-buffer-when-compile-success)

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

(eval-after-load 'autoinsert
  '(define-auto-insert
     '("\\.\\(CC?\\|cc\\|cxx\\|cpp\\|c++\\)\\'" . "C++ skeleton")
     '("Short description: "
       "/*" \n
       (file-name-nondirectory (buffer-file-name))
       " -- " str \n
       " */" > \n \n
       "#include <iostream>" \n \n
       "using namespace std;" \n \n
       "main()" \n
       "{" \n
       > _ \n
       "}" > \n)))

;; Taken from http://www.emacswiki.org/cgi-bin/wiki/CppTemplate#toc3
(defun cpp-solution-file (name)
  "Insert a C++ class definition.
 It creates a matching header file, inserts the class definition and
 creates the  most important function templates in a named after the
 class name. This might still be somewhat buggy."
  (interactive "sfile name: ")
  (let* (
	(def-file-name    (concat (downcase name) ".cpp")))

	;; create CPP file
	(set-buffer (get-buffer-create def-file-name))
	(set-visited-file-name def-file-name)
	(switch-to-buffer (current-buffer))
	(c++-mode)
	(turn-on-font-lock)
	(insert (concat
			"// -*- C++ -*-\n"
			"// File: " def-file-name "\n//\n"
			"// Time-stamp: <>\n"
			"// $Id: $\n//\n"
			"// Copyright (C) "(substring (current-time-string) -4)
			" by CMP\n//\n"
			"// Author: K0stIa \n//\n\n\n"
			"#include <algorithm>\n"
			"#include <string>\n"
			"#include <vector>\n"
			"#include <queue>\n"
			"#include <iostream>\n"
			"#include <cmath>\n"
			"#include <sstream>\n"
			"#include <map>\n"
			"#include <set>\n"
			"#include <numeric>\n"
			"#include <memory.h>\n"
			"#include <cstdio>\n"
			"#include <assert.h>\n\n"
			"using namespace std;\n\n"
			"#define pb push_back\n"
			"#define INF 1011111111\n"
			"#define FOR(i,a,b) for (int _n(b), i(a); i < _n; i++)\n"
			"#define rep(i,n) FOR(i,0,n)\n"
			"#define CL(a,v) memset((a),(v),sizeof(a))\n"
			"#define mp make_pair\n"
			"#define X first\n"
			"#define Y second\n"
			"#define all(c) (c).begin(), (c).end()\n"
			"#define SORT(c) sort(all(c))\n\n"
			"typedef long long ll;\n"
			"typedef vector<int> VI;\n"
			"typedef pair<int,int> pii;\n\n"
			"/*** TEMPLATE CODE ENDS HERE */\n\n\n"
			"int main() {\n"
			"#ifndef ONLINE_JUDGE\n"
			"      freopen(\"" (downcase name) "_input.txt\",\"r\",stdin);\n"
			"      //freopen(\"" (downcase name) "_output.txt\",\"w\",stdout);\n"
			"#endif\n\n\n\n"
			"#ifdef LocalHost\n"
			"	printf(\"TIME: %.3lf\\n\",double(clock())/CLOCKS_PER_SEC);\n"
			"#endif\n\n"
			"  return 0;\n"
			"}\n"
			 ))
	(beginning-of-buffer)
	(while (and (not (eobp)) (forward-line))
	  (indent-according-to-mode))
	(beginning-of-buffer)
        (goto-char 912)
;;	(search-forward "endif\n\n")
	)
)
