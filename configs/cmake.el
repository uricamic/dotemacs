
;; http://www.cmake.org/Wiki/CMake_Editors_Support

(setq load-path (cons (expand-file-name "~/.emacs.d/3dparty/cmake/cmake-mode.el") load-path))
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))
