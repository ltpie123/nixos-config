{ pkgs, ... }: {
  # Virtualization support for Windows VMs
  # QEMU/KVM with GPU passthrough capabilities

  # Enable virtualization
  virtualisation = {
    # QEMU/KVM
    qemu = {
      enable = true;
      package = pkgs.qemu_kvm;
    };
    
    # Libvirt for VM management
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      extraConfig = ''
        unix_sock_group = "libvirt"
        unix_sock_rw_perms = "0770"
      '';
    };
    
    # Docker support
    docker = {
      enable = true;
      autoPrune.enable = true;
      autoPrune.dates = "weekly";
    };
    
    # Podman support
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    
    # LXD container support
    lxd = {
      enable = true;
      recommended = true;
    };
  };

  # GPU passthrough support
  boot.kernelParams = [
    # IOMMU support for GPU passthrough
    "intel_iommu=on"
    "iommu=pt"
    "vfio-pci.ids=10de:1f08,10de:10f9"  # Common NVIDIA GPU IDs (adjust for your GPU)
    
    # Disable GPU drivers for passthrough
    "nvidia-drm.modeset=0"
    "nvidia.NVreg_UsePageAttributeTable=0"
    
    # Memory management for VMs
    "hugepagesz=1G"
    "hugepages=8"
    "default_hugepagesz=1G"
  ];

  # Additional kernel modules for virtualization
  boot.kernelModules = [
    "kvm"
    "kvm_intel"
    "vfio"
    "vfio_iommu_type1"
    "vfio_pci"
    "vfio_virqfd"
  ];

  # System packages for virtualization
  environment.systemPackages = with pkgs; [
    # VM management
    virt-manager
    virt-viewer
    virtiofsd
    
    # QEMU tools
    qemu
    qemu_kvm
    qemu-utils
    
    # GPU passthrough tools
    pciutils
    usbutils
    
    # VM optimization tools
    spice
    spice-gtk
    spice-protocol
    
    # Windows VM tools
    win-virtio
    win-spice
    
    # Additional virtualization tools
    libguestfs
    guestfs-tools
    virtio-win
  ];

  # User groups for virtualization
  users.groups.libvirt.members = [ "hi" ];
  users.groups.kvm.members = [ "hi" ];

  # Services for virtualization
  services = {
    # SPICE USB redirection
    spice-vdagentd.enable = true;
    
    # QEMU guest agent
    qemuGuest.enable = true;
    
    # USB device management
    udev.extraRules = ''
      # USB passthrough for VMs
      SUBSYSTEM=="usb", ATTR{idVendor}=="1532", MODE="0666", GROUP="libvirt"
      SUBSYSTEM=="usb", ATTR{idVendor}=="046d", MODE="0666", GROUP="libvirt"
      SUBSYSTEM=="usb", ATTR{idVendor}=="045e", MODE="0666", GROUP="libvirt"
      
      # GPU passthrough
      SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", MODE="0666", GROUP="libvirt"
      SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{class}=="0x030000", MODE="0666", GROUP="libvirt"
    '';
  };

  # Network configuration for VMs
  networking = {
    # Bridge networking for VMs
    bridges = {
      br0 = {
        interfaces = [ "enp0s31f6" ];  # Adjust to your network interface
      };
    };
    
    # DHCP for VM network
    dhcpcd.extraConfig = ''
      interface br0
      static ip_address=192.168.1.2/24
      static routers=192.168.1.1
      static domain_name_servers=8.8.8.8 8.8.4.4
    '';
  };

  # File system support for VMs
  fileSystems."/var/lib/libvirt" = {
    device = "/dev/disk/by-uuid/YOUR-UUID";  # Adjust to your storage
    fsType = "ext4";
    options = [ "defaults" "noatime" ];
  };

  # Windows VM optimization scripts
  environment.etc."libvirt/qemu/windows-vm.xml".text = ''
    <domain type='kvm'>
      <name>windows-vm</name>
      <memory unit='GiB'>16</memory>
      <vcpu>8</vcpu>
      <os>
        <type arch='x86_64' machine='pc-q35-6.2'>hvm</type>
        <boot dev='hd'/>
        <boot dev='cdrom'/>
      </os>
      <features>
        <acpi/>
        <apic/>
        <hyperv>
          <relaxed state='on'/>
          <vapic state='on'/>
          <spinlocks state='on' retries='8191'/>
          <vendor_id state='on' value='1234567890ab'/>
        </hyperv>
        <vmx state='on'/>
      </features>
      <cpu mode='host-passthrough' check='none' migratable='on'>
        <topology sockets='1' dies='1' cores='4' threads='2'/>
      </cpu>
      <devices>
        <disk type='file' device='disk'>
          <driver name='qemu' type='qcow2' cache='writeback'/>
          <source file='/var/lib/libvirt/images/windows.qcow2'/>
          <target dev='vda' bus='virtio'/>
        </disk>
        <disk type='file' device='cdrom'>
          <driver name='qemu' type='raw'/>
          <source file='/var/lib/libvirt/images/windows.iso'/>
          <target dev='sda' bus='sata'/>
          <readonly/>
        </disk>
        <interface type='bridge'>
          <source bridge='br0'/>
          <model type='virtio'/>
        </interface>
        <input type='tablet' bus='usb'/>
        <input type='keyboard' bus='usb'/>
        <graphics type='spice' port='5900' autoport='yes' listen='0.0.0.0'>
          <listen type='address' address='0.0.0.0'/>
        </graphics>
        <video>
          <model type='qxl' ram='65536' vram='65536' vgamem='16384' heads='1' primary='yes'/>
        </video>
        <memballoon model='virtio'/>
        <rng model='virtio'>
          <backend model='random'>/dev/urandom</backend>
        </rng>
      </devices>
    </domain>
  '';

  # Performance tuning for VMs
  boot.kernel.sysctl = {
    # VM performance
    "vm.swappiness" = "1";
    "vm.dirty_ratio" = "15";
    "vm.dirty_background_ratio" = "5";
    "vm.overcommit_memory" = "1";
    
    # Network performance for VMs
    "net.core.rmem_max" = "134217728";
    "net.core.wmem_max" = "134217728";
    "net.ipv4.tcp_rmem" = "4096 87380 134217728";
    "net.ipv4.tcp_wmem" = "4096 65536 134217728";
  };
} 