{ pkgs, ... }: {
  # Razer Blade specific optimizations
  # AMD CPU + NVIDIA GPU configuration

  # Hardware configuration for Razer Blade
  hardware = {
    # NVIDIA GPU configuration
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # AMD CPU optimizations
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };
  };

  # Power management for laptop
  powerManagement = {
    cpuFreqGovernor = "performance";
    powertop.enable = true;
  };

  # Thermal management
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      # CPU settings
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_MIN_FREQ_ON_AC = "2000000";
      CPU_SCALING_MAX_FREQ_ON_AC = "4000000";
      CPU_SCALING_MIN_FREQ_ON_BAT = "800000";
      CPU_SCALING_MAX_FREQ_ON_BAT = "2000000";

      # GPU settings
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "battery";

      # NVIDIA GPU
      NVIDIA_DYNAMIC_POWER_MANAGEMENT = "0x01";
      NVIDIA_POWER_MANAGEMENT = "1";

      # Battery care
      START_CHARGE_THRESH_BAT0 = "40";
      STOP_CHARGE_THRESH_BAT0 = "80";
      RESTORE_THRESHOLDS_ON_BAT = "1";

      # Thermal management
      CPU_HWP_ON_AC = "performance";
      CPU_HWP_ON_BAT = "power";
      CPU_MIN_PERF_ON_AC = "0";
      CPU_MAX_PERF_ON_AC = "100";
      CPU_MIN_PERF_ON_BAT = "0";
      CPU_MAX_PERF_ON_BAT = "50";
    };
  };

  # Kernel parameters for Razer Blade
  boot.kernelParams = [
    # AMD CPU optimizations
    "amd_pstate=performance"
    "amd_pstate_epp=performance"
    
    # NVIDIA optimizations
    "nvidia-drm.modeset=1"
    "nvidia.NVreg_UsePageAttributeTable=1"
    "nvidia.NVreg_EnablePCIeGen3=1"
    "nvidia.NVreg_InitializeSystemMemoryAllocations=1"
    
    # Power management
    "intel_pstate=performance"
    "processor.max_cstate=1"
    
    # Thermal management
    "thermal.act=0"
    "thermal.nocrt=1"
    
    # Memory management
    "vm.swappiness=10"
    "vm.vfs_cache_pressure=50"
  ];

  # System tuning
  boot.kernel.sysctl = {
    # Network optimizations
    "net.core.rmem_max" = "134217728";
    "net.core.wmem_max" = "134217728";
    "net.ipv4.tcp_rmem" = "4096 87380 134217728";
    "net.ipv4.tcp_wmem" = "4096 65536 134217728";
    
    # File system optimizations
    "vm.dirty_ratio" = "15";
    "vm.dirty_background_ratio" = "5";
    
    # CPU optimizations
    "kernel.sched_autogroup_enabled" = "0";
    "kernel.sched_min_granularity_ns" = "10000000";
    "kernel.sched_wakeup_granularity_ns" = "15000000";
  };

  # Additional packages for Razer Blade
  environment.systemPackages = with pkgs; [
    # Hardware monitoring
    lm_sensors
    hwmon
    radeontop
    nvtop
    
    # Power management tools
    powertop
    tlp
    tlpui
    
    # Thermal monitoring
    psensor
    s-tui
    
    # Razer specific tools
    openrazer
    polychromatic
  ];

  # Enable hardware monitoring
  services.lm_sensors = {
    enable = true;
    configFile = ./sensors.conf;
  };

  # Razer device support
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  # Additional services
  services.udev.extraRules = ''
    # Razer devices
    SUBSYSTEM=="usb", ATTR{idVendor}=="1532", MODE="0666"
    
    # NVIDIA GPU
    SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", MODE="0666"
  '';
} 