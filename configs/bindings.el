(global-set-key (kbd "M-3") 'split-window-horizontally) ; was digit-argument
(global-set-key (kbd "M-2") 'split-window-vertically) ; was digit-argument
(global-set-key (kbd "M-1") 'delete-other-windows) ; was digit-argument
(global-set-key (kbd "M-0") 'delete-window) ; was digit-argument
(global-set-key (kbd "M-o") 'other-window) ; was facemenu-keymap
(global-set-key (kbd "M-k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c C-f") 'insert-file-name)
(global-set-key (kbd "M-Y") 'yank-pop-backwards)
(global-set-key (kbd "C-z") 'repeat)
(global-set-key (kbd "C-M-}") 'forward-page)
(global-set-key (kbd "C-M-{") 'backward-page)

;; rgrep
(global-set-key [C-f7] 'rgrep)
(global-set-key [XF86Search] 'rgrep)

;; occur
;; http://www.emacswiki.org/emacs/KeyboardMacrosTricks#toc5
(fset 'myoccur
      [?\C-  C-right C-kp-insert escape ?x ?o ?c ?c ?u ?r return ?\C-y return f4])
(global-set-key (kbd "C-c C-o") 'myoccur)
(global-set-key [(control shift f7)] 'occur)

;; hippie expand
(global-set-key "\M- " 'hippie-expand)


;; comment-uncomment region
(global-set-key [(control /)] 'comment-or-uncomment-region)
(global-set-key [(control shift z)] 'comment-or-uncomment-region)


;;<<
(global-set-key [M-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to downer window
;;>>
