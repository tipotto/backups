;;; Emacsの初期設定を施します。
(progn

  ;; パッケージリポジトリを追加します。
  ;; (require 'package nil t)
  (require 'package) ; package.elを有効化します。
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize) ; インストール済みのElispを読み込みます。

  ;; use-packageを自動的に利用可能な状態にします。
  (when (not (package-installed-p 'use-package))
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package)
  
  ;; 先に読み込まなければならないパッケージを読み込みます。
  (use-package smartrep :ensure t)

  ;; Emacsが自動的に書き込む設定をcustom.elに保存します。
  (setq custom-file (locate-user-emacs-file "~/.emacs.d/custom.el"))
  
  ;; カスタムファイルが存在しない場合は作成します。
  (unless (file-exists-p custom-file)
    (write-region "" nil custom-file))
  
  ;; カスタムファイルを読み込みます。
  (load custom-file)
  
)
