{ stdenv
, fetchFromGitHub
, nix-update-script
, pantheon
, pkgconfig
, meson
, ninja
, vala
, desktop-file-utils
, python3
, gettext
, libxml2
, gtk3
, granite
, libgee
, gst_all_1
, libcanberra
, clutter-gtk
, clutter-gst
, elementary-icon-theme
, appstream
, wrapGAppsHook
, libhandy
}:

stdenv.mkDerivation rec {
  pname = "elementary-camera";
  version = "2020-12-19";

  repoName = "camera";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = repoName;
    rev = "1af394264b2ce086a58b3f90706a62803cd22de8";
    sha256 = "00ks8w80c1fwmjwfv6h21xcjvcvibjyyh0h68yss786xz1bmnwls";
  };

  passthru = {
    updateScript = nix-update-script {
      attrPath = "pantheon.${pname}";
    };
  };

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    gettext
    libxml2
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter-gst
    clutter-gtk
    elementary-icon-theme
    granite
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gstreamer
    gtk3
    libcanberra
    libgee
    libhandy
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Camera app designed for elementary OS";
    homepage = "https://github.com/elementary/camera";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = pantheon.maintainers;
  };
}
