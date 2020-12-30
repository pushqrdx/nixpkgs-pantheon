{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, pkgconfig
, meson
, ninja
, substituteAll
, vala
, gtk3
, libxml2
, libgee
, xorg
, libgnomekbd
, granite
, wingpanel
}:

stdenv.mkDerivation rec {
  pname = "wingpanel-indicator-keyboard";
  version = "2020-12-25";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "97b8ed7338b360c980049a985b908fa6fdc1a376";
    sha256 = "0d814kxj08rakwzfyvlb0x5mvpk6ps27rrknbddyi2fjrp1z8fng";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    meson
    ninja
    libxml2
    pkgconfig
    vala
  ];

  buildInputs = [
    granite
    gtk3
    libgee
    wingpanel
    xorg.xkeyboardconfig
  ];

  patches = [
    (substituteAll {
      src = ./fix-paths.patch;
      gkbd_keyboard_display = "${libgnomekbd}/bin/gkbd-keyboard-display";
    })
  ];

  meta = with stdenv.lib; {
    description = "Keyboard Indicator for Wingpanel";
    homepage = "https://github.com/elementary/wingpanel-indicator-keyboard";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
