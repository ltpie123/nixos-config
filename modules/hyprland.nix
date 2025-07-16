{ pkgs, ... }: {
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    # Hyprland essentials
    hyprpaper waybar kitty rofi-wayland grim slurp wl-clipboard

    # Display/media control
    brightnessctl playerctl pavucontrol

    # Hyprland tools and utils
    wl-clipboard wl-clipboard-x11
    xdg-utils xdg-desktop-portal-hyprland
    xdg-desktop-portal

    # Screenshot & recording
    obs-studio

    # Notifications and usability
    dunst networkmanagerapplet swww gnome.nautilus gnome.seahorse mako

    # Polkit/keyring
    polkit_gnome gnome.gnome-keyring
  ];

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.hyprland}/bin/Hyprland";
      user = "hi";
    };
  };

  security.pam.services.hyprland.enableGnomeKeyring = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
