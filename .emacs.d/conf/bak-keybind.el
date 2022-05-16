;;; Emacsの基本キーバインド設定を施します。
(progn

  (global-set-key (kbd "C-c p") 'multi-term-next)
  (global-set-key (kbd "C-c n") 'multi-term-prev)
	
;;  (bind-key "C-c a" 'my-append-to-buffer)
;;  (bind-key "C-c c" 'my-copy-to-buffer)
;;  (bind-key "C-c i" 'my-insert-buffer)

  ;; goto-lineを一手間省略します。
  (bind-key "M-g" 'goto-line)

  ;; EWW
  (bind-key "C-c o w" 'eww)

  ;; 指定した関数の説明を読めるようにします。
;;  (bind-key "C-x f" 'describe-function)

  ;; 画面からはみ出した行の折り返しを切り替えられるようにします。
;;  (global-set-key (kbd "C-c l") 'toggle-truncate-lines)

  ;; universal-argumentをC-uからC-M-uに変更します。
;;  (bind-key "C-c @" 'universal-argument)
  
  ;; ターミナル操作でお馴染みの文字入れ替え操作を適応します。
;;  (bind-key "C-t" 'transpose-chars)
  
  ;; C-uをカーソル位置から行頭まで1行削除に割り当てます。
  (bind-key "C-u" '(lambda (arg) (interactive "p") (kill-line 0)))
    
  ;; C-hをバックスペース（1文字削除）に割り当てます。
  (keyboard-translate ?\C-h ?\177)
    
  ;; M-rでバッファを更新できるようにします。
;;  (bind-key "M-r" 'revert-buffer)

  ;; C-c C-fにhelm-for-filesを割り当てます。
  (global-set-key (kbd "C-c C-f") 'helm-for-files)

  ;; M-yにhelm-show-kill-ringを割り当てます。
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
	
  ;; list-packageに気軽にアクセスできるようにします。
  (bind-key "C-c o l" 'list-packages)

  ;; multi-termに気軽にアクセスできるようにします。
  (bind-key "C-c o t" 'multi-term)
  
  ;; init.elに気軽にアクセスできるようにします。
;;  (defun open-emacs-config () (interactive) (find-file "~/.emacs.d/init.el"))
;;  (bind-key "C-c o i" 'open-emacs-config)
;;  (bind-key "C-c o i" '(lambda () (interactive) (find-file "~/.emacs.d/init.el")))

  ;; .emacs.dディレクトリに気軽にアクセスできるようにします。
  (defun open-emacs-dir () (interactive) (find-file "~/.emacs.d/"))
  (bind-key "C-c o e" 'open-emacs-dir)
  
  ;; スクラッチバッファに気軽にアクセスできるようにします。
  (defun open-scratch () (interactive) (switch-to-buffer "*scratch*"))
  (bind-key "C-c o s" 'open-scratch)
  ;(bind-key "C-c o s" '(lambda () (interactive) (switch-to-buffer "*scratch*")))

  ;; Trampで気軽にリモートサーバーにsshアクセスできるようにします。
;;  (defun ssh-by-tramp () (interactive) (find-file "/ssh:tipotto404@markets|sudo:root@markets:/var/www"))
;;  (defun ssh-by-tramp () (interactive) (find-file "/ssh:tipotto404@markets|sudo:markets:/var/www"))
;;  (bind-key "C-c s s h" 'ssh-by-tramp)
;;  (bind-key "C-c s s h" '(lambda () (interactive) (find-file "/ssh:tipotto404@markets|sudo:root@markets:/var/www")))
  
  ;; keyhacのconfig.pyファイルに素早く移動できるできるようにします。
;;  (defun open-keyhac-config () (interactive) (find-file "~/Library/Mobile Documents/com~apple~CloudDocs/.config/KeyBindings/DefaultKeyBinding.dict"))
;;  (bind-key "C-c o k" 'open-keyhac-config)
  
  ;; .ssh/configに気軽にアクセスできるようにします。
;;  (defun open-ssh-config () (interactive) (find-file "~/.ssh/config"))
;;  (bind-key "C-c o h" 'open-ssh-config)
)
