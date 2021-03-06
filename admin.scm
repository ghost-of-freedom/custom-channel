(define-module (admin)
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

(define-public custom-dhcpcd
  (package
   (name "custom-dhcpcd")
   (version "9.4.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/NetworkConfiguration/dhcpcd")
           (commit "dhcpcd-9.4.1")))
     (file-name (git-file-name name version)) 
     (sha256
      (base32 "0xx40nxgs7v7i1h6vsjn3a1yqgvmzs9nyzcd00qa607cwhvlwb5b")))) 
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f
      #:configure-flags
      (list "--disable-privsep")))
   (home-page "https://roy.marples.name/projects/dhcpcd/")
   (synopsis "DHCP / IPv4LL / IPv6RA / DHCPv6 client.")
   (description "dhcpcd is a DHCP and a DHCPv6 client. It's also an IPv4LL (aka ZeroConf) client. In layman's terms, dhcpcd runs on your machine and silently configures your computer to work on the attached networks without trouble and mostly without configuration.")
   (license license:bsd-2)))
