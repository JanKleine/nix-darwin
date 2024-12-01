{ pkgs, config, ... }: {

  environment.systemPackages = [
    pkgs.neovim
  ];

  environment.etc = {
    "zshenv".text = ''
      # move zsh files to .config for all users
      export ZDOTDIR="$HOME"/.config/zsh
    '';
  };

  fonts.packages = [
    pkgs.nerd-fonts.iosevka
  ];

  homebrew = {
    enable = true;
    casks = [
      "1password"
      "firefox"
      "iina"
      "iterm2"
      "jetbrains-toolbox"
      "nextcloud"
      "proton-mail"
      "protonvpn"
      "plex"
      "signal"
    ];
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = config.self.rev or config.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  system.defaults = {
    controlcenter.BatteryShowPercentage = true;
    finder.FXPreferredViewStyle = "Nlsv";
    screensaver.askForPassword = true;
    screensaver.askForPasswordDelay = 0;
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };
  };

  users.users = {
    jankleine = {
      description = "Jan Kleine";
      home = "/Users/jankleine";
    };
    ipt = {
      description = "IPT";
      home = "/Users/ipt";
    };
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
