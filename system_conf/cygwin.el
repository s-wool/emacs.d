(setq interprogram-cut-function
      (lambda (text &optional push)
        (let ((process-connection-type nil))
          (let ((proc (start-process "putclip" "*Messages*" "putclip")))
            (process-send-string proc text)
            (process-send-eof proc)))))
(setq interprogram-paste-function
       (lambda ()
         (shell-command-to-string "getclip")))

;; (defun copy-from-system ()
;;   (shell-command-to-string "getclip"))

;; (defun paste-to-system (text &optional push)
;;   )

;; (setq interprogram-cut-function 'paste-to-system)
;; (setq interprogram-paste-function 'copy-from-system)

;; tramp
(require 'tramp)
(setq tramp-default-method "scp")
(add-to-list 'tramp-default-proxies-alist '("\\'" "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist '("localhost\\'" "\\`root\\'" nil))
