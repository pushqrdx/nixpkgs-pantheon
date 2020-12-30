{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, wrapGAppsHook
, pkgconfig
, meson
, ninja
, vala
, gala
, gtk3
, libgee
, granite
, gettext
, mutter
, json-glib
, python3
, elementary-gtk-theme
, elementary-icon-theme
}:

stdenv.mkDerivation rec {
  pname = "wingpanel";
  version = "2020-06-17";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "d6195192d373fa6d870879889dfd7a194a1b8a8b";
    sha256 = "0d3qjc7c0275inz1g7yf8l6az229q8f3k0clbr8p6hgjr19ma913";
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
    elementary-gtk-theme
    elementary-icon-theme
    gala
    granite
    gtk3
    json-glib
    libgee
    mutter
  ];

  patches = [
    ./indicators.patch
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  preFixup = ''
    gappsWrapperArgs+=(
      # this theme is required
      --prefix XDG_DATA_DIRS : "${elementary-gtk-theme}/share"
    )
  '';

  meta = with stdenv.lib; {
    description = "The extensible top panel for Pantheon";
    longDescription = ''
      Wingpanel is an empty container that accepts indicators as extensions,
      including the applications menu.
    '';
    homepage = "https://github.com/elementary/wingpanel";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
