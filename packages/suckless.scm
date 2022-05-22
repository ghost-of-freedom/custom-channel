(define-module (custom-channel packages suckless)
  #:use-module (gnu packages)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cups)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages image)
  #:use-module (gnu packages libbsd)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages mpd)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils)
  #:use-module (guix packages))

(define-public custom/st
  (package
   (name "custom/st")
   (version "0.8.5")
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://dl.suckless.org/st/st-"
                         version ".tar.gz"))
     (sha256
      (base32 "0dxb8ksy4rcnhp5k54p7i7wwhm64ksmavf5wh90zfbyh7qh34s7a"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f                      ; no tests
               #:make-flags
               (list (string-append "CC=" ,(cc-for-target))
                     (string-append "TERMINFO="
                                    (assoc-ref %outputs "out")
                                    "/share/terminfo")
                     (string-append "PREFIX=" %output))
               #:phases
               (modify-phases %standard-phases
                              (delete 'configure))))
   (inputs
    `(("libx11" ,libx11)
      ("libxft" ,libxft)
      ("fontconfig" ,fontconfig)
      ("freetype" ,freetype)))
   (native-inputs
    (list ncurses ;provides tic program
          pkg-config))
   (home-page "https://st.suckless.org/")
   (synopsis "Simple terminal emulator")
   (description
         "St implements a simple and lightweight terminal emulator.  It
implements 256 colors, most VT10X escape sequences, utf8, X11 copy/paste,
antialiased fonts (using fontconfig), fallback fonts, resizing, and line
drawing.")
       (license license:x11)))

(define-public custom/xst
  (package
    (inherit custom/st)
    (name "custom/xst")
    (version "0.8.4.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/gnotclub/xst")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1q64x7czpbcg0v509qchn5v96zdnx7jmvy0zxhjmkk3d10x5rqlw"))))
    (home-page "https://github.com/gnotclub/xst")
    (synopsis "Fork of st that uses Xresources")
    (description
     "@command{xst} uses Xresources and applies the following patches to
@command{st}:
@itemize
@item @uref{https://st.suckless.org/patches/alpha/, alpha}
@item @uref{https://st.suckless.org/patches/boxdraw/, boxdraw}
@item @uref{https://st.suckless.org/patches/clipboard/, clipboard}
@item @uref{https://st.suckless.org/patches/disable_bold_italic_fonts/, disable_bold_italic_fonts}
@item @uref{https://st.suckless.org/patches/externalpipe/, externalpipe}
@item @uref{https://st.suckless.org/patches/scrollback/, scrollback}
@item @uref{https://st.suckless.org/patches/spoiler/, spoiler}
@item @uref{https://st.suckless.org/patches/vertcenter/, vertcenter}
@end itemize")
    (license license:expat)))
