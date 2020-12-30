{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, meson
, ninja
, substituteAll
, pkgconfig
, vala
, libgee
, granite
, gtk3
, libxml2
, switchboard
, tzdata
}:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-datetime";
  version = "2020-12-23";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "6f815d9c2b6de5d7cc6c7ee3522339709c9048e9";
    sha256 = "07qqxy2kq6xawpwjmrv5ffpqjxapgyh23gkaz25lwv5mnigwvc5b";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    libxml2
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
    description = "Switchboard Date & Time Plug";
    homepage = "https://github.com/elementary/switchboard-plug-datetime";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
