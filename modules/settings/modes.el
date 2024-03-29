
(defun my/enable-ivy-counsel ()
  (interactive)
  (ivy-mode +1)
  (counsel-mode +1)
  (message "ivy on"))

(defun my/disable-ivy-counsel ()
  (interactive)
  (ivy-mode -1)
  (counsel-mode -1)
  (message "ivy off"))



(defun my/conf-hooks ()
  (interactive)
  (line-numbers)
  (subword-mode 1)
  (company-mode 1)
  (flycheck-mode 1)
  (smartparens-mode 1)
  (tab-jump-out-mode 1)
  (electric-operator-mode 1)
  (rainbow-delimiters-mode 1)
  (electric-pair-local-mode 1)
  (highlight-numbers-mode 1)
  (highlight-operators-mode 1)
  (highlight-indent-guides-mode 1)
  (subword-mode 1)
  (tab-jump-out-mode 1))

(add-hook 'conf-space-mode-hook 'my/conf-hooks)

(defun abbrev-edit-save-close ()
  (interactive)
  (abbrev-edit-save-buffer)
  (my/kill-this-buffer))


(defun my/sh-mode-hooks ()
  (interactive)
  (line-numbers)
  (subword-mode 1)
  (company-mode 1)
  (smartparens-mode 1)
  (tab-jump-out-mode 1)
  (flycheck-mode 1)
  (electric-pair-local-mode 1)
  (yas-minor-mode 1)
  (highlight-indent-guides-mode 1)
  (aggressive-indent-mode 1)
  (beacon-mode 1)
  (message " my sh-mode on"))


(defun org-hide-other ()
  (interactive)
  (point-to-register 'z)
  (org-shifttab)
  (jump-to-register 'z)
  (org-cycle)
  (outline-show-subtree)
  (message ""))


(defun my/org-agenda ()
  (interactive)
  (org-agenda t "a"))

(defun my/org-agenda-single-window ()
  (interactive)
  (org-agenda t "a")
  (delete-other-windows))


(defun my/org-projectile-agenda ()
  (interactive)
  (counsel-projectile-org-agenda t "a"))

(defun org-1-day-agenda ()
  (interactive)
  (let ((current-prefix-arg 1))
    (org-agenda t "a")))

(defun org-2-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 2))
    (org-agenda t "a")))

(defun org-3-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 3))
    (org-agenda t "a")))

(defun org-4-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 4))
    (org-agenda t "a")))

(defun org-5-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 5))
    (org-agenda t "a")))

(defun org-6-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 6))
    (org-agenda t "a")))

(defun org-7-days-agenda ()
  (interactive)
  (let ((current-prefix-arg 7))
    (org-agenda t "a")))

(defun my/agenda-enter ()
  (interactive)
  (let ((current-prefix-arg 4))
    (org-agenda-switch-to)))

(defun org-hide-emphasis ()
  (interactive)
  (save-excursion
    (setq org-hide-emphasis-markers t)
    (let ((inhibit-message t))
      (org-mode-restart)
      (org-cycle))))

(defun org-show-emphasis ()
  (interactive)
  (save-excursion
    (setq org-hide-emphasis-markers nil)
    (let ((inhibit-message t))
      (org-mode-restart)
      (org-cycle))))

(defun afs/org-remove-link ()
  "Replace an org link by its description or if empty its address"
  (interactive)
  (if (org-in-regexp org-bracket-link-regexp 1)
      (save-excursion
        (let ((remove (list (match-beginning 0) (match-end 0)))
              (description (if (match-end 3)
                               (org-match-string-no-properties 3)
                             (org-match-string-no-properties 1))))
          (apply 'delete-region remove)
          (insert description)))))

(defun org-clock-history ()
  "Show Clock History"
  (interactive)
  (let ((current-prefix-arg '(4))) (call-interactively 'org-clock-in)))

;;; i3wm-emacs.el --- i3wm emacs mode

;; Copyright (C) 2014 Steven Knight

;; Author: Steven Knight <steven@knight.cx>
;; URL: https://github.com/skk/i3wm-emacs

(define-derived-mode i3wm-emacs sh-mode
  "i3wm-emacs" "Major mode for editing configuration files for i3 (http://i3wm.org/)."

  (defvar i3-config-keywords
    '("set" "exec" "exec_alwyas" "bindsym" "bindcode" "font"
      "floating_modifier" "floating_minimum_size" "floating_maximum_size"
      "default_orientation" "workspace_layout" "new_window" "hide_edge_borders"
      "for_window" "assign" "workspace" "colorclass" "ipc-socket" "focus_follows_mouse"
      "popup_during_fullscreen" "force_focus_wrapping" "force_xinerama" "workspace_auto_back_and_forth")
    "i3 Config keywords")

  (defvar i3-config-types
    '()
    "i3 Config types.")

  (defvar i3-config-constants
    '()
    "i3 Config constants.")

  (defvar i3-config-events
    '()
    "i3 Config events.")

  (defvar i3-config-functions
    '()
    "i3 Config functions.")

  (defvar i3-config-keywords-regexp (regexp-opt i3-config-keywords 'words))
  (defvar i3-config-type-regexp (regexp-opt i3-config-types 'words))
  (defvar i3-config-constant-regexp (regexp-opt i3-config-constants 'words))
  (defvar i3-config-event-regexp (regexp-opt i3-config-events 'words))
  (defvar i3-config-functions-regexp (regexp-opt i3-config-functions 'words))

  (setq i3-config-font-lock-keywords
        `(
          (,i3-config-type-regexp . font-lock-type-face)
          (,i3-config-constant-regexp . font-lock-constant-face)
          (,i3-config-event-regexp . font-lock-builtin-face)
          (,i3-config-functions-regexp . font-lock-function-name-face)
          (,i3-config-keywords-regexp . font-lock-keyword-face)
          ;; note: order above matters.
          ))

  ;; code for syntax highlighting
  (setq font-lock-defaults '((i3-config-font-lock-keywords)))

  ;; clear memory
  (setq i3-config-keywords nil)
  (setq i3-config-types nil)
  (setq i3-config-constants nil)
  (setq i3-config-events nil)
  (setq i3-config-functions nil))

(provide 'i3wm-emacs)

(add-to-list 'auto-mode-alist '("\\i3/config\\'" . i3wm-emacs))

(add-hook 'i3wm-emacs-hook 'line-numbers)
(add-hook 'i3wm-emacs-hook 'my/prog-mode-hooks)
;;; i3wm-emacs.el ends here

;;; tmuxconf-emacs.el --- tmux emacs mode

;; Copyright (C) 2014 Steven Knight

;; Author: Steven Knight <steven@knight.cx>
;; URL: https://github.com/skk/i3wm-emacs

(define-derived-mode tmuxconf-emacs text-mode
  "tmuxconf-emacs" "Major mode for editing configuration files for i3 (http://i3wm.org/)."

  (defvar tmux-config-keywords
    '("set" "setw" "set-window-option" "set-clipboard" "set-titles" "set-titles-string" "bind-key" "bind" "unbind")
    "tmux Config keywords")

  (defvar tmux-config-types
    '()
    "tmux Config types.")

  (defvar tmux-config-constants
    '()
    "tmux Config constants.")

  (defvar tmux-config-events
    '("-g" "-n" "@plugin")
    "tmux Config events.")

  (defvar tmux-config-functions
    '()
    "tmux Config functions.")

  (defvar tmux-config-keywords-regexp (regexp-opt tmux-config-keywords 'words))
  (defvar tmux-config-type-regexp (regexp-opt tmux-config-types 'words))
  (defvar tmux-config-constant-regexp (regexp-opt tmux-config-constants 'words))
  (defvar tmux-config-event-regexp (regexp-opt tmux-config-events 'words))
  (defvar tmux-config-functions-regexp (regexp-opt tmux-config-functions 'words))

  (setq tmux-config-font-lock-keywords
        `(
          (,tmux-config-type-regexp . font-lock-type-face)
          (,tmux-config-constant-regexp . font-lock-constant-face)
          (,tmux-config-event-regexp . font-lock-builtin-face)
          (,tmux-config-functions-regexp . font-lock-function-name-face)
          (,tmux-config-keywords-regexp . font-lock-keyword-face)
          ;; note: order above matters.
          ))

  ;; code for syntax highlighting
  (setq font-lock-defaults '((tmux-config-font-lock-keywords)))

  ;; clear memory
  (setq tmux-config-keywords nil)
  (setq tmux-config-types nil)
  (setq tmux-config-constants nil)
  (setq tmux-config-events nil)
  (setq tmux-config-functions nil))

(provide 'tmuxconf-emacs)

(add-to-list 'auto-mode-alist '("\\.*tmux.*\\'" . tmuxconf-emacs))

;;; tmuxconf-emacs.el ends here

(defun xah-clean-whitespace ()
  "Delete trailing whitespace, and replace repeated blank lines to just 1.
Only space and tab is considered whitespace here.
Works on whole buffer or text selection, respects `narrow-to-region'.

URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
Version 2017-09-22"
  (interactive)
  (let ($begin $end)
    (if (region-active-p)
        (setq $begin (region-beginning) $end (region-end))
      (setq $begin (point-min) $end (point-max)))
    (save-excursion
      (save-restriction
        (narrow-to-region $begin $end)
        (progn
          (goto-char (point-min))
          (while (re-search-forward "[ \t]+\n" nil "move")
            (replace-match "\n")))
        (progn
          (goto-char (point-min))
          (while (re-search-forward "\n\n\n+" nil "move")
            (replace-match "\n\n")))
        (progn
          (goto-char (point-max))
          (while (equal (char-before) 32) ; char 32 is space
            (delete-char -1))))
      (message "white space cleaned"))))

;; (add-hook 'before-save-hook 'xah-clean-whitespace)

(defun xah-clean-empty-lines ()
  "Replace repeated blank lines to just 1.
Works on whole buffer or text selection, respects `narrow-to-region'.

URL `http://ergoemacs.org/emacs/elisp_compact_empty_lines.html'
Version 2017-09-22"
  (interactive)
  (let ($begin $end)
    (if (region-active-p)
        (setq $begin (region-beginning) $end (region-end))
      (setq $begin (point-min) $end (point-max)))
    (save-excursion
      (save-restriction
        (narrow-to-region $begin $end)
        (progn
          (goto-char (point-min))
          (while (re-search-forward "\n\n\n+" nil "move")
            (replace-match "\n\n")))))))

(defun xah-next-user-buffer ()
  "Switch to the next user buffer.
“user buffer” is determined by `xah-user-buffer-q'.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (xah-user-buffer-q))
          (progn (next-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))

(defun xah-previous-user-buffer ()
  "Switch to the previous user buffer.
“user buffer” is determined by `xah-user-buffer-q'.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (xah-user-buffer-q))
          (progn (previous-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))

(defun xah-next-emacs-buffer ()
  "Switch to the next emacs buffer.
“emacs buffer” here is buffer whose name starts with *.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (not (string-equal "*" (substring (buffer-name) 0 1))) (< i 20))
      (setq i (1+ i)) (next-buffer))))

(defun xah-previous-emacs-buffer ()
  "Switch to the previous emacs buffer.
“emacs buffer” here is buffer whose name starts with *.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (not (string-equal "*" (substring (buffer-name) 0 1))) (< i 20))
      (setq i (1+ i)) (previous-buffer))))

(defun xah-user-buffer-q ()
  "Return t if current buffer is a user buffer, else nil.
Typically, if buffer name starts with *, it's not considered a user buffer.
This function is used by buffer switching command and close buffer command, so that next buffer shown is a user buffer.
You can override this function to get your idea of “user buffer”.
version 2016-06-18"
  (interactive)
  (if (string-equal "*" (substring (buffer-name) 0 1))
      nil
    (if (string-equal major-mode "dired-mode")
        nil
      t)))

(define-generic-mode 'xmodmap-mode
  '(?!)
  '("add" "clear" "keycode" "keysym" "pointer" "remove")
  nil
  '("[xX]modmap.*\\(rc\\)?\\'")
  nil
  "Simple mode for xmodmap files.")

(setq display-time-default-load-average nil)
(setq display-time-format "%H:%M")

(require 'time)

(defvar title-time-mode t
  "This is set to t iff we are displaying the current time in the title bar.")

(defun title-time-set ()
  "Set `frame-title-format' to the local system name followed by date,
time, and load information (as per `display-time-string-forms') and perhaps
followed by an appointment notification."
  (setq frame-title-format '(" " display-time-string)))

(defun title-time-update ()
  "Update the time display in the title-bar.
Skips inferior frames, that is, those without a minibuffer (eg. speedbar). "
  (interactive)
  ;; remove time display from the mode line
  (delq 'display-time-string global-mode-string)
  (delq 'appt-mode-string global-mode-string)
  (let ((start-frame (selected-frame)))
    (save-excursion
      (save-window-excursion
        (let ((my/frame-list (frame-list))
              (my/frame nil))
          (while (setq my/frame (car my/frame-list))
            (when (frame-parameter my/frame 'minibuffer)
              '(select-frame my/frame)
              (title-time-set))
            (setq my/frame-list (cdr my/frame-list))))))
    (select-frame start-frame)))

(add-hook 'display-time-hook #'title-time-update)

(display-time-mode 1)

(provide 'title-time)
(require 'title-time)

;;; title-time.el ends here


(define-derived-mode mv fundamental-mode

  (defun mv-hooks ()
    (setq display-line-numbers nil)
    (abbrev-mode -1)
    (vlf-mode 1))

  (add-hook 'mv-hook 'mv-hooks)

  (provide 'mv))

(general-define-key
 :keymaps 'mv-map
 "M-p" 'my/paragraph-backwards
 "M-n" 'my/paragraph-forward
 "<prior>" 'down-five
 "<next>" 'up-five)

(general-unbind 'mv-map
  :with 'ignore
  [remap my/quiet-save-buffer])


(defvar opened-org-agenda-files nil)

(defun opened-org-agenda-files ()
  (let ((files (org-agenda-files)))
    (setq opened-org-agenda-files nil)
    (mapcar
     (lambda (x)
       (when (get-file-buffer x)
	 (push x opened-org-agenda-files)))
     files)))

(defun kill-org-agenda-files ()
  (interactive)
  (let ((files (org-agenda-files)))
    (mapcar
     (lambda (x)
       (when
	   (and
	    (get-file-buffer x)
	    (not (member x opened-org-agenda-files)))
	 (kill-buffer (get-file-buffer x))))
     files)))

(defadvice org-agenda-list (around opened-org-agenda-list-around activate)
  (opened-org-agenda-files)
  ad-do-it
  (kill-org-agenda-files))

(defadvice org-search-view (around org-search-view-around activate)
  (opened-org-agenda-files)
  ad-do-it
  (kill-org-agenda-files))

(defadvice org-tags-view (around org-tags-view-around activate)
  (opened-org-agenda-files)
  ad-do-it
  (kill-org-agenda-files))

(defun my/notes-mode ()
  (interactive)
  (olivetti-mode -1)
  (setq-local mode-line-format nil))
