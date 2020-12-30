{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, pkgconfig
, meson
, ninja
, gettext
, vala
, python3
, desktop-file-utils
, libcanberra
, gtk3
, glib
, libgee
, granite
, libnotify
, libunity
, pango
, elementary-dock
, bamf
, sqlite
, libdbusmenu-gtk3
, zeitgeist
, glib-networking
, elementary-icon-theme
, libcloudproviders
, libgit2-glib
, wrapGAppsHook
, libhandy
, systemd
}:

stdenv.mkDerivation rec {
  pname = "elementary-files";
  version = "2020-12-25";

  repoName = "files";

  outputs = [ "out" "dev" ];

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "ea69a76eb0d97a66286f897126ea82152be204db";
    sha256 = "0gd9sz64zn4zk4q3mrbamn1hkkyh2zpc3j1abl14l8vbn5rsgm9q";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    desktop-file-utils
    gettext
    glib-networking
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    bamf
    elementary-dock
    elementary-icon-theme
    granite
    gtk3
    libcanberra
    libcloudproviders
    libdbusmenu-gtk3
    libgee
    libgit2-glib
    libnotify
    libunity
    pango
    sqlite
    zeitgeist
    libhandy
    systemd
  ];

  #patches = [
  #  ./0001-filechooser-module-hardcode-gsettings-for-nixos.patch
  #];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py

    substituteInPlace filechooser-portal/FileChooserDialog.vala \
      --subst-var-by ELEMENTARY_FILES_GSETTINGS_PATH ${glib.makeSchemaPath "$out" "${pname}-${version}"}
  '';

  meta = with stdenv.lib; {
    description = "File browser designed for elementary OS";
    homepage = "https://github.com/elementary/files";
    license = licenses.lgpl3;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
