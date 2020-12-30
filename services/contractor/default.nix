{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, meson
, python3
, ninja
, pkgconfig
, vala
, glib
, libgee
, dbus
, glib-networking
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "contractor";
  version = "2019-08-14";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "73372b49f9e908811c7ef53444a82aa1a1fcb053";
    sha256 = "0mhw7ipka5y8fkd80dr2qqi5kxqvnb8hmv4km4d0y51hivv6cv0c";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    dbus
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    glib
    glib-networking
    libgee
  ];

  PKG_CONFIG_DBUS_1_SESSION_BUS_SERVICES_DIR = "${placeholder "out"}/share/dbus-1/services";

  meta = with stdenv.lib; {
    description = "A desktop-wide extension service used by elementary OS";
    homepage = "https://github.com/elementary/contractor";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
