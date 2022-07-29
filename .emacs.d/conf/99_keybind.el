(global-set-key (kbd "C-c p") 'multi-term-next)
(global-set-key (kbd "C-c n") 'multi-term-prev)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
;(global-set-key (kbd "M-x") 'shell-command)

;; eval-bufferを一手間省略します。
;(advice-add 'eval-buffer :after '(lambda () (message "Buffer is evaluated.")))
;(advice-add 'eval-buffer :before '(lambda () (message "Buffer is evaluated.")))
(global-set-key (kbd "C-c C-e") 'eval-buffer)

;; goto-lineを一手間省略します。
(global-set-key (kbd "M-g") 'goto-line)

;; describe-functionを一手間省略します。
(global-set-key (kbd "C-c f") 'describe-function)

;; describe-variableを一手間省略します。
(global-set-key (kbd "C-c v") 'describe-variable)

;; nyxtに気軽にアクセスできるようにします。
;(global-set-key (kbd "C-c o w") 'eww)
(global-set-key (kbd "C-c o w") '(lambda () (interactive) (async-shell-command "nyxt")))

;; C-uをカーソル位置から行頭まで1行削除に割り当てます。
(global-set-key (kbd "C-u") '(lambda (arg) (interactive "p") (kill-line 0)))

;; C-hをバックスペース（1文字削除）に割り当てます。
(keyboard-translate ?\C-h ?\177)

;; M-rでバッファを更新できるようにします。
;;(global-set-key (kbd "M-r") 'revert-buffer)

;; C-c C-fにhelm-for-filesを割り当てます。
(global-set-key (kbd "C-c C-f") 'helm-for-files)

;; M-yにhelm-show-kill-ringを割り当てます。
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; list-packageに気軽にアクセスできるようにします。
(global-set-key (kbd "C-c o l") 'list-packages)

;; multi-termに気軽にアクセスできるようにします。
(global-set-key (kbd "C-c o t") 'multi-term)

;; .emacs.dディレクトリに気軽にアクセスできるようにします。
(global-set-key (kbd "C-c o e") '(lambda () (interactive) (find-file (kbd "~/.emacs.d/"))))

;; スクラッチバッファに気軽にアクセスできるようにします。
(global-set-key (kbd "C-c o s") '(lambda () (interactive) (switch-to-buffer "*scratch*")))

;; ウインドウ切替を「C-x o o o ...」で連続実行できるようにし
;; また「f, b, n, p」で上下左右に移動できるようにします。
;(global-set-key (kbd "C-o") 'other-window)
;(global-set-key (kbd "C-O") '(other-window -1))
(global-set-key (kbd "C-x o") (lambda () 
  (interactive) 
  (funcall (smartrep-map '(
    ("a" . avy-goto-line)
    ("b" . windmove-left) 
    ("f" . windmove-right) 
    ("p" . windmove-up) 
    ("n" . windmove-down) 
    ("o" . other-window) 
    ("O" . (other-window -1)))))))
(global-set-key (kbd "C-x O") (lambda ()
  (interactive) 
  (funcall (smartrep-map '(
    ("a" . avy-goto-line)
    ("b" . windmove-left) 
    ("f" . windmove-right) 
    ("p" . windmove-up) 
    ("n" . windmove-down) 
    ("o" . other-window) 
    ("O" . (other-window -1)))))))

(require 'go-translate)

;; your languages pair used to translate
(setq gts-translate-list '(("en" "ja") ("ja" "en")))

(defconst deepl-api-key "746f8e9b-0613-9745-d239-559aa5eece7c:fx")
(defvar my-translator-n
  (gts-translator :picker (gts-prompt-picker)
                  :engines (list (gts-deepl-engine :auth-key deepl-api-key :pro nil))
                  :render (gts-buffer-render)))

(cl-defmethod gts-translate :before ((o gts-engine) task callback)
  (with-slots (text) task
    (setf text (replace-regexp-in-string "\n" " " text))))

(defun translate ()
  (interactive)
  (gts-translate my-translator-n))

(global-set-key (kbd "C-c t") 'translate)

