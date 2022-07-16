(define-module (qt)
  #:use-module (guix licenses)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system qt))

(define-public custom-qt-style-plugins
  (package
   (name "custom-qt-style-plugins")
   (version "5.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/ghost-of-freedom/qtstyleplugins")
           (commit "335dbece103e2cbf6c7cf819ab6672c2956b17b3")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1razd3xm4s4dggmns81cdv7xzpi65igxqlqjc1y2gg6nf99923rg"))))
   (build-system qt-build-system)
   (inputs (list qtbase-5 gtk+ libx11 pango))
   (native-inputs (list qtbase-5 gtk+ libx11 pango))
   (synopsis "Additional style plugins for Qt")
   (description "Additional style plugins for Qt")
   (home-page "https://github.com/qt/qtstyleplugins")
   (license lgpl2.1)))
