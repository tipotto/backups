(define-configuration (buffer internal-buffer editor-buffer prompt-buffer web-buffer)
  ((override-map (let ((map (make-keymap "override-map")))
                   (define-key map
		     ;"C-space" 'nyxt/visual-mode:mark-set
                     "C-space" 'nyxt/visual-mode:toggle-mark
		     )))))

(defvar *my-keymap* (make-keymap "my-map"))
(define-key *my-keymap*
  "C-s" 'nyxt/web-mode:search-buffer
;  "C-n" 'nyxt/web-mode:scroll-down
;  "C-p" 'nyxt/web-mode:scroll-up
  "C-f" 'nyxt/web-mode:scroll-right
  "C-b" 'nyxt/web-mode:scroll-left
  "C-x o" 'switch-buffer-next
  "C-x k" 'delete-current-buffer
  "C-x C-k" 'delete-all-buffers
  "C-c p" 'switch-buffer-next
  "C-c n" 'switch-buffer-previous
  "C-c C-f" 'nyxt/buffer-listing-mode:list-buffers
  "C-v" 'nyxt/visual-mode:visual-mode
;  "C-g" 'nyxt/visual-mode:clear-selection
  "C-e" 'nyxt/web-mode:history-forwards
  "C-a" 'nyxt/web-mode:history-backwards
  "C-;" 'nyxt/web-mode:follow-hint
  "M-;" 'nyxt/web-mode:follow-hint-new-buffer-focus
  "s-;" 'nyxt/web-mode:follow-hint-new-buffer
  "M-y" 'nyxt/web-mode:paste-from-clipboard-ring
  "C-c c" 'describe-command
  "C-c f" 'describe-function
  "C-c b c" 'bookmark-current-url
  "C-c b l" 'list-bookmarks
  "S-l" 'set-url-from-bookmark
  )

(define-mode my-mode ()
  "Dummy mode for the custom key bindings in `*my-keymap*'."
  ((keymap-scheme :initform (keymap:make-scheme scheme:emacs *my-keymap*))))

(define-configuration (buffer internal-buffer editor-buffer prompt-buffer)
  ((default-modes `(nyxt/emacs-mode:emacs-mode
                    my-mode
                    ,@%slot-default%))))

(define-configuration (web-buffer prompt-buffer)
  ((default-modes (append '(nyxt::input-edit-mode) %slot-default%))))
