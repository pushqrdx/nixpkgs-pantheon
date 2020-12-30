{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, pkgconfig
, meson
, ninja
, vala
, libxml2
, desktop-file-utils
, gtk3
, glib
, granite
, libgee
, elementary-icon-theme
, wrapGAppsHook
, libhandy
}:

stdenv.mkDerivation rec {
  pname = "elementary-shortcut-overlay";
  version = "2020-12-19";

  repoName = "shortcut-overlay";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "34e56468664062ecc1fff15680d5a17b00c4d9c1";
    sha256 = "1csx874jx96z26vbq9lnsmd6rnjxjylmjf52gn4amqynn8vaw53n";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    desktop-file-utils
    libxml2
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    elementary-icon-theme
    glib
    granite
    gtk3
    libgee
    libhandy
  ];

  meta = with stdenv.lib; {
    description = "A native OS-wide shortcut overlay to be launched by Gala";
    homepage = "https://github.com/elementary/shortcut-overlay";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
