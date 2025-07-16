# NixOS Configuration for hiNotePro

A comprehensive NixOS configuration with Hyprland, gaming support, and development tools.

## Features

- **Hyprland**: Modern Wayland compositor with tiling window management
- **Zellij**: Modern terminal multiplexer with Sakura theme
- **Iosevka**: Beautiful programming font family
- **Python Development**: Comprehensive Python tooling with uv, hatch, and modern toolchain
- **Gaming**: Steam, Lutris, Wine, and emulation support
- **Development**: Full development environment with multiple languages
- **Doom Emacs**: Pre-configured Emacs distribution with excellent defaults
- **Razer Blade Optimized**: AMD CPU + NVIDIA GPU optimizations, power management, and thermal control
- **Virtualization**: QEMU/KVM with GPU passthrough for Windows VMs
- **Security**: Enhanced security settings and firewall
- **Performance**: Optimized for gaming and development

## Structure

```
nixos-config/
├── flake.nix                 # Main flake configuration
├── hosts/
│   └── hiNotePro.nix        # Host-specific configuration
├── modules/
│   ├── common.nix           # Common system packages and settings
│   ├── hyprland.nix         # Hyprland desktop environment
│   ├── gaming.nix           # Gaming and graphics support
│   ├── nvim.nix            # Neovim and development tools
│   ├── doom-emacs.nix      # Doom Emacs configuration
│   ├── security.nix        # Security and firewall settings
│   └── development.nix     # Development environment
└── home/
    └── default.nix         # Home-manager configuration
```

## Installation

### Option 1: Live Boot Testing (Recommended First Step)

1. **Build the live ISO**:
   ```bash
   nix build .#live-iso
   ```

2. **Create bootable USB**:
   ```bash
   # Find your USB device (replace /dev/sdX with your actual device)
   lsblk
   
   # Write the ISO to USB (WARNING: This will erase the USB drive!)
   sudo dd if=result/iso/nixos-hinote-live-*.iso of=/dev/sdX bs=4M status=progress conv=fdatasync
   ```

3. **Boot from USB**:
   - Restart your computer
   - Boot from the USB drive
   - Login with username: `live`, password: `live`
   - Test your configuration before installing

### Option 2: Direct Installation

1. **Clone the repository**:
   ```bash
   git clone <your-repo-url> /etc/nixos
   cd /etc/nixos
   ```

2. **Generate hardware configuration** (if needed):
   ```bash
   nixos-generate-config --show-hardware-config > hosts/hardware-configuration.nix
   ```

3. **Set passwords** (during first installation):
   ```bash
   # Set user password (optional for personal use)
   sudo passwd hi
   
   # Set root password (optional for personal use)
   sudo passwd root
   ```

4. **Build and switch**:
   ```bash
   sudo nixos-rebuild switch --flake .#hiNotePro
   ```

5. **Set up SSH keys** (after first boot):
   ```bash
   # Create SSH directory
   mkdir -p ~/.ssh
   chmod 700 ~/.ssh
   
   # Copy your private key (from your current system)
   # Option A: Copy from USB/external drive
   cp /path/to/your/private/key ~/.ssh/id_ed25519
   chmod 600 ~/.ssh/id_ed25519
   
   # Option B: Copy from another machine via USB
   # Option C: Use ssh-copy-id from another machine
   ```

## Development

- **Development shell**: `nix develop`
- **Build configuration**: `nix build .#nixosConfigurations.hiNotePro.config.system.build.toplevel`
- **Test configuration**: `nixos-rebuild build --flake .#hiNotePro`
- **Build live ISO**: `nix build .#live-iso`

## Customization

### Adding SSH Keys
Edit `hosts/hiNotePro.nix` and add your SSH public key to the `openssh.authorizedKeys.keys` list.

### Modifying Packages
- System packages: Edit the respective module files
- User packages: Edit `home/default.nix`

### Hyprland Configuration
The Hyprland configuration is in `home/default.nix`. You can customize:
- Keybindings
- Window rules
- Workspace layouts
- Appearance

## Troubleshooting

### Common Issues

1. **Hardware not detected**: Generate hardware configuration
2. **Graphics issues**: Check gaming.nix for proper driver setup
3. **Audio problems**: Verify pipewire configuration in common.nix

### Logs
- System logs: `journalctl -xe`
- Hyprland logs: `journalctl --user -f`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `nixos-rebuild build`
5. Submit a pull request

## License

MIT License - feel free to use and modify as needed.

## Development

- **Development shell**: `