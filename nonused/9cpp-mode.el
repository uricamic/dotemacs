(load-file "~/.emacs.d/vendor/cedet/common/cedet.el")

(global-ede-mode t)

; Semantic's customization

(semantic-load-enable-excessive-code-helpers)

(require 'semantic-ia)

; System header files
; add automatic loading of include files
(require 'semantic-gcc)
; add pathes for lookinkg including files
; (semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)

;TODO
; Optimization of Semantic's work

; Integration with imenu
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

; Customization of Semanticdb

(require 'semanticdb)
(global-semanticdb-minor-mode 1)

;; if you want to enable support for gnu global
(when (cedet-gnu-global-version-check t)
  (require 'semanticdb-global)
  (semanticdb-enable-gnu-global-databases 'c-mode)
  (semanticdb-enable-gnu-global-databases 'c++-mode))

;; enable ctags for some languages:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
(when (cedet-ectag-version-check)
  (semantic-load-enable-primary-exuberent-ctags-support))