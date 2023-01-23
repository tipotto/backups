;(define-configuration (buffer internal-buffer editor-buffer prompt-buffer web-buffer)
;  ((override-map (let ((map (make-keymap "override-map")))
;                   (define-key map
;                     "C-h" 'nothing
;		     )))))

(defvar *custom-emacs-keymap* (make-keymap "custom-emacs-map"))

(define-key *custom-emacs-keymap*
  "C-s C-s" 'nyxt/search-buffer-mode:search-buffer
  "C-x k" 'delete-current-buffer
  "C-x C-k" 'delete-all-buffers
  "C-c C-f" 'nyxt/buffer-listing-mode:list-buffers
  "C-c p" 'switch-buffer-next
  "C-c n" 'switch-buffer-previous
  ;"C-v" 'nyxt/visual-mode:visual-mode
  ;"S-f" 'nyxt/history-mode:history-forwards
  ;"S-b" 'nyxt/history-mode:history-backwards
  "C-;" 'nyxt/hint-mode:follow-hint
  "C-c c" 'describe-command
  "C-c f" 'describe-function
  "S-f" 'nyxt/document-mode:focus-first-input-field
  )

(define-mode custom-emacs-mode ()
  "Mode for the custom key bindings in `*custom-emacs-keymap*'."
  ((keyscheme-map (keymaps:make-keyscheme-map
                   nyxt/keyscheme:emacs *custom-emacs-keymap*
		   ))))

(define-configuration (buffer context-buffer)
  ((default-modes (append '(custom-emacs-mode) %slot-value%))))

;(define-configuration base-mode
;  ((keyscheme-map
;    (define-keyscheme-map "my-base" (list :import %slot-default%)
;      keyscheme:vi-normal
;      (list "g b" (lambda-command switch-buffer* ()
;                      (switch-buffer :current-is-last-p t)))))))

(define-configuration nyxt/visual-mode:visual-mode
  ((keyscheme-map
    (define-keyscheme-map "custom-visual" (list :import %slot-default%)
      nyxt/keyscheme:emacs
      (list
       "C-v" 'nyxt/visual-mode:visual-mode
       "M-w" (lambda-command custom-copy* ()
			     (progn (nyxt/document-mode:copy) (nyxt/visual-mode:clear-selection)))
       )))))

;(define-configuration web-buffer
;  ((default-modes (append '(nyxt/input-edit-mode:input-edit-mode) %slot-value%))))
;
;(define-configuration nyxt/input-edit-mode:input-edit-mode
;  ((keyscheme-map
;    (define-keyscheme-map "custom-input-edit" (list :import %slot-default%)
;      nyxt/keyscheme:emacs
;      (list
;       "C-h" 'nyxt/input-edit-mode:delete-backwards
;       "C-a" 'nyxt/prompt-buffer-mode:move-start-of-input
;       "C-e" 'nyxt/prompt-buffer-mode:move-end-of-input
;       )))))
