(add-to-list 'load-path "~/.emacs.d/3dparty/org-mode/lisp/")
(require 'org)
(setq org-export-docbook-xsl-fo-proc-command "fop %s %s")
(setq org-export-docbook-xslt-proc-command
      "xsltproc --output %s /usr/share/xml/docbook/xsl-stylesheets-1.76.1/xhtml/docbook.xsl %s")
(load-file "~/.emacs.d/3dparty/org-s5/org-export-as-s5.el")


(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)

(setq org-agenda-files (list "~/org/gtd/todo.org"
                             "~/org/algorithm.org"
                             "~/org/research.org"
                             "~/org/research_papers.org"
                             "~/org/research_project.org"
                       )
)


(require 'org-latex)
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")))


(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
)
(add-hook 'org-mode-hook 'org-mode-reftex-setup)


(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
      (set-face-underline-p 'org-link t))
  (iimage-mode))

;;;;;;;;;;;;;; Setting up RefTeX

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
       (progn
        ;enable auto-revert-mode to update reftex when bibtex file changes on disk
	 (global-auto-revert-mode t)
	 (reftex-parse-all)
	 ;add a custom reftex cite format to insert links
	 (reftex-set-cite-format
	  '((?b . "[[bib:%l][%l-bib]]")
	    (?n . "[[notes:%l][%l-notes]]")
	    (?p . "[[papers:%l][%l-paper]]")
	    (?t . "%t")
	    (?h . "** %t\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[papers:%l][%l-paper]]")))))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))

(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(defun org-mode-reftex-search ()
  ;;jump to the notes for the paper pointed to at from reftex search
  (interactive)
  (org-open-link-from-string (format "[[notes:%s]]" (reftex-citation t))))

(setq org-link-abbrev-alist
      '(("bib" . "~/research/refs.bib::%s")
	("notes" . "~/research/org/papers.org::#%s")
	("papers" . "/mnt/E/study/PhD/papers/%s.pdf")
        ("papers" . "/mnt/E/study/PhD/papers/%s.pdf")))

;; remember
(require 'remember)

(setq org-directory "~/org/")
(setq org-default-notes-file "~/org/.notes")
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)

;; remember templates

 (setq org-remember-templates
    '(("Todo" ?t "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" "~/org/gtd/todo.org" "Tasks")
      ("Journal"   ?j "** %^{Head Line} %U %^g\n%i%?"  "~/org/gtd/journal.org")
      ("Clipboard" ?c "** %^{Head Line} %U %^g\n%c\n%?"  "~/org/gtd/journal.org")
      ("Receipt"   ?r "** %^{BriefDesc} %U %^g\n%?"   "~/org/gtd/finances.org")
;      ("Book" ?b "** %^{Book Title} %t :BOOK: \n%[~/.book_template.txt]\n"
;         "~/GTD/journal.org")
;          ("Film" ?f "** %^{Film Title} %t :FILM: \n%[~/.film_template.txt]\n"
;         "~/GTD/journal.org")
;      ("Daily Review" ?a "** %t :COACH: \n%[~/org/daily_review.txt]\n"
;         "~/GTD/journal.org")
      ("Someday"   ?s "** %^{Someday Heading} %U\n%?\n"  "~/org/gtd/someday.org")
      ("Vocab"   ?v "** %^{Word?}\n%?\n"  "~/org/gtd/vocab.org")
     )
   )


;; ;; ORG mode (life organization in text)
;; ;; Custom Key Bindings
;; ;; 3--
;; (global-set-key (kbd "<f12>") 'org-agenda)
;; (global-set-key (kbd "<f5>") 'bh/org-todo)
;; (global-set-key (kbd "<S-f5>") 'bh/widen)
;; (global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
;; (global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
;; (global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)
;; (global-set-key (kbd "<f9> b") 'bbdb)
;; (global-set-key (kbd "<f9> c") 'calendar)
;; (global-set-key (kbd "<f9> f") 'boxquote-insert-file)
;; (global-set-key (kbd "<f9> g") 'gnus)
;; (global-set-key (kbd "<f9> h") 'bh/hide-other)
;; (global-set-key (kbd "<f9> n") 'org-narrow-to-subtree)
;; (global-set-key (kbd "<f9> w") 'widen)
;; (global-set-key (kbd "<f9> u") 'bh/narrow-up-one-level)

;; (global-set-key (kbd "<f9> I") 'bh/punch-in)
;; (global-set-key (kbd "<f9> O") 'bh/punch-out)

;; (global-set-key (kbd "<f9> o") 'bh/make-org-scratch)

;; (global-set-key (kbd "<f9> r") 'boxquote-region)
;; (global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

;; (global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
;; (global-set-key (kbd "<f9> T") 'tabify)
;; (global-set-key (kbd "<f9> U") 'untabify)

;; (global-set-key (kbd "<f9> v") 'visible-mode)
;; (global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
;; (global-set-key (kbd "C-<f9>") 'previous-buffer)
;; (global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)
;; (global-set-key (kbd "C-x n r") 'narrow-to-region)
;; (global-set-key (kbd "C-<f10>") 'next-buffer)
;; (global-set-key (kbd "<f11>") 'org-clock-goto)
;; (global-set-key (kbd "C-<f11>") 'org-clock-in)
;; (global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
;; (global-set-key (kbd "C-M-r") 'org-capture)
;; (global-set-key (kbd "C-c r") 'org-capture)


;; (defun bh/hide-other ()
;;   (interactive)
;;   (save-excursion
;;     (org-back-to-heading 'invisible-ok)
;;     (hide-other)
;;     (org-cycle)
;;     (org-cycle)
;;     (org-cycle)))

;; (defun bh/set-truncate-lines ()
;;   "Toggle value of truncate-lines and refresh window display."
;;   (interactive)
;;   (setq truncate-lines (not truncate-lines))
;;   ;; now refresh window display (an idiom from simple.el):
;;   (save-excursion
;;     (set-window-start (selected-window)
;;                       (window-start (selected-window)))))

;; (defun bh/make-org-scratch ()
;;   (interactive)
;;   (find-file "/tmp/publish/scratch.org")
;;   (gnus-make-directory "/tmp/publish"))

;; (defun bh/switch-to-scratch ()
;;   (interactive)
;;   (switch-to-buffer "*scratch*"))

;; ;; 4 --
;; (setq org-todo-keywords
;;       (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
;;               (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE"))))

;; (setq org-todo-keyword-faces
;;       (quote (("TODO" :foreground "red" :weight bold)
;;               ("NEXT" :foreground "blue" :weight bold)
;;               ("DONE" :foreground "forest green" :weight bold)
;;               ("WAITING" :foreground "orange" :weight bold)
;;               ("HOLD" :foreground "magenta" :weight bold)
;;               ("CANCELLED" :foreground "forest green" :weight bold)
;;               ("PHONE" :foreground "forest green" :weight bold))))

;; (setq org-use-fast-todo-selection t)
;; (setq org-treat-S-cursor-todo-selection-as-state-change nil)

;; (setq org-todo-state-tags-triggers
;;       (quote (("CANCELLED" ("CANCELLED" . t))
;;               ("WAITING" ("WAITING" . t))
;;               ("HOLD" ("WAITING" . t) ("HOLD" . t))
;;               (done ("WAITING") ("HOLD"))
;;               ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
;;               ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
;;               ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;; ;; 5--
;; (setq org-directory "~/org")
;; (setq org-default-notes-file "~/org/refile.org")

;; ;; I use C-M-r to start capture mode
;; (global-set-key (kbd "C-M-r") 'org-capture)
;; ;; I use C-c r to start capture mode when using SSH from my Android phone
;; (global-set-key (kbd "C-c r") 'org-capture)

;; ;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol
;; (setq org-capture-templates
;;       (quote (("t" "todo" entry (file "~/org/refile.org")
;;                "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
;;               ("r" "respond" entry (file "~/org/refile.org")
;;                "* TODO Respond to %:from on %:subject\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
;;               ("n" "note" entry (file "~/org/refile.org")
;;                "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
;;               ("j" "Journal" entry (file+datetree "~/org/diary.org")
;;                "* %?\n%U\n" :clock-in t :clock-resume t)
;;               ("w" "org-protocol" entry (file "~/org/refile.org")
;;                "* TODO Review %c\n%U\n" :immediate-finish t)
;;               ("p" "Phone call" entry (file "~/org/refile.org")
;;                "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
;;               ("h" "Habit" entry (file "~/org/refile.org")
;;                "* NEXT %?\n%U\n%a\nSCHEDULED: %t .+1d/3d\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; ;; -6--
;; ; Targets include this file and any file contributing to the agenda - up to 9 levels deep
;; (setq org-refile-targets (quote ((nil :maxlevel . 9)
;;                                  (org-agenda-files :maxlevel . 9))))

;; ; Use full outline paths for refile targets - we file directly with IDO
;; (setq org-refile-use-outline-path t)

;; ; Targets complete directly with IDO
;; (setq org-outline-path-complete-in-steps nil)

;; ; Allow refile to create parent tasks with confirmation
;; (setq org-refile-allow-creating-parent-nodes (quote confirm))

;; ; Use IDO for both buffer and file completion and ido-everywhere to t
;; (setq org-completion-use-ido t)
;; (setq ido-everywhere t)
;; (setq ido-max-directory-size 100000)
;; (ido-mode (quote both))

;; ;;;; Refile settings
;; ; Exclude DONE state tasks from refile targets
;; (defun bh/verify-refile-target ()
;;   "Exclude todo keywords with a done state from refile targets"
;;   (not (member (nth 2 (org-heading-components)) org-done-keywords)))

;; (setq org-refile-target-verify-function 'bh/verify-refile-target)
