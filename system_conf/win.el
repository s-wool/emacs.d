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

(require 'edit-server)
(edit-server-start)
