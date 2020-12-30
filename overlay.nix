final: prev:

{
  pantheon = prev.pantheon.overrideScope' (pfinal: pprev: {
    elementary-gsettings-schemas = pfinal.callPackage ./desktop/elementary-gsettings-schemas { };

    #### APPS

    appcenter = pfinal.callPackage ./apps/appcenter { };

    elementary-calculator = pfinal.callPackage ./apps/elementary-calculator { };

    elementary-calendar = pfinal.callPackage ./apps/elementary-calendar { };

    elementary-camera = pfinal.callPackage ./apps/elementary-camera { };

    elementary-code = pfinal.callPackage ./apps/elementary-code { };

    elementary-dock = pfinal.callPackage ./apps/elementary-dock { };

    elementary-files = pfinal.callPackage ./apps/elementary-files { };

    elementary-feedback = pfinal.callPackage ./apps/elementary-feedback { };

    elementary-music = pfinal.callPackage ./apps/elementary-music { };

    elementary-photos = pfinal.callPackage ./apps/elementary-photos { };

    elementary-screenshot-tool = pfinal.callPackage ./apps/elementary-screenshot-tool { };

    elementary-terminal = pfinal.callPackage ./apps/elementary-terminal { };

    elementary-videos = pfinal.callPackage ./apps/elementary-videos { };

    sideload = pfinal.callPackage ./apps/sideload { };

    #### DESKTOP

    elementary-default-settings = pfinal.callPackage ./desktop/elementary-default-settings { };

    elementary-greeter = pfinal.callPackage ./desktop/elementary-greeter { };

    elementary-onboarding = pfinal.callPackage ./desktop/elementary-onboarding { };

    elementary-print-shim = pfinal.callPackage ./desktop/elementary-print-shim { };

    elementary-session-settings = pfinal.callPackage ./desktop/elementary-session-settings {
      inherit (prev.gnome3) gnome-session gnome-keyring;
    };

    elementary-shortcut-overlay = pfinal.callPackage ./desktop/elementary-shortcut-overlay { };

    extra-elementary-contracts = pfinal.callPackage ./desktop/extra-elementary-contracts {
      inherit (prev.gnome3) file-roller gnome-bluetooth;
    };

    gala = pfinal.callPackage ./desktop/gala {
      inherit (prev.gnome3) gnome-desktop;
    };

    wingpanel = pfinal.callPackage ./desktop/wingpanel { };

    wingpanel-with-indicators = pfinal.callPackage ./desktop/wingpanel/wrapper.nix {
      indicators = null;
    };

    #### LIBRARIES

    granite = pfinal.callPackage ./granite { };

    #### SERVICES

    contractor = pfinal.callPackage ./services/contractor { };

    elementary-capnet-assist = pfinal.callPackage ./services/elementary-capnet-assist { };

    elementary-dpms-helper = pfinal.callPackage ./services/elementary-dpms-helper { };

    elementary-notifications = pfinal.callPackage ./services/elementary-notifications { };

    # We're using ubuntu and elementary's patchset due to reasons
    # explained here -> https://github.com/elementary/greeter/issues/92#issuecomment-376215614
    # Take note of "I am holding off on "fixing" this bug for as long as possible."
    elementary-settings-daemon = pfinal.callPackage ./services/elementary-settings-daemon {
      inherit (prev.gnome3) gnome-desktop;
    };

    pantheon-agent-geoclue2 = pfinal.callPackage ./services/pantheon-agent-geoclue2 { };

    pantheon-agent-polkit = pfinal.callPackage ./services/pantheon-agent-polkit { };

    pantheon-settings-daemon = pfinal.callPackage ./services/pantheon-settings-daemon { };

    #### WINGPANEL INDICATORS

    wingpanel-applications-menu = pfinal.callPackage ./desktop/wingpanel-indicators/applications-menu { };

    wingpanel-indicator-bluetooth = pfinal.callPackage ./desktop/wingpanel-indicators/bluetooth { };

    wingpanel-indicator-datetime = pfinal.callPackage ./desktop/wingpanel-indicators/datetime { };

    wingpanel-indicator-keyboard = pfinal.callPackage ./desktop/wingpanel-indicators/keyboard { };

    wingpanel-indicator-network = pfinal.callPackage ./desktop/wingpanel-indicators/network { };

    wingpanel-indicator-nightlight = pfinal.callPackage ./desktop/wingpanel-indicators/nightlight { };

    wingpanel-indicator-notifications = pfinal.callPackage ./desktop/wingpanel-indicators/notifications { };

    wingpanel-indicator-power = pfinal.callPackage ./desktop/wingpanel-indicators/power { };

    wingpanel-indicator-session = pfinal.callPackage ./desktop/wingpanel-indicators/session { };

    wingpanel-indicator-sound = pfinal.callPackage ./desktop/wingpanel-indicators/sound { };

    #### SWITCHBOARD

    switchboard = pfinal.callPackage ./apps/switchboard { };

    switchboard-with-plugs = pfinal.callPackage ./apps/switchboard/wrapper.nix {
      plugs = null;
    };

    switchboard-plug-a11y = pfinal.callPackage ./apps/switchboard-plugs/a11y { };

    switchboard-plug-about = pfinal.callPackage ./apps/switchboard-plugs/about { };

    switchboard-plug-applications = pfinal.callPackage ./apps/switchboard-plugs/applications { };

    switchboard-plug-bluetooth = pfinal.callPackage ./apps/switchboard-plugs/bluetooth { };

    switchboard-plug-datetime = pfinal.callPackage ./apps/switchboard-plugs/datetime { };

    switchboard-plug-display = pfinal.callPackage ./apps/switchboard-plugs/display { };

    switchboard-plug-keyboard = pfinal.callPackage ./apps/switchboard-plugs/keyboard { };

    switchboard-plug-mouse-touchpad = pfinal.callPackage ./apps/switchboard-plugs/mouse-touchpad { };

    switchboard-plug-network = pfinal.callPackage ./apps/switchboard-plugs/network { };

    switchboard-plug-notifications = pfinal.callPackage ./apps/switchboard-plugs/notifications { };

    switchboard-plug-onlineaccounts = pfinal.callPackage ./apps/switchboard-plugs/onlineaccounts { };

    switchboard-plug-pantheon-shell = pfinal.callPackage ./apps/switchboard-plugs/pantheon-shell {
      inherit (prev.gnome3) gnome-desktop;
    };

    switchboard-plug-power = pfinal.callPackage ./apps/switchboard-plugs/power { };

    switchboard-plug-printers = pfinal.callPackage ./apps/switchboard-plugs/printers { };

    switchboard-plug-security-privacy = pfinal.callPackage ./apps/switchboard-plugs/security-privacy { };

    switchboard-plug-sharing = pfinal.callPackage ./apps/switchboard-plugs/sharing { };

    switchboard-plug-sound = pfinal.callPackage ./apps/switchboard-plugs/sound { };

    ### ARTWORK

    elementary-gtk-theme = pfinal.callPackage ./artwork/elementary-gtk-theme { };

    elementary-icon-theme = pfinal.callPackage ./artwork/elementary-icon-theme { };

    elementary-redacted-script = pfinal.callPackage ./artwork/elementary-redacted-script { };

    elementary-sound-theme = pfinal.callPackage ./artwork/elementary-sound-theme { };

    elementary-wallpapers = pfinal.callPackage ./artwork/elementary-wallpapers { };

  });
}

