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
, elementary-settings-daemon
, glib
, libxml2
}:

stdenv.mkDerivation rec {
  pname = "switchboard-plug-mouse-touchpad";
  version = "2020-12-24";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = "dd64be8c03ed3c3167557530077568aed776a6c1";
    sha256 = "0m0imz3s43kk6m8vsxgrc294iwy7dkqlng421rjn6rhdf4v8848z";
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
    glib
    granite
    gtk3
    libgee
    elementary-settings-daemon
    switchboard
    libxml2
  ];

  meta = with stdenv.lib; {
    description = "Switchboard Mouse & Touchpad Plug";
    homepage = "https://github.com/elementary/switchboard-plug-mouse-touchpad";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
