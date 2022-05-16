(global-set-key (kbd "C-c p") 'multi-term-next)
(global-set-key (kbd "C-c n") 'multi-term-prev)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; goto-lineを一手間省略します。
(bind-key "M-g" 'goto-line)

;; describe-functionを一手間省略します。
(bind-key "M-d" 'describe-function)

;; ewwに気軽にアクセスできるようにします。
(bind-key "C-c o w" 'eww)

;; C-uをカーソル位置から行頭まで1行削除に割り当てます。
(bind-key "C-u" '(lambda (arg) (interactive "p") (kill-line 0)))

;; C-hをバックスペース（1文字削除）に割り当てます。
(keyboard-translate ?\C-h ?\177)

;; M-rでバッファを更新できるようにします。
;;(bind-key "M-r" 'revert-buffer)

;; C-c C-fにhelm-for-filesを割り当てます。
;;(global-unset-key (kbd "C-c C-f"))
(global-set-key (kbd "C-c C-f") 'helm-for-files)

;; M-yにhelm-show-kill-ringを割り当てます。
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; list-packageに気軽にアクセスできるようにします。
(bind-key "C-c o l" 'list-packages)

;;(add-hook 'term-mode-hook (lambda () (read-only-mode 0)))
(bind-key "C-c o t" 'multi-term)

;; .emacs.dディレクトリに気軽にアクセスできるようにします。
(bind-key "C-c o e" '(lambda () (interactive) (find-file "~/.emacs.d/")))

;; スクラッチバッファに気軽にアクセスできるようにします。
(bind-key "C-c o s" '(lambda () (interactive) (switch-to-buffer "*scratch*")))

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
