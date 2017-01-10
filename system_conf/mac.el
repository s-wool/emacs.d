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

(require 'tramp)
(setq tramp-shell-prompt-pattern "^.*[#$%>] *")
(setq tramp-default-method "scp")
(add-to-list 'tramp-default-proxies-alist '("\\'" "\\`root\\'" "/sshx:%h:"))
(add-to-list 'tramp-default-proxies-alist '("localhost\\'" "\\`root\\'" nil))
(setq tramp-debug-buffer t tramp-verbose 10)
(defadvice tramp-handle-vc-registered (around tramp-handle-vc-registered-around activate)
  (let ((vc-handled-backends '(SVN Git))) ad-do-it))
