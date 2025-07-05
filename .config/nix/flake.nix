{
  description = "Ridoy Hossain macbook air nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
	  pkgs.go pkgs.claude-code pkgs.opencode pkgs.gh pkgs.neovim
        ];

      security.pam.services.sudo_local.touchIdAuth = true;

      system.defaults.trackpad.Clicking = true;
      system.defaults.trackpad.FirstClickThreshold = 0;

      system.defaults.dock = {
	autohide = true;
	autohide-delay = 0.0;  # Remove delay before showing dock (default is 0.5)
	autohide-time-modifier = 0.5;  # Speed up animation (default is 1.0)
      };

      system.defaults.NSGlobalDomain = {
	KeyRepeat = 2;                # Fast key repeat rate (1-120, lower = faster)
	InitialKeyRepeat = 15;        # Short delay until repeat (10-120, lower = shorter)
      };

      system.primaryUser = "hridu";

      programs.zsh = {
	enable = true;
	shellInit = ''
	  eval "$(/opt/homebrew/bin/brew shellenv)"
	  export PATH="/Users/hridu/go/bin:$PATH"
	'';
      };


      homebrew = {
	enable = true;
	casks = [
	  "brave-browser"
	  "iterm2"
	  "capacities"
	  "sequel-ace"
	  "raycast"
	  "herd"
	  "visual-studio-code"
	  "orbstack"
	  "google-chrome"
	  "vlc"
	  "syncthing-app"
	  "obsidian"
	  "wireshark"
	  "postman"
	  "whatsapp"
	];
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#hriduair
    darwinConfigurations."hriduair" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
