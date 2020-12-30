{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, pkgconfig
, meson
, python3
, ninja
, vala
, gtk3
, libgee
, granite
, gettext
, clutter-gtk
, elementary-icon-theme
, wrapGAppsHook
, libhandy
}:

stdenv.mkDerivation rec {
  pname = "switchboard";
  version = "2020-12-18";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "e4299f16f02c03cd2180c0399ce5cfde4c3eca0a";
    sha256 = "00f39l5m98gv81zr9p8l6i18dhq4vm80xmpwxvj18028d5l6g86d";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    gettext
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter-gtk
    elementary-icon-theme
    granite
    gtk3
    libgee
    libhandy
  ];

  patches = [
    ./plugs-path-env.patch
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Extensible System Settings app for Pantheon";
    homepage = "https://github.com/elementary/switchboard";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
