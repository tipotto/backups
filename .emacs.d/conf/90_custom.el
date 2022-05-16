;; Emacsが自動的に書き込む設定をcustom.elに保存します。
(setq custom-file (locate-user-emacs-file "~/.emacs.d/custom.el"))

;; カスタムファイルが存在しない場合は作成します。
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

;; カスタムファイルを読み込みます。
(load custom-file)
