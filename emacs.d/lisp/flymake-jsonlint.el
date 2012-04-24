
;;; flymake-jsonlint.el --- Flymake support for jsonlint
;;
(require 'flymake)


(defconst flymake-jsonlint-err-line-patterns
  (cons '("^\\(.*\\): line \\([[:digit:]]+\\), col \\([[:digit:]]+\\), \\(.+\\)$"
          1 2 3 4)
        flymake-err-line-patterns))


(defun flymake-jsonlint--create-temp-in-system-tempdir (file-name prefix)
  "Return a temporary file name into which flymake can save buffer contents.

This is tidier than `flymake-create-temp-inplace', and therefore
preferable when the checking doesn't depend on the file's exact
location."
  (make-temp-file (or prefix "flymake-jsonlint") nil ".jsonlint"))

(defun flymake-jsonlint-command ()
  "Return the location of the user's 'jsonlint' executable, using 'jsonlint-command if available."
  (if (boundp 'jsonlint-command)
      jsonlint-command
    "jsonlint"))

(defun flymake-jsonlint-init ()
  "Construct a command that flymake can use to check jsonlintscript source."
  (list (flymake-jsonlint-command)
        (list "-c" (flymake-init-create-temp-buffer-copy
                    'flymake-jsonlint--create-temp-in-system-tempdir))))

;;;###autoload
(defun flymake-jsonlint-load ()
  "Configure flymake mode to check the current buffer's jsonlintscript syntax.

This function is designed to be called in `jsonlint-mode-hook'; it
does not alter flymake's global configuration, so function
`flymake-mode' alone will not suffice."
  (interactive)
  (set (make-local-variable 'flymake-allowed-file-name-masks) '(("." flymake-jsonlint-init flymake-simple-cleanup)))
  (set (make-local-variable 'flymake-err-line-patterns) flymake-jsonlint-err-line-patterns)
  (if (executable-find (flymake-jsonlint-command))
      (flymake-mode t)
    (message "Not enabling flymake: jsonlint command not found")))


(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)


(provide 'flymake-jsonlint)
;;; flymake-jsonlint.el ends here
