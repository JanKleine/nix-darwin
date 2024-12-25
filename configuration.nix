{ pkgs, config, ... }: {

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
    onActivation.cleanup = "zap";
    taps = [
      "platformplane/tap"
    ];
    brews = [
      "platformplane/tap/console"
    ];
    casks = [
      "1password"
      "firefox"
      "iina"
      "intellij-idea"
      "iterm2"
      "nextcloud"
      "plex"
      "proton-mail"
      "protonvpn"
      "rustrover"
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

  # diable here because of conflict with home-manager
  # needs to be enabled per user
  programs.zsh.enableGlobalCompInit = false;

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
