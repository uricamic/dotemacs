(add-to-list 'load-path "~/.emacs.d/vendor/org-mode/lisp/")
(require 'org)
(setq org-export-docbook-xsl-fo-proc-command "fop %s %s")
(setq org-export-docbook-xslt-proc-command
      "xsltproc --output %s /usr/share/xml/docbook/xsl-stylesheets-1.76.1/xhtml/docbook.xsl %s")
(load-file "~/.emacs.d/vendor/org-s5/org-export-as-s5.el")


(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/org/work.org"
                             "~/org/school.org" 
                             "~/org/home.org"))
                             
                             
(require 'org-latex)
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")))  