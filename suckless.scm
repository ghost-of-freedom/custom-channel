(define-module (suckless)
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

(define-public custom-st-base
  (package
   (name "custom-st-base")
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

(define-public custom-st
  (package
    (inherit custom-st-base)
    (name "custom-st")
    (version "0.8.4.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ghost-of-freedom/st")
             (commit "62583225a9dfb975175d4f0c3053c2c2b41be5f3")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "00bp9ilnsli8r9agl9hp1vvk4j3s295bzpq9pcf8zfhs0kipvh0s"))))
    (home-page "https://github.com/ghost-of-freedom/st")
    (synopsis "Fork of st with few patches")
    (description
     "@command{st} uses Xresources and applies the following patches to
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

(define-public custom-dmenu-base
  (package
    (name "custom-dmenu-base")
    (version "5.1")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://dl.suckless.org/tools/dmenu-"
                                  version ".tar.gz"))
              (sha256
               (base32
                "1mcg6i5g2c4wsyq9ap739si4zghk1xg6c3msdqrbfzm3pfg70k8z"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f                      ; no tests
       #:make-flags
       (list (string-append "CC=" ,(cc-for-target))
             (string-append "PREFIX=" %output)
             (string-append "FREETYPEINC="
                            (assoc-ref %build-inputs "freetype")
                            "/include/freetype2"))
       #:phases
       (modify-phases %standard-phases (delete 'configure))))
    (inputs
     (list freetype libxft libx11 libxinerama))
    (home-page "https://tools.suckless.org/dmenu/")
    (synopsis "Dynamic menu")
    (description
     "A dynamic menu for X, originally designed for dwm.  It manages large
numbers of user-defined menu items efficiently.")
    (license license:x11)))

(define-public custom-dmenu
  (package
    (inherit custom-dmenu-base)
    (name "custom-dmenu")
    (version "1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ghost-of-freedom/dmenu")
             (commit "89f41bc24cc209e03c24335d858d9ab9f16ca32e")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1a259vky8vrbcblaqac7vr58b2qvj6zcrpx1yvz9glqhrlbvgkvx"))))
    (home-page "https://github.com/ghost-of-freedom/dmenu")
    (synopsis "Fork of dmenu with few patches")
    (description
     "@command{dmenu} uses Xresources and applies the following patches to
@command{dmenu}:
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
