;;; Emacsのモードに関する設定を施します。
(progn 

  ;; css-modeを追加します。
  (use-package css-mode
    :config
    (add-to-list 'auto-mode-alist '("\\.less?\\'" . css-mode))
    (setq css-indent-offset 2))
  
  ;; web-modeを追加します。
  (use-package web-mode :ensure t
    :config
    (add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
    ;(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
    
    ;; タブ幅を2文字分に設定します。
    (setq-default tab-width 2)
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-script-padding 2)

    ; 閉じタグを自動的に補完します。
    (setq web-mode-enable-auto-closing t)

    ; 色を設定します。
    (when (not window-system)
      (set-face-foreground 'web-mode-html-attr-custom-face "brightmagenta")
      ;(set-face-foreground 'web-mode-html-attr-engine-face "green")
      (set-face-foreground 'web-mode-html-attr-equal-face "green")
      (set-face-foreground 'web-mode-html-attr-name-face "brightblue")
      (set-face-foreground 'web-mode-html-tag-bracket-face "green")
      ;(set-face-foreground 'web-mode-html-tag-custom-face "brightred")
      (set-face-foreground 'web-mode-html-tag-face "red")))
  
  ;; markdownモードでは文字列が画面端で自動的に折り返されるようにします。
  ;; (use-package markdown-mode :ensure t
  ;;   :config
  ;;   (add-hook 'markdown-mode-hook
  ;;     '(lambda () (interactive) (set-default 'truncate-lines nil))))

  ;; smerge-mode
  ;; (add-hook 'smerge-mode-hook
  ;;   '(lambda ()
  ;;     ; 色を設定します。
  ;;     (when (not window-system)
  ;;       (set-face-foreground 'smerge-markers "brightwhite")
  ;;       (set-face-background 'smerge-markers "brightblack"))))

  (defun js-indent-hook ()
    ;; インデント幅を2にする
    (setq js-indent-level 2
          js-expr-indent-offset 2
          indent-tabs-mode nil)
    
    ;; switch文のcaseラベルをインデントする関数を定義する
    ;(defun my-js-indent-line ()
    ;  (interactive)
    ;  (let* ((parse-status (save-excursion (syntax-ppss (point-at-bol))))
    ;         (offset (- (current-column) (current-indentation)))
    ;         (indentation (js--proper-indentation parse-status)))
    ;    (back-to-indentation)
    ;    (if (looking-at "case\\s-")
    ;        (indent-line-to (+ indentation 2))
    ;      (js-indent-line))
    ;    (when (> offset 0) (forward-char offset))))
    ;
    ;;; caseラベルのインデント処理をセットする
    ;(set (make-local-variable 'indent-line-function) 'my-js-indent-line)
  )

  ;; js-modeの起動時にhookを追加します。
	;; インデント幅を2に設定します。
  (add-hook 'js-mode-hook 'js-indent-hook)

	;; js2-modeをメジャーモードとして追加します。
  ;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

	;; js2-modeをマイナーモードとして追加します。
	;(add-hook 'js-mode-hook 'js2-minor-mode)

  ;; js2-jsx-modeをメジャーモードとして追加します。(js, jsx対応)
	;(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))

	;; 構文チェックのためにflycheckを有効にします。
  (add-hook 'after-init-hook #'global-flycheck-mode)

  ;(with-eval-after-load 'flycheck
  ;   (flycheck-pos-tip-mode))

	;; C-c C-vでPythonの構文チェックを行います。
  (setq python-check-command "flake8")
)
