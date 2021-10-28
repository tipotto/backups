
((digest . "30c495bc03b2febdfca3773cf762caed") (undo-list nil (38 . 41) nil ("
" . -38) ((marker . 176) . -1) ((marker . 38) . -1) ((marker . 38) . -1) ("
" . -39) ((marker . 176) . -1) ((marker . 38) . -1) ((marker . 38) . -1) ("
" . -40) ((marker . 176) . -1) ((marker . 38) . -1) ((marker . 38) . -1) ("
" . -41) ((marker . 176) . -1) 42 nil (";;; Diredの詳細設定を施します。
  (use-package dired
  :config
  
  ;; 削除したファイルをゴミ箱へ移動するようにします。
  (setq delete-by-moving-to-trash t)

  ;; diredのが利用するlsコマンドのオプションを変更します。
  ;(setq dired-listing-switches \"-Ahl\")

  ;; diredにFinderで開く機能を追加します。
  ;;(define-key dired-mode-map (kbd \"F\") '(lambda () (interactive) (shell-command (concat \"open .\"))))

  ;; diredでのウィンドウを２つ開いている時にコピーや移動のデフォルトパスをもう一方で開いてるディレクトリにする。
  ;; (setq dired-dwim-target t)
  
  ;; diredでインクリメンタルサーチした時にファイル名だけにマッチするようにする。
  (setq dired-isearch-filenames t)
  
  ;; wdiredを有効にして簡単にリネームできるようにします。
  (require 'wdired)
  (define-key dired-mode-map \"r\" 'wdired-change-to-wdired-mode)
  (define-key wdired-mode-map \"\\C-g\" 'wdired-abort-changes)
  (setq wdired-allow-to-change-permissions t)
  
  ;; ディレクトリを再起的にコピーする設定にします。
  (setq dired-recursive-copies 'always)
  )
" . 41) ((marker . 176) . -816) ((marker . 1) . -334) ((marker) . -816) ((marker) . -816) 857 (t 24092 8929 10030 852000) nil ("
" . 857) ((marker*) . 1) ((marker) . -1) nil ("
" . 62) ((marker*) . 1) ((marker) . -1) nil ("
" . 41) ((marker*) . 1) ((marker) . -1) nil ("  " . 41) (41 . 43) (41 . 42) nil (63 . 65) ("  " . 62) (62 . 64) (62 . 63) nil (855 . 856) (851 . 853) (852 . 853) nil ("  " . 40) (40 . 42) (40 . 41) nil ("  
" . 852) ((marker) . -3) nil (40 . 852) nil (40 . 42) ("  " . 39) ((marker) . -2) (38 . 42) (t 24092 7224 94481 450000) nil ("k" . -1) ((marker) . -1) 2 nil (1 . 2) (t 24092 7173 871553 81000) nil ("
" . 5736) nil ("
" . 6965) nil (6569 . 6965) nil (6567 . 6569) nil undo-tree-canary))
