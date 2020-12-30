{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, pkgconfig
, meson
, ninja
, vala
, gtk3
, granite
, networkmanager
, libnma
, libgee
, cmake
}:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-network";
  version = "2020-12-25";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "f9b87d1d14c16f722c4ae1078b43e4b4f531b090";
    sha256 = "1svq7fadh6vi18mzay6qspc81qnhfx2jr3prfxqfpkkgf8phvblf";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    meson
    cmake
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    granite
    gtk3
    libgee
    networkmanager
    libnma
    pantheon.wingpanel
  ];

  meta = with stdenv.lib; {
    description = "Network Indicator for Wingpanel";
    homepage = "https://github.com/elementary/wingpanel-indicator-network";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
