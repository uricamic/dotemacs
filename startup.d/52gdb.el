

;;(setq gdb-non-stop-setting t)

;;(load "cdb-gud")
;;(load-library "multi-gud.el")
;;(load-library "multi-gdb-ui.el")

(add-hook 'gdb-mode-hook '(lambda ()
        (gdb-many-windows t)
;;        (tabbar-mode nil)
        (tool-bar-mode t)
        (fullscreen)
;;        (menu-bar-mode nil)
)
)