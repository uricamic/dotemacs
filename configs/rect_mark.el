(global-set-key (kbd "C-x r C-SPC") 'rm-set-mark)
(global-set-key (kbd "C-x r C-x") 'rm-exchange-point-and-mark)
(global-set-key (kbd "C-x r C-w") 'rm-kill-region)
(global-set-key (kbd "C-x r M-w") 'rm-kill-ring-save)

(autoload 'rm-set-mark "rect-mark"
     "Set mark for rectangle." t)
(autoload 'rm-exchange-point-and-mark "rect-mark"
      "Exchange point and mark for rectangle." t)
(autoload 'rm-kill-region "rect-mark"
      "Kill a rectangular region and save it in the kill ring." t)
(autoload 'rm-kill-ring-save "rect-mark"
      "Copy a rectangular region to the kill ring." t)

(require 'rect-mark)
(global-set-key (kbd "C-x r C-SPC") 'rm-set-mark)
(global-set-key (kbd "C-w")
  '(lambda(b e) (interactive "r")
     (if rm-mark-active
       (rm-kill-region b e) (kill-region b e))))
(global-set-key (kbd "M-w")
  '(lambda(b e) (interactive "r")
     (if rm-mark-active
       (rm-kill-ring-save b e) (kill-ring-save b e))))
(global-set-key (kbd "C-x C-x")
  '(lambda(&optional p) (interactive "p")
     (if rm-mark-active
       (rm-exchange-point-and-mark p) (exchange-point-and-mark p))))
