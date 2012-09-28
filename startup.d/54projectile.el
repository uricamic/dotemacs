
(require 'projectile)
(projectile-global-mode)

(add-hook 'c++-mode-hook 'projectile-on)



;; only for small projects
;; (setq projectile-enable-caching nil)
