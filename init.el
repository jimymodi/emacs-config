

;;; General Settings 

(menu-bar-mode -1) ; Get rid of the menu bar first!
(tool-bar-mode -1) ; and then the tool bar
(mouse-avoidance-mode 'cat-and-mouse) ; then the mouse
(setq x-select-enable-clipboard t) ; x-copy-paste
(setq inhibit-startup-message t) ; Get rid of the startup message
(setq c-basic-offset 4) ; basic c/php indentation to 4 spaces
(setq-default indent-tabs-mode nil) ; I hate tabs!
(setq-default truncate-lines t) ; I hate line-wrapping!
(iswitchb-mode 1) ; enable iswitch buffer
(icomplete-mode t)  ; Show completions in mini buffer
(which-function-mode t) ; enable which function mode
(global-linum-mode t) ; Show line nums on left


;; Custom file where Customize-* will write
(setq custom-file "~/emacs/site/custom.el")
(load custom-file)


;; common dir where all random modes will reside
(add-to-list 'load-path (expand-file-name "~/emacs/site/common"))


;;; Programming 

;; flymake 
(add-hook 'find-file-hook 'flymake-find-file-hook)
(require 'flymake-cursor)

;; disable flymake for html and xml
;; (delete 
;;  '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
;; (delete 
;;  '("\\.xml?\\'" flymake-xml-init) flymake-allowed-file-name-masks)

;; python
;; Pyflakes
(when (load "flymake" t) 
  (defun flymake-pyflakes-init () 
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                       'flymake-create-temp-inplace)) 
           (local-file (file-relative-name 
                        temp-file 
                        (file-name-directory buffer-file-name)))) 
      (list "pyflakes" (list local-file))))
  
  (add-to-list 'flymake-allowed-file-name-masks 
               '("\\.py\\'" flymake-pyflakes-init)))

;; javascript 
;; espresso mode
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))

;; json (Josh's lite weight json major mode)
(autoload 'json-mode "json-mode.el" "Major mode for editing json files" t)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))


;;; php
;; php 5.4 friendly mode from https://github.com/ejmr/php-mode
(require 'php-mode)

;; flymake for php
(defun flymake-php-init ()
  "Use php to check the syntax of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
	 (local (file-relative-name temp (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns
             '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

;; more stuff here

;;; Editing and Outlining

;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t) 
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

;; Org mode
(setq load-path (cons "~/emacs/site/org-mode/lisp" load-path))
(setq load-path (cons "~/emacs/site/org-mode/contrib/lisp" load-path))
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-hide-leading-stars t) ; hide leading stars


;;; Themes
(add-to-list 'custom-theme-load-path "~/emacs/site/themes")

;; solarized-dark
(add-to-list 'custom-theme-load-path "~/emacs/site/themes/solarized")
(load-theme 'solarized-dark t)

;; (add-to-list 'custom-theme-load-path "~/emacs/site/themes/tomorrow-night")
