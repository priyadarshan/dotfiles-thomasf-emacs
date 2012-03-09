(setq dotfiles-dir 
      (file-name-directory (or load-file-name (buffer-file-name))))
(add-to-list 'load-path dotfiles-dir)
(require 'thomasf-init)

;; Load main configuration
(org-babel-load-file (expand-file-name "thomasf-emacs.org" dotfiles-dir))
