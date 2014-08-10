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

(setq tramp-default-method "plink")

(defvar prev-yanked-text nil "*previous yanked text")
(setq interprogram-cut-function
      (lambda (text &optional push)
        (with-temp-buffer (cd "/tmp")
                          (let ((process-connection-type nil))
                            (let ((proc (start-process "putclip" nil "putclip")))
                              (process-send-string proc string)
                              (process-send-eof proc)
                              )))))
(setq interprogram-paste-function
      (lambda ()
        (with-temp-buffer (cd "/tmp")
                          (let ((text (shell-command-to-string "getclip")))
                            (if (string= prev-yanked-text text)
                                nil
                              (setq prev-yanked-text text))))))

;; tramp
(require 'tramp)
(setq tramp-default-method "ssh")
(add-to-list 'tramp-default-proxies-alist '("\\'" "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist '("localhost\\'" "\\`root\\'" nil))
