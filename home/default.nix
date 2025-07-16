{ pkgs, ... }: {
  home.username = "hi";
  home.homeDirectory = "/home/hi";

  home.stateVersion = "24.05";

  # Font configuration
  fonts.fontconfig.enable = true;

  programs.fish = {
    enable = true;
    shellInit = ''
      set -g theme_nerd_fonts yes
      set -g fish_greeting "hey hi hello"
      
      # Set default font
      set -g fish_term24bit 1
      
      # Run pokemon on startup
      pokemon-colorscripts --random
    '';
    interactiveShellInit = ''
      alias gs="git status"
      alias gc="git commit"
      alias ga="git add"
      alias lg="lazygit"
      
      # Zellij aliases
      alias zj="zellij"
      alias zja="zellij attach"
      alias zjl="zellij list-sessions"
      alias zjk="zellij kill-session"
      
      # Python aliases
      alias py="python3"
      alias pip="pip3"
      alias venv="python3 -m venv"
      alias activate="source venv/bin/activate"
      alias pytest="python3 -m pytest"
      alias black="python3 -m black"
      alias flake8="python3 -m flake8"
      alias mypy="python3 -m mypy"
      alias isort="python3 -m isort"
      alias jupyter="python3 -m jupyter"
      alias ipython="python3 -m IPython"
      
      # Virtualization aliases
      alias vm="virt-manager"
      alias vlist="virsh list --all"
      alias vstart="virsh start"
      alias vstop="virsh shutdown"
      alias vdestroy="virsh destroy"
      alias vedit="virsh edit"
      alias vinfo="virsh dominfo"
      alias vconsole="virsh console"
    '';
  };

  programs.git = {
    enable = true;
    userName = "hi";
    userEmail = "hi@hinote.pro";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
    };
  };

  home.file.".config/nvim/init.lua".text = "-- put your Neovim config here";

  # Doom Emacs configuration
  home.file.".doom.d/init.el".text = ''
    ;; Doom Emacs configuration
    (doom! :input
          ;;chinese
          ;;japanese
          ;;layout            ; auie,ctsrnm is the superior home row

          :completion
          (company +childframe)     ; the ultimate code completion backend
          ;;helm              ; the *other* search engine for love and life
          ;;ido               ; the other *other* search engine...
          (ivy +fuzzy +prescient +icons) ; a search engine for love and life
          ;;vertico           ; the search engine of the future

          :ui
          ;;deft              ; notational velocity for Emacs
          doom              ; what makes DOOM look the way it does
          doom-dashboard    ; a nifty splash screen for Emacs
          doom-quit         ; DOOM quit-message prompts when you quit Emacs
          ;;fill-column       ; a `fill-column' indicator
          hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/XXX
          ;;hydra
          ;;indent-guides     ; highlighted indent columns
          ;;ligatures         ; ligatures and symbols to make your code pretty again
          ;;minimap           ; show a map of the code on the side
          modeline          ; snazzy, Atom-inspired modeline, plus API
          ;;nav-flash         ; blink cursor line after big motions
          ;;neotree           ; a project drawer, like NERDTree for vim
          ophints           ; highlight the region an operation acts on
          (popup +defaults)   ; tame sudden yet inevitable temporary windows
          ;;tabs              ; a tab bar for Emacs
          ;;treemacs          ; a project drawer, like neotree but cooler
          ;;unicode           ; extended unicode support for various languages
          vc-gutter         ; vcs diff in the fringe
          vi-tilde-fringe   ; fringe tildes to mark beyond EOB
          ;;window-select     ; visually switch windows
          workspaces        ; tab emulation, persistence & separate workspaces
          ;;zen               ; distraction-free coding or writing

          :editor
          (evil +everywhere); come to the dark side, we have cookies
          file-templates    ; auto-snippets for empty files
          fold              ; (nigh) universal code folding
          (format +onsave)  ; automated prettiness
          ;;god               ; run Emacs commands without modifier keys
          ;;lispy             ; vim for lisp, for people who don't like vim
          ;;multiple-cursors  ; editing in many places at once
          ;;objed             ; text object editing for the innocent
          ;;parinfer          ; turn lisp into python, sort of
          ;;rotate-text       ; cycle region at point between text candidates
          snippets          ; my elves. They type so I don't have to
          ;;word-wrap         ; soft wrapping with language-aware indent

          :emacs
          (dired +icons)             ; making dired pretty [functional]
          electric          ; smarter, keyword-based electric-indent
          ;;ibuffer         ; interactive buffer management
          (undo +tree)     ; persistent, smarter undo for your inevitable mistakes
          vc                ; version-control and Emacs, sitting in a tree

          :term
          ;;eshell            ; the elisp shell that works everywhere
          ;;shell             ; simple shell REPL for Emacs
          ;;term              ; basic terminal emulator for Emacs
          vterm             ; the best terminal emulation in Emacs

          :checkers
          (syntax +childframe)                ; tasing you for every semicolon you forget
          (spell +flyspell) ; tasing you for misspelling mispelling
          ;;grammar           ; tasing grammar mistake every you make

          :tools
          ;;ansible
          ;;biblio            ; Writes a PhD for you (citation needed)
          (debugger +lsp)     ; FIXME stepping through code, to help you add bugs
          ;;direnv
          (docker +lsp)
          ;;editorconfig      ; let someone else argue about tabs vs spaces
          ;;ein               ; tame Jupyter notebooks with emacs
          (eval +overlay)     ; run code, run (also, repls)
          ;;gist              ; interacting with github gists
          (lookup +dictionary +offline)              ; navigate your code and its documentation
          (lsp +peek)               ; M-x vscode
          (magit +forge)             ; a git porcelain for Emacs
          ;;make              ; run make tasks from Emacs
          ;;pass              ; password manager for nerds
          ;;pdf               ; pdf enhancements
          ;;prodigy           ; FIXME managing external services & code builders
          ;;rgb               ; emacs for rednecks, programming language
          ;;taskrunner        ; taskrunner for all your projects
          ;;terraform         ; infrastructure as code
          ;;tmux              ; an API for interacting with tmux
          ;;upload            ; map local to remote projects via ssh/ftp

          :os
          (:if IS-MAC macos)  ; improve compatibility with macOS
          ;;tty               ; improve the terminal Emacs experience

          :lang
          ;;agda              ; types of types of types of types...
          ;;beancount         ; mind the GAAP
          (cc +lsp)                ; C > C++ == 1
          ;;clojure           ; java with a lisp
          ;;common-lisp       ; if you've seen one lisp, you've seen them all
          ;;coq               ; proofs-as-programs
          ;;crystal           ; ruby at the speed of c
          ;;csharp            ; unity, .NET, and mono shenanigans
          ;;data              ; config/data formats
          ;;(dart +flutter)   ; paint ui and not anything else
          ;;dhall
          ;;elixir            ; erlang done right
          ;;elm               ; care for a cup of TEA?
          emacs-lisp        ; drown in parentheses
          ;;erlang            ; an elegant language for a more civilized age
          ;;ess               ; emacs speaks statistics
          ;;factor
          ;;faust             ; dsp, but you get to keep your soul
          ;;fortran           ; in FORTRAN, GOD is REAL (unless declared INTEGER)
          ;;fsharp           ; ML stands for Microsoft's Language
          ;;fstar             ; (dependent) types and (monadic) effects and Z3
          ;;gdscript          ; the language you waited for
          ;;(go +lsp)         ; the hipster dialect
          ;;(haskell +lsp)    ; a language that's lazier than I am
          ;;hy                ; readability of scheme w/ speed of python
          ;;idris             ; a language you can depend on
          ;;json              ; At least it ain't XML
          ;;(java +lsp)       ; the poster child for carpal tunnel syndrome
          ;;javascript        ; all(hope(abandon(ye(who(enter(here))))))
          ;;julia             ; a better, faster MATLAB
          ;;kotlin            ; a better, slicker Java(Script)
          ;;latex             ; writing papers in Emacs has never been so fun
          ;;lean              ; for folks with too much to prove
          ;;factor            ; for folks with too much to prove
          ;;ledger            ; an accounting system written in lisp
          ;;lua               ; one-based indices? one-based indices
          (markdown +grip)          ; it'll shock you how much I didn't do
          ;;nim               ; python + lisp at the speed of c
          ;;nix               ; I hereby declare "nix geht mehr!"
          ;;ocaml             ; an objective camel
          (org +pretty +gnuplot +pandoc +pomodoro +present)               ; organize your plain life in plain text
          ;;php               ; perl's insecure younger brother
          ;;plantuml          ; diagrams for confusing people more
          ;;purescript        ; javascript, but functional
          (python +lsp +pyright)            ; beautiful is better than ugly
          ;;qt                ; the 'cutest' gui framework ever
          ;;racket            ; a DSL for DSLs
          ;;raku              ; the artist formerly known as perl6
          ;;rest              ; Emacs a la web
          ;;rst               ; ReST in peace
          ;;(ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
          ;;rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
          ;;scala             ; java, but good
          ;;(scheme +guile)   ; a lisp native to gnu
          ;;sh                ; she sells {ba,z,fi}sh shells on the C xor
          ;;sml
          ;;solidity          ; do you need a blockchain? No.
          ;;swift             ; who asked for emoji variables?
          ;;terra             ; Earth and Moon in alignment for performance.
          ;;web               ; the tubes
          ;;yaml              ; JSON, but readable
          ;;zig               ; C, but simpler

          :email
          ;;(mu4e +gmail)
          ;;notmuch
          ;;(wanderlust +gmail)

          :app
          ;;calendar
          ;;emms
          ;;everywhere        ; *leave* Emacs!? You must be joking
          ;;irc               ; how neckbeards socialize
          ;;(rss +org)        ; emacs as an RSS reader
          ;;twitter           ; twitter client https://twitter.com/vnought

          :config
          ;;literate
          (default +bindings +smartparens))
  '';

  home.file.".doom.d/config.el".text = ''
    ;; Doom Emacs user configuration
    ;; Place your private configuration here! Remember, you do not need to run 'doom
    ;; sync' after modifying this file!

    ;; Some functionality uses this to identify you, e.g. GPG configuration, email
    ;; clients, file templates and snippets.
    (setq user-full-name "hi"
          user-mail-address "hi@hinote.pro")

    ;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
    ;; are the three important ones:
    ;;
    ;; +doom-font
    ;; +doom-variable-pitch-font
    ;; +doom-big-font -- used for `doom-big-font-mode'; use this for
    ;; presentations or streaming.
    ;;
    ;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
    ;; font string. You generally only need these two:
    (setq doom-font (font-spec :family "Iosevka" :size 14 :weight 'normal)
          doom-variable-pitch-font (font-spec :family "Noto Sans" :size 14)
          doom-big-font (font-spec :family "Iosevka" :size 18))

    ;; There are two ways to load a theme. You can either set `doom-theme' or manually
    ;; load a theme with the `load-theme' function. This is the default:
    (setq doom-theme 'doom-sakura)

    ;; If you use `org' and don't want your org files in the default location below,
    ;; change `org-directory'. It must be set before org loads!
    (setq org-directory "~/org/")

    ;; This determines the style of line numbers in effect. If set to `nil', line
    ;; numbers are disabled. For relative line numbers, set this to `relative'.
    (setq display-line-numbers-type t)

    ;; Here are some additional functions/macros that could help you configure Doom:
    ;;
    ;; - `load!' for loading external *.el files relative to this one
    ;; - `use-package!' for configuring packages
    ;; - `after!' for running code after a package has loaded
    ;; - `add-load-path!' for adding directories to the `load-path', relative to
    ;;   this file. Emacs searches the `load-path' when you load packages with
    ;;   `require' or `use-package'.
    ;; - `map!' for binding new keys
    ;;
    ;; To get information about any of these functions/macros, move the cursor over
    ;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
    ;; This will open documentation for it, including demos of how they are used.
    ;;
    ;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
    ;; they are implemented.

    ;; Python configuration
    (after! python
      (setq python-shell-interpreter "python3"
            python-shell-interpreter-args "-i"))

    ;; LSP configuration
    (after! lsp-mode
      (setq lsp-enable-symbol-highlighting t
            lsp-enable-indentation t
            lsp-enable-on-type-formatting t))

    ;; Git configuration
    (after! magit
      (setq magit-repository-directories '(("~/Personal" . 2))))

    ;; Org mode configuration
    (after! org
      (setq org-agenda-files '("~/org/")
            org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "DONE(d)" "CANCELLED(c)"))
            org-todo-keyword-faces '(("INPROGRESS" . "orange")
                                   ("WAITING" . "yellow")
                                   ("CANCELLED" . "red"))))

    ;; Keybindings
    (map! :n "C-h" #'evil-window-left
          :n "C-j" #'evil-window-down
          :n "C-k" #'evil-window-up
          :n "C-l" #'evil-window-right
          :n "C-w h" #'evil-window-left
          :n "C-w j" #'evil-window-down
          :n "C-w k" #'evil-window-up
          :n "C-w l" #'evil-window-right)
  '';

  home.file.".doom.d/packages.el".text = ''
    ;; -*- no-byte-compile: t; -*-
    ;; ~/.doom.d/packages.el

    ;; To install a package with Doom you must declare them here and run 'doom sync'
    ;; on the command line, then restart Emacs for the changes to take effect -- or
    ;; use 'M-x doom/reload-font' for a more limited version of this.
    ;;
    ;; WARNING: Disabling core packages listed in ~/.emacs.d/core/packages.el may
    ;; have nasty side-effects and is not recommended.

    ;;
    ;; These are packages for a particular language, framework or library. If you
    ;; want to see the options, go to ~/.emacs.d/langs/ and press 'SPC h o'.
    ;; Langs marked with [2] are two-layered, also see the Development docs on the
    ;; website.

    ;; --- Language Packs ---
    ;; (python +lsp +pyright)        ; beautiful is better than ugly
    ;; (rust +lsp)                   ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
    ;; (cc +lsp)                     ; C > C++ == 1
    ;; (go +lsp)                     ; the hipster dialect
    ;; (haskell +lsp)                ; a language that's lazier than I am
    ;; (java +lsp)                   ; the poster child for carpal tunnel syndrome
    ;; (javascript +lsp)             ; all(hope(abandon(ye(who(enter(here))))))
    ;; (json +lsp)                   ; At least it ain't XML
    ;; (lua +lsp)                    ; one-based indices? one-based indices
    ;; (markdown +grip)              ; it'll shock you how much I didn't do
    ;; (nix +lsp)                    ; I hereby declare "nix geht mehr!"
    ;; (org +pretty +gnuplot +pandoc +pomodoro +present) ; organize your plain life in plain text
    ;; (sh +lsp)                     ; she sells {ba,z,fi}sh shells on the C xor
    ;; (web +lsp)                    ; the tubes
    ;; (yaml +lsp)                   ; JSON, but readable

    ;; --- Editor Packs ---
    ;; (company +childframe)         ; the ultimate code completion backend
    ;; (ivy +fuzzy +prescient +icons) ; a search engine for love and life
    ;; (vertico +icons)              ; the search engine of the future

    ;; --- Tool Packs ---
    ;; (debugger +lsp)               ; FIXME stepping through code, to help you add bugs
    ;; (docker +lsp)                 ; the gift of the gods
    ;; (eval +overlay)               ; run code, run (also, repls)
    ;; (lookup +dictionary +offline) ; navigate your code and its documentation
    ;; (lsp +peek)                   ; M-x vscode
    ;; (magit +forge)                ; a git porcelain for Emacs
    ;; (pass)                        ; password manager for nerds
    ;; (pdf)                         ; pdf enhancements
    ;; (terraform +lsp)              ; infrastructure as code
    ;; (tmux)                        ; an API for interacting with tmux
    ;; (upload)                      ; map local to remote projects via ssh/ftp

    ;; --- App Packs ---
    ;; (calendar)                    ; Emacs' calendar
    ;; (emms)                        ; Emacs Multimedia System
    ;; (everywhere)                  ; *leave* Emacs!? You must be joking
    ;; (irc)                         ; how neckbeards socialize
    ;; (rss +org)                    ; emacs as an RSS reader
    ;; (twitter)                     ; twitter client https://twitter.com/vnought

    ;; --- Custom Packages ---
    ;; Add any additional packages you want to install
  '';

  # Font configuration
  home.file.".config/fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>Iosevka</family>
          <family>Iosevka Aile</family>
          <family>Iosevka Etoile</family>
          <family>DejaVu Sans Mono</family>
          <family>Liberation Mono</family>
        </prefer>
      </alias>
      <alias>
        <family>sans-serif</family>
        <prefer>
          <family>Noto Sans</family>
          <family>DejaVu Sans</family>
        </prefer>
      </alias>
    </fontconfig>
  '';

  # Python development configuration
  home.file.".config/python/pyproject.toml".text = ''
    [build-system]
    requires = ["hatchling"]
    build-backend = "hatchling.build"

    [project]
    name = "your-project"
    version = "0.1.0"
    description = "Your project description"
    authors = [{name = "hi", email = "hi@hinote.pro"}]
    readme = "README.md"
    requires-python = ">=3.11"
    classifiers = [
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.11",
        "Programming Language :: Python :: 3.12",
    ]

    [project.optional-dependencies]
    dev = [
        "pytest>=7.0",
        "pytest-cov>=4.0",
        "pytest-asyncio>=0.21",
        "pytest-mock>=3.10",
        "black>=23.0",
        "flake8>=6.0",
        "mypy>=1.0",
        "isort>=5.12",
        "pre-commit>=3.0",
        "safety>=2.0",
        "bandit>=1.7",
    ]

    [tool.black]
    line-length = 88
    target-version = ['py311']
    include = '\.pyi?$'
    extend-exclude = '''
    /(
      # directories
      \.eggs
      | \.git
      | \.hg
      | \.mypy_cache
      | \.tox
      | \.venv
      | build
      | dist
    )/
    '''

    [tool.isort]
    profile = "black"
    line_length = 88
    multi_line_output = 3
    include_trailing_comma = true
    force_grid_wrap = 0
    use_parentheses = true
    ensure_newline_before_comments = true

    [tool.mypy]
    python_version = "3.11"
    warn_return_any = true
    warn_unused_configs = true
    disallow_untyped_defs = true
    disallow_incomplete_defs = true
    check_untyped_defs = true
    disallow_untyped_decorators = true
    no_implicit_optional = true
    warn_redundant_casts = true
    warn_unused_ignores = true
    warn_no_return = true
    warn_unreachable = true
    strict_equality = true

    [tool.pytest.ini_options]
    minversion = "7.0"
    addopts = "-ra -q --strict-markers --strict-config"
    testpaths = ["tests"]
    python_files = ["test_*.py", "*_test.py"]
    python_classes = ["Test*"]
    python_functions = ["test_*"]
    markers = [
        "slow: marks tests as slow (deselect with '-m \"not slow\"')",
        "integration: marks tests as integration tests",
        "unit: marks tests as unit tests",
    ]

    [tool.coverage.run]
    source = ["src"]
    omit = [
        "*/tests/*",
        "*/test_*",
        "*/__pycache__/*",
        "*/venv/*",
        "*/\.venv/*",
    ]

    [tool.coverage.report]
    exclude_lines = [
        "pragma: no cover",
        "def __repr__",
        "if self.debug:",
        "if settings.DEBUG",
        "raise AssertionError",
        "raise NotImplementedError",
        "if 0:",
        "if __name__ == .__main__.:",
        "class .*\\bProtocol\\):",
        "@(abc\\.)?abstractmethod",
    ]
  '';

  home.file.".config/python/.pre-commit-config.yaml".text = ''
    repos:
      - repo: https://github.com/pre-commit/pre-commit-hooks
        rev: v4.5.0
        hooks:
          - id: trailing-whitespace
          - id: end-of-file-fixer
          - id: check-yaml
          - id: check-added-large-files
          - id: check-merge-conflict
          - id: debug-statements

      - repo: https://github.com/psf/black
        rev: 23.12.1
        hooks:
          - id: black
            language_version: python3

      - repo: https://github.com/pycqa/isort
        rev: 5.13.2
        hooks:
          - id: isort
            args: ["--profile", "black"]

      - repo: https://github.com/pycqa/flake8
        rev: 7.0.0
        hooks:
          - id: flake8
            args: [--max-line-length=88, --extend-ignore=E203,W503]

      - repo: https://github.com/pre-commit/mirrors-mypy
        rev: v1.8.0
        hooks:
          - id: mypy
            additional_dependencies: [types-all]

      - repo: https://github.com/PyCQA/bandit
        rev: 1.7.5
        hooks:
          - id: bandit
            args: ["-r", ".", "-f", "json", "-o", "bandit-report.json"]
            exclude: ^tests/

      - repo: https://github.com/PyCQA/safety
        rev: v2.3.5
        hooks:
          - id: safety
            args: ["--full-report"]
  '';

  home.file.".config/python/.flake8".text = ''
    [flake8]
    max-line-length = 88
    extend-ignore = E203, W503
    exclude = 
        .git,
        __pycache__,
        .venv,
        venv,
        build,
        dist,
        *.egg-info,
        .mypy_cache,
        .pytest_cache
    per-file-ignores =
        __init__.py:F401
        tests/*:S101,S105,S106,S107
  '';

  home.file.".config/python/.mypy.ini".text = ''
    [mypy]
    python_version = 3.11
    warn_return_any = True
    warn_unused_configs = True
    disallow_untyped_defs = True
    disallow_incomplete_defs = True
    check_untyped_defs = True
    disallow_untyped_decorators = True
    no_implicit_optional = True
    warn_redundant_casts = True
    warn_unused_ignores = True
    warn_no_return = True
    warn_unreachable = True
    strict_equality = True

    [mypy.plugins.numpy.*]
    ignore_missing_imports = True

    [mypy-pandas.*]
    ignore_missing_imports = True

    [mypy-matplotlib.*]
    ignore_missing_imports = True
  '';

  home.file.".config/zellij/config.kdl".text = ''
    // Zellij configuration
    default_shell "fish"
    default_layout "compact"
    
    // Theme
    theme "sakura"
    
    // Keybindings
    keybinds {
      shared_except "locked" {
        bind "Ctrl g" { SwitchToMode "Normal"; }
        bind "Ctrl t" { NewTab; }
        bind "Alt t" { NewTab; }
        bind "Ctrl w" { CloseTab; }
        bind "Alt w" { CloseTab; }
        bind "Ctrl Tab" { NextTab; }
        bind "Ctrl Shift Tab" { PreviousTab; }
        bind "Alt 1" { GoToTab 0; }
        bind "Alt 2" { GoToTab 1; }
        bind "Alt 3" { GoToTab 2; }
        bind "Alt 4" { GoToTab 3; }
        bind "Alt 5" { GoToTab 4; }
        bind "Alt 6" { GoToTab 5; }
        bind "Alt 7" { GoToTab 6; }
        bind "Alt 8" { GoToTab 7; }
        bind "Alt 9" { GoToTab 8; }
        bind "Alt 0" { GoToTab 9; }
      }
      
      normal {
        bind "Ctrl h" { MoveFocus "Left"; }
        bind "Ctrl j" { MoveFocus "Down"; }
        bind "Ctrl k" { MoveFocus "Up"; }
        bind "Ctrl l" { MoveFocus "Right"; }
        bind "Ctrl Shift h" { MoveFocusOrTab "Left"; }
        bind "Ctrl Shift j" { MoveFocusOrTab "Down"; }
        bind "Ctrl Shift k" { MoveFocusOrTab "Up"; }
        bind "Ctrl Shift l" { MoveFocusOrTab "Right"; }
        bind "Alt h" { Resize "Increase Left"; }
        bind "Alt j" { Resize "Increase Down"; }
        bind "Alt k" { Resize "Increase Up"; }
        bind "Alt l" { Resize "Increase Right"; }
        bind "Ctrl Shift ==" { Resize "Increase"; }
        bind "Ctrl Shift -" { Resize "Decrease"; }
        bind "Ctrl Shift 0" { Resize "Reset"; }
        bind "Ctrl d" { Detach; }
        bind "Ctrl s" { SwitchToMode "Scroll"; }
        bind "Ctrl p" { SwitchToMode "Pane"; }
        bind "Ctrl n" { NewPane; }
        bind "Ctrl Shift n" { NewPane "Down"; }
        bind "Ctrl Shift o" { NewPane "Right"; }
        bind "Ctrl x" { CloseFocus; }
        bind "Ctrl z" { TogglePaneFrames; }
        bind "Ctrl m" { ToggleFloatingPanes; }
        bind "Ctrl f" { SwitchToMode "Search"; }
        bind "Ctrl /" { TogglePaneEmbedOrFloating; }
        bind "Alt [" { PreviousSwapLayout; }
        bind "Alt ]" { NextSwapLayout; }
        bind "Alt Enter" { ToggleFullscreen; }
      }
      
      locked {
        bind "Ctrl g" { SwitchToMode "Normal"; }
        bind "Ctrl t" { NewTab; }
        bind "Alt t" { NewTab; }
        bind "Ctrl w" { CloseTab; }
        bind "Alt w" { CloseTab; }
        bind "Ctrl Tab" { NextTab; }
        bind "Ctrl Shift Tab" { PreviousTab; }
        bind "Alt 1" { GoToTab 0; }
        bind "Alt 2" { GoToTab 1; }
        bind "Alt 3" { GoToTab 2; }
        bind "Alt 4" { GoToTab 3; }
        bind "Alt 5" { GoToTab 4; }
        bind "Alt 6" { GoToTab 5; }
        bind "Alt 7" { GoToTab 6; }
        bind "Alt 8" { GoToTab 7; }
        bind "Alt 9" { GoToTab 8; }
        bind "Alt 0" { GoToTab 9; }
      }
      
      pane {
        bind "h" { MoveFocus "Left"; }
        bind "j" { MoveFocus "Down"; }
        bind "k" { MoveFocus "Up"; }
        bind "l" { MoveFocus "Right"; }
        bind "p" { NewPane; }
        bind "n" { NewPane "Down"; }
        bind "o" { NewPane "Right"; }
        bind "x" { CloseFocus; }
        bind "z" { TogglePaneFrames; }
        bind "f" { ToggleFloatingPanes; }
        bind "w" { TogglePaneEmbedOrFloating; }
        bind "e" { TogglePaneEmbedOrFloating; }
        bind "c" { SwitchToMode "RenamePane"; }
        bind "m" { TogglePaneEmbedOrFloating; }
        bind "1" { NewPane "Down"; }
        bind "2" { NewPane "Right"; }
        bind "3" { NewPane "Down"; }
        bind "4" { NewPane "Right"; }
        bind "5" { NewPane "Down"; }
        bind "6" { NewPane "Right"; }
        bind "7" { NewPane "Down"; }
        bind "8" { NewPane "Right"; }
        bind "9" { NewPane "Down"; }
        bind "0" { NewPane "Right"; }
        bind "Space" { ToggleFloatingPanes; }
        bind "Escape" { SwitchToMode "Normal"; }
      }
      
      tab {
        bind "h" { GoToPreviousTab; }
        bind "j" { GoToNextTab; }
        bind "k" { GoToPreviousTab; }
        bind "l" { GoToNextTab; }
        bind "n" { NewTab; }
        bind "x" { CloseTab; }
        bind "1" { GoToTab 0; }
        bind "2" { GoToTab 1; }
        bind "3" { GoToTab 2; }
        bind "4" { GoToTab 3; }
        bind "5" { GoToTab 4; }
        bind "6" { GoToTab 5; }
        bind "7" { GoToTab 6; }
        bind "8" { GoToTab 7; }
        bind "9" { GoToTab 8; }
        bind "0" { GoToTab 9; }
        bind "r" { SwitchToMode "RenameTab"; }
        bind "Escape" { SwitchToMode "Normal"; }
      }
      
      scroll {
        bind "Ctrl u" { ScrollUp; }
        bind "Ctrl d" { ScrollDown; }
        bind "Ctrl b" { ScrollUp; }
        bind "Ctrl f" { ScrollDown; }
        bind "Ctrl y" { ScrollUp; }
        bind "Ctrl e" { ScrollDown; }
        bind "k" { ScrollUp; }
        bind "j" { ScrollDown; }
        bind "G" { ScrollToBottom; }
        bind "g" { ScrollToTop; }
        bind "Escape" { SwitchToMode "Normal"; }
      }
      
      search {
        bind "Ctrl n" { Search "next"; }
        bind "Ctrl p" { Search "previous"; }
        bind "Escape" { SwitchToMode "Normal"; }
      }
      
      rename_tab {
        bind "Enter" { Confirm; }
        bind "Escape" { SwitchToMode "Normal"; }
      }
      
      rename_pane {
        bind "Enter" { Confirm; }
        bind "Escape" { SwitchToMode "Normal"; }
      }
      
      session {
        bind "d" { Detach; }
        bind "Escape" { SwitchToMode "Normal"; }
      }
      
      move {
        bind "h" { MovePane "Left"; }
        bind "j" { MovePane "Down"; }
        bind "k" { MovePane "Up"; }
        bind "l" { MovePane "Right"; }
        bind "Escape" { SwitchToMode "Normal"; }
      }
      
      resize {
        bind "h" { Resize "Increase Left"; }
        bind "j" { Resize "Increase Down"; }
        bind "k" { Resize "Increase Up"; }
        bind "l" { Resize "Increase Right"; }
        bind "Escape" { SwitchToMode "Normal"; }
      }
    }
    
    // Layouts
    layouts {
      layout "compact" {
        pane size=1 borderless=true {
          plugin location="zellij:status-bar"
        }
        children
        pane size=2 borderless=true {
          plugin location="zellij:tab-bar"
        }
        children
      }
    }
    
    // Plugins
    plugins {
      tab-bar { path = "tab-bar"; }
      status-bar { path = "status-bar"; }
      strider { path = "strider"; }
    }
  '';

  home.file.".config/hypr/hyprland.conf".text = "...";  # Truncated for brevity
  home.file.".config/hypr/hyprpaper.conf".text = "preload = ~/Pictures/wallpaper.jpg
wallpaper = eDP-1,~/Pictures/wallpaper.jpg";

  home.file.".config/waybar/config".text = "...";  # Truncated for brevity
  home.file.".config/waybar/style.css".text = "...";  # Truncated for brevity

  home.packages = with pkgs; [
    # Development tools
    lazygit starship zoxide eza
    gcc gdb clang valgrind rustup nodejs_20 yarn deno python3 python311 python312 python313 cmake pkg-config
    strace ltrace qemu docker docker-compose podman kubectl helm minikube terraform k9s
    direnv nix-direnv gh ripgrep fd tree-sitter stylua
    
    # Python development tools
    uv hatch
    python3Packages.pip python3Packages.setuptools python3Packages.wheel
    python3Packages.virtualenv python3Packages.pytest python3Packages.black
    python3Packages.flake8 python3Packages.mypy python3Packages.isort
    python3Packages.pylint python3Packages.poetry python3Packages.pipenv
    python3Packages.jupyter python3Packages.ipython python3Packages.notebook
    python3Packages.matplotlib python3Packages.numpy python3Packages.pandas
    python3Packages.scipy python3Packages.scikit-learn python3Packages.requests
    python3Packages.flask python3Packages.django python3Packages.fastapi
    python3Packages.uvicorn python3Packages.sqlalchemy python3Packages.alembic
    python3Packages.pytest-cov python3Packages.pytest-asyncio python3Packages.pytest-mock
    python3Packages.pre-commit python3Packages.safety python3Packages.bandit
    
    # Additional useful tools
    bat du-dust fzf jq yq-go
    zellij
    ffmpeg imagemagick
    
    # Fun stuff
    pokemon-colorscripts
    neofetch
    fastfetch
    
    # Fonts
    iosevka
    iosevka-bin
    iosevka-aile
    iosevka-etoile
  ];
}
