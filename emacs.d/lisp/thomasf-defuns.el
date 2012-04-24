;; Utility functions

(eval-when-compile (require 'cl))

(defun insert-file-as-org-table (filename)
  "Insert a file into the current buffer at point, and convert it to an org table."
  (interactive (list (ido-read-file-name "csv file: ")))
  (let* ((start (point))
         (end (+ start (nth 1 (insert-file-contents filename)))))
    (org-table-convert-region start end)))

(defun night-mode ()
  "Switch to night mode (dark color theme)"
  (interactive)
  (load-theme night-mode-theme)
  (set-frame-parameter nil 'night-mode-on t))

(defun day-mode ()
  "Switch to day mode (light color theme)"
  (interactive)
  (load-theme day-mode-theme)
  (set-frame-parameter nil 'night-mode-on nil))

(defun toggle-night-mode ()
  "Toggle between day and night modes"
  (interactive)
  (if (frame-parameter nil 'night-mode-on)
      (day-mode)
    (night-mode)))


(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (if (eq mode major-mode)
            (add-to-list 'buffer-mode-matches buf))))
    buffer-mode-matches))

(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args))))

;; Languages for spellinc cycling
(let ((langs '("svenska" "english")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))

(defun cycle-ispell-languages ()
  "Cycle spelling dictionaries from a list"
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))


(defun intelligent-close ()
  "quit a frame the same way no matter what kind of frame you are on.

This method, when bound to C-x C-c, allows you to close an emacs frame the
same way, whether it's the sole window you have open, or whether it's
a \"child\" frame of a \"parent\" frame.  If you're like me, and use emacs in
a windowing environment, you probably have lots of frames open at any given
time.  Well, it's a pain to remember to do Ctrl-x 5 0 to dispose of a child
frame, and to remember to do C-x C-x to close the main frame (and if you're
not careful, doing so will take all the child frames away with it).  This
is my solution to that: an intelligent close-frame operation that works in
all cases (even in an emacs -nw session).

  Stolen from http://www.dotemacs.de/dotfiles/BenjaminRutt.emacs.html."
  (interactive)
  (if (eq (car (visible-frame-list)) (selected-frame))
      ;;for parent/master frame...
      (if (> (length (visible-frame-list)) 1)
          ;;close a parent with children present
          (delete-frame (selected-frame))
        ;;close a parent with no children present
        (save-buffers-kill-emacs))
    ;;close a child frame
    (delete-frame (selected-frame))))


(defun lorem (paragraphs)
  "Inserts up to 5 paragraphs of lorem ipsum filler text."
  (interactive "nParagraphs: ")
  (let ((lorems '("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enimad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                  "\n\nIn non elit turpis, quis accumsan tortor. Vestibulum enim mi, tincidunt eget fringilla a, euismod nec mi. Integer dictum diam sed ante posuere feugiat. Aenean convallis sapien tincidunt leo aliquam posuere. Mauris porta facilisis metus, non commodo mauris interdum sed. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce a diam nec augue tristique placerat eu at odio. Sed fermentum, nunc non condimentum accumsan, dolor nisl mollis quam, sed condimentum massa massa at nisi. Etiam quis ante neque. Mauris feugiat lacus nec lorem vulputate sagittis. Fusce congue ullamcorper nulla, in lacinia felis euismod eu. Integer arcu dolor, tempus eget scelerisque sit amet, fermentum at elit. Maecenas dignissim mollis sapien, nec elementum enim feugiat vel. Mauris lobortis sodales sem vitae venenatis. Aliquam a risus arcu. Aliquam bibendum pretium velit in tempor. Aliquam erat volutpat."
                  "\n\nSed ut nisi ante. Sed sollicitudin blandit tortor eu cursus. Praesent sem augue, cursus vitae sodales a, aliquam eget enim. Nullam velit nulla, ornare vitae vulputate sit amet, blandit ut nisl. Vivamus sodales blandit pretium. In faucibus risus nec purus dapibus laoreet. Aliquam erat volutpat. Phasellus a sem sit amet metus pharetra euismod. Nunc sit amet vehicula purus. Donec lorem metus, feugiat vel ultrices vel, sagittis nec odio. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In scelerisque, justo eu pretium ultricies, elit eros varius mauris, quis scelerisque lacus lacus sed metus. Phasellus hendrerit, quam in accumsan ullamcorper, magna enim vehicula sem, et vulputate massa dolor eu augue. Pellentesque sed nibh sit amet mi vulputate porttitor at ac tortor. Ut ac augue risus, tincidunt ornare sapien. Suspendisse gravida est lacinia urna interdum scelerisque ut non sem. Sed quis lectus lectus."
                  "\n\nNam et consectetur nisl. Pellentesque rhoncus velit a elit mollis cursus nec ut orci. Vestibulum a purus ligula. Cras blandit, felis et venenatis interdum, urna libero cursus sapien, at auctor sem purus eget quam. Suspendisse pretium sollicitudin leo, quis imperdiet sem faucibus vel. Vestibulum mollis imperdiet urna, pretium porttitor lorem posuere at. Integer aliquam, velit id luctus lobortis, odio ipsum convallis urna, sit amet eleifend lacus mi et leo. Phasellus quis ante in dolor tincidunt lobortis. Proin in massa purus, vitae dignissim elit. Curabitur non enim sit amet lectus volutpat tristique."
                  "\n\nPellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed vel neque a nibh tincidunt luctus id a eros. Curabitur leo odio, sodales id malesuada ac, commodo et augue. Aenean auctor justo a nulla lobortis ut tempor mauris mollis. Duis a purus consequat enim vestibulum pretium. Vestibulum diam urna, luctus at pulvinar sed, rhoncus id risus. Maecenas sit amet velit vitae libero viverra aliquet sit amet non mauris. Suspendisse potenti. Duis eu lectus sem. Maecenas aliquam erat vitae tortor congue ut imperdiet lacus consectetur. Praesent nisl ipsum, fermentum id venenatis eu, lobortis eu nunc. Fusce ut enim tellus, ac semper turpis. Proin in ante massa. Curabitur velit lacus, pharetra vel dapibus egestas, posuere quis dui. Morbi aliquet congue nisl, dictum fringilla velit dictum sed. Integer eu consequat nisl. Curabitur aliquam suscipit magna vel pharetra. Duis eget erat vel purus mattis dignissim. Donec mattis, nulla nec imperdiet scelerisque, leo elit tincidunt dui, eget ullamcorper tortor neque nec erat. Aliquam libero augue, suscipit vitae scelerisque vitae, rutrum vitae quam.")))
    (loop for p from 0 to (- paragraphs 1)
          do (insert (nth p lorems)))))


(defun recompile-dot-lisp ()
  "Recompile emacs lisp code in emacs dotfiles directory"
  (interactive)
  (setq font-lock-verbose nil)
  (setq byte-compile-verbose  nil)
  (byte-recompile-directory (concat dotfiles-dir "vendor") 0)
  (byte-recompile-directory (concat dotfiles-dir "lisp") 0)
  (byte-recompile-directory (concat dotfiles-dir "elpa") 0)
  (byte-recompile-directory (concat dotfiles-dir "themes") 0)
  (byte-compile-file "~/.emacs-private.el")
  (byte-compile-file (concat dotfiles-dir "init.el"))
  (byte-compile-file (concat dotfiles-dir "thomasf-bootstrap.el"))
  (byte-compile-file (concat dotfiles-dir "thomasf-org.el"))
  (byte-compile-file (concat dotfiles-dir "thomasf-gui.el"))
  (byte-compile-file (concat dotfiles-dir "thomasf-emacs.el"))
  ;;(yas/compile-top-level-dir (concat dotfiles-dir "snippets"))
  ;;(yas/compile-top-level-dir (concat dotfiles-dir "snippets-imported"))
  (yas/recompile-all)
  (byte-recompile-directory (concat dotfiles-dir "snippets") 0)
  (byte-recompile-directory (concat dotfiles-dir "snippets-imported") 0))


(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))


(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))


(when (featurep 'x)
  (defun toggle-fullscreen ()
    "Toggle fullscreen for x"
    (interactive)
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                           '(2 "_NET_WM_STATE_FULLSCREEN" 0))))


(defun comment-or-uncomment-line (&optional lines)
  "Comment current line. Argument gives the number of lines forward to comment"
  (interactive "P")
  (comment-or-uncomment-region
   (line-beginning-position)
   (line-end-position lines)))


(defun comment-or-uncomment-region-or-line (&optional lines)
  (interactive "P")
  (if mark-active
      (if (< (mark) (point))
          (comment-or-uncomment-region (mark) (point))
        (comment-or-uncomment-region (point) (mark)))
    (comment-or-uncomment-line lines)))


(defun sudo-edit (&optional arg)
  "Edit as root"
  (interactive "p")
  (if arg
      (find-file (concat "/sudo::" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo::" buffer-file-name))))


(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))


(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))


(defun esk-paredit-nonlisp ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))


(defun isearch-occur ()
  "Invoke `occur' from within Isearch."
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))


(provide 'thomasf-defuns)
