{ stdenv
, fetchFromGitHub
, nix-update-script
, fetchpatch
, pantheon
, meson
, ninja
, pkgconfig
, vala_0_46
, libgee
, granite
, gtk3
, libaccounts-glib
, libsignon-glib
, json-glib
, librest
, webkitgtk
, libsoup
, switchboard
}:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-onlineaccounts";
  version = "2020-12-19";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "24ddcce704e05536e214993bdcf2f6221465cf71";
    sha256 = "0bkmqsic25qx9nr1c2cynwbnaapcfz6rffvll380nzv4sjink917";
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
    vala_0_46
  ];

  buildInputs = [
    granite
    gtk3
    json-glib
    libaccounts-glib
    libgee
    libsignon-glib
    libsoup
    librest
    switchboard
    webkitgtk
  ];

  PKG_CONFIG_LIBACCOUNTS_GLIB_PROVIDERFILESDIR = "${placeholder "out"}/share/accounts/providers";
  PKG_CONFIG_LIBACCOUNTS_GLIB_SERVICEFILESDIR = "${placeholder "out"}/share/accounts/services";
  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "${placeholder "out"}/lib/switchboard";

  meta = with stdenv.lib; {
    description = "Switchboard Online Accounts Plug";
    homepage = "https://github.com/elementary/switchboard-plug-onlineaccounts";
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };

}
