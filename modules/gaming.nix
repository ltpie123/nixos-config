{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Enhanced graphics support
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Gaming packages
  environment.systemPackages = with pkgs; [
    # Wine and compatibility
    lutris wineWowPackages.stable winetricks protontricks
    
    # Performance monitoring
    mangohud goverlay
    
    # Game launchers
    heroic gamescope
    
    # Additional gaming tools
    gamemode
    gamescope
    vkbasalt
    
    # Emulation
    retroarch
    dolphin-emu
    pcsx2
    rpcs3
  ];
  
  # Performance optimizations (handled by razer-blade.nix)
  # NVIDIA and AMD optimizations are configured in the Razer Blade module
  
  # Enable gamemode
  programs.gamemode.enable = true;
  
  # Better audio for gaming
  hardware.pulseaudio.support32Bit = true;
  
  # Enable FUSE for some games
  programs.fuse.userAllowOther = true;
}
