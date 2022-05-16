;;; Emacsをより便利に使うための拡張設定を施します。
(progn

  ;; Enterによる改行を便利にします。
;  (use-package smart-newline :ensure t
;    :config
;    (define-key global-map (kbd "C-m") 'smart-newline))

	;; eww
  (defvar eww-disable-colorize t)
  (defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
    (unless eww-disable-colorize
      (funcall orig start end fg)))
  (advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
  (advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
  (defun eww-disable-color ()
    "eww で文字色を反映させない"
    (interactive)
    (setq-local eww-disable-colorize t)
    (eww-reload))
  (defun eww-enable-color ()
    "eww で文字色を反映させる"
    (interactive)
    (setq-local eww-disable-colorize nil)
    (eww-reload))
	
  (defun eww-disable-images ()
    "eww で画像表示させない"
    (interactive)
    (setq-local shr-put-image-function 'shr-put-image-alt)
    (eww-reload))
	
  (defun eww-enable-images ()
    "eww で画像表示させる"
    (interactive)
    (setq-local shr-put-image-function 'shr-put-image)
    (eww-reload))
	
  (defun shr-put-image-alt (spec alt &optional flags)
    (insert alt))
	
  ;; はじめから非表示
  (defun eww-mode-hook--disable-image ()
    (setq-local shr-put-image-function 'shr-put-image-alt))
  (add-hook 'eww-mode-hook 'eww-mode-hook--disable-image)

	(setq eww-search-prefix "https://www.google.co.jp/search?q=")
	
;	 (define-key eww-mode-map "R" 'eww-reload)
;  (define-key eww-mode-map "C" 'eww-copy-page-url)
;  (define-key eww-mode-map "p" 'scroll-down)
;  (define-key eww-mode-map "n" 'scroll-up)

  ;; 自動補完を有効にします。
  (use-package company :ensure t
    :bind (("TAB" . company-complete))
    :config
    (global-company-mode)
    (setq company-minimum-prefix-length nil)
    (define-key company-active-map (kbd "C-i") 'company-select-next)
    (define-key company-active-map (kbd "M-i") 'company-select-previous)

    ; 色を設定します。
    (when (not window-system)
      (set-face-background 'company-tooltip "white")
      (set-face-foreground 'company-tooltip "black")
      (set-face-background 'company-tooltip-selection "brightblue")
      (set-face-foreground 'company-tooltip-common-selection "brightwhite")
      (set-face-foreground 'company-tooltip-common "brightwhite")
      (set-face-background 'company-scrollbar-bg "white") 
      (set-face-background 'company-scrollbar-fg "brightblack")))
  
  ;; lispを評価したときに式を結果で置換するようにします。
  ;; (defun replace-last-sexp ()
  ;;   (interactive)
  ;;   (let ((value (eval (preceding-sexp))))
  ;;     (kill-sexp -1)
  ;;     (insert (format "%S" value))))
  ;; (bind-key "C-x E" 'replace-last-sexp)
  
  ;; 選択範囲をisearchできるようにします。
  ;; (defadvice isearch-mode (around isearch-mode-default-string (forward &optional regexp op-fun recursive-edit word-p) activate)
  ;;   (if (and transient-mark-mode mark-active (not (eq (mark) (point))))
  ;;       (progn
  ;;         (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
  ;;         (deactivate-mark)
  ;;         ad-do-it
  ;;         (if (not forward)
  ;;             (isearch-repeat-backward)
  ;;           (goto-char (mark))
  ;;           (isearch-repeat-forward)))
  ;;     ad-do-it))

  ;; helmを有効にします。
  ;;(use-package helm :ensure t)
  
  ;; バッファ切り替えを「C-x b」に続けて「b, n, p, N, P」で素早く実行できるようにします。
;;  (global-unset-key (kbd "C-x b"))
;;  (smartrep-define-key global-map (kbd "C-x b")
;;    '(("b" . 'helm-for-files)
;;      ("n" . 'next-buffer-noast)
;;      ("p" . 'previous-buffer-noast)
;;      ("N" . 'next-buffer)
;;      ("P" . 'previous-buffer)))
;;  (defun asterisked? (buf-name)
;;    (= 42 (car (string-to-list buf-name))))
;;  (defun next-buffer-noast ()
;;    (interactive)
;;    (let ((current-buffer-name (buffer-name)))
;;      (next-buffer)
;;      (while (and (asterisked? (buffer-name))
;;                  (not (string= current-buffer-name (buffer-name))))
;;        (next-buffer))))
;;  (defun previous-buffer-noast ()
;;    (interactive)
;;    (let ((current-buffer-name (buffer-name)))
;;      (previous-buffer)
;;      (while (and (asterisked? (buffer-name))
;;                  (not (string= current-buffer-name (buffer-name))))
;;        (previous-buffer))))
  
  ;; ウインドウサイズを「C-x 7」に続けて「b, f, p, n」で変更可能にします。
  ;; (defun resize-window (dir pos)
  ;;   (interactive)
  ;;   (progn 
  ;;     (cond ((eq dir 'left) (shrink-window-horizontally pos))
  ;;       ((eq dir 'up) (shrink-window pos))
  ;;       ((eq dir 'right) (enlarge-window-horizontally pos))
  ;;       ((eq dir 'down) (enlarge-window pos)))
  ;;     (message "size[%dx%d]" (window-width) (window-height))))
  ;; (smartrep-define-key global-map (kbd "C-x 7")
  ;;   '(("b" . '(resize-window 'left 5))
  ;;     ("f" . '(resize-window 'right 5))
  ;;     ("p" . '(resize-window 'up 5))
  ;;     ("n" . '(resize-window 'down 5))))

  ;; 文字サイズを「C-x 8」に続けて「n, p」で気軽に変更できるようにします。
  ;; (defun change-font-height (delta)
  ;;   (set-face-attribute 'default
  ;;                       (selected-frame)
  ;;                       :height (+ (face-attribute 'default :height) delta)))
  ;; (smartrep-define-key global-map (kbd "C-x 8")
  ;;   '(("n" . '(lambda () (interactive) (change-font-height +10)))
  ;;     ("p" . '(lambda () (interactive) (change-font-height -10)))))
  
  ;; コメントの表示非表示の切り替えを「C-c c」で行えるようにします。
  ;; (use-package hide-comnt :ensure t
  ;;   :config
  ;;   (require 'hide-comnt)
  ;;   (bind-key "C-c c" 'hide/show-comments-toggle))

  ;; ウインドウ切替を「C-x o o o ...」で連続実行できるようにし
  ;; また「f, b, n, p」で上下左右に移動できるようにします。
  ;(define-key global-map (kbd "C-o") 'other-window)
  ;(define-key global-map (kbd "C-O") '(other-window -1))
  (define-key global-map (kbd "C-x o") (lambda () 
    (interactive) 
    (funcall (smartrep-map '(
      ("a" . avy-goto-line)
      ("b" . windmove-left) 
      ("f" . windmove-right) 
      ("p" . windmove-up) 
      ("n" . windmove-down) 
      ("o" . other-window) 
      ("O" . (other-window -1)))))))
  (define-key global-map (kbd "C-x O") (lambda ()
    (interactive) 
    (funcall (smartrep-map '(
      ("a" . avy-goto-line)
      ("b" . windmove-left) 
      ("f" . windmove-right) 
      ("p" . windmove-up) 
      ("n" . windmove-down) 
      ("o" . other-window) 
      ("O" . (other-window -1)))))))

  ;; grepの実行結果を編集できるようにします。
  ;; (use-package wgrep :ensure t
  ;;   :config
  ;;   (define-key grep-mode-map (kbd "r") 'wgrep-change-to-wgrep-mode)
  ;;   (define-key grep-mode-map (kbd "C-g") 'wgrep-remove-all-change)
  ;;   (define-key grep-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)

  ;;   ; 色を設定します。
  ;;   (when (not window-system)
  ;;     (set-face-foreground 'wgrep-face "brightwhite")
  ;;     (set-face-background 'wgrep-face "red")))
    
  
  ;; moccurの実行結果を編集できるようにし「C-o」に続けて「o, m, g」で
  ;; moccurやgrep-findを気軽に実行できるようにします。
  ;; (use-package moccur-edit :ensure t
  ;;   :bind (("C-c r o" . occur-by-moccur)
  ;;          ("C-c r m" . moccur)
  ;;          ("C-c r g" . grep-find))
  ;;   :config
  ;;   (when (not window-system)
  ;;     (set-face-foreground 'moccur-face "brightwhite")
  ;;     (set-face-background 'moccur-face "red")))

;;; undohist
(use-package undohist :ensure t
  :config
  (undohist-initialize))

;;; multiple-cursors
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

;;; Undo-tree
(use-package undo-tree :ensure t
  :bind (("C-_" . undo-tree-undo)
         ("C-M-_" . undo-tree-redo))
  :config
  (global-undo-tree-mode)
  (setq undo-limit 600000)
  (setq undo-strong-limit 900000)

  (when (not window-system)
    (set-face-foreground 'undo-tree-visualizer-active-branch-face "white")
    (set-face-foreground 'undo-tree-visualizer-default-face "brightblack")))
  
)

;; (use-package which-key :ensure t
;;   :config
;;   (which-key-setup-side-window-bottom)
;;   (which-key-mode 1))

;;; expand-region
;; (use-package expand-region :ensure t
;;   :bind (("M-@" . er/expand-region)
;;          ("M-`" . er/contract-region)))




;;; highlight-symbol
;; (use-package highlight-symbol :ensure t
;;   :config
;;   (global-unset-key (kbd "C-x m"))
;;   (smartrep-define-key global-map (kbd "C-x m") 
;;     '(("m" . 'highlight-symbol)
;;       ("n" . 'highlight-symbol-next)
;;       ("p" . 'highlight-symbol-prev)
;;       ("c" . 'highlight-symbol-query-replace))))




;;; anzu
;; (use-package anzu :ensure t
;;   :bind (("M-%" . anzu-query-replace)
;;          ("C-M-%" . anzu-query-replace-regexp)) ;動作するようにしましょううううううううううううううううううう
;;   :config
;;   (global-anzu-mode +1))


;;; hungry-delete
;; (use-package hungry-delete :ensure t
;;   :bind (("M-d" . hungry-delete-forward)
;;          ("M-h" . hungry-delete-backward)))


;;; magit
;; (use-package magit :ensure t
;;   :bind (("C-c m" . magit-status)))


;;; git-gutter+
;; (use-package git-gutter+ :ensure t
;;   :bind (("C-c g" . global-git-gutter+-mode))
;;   :config
;;   (global-git-gutter+-mode t)
;;   (setq git-gutter+-modified-sign " ")
;;   (setq git-gutter+-added-sign " ")
;;   (setq git-gutter+-deleted-sign " ")
;;   (eval-after-load 'git-gutter+
;;     '(progn
;;        ;(define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
;;        ;(define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
  
;;        (define-key git-gutter+-mode-map (kbd "C-x g s") 'git-gutter+-show-hunk)
;;        (define-key git-gutter+-mode-map (kbd "C-x g r") 'git-gutter+-revert-hunks)
;;        ;; Stage hunk at point.
;;        ;; If region is active, stage all hunk lines within the region.
;;        (define-key git-gutter+-mode-map (kbd "C-x g t") 'git-gutter+-stage-hunks)
;;        (define-key git-gutter+-mode-map (kbd "C-x g c") 'git-gutter+-commit)
;;        (define-key git-gutter+-mode-map (kbd "C-x g C") 'git-gutter+-stage-and-commit)
;;        ;(define-key git-gutter+-mode-map (kbd "C-x g C-y") 'git-gutter+-stage-and-commit-whole-buffer)
;;        (define-key git-gutter+-mode-map (kbd "C-x g U") 'git-gutter+-unstage-whole-buffer))))


;;; quickrun
;; (use-package quickrun :ensure t
;;   :bind ("<f5>" . quickrun-sc)
;;   :config
;;   (defun quickrun-sc (start end)
;;     (interactive "r")
;;     (if mark-active
;;         (quickrun :start start :end end)
;;       (quickrun))))


;;; erc
;; (use-package erc-join
;;   :config
;;   (setq erc-server-coding-system '(iso-2022-jp . iso-2022-jp))
;;   (setq erc-beep-match-types '(current-nick keyword))
;;   (add-hook 'erc-text-matched-hook '(lambda (&rest args) (start-process-shell-command "afplay" nil "afplay" "~/Library/Mobile\\ Documents/com~apple~CloudDocs/.config/sound/pow.aiff")))
;;   (add-hook 'erc-insert-pre-hook '(lambda (&rest args) (start-process-shell-command "afplay" nil "afplay" "~/Library/Mobile\\ Documents/com~apple~CloudDocs/.config/sound/pop.aiff")))
;;   (erc-autojoin-mode 1)
;;   (setq erc-default-server "irc2.juggler.jp")
;;   (setq erc-autojoin-channels-alist
;;     '(("juggler.jp" "!プログラミング"))))


;;; navi2ch
;; (use-package navi2ch :ensure t
;;   :bind (("C-c o 2" . navi2ch))
;;   :config
;;   (setq navi2ch-net-http-proxy "localhost:8080")
;;   (shell-command "perl /Users/tutinoco/Documents/Config/emacs/2chproxy.pl --kill")
;;   (shell-command "rm /tmp/2chproxy.pid")
;;   (async-shell-command "perl /Users/tutinoco/Documents/Config/emacs/2chproxy.pl")
;;   (custom-set-variables
;;     '(navi2ch-article-use-jit t)
;;     '(navi2ch-article-exist-message-range nil)
;;     '(navi2ch-article-new-message-range nil)
;;     '(navi2ch-mona-enable t)
;;     '(navi2ch-mona-use-ipa-mona t)
;;     '(navi2ch-mona-ipa-mona-font-family-name "mona-izmg16"))
;;   (setq navi2ch-net-user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0 ")
;;   (setq navi2ch-search-web-search-method 'navi2ch-search-union-method)
;;   (setq navi2ch-search-union-method-list '(navi2ch-search-find-2ch-method navi2ch-search-hula-method))
;;   (navi2ch-mona-setup))


;; mobile-org
;; (setq org-directory "~/.emacs.d/org")
;; (setq org-mobile-inbox-for-pull "~/.emacs.d/org/flagged.org")
;; (setq org-mobile-directory "/Volumes/A/Dropbox (Personal)/Apps/MobileOrg")
