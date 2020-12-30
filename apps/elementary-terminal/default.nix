{ stdenv
, fetchFromGitHub
, nix-update-script
, fetchpatch
, pantheon
, pkgconfig
, meson
, ninja
, python3
, vala
, desktop-file-utils
, gtk3
, libxml2
, granite
, libnotify
, vte
, libgee
, elementary-icon-theme
, appstream
, pcre2
, wrapGAppsHook
, libhandy
}:

stdenv.mkDerivation rec {
  pname = "elementary-terminal";
  version = "2020-12-19";

  repoName = "terminal";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "1bcad8fe20c6ba942825e8f332569bd04fd8553d";
    sha256 = "1v0fbqszsz78gyyz8hw1rn0krdqf1nrarq5hsmllnjn7i6lsiris";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    libxml2
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
    libgee
    libnotify
    pcre2
    vte
    libhandy
  ];

  # See https://github.com/elementary/terminal/commit/914d4b0e2d0a137f12276d748ae07072b95eff80
  mesonFlags = [ "-Dubuntu-bionic-patched-vte=false" ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Terminal emulator designed for elementary OS";
    longDescription = ''
      A super lightweight, beautiful, and simple terminal. Comes with sane defaults, browser-class tabs, sudo paste protection,
      smart copy/paste, and little to no configuration.
    '';
    homepage = "https://github.com/elementary/terminal";
    license = licenses.lgpl3;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
