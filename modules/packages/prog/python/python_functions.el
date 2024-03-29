;;;; FUNCTIONS ;;;;

(defun execute-python-program ()
  (interactive)
  (my/window-to-register-91)
  (my/quiet-save-buffer)
  (defvar foo)
  (setq foo (concat "python3 " (buffer-file-name)))
  (other-window 1)
  (switch-to-buffer-other-window "*Async Shell Command*")
  (shell-command foo))

(defun my/execute-python-program-shell-simple  ()
  (interactive)
  (my/window-to-register-91)
  (my/quiet-save-buffer)
  (defvar foo)
  (setq foo (concat "python3 " (prelude-copy-file-name-to-clipboard)))
  (shell-command foo))

(defun my/ex-python-run ()
  (interactive)
  (evil-ex "w !python3"))

(defun my/execute-python-program-shell ()
  (interactive)
  (progn
    (my/quiet-save-buffer)
    (prelude-copy-file-name-to-clipboard)
    (shell)
    (sit-for 0.3)
    (insert "source ~/scripts/cline_scripts/smallprompt.sh")
    (comint-send-input)
    (insert "python3 ")
    (yank)
    (comint-send-input)
    (evil-insert-state)
    (sit-for 0.3)
    (comint-clear-buffer)
    (company-mode -1)))

(defun my/run-python-external ()
  (interactive)
  (progn
    (prelude-copy-file-name-to-clipboard)
    (start-process-shell-command
     "call term" nil
     "~/scripts/i3_scripts/show_term_right")))

(defun my/python-mode-hooks ()
  (interactive)
  (electric-operator-mode 1)
  (my/company-idle-zero-prefix-one-quiet)
  ;; (my/company-idle-one-prefix-one-quiet)
  ;; (my/company-idle-two-prefix-two-quiet)
  ;; (my/company-idle-one-prefix-two-quiet)
  (importmagic-mode 1)
  (blacken-mode 1))

(defun my/inferior-python-mode-hooks ()
  (interactive)
  (line-numbers)
  (tab-jump-out-mode 1)
  (subword-mode 1))
