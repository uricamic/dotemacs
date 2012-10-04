(require 'yasnippet)
(setq yas/root-directory '("~/.emacs.d/3dparty/yasnippet/snippets" "~/.emacs.d/3dparty/yasnippet-snippets"))
(yas/initialize)
(setq yas/prompt-functions '(yas/dropdown-prompt))
(setq yas/wrap-around-region t)

(global-set-key (kbd "C-SPC") 'yas/expand)