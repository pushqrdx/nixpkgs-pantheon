{ stdenv
, fetchFromGitHub
, nix-update-script
, fetchpatch
, pantheon
, pkgconfig
, meson
, ninja
, vala
, gtk3
, granite
, accountsservice
, libgee
, libhandy
}:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-session";
  version = "2020-12-19";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "5e265b35e3bd646311311fb2cd06dd5753302dd7";
    sha256 = "1hhmp2hxc85s2drmpn4m9iwwhn8w6sj2jkp9fqqjl6q22z2dnwqr";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    accountsservice
    granite
    gtk3
    libgee
    libhandy
    pantheon.wingpanel
  ];

  meta = with stdenv.lib; {
    description = "Session Indicator for Wingpanel";
    homepage = "https://github.com/elementary/wingpanel-indicator-session";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
