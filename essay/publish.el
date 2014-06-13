;;; we need environment at first
(load "~/.emacs") 
;;; then we do action
(require 'org-publish)
(org-publish-project "blog")
