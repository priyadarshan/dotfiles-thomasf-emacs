(require 'solarized-theme)

(defun thomasf-solarized-childtheme ()
  "My solarized child theme"

  (custom-theme-set-faces
   theme-name
   `(show-paren-match ((,class (:foreground ,cyan-hc :background ,cyan-lc :weight bold))))

   ;; maybe...
   `(font-lock-builtin-face ((,class (:foreground ,blue :slant italic))))
   `(font-lock-comment-face ((,class (:foreground ,solarized-comments))))
   `(font-lock-comment-delimiter-face ((,class (:foreground ,solarized-comments))))
   `(font-lock-constant-face ((,class (:foreground ,blue :weight bold))))
   `(font-lock-doc-face ((,class (:foreground ,cyan :slant italic))))
   `(font-lock-doc-string-face ((,class (:foreground ,blue))))
   `(font-lock-function-name-face ((,class (:foreground ,blue))))
   `(font-lock-keyword-face ((,class (:foreground ,green :weight bold))))
   `(font-lock-negation-char-face ((,class (:foreground ,solarized-fg))))
   `(font-lock-preprocessor-face ((,class (:foreground ,blue))))
   `(font-lock-string-face ((,class (:foreground ,cyan))))
   `(font-lock-type-face ((,class (:foreground ,yellow))))
   `(font-lock-variable-name-face ((,class (:foreground ,blue))))
   `(font-lock-warning-face ((,class (:foreground ,yellow :weight bold :underline t)))))

  (custom-theme-set-variables
   theme-name
   `(org-todo-keyword-faces
     (quote (("TODO" :foreground ,red :weight bold :inverse-video t)
             ("NEXT" :foreground ,blue :weight bold :inverse-video t)
             ("DONE" :foreground ,green :weight bold)
             ("WAITING" :foreground ,orange :weight bold :inverse-video t)
             ("HOLD" :foreground ,magenta :weight bold :inverse-video t)
             ("CANCELLED" :foreground ,green :weight bold)
             ("PHONE" :foreground ,green :weight bold))))

   `(org-tag-faces
     (quote (("@home" :slant italic)
             ("@office" :slant italic)
             ("@errand" :slant italic :inverse-video t)
             ("work" :slant italic)
             ("personal" :slant italic)
             ("bulk" :foreground ,solarized-comments)
             ("hold" :foreground ,green :slant italic)
             ("note" :foreground ,magenta :slant italic)
             ("waiting" :foreground ,orange :slant italic :inverse-video t)
             ("cancelled" :foreground ,green :slant italic :slant italic)
             ("flagged" :foreground ,red :slant italic :inverse-video t))))))

(provide 'thomasf-solarized)











