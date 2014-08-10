;; php-mode
(require 'php-mode)
(autoload 'php-mode "php-mode")
(setq auto-mode-alist
      (cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq php-mode-force-pear t)
(add-hook 'php-mode-hook
      (lambda ()
        (c-set-offset 'arglist-intro '+)
        (c-set-offset 'arglist-close 0)
        (setq tab-width 4)
        (setq c-basic-offset 4)
        (setq indent-tabs-mode nil)
        ))

;; smarty
;; http://deboutv.free.fr/lisp/smarty/download.php
(add-to-list 'auto-mode-alist (cons "\\.tpl\\'" 'smarty-mode))
(autoload 'smarty-mode "smarty-mode" "Smarty Mode" t)
(add-hook 'smarty-mode-hook
          (lambda ()
            (setq tab-width 4)
            (setq c-basic-offset 4)))
