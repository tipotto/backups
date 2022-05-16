;;; バックアップに関する設定を施します。
(progn
  
  ;; Emacsの自動保存ファイルの保存先を変更します。
  (setq backup-directory "~/.emacs.d/autosave/")
  (if (file-directory-p backup-directory) nil (make-directory backup-directory))
  (setq backup-directory-alist
    (cons (cons ".*" (expand-file-name backup-directory))
          backup-directory-alist))
  (setq auto-save-file-name-transforms
    `((".*", (expand-file-name backup-directory) t)))
  
  ;; バックアップファイルを世代管理して保存先を変更します。
  (when (setq make-backup-files t)
    (setq version-control t)       ;; 複数のバックアップ世代を管理します。
    (setq kept-old-versions 0)     ;; 古いものをいくつ残すか
    (setq kept-new-versions 65535) ;; 新しいものをいくつ残すか
    (setq delete-old-versions t)   ;; 確認せずに古いものを消します。
    (setq vc-make-backup-files t)) ;; バージョン管理下のファイルもバックアップを作ります。
  
  ;; ファイルを保存するたびにバックアップするようにします。
  (add-hook 'before-save-hook
    '(lambda () (interactive) (setq backup-directory-alist (cons (cons "\\.*$" (format-time-string (expand-file-name "~/.emacs.d/backup/%Y%m%d/"))) backup-directory-alist))))
  (bind-key "C-x C-s" '(lambda () (interactive) (save-buffer 16)))
  
)
