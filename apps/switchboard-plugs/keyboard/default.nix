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
    rev = "9d9eddeb7da8450a309496c25066f4f78a9d4070";
    sha256 = "04wn9rj11wvl4qxc2mq8sfdy3zkbqvxzr0f22vrbbypgkqszkswa";
  };

  # patches = [
  #   ./0001-Remove-Install-Unlisted-Engines-function.patch
  # ];

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
