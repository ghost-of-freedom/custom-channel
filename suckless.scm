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

(define-public custom-st
  (package
    (name "custom-st")
    (version "1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ghost-of-freedom/st")
             (commit "46de2f8fefcb2419ee012851db8ea165aaea5608")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1bmslm3hxwjmkm9apazp2kglwr60lniwbr8cqbz13b8xcq8cia18"))))
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
    (home-page "https://github.com/ghost-of-freedom/st")
    (synopsis "Fork of st with custom config and few patches")
    (description
     "@command{st} with custom config and following patches:
@itemize
@item @uref{https://st.suckless.org/patches/solarized/, solarized-light}
@item @uref{https://st.suckless.org/patches/boxdraw/, boxdraw}
@item @uref{https://st.suckless.org/patches/bold-is-not-bright/, bold-is-not-bright}
@end itemize")
    (license license:expat)))

(define-public custom-dmenu
  (package
    (name "custom-dmenu")
    (version "1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ghost-of-freedom/dmenu")
             (commit "30c3931534dadedff0be760e5d10b2684bdf2a1e")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1kxnzbrw8y5dlwzj70sy8yysdxysphw592m9vnsnbprbss1vk0rg"))))
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
    (home-page "https://github.com/ghost-of-freedom/dmenu")
    (synopsis "Fork of dmenu with custom config and few patches")
    (description
     "@command{dmenu} with custom config and following patches:
@itemize
@item @uref{https://tools.suckless.org/dmenu/patches/solarized/, solarized-light}
@item @uref{https://tools.suckless.org/dmenu/patches/case-insensitive/, case-insensitive}
@item @uref{https://tools.suckless.org/dmenu/patches/center/, center}
@item @uref{https://tools.suckless.org/dmenu/patches/border/, border}
@item @uref{https://tools.suckless.org/dmenu/patches/mouse-support/, mouse-support}
@end itemize")
    (license license:expat)))
