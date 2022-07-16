(define-module (qt)
  #:use-module (guix licenses)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages xorg)
  ;#:use-module (guix build-system qt)
  #:use-module (guix build-system gnu))

(define *outname* #t)

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
   ;;(build-system qt-build-system)
   (build-system gnu-build-system)
   (arguments
    '(#:phases
      (modify-phases %standard-phases
        (replace 'configure
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (invoke "qmake")))
        (add-after 'build 'replace-makefiles
          (lambda* (#:key outputs #:allow-other-keys)
            (let* ((out (assoc-ref outputs "out")))
              (for-each (lambda (file)
                          (substitute* file
                            ;; (("/gnu/store/[a-zA-Z0-9]+-qtbase-[0-9.]+/lib/cmake")
                            ;; (string-append out "/lib/cmake"))
                            ;; (("/gnu/store/[a-zA-Z0-9]+-qtbase-[0-9.]+/lib/qt5/plugins/styles")
                            ;; (string-append out "/lib/qt5/plugins/styles"))))
                            (("/gnu/store/[a-zA-Z0-9]+-qtbase-[0-9.]+/lib/")
                            (string-append out "/lib/"))))
                        (cons*
                         (find-files "." "Makefile")
                         (find-files "src" "Makefile")
                         (find-files "src/plugins" "Makefile")
                         (find-files "src/plugins/styles" "Makefile")
                         (find-files "src/plugins/styles/plastique" "Makefile")
                         (find-files "src/plugins/styles/motif" "Makefile")
                         (find-files "src/plugins/styles/gtk2" "Makefile")
                         (find-files "src/plugins/styles/cleanlooks" "Makefile")
                         (find-files "src/plugins/styles/bb10style" "Makefile")
                         (find-files "src/plugins/platformthemes" "Makefile")
                         (find-files "src/plugins/platformthemes/gtk2" "Makefile"))))
            #t)))))
   (inputs (list qtbase-5 gtk+ libx11 pango))
   (native-inputs (list qtbase-5 gtk+ libx11 pango))
   (synopsis "Additional style plugins for Qt")
   (description "Additional style plugins for Qt")
   (home-page "https://github.com/qt/qtstyleplugins")
   (license lgpl2.1)))
