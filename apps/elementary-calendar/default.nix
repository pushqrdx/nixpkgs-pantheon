{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, pkgconfig
, meson
, ninja
, vala
, desktop-file-utils
, gtk3
, granite
, libgee
, geoclue2
, libchamplain
, clutter
, folks
, geocode-glib
, python3
, libnotify
, libical
, evolution-data-server
, appstream-glib
, elementary-icon-theme
, wrapGAppsHook
, libhandy
}:

stdenv.mkDerivation rec {
  pname = "elementary-calendar";
  version = "2020-12-25";

  repoName = "calendar";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "6001fe5b7e8b600f5401f35fac0309941d7bc76b";
    sha256 = "0lzxavqc8i05xypn547mvrss6fh445qa3qp8p6sfn1bfyqp667yv";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    appstream-glib
    desktop-file-utils
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter
    elementary-icon-theme
    evolution-data-server
    folks
    geoclue2
    geocode-glib
    granite
    gtk3
    libchamplain
    libgee
    libical
    libnotify
    libhandy
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Desktop calendar app designed for elementary OS";
    homepage = "https://github.com/elementary/calendar";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
