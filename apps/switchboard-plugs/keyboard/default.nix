{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, fetchpatch
, substituteAll
, meson
, ninja
, pkgconfig
, vala
, libgee
, granite
, gtk3
, libxml2
, libgnomekbd
, libxklavier
, xorg
, ibus
, switchboard
, libhandy
}:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-keyboard";
  version = "2020-12-23";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "26b024404d8fbaa6917cf832901293e4bc8b3970";
    sha256 = "1c95bkw0q1h3k2gi925m05x6gq22yrl38hn9plhg1zzmjjw42002";
  };

  patches = [
    ./0001-Remove-Install-Unlisted-Engines-function.patch
  ];

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
    ibus
    libgee
    libgnomekbd
    libxklavier
    libhandy
    switchboard
  ];

  meta = with stdenv.lib; {
    description = "Switchboard Keyboard Plug";
    homepage = "https://github.com/elementary/switchboard-plug-keyboard";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
