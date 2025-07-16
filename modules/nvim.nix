{ pkgs, ... }: {
  programs.neovim.enable = true;

  environment.systemPackages = with pkgs; [
    # Neovim and core tools
    neovim ripgrep fd gcc tree-sitter
    
    # Language servers and formatters
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
    
    # Git tools
    git
    lazygit
    
    # File search and navigation
    fzf
    bat
    eza
  ];
}
