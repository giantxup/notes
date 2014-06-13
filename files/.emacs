;;; .emacs
(add-to-list 'load-path "~/.emacs.d/")

(setq mac-system nil)
(when (eq system-type 'darwin)
  (setq mac-system t))

;;; ####################
;;; package

(require 'package)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;; ####################
;;; common

;; https://github.com/purcell/exec-path-from-shell
;; otherwise variable exec-path will be wrong.
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)


;;; ####################
;;; perference.

;; font on mac.
(if mac-system
    (progn
      (set-default-font "-apple-Monaco-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")))
;; font on linux.
(set-language-environment 'UTF-8)
(set-locale-environment "UTF-8")
(if (not mac-system)
    (progn
      (custom-set-faces
       ;; custom-set-faces was added by Custom.
       ;; If you edit it by hand, you could mess it up, so be careful.
       ;; Your init file should contain only one such instance.
       ;; If there is more than one, they won't work right.
       '(default ((t (:inherit nil :stipple nil :background "black" :foreground "cornsilk" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
      (set-fontset-font "fontset-default" 'unicode '("WenQuanYi Zen Hei" . "unicode-ttf"))))

;; (setq inhibit-default-init t)
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))
(setq frame-title-format "%b")
;; uncomment it if backspace doesn't work.
;; (normal-erase-is-backspace-mode)
(setq transient-mark-mode t)
(setq column-number-mode t)
(setq default-fill-column 80)
(setq hl-line-mode t)
(setq bookmark-save-flag 1)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
;; allow to use clipboard on X System.
(setq x-select-enable-clipboard t)
(setq default-major-mode 'text-mode)
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq initial-major-mode 'emacs-lisp-mode)
(add-to-list 'auto-mode-alist '("\\.el\\'" . emacs-lisp-mode))
(setq visible-bell nil)
(setq kill-ring-max 200)
(show-paren-mode t)
(setq show-paren-style 'parentheses)
(tool-bar-mode -1)
(menu-bar-mode 1)
(scroll-bar-mode -1)
;; allow to view image directly.
(auto-image-file-mode t)
;; use version control to backup. but seems useless to me.
;; http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq version-control t)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq kept-old-versions 2)
(setq dired-kept-versions 1)
;; (setq backup-directory-alist '(("." . "~/.backups")))
;; so turn it off.
(setq make-backup-files nil)
(setq user-full-name "dirtysalt")
(setq user-mail-address "dirtysalt1987@gmail.com")
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; ####################
;;; utility

;;; htmlize.
(require 'htmlize)

;;; recentf.
(require 'recentf)
(recentf-mode 1)

;;; hippie-expand.
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev-visible
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        try-expand-whole-kill))

;;; color-theme.
(require 'color-theme)
(color-theme-initialize)
(color-theme-billw)

;;; auto-complete.
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(global-auto-complete-mode 1)
(setq ac-modes
      (append ac-modes '(org-mode
                         objc-mode
                         sql-mode
                         c++-mode
                         java-mode
                         python-mode
                         change-log-mode
                         text-mode
                         conf-mode
                         makefile-mode
                         autoconf-mode)))

;;; ido.
;; C-x b # select buffer.
(require 'ido)
(ido-mode t)
(require 'ido-ubiquitous)
(ido-ubiquitous t)
(require 'smex)

;;; ibuffer.
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;; session.
(require 'session)
(add-hook 'after-init-hook 'session-initialize)


;;; ibus.
(if (not mac-system)
    (progn
      (add-to-list 'load-path "~/.emacs.d/ibus-el-0.3.2")
      (require 'ibus)
      (add-hook 'after-init-hook 'ibus-mode-on)
      ;; Use C-SPC for Set Mark command
      ;; (ibus-define-common-key ?\C-\s nil)
      ;; Use C-/ for Undo command
      (ibus-define-common-key ?\C-/ nil)
      (global-set-key [(shift)] 'ibus-toggle)
      ;; Change cursor color depending on IBus status
      (setq ibus-cursor-color '("red" "blue" "limegreen"))))

;;; multi-term.
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
;; (setq multi-term-program "/bin/bash")
(setq multi-term-buffer-name "multi-term")
;; select the right opening window.
(setq multi-term-dedicated-select-after-open-p t)

;;; encoding.
(set-language-environment "UTF-8")
(setq current-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;; default browser.
(setq browse-url-browser-function
      'browse-url-generic)
(setq browse-url-generic-program
      (executable-find "google-chrome"))
(if mac-system
    (setq browse-url-browser-function 'browse-url-default-macosx-browser))

;;; desktop.
(require 'desktop)
(desktop-save-mode t)

;;; better-defaults.
(require 'better-defaults)

;;; ####################
;;; prog mode

;;; google c style.
(require 'google-c-style)
(setq c-default-style "java")
(defun my-c-mode-common-hook()
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(setq auto-mode-alist  (append '(("\\.h\\'" . c++-mode))
                               '(("\\.hpp\\'" . c++-mode))
                               '(("\\.c\\'" . c++-mode))
                               '(("\\.cc\\'" . c++-mode))
                               '(("\\.cpp\\'" . c++-mode))
                               auto-mode-alist))
(setq-default nuke-trailing-whitespace-p t)
(setq tab-width 4)
(setq indent-tabs-mode nil)
(setq c-basic-offset 4)

;;; go
(require 'go-mode-load)
;;; clojure
(require 'clojure-mode)
(require 'clojure-test-mode)
;;; cmake
(require 'cmake-mode)
;;; python
(require 'python-mode)
;;; php
(require 'php-mode)
;; (require 'cedet)
;;; scala
(require 'scala-mode2)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.sbt$" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.cnf\\'" . conf-mode))
;;; systemtap
(require 'systemtap-mode)
(add-to-list 'auto-mode-alist '("\\.stp$" . systemtap-mode))
;;; markdown
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;;; protobuf
(require 'protobuf-mode)
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))
;;; nxml mode.
;; (defvar nxml-mode-map
;;       (let ((map (make-sparse-keymap)))
;;         (define-key map "\M-\C-u"  'nxml-backward-up-element)
;;         (define-key map "\M-\C-d"  'nxml-down-element)
;;         (define-key map "\M-\C-n"  'nxml-forward-element)
;;         (define-key map "\M-\C-p"  'nxml-backward-element)
;;         (define-key map "\M-{"     'nxml-backward-paragraph)
;;         (define-key map "\M-}"     'nxml-forward-paragraph)
;;         (define-key map "\M-h"     'nxml-mark-paragraph)
;;         (define-key map "\C-c\C-f" 'nxml-finish-element)
;;         (define-key map "\C-c\C-b" 'nxml-balanced-close-start-tag-block)
;;         (define-key map "\C-c\C-i" 'nxml-balanced-close-start-tag-inline)
;;         (define-key map "\C-c\C-x" 'nxml-insert-xml-declaration)
;;         (define-key map "\C-c\C-d" 'nxml-dynamic-markup-word)
;;         (define-key map "\C-c\C-u" 'nxml-insert-named-char)
;;         (define-key map "/"        'nxml-electric-slash)
;;         (define-key map [C-return] 'nxml-complete)
;;         (when nxml-bind-meta-tab-to-complete-flag
;;           (define-key map "\M-\t"  'nxml-complete))
;;         map)
;;       "Keymap used by NXML Mode.")
(require 'nxml-mode)
(setq nxml-child-indent 2)
(add-to-list 'auto-mode-alist
             '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\|html\\|htm\\)\\'" . nxml-mode))

;;; cscope.
;; C-s s I # index files.
;; C-c s s # search symbols.
;; C-c s g # search definitions.
;; C-c s c # callers of a function.
;; C-c s C # callees of a function.
;; C-c s e # search regex.
;; C-c s f # search files.
;; C-c s i # including files.
;; C-c s u # last popup mark.
;; C-c s p # previous symbol.
;; C-c s P # previous file.
;; C-c s n # next symbol.
;; C-c s N # next file.
(require 'xcscope)
;; (setq cscope-do-not-update-database t) ;; don't need to update database

;;; global.
;; M-. # search tag/definition
;; M-* # go back
;; M-] # search reference
;; M-n # next match
;; N-p # previous match
;; ggtags-browse-file-as-hypertext
;; ggtags-update-tags
;; ggtags-reload
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))
(setq-local imenu-create-index-function #'ggtags-build-imenu-index)
(setq-local hippie-expand-try-functions-list
            (cons 'ggtags-try-complete-tag hippie-expand-try-functions-list))

;;; org-mode.
;; BEGIN_VERSE
;; BEGIN_QUOTE
;; BEGIN_CENTER
;; BEGIN_EXAMPLE
;; BEGIN_SOURCE
;; C-C C-e t // insert export template.
;; C-c C-n // next section.
;; C-c C-p // previous section.
;; C-c C-f // next same-level section.
;; C-c C-b // previous same-level section.
;; C-c C-u // higher-level section.
;; C-c C-o // open file.
;; C-c C-l // edit link.
;; C-cxa // open org-agenda.
;; C-c C-e // export.
;; C-c C-c // switch between footnote and corresponding content.
;; *text* bold mode.
;; /text/ italic mode.
;; _text_ underline mode.
;; +text+ delete mode.
;; #<<anchor>>
;; #+STYLE: <link rel="stylesheet" type="text/css" href="./site.css" />
;; file:projects.org::some words # text search in Org file1
;; file:projects.org::*task title # heading search in Org file
;; mailto:adent@galaxy.net Mail link
(require 'org-install)
(require 'org-publish)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook
          (lambda () (progn
		       (setq truncate-lines nil)
		       (local-unset-key (kbd "<M-up>"))
		       (local-unset-key (kbd "<M-down>"))
		       (local-unset-key (kbd "<M-left>"))
		       (local-unset-key (kbd "<M-right>")))))
(setq org-log-done t)

;; http://orgmode.org/manual/Publishing-options.html
(setq org-export-have-math nil)
(setq org-use-sub-superscripts (quote {}))
(setq org-export-author-info nil)
(setq org-html-preamble nil)
(setq org-html-postamble nil)
;; (setq org-export-html-style-include-default nil)
(setq org-export-html-style-include-scripts nil)
(setq org-export-htmlize-output-type 'css)
(setq org-publish-project-alist
      '(("essay"
         :base-directory "~/repo/notes/essay"
         :publishing-directory "~/repo/notes/www/"
         :section-numbers 't
	 :recursive nil
	 :author "dirtysalt"
         :email "dirtysalt at gmail dot com"
	 :style "<link rel=\"shortcut icon\" href=\"http://dirlt.com/css/favicon.ico\" /> <link rel=\"stylesheet\" type=\"text/css\" href=\"./css/site.css\" />"
         :table-of-contents 't)
        ("note"
         :base-directory "~/repo/notes/essay/note"
         :publishing-directory "~/repo/notes/www/note"
         :section-numbers 't
	 :recursive nil
	 :author "dirtysalt"
	 :email "dirtysalt at gmail dot com"
	 :style "<link rel=\"shortcut icon\" href=\"http://dirlt.com/css/favicon.ico\" /> <link rel=\"stylesheet\" type=\"text/css\" href=\"../css/site.css\" />"
         :table-of-contents 't)
	("blog" :components ("essay" "note"))))

;; auto indent.
;;(setq org-startup-indented t)
(global-set-key "\C-coi" 'org-indent-mode) ;; toggle indent mode.
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)
(global-set-key "\C-cii" 'iimage-mode) ;; toggle image mode.


;;; yasnippet.
;; http://capitaomorte.github.com/yasnippet/
(require 'yasnippet)
(yas-global-mode 1)
;; default TAB key is occupied by auto-complete
;; yas/insert-snippet ; insert a template
;; yas/new-snippet ; create a template
;; (global-set-key "\C-c," 'yas/expand)
(global-set-key "\C-cye" 'yas/expand)

;; thanks to capitaomorte for providing the trick.
(defadvice yas/insert-snippet (around use-completing-prompt activate)
  "Use `yas/completing-prompt' for `yas/prompt-functions' but only here..."
  (let ((yas/prompt-functions '(yas/completing-prompt)))
    ad-do-it))

;; give yas/dropdown-prompt in yas/prompt-functions a chance
(require 'dropdown-list)
;; use yas/completing-prompt when ONLY when `M-x yas/insert-snippet'
;; thanks to capitaomorte for providing the trick.
(defadvice yas/insert-snippet (around use-completing-prompt activate)
  "Use `yas/completing-prompt' for `yas/prompt-functions' but only here..."
  (let ((yas/prompt-functions '(yas/completing-prompt)))
    ad-do-it))


;;; ####################
;;; key bindings
(when mac-system
  ;; (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [(f10)] 'ns-toggle-fullscreen)
  (global-set-key [kp-delete] 'delete-char))

(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-m" 'compile)
(global-set-key "\M-/" 'hippie-expand)
(global-set-key "\C-xp" 'previous-error)
(global-set-key "\C-xn" 'next-error)
;; (global-set-key "\C-cbml" 'list-bookmarks) ;; book mark list.
;; (global-set-key "\C-cbms" 'bookmark-set) ;; book mark set.
;; (global-set-key "\C-chdf" 'describe-function) ;; help describe function.
;; (global-set-key "\C-chdv" 'describe-variable) ;; help describe variable.
;; (global-set-key "\C-chdk" 'describe-key) ;; help describe key.
(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\C-x." 'multi-term)
(global-set-key "\C-cdw" 'delete-trailing-whitespace)
(menu-bar-mode 1)
