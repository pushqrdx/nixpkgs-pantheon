{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, meson
, ninja
, pkgconfig
}:

stdenv.mkDerivation rec {
  pname = "elementary-sound-theme";
  version = "2018-05-21";

  repoName = "sound-theme";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "5519eaffa7cd018a00e9b1e3a7da1c6e13fbd53b";
    sha256 = "1dc583lq61c361arjl3s44d2k72c46bqvcqv1c3s69f2ndsnxjdz";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
  ];

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  meta = with stdenv.lib; {
    description = "A set of system sounds for elementary";
    homepage = "https://github.com/elementary/sound-theme";
    license = licenses.unlicense;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
