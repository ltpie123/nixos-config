{ pkgs, ... }: {
  # Enable Doom Emacs
  programs.emacs.enable = true;
  
  # Install Doom Emacs
  environment.systemPackages = with pkgs; [
    # Doom Emacs and dependencies
    emacs
    git
    ripgrep
    fd
    gcc
    tree-sitter
    
    # Language servers and formatters (shared with Neovim)
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    rust-analyzer
    gopls
    python3Packages.python-lsp-server
    lua-language-server
    nil # Nix language server
    
    # Formatters
    stylua # Lua
    rustfmt # Rust
    black # Python
    prettier # JavaScript/TypeScript
    shfmt # Shell
    
    # Additional development tools
    gdb
    valgrind
    cmake
    pkg-config
    
    # File search and navigation
    fzf
    bat
    eza
    
    # Emacs-specific tools
    emacsPackages.org
    emacsPackages.magit
    emacsPackages.doom-modeline
    emacsPackages.all-the-icons
  ];

  # Set up Doom Emacs installation
  system.activationScripts.doomEmacs = ''
    # Install Doom Emacs if not already installed
    if [ ! -d "$HOME/.emacs.d" ]; then
      echo "Installing Doom Emacs..."
      git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
      ~/.emacs.d/bin/doom install --yes
    fi
  '';

  # Add Doom Emacs to PATH
  environment.variables = {
    DOOMDIR = "$HOME/.doom.d";
  };
} 