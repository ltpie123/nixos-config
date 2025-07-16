{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Core utilities
    git curl wget htop unzip neofetch fastfetch file killall psmisc usbutils pciutils
    
    # File management
    ripgrep fd fzf bat eza du-dust
    
    # System monitoring
    btop iotop nethogs
    
    # Network tools
    nmap mtr traceroute
    
    # Archive tools
    zip unzip p7zip
    
    # Text processing
    jq yq-go
    
    # Development tools
    gcc gdb clang valgrind cmake pkg-config
    
    # Container tools
    docker docker-compose podman
    
    # Cloud tools
    kubectl helm terraform
    
    # Security tools
    openssl gnupg
    
    # Media tools
    ffmpeg imagemagick
    
    # Terminal utilities
    zellij
  ];

  programs.fish.enable = true;
  
  # Printing support
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  
  # Better font configuration
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    iosevka
    iosevka-bin
    iosevka-aile
    iosevka-etoile
  ];
  
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Better locale support
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "en_GB.UTF-8/UTF-8" ];
  
  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = false; # Disable if using pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
