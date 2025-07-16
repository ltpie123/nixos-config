{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "hiNotePro";
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  # Better user configuration
  users.users.hi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "video" "audio" "input" ];
    shell = pkgs.fish;
    # Set a password for the user (you'll be prompted during installation)
    hashedPassword = null; # Will be set during installation
    openssh.authorizedKeys.keys = [
      # Add your SSH public key here for remote access
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINRrsIvvZjshnQLLHcSRGkzVWQAVaoVo+eAg6cN8xFwj ltpie12345+github@gmail.com
    ];
  };

  # Root password configuration
  users.users.root = {
    hashedPassword = null; # Will be set during installation
  };

  # Enhanced Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    trusted-users = [ "root" "hi" ];
  };
  nixpkgs.config.allowUnfree = true;

  # Security improvements (relaxed for personal use)
  security.sudo.wheelNeedsPassword = false; # No password for sudo (personal machine)
  security.rtkit.enable = true;
  
  # Better system services (relaxed for personal use)
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true; # Allow password auth for convenience
      PubkeyAuthentication = true;
      # Relaxed security settings for personal use
      X11Forwarding = true; # Allow X11 forwarding
      AllowTcpForwarding = true; # Allow port forwarding
      AllowAgentForwarding = true; # Allow SSH agent forwarding
      PermitEmptyPasswords = false;
      MaxAuthTries = 6; # More attempts allowed
      ClientAliveInterval = 600; # Longer timeout
      ClientAliveCountMax = 3;
    };
  };
  
  networking.networkmanager.enable = true;
  
  # Performance and system improvements
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_max" = 134217728;
    };
  };
  
  # Power management
  powerManagement.cpuFreqGovernor = "performance";
  
  # System version
  system.stateVersion = "24.05";
}
