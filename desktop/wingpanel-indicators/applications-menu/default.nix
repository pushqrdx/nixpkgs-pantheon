{ stdenv
, fetchFromGitHub
, fetchpatch
, nix-update-script
, pantheon
, substituteAll
, meson
, ninja
, python3
, pkgconfig
, vala
, granite
, libgee
, gettext
, gtk3
, appstream
, gnome-menus
, json-glib
, elementary-dock
, bamf
, switchboard-with-plugs
, libunity
, libsoup
, wingpanel
, zeitgeist
, bc
, libhandy
}:

stdenv.mkDerivation rec {
  pname = "wingpanel-applications-menu";
  version = "2020-12-19";

  repoName = "applications-menu";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "59b3b6dc94d35a6dae1e453d58996fdf9ace9334";
    sha256 = "1jm34njiidpwv09fprlq4zwpvp3bdbcn1hrfvzxxzcm5qq0sh7hm";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    appstream
    gettext
    meson
    ninja
    pkgconfig
    python3
    vala
  ];

  buildInputs = [
    bamf
    elementary-dock
    gnome-menus
    granite
    gtk3
    json-glib
    libgee
    libhandy
    libsoup
    libunity
    switchboard-with-plugs
    pantheon.wingpanel
    zeitgeist
  ] ++
  # applications-menu has a plugin to search switchboard plugins
  # see https://github.com/NixOS/nixpkgs/issues/100209
  # wingpanel's wrapper will need to pick up the fact that
  # applications-menu needs a version of switchboard with all
  # its plugins for search.
  switchboard-with-plugs.buildInputs;

  mesonFlags = [
    "--sysconfdir=${placeholder "out"}/etc"
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Lightweight and stylish app launcher for Pantheon";
    homepage = "https://github.com/elementary/applications-menu";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
