{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, meson
, ninja
, nixos-artwork
, glib
, pkgconfig
, dbus
, polkit
, accountsservice
, python3
, fetchpatch
}:

stdenv.mkDerivation rec {
  pname = "elementary-default-settings";
  version = "2020-12-23";

  repoName = "default-settings";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "ff9a432dada00bfeadcb3c423e6cfbfd1c90f978";
    sha256 = "1qdz5q8xm2cmf96ihq5sv4qij419mrnp7bcdcix4hfqi8skkj3mc";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    accountsservice
    dbus
    glib # polkit requires
    meson
    ninja
    pkgconfig
    polkit
    python3
  ];

  mesonFlags = [
    "--sysconfdir=${placeholder "out"}/etc"
    "-Ddefault-wallpaper=${nixos-artwork.wallpapers.simple-dark-gray.gnomeFilePath}"
    "-Dplank-dockitems=false"
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  preInstall = ''
    # Install our override for plank dockitems.
    # This is because we don't have Pantheon's mail or Appcenter.
    # See: https://github.com/NixOS/nixpkgs/issues/58161
    schema_dir=$out/share/glib-2.0/schemas
    install -D ${./overrides/plank-dockitems.gschema.override} $schema_dir/plank-dockitems.gschema.override

    # Our launchers that use paths at /run/current-system/sw/bin
    mkdir -p $out/etc/skel/.config/plank/dock1
    cp -avr ${./launchers} $out/etc/skel/.config/plank/dock1/launchers

    # Whitelist wingpanel indicators to be used in the greeter
    # hhttps://github.com/elementary/greeter/blob/fc19752f147c62767cd2097c0c0c0fcce41e5873/debian/io.elementary.greeter.whitelist
    # wingpanel 2.3.2 renamed this to .allowed to .forbidden
    # https://github.com/elementary/wingpanel/pull/326
    install -D ${./io.elementary.greeter.allowed} $out/etc/wingpanel.d/io.elementary.greeter.allowed
  '';

  postFixup = ''
    # https://github.com/elementary/default-settings/issues/55
    rm -rf $out/share/plymouth
    rm -rf $out/share/cups

    rm -rf $out/share/applications
  '';

  meta = with stdenv.lib; {
    description = "Default settings and configuration files for elementary";
    homepage = "https://github.com/elementary/default-settings";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
