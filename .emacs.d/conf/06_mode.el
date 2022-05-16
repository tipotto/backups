;; Tramp Mode
(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
(setq tramp-verbose 3)
(setq projectile-mode nil)
(setq projectile-mode-line nil)
