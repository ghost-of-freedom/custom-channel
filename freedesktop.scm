(define-module (freedesktop)
  #:use-module (guix packages)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages kde-frameworks)
  #:use-module (gnu packages freedesktop)
  #:use-module (guix git-download)
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
           (commit "6c1358e7d77644b30563ab69330748cddae6c6f4")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "0scj60b4n7rfsd7j22dmd6r9drbj3b6nnq6pk88rhsxzxwv6j33b"))))
   (build-system cmake-build-system)
   (inputs
    (list qtbase-5 kcoreaddons ki18n knotifications))
   (native-inputs
    (list wayland xdg-desktop-portal extra-cmake-modules qtdeclarative kirigami kwindowsystem kwayland plasma-framework kwidgetsaddons kio knotifications kdeclarative))
   ;; (inputs `(("kcoreaddons" ,kcoreaddons)
   ;;           ("qtbase@5.15.2" ,qtbase@5.15.2)
   ;;          )) 
   ;; (native-inputs `(("xdg-desktop-portal" ,xdg-desktop-portal)
   ;;                  ))
   (synopsis "A backend implementation for xdg-desktop-portal that is using Qt/KDE")
   (description "A backend implementation for xdg-desktop-portal that is using Qt/KDE")
   (home-page "https://github.com/KDE/xdg-desktop-portal-kde")
   (license lgpl2.0+)))

(define-public plasma-wayland-protocols 
  (package
   (name "plasma-wayland-protocols")
   (version "1.7.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/ghost-of-freedom/plasma-wayland-protocols")
           (commit "1067b613212cf9c7d8da310c5147e9a783459617")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "034h3kki83ahr7jaw28h27qw6c98jy3y55qriazqiyfwcjzsmh8a"))))
   (build-system cmake-build-system)
   (inputs
    (list extra-cmake-modules))
   (native-inputs
    (list qtbase-5))
   (synopsis "Plasma Specific Protocols for Wayland")
   (description "Plasma Specific Protocols for Wayland")
   (home-page "https://invent.kde.org/libraries/plasma-wayland-protocols")
   (license lgpl2.1)))
