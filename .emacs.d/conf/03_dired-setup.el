;;; Diredの詳細設定を施します。
(use-package dired
  :config
  
  ;; 削除したファイルをゴミ箱へ移動するようにします。
  (setq delete-by-moving-to-trash t)

  ;; diredのが利用するlsコマンドのオプションを変更します。
  ;(setq dired-listing-switches "-Ahl")

  ;; diredにFinderで開く機能を追加します。
  ;;(define-key dired-mode-map (kbd "F") '(lambda () (interactive) (shell-command (concat "open ."))))

  ;; diredでウィンドウを２つ開いている時にコピーや移動のデフォルトパスをもう一方で開いてるディレクトリにします。
  ;; (setq dired-dwim-target t)
  
  ;; diredでインクリメンタルサーチした時にファイル名だけにマッチするようにします。
  (setq dired-isearch-filenames t)
  
  ;; wdiredを有効にして簡単にリネームできるようにします。
  (require 'wdired)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
  (define-key wdired-mode-map "\C-g" 'wdired-abort-changes)
  (setq wdired-allow-to-change-permissions t)
  
  ;; ディレクトリを再起的にコピーする設定にします。
  (setq dired-recursive-copies 'always)
)
