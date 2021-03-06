{ stdenv
, nix-update-script
, appstream
, appstream-glib
, dbus
, desktop-file-utils
, elementary-gtk-theme
, elementary-icon-theme
, fetchFromGitHub
, fetchpatch
, flatpak
, gettext
, glib
, granite
, gtk3
, json-glib
, libgee
, libsoup
, libxml2
, meson
, ninja
, packagekit
, pantheon
, pkgconfig
, python3
, vala
, polkit
, libhandy
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "appcenter";
  version = "2020-12-25";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "a7ad89fd0efaa901ae58688bd2b3051f9384ec26";
    sha256 = "0yc7fwm9fmazhcrydn8ra5dbqmj3w0dar7ayzqvjdwmpj1abrkiz";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    appstream-glib
    dbus # for pkgconfig
    desktop-file-utils
    gettext
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    appstream
    elementary-gtk-theme
    elementary-icon-theme
    flatpak
    glib
    granite
    gtk3
    json-glib
    libgee
    libhandy
    libsoup
    libxml2
    packagekit
    polkit
  ];

  mesonFlags = [
    "-Dhomepage=false"
    "-Dpayments=false"
    "-Dcurated=false"
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    homepage = "https://github.com/elementary/appcenter";
    description = "An open, pay-what-you-want app store for indie developers, designed for elementary OS";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
