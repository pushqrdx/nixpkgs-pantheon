{ stdenv
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
, flatpak
}:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-applications";
  version = "2020-12-19";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "77ef00e0f5a0e4402f4e3aa84c866b34c1d29d0c";
    sha256 = "1ih5zwzcqglqnjcrl88igjjjizl2xs1dqalbljmw05wsa6klrzsd";
  };

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
    flatpak
  ];

  meta = with stdenv.lib; {
    description = "Switchboard Applications Plug";
    homepage = "https://github.com/elementary/switchboard-plug-applications";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
