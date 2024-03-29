(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
 (when no-ssl
  (warn "\
   Your version of Emacs does not support SSL connections,
   which is unsafe because it allows man-in-the-middle attacks.
   There are two things you can do about this warning:
   1. Install an Emacs version that does support SSL and be safe.
   2. Remove this warning from your init file so you won't see it again."))
 (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
 (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
 (when (< emacs-major-version 24)
  (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(custom-set-variables
 '(package-selected-packages '(use-package)))

(use-package quelpa
 :init
 (setq quelpa-update-melpa-p nil)
 :ensure t)

    (use-package quelpa-use-package
     :ensure t)

(setq custom-file "~/.emacs.d/etc/custom.el")
(setq initial-buffer-choice nil)
(setq initial-scratch-message nil)
(setq inhibit-startup-message t)
(setq initial-buffer-choice nil)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq default-frame-alist '((font . "Input Mono Light 13")))

(use-package menu-bar
:ensure nil
:config
(menu-bar-mode -1))

(defun line-numbers ()
  (interactive)
  (setq display-line-numbers 'visual)
  (setq display-line-numbers-widen nil)
  (setq display-line-numbers-current-absolute nil))

;; (setq-default left-fringe-width nil)

(defun line-numbers-absolute ()
  (interactive)
  (setq display-line-numbers 'visual)
  (setq display-line-numbers-widen nil)
  (setq display-line-numbers-current-absolute t))

(defun noct:relative ()
  (setq-local display-line-numbers 'visual))

(defun noct:absolute ()
  (setq-local display-line-numbers t))

(defun line-no-numbers ()
  (interactive)
  (setq display-line-numbers nil))


(add-to-list 'load-path "~/.emacs.d/modules/packages/lisp")

;;;; http://bit.ly/2YQFVQu (defun load-directory (dir)
(defun load-directory (dir)
      (let ((load-it (lambda (f)
		       (load-file (concat (file-name-as-directory dir) f)))
		     ))
	(mapc load-it (directory-files dir nil "\\.el$"))))

;;;; LOAD MAIN PACKAGES
(load-file "~/.emacs.d/modules/packages/main/general.el")
(load-file "~/.emacs.d/modules/packages/main/evil.el")
(load-file "~/.emacs.d/modules/packages/main/org.el")
(load-file "~/.emacs.d/modules/packages/main/org/org_functions.el")
(load-file "~/.emacs.d/modules/packages/main/org/org_keys.el")
(load-file "~/.emacs.d/modules/packages/misc/hydra.el")

;;;; LOAD DIRECTORIES ;;;;
(load-directory "~/.emacs.d/modules/packages/misc")
(load-directory "~/.emacs.d/modules/packages/prog")
(load-directory "~/.emacs.d/modules/settings")

