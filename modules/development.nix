{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Core development tools
    git gcc gdb clang valgrind cmake pkg-config
    
    # Language runtimes
    python3 python311 python312 python313 nodejs_20 rustup go gcc
    
    # Package managers
    cargo yarn npm pipenv poetry uv hatch pnpm
    
    # Development utilities
    direnv nix-direnv
    
    # Database tools
    postgresql sqlite
    
    # Cloud and container tools
    docker docker-compose podman kubectl helm terraform
    
    # Monitoring and debugging
    strace ltrace htop btop
    
    # Code quality tools
    shellcheck hadolint
    
    # Python development tools
    python3Packages.pip
    python3Packages.setuptools
    python3Packages.wheel
    python3Packages.virtualenv
    python3Packages.pytest
    python3Packages.black
    python3Packages.flake8
    python3Packages.mypy
    python3Packages.isort
    python3Packages.pylint
    python3Packages.poetry
    python3Packages.pipenv
    python3Packages.jupyter
    python3Packages.ipython
    python3Packages.notebook
    python3Packages.matplotlib
    python3Packages.numpy
    python3Packages.pandas
    python3Packages.scipy
    python3Packages.scikit-learn
    python3Packages.requests
    python3Packages.flask
    python3Packages.django
    python3Packages.fastapi
    python3Packages.uvicorn
    python3Packages.sqlalchemy
    python3Packages.alembic
    python3Packages.pytest-cov
    python3Packages.pytest-asyncio
    python3Packages.pytest-mock
    python3Packages.pre-commit
    python3Packages.safety
    python3Packages.bandit
    
    # Additional languages
    deno elixir ruby
    
    # Additional development tools
    just # Task runner
    yazi # Terminal file manager
    zoxide # Smart cd
    atuin # Shell history
    chezmoi # Dotfile manager
    
    # Additional Python tools
    python3Packages.yt-dlp
    python3Packages.psutil
    python3Packages.rich
    python3Packages.click
    python3Packages.typer
    
    # Additional Node.js tools
    nodePackages.typescript
    nodePackages.pnpm
    
    # Additional Rust tools
    rust-analyzer
    
    # Additional Go tools
    gopls
    

    
    # Additional Ruby tools
    rubyPackages.bundler
    rubyPackages.jekyll
    
    # Additional development utilities
    tree-sitter
    ripgrep-all
    
    # Additional debugging tools
    gdb-common
    
    # Additional build tools
    ninja
    meson
    
    # Additional documentation tools
    pandoc
    texlive.combined.scheme-medium
  ];

  # Enable direnv
  programs.direnv.enable = true;
  
  # Development services
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
  };
  
  # Better shell integration
  programs.bash.enableCompletion = true;
  programs.zsh.enableCompletion = true;
  
  # Zellij configuration
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
} 