{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, pkgconfig
, meson
, ninja
, vala
, glib
, gtk3
, libgee
, desktop-file-utils
, geoclue2
, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  pname = "pantheon-agent-geoclue2";
  version = "2020-12-19";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "0438229e7f2160357aaa67678841e01623f1af0a";
    sha256 = "1ixhc5nqp1j5is2k6w05nffzj68c9as35hnjvvxh05z1aaxdd9sv";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    desktop-file-utils
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
   ];

  buildInputs = [
    geoclue2
    gtk3
    libgee
   ];

  # This should be provided by a post_install.py script - See -> https://github.com/elementary/pantheon-agent-geoclue2/pull/21
  postInstall = ''
    ${glib.dev}/bin/glib-compile-schemas $out/share/glib-2.0/schemas
  '';

  meta = with stdenv.lib; {
    description = "Pantheon Geoclue2 Agent";
    homepage = "https://github.com/elementary/pantheon-agent-geoclue2";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
