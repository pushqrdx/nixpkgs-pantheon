{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, pkgconfig
, meson
, ninja
, vala
, python3
, gtk3
, glib
, granite
, libgee
, elementary-icon-theme
, elementary-gtk-theme
, gettext
, wrapGAppsHook
, appstream
, libhandy
}:

stdenv.mkDerivation rec {
  pname = "elementary-feedback";
  version = "2020-12-19";

  repoName = "feedback";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "b672739373c14e5a41d868cdb6cdcb4e1369ab74";
    sha256 = "0zp055nfn5sx7sy4k658i30bkmcn1wx7bdbqw4x021qxlpgnxiv3";
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
    elementary-icon-theme
    granite
    gtk3
    elementary-gtk-theme
    libgee
    glib
    appstream
    libhandy
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "GitHub Issue Reporter designed for elementary OS";
    homepage = "https://github.com/elementary/feedback";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
