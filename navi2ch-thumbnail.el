;;; navi2ch-thumbnail.el --- thumbnail view for navi2ch -*- coding: iso-2022-7bit; -*-

;; Copyright (C) 2010 by Navi2ch Project

;; Authors: MIZUNUMA Yuto <mizmiz@users.sourceforge.net>
;; Keywords: network 2ch

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; $B%5%`%M%$%k$rI=<($9$k5!G=$G$9(B
;; $B2hA|I=<($KBP1~$7$?(Bemacs$B$GF0$-$^$9(B

;; $B2hA|%j%s%/(BURL$B>e$G(B','$B$r2!$9$H%5%`%M%$%k2hA|$rA^F~I=<($7$^$9!#<+F0<hF@!"(B
;; $B<+F0I=<($O$7$^$;$s!#4pK\E*$K%-!<$G6nF0$G$9!#%-%c%C%7%e$r;}$C$F$$$k2h(B
;; $BA|$O<+F0I=<($5$l$^$9!#%-%c%C%7%e$N<+F0:o=|5!G=$O$"$j$^$;$s!#4pK\E*$K(B
;; $B%3%^%s%I$O(BImageMagick$B0MB8$G$9!#(B
;;
;; $B;29M$K$7$?%3!<%I(B(navi2ch$B%9%l$N$I$3$+$G8+$?(B)$B$OHsF14|$@$C$?$j30It%7%'(B
;; $B%kC!$-$@$C$?$j$HJ#;($J$N$G!"$J$k$Y$/%7%s%W%k$K:F9=@.$7$^$7$?(B

;; To Do
;; - $B$I$3$+(B($BA4BN(B?)$B$r(B(display-images-p)$B$G0O$`$Y$-$@$,MW8!F$(B
;; - $B%-!<%P%$%s%ID4@0(B
;; - $B%9%l:FIA2h;~$K%5%`%M$rFI$^$J$+$C$?$jFI$s$@$j$,$"$k$+$b(B

;; $B@_DjNc(B
;; Windows
;;   (setq navi2ch-thumbnail-image-convert-program
;;         "C:/Program Files/ImageMagick-6.2.8-Q16/convert.exe")
;;   (setq navi2ch-thumbnail-image-identify-program
;;         "C:/Program Files/ImageMagick-6.2.8-Q16/identify.exe")
;;   (setq navi2ch-browse-url-image-program
;;         "c:/win/iview425j/i_view32.exe") ;; IrfanView
;; MacOSX
;;   (setq navi2ch-browse-url-image-program
;;         "/Applications/Preview.app/Contents/MacOS/Preview")
;;   (setq navi2ch-thumbnail-image-convert-program
;;         "/opt/local/bin/convert") ;; MacPort ImageMagick
;;   (setq navi2ch-thumbnail-image-identify-program "/opt/local/bin/identify")

;; $B;H$$J}!"7s%-!<%P%$%s%I(B
;;
;; URL$B$K%+!<%=%k$,$"$k>uBV$G(B','$B$r2!$9$H%5%`%M%$%kA^F~(B. $B%5%`%M%$%k$K%+!<(B
;; $B%=%k$,$"$k>uBV$G(B','$B$r2!$9$H30It%S%e!<%"!<$G%*%j%8%J%k2hA|I=<((B($BK\Ev$O(B
;; enter$B%-!<$G$d$k$[$&$,4qNo$J5$$b$9$k(B)
;;
;; $B%5%`%M%$%k$K%+!<%=%k$,$"$k>uBV$G(B'V'(shift+v)$B$G2hA|$rJ]B8(B($B%5%`%M%$%k$G$O$J$/!"(B
;; $B85$NBg$-$$2hA|(B)
;;
;; Esc+Enter$B$G(BURL$B$r%V%i%&%6$G3+$/(B($B4{B85!G=$K4]Ej$2(B)$B!#2hA|%S%e!<%"!<$,;X(B
;; $BDj$5$l$F$k$H!"$=$N(BURL$B$r3+$/$N$G%j%b!<%H$J%U%!%$%k$r3+$1$k%S%e!<%"!<(B
;; $B$,I,MW(B($B85!9$=$NF0:n(B)
;;
;; $B%5%`%M%$%k$K%+!<%=%k$,$"$k>uBV$G(B'C-cC-d'$B$r2!$9$H%-%c%C%7%e2hA|$r:o=|(B.
;;
;; 'T'$B$r2!$9$H%+!<%=%k$,$"$k%l%9(B1$B8D$N%l%9Fb$N(BURL$B$rA4<hF@(B

;;; Code

(provide 'navi2ch-thumbnail)

(defcustom navi2ch-thumbnail-thumbnail-directory
  (expand-file-name "navi2ch-thumbnails/" navi2ch-directory)
  "* $B2hA|%-%c%C%7%e%G%#%l%/%H%j(B"
  :type 'string
  :group 'navi2ch)

(defcustom navi2ch-thumbnail-save-content-dir "~/"
  "* $B2hA|J]B8;~$N%G%#%U%)%k%H%G%#%l%/%H%j(B"
  :type 'string
  :group 'navi2ch)

(defcustom navi2ch-thumbnail-image-convert-program
  (executable-find "convert")
  "* $B%5%`%M%$%k:n@.%W%m%0%i%`(B"
  :type 'string
  :group 'navi2ch)

(defcustom navi2ch-thumbnail-image-identify-program
  (executable-find "identify")
  "* $B%5%`%M%$%k2hA|H=JL%W%m%0%i%`(B"
  :type 'string
  :group 'navi2ch)

(defcustom navi2ch-thumbnail-thumbsize-width 300
  "* $B%5%`%M%$%kI=<(%5%$%:2#(B($BEyG\=L>.$G%"%9%Z%/%HHfJ];}(B)"
  :type 'integer
  :group 'navi2ch)

(defcustom navi2ch-thumbnail-thumbsize-height 150
  "* $B%5%`%M%$%kI=<(%5%$%:=D(B($BEyG\=L>.$G%"%9%Z%/%HHfJ];}(B)"
  :type 'integer
  :group 'navi2ch)

(defcustom navi2ch-thumbnail-use-mac-sips nil
  "* $B%5%`%M%$%k:n@.$K(BMacOSX$B$NI8=`%D!<%k$G$"$k(Bsips$B$r;H$&(B"
  :type 'bool
  :group 'navi2ch)

(defcustom navi2ch-thumbanil-imagemagick-resize-option "-sample"
  "* ImageMagick $B$G3HBg=L>.$r9T$J$&$5$$$N%*%W%7%g%s(B"
  :group 'navi2ch
  :type '(radio (const :format "-sample ($B9bB.(B)"  "-sample")
		(const :format "-resize ($B9b2h<A(B)" "-resize")))

(defvar navi2ch-thumbnail-404-list
  (list "/404\.s?html$"
	"10mai_404\.html$"))

(defvar navi2ch-thumbnail-enable-status-check t)

(defvar navi2ch-thumbnail-url-coversion-table
      '(
        ;; http://imepic.jp/20111231/11111 ->
        ;; http://img1.imepic.jp/image/20111231/11111.jpg?550e3768ff8455488ae8d5582f55db6d
        ("h?ttp://imepic\\.jp/\\([0-9/]+\\)" ".jpg" navi2ch-thumbnail-imepic "http://img1.imepic.jp/image/")
        ("h?t?tps?://twitter.com/.+/status/[0-9]+/photo/1" ".jpg" navi2ch-thumbnail-twitpic nil)
  )
      "$B%j%9%H9=B$(B
  0:$BBP>](BURL$B@55,I=8=(B
  1:$BI,MW$J$i$PIU2C3HD%;R(B($B3HD%;RL5$7$@$H2hA|%S%e!<%"!<$,<oN`$NH=JL%_%9$r$9$k(B)
  2:$BCV49=hM}4X?t(B(2$BCJ3,$N<hF@%W%m%;%9$,I,MW$J>l9g(B)
  3:$BCV49@55,I=8=(B($B>e5-(B0$B$G=&$C$?@55,I=8=$rKvHx$KIU2C(B)"
)


(defun navi2ch-thumbnail-image-pre (url &optional force)
  "force$B$O%9%l:FIA2h$G$O(Bnil"
  (let ((rtn nil) (real-image-url url) (target-list nil) (cache-url url))
    
    ;;imepic$BEy$N(BURL$B$,2hA|$C$]$/$J$$>l9g$N=hM}(B
    (dolist (l navi2ch-thumbnail-url-coversion-table)
      (setq url-regex (nth 0 l))
      (setq ext (nth 1 l))
      (when (string-match url-regex url)
        (setq target-list l)
        (if ext
            (setq cache-url (concat url ext)))))

    ;;$B%-%c%C%7%e$,$"$k>l9g$O%-%c%C%7%eI=<((B
    (setq rtn (navi2ch-thumbnail-insert-image-cache cache-url))

    ;;$B%-%c%C%7%e$,L5$$$N$G<hF@(B
    (when (and (not rtn) force)
      (setq real-image-url (navi2ch-thumbnail-url-status-check url))
      (dolist (l navi2ch-thumbnail-404-list)
        (when (string-match l real-image-url)
          (error "$B%U%!%$%k$,(B404 url=%s" url)))
      ;;URL$B=q$-49$($,I,MW$J>l9g(B
      (if target-list
          (setq real-image-url (funcall (nth 2 target-list) url (nth 0 target-list) (nth 3 target-list))))
      (setq rtn (navi2ch-thumbnail-show-image real-image-url cache-url url))
    rtn )))

(defun navi2ch-thumbnail-url-replace (url regex-src-url regex-dist-url)
  "URL$B$NC1=cCV49(B"
  (string-match regex-src-url url)
  (message "%s" regex-dist-url)
  (concat regex-dist-url (match-string 1 url)))

(defun navi2ch-thumbnail-imepic (url regex-src-url regex-dist-url)
  "imepic$B$N>l9g$N2hA|$r<hF@(B"
  (let ((proc (navi2ch-net-send-request
               url
               "GET"))
        cont)
    (setq cont (navi2ch-net-get-content proc))
    (if (string-match "\\(http://img1\.imepic\.jp/image/[0-9]+/[0-9]+\.jpg\?.+\\)\"" cont)
        (setq img-url (match-string 1 cont))
      (error "can't get image url from %s" url)))
;  (message "imepic:%s" img-url)
  img-url)

(defun navi2ch-thumbnail-twitpic (url &optional dummy0 dummy1)
  "twitpic$B$N>l9g$N2hA|$r<hF@(B"
  (let ((proc (navi2ch-net-send-request
               url
               "GET"))
        cont)
    (setq cont (navi2ch-net-get-content proc))
    (if (string-match "src=\"\\(http://pbs\.twimg\.com/media/.+\.jpg\\)\"" cont)
        (setq twitpic-img (match-string 1 cont))
      (error "can't get image url from %s" url))))

;;article$B$+$i2hA|$i$7$-%j%s%/$rC5$9(Bregex$B$r(B1$B9T$K$^$H$a$k(B
(defvar navi2ch-thumbnail-image-url-regex nil)

(defun navi2ch-thumbnail-image-url-regex-build ()
  "article$B$+$i2hA|$i$7$-%j%s%/$rC5$9(Bregex$B$r(B1$B9T$K$^$H$a$k(B"
  (setq navi2ch-thumbnail-image-url-regex
        (concat "\\("
                (mapconcat (function (lambda (x) (nth 0 x)))
                           navi2ch-thumbnail-url-coversion-table "\\|")
                "\\|h?t?tps?://[^ \t\n\r]+\\.\\(gif\\|jpe?g\\|png\\)"
                "\\)")))

(defun navi2ch-thumbnail-insert-image-reload ()
  "$B%9%l$,:FIA2h$5$l$k;~$K%5%`%M$b:FIA2h(B"
  (interactive)
  (let (url)
    (when (display-images-p)
      (save-excursion
        (if (not navi2ch-thumbnail-image-url-regex)
            (navi2ch-thumbnail-image-url-regex-build))
	(let ((buffer-read-only nil))
	  (goto-char (point-min))
	  (while (re-search-forward navi2ch-thumbnail-image-url-regex nil t)
	    (setq url (match-string 1))
            (navi2ch-thumbnail-image-pre url nil)))))))

(eval-and-compile
  (defalias 'navi2ch-create-image (if (fboundp 'create-animated-image)
				      'create-animated-image
				    'create-image)))

(defun navi2ch-plist-drop (props drops)
  (let (new-props)
    (while props
      (unless (memq (car props) drops)
	(setq new-props (nconc new-props (list (car props) (cadr props)))))
      (setq props (cddr props)))
    new-props))

(defun navi2ch-create-scaled-image (file-or-data &optional type data-p &rest props)
  (setq file-or-data (substring-no-properties file-or-data))
  (when (and (plist-member props :width)
	     (plist-member props :height))
    (let* ((new-props (navi2ch-plist-drop props '(:width :height)))
	   (image (apply 'navi2ch-create-image
			 file-or-data type data-p new-props))
	   (size (image-size image))
	   (width (car size))
	   (height (cdr size)))
      (setq props
	    (if (< (/ (float height) navi2ch-thumbnail-thumbsize-height)
		   (/ (float width) navi2ch-thumbnail-thumbsize-width))
		(plist-put new-props :width navi2ch-thumbnail-thumbsize-width)
	      (plist-put new-props :height navi2ch-thumbnail-thumbsize-height)))))
  (apply 'navi2ch-create-image
	 file-or-data type data-p props))

(defun navi2ch-thumbnail-save-content
  (cache-filename filename &optional overwrite)
  "$B%-%c%C%7%e$+$i2hA|$rJ]B8(B($B%5%`%M%$%k$G$O$J$/852hA|(B)"
  (interactive
   (let* ((prop-filename (get-text-property (point) 'file-name))
	  (default-filename (and prop-filename
				 (file-name-nondirectory prop-filename))))
     (list (or (get-text-property (point) 'navi2ch-link)
	       (error "No file to save."))
	   (let ((filename
		  (read-file-name
		   (if default-filename
		       (format "Save file (default `%s'): "
			       default-filename)
		     "Save file: ")
		   navi2ch-thumbnail-save-content-dir
		   (expand-file-name default-filename
				     navi2ch-thumbnail-save-content-dir))))
	     (if (file-directory-p filename)
		 (if default-filename
		     (expand-file-name default-filename filename)
		   (error "%s is a directory" filename))
	       filename))
	   0)))
  (copy-file cache-filename filename overwrite))

(defun navi2ch-thumbnail-show-image-external ()
  "$B30It%S%e!<%"!<$GI=<((B"
  (interactive)
  (let ((type (car (get-text-property (point) 'display)))
	(prop (get-text-property (point) 'navi2ch-link)))
    (when (eq type 'image)
      (navi2ch-browse-url-image
       (if (eq system-type 'windows-nt)
	   (navi2ch-replace-string "/" "\\\\" prop t)
	 prop)))))

(defun navi2ch-thumbnail-image-delete-cache ()
  "$B<hF@$7$?2hA|$r:o=|!#%-%c%C%7%e$,L5$/$J$k$NI=<($5$l$J$/$J$k(B"
  (interactive)
  (let* ((type (car (get-text-property (point) 'display)))
	 (file (get-text-property (point) 'navi2ch-link))
	 (thumb (concat file ".jpg")))
    (when (and file (file-exists-p file))
      (delete-file file)
      (message "deleting file:%s " file))
    (when (and thumb (file-exists-p thumb))
      (delete-file thumb)
      (message "deleting thumbnail:%s " thumb))))

(defun navi2ch-thumbnail-insert-image-cache (url)
  (if (string-match "h?ttps?://\\(.+\\)$" url)
      (setq url (match-string 1 url)))
  (let ((thumb_dir navi2ch-thumbnail-thumbnail-directory)
	file thumb image-attr)
    (setq url (navi2ch-thumbnail-image-escape-filename url))
    (setq file (concat thumb_dir url))
    (setq thumb (concat thumb_dir url ".jpg"))
    (when (and (not (file-exists-p thumb)) (file-exists-p file))
      (setq thumb file))
    (let ((buffer-read-only nil))
      (when (file-exists-p thumb)
	(move-beginning-of-line nil)
	(insert-image
	 (if (fboundp 'imagemagick-types)
	     (navi2ch-create-scaled-image thumb
					  'imagemagick nil
					  :width navi2ch-thumbnail-thumbsize-width
					  :height navi2ch-thumbnail-thumbsize-height)
	   (navi2ch-create-image thumb)))
	(add-text-properties
	 (1- (point)) (point)
	 (list 'link t 'link-head t
	       'url file 'help-echo file
	       'navi2ch-link-type 'image 'navi2ch-link file 'file-name file))
	(setq image-attr (navi2ch-thumbnail-image-identify file))
	(insert (format " (%sx%s:%sk%s)"
			(nth 0 image-attr)
			(nth 1 image-attr)
			(round (/ (nth 7 (file-attributes file)) 1024))
			(if (nth 2 image-attr) " GIF ANIME" "")))
      (if (re-search-forward
	   (concat "h?ttps?://\\([^ \t\n\r]+\\."
		   (regexp-opt navi2ch-browse-url-image-extentions t)
		   "\\)") nil t)
	  (save-excursion
	    (let ((url (concat "https?://" (match-string 1)))
		  (beg (match-beginning 0))
		  (end (match-end 0)))
	      (add-text-properties beg end '(navi2ch-image-shown "shown")))))
	(move-end-of-line nil)
	t))))

(defun navi2ch-thumbnail-all-show ()
  "1$B%l%9Fb$N2hA|$rO"B3<hF@I=<((B"
  (interactive)
  (let* ((prop (get-text-property (point) 'current-number))
	 (beg (if prop
		  (point)
		(previous-single-property-change (point) 'current-number)))
	 (end (next-single-property-change
	       (if prop (1+ (point)) (point))
	       'current-number)))
    (navi2ch-thumbnail-image-show-region
     (if beg (max (1- beg) (point-min)) (point-min))
     end)))

(defun navi2ch-thumbnail-image-show-region (begin end)
  "$B%j!<%8%g%sFb$N2hA|(BURL$B$rI=<((B"
  (interactive "rP")
  (save-restriction
    (save-excursion
      (let ((num (navi2ch-article-get-current-number))
	    (board (cdr (assq 'uri navi2ch-article-current-board)))
	    (regex (concat "h?ttp://\\([^ \t\n\r]+\\."
			   (regexp-opt navi2ch-browse-url-image-extentions t)
			   "\\)")))
	(narrow-to-region begin end)
	(goto-char begin)
	(while (re-search-forward regex nil t)
          (goto-char (match-beginning 0))
          (navi2ch-thumbnail-select-current-link)
          (goto-char (match-end 0)))))))

(defun navi2ch-thumbnail-image-shown-p ()
  (string= (get-text-property (point) 'navi2ch-image-shown) "shown"))

(defun navi2ch-thumbnail-image-escape-filename (filename)
  "$B%U%!%$%kL>$K;H$($J$$J8;z$r%(%9%1!<%W(B"
  (navi2ch-replace-string-regexp-alist '(("-" . "%2d")
					 (":" . "%3a")
					 ("\\?" . "%63"))
				       filename
				       t))

(defun navi2ch-thumbnail-show-image (url org-url &optional referer)
  (save-excursion
    (let ((buffer-read-only nil)
	  (thumb-dir navi2ch-thumbnail-thumbnail-directory)
	  thumb-file file width height size anime filename
	  image-attr)
      (unless (and (stringp org-url)
		   (string-match "tps?://\\(.+\\)$" org-url))
	(error "URL not match"))
      (setq file (expand-file-name
		  (navi2ch-thumbnail-image-escape-filename
		   (match-string 1 org-url))
		  thumb-dir))
      (setq thumb-file (concat file ".jpg"))
      (when (navi2ch-net-update-file url file nil nil nil nil
				     (when referer
				       (list (cons "Referer" referer))))
	(unless (file-exists-p file)
	  (error "$B%U%!%$%k$,$"$j$^$;$s(B %s" file))
	(unless (image-type-from-file-header file)
	  (let (buffer-error)
	    (with-temp-buffer
	      (insert-file-contents file nil 0 500)
	      (setq buffer-error (buffer-string)))
	    (delete-file file)
	    (error "$B2hA|%U%!%$%k$G$O$"$j$^$;$s(B %s %s" file buffer-error)))
	(setq filename (file-name-nondirectory file))
	(setq image-attr (navi2ch-thumbnail-image-identify file))
	(if (not image-attr)
	    (error "$B2hA|%U%!%$%k$r<1JL$G$-$^$;$s(B %s" file))
	(setq anime (nth 2 image-attr))
	(setq width (nth 0 image-attr))
	(setq height (nth 1 image-attr))
	(setq size (nth 7 (file-attributes file)))

	(cond
	 ((and (< width navi2ch-thumbnail-thumbsize-width)
	       (< height navi2ch-thumbnail-thumbsize-height))
	  (copy-file file thumb-file)
	  (insert-image (navi2ch-create-image file)))
	 ((fboundp 'imagemagick-types)
	  (let ((thumb (navi2ch-create-scaled-image
			 file
			 'imagemagick nil
			 :width navi2ch-thumbnail-thumbsize-width
			 :height navi2ch-thumbnail-thumbsize-height)))
	    (insert-image thumb)))
	 (t
	  (with-temp-buffer
            (cond
             ;;MacOSX$B$O(Bsips$B$H$$$&I8=`%D!<%k$G2hA|JQ49$G$-$k(B
             ;;GIF$B%"%K%a=hM}$O=L>.$@$1$G$G$-$k(B($B!)(B)
             (navi2ch-thumbnail-use-mac-sips
              (call-process "sips" nil t nil
                            "-s" "format" "jpeg" file "--out" thumb-file)
              (call-process "sips" nil t nil
                            "--resampleHeight"
                            (number-to-string navi2ch-thumbnail-thumbsize-height)
                            thumb-file "--out" thumb-file))
             (t
              (if (or (not anime) (fboundp 'create-animated-image))
                  (call-process navi2ch-thumbnail-image-convert-program
                                nil t nil
				navi2ch-thumbanil-imagemagick-resize-option
                                (format "%sx%s"
                                        navi2ch-thumbnail-thumbsize-width
                                        navi2ch-thumbnail-thumbsize-height)
                                file thumb-file)
                ;; GIF$B%"%K%a$O(B1$B%U%l!<%`$@$1$r;H$&(B
                (call-process navi2ch-thumbnail-image-convert-program
                              nil t nil
                              "-scene" "0"
			      navi2ch-thumbanil-imagemagick-resize-option
                              (format "%sx%s"
                                      navi2ch-thumbnail-thumbsize-width
                                      navi2ch-thumbnail-thumbsize-height)
                              file (concat file ".jpg"))
                (rename-file (concat file "-0" ".jpg") thumb-file)
	      
                (dolist (delfile (directory-files (file-name-directory thumb-file)
                                                  t
                                                  (concat (file-name-nondirectory file)
                                                          "-.+\.jpg")))
                  (delete-file delfile))
                (message "gif anime %s" anime)))))
	  (insert-image (navi2ch-create-image thumb-file))))
	(add-text-properties (1- (point)) (point)
			     (list 'link t 'link-head t
				   'url file 'help-echo file
				   'navi2ch-link-type 'image 'navi2ch-link file
				   'file-name filename
				   'width width 'height height 'size size)))

	(insert (format " (%s x %s :%s%sk) " width height
			(if anime " GIF ANIME" "") (round (/ size 1024))))

	(when (re-search-forward
	       (concat "h?ttps?://\\([^ \t\n\r]+\\."
		       (regexp-opt navi2ch-browse-url-image-extentions t)
		       "\\)") nil t)
	  (save-excursion
	    (let ((url (concat "http://" (match-string 1)))
		  (beg (match-beginning 0))
		  (end (match-end 0)))
	      (add-text-properties beg end '(navi2ch-image-shown "shown"))))))))

(defun navi2ch-thumbnail-select-current-link (&optional browse-p)
  (interactive "P")
  (let ((type (get-text-property (point) 'navi2ch-link-type))
	(prop (get-text-property (point) 'navi2ch-link))
	url)
    (cond
     ((eq type 'url)
      (cond
       ((and (not (navi2ch-thumbnail-image-shown-p))
             (string-match navi2ch-thumbnail-image-url-regex prop))
        (navi2ch-thumbnail-image-pre prop t)
;	(message "not image url but image")
        )

       ((and (file-name-extension prop)
	     (member (downcase (file-name-extension prop))
		     navi2ch-browse-url-image-extentions))
;	(when (not (navi2ch-thumbnail-insert-image-cache
;		    (substring prop 7 nil)))
;	  (setq url (navi2ch-thumbnail-url-status-check prop))
;	  (dolist (l navi2ch-thumbnail-404-list)
;	    (when (string-match l url)
;	      (error "$B%U%!%$%k$,(B404 url=%s" url)))
;	  (navi2ch-thumbnail-show-image url prop))
        )))
     ((eq type 'image)
      (navi2ch-thumbnail-show-image-external)))))

(defun navi2ch-thumbnail-url-status-check (url)
  "$B2hA|<hF@A0$K(B302$B$d(B404$B$N%A%'%C%/!#(B302$B$N>l9g0\F0@h(BURL$B$rJV$9(B"
  (when navi2ch-thumbnail-enable-status-check
    (let (header status md5 proc)
      (while (not (or (string= status "200")
		      (string= status "201")
		      (string= status "400")
		      (string= status "405")))
	(setq proc (navi2ch-net-send-request
		    url "HEAD"
		    (list
;                     (cons "User-Agent:" navi2ch-net-user-agent)
			  (cons "Referer" url )
                          )))
	(unless proc (error "$B%5!<%P$K@\B3$G$-$^$;$s(B url=%s" url))
	(setq status (navi2ch-net-get-status proc))
	(unless status (error "$B%5!<%P$K@\B3$G$-$^$;$s(B url=%s" url))
	(message "status %s" status)

	;; (setq header (navi2ch-net-get-header proc))	
	;; (when (setq md5 (cdr (assq 'Content-MD5 header)))
	;;   (error "Content-MD5 %s" md5))

	(cond ((or (string= status "404")
		   (string= status "403")
		   (string= status "408")
		   (string= status "503"))
	       (error "$B%V%i%&%:$9$k$N$d$a$^$7$?(B return code %s" status))
	      ((or (string= status "301")
		   (string= status "302")
		   (string= status "303")
		   (string= status "307")
                   )
	       (setq header (navi2ch-net-get-header proc))
	       (setq url (cdr (assq 'location header)))
	       (message "loacation %s" url))))))
  url)

(defun navi2ch-thumbnail-image-jpeg-identify (data)
  (let ((len (length data)) (i 2) (anime nil))
    (catch 'jfif
      ;;read more 8 byte in loop
      (while (< i (- len 8))
	(let ((nbytes (+ (lsh (aref data (+ i 2)) 8)
			 (aref data (+ i 3))))
              (code (+ (lsh (aref data i) 8)
			 (aref data (+ i 1)))))
	  (cond
           ;; DHT
	   ((= code #xffc4))
           ;; APP
           ((and (>= code #xffe0) (<= code #xffed)))
           ;; SOF0(baseline) or SOF2(progressive)
	   ((and (>= code #xffc0) (<= code #xffcF))
	    (let ((sample (aref data (+ i 4)))
		  (ysize (+ (lsh (aref data (+ i 5)) 8)
			    (aref data (+ i 6))))
		  (xsize (+ (lsh (aref data (+ i 7)) 8)
			    (aref data (+ i 8)))))
	      (throw 'jfif (list xsize ysize anime)))))
	  ;;skip x00(end marker) xff(start marker)
	  (setq i (+ i 2 nbytes)))))))

(defun navi2ch-thumbnail-image-png-identify (data)
  (let ((i 8)
	(anime nil))
    ;; magic number
    (when (string-match "\\`\x49\x48\x44\x52"
			(substring data (+ i 4)))
      (let (;; 4byte
	    (xsize
	     (+
	      (lsh (aref data (+ i 8)) 24)
	      (lsh (aref data (+ i 9)) 16)
	      (lsh (aref data (+ i 10)) 8)
	      (aref data (+ i 11))))
	    ;; 4byte
	    (ysize
	     (+
	      (lsh (aref data (+ i 12)) 24)
	      (lsh (aref data (+ i 13)) 16)
	      (lsh (aref data (+ i 14)) 8)
	      (aref data (+ i 15)))))
	(list xsize ysize anime)))))

(defun navi2ch-thumbnail-image-gif-identify (data)
  (let ((i 0)
	(len (length data))
	xsize
	ysize
	(anime nil)
	sgct slct)
    (setq i (+ i 6))

    ;; GIF Header
    ;; 2byte
    (setq xsize (+ (lsh (aref data (+ i 1)) 8)
		   (aref data i)))
    (setq i (+ i 2))
    ;; 2byte
    (setq ysize (+ (lsh (aref data (+ i 1)) 8)
		   (aref data (+ i 0))))
    (setq i (+ i 2))
    ;; Size of Global Color Table(3 Bits)
    (setq sgct (+ 1 (logand (aref data i) 7)))
    (setq i (+ i 3))

    ;; skip Global Color Table
    (setq i (+ i (* (expt 2 sgct) 3)))

    ;; Block
    (while (< i len)
      (cond
       ((= (aref data (+ i 0)) #x21)
	(setq i (+ i 1))
	(cond
	 ;; Graphic Control Extension
	 ((= (aref data (+ i 0)) #xf9)
	  (message "Graphic Control Extension")
	  (setq i (+ i 7)))

	 ;; maybe GIF Anime
	 ((= (aref data (+ i 0)) #xff)
	  (message "Application Extension GIF ANIME")
	  (setq anime t)
	  (setq i (+ i 7)))

	 ((= (aref data (+ i 0)) #xfe)
	  (message "Comment Extension")
	  (setq i (+ i 1))
	  (setq i (+ i (aref data i)))
	  (setq i (+ i 2))
	  )))

       ;; image block table
       ((= (aref data (+ i 0)) #x2c)
	(message "Image Block")
	(setq i (+ i 9))
	(setq slct (+ 1(logand (aref data i) 7)))
	(setq i (+ i (* (expt 2 slct) 3)))
	(setq i (+ i (aref data i)))
	(setq i (+ i 1))
;	(message "last i:%s" i)
        )
       (t (setq i (+ i 1024)))))
    (list xsize ysize anime)))

(defun navi2ch-thumbnail-image-identify (file &optional size)
  "$B2hA|%U%!%$%k$+$iI}(B,$B9b$5(B,GIF$B%"%K%a$+!)$r<hF@$7$F(Blist$B$GJV$9!#(B
$B<hF@$G$-$J$+$C$?>l9g$O30It%W%m%0%i%`(B(navi2ch-thumbnail-image-identify-program)$B$KMj$k!#(B
$B$=$l$G$b%@%a$J$i(Bnil$B$rJV$9!#(Bsize$B$GFI$_9~$`%5%$%:$r;XDj$b$G$-$k(B"
  (let ((file-size (nth 7 (file-attributes file)))
	data rtn)
    (catch 'identify
      (unless (file-readable-p file) (throw 'identify nil))
      (with-temp-buffer
	(set-buffer-multibyte nil)
	(unless size
	  (setq size 1024))
	(insert-file-contents-literally file nil 0 size)
	(setq data (buffer-substring (point-min)
				     (min (point-max)
					  (+ (point-min) size))))
	(cond
	 ;; gif
	 ((string-match "\\`GIF" data)
	  (setq rtn (navi2ch-thumbnail-image-gif-identify data)))
	 ;; png
	 ((string-match "\\`\x89\x50\x4E\x47\x0D\x0A\x1A\x0A" data)
	  (setq rtn (navi2ch-thumbnail-image-png-identify data)))
	 ;; jpeg
	 ((string-match "\\`\xff\xd8" data)
	  (setq rtn (navi2ch-thumbnail-image-jpeg-identify data))))
	(if rtn (throw 'identify rtn)))
      
      ;; $B>pJs$,<hF@$G$-$J$+$C$?>l9g$O%X%C%@$r$5$i$KFI$_9~$`(B
      (when (not (= size file-size))
        (setq size (* size 10))
        (if (> size file-size)
            (setq size file-size))
        (setq rtn (navi2ch-thumbnail-image-identify file size))
        (if rtn (throw 'identify rtn)))

      ;; $B$=$l$G$bL5M}$J$i30It%W%m%0%i%`$KMj$k(B
      (when navi2ch-thumbnail-image-identify-program
	(message "identify called %s" file)
	(with-temp-buffer
          (cond
           (navi2ch-thumbnail-use-mac-sips
	    (let (width height)
	      (call-process 'sips' nil t nil "-g" "-all" file)
	      (when (re-search-forward
		     "pixelWidth: \\([0-9]+\\)")
		(setq width (string-to-number (match-string 1))))
	      (when (re-search-forward
		     "pixelHeight: \\([0-9]+\\)")
		(setq height (string-to-number (match-string 1))))
	      ;;anime gif$B$O$"$-$i$a$k(B
              (list width height nil)))
           (t
            (call-process navi2ch-thumbnail-image-identify-program nil t nil
                          "-quiet" "-format" "\"%n %w %h %b\"" file)
            (goto-char (point-min))
            (when (re-search-forward
                   "\\([0-9]+\\) \\([0-9]+\\) \\([0-9]+\\) \\([0-9]+\\)")
              (list (string-to-number (match-string 2))
                    (string-to-number (match-string 3))
                    (> (string-to-number (match-string 1)) 1))))))))))
