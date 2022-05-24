(define-module (fonts)
  #:use-module (guix git-download)
  #:use-module (guix licenses)
  #:use-module (guix build-system font))

(define-public custom-font-ipamona
  (package
   (name "custom-font-mona")
   (version "1.0.8")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/ghost-of-freedom/font-ipamona")
           (commit "e82eb86b2feeba4527fff934051f7c5523356ff2")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1nd3q6yv8iixm1z88qf44xc7h5inmy1shsyn7lciblyn31cjx8gw"))))
   (build-system font-build-system)
   (home-page "https://web.archive.org/web/20190326123924/http://www.geocities.jp/ipa_mona/")
   (synopsis "Proportional IPA font version suitable for 2channel Shift_JIS art")
   (description "Proportional IPA font version suitable for 2channel Shift_JIS art")
   (license ipa)))
