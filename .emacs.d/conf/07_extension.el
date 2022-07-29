;; 自動補完を有効にします。
(use-package company :ensure t
  :bind (("TAB" . company-complete))
  :config
  (global-company-mode)
  (setq company-minimum-prefix-length nil)
  (define-key company-active-map (kbd "C-i") 'company-select-next)
  (define-key company-active-map (kbd "M-i") 'company-select-previous))
 ; 色を設定します。
;;  (when (not window-system)
;;    (set-face-background 'company-tooltip "white")
;;    (set-face-foreground 'company-tooltip "black")
;;    (set-face-background 'company-tooltip-selection "brightblue")
;;    (set-face-foreground 'company-tooltip-common-selection "brightwhite")
;;    (set-face-foreground 'company-tooltip-common "brightwhite")
;;    (set-face-background 'company-scrollbar-bg "white") 
;;    (set-face-background 'company-scrollbar-fg "brightblack")))

;; 選択範囲をisearchできるようにします。
(defadvice isearch-mode (around isearch-mode-default-string (forward &optional regexp op-fun recursive-edit word-p) activate)
  (if (and transient-mark-mode mark-active (not (eq (mark) (point))))
      (progn
        (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
        (deactivate-mark)
        ad-do-it
        (if (not forward)
            (isearch-repeat-backward)
          (goto-char (mark))
          (isearch-repeat-forward)))
    ad-do-it))

;; undohist
;;(use-package undohist :ensure t
;;  :config
;;  (undohist-initialize))

;; multiple-cursors
(use-package multiple-cursors :ensure t
  :config
  (use-package phi-search :ensure t)
  (smartrep-define-key global-map "C-x t"
    '(("t" . 'mc/mark-next-like-this)
      ("T" . 'mc/mark-previous-like-this)
      ("P" . 'mc/cycle-backward)
      ("N" . 'mc/cycle-forward)
      ("m" . 'mc/mark-more-like-this-extended)
      ("u" . 'mc/unmark-next-like-this)
      ("U" . 'mc/unmark-previous-like-this)
      ("s" . 'mc/skip-to-next-like-this)
      ("S" . 'mc/skip-to-previous-like-this)
      ("C-s" . 'phi-search)
      ("C-r" . 'phi-search-backward)
      ("d" . 'mc/mark-all-like-this-dwim)
      ("i" . 'mc/insert-numbers)
      ("n" . 'next-line)
      ("p" . 'previous-line)
      ("f" . 'forward-char)
      ("b" . 'backward-char)
      ("o" . 'mc/sort-regions)
      ("O" . 'mc/reverse-regions))))

;; Undo-tree
(use-package undo-tree :ensure t
  :bind (("C-/" . undo-tree-undo)
         ("C-M-/" . undo-tree-redo))
  :config
  (global-undo-tree-mode)
  (setq undo-limit 600000)
  (setq undo-strong-limit 900000)

  (when (not window-system)
    (set-face-foreground 'undo-tree-visualizer-active-branch-face "white")
    (set-face-foreground 'undo-tree-visualizer-default-face "brightblack")))

;; multi-termを使えるようにします。
(when (require 'multi-term nil t)
  (setq multi-term-program "/usr/bin/zsh"))
	
;; Helmを使えるようにします。
(require 'helm-config)

;; sh4hackを使えるようにします。
(require 'sh4hack)

(require 'tty-format)

;; M-x display-ansi-colors to explicitly decode ANSI color escape sequences                                                                                                                                        
(defun display-ansi-colors ()
  (interactive)
  (format-decode-buffer 'ansi-colors))

;; decode ANSI color escape sequences for *.txt or README files                                                                                                                                                    
(add-hook 'find-file-hooks 'tty-format-guess)

;; decode ANSI color escape sequences for .log files                                                                                                                                                               
(add-to-list 'auto-mode-alist '("\\.log\\'" . display-ansi-colors))
