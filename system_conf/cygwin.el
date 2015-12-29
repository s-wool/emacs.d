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
