{
  description = "NixOS config for hiNotePro";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # Additional useful inputs
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    
    # For better development experience
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    
    # For secrets management (optional)
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, nixos-generators, devshell, agenix, ... }: {
    nixosConfigurations.hiNotePro = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/hiNotePro.nix
        ./modules/common.nix
        ./modules/hyprland.nix
        ./modules/gaming.nix
        ./modules/nvim.nix
        ./modules/doom-emacs.nix
        ./modules/security.nix
        ./modules/development.nix
        ./modules/razer-blade.nix
        ./modules/virtualization.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          home-manager.users.hi = import ./home/default.nix;
        }
      ];
    };

    # Live ISO configuration for testing
    nixosConfigurations.liveIso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-generators.nixosModules.all-formats
        ./modules/common.nix
        ./modules/hyprland.nix
        ./modules/gaming.nix
        ./modules/nvim.nix
        ./modules/doom-emacs.nix
        ./modules/development.nix
        ./modules/razer-blade.nix
        ./modules/virtualization.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          home-manager.users.hi = import ./home/default.nix;
        }
        {
          # Live ISO specific settings
          isoImage.isoBaseName = "nixos-hinote-live";
          isoImage.volumeID = "NIXOS_HINOTE_LIVE";
          
          # Enable live user
          users.users.live = {
            isNormalUser = true;
            extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
            password = "live";  # Simple password for live boot
          };
          
          # Auto-login for live user
          services.getty.autologinUser = "live";
          
          # Disable some services for live boot
          services.openssh.enable = false;
          services.fwupd.enable = false;
          
          # Enable networking
          networking.networkmanager.enable = true;
          networking.wireless.enable = true;
        }
      ];
    };
    
    # Add development shell
    devShells.x86_64-linux.default = devshell.legacyPackages.x86_64-linux.mkShell {
      name = "nixos-config";
      packages = with nixpkgs.legacyPackages.x86_64-linux; [
        nixos-generators
        agenix.packages.x86_64-linux.default
      ];
    };

    # Build targets for easy access
    packages.x86_64-linux = {
      # Live ISO
      live-iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          nixos-generators.nixosModules.iso
          ./modules/common.nix
          ./modules/hyprland.nix
          ./modules/gaming.nix
          ./modules/nvim.nix
          ./modules/doom-emacs.nix
          ./modules/development.nix
          ./modules/razer-blade.nix
          ./modules/virtualization.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.hi = import ./home/default.nix;
          }
          {
            # Live ISO specific settings
            isoImage.isoBaseName = "nixos-hinote-live";
            isoImage.volumeID = "NIXOS_HINOTE_LIVE";
            
            # Enable live user
            users.users.live = {
              isNormalUser = true;
              extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
              password = "live";
            };
            
            # Auto-login for live user
            services.getty.autologinUser = "live";
            
            # Disable some services for live boot
            services.openssh.enable = false;
            services.fwupd.enable = false;
            
            # Enable networking
            networking.networkmanager.enable = true;
            networking.wireless.enable = true;
          }
        ];
        format = "iso";
      };
    };
  };
}
