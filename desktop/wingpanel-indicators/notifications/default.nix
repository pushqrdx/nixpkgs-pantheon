{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, pkgconfig
, fetchpatch
, meson
, ninja
, vala
, gtk3
, granite
, libgee
, libhandy
, elementary-notifications
}:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-notifications";
  version = "2020-12-21";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "0d639a67dcc6dfe79627cdc23dc1390527e2aafc";
    sha256 = "05g1lxdsh364hyqmmw53i11ym6j8nx0gq6qb4dlqrpxgc4aiq9ld";
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
    elementary-notifications
    granite
    gtk3
    libgee
    libhandy
    pantheon.wingpanel
  ];

  meta = with stdenv.lib; {
    description = "Notifications Indicator for Wingpanel";
    homepage = "https://github.com/elementary/wingpanel-indicator-notifications";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
