;; cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;;load-path
(add-to-list 'load-path "~/.emacs.d/elisp")
;; load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf")

;; システム毎の設定
(when (eq system-type 'darwin)
  (load "~/.emacs.d/system_conf/mac.el"))
(when (eq system-type 'windows-nt)
  (load "~/.emacs.d/system_conf/win.el"))

;; backup
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; 極力UTF-8
(prefer-coding-system 'utf-8)

;; color
(add-to-list 'custom-theme-load-path
             (file-name-as-directory "~/.emacs.d/elisp/themes/"))
(load-theme 'clarity t t)
(enable-theme 'clarity)

;;時計表示
(display-time)
;;yesをyで答える
(defalias 'yes-or-no-p 'y-or-n-p)
;;履歴を多めに保存。
(setq history-length 1000)
;;履歴を次回に保存する。
(savehist-mode t)
;;; 最近開いたファイルを保存する数を増やす
(setq recentf-max-saved-items 1000)
;;行数
(require 'linum)
;; 行番号表示をトグル
(defun toggle-linum-lines ()
  "toggle display line number"
  (interactive)
  (setq linum-format "%4d ")
  (linum-mode
   (if linum-mode -1 1)))
(define-key global-map (kbd "C-x C-l") 'toggle-linum-lines)
;;スタートアップページいらない
(setq inhibit-startup-message t)
;;hide toolbar
(tool-bar-mode -1)
;; リージョンを削除できるように
(delete-selection-mode t)
;;対応する括弧をハイライト
(show-paren-mode t)
;;カーソル点滅
(blink-cursor-mode t)
;;編集行ハイライト
(global-hl-line-mode t)
;;ビープ音消去
(setq visible-bell t)
(setq ring-bell-function 'ignore)
;;minibufでisearchを使えるようにする
(require 'minibuf-isearch nil t)
;; use space
(setq-default indent-tabs-mode nil)

;; other window
;; via: http://d.hatena.ne.jp/rubikitch/20100210/emacs
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))

(global-set-key (kbd "C-]") 'other-window-or-split)

(require 'anything-startup)
(when (require 'anything nil t)
  (setq
   anything-idle-delay 0.3
   anything-input-idle-delay 0.2
   anything-candidate-number-limit 100
   anything-quick-update t
   anything-enable-shortcuts 'alphabet)
  (when (require 'anything-coding nil t)
    (setq anything-su-or-sudo "sudo"))
  (require 'anything-match-plugin nil t)
  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (require 'anything-migemo nit t))
  (when (require 'anything-complete nil t)
    (anything-lisp-complete-symbol-set-timer 150))
  (require 'anything-show-completion nil t)
  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))
  (when (require 'descbinds-anything nil t)
    (descbinds-anything-install)))

(global-set-key (kbd "C-x b") 'anything)

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq ac-auto-start t)

;; タブ, 全角スペース、改行直前の半角スペースを表示する
(when (require 'jaspace nil t)
  (when (boundp 'jaspace-modes)
    (setq jaspace-modes (append jaspace-modes
                                (list 'php-mode
                                      'yaml-mode
                                      'javascript-mode
                                      'ruby-mode
                                      'text-mode
                                      'fundamental-mode
				      'smarty-mode))))
  (when (boundp 'jaspace-alternate-jaspace-string)
    (setq jaspace-alternate-jaspace-string "□"))
  (when (boundp 'jaspace-highlight-tabs)
    (setq jaspace-highlight-tabs ?^))
  (add-hook 'jaspace-mode-off-hook
            (lambda()
              (when (boundp 'show-trailing-whitespace)
                (setq show-trailing-whitespace nil))))
  (add-hook 'jaspace-mode-hook
            (lambda()
              (progn
                (when (boundp 'show-trailing-whitespace)
                  (setq show-trailing-whitespace t))
                (face-spec-set 'jaspace-highlight-jaspace-face
                               '((((class color) (background light))
                                  (:foreground "blue"))
                                 (t (:foreground "green"))))
                (face-spec-set 'jaspace-highlight-tab-face
                               '((((class color) (background light))
                                  (:foreground "red"
                                   :background "unspecified"
                                   :strike-through nil
                                   :underline t))
                                 (t (:foreground "purple"
                                     :background "unspecified"
                                     :strike-through nil
                                     :underline t))))
                (face-spec-set 'trailing-whitespace
                               '((((class color) (background light))
                                  (:foreground "red"
                                   :background "unspecified"
                                   :strike-through nil
                                   :underline t))
                                 (t (:foreground "purple"
                                     :background "unspecified"
                                     :strike-through nil
                                     :underline t))))))))

;; goto-line
(global-set-key "\M-l" 'goto-line)

;; redo+.el
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-c '") 'redo))
(setq undo-no-redo t)
