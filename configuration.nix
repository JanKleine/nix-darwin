{ pkgs, config, ... }: {

  environment.systemPackages = [
    pkgs.neovim
  ];

  fonts.packages = [
    (pkgs.nerdfonts.override { fonts = ["Iosevka"]; })
  ];

  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "iina"
      "iterm2"
      "1password"
      "jetbrains-toolbox"
      "nextcloud"
      "proton-mail"
      "protonvpn"
      "plex"
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

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
