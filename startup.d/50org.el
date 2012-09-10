(add-to-list 'load-path "~/.emacs.d/3dparty/org-mode/lisp/")
(require 'org)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; (setq org-log-done t)

(setq org-agenda-files (list "~/org/gtd/todo.org"
                             "~/org/gtd/todo_archive.org"
                             "~/org/notes.org"
                             "~/org/research.org"
                             "~/org/research_papers.org"
                             "~/org/research_project.org"
                       )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Make TAB the yas trigger key in the org-mode-hook and turn on flyspell mode
(add-hook 'org-mode-hook
           (lambda ()
             ;; yasnippet
             (make-variable-buffer-local 'yas/trigger-key)
             (setq yas/trigger-key [tab])
             (define-key yas/keymap [tab] 'yas/next-field-group)
             ;; flyspell mode to spell check everywhere
             (flyspell-mode 1)
             )
           )


;; Custom Key Bindings
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f6>") 'bh/org-todo)
(global-set-key (kbd "<S-f6>") 'widen)
(global-set-key (kbd "<f7>") 'set-truncate-lines)
(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
(global-set-key (kbd "<f10x> b") 'bbdb)
(global-set-key (kbd "<f11> c") 'calendar)
(global-set-key (kbd "<f11> f") 'boxquote-insert-file)
;; (global-set-key (kbd "<f9> g") 'gnus)
(global-set-key (kbd "<f9> h") 'hide-other)
;; (global-set-key (kbd "<f9> i") (lambda ()
;;                                  (interactive)
;;                                  (info "~/git/org-mode/doc/org.info")))
(global-set-key (kbd "<f11> r") 'boxquote-region)
(global-set-key (kbd "<f11> t") 'bh/insert-inactive-timestamp)
(global-set-key (kbd "<f11> u") (lambda ()
                                 (interactive)
                                 (untabify (point-min) (point-max))))
(global-set-key (kbd "<f11> v") 'visible-mode)
(global-set-key (kbd "C-<f11>") 'previous-buffer)
(global-set-key (kbd "C-x n r") 'narrow-to-region)
(global-set-key (kbd "C-<f11>") 'next-buffer)
(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
(global-set-key (kbd "M-<f11>") 'org-resolve-clocks)
(global-set-key (kbd "C-M-r") 'org-remember)



;;ToDo keywords
;; Here are my TODO state keywords and colour settings:
(setq org-todo-keywords (quote ((sequence "TODO(t)" "STARTED(s!)" "|" "DONE(d!/!)")
(sequence "WAITING(w@/!)" "SOMEDAY(S!)" "OPEN(O@)" "|" "CANCELLED(c@/!)")
(sequence "QUOTE(q!)" "QUOTED(Q!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)"))))
(setq org-todo-keyword-faces (quote (("TODO" :foreground "red" :weight bold)
                                     ("STARTED" :foreground "blue" :weight bold)
                                     ("DONE" :foreground "forest green" :weight bold)
                                     ("WAITING" :foreground "orange" :weight bold)
                                     ("SOMEDAY" :foreground "magenta" :weight bold)
                                     ("CANCELLED" :foreground "forest green" :weight bold)
                                     ("QUOTE" :foreground "red" :weight bold)
                                     ("QUOTED" :foreground "magenta" :weight bold)
                                     ("APPROVED" :foreground "forest green" :weight bold)
                                     ("EXPIRED" :foreground "forest green" :weight bold)
                                     ("REJECTED" :foreground "forest green" :weight bold)
                                     ("OPEN" :foreground "blue" :weight bold))))

;; Fast todo selection allows changing from any task todo state to any other
;; state directly by selecting the appropriate key from the fast todo selection
;; key menu. This is a great feature!
(setq org-use-fast-todo-selection t)

;; allows changing todo states with S-left and S-right skipping all of the
;; normal processing when entering or leaving a todo state. This cycles
;; through the todo states but skips setting timestamps and entering notes
;; which is very convenient when all you want to do is ﬁx up the status of
;; an entry.

(setq org-treat-S-cursor-todo-selection-as-state-change nil)


;; a few triggers that automatically assign tags to tasks based on state
;; changes.

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t) ("NEXT"))
              ("SOMEDAY" ("WAITING" . t))
              (done ("NEXT") ("WAITING"))
              ("TODO" ("WAITING") ("CANCELLED") ("NEXT"))
              ("DONE" ("WAITING") ("CANCELLED") ("NEXT"))
              )
             )
)


;; Tasks automatically change to STARTED whenever they are clocked
;; in.

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")


(setq org-agenda-custom-commands
      (quote (("s" "Started Tasks" todo "STARTED" ((org-agenda-todo-ignore-scheduled nil)
                                                   (org-agenda-todo-ignore-deadlines nil)
                                                   (org-agenda-todo-ignore-with-date nil)))
                   ("w" "Tasks waiting on something" tags "WAITING/!" ((org-use-tag-inheritance nil)))
                   ("r" "Refile New Notes and Tasks" tags "LEVEL=1+REFILE" ((org-agenda-todo-ignore-with-date nil)
                                                                            (org-agenda-todo-ignore-deadlines nil)
                                                                            (org-agenda-todo-ignore-scheduled nil)))
                   ("N" "Notes" tags "NOTE" nil)
                   ("n" "Next" tags "NEXT-WAITING-CANCELLED/!" nil)
                   ("p" "Projects" tags-todo "LEVEL=2-NEXT-WAITING-CANCELLED/!-DONE" nil)
                   ("A" "Tasks to be Archived" tags "LEVEL=2/DONE|CANCELLED" nil)
                   ("h" "Habits" tags "STYLE=\"habit\"" ((org-agenda-todo-ignore-with-date nil) (org-agenda-todo-ignore-scheduled nil) (org-agenda-todo-ignore-deadlines nil)))))
      )


(defun bh/weekday-p ()
    (let ((wday (nth 6 (decode-time))))
      (and (< wday 6) (> wday 0))))

(defun bh/working-p ()
    (let ((hour (nth 2 (decode-time))))
      (and (bh/weekday-p) (or (and (>= hour 8) (<= hour 11))
                              (and (>= hour 13) (<= hour 16))))))

(defun bh/network-p ()
  (= 0 (call-process "/bin/ping" nil nil nil
                     "-c1" "-q" "-t1" "norang.ca")))

(defun bh/org-auto-exclude-function (tag)
  (and (cond
        ((string= tag "@home")
         (bh/working-p))
        ((string= tag "@office")
         (not (bh/working-p)))
        ((or (string= tag "@errand") (string= tag "PHONE"))
         (let ((hour (nth 2 (decode-time))))
           (or (< hour 8) (> hour 21)))))
       (concat "-" tag)))

(setq org-agenda-auto-exclude-function 'bh/org-auto-exclude-function)

;;; Time Clocking


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
(setq org-default-notes-file "~/org/notes.org")
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)

;; Start clock if a remember buffer includes :CLOCK-IN:
(add-hook 'remember-mode-hook 'bh/start-clock-if-needed 'append)

(defun bh/start-clock-if-needed ()
(save-excursion
  (goto-char (point-min))
  (when (re-search-forward " *:CLOCK-IN: *" nil t)
    (replace-match "")
    (org-clock-in)
    )
  )
)

;; I use C-M-r to start org-remember
(global-set-key (kbd "C-M-r") 'org-remember)

;; Keep clocks running
(setq org-remember-clock-out-on-exit nil)

;; C-c C-c stores the note immediately
(setq org-remember-store-without-prompt t)

;; I don’t use this -- but set it in case I forget to specify a location in a future template
(setq org-remember-default-headline "Tasks")

;; remember templates

 (setq org-remember-templates
    '(("Todo" ?t "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" "~/org/gtd/todo.org" "Tasks")
      ("Research Todo" ?r "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" "~/org/gtd/todo.org" "Research")
      ("Algorithm Todo" ?a "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" "~/org/gtd/todo.org" "Algorithms")
      ("Journal"   ?j "** %^{Head Line} %U %^g\n%i%?"  "~/org/gtd/journal.org")
      ("Note" ?n "* %?                                        :NOTE:\n  %u\n  %a" nil bottom nil)
;      ("Clipboard" ?c "** %^{Head Line} %U %^g\n%c\n%?"  "~/org/gtd/journal.org")
;      ("Receipt"   ?r "** %^{BriefDesc} %U %^g\n%?"   "~/org/gtd/finances.org")
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

;; ;;;; Reﬁling Tasks

;; ; Use IDO for target completion
;; (setq org-completion-use-ido t)

;; ;;  Targets include this file and any file contributing to the agenda - up to 5 levels deep
;; (setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))

;; ;; Targets start with the file name - allows creating level 1 tasks
;; (setq org-refile-use-outline-path (quote file))

;; ;; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
;; (setq org-outline-path-complete-in-steps t)


;; ;; Time Clocking

;; Clock setup

;; ;; Resume clocking tasks when emacs is restarted
;; (org-clock-persistence-insinuate)
;; ;;
;; ;; Yes it's long... but more is better ;)
;; (setq org-clock-history-length 35)
;; ;; Resume clocking task on clock-in if the clock is open
;; (setq org-clock-in-resume t)
;; ;; Change task state to STARTED when clocking in
;; (setq org-clock-in-switch-to-state "STARTED")
;; ;; Separate drawers for clocking and logs
;; (setq org-drawers (quote ("PROPERTIES" "LOGBOOK" "CLOCK"))
;;       ;; Save clock data in the CLOCK drawer and state changes and notes in the LOGBOOK drawer
;;       (setq org-clock-into-drawer "CLOCK")
;;       ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
;;       (setq org-clock-out-remove-zero-time-clocks t)
;;       ;; Don't clock out when moving task to a done state
;;       (setq org-clock-out-when-done nil)
;;       ;; Save the running clock and all clock history when exiting Emacs, load it on startup
;;       (setq org-clock-persist (quote history)
;; )

;; ;; Editing clock entries
;; ; (setq org-time-stamp-rounding-minutes (quote (1 15)))

;; ;;  Time reporting and tracking

;; ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
;; ; (setq org-clock-out-remove-zero-time-clocks t)

;; ;; Agenda log mode items to display (clock time only by default)
;; ; (setq org-agenda-log-mode-items (quote (clock)))


;; ;; Agenda clock report parameters (no links, 2 levels deep)
;; ; (setq org-agenda-clockreport-parameter-plist (quote (:link nil :maxlevel 2)))

;; ;; Set default column view headings: Task Effort Clock_Summary
;; ; (setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")


;; ;; Agenda clock report parameters (no links, 2 levels deep)
;; ;; global Effort estimate values
;; ; (setq org-global-properties (quote (("Effort_ALL" . "0:10 0:30 1:00 2:00 3:00 4:00 5:00 6:00 7:00 8:00"))))


;; TAGS

;; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?h)
                            ("@farm" . ?f)
                            (:endgroup)
                            ("PHONE" . ?p)
                            ("QUOTE" . ?q)
                            ("NEXT" . ?n)
                            ("WAITING" . ?w)
                            ("FARM" . ?F)
                            ("HOME" . ?H)
                            ("ORG" . ?O)
                            ("NORANG" . ?N)
                            ("crypt" . ?c)
                            ("MARK" . ?M))))

;; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

;; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)



;;;; GTD stuﬀ

(setq org-agenda-ndays 1)

(setq org-stuck-projects (quote ("LEVEL=2-REFILE-WAITING|LEVEL=1+REFILE/!-DONE-CANCELLED-OPEN" nil ("NEXT") "")))

;; Publising stuff
;;(setq org-export-docbook-xsl-fo-proc-command "fop %s %s")
;; (setq org-export-docbook-xslt-proc-command
;;      "xsltproc --output %s /usr/share/xml/docbook/xsl-stylesheets-1.76.1/xhtml/docbook.xsl %s")

;; experimenting with docbook exports - not finished
(setq org-export-docbook-xsl-fo-proc-command "fop %s %s")
(setq org-export-docbook-xslt-proc-command "xsltproc --output %s /usr/share/xml/docbook/stylesheet/nwalsh/fo/docbook.xsl %s")
;;
;; Inline images in HTML instead of producting links to the image
(setq org-export-html-inline-images t)
;; Do not use sub or superscripts - I currently don't need this functionality in my documents
(setq org-export-with-sub-superscripts nil)

(load-file "~/.emacs.d/3dparty/org-s5/org-export-as-s5.el")


;; I'm lazy and don't want to remember the name of the project to publish when I modify
;; a file that is part of a project.  So this function saves the file, and publishes
;; the project that includes this file
                                        ;
;; It's bound to C-S-F12 so I just edit and hit C-S-F12 when I'm done and move on to the next thing
(defun bh/save-then-publish ()
  (interactive)
  (save-buffer)
  (org-save-all-org-buffers)
  (org-publish-current-project)
)

(global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)

;;; Reminders

; Erase all reminders and rebuilt reminders for today from the agenda
(defun bh/org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt)
)
;; Rebuild the reminders everytime the agenda is displayed
(add-hook 'org-finalize-agenda-hook 'bh/org-agenda-to-appt)
;; This is at the end of my .emacs - so appointments are set up when Emacs starts
(bh/org-agenda-to-appt)
; Activate appointments so we get notifications
(appt-activate t)
; If we leave Emacs running overnight - reset the appointments one minute after midn
(run-at-time "24:01" nil 'bh/org-agenda-to-appt)

;;; Productivity Tools





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
