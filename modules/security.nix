{ pkgs, ... }: {
  # Firewall configuration (relaxed for personal use)
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 8080 3000 5000 8000 9000 ]; # More dev ports
    allowedUDPPorts = [ 53 67 68 ];
    # Allow all outgoing traffic
    allowedUDPPortRanges = [ { from = 1024; to = 65535; } ];
  };

  # Security settings (relaxed for personal use)
  security = {
    # AppArmor (disabled for personal use - can be annoying)
    apparmor.enable = false;
    
    # Audit (disabled for personal use - can be noisy)
    auditd.enable = false;
    
    # Better sudo configuration (relaxed for personal use)
    sudo.wheelNeedsPassword = false;
    
    # Protect against common attacks
    protectKernelImage = true; # Enabled for better security
  };

  # System hardening
  boot.kernel.sysctl = {
    # Network security
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    
    # Memory protection
    "vm.mmap_min_addr" = 65536;
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
  };
} 