;; 文字サイズを設定します。
(set-face-attribute 'default nil :height 170)

;; 起動時の画面サイズを設定します。
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Emacs起動時にスタートアップ画面を表示しないように設定します。
(setq inhibit-startup-message t)

;; emacs終了時に終了の確認を行うようにします。
(setq confirm-kill-emacs 'y-or-n-p)

;; 削除確認などでyes/noと入れる代わりにy/nを使えるようにします。
(fset 'yes-or-no-p 'y-or-n-p)

(setq kill-buffer-query-functions nil)

(setq async-shell-command-buffer 'new-buffer)

(add-to-list 'display-buffer-alist '("*Async Shell Command*" display-buffer-no-window (nil)))

;; ビープ音を禁止します。
(setq ring-bell-function 'ignore)

;; kill-line (C-k) で行全体をカットする時に空行を残さないようにします。
(setq kill-whole-line t)

;; タイトルバーにファイルのフルパスを表示します。
(setq frame-title-format "%f")

;; メニューバーを非表示にします。
(menu-bar-mode -1)

;; ツールバーを非表示にします。
(tool-bar-mode -1)

;; スクロールバーを非表示にします。
(toggle-scroll-bar -1)

;; 文字列が画面端で自動的に折り返されないようにし
;; 画面から文字が切捨られるときに表示される文字を変更します。
(set-default 'truncate-lines t)
(set-display-table-slot standard-display-table 0 ?⠤)
(set-display-table-slot standard-display-table 1 ?↵)
(set-display-table-slot standard-display-table 5 ?¦)

;; コマンドのエコーを素早くします。
(setq echo-keystrokes 0.1)

;; スクラッチバッファの初期テキストを空にします。
(setq initial-scratch-message nil)
  
;; スクラッチバッファを自動的に保存するようにします。
(use-package scratch-log :ensure t)

;; 対応するカッコを強調表示するように設定します。
(show-paren-mode t)

;; タブを無効化してスペースを挿入するようにします。
;;(setq-default indent-tabs-mode nil)

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

; 非アクティブウインドウを暗転させます。
;;(use-package hiwin :ensure t
;;  :config
;;  (hiwin-activate)
;;  
;;  ; 色を設定します。
;;  (when (not window-system)
;;    (set-face-background 'hiwin-face "black")))

