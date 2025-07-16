{ pkgs, ... }: {
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    # Hyprland essentials
    hyprpaper waybar kitty rofi-wayland grim slurp wl-clipboard
    
    # Display and media control
    brightnessctl playerctl pavucontrol
    
    # Additional Hyprland tools
    wl-clipboard wl-clipboard-x11
    xdg-utils xdg-desktop-portal-hyprland
    
    # Screenshot and recording
    obs-studio
    
    # Additional utilities
    polkit_gnome
    gnome.gnome-keyring
  ];

  # Better display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "Hyprland";
        user = "hi";
      };
    };
  };

  # Security and keyring
  security.pam.services.greetd.enableGnomeKeyring = true;
  
  # XDG portal for better app integration
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  
  # Better input handling
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };
  
  # Enable wayland support
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
