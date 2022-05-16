;;
;; hostごとの設定があれば読み込む
;;
;;(setq init_host (concat "~/.emacs.d/local/init_" (system-name) ".el"))
;;(if (file-exists-p init_host)
;;    (load-file init_host))

;;
;; パッケージ管理(package.el)の設定
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加します。
(add-to-load-path "conf" "elisp")
;;(add-to-load-path "elisp" "conf" "public_repos")

;; use-packageを自動的に利用可能な状態にします。
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; 先に読み込まなければならないパッケージを読み込みます。
(use-package smartrep :ensure t)
