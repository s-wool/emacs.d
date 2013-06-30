;; 極力UTF-8
(prefer-coding-system 'utf-8)

;; Mac用(App版)
(when (eq window-system 'ns)
  ;; 日本語入力
  (setq default-input-method "MacOSX")
  ;; フォント
  (create-fontset-from-ascii-font "DejaVu Sans Mono-12:weight=normal:slant=normal" nil "dejavukakugo")
  (set-fontset-font "fontset-dejavukakugo"
		    'unicode
		    (font-spec :family "Hiragino Kaku Gothic ProN" :size 12)
		    nil
		    'append)
  (add-to-list 'default-frame-alist '(font . "fontset-dejavukakugo")))

;; Clipboardとの共有
(defvar prev-yanked-text nil "*previous yanked text")
(setq interprogram-cut-function
      (lambda (text &optional push)
                                        ; use pipe
        (with-temp-buffer (cd "/tmp")
                          (let ((process-connection-type nil))
                            (let ((proc (start-process "pbcopy" nil "pbcopy")))
                              (process-send-string proc string)
                              (process-send-eof proc)
                              )))))
(setq interprogram-paste-function
      (lambda ()
        (with-temp-buffer (cd "/tmp")
                          (let ((text (shell-command-to-string "pbpaste")))
                            (if (string= prev-yanked-text text)
                                nil
                              (setq prev-yanked-text text))))))

;; dash
(when (eq system-type 'darwin)
  (defun dash ()
    (interactive)
    (shell-command
     (format "open dash://%s"
	     (or (thing-at-point 'symbol) ""))))
  (global-set-key "\C-cd" 'dash))

(require 'tramp)
(setq tramp-default-method "ssh")
(add-to-list 'tramp-default-proxies-alist '("\\'" "\\`root\\'" "/ssh:%h:")) ;; 追加
(add-to-list 'tramp-default-proxies-alist '("localhost\\'" "\\`root\\'" nil)) ;; 追加

(setq howm-directory "~/Dropbox/Application Data/howm/")
