{ stdenv
, substituteAll
, fetchFromGitHub
, nix-update-script
, pantheon
, meson
, ninja
, pkgconfig
, vala
, libgee
, granite
, gtk3
, switchboard
, onboard
}:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-a11y";
  version = "2020-12-19";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "c16bb69f3be22c051099fab5affec2a4a1538747";
    sha256 = "1s5aw9vzars28fd3pfkcv7vykfsd8xykxrcb0a705b5mm5dm28z9";
  };

  patches = [
    (substituteAll {
      src = ./fix-paths.patch;
      inherit onboard;
    })
  ];

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [
    granite
    gtk3
    libgee
    switchboard
  ];

  meta = with stdenv.lib; {
    description = "Switchboard Universal Access Plug";
    homepage = "https://github.com/elementary/switchboard-plug-a11y";
    license = licenses.lgpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
