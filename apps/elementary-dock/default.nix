{ stdenv
, fetchFromGitHub
, fetchpatch
, vala
, atk
, cairo
, dconf
, glib
, gtk3
, libwnck3
, libX11
, libXfixes
, libXi
, pango
, gettext
, pkgconfig
, libxml2
, bamf
, gdk-pixbuf
, libdbusmenu-gtk3
, gnome-menus
, libgee
, wrapGAppsHook
, pantheon
, meson
, ninja
, granite
}:

stdenv.mkDerivation rec {
  pname = "elementary-dock";
  version = "2020-12-06";

  outputs = [ "out" "dev" ];

  repoName = "dock";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "456795d510af276ef9a6eb07c549c926e2ed9ccd";
    sha256 = "1fj80nliym37j2pg0ndff4inak6vjba2zv7bc4m6l02l7dd40pcm";
  };

  nativeBuildInputs = [
    gettext
    meson
    ninja
    libxml2 # xmllint
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    atk
    bamf
    cairo
    gdk-pixbuf
    glib
    gnome-menus
    dconf
    gtk3
    libX11
    libXfixes
    libXi
    libdbusmenu-gtk3
    libgee
    libwnck3
    pango
    granite
  ];

  meta = with stdenv.lib; {
    description = "Elegant, simple, clean dock";
    homepage = "https://github.com/elementary/dock";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ davidak ] ++ pantheon.maintainers;
  };
}
