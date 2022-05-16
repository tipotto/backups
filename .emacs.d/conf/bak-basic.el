;;; Emacsの基本設定を施します。
(progn 

  ;; 文字化け対策を施します。
;;  (set-language-environment 'Japanese)
;;  (prefer-coding-system 'utf-8)

  ;; Emacs起動時にスタートアップ画面を表示しないように設定します。
  (setq inhibit-startup-message t)

  ;; emacs終了時に終了の確認を行うようにします。
  (setq confirm-kill-emacs 'y-or-n-p)

  ;; 削除確認などでyes/noと入れる代わりにy/nを使えるようにします。
  (fset 'yes-or-no-p 'y-or-n-p)

  ;; ビープ音を禁止します。
  (setq ring-bell-function 'ignore)

  ;; kill-line (C-k) で行全体をカットする時に空行を残さないようにします。
  (setq kill-whole-line t)

  ;; png, jpg などのファイルを画像として表示します。
;;  (setq auto-image-file-mode t)

  ;; タイトルバーにファイルのフルパスを表示します。
  (setq frame-title-format "%f")
  
  ;; メニューを非表示にします。
  (menu-bar-mode -1)
  
  ;; 文字列が画面端で自動的に折り返されないようにし
  ;; 画面から文字が切捨られるときに表示される文字を変更します。
  (set-default 'truncate-lines t)
  (set-display-table-slot standard-display-table 0 ?⠤)
  (set-display-table-slot standard-display-table 1 ?↵)
  (set-display-table-slot standard-display-table 5 ?¦)

  ;; コマンドのエコーを素早くします。
  (setq echo-keystrokes 0.1)

  ;; バッファ対象のファイルに変更のあった場合に自動再読み込みします。
;;  (global-auto-revert-mode 1)

  ;; 同名のバッファが存在する場合にはディレクトリ名を付与して区別できるようにします。
;;  (use-package uniquify
;;    :config
;;    (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

  ;; スクラッチバッファの初期テキストを空にします。
  (setq initial-scratch-message "")
  
  ;; スクラッチバッファを自動的に保存するようにします。
  (use-package scratch-log :ensure t)
  
  ;; モードラインにカーソルの位置を表示します。
;;  (column-number-mode t)
  
  ;; 対応するカッコを強調表示するように設定します。
  (show-paren-mode t)
  
  ;; find-fileでURLを開けるようにします。
;;  (url-handler-mode 1)
  
  ;; タブを無効化してスペースを挿入するようにします。
  (setq-default indent-tabs-mode nil)
  
  ;; デフォルトディレクトリを変更します。
;;  (setq default-directory "~/") 
;;  (setq command-line-default-directory "~/")

  ;; ファイル名の補完で大文字小文字を区別しないようにします。
;;  (setq read-buffer-completion-ignore-case t)
;;  (setq read-file-name-completion-ignore-case t)

  ;; バッファメニューを開くときにウインドウを分割しないようにします。
;;  (bind-key "C-x C-b" 'buffer-menu)

  ;; 基本カラーを設定します。
;;  (when (not window-system)
;;    ;(list-colors-display)
;;    ;(list-faces-display)
;;  
;;    (set-face-foreground 'font-lock-comment-face "brightblack") ; コメントの色を設定
;;    (set-face-foreground 'font-lock-function-name-face "brightblue") ; 関数名の色
;;    (set-face-foreground 'font-lock-keyword-face "red") ; 関数名の色
;;    (set-face-foreground 'font-lock-string-face "yellow") ; 文字列の色
;;    (set-face-foreground 'font-lock-variable-name-face "brightmagenta") ; 変数名の色
;;    (set-face-foreground 'font-lock-constant-face "green") ; 予約語の色
;;  
;;    (set-face-attribute 'region nil :foreground "black") ; 選択された文字色
;;    (set-face-attribute 'region nil :background "white") ; 選択された文字の背景色
;;    
;;    (set-face-background 'mode-line "brightwhite") ; アクティブなモードライン文字色
;;    (set-face-foreground 'mode-line "black") ; アクティブなモードライン背景色
;;    (set-face-background 'mode-line-inactive "brightblack") ; モードライン文字色
;;    (set-face-foreground 'mode-line-inactive "black")) ; モードライン背景色

  ;; クリップボードをOSと共有します。
  (when (and (executable-find "xclip")
						 (eq system-type 'gnu/linux))
		(require 'xclip)
    (xclip-mode 1))

	(when (eq system-type 'darwin)
		 (use-package pbcopy :ensure t
    :config
    (turn-on-pbcopy)))
  
  ;; ウインドウ分割時にカーソルを分割先に移動するようにします。
  (bind-key "C-x 2" '(lambda () (interactive) (split-window-below) (other-window 1)))
  (bind-key "C-x 3" '(lambda () (interactive) (split-window-right) (other-window 1)))
  (defadvice grep-find (after move-point-to-grep-find-window activate) (other-window 1))
  (defadvice occur (after move-point-to-grep-occur-window activate) (other-window 1))

  ;; 非アクティブウインドウを暗転させます。
  (use-package hiwin :ensure t
    :config
    (hiwin-activate)
    
    ; 色を設定します。
    (when (not window-system)
      (set-face-background 'hiwin-face "black")))
  
  ;; trampを拡張してsshでsudoアクセスできるようにします。
;;  (put 'temporary-file-directory 'standard-value '((file-name-as-directory "/tmp")))
;;  ;(setenv "TMPDIR" "/tmp")
;;  (use-package tramp
;;    :config
;;    (require 'ange-ftp)
;;    (add-to-list 'tramp-remote-process-environment "HISTFILE=/dev/null")
;;    (add-to-list 'tramp-default-proxies-alist
;;                 '(nil "\\`root\\'" "/ssh:%h:"))
;;    (add-to-list 'tramp-default-proxies-alist
;;                 '("localhost" nil nil))
;;    (add-to-list 'tramp-default-proxies-alist
;;                 '((regexp-quote (system-name)) nil nil))

	;; multi-termを使えるようにします。
	(when (require 'multi-term nil t)
		(setq multi-term-program "/usr/bin/zsh"))

	;; Helmを使えるようにします。
	(require 'helm-config)

	;; helm-c-moccurを使えるようにします。
	;; helm-c-moccurは現在メンテナンスされておらず、リポジトリも削除されている。
	;; 同様の機能であるhelm-occurがhelm本家に存在するため、そちらを利用する。
	;(when (require 'helm-c-moccur nil t)
	;  (setq
  ;   ;; 執筆時点でエラーが出たため定義しているが、
  ;   ;; 将来的には不要になる可能性が高い
  ;   helm-idle-delay 0.1
  ;   ;; helm-c-moccur用 `helm-idle-delay'
  ;   helm-c-moccur-helm-idle-delay 0.1
  ;   ;; バッファの情報をハイライトする
  ;   helm-c-moccur-higligt-info-line-flag t
  ;   ;; 現在選択中の候補の位置をほかのwindowに表示する
  ;   helm-c-moccur-enable-auto-look-flag t
  ;   ;; 起動時にポイントの位置の単語を初期パターンにする
  ;   helm-c-moccur-enable-initial-pattern t)
  ;  ;; C-c mにhelm-c-moccur-occur-by-moccurを割り当てます。
  ;  (global-set-key (kbd "C-c m") 'helm-c-moccur-occur-by-moccur))
	
	;; helm-occurを使えるようにします。
	(global-set-key (kbd "C-c h") 'helm-occur)
	
	;; color-moccurを使えるようにします。
  (when (require 'color-moccur nil t)
    ;; C-c mにoccur-by-moccurを割り当て
    (global-set-key (kbd "C-c m") 'occur-by-moccur)
    ;; スペース区切りでAND検索
    (setq moccur-split-word t)
    ;; ディレクトリ検索で除外するファイル
    (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
    (add-to-list 'dmoccur-exclusion-mask "^#.+#$"))

	;; moccur-editを使えるようにします。
	;; 一度編集内容を保存すると、編集行がハイライトされる。
	;; 同じ行を再度編集したい場合は、moccur-edit-modeでC-x kを入力することでハイライトを解除できる。
	;; ハイライトを解除しないまま編集すると、ファイルに変更内容が反映されない。
  (require 'moccur-edit nil t)
	;; moccur-edit-finish-editと同時にファイルを保存します。
  (defadvice moccur-edit-change-file
    (after save-after-moccur-edit-buffer activate)
    (save-buffer))

	;; Auto complete modeを使えるようにします。
	(when (require 'auto-complete-config nil t)
    (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
    (ac-config-default)
    (setq ac-use-menu-map t)
    (setq ac-ignore-case nil))

	;; wgrepを使えるようにします。
	;; M-x grepで起動した後、コマンドのオプションを削除すると正常に動作しない。
	;; そのため、検索ワードや検索対象ファイルはeオプションに続けて指定する。
  (require 'wgrep nil t)

  ;; ediffの設定をします。
  ;(use-package ediff
  ;  :config
  ;  (setq ediff-window-setup-function 'ediff-setup-windows-plain) ; コントロール用のバッファを同一フレーム内に表示
  ;  (setq ediff-split-window-function 'split-window-horizontally) ; diffのバッファを上下ではなく左右に並べる

    ;; 色を設定します。
  ;  (when (not window-system)
  ;    (set-face-foreground 'ediff-odd-diff-A "red")
  ;    (set-face-background 'ediff-odd-diff-A "brightblack")
  ;    (set-face-foreground 'ediff-odd-diff-B "red")
  ;    (set-face-background 'ediff-odd-diff-B "brightblack")
  ;    (set-face-foreground 'ediff-odd-diff-C "red")
  ;    (set-face-background 'ediff-odd-diff-C "brightblack")
  ;    (set-face-foreground 'ediff-even-diff-A "red")
  ;    (set-face-background 'ediff-even-diff-A "brightblack")
  ;    (set-face-foreground 'ediff-even-diff-B "red")
  ;    (set-face-background 'ediff-even-diff-B "brightblack")
  ;    (set-face-foreground 'ediff-even-diff-C "red")
  ;    (set-face-background 'ediff-even-diff-C "brightblack")
  ;    (set-face-foreground 'ediff-current-diff-A "red")
  ;    (set-face-background 'ediff-current-diff-A "brightblack")
  ;    (set-face-foreground 'ediff-current-diff-B "red")
  ;    (set-face-background 'ediff-current-diff-B "brightblack")
  ;    (set-face-foreground 'ediff-current-diff-C "red")
  ;    (set-face-background 'ediff-current-diff-C "brightblack")
  ;    (set-face-foreground 'ediff-fine-diff-A "black")
  ;    (set-face-background 'ediff-fine-diff-A "white")
  ;    (set-face-foreground 'ediff-fine-diff-B "black")
  ;    (set-face-background 'ediff-fine-diff-B "white")
  ;    (set-face-foreground 'ediff-fine-diff-C "black")
  ;    (set-face-background 'ediff-fine-diff-C "white")))
)
