{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, meson
, ninja
, gettext
}:

stdenv.mkDerivation rec {
  pname = "elementary-wallpapers";
  version = "2020-10-26";

  repoName = "wallpapers";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "7656a8cf14326bbe29a7b6cd206514093bedbaba";
    sha256 = "0mjz6nycw2x2zz9wabnsnp7aip1pakc82f3w6hla0fhxqw9qgxqg";
  };

  nativeBuildInputs = [
    gettext
    meson
    ninja
  ];

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  meta = with stdenv.lib; {
    description = "Collection of wallpapers for elementary";
    homepage = "https://github.com/elementary/wallpapers";
    license = licenses.publicDomain;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}

