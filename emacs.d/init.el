(setq dotfiles-dir 
      (file-name-directory (or load-file-name (buffer-file-name))))
(add-to-list 'load-path dotfiles-dir)
(require 'thomasf-bootstrap)

;; Load main configuration
(org-babel-load-file (expand-file-name "thomasf-emacs.org" dotfiles-dir))
