;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)

(progn

  ;; 自作関数を作成してload-pathの設定を行います。
  ;; add-to-list関数を使うことで、サブディレクトリも自動的にload-pathに追加します。
  ;; init-loaderを実行する前に定義する必要あり。
  ;; init-loader.elがあるelispフォルダにロードパスが設定されていないためだと思われる。
  (defun add-to-load-path (&rest paths)
    (let (path)
      (dolist (path paths paths)
        (let ((default-directory
                (expand-file-name (concat user-emacs-directory path))))
          (add-to-list 'load-path default-directory)
          (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
              (normal-top-level-add-subdirs-to-load-path))))))

  ;; 引数のディレクトリとそのサブディレクトリをload-pathに追加します。
  (add-to-load-path "elisp" "conf" "public_repos")
  
  ;;; init-loaderを設定します。
  (require 'init-loader)
  (setq init-loader-show-log-after-init 'error-only)
  (init-loader-load "~/.emacs.d/conf")
  
)


