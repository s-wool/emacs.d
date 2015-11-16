;; Clipboardとの共有
(defvar prev-yanked-text nil "*previous yanked text")
(setq interprogram-cut-function
      (lambda (text &optional push)
                                        ; use pipe
        (with-temp-buffer (cd "/tmp")
                          (let ((process-connection-type nil))
                            (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
                              (process-send-string proc text)
                              (process-send-eof proc)
                              )))))
(setq interprogram-paste-function
      (lambda ()
        (with-temp-buffer (cd "/tmp")
                          (let ((text (shell-command-to-string "pbpaste")))
                            (if (string= prev-yanked-text text)
                                nil
                              (setq prev-yanked-text text))))))

;; howm
(setq howm-directory "~/Dropbox/Application Data/howm/")
;(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
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

(require 'tramp)
(setq tramp-shell-prompt-pattern "^.*[#$%>] *")
(setq tramp-default-method "scp")
(add-to-list 'tramp-default-proxies-alist '("\\'" "\\`root\\'" "/sshx:%h:"))
(add-to-list 'tramp-default-proxies-alist '("localhost\\'" "\\`root\\'" nil))
(setq tramp-debug-buffer t tramp-verbose 10)
(defadvice tramp-handle-vc-registered (around tramp-handle-vc-registered-around activate)
  (let ((vc-handled-backends '(SVN Git))) ad-do-it))
