{ stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, vala
, gtk3
, glib
, granite
, libgee
, libcanberra-gtk3
, pantheon
, python3
, wrapGAppsHook
, libhandy
}:

stdenv.mkDerivation rec {
  pname = "elementary-notifications";
  version = "2020-12-19";

  repoName = "notifications";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "248fb258429042f69d77cf8f063f5a3b42c276aa";
    sha256 = "08n7g5zsb185864j3hqy1ccp0l4zissig6wykfaaxpcq6ndk5i6p";
  };

  nativeBuildInputs = [
    glib # for glib-compile-schemas
    meson
    ninja
    pkg-config
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    glib
    granite
    gtk3
    libcanberra-gtk3
    libgee
    libhandy
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "GTK notification server for Pantheon";
    homepage = "https://github.com/elementary/notifications";
    license = licenses.gpl3Plus;
    maintainers = pantheon.maintainers;
    platforms = platforms.linux;
  };
}
