(define-module (wm)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages base)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix licenses)
  #:use-module (guix utils)
  #:use-module (guix packages))

(define-public i3ipc-glib
  (package
   (name "i3ipc-glib")
   (version "1.0.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/ghost-of-freedom/i3ipc-glib")
           (commit "ef6d03007f1f1d14d1ab171dc63e02f30f0fa5b3")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1gr7cg9qvdpjbjjl6g6sn43hk21xa9wnmlygfqiv9sazyw4ynirl"))))
   (build-system gnu-build-system)
   (inputs (list libxcb xcb-proto glib gobject-introspection json-glib gtk-doc))
   (native-inputs (list libxcb xcb-proto glib gobject-introspection json-glib gtk-doc which))
   (home-page "https://github.com/altdesktop/i3ipc-glib")
   (synopsis "A C interface library to i3wm ")
   (description "")
   (license gpl3)))
