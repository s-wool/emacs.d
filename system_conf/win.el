(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'shift_jis)

(setq default-cursor-type 'box)

(setq default-input-method "W32-IME")
(w32-ime-initialize)
(set-cursor-color "red")
(setq w32-ime-buffer-switch-p nil)

(add-hook 'input-method-activate-hook
    (lambda() (set-cursor-color "green")))
(add-hook 'input-method-inactivate-hook
    (lambda() (set-cursor-color "red")))

(set-face-font 'default "MigMix 1M-12")

(global-set-key [M-kanji] 'ignore)
(global-set-key (kbd "C-t") 'ignore)

(setq howm-directory "~/Dropbox/Application Data/howm/")

(setenv "PATH"
  (concat
   "/Users/Norikazu/apps/putty" ";"
   (getenv "PATH")))

;;(require 'tramp)
(setq tramp-default-method "plink")
;;(setq tramp-shell-prompt-pattern "^[ $]+")

;; howm
(setq howm-directory "~/Dropbox/Application Data/howm/")
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
(setq howm-menu-lang 'ja)
(setq howm-process-coding-system 'utf-8)
(when (require 'howm-mode nil t)
  (define-key global-map (kbd "C-c ,,") 'howm-menu))
;; save and close howm
(defun howm-save-buffer-and-kill ()
  "close howm"
  (interactive)
  (when (and (buffer-file-name)
	     (string-match "\\.txt" (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(define-key howm-mode-map (kbd "C-c C-c") 'howm-save-buffer-and-kill)

(require 'edit-server)
(edit-server-start)
