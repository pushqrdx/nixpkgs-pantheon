{ stdenv
, fetchFromGitHub
, fetchpatch
, nix-update-script
, pantheon
, substituteAll
, meson
, ninja
, pkgconfig
, vala
, libgee
, granite
, gtk3
, switchboard
, pciutils
, elementary-feedback
, libgtop
}:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-about";
  version = "2020-12-19";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "5aa4e54810cf1bfedf1abaa1e39d04aa36039581";
    sha256 = "01qhagvq69hm3r77pj0x0j59r5skf5h397mflqw0frwmbz3fkw30";
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
    libgtop
    switchboard
  ];

  meta = with stdenv.lib; {
    description = "Switchboard About Plug";
    homepage = "https://github.com/elementary/switchboard-plug-about";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };

}
