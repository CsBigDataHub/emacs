;;; dupwords.el --- find duplicate words in sentences

;; Copyright (C) 1998 Stephen Eglen

;; Author: Stephen Eglen stephen@anc.ed.ac.uk
;; Maintainer: Tal Wrii <talwrii@gmail.com>
;; Created: 27 Jul 1998
;; Version: 2.0
;; Keywords: wp
;; Location: http://www.anc.ed.ac.uk/~stephen/emacs
;; Downloaded from: https://github.com/talwrii/emacs-dupwords
;; RCS: $Id: dupwords.el,v 1.6 2004/04/11 15:16:58 stephen Exp $

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; This program will find duplicate words in sentences.  For example,
;; in the sentence `The the cat sat on the mat', it will notice that
;; you have written `the the' and highlight the two identical words.
;; To check a region, use `M-x dupwords-check-region', or use `M-x
;; dupwords-check-to-end' to check from the current point to the end of the
;; buffer.  When you find a duplicate word, if you press `n' to exit,
;; point is left at the beginning of the first word, and mark at the
;; start of the second.

;; Some solutions to this have already been sent to the Emacs newsgroups e.g.
;; http://x8.dejanews.com/getdoc.xp?AN=118205039&fmt=raw
;; http://x8.dejanews.com/getdoc.xp?AN=118375212&fmt=raw

;; The advantage of this approach is that it also tells you when you
;; have used the same word further on in the same sentence.  Set
;; `dupwords-forward-words' to 1 if you wish to find only duplicate words
;; that are immediately next to each other.  Or, if you want to check
;; for duplicate words within three words of each other, set it to 3.
;; If you want to check for duplicate words anywhere within a
;; sentence, set dupwords-forward-words to a negative value.  Duplicate
;; occurences of common words within a sentence but not adjacent can
;; be ignored by including the word in `dupwords-ignore-list'.

;;; How it works.

;; For each sentence, a list of the words in it is created.  The
;; position of each word in the buffer is stored using the text
;; property `dupwords-pos'.  When we find duplicate words in the sentence,
;; the text property is used to highlight the duplicate words in the
;; buffer.

;;; Developed on Emacs 20.2, but tested also on Emacs 19.34 and XEmacs
;;; 19.15.  Should work in Emacs 21.


;;; Bugs / To do:

;; Works only in text-based modes, such as Text, LaTeX, since it
;; relies on defuns such as `forward-sentence'.

;; Doesn't finish cleanly if the final sentence is not complete.

;; This code is new, so I'm sure there are lots of bugs!

;;; Some suggestions from Drew Adams:
;; Create a single command, say dupwords-check, to do both dupwords-check-to-end and
;; dupwords-check-region: If the region is active - for example (and
;; transient-mark-mode mark-active) - then dupwords-check-region; else
;; dupwords-check-to-end. (In any case, dupwords-check-region does nothing if the region is
;; not active, so the command might as well check till the end.)

;; Cancel a dupwords command cleanly with C-g, in addition to `n'.  Perhaps
;; also give SPACE the same binding as `y' (continue), for convenience.

;;  Supply a value as prefix arg for use instead of dupwords-forward-words,
;; and have it default to dupwords-forward-words (whose defvar default value
;; could be 1). For example, M-x dupwords-check would check for adjacent
;; duplicates (assuming dupwords-forward-words = 1), C-u 3 would check for
;; duplicates within 3 words, M-- would check for duplicates within sentence.
;; That would be more convenient than users changing dupwords-forward-words. In other
;; words, dupwords-forward-words would act as a default value, which could be
;; overridden with a prefix arg.

;; When checking for adjacent duplicates, perhaps temporarily bind a
;; convenient key (e.g. `.' or `k' or `d') to the binding used by C-w
;; (usually kill-region, but not necessarily), to make it easier to remove the
;; duplicate.


;;; Code:

(defvar dupwords-forward-words -1
  "*Number of words to check forward in rest of sentence for repeated word.
A negative value means check all the way to the end of the sentence.")

(defvar dupwords-ignore-list '("the" "a" "on" "in" "of" "in" "and" "to")
  "*List of words to be ignored when checking for repeated words.
Will still check though if these words are adjacent.")

(defvar dupwords-sentence-start nil
  "Position of the start of the current sentence.")

(defvar dupwords-highlight-overlays [nil nil])

(defun dupwords-check-sentence (s)
  "Check the current sentence for repeated words.
S is a list of symbols representing the words in the sentence."
  (let (word rest)
    (while s
      (setq word (car s)
	    s (cdr s))
      (dupwords-check-next dupwords-forward-words word s)
      )))


(defun dupwords-ignore-word-p (word)
  "Return non-nil if WORD is in `dupwords-ignore-list'."
  ;; in Emacs 20 we can use just (member word dupwords-ignore-list),
  ;; but this doesn't work in Emacs 19.
  (let ((l dupwords-ignore-list)
	(searching t))
    (while (and searching (car l)
      (if (string= word (car l))
	  (setq searching nil)
	(setq l (cdr l)))))
    l))

(defun dupwords-check-next (n word rest)
  "Check to see if WORD occurs in next N elements of the REST of sentence."
  (if (dupwords-ignore-word-p word)
      ;; check only immediately following words.
      (setq n 1))
  (while (and (not (= n 0)) rest)
    (if (string= word (car rest))
	;; found a repeated word.
	(progn
	  (dupwords-highlight-words word (car rest))
	  (if (not (y-or-n-p (format "`%s' is repeated -- continue? " word)))
	      (dupwords-abort))))
    ;; move on to other words.
    (setq rest (cdr rest)
	  n (1- n))))


(defun dupwords-abort ()
  "Abort checking words.
Point is left at start of first duplicate word, and mark at the start
of the second."
  ;; Move point to start of first repeated word.
  (goto-char (overlay-start (aref dupwords-highlight-overlays 0)))
  (push-mark (overlay-start (aref dupwords-highlight-overlays 1)))
  (dupwords-unhighlight 0)
  (dupwords-unhighlight 1)
  (error "Abort duplicate word checking."))


(defun dupwords-finish ()
  "Finish checking words."
  (dupwords-unhighlight 0)
  (dupwords-unhighlight 1)
  (message "Finished duplicate word checking."))

(defun dupwords-highlight-words (word1 word2)
  "Highlight WORD1 and WORD2 (instances of the same word)."
  (let (
	(beg nil)
	(end nil)
	)
    (setq beg (get-text-property 0 'dupwords-pos word1)
	  end (+ beg (length word1)))
    (dupwords-highlight 0 beg end)

    (setq beg (get-text-property 0 'dupwords-pos word2)
	  end (+ beg (length word2)))
    (dupwords-highlight 1 beg end)
    ))


(defun dupwords-check-to-end ()
  "Check to the end of the document."
  (interactive)
  (dupwords-check-region (point) (point-max)))

;; (global-set-key (quote [f5]) 'dupwords-check-to-end)
;; (global-set-key (quote [f5]) 'dupwords-check-region)


(defun dupwords-check-region (beg end)
  "Check the current region for duplicate words."
  (interactive "r")
  (let (sentence end-sen beg-word end-word word-string word)
    (goto-char beg)
    (while (< (point) end)
      ;; get next sentence.
      ;; assume point is at beginning of sentence.
      (setq sentence nil)
      (setq dupwords-sentence-start (point))
      (forward-sentence 1)
      (setq end-sen (point))

      (goto-char dupwords-sentence-start)
      (while (< (point) end-sen)
	(re-search-forward "\\b\\w")
	(forward-char -1)
	(setq beg-word (point))
	;;(forward-word 1)
	(re-search-forward "\\W")
	(setq end-word (1- (point)))
	(cond ( (< end-word end-sen)
		;; get the current word as a string
		(setq word-string (buffer-substring beg-word end-word))
		;; convert it to a symbol
		(setq word (downcase word-string))
		(put-text-property 0 1 'dupwords-pos beg-word word)
		(setq sentence (cons word sentence))) ))
      (setq sentence (reverse sentence))
      ;;(setq ts sentence) ;todo -- delete.
      (goto-char end-sen)
      ;; Once the current sentence has been converted into a list of symbols,
      ;; we can find out if there are any double words.
      (dupwords-check-sentence sentence)
      ) ; try next sentence.
    (dupwords-finish)
    ))



;;; Highlighting (copied from reftex.el -- cheers Carsten!)

;; Highlighting uses overlays.  If this is for XEmacs, we need to load
;; the overlay library, available in version 19.15
(and (not (fboundp 'make-overlay))
     (condition-case nil
         (require 'overlay)
       ('error
        (error "Fm needs overlay emulation (available in XEmacs 19.15)"))))

;; Initialize the overlays
(aset dupwords-highlight-overlays 0 (make-overlay 1 1))
(overlay-put (aref dupwords-highlight-overlays 0) 'face 'highlight)
(aset dupwords-highlight-overlays 1 (make-overlay 1 1))
(overlay-put (aref dupwords-highlight-overlays 1) 'face 'highlight)

;; Two functions for activating and deactivation highlight overlays
(defun dupwords-highlight (index begin end &optional buffer)
  "Highlight a region with overlay INDEX."
  (move-overlay (aref dupwords-highlight-overlays index)
                begin end (or buffer (current-buffer))))


(defun dupwords-unhighlight (index)
  "Detatch overlay INDEX."
  (delete-overlay (aref dupwords-highlight-overlays index)))

(provide 'dupwords)
;;; dupwords.el ends here
