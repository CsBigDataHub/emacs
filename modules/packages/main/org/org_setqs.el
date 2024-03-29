
  (setq org-clock-sound "~/Music/Sounds/cuckoo.au")
  (setq org-lowest-priority 73)
  (setq org-default-priority 70)

  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-timestamp-if-done t)
  (setq org-agenda-skip-scheduled-if-done t)

  (setq org-global-properties
	'(("Effort_ALL" .
	   "0:05 0:10 0:15 0:25 0:30 0:45 1:00 2:00 4:00 6:00")))
  (setq org-modules '(org-w3m org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-eww org-habit))


    ;;; http://bit.ly/2KJHooJ
  (setq org-agenda-files (apply 'append
				(mapcar
				 (lambda (directory)
				   (directory-files-recursively
				    directory org-agenda-file-regexp))
				 '("~/org/Agenda"))))

  (setq org-deadline-warning-days 7)
  (setq org-enforce-todo-checkbox-dependencies nil)
  (setq org-link-file-path-type 'relative)
  (setq org-export-with-toc nil)
  (setq calendar-date-style 'european)

  ;; (setq org-clock-persist nil)
  ;; (org-clock-persistence-insinuate)
  (setq org-clock-in-resume t)
  (setq org-pretty-entities t)
  (setq org-clock-into-drawer t)
  (setq org-clock-out-when-done t)
  (setq org-clock-history-length 10)
  (setq org-clock-mode-line-total 'auto)
  (setq org-clock-clocked-in-display t)
  (setq org-clock-persist-query-resume t)
  (setq org-clock-out-remove-zero-time-clocks nil)
  (setq org-clock-report-include-clocking-task t)
  (setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
  (setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))  ;; Separate drawers for clocking and logs
  (setq org-log-into-drawer t)


  (setq org-edit-src-content-indentation 1)
  (setq org-src-preserve-indentation t)
  (setq org-edit-src-persistent-message nil)
  (setq org-edit-src-auto-save-idle-delay 1)

  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-confirm-babel-evaluate nil)
  (setq org-babel-no-eval-on-ctrl-c-ctrl-c t)
  (setq org-src-ask-before-returning-to-edit-buffer nil)
  (setq org-src-window-setup 'current-window)

  ;; (setq org-time-stamp-formats '("<%Y-%m-%d %a>" . "<%Y-%m-%d %H:%M %a>"))
  ;; (setq org-time-stamp-custom-formats '("<%d/%m/%Y %a>" . "<%d/%m/%Y %H:%M %a>"))
  ;; (setq org-display-custom-times t)
  ;; (setq-default org-display-custom-times t)

  (setq org-pretty-entities-include-sub-superscripts nil)
  (setq org-format-latex-options
	(plist-put org-format-latex-options :scale 1.3))
  (setq org-archive-location "~/org/Info/Config/archive.org::* From %s")
  (setq org-export-with-archived-trees nil)
  (setq org-export-html-postamble nil)
  (setq org-indent-mode t)
  (setq org-link-frame-setup ( quote ((file . find-file))))
  (setq org-allow-promoting-top-level-subtree nil)
  (setq org-image-actual-width nil)
  (setq org-use-speed-commands t)
  (setq org-cycle-level-faces t)
  (setq org-return-follows-link t)
  (setq org-fontify-whole-heading-line t)
  (setq org-hide-emphasis-markers t)
  (setq org-startup-indented t)
  (setq org-replace-disputed-keys t)
  (setq org-ellipsis ".")
  (setq org-babel-temporary-directory "~/.emacs.d/babel-temp")
  (setq org-fontify-done-headline t)

  (setq org-todo-keywords
	'((sequence "TODO(t!)" "STARTED(s!)" "|"  "DONE(d!)")))

  (setq org-tags-column -79)
  (setq org-agenda-tags-column -80)

  (setq org-refile-targets '((nil :maxlevel . 9)
			     (org-agenda-files :maxlevel . 9)))

  ;; (setq org-refile-targets '((nil :maxlevel . 9)))

  (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
  ;; (setq org-refile-use-outline-path file)                  ; Show full paths for refiling
  (setq org-refile-use-outline-path 'file)
  (setq org-refile-allow-creating-parent-nodes (quote confirm))

  (setq org-file-apps (quote ((auto-mode . emacs)
			      ("\\.mm\\'" . default)
			      ("\\.x?html?\\'" . default)
			      ("\\.jpg\\'" . "~/scripts/cline_scripts/my_feh %s")
			      ("\\.mp4\\'" . "vlc %s")
			      ("\\.pdf\\'" . default))))


  ;;;; See:
  ;;;;; https://orgmode.org/manual/Template-expansion.html#Template-expansion
  (setq org-capture-templates
	'(("a" "Agenda" entry  (file+headline "~/org/Agenda/agenda.org" "Tasks") "* TODO %i%^{1|Title}\nDEADLINE: %^t\n%?")
	  ("p" "Planning" entry  (file+headline "~/org/Agenda/planning.org" "Tasks") "* TODO %i%^{1|Title}\nDEADLINE: %^t\n%?")))
