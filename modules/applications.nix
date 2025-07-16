{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Web browsers
    firefox
    brave
    
    # Communication
    discord
    zoom
    
    # Productivity
    libreoffice
    drawio-desktop
    
    # Graphics and design
    gimp
    inkscape
    krita
    
    # System utilities
    gparted
    baobab # Disk usage analyzer
    gnome-system-monitor
    
    # Additional terminal tools
    kitty
    alacritty
    
    # Additional file managers
    nautilus
    pcmanfm
    
    # Additional system tools
    gnome-disk-utility
    gnome-calculator
    
    # Additional network tools
    networkmanager-openvpn
    openvpn
    
    # Additional security tools
    pass # Password manager
    keepassxc
    _1password-gui # 1Password desktop app
    _1password # 1Password CLI
    
    # Additional utilities
    peaclock # Clock
    waybar # Status bar
    wlogout # Logout menu
    wofi # Application launcher
    rofi-wayland
    
    # Additional system monitoring
    swww # Wallpaper daemon
    swaync # Notification center
    
    # Additional development tools
    github-cli
    
    # Additional media tools
    obs-studio
    
    # Additional system tools
    supergfxctl # Graphics switching
    
    # Additional utilities
    wallust # Wallpaper generator
    hyprcursor # Cursor themes
    hypridle # Idle daemon
    hyprlock # Lock screen
    
    # Additional development tools
    lazydocker
    lazygit
    
    # Additional system tools
    polychromatic # Razer RGB control
    
    # Additional utilities
    pfetch # System info
    neofetch
    fastfetch
    
    # Additional development tools
    ollama # Local AI models
    
    # Additional system tools
    proton-vpn-gtk-app
    protonup-qt
    
    # Additional utilities
    wordle-cli-bin
    lichess # Chess
    
    # Additional development tools
    zettlr # Note taking
    
    # Additional system tools
    remmina # Remote desktop
    
    # Additional utilities
    nicotine-plus # Soulseek client
    
    # Additional development tools
    balena-etcher # USB burner
    
    # Additional system tools
    popsicle-git # USB burner
    
    # Additional utilities
    oneko # Cat follows cursor
    
    # Additional development tools
    rig # Random identity generator
    
    # Additional system tools
    termtrack # Terminal tracking
    
    # Additional utilities
    typespeed # Typing test
    
    # Additional development tools
    yeet # Package manager
    
    # Additional system tools
    nwg-look # GTK theme switcher
    
    # Additional utilities
    icat # Image viewer for terminal
    
    # Additional development tools
    bonsai-sh-git # Bonsai tree generator
    
    # Additional system tools
    pipes-sh # Pipe screensaver
    
    # Additional utilities
    sl # Steam locomotive
    
    # Additional development tools
    termtrack # Terminal tracking
  ];

  # Enable additional services
  services.flatpak.enable = true;
  
  # Enable additional programs
  programs = {
    # Enable additional shells
    zsh.enable = true;
    bash.enableCompletion = true;
    zsh.enableCompletion = true;
    
    # Enable additional utilities
    dconf.enable = true;
    seahorse.enable = true; # Password and keys
  };
  
  # Additional fonts
  fonts.packages = with pkgs; [
    # Additional programming fonts
    fira-code
    jetbrains-mono
    jetbrains-mono-nerd
    inconsolata
    liberation_ttf
    dejavu_fonts
    ubuntu_font_family
    
    # Additional symbol fonts
    font-awesome
    nerd-font-patcher
    
    # Additional system fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
  ];
} 