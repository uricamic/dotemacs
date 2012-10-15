(defconst emacs-config-dir "~/.emacs.d/configs/" "")

(defun load-cfg-files (filelist)
  (dolist (file filelist)
    (load (expand-file-name
	   (concat emacs-config-dir file)))
    (message "Loaded config file:%s" file)
    ))


; INSTALL instructions:
; The procedure of setting up my custom file:
;  run emacs --debug-config
;  install additional required modules which emacs can not load
;   OR
;  comment non-needed modules in load-cfg-files section below


(load-cfg-files '(
                  "matlab.el"
;;                  "cedet_dev.el"
                  "env.el"
                  "functions.el"
                  "yasnippet.el"
                  "smart-tab.el"
                  "cmake.el"
                  "deft.el"

                  "full-ack.el"
                  "ibuffer.el"
                  "mulled.el"
                  "org.el"
                  "python.el"
;;                  "init_python"
;;                  "cfg_python.el"
                  "cfg_browse_killring.el"
                  "slime.el"
                  "terminal.el"
                  "whitespace.el"
                  "cpp.el"
                  "gdb.el"
                  "rect_mark.el"
                  "autocomplete.el"
                  "projectile.el"
                  "emacsclangcompleteasync.el"
                  "auctex.el"
                  "predictive.el"
                  "bindings.el"
                  "cedet.el"
                  "color-theme.el"
                  "ecb.el"
                  "dired.el"
                  "global.el"
                  "configs.el"
;;                "cfg_ede_cmake.el"
                  "srspeedbar.el"
                  "bookmark+.el"
                  "x-cscope.el"
                  ))
