(define-module (freedesktop)
  #:use-module (guix packages)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages kde-frameworks)
  #:use-module (gnu packages freedesktop)
  #:use-module (guix git download)
  #:use-module (guix licenses)
  #:use-module (guix build-system cmake))

(define-public custom-xdg-desktop-portal-kde
  (package
   (name "custom-xdg-desktop-portal-kde")
   (version "5.25.80")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/ghost-of-freedom/xdg-desktop-portal-kde")
           (commit "45c8492ba7cd2339a76e910e5bf510c29cb5af57")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1dkaskm8vprnw0kvg5ca62rhk1f8vaqbwr3vks1ji2hfhr9rcb56"))))
   (build-system cmake-build-system)
   (inputs
    (list qtbase-5 kcoreaddons ki18n knotifications))
   (native-inputs
    (list xdg-desktop-portal))
   ;; (inputs `(("kcoreaddons" ,kcoreaddons)
   ;;           ("qtbase@5.15.2" ,qtbase@5.15.2)
   ;;          )) 
   ;; (native-inputs `(("xdg-desktop-portal" ,xdg-desktop-portal)
   ;;                  ))
   (synopsis "A backend implementation for xdg-desktop-portal that is using Qt/KDE")
   (description "A backend implementation for xdg-desktop-portal that is using Qt/KDE")
   (home-page "https://github.com/KDE/xdg-desktop-portal-kde")
   (license lgpl2.0+)))
