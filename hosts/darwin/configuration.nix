{
  self,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ../../packages/system.nix
    ../../packages/homebrew.nix
  ];

  environment.shells = [ pkgs.fish ];

  home-manager.backupFileExtension = "hmbackup";

  programs.fish.enable = true;

  services.tailscale.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    allowUnsupportedSystem = true;
    permittedInsecurePackages = [
      "google-chrome-144.0.7559.97"
      "docker-28.5.2"
      "lima-full-1.2.2"
      "lima-additional-guestagents-1.2.2"
    ];
  };

  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = [ "/Applications" ];
      };
    in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';

  # Necessary for using flakes on this system.
  nix.settings = {
    experimental-features = "nix-command flakes";
    # substituters = [
    #   "https://mirror.sjtu.edu.cn/nix-channels/store?priority=2" # Shanghai Jiao Tong University - best for Asia
    #   "https://mirrors.ustc.edu.cn/nix-channels/store?priority=3" # USTC backup mirror
    #   "https://nix-community.cachix.org?priority=4" # Community packages
    #   "https://cache.nixos.org" # Official global cache
    # ];
    # http-connections = 128;
    # max-substitution-jobs = 128;
    # max-jobs = "auto";
    # trusted-public-keys = [
    #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    #   "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
    # ];
  };

  system.primaryUser = "tokhir";

  users.users.tokhir = {
    name = "tokhir";
    uid = 501;
    home = "/Users/tokhir";
    shell = pkgs.zsh;
  };

  users.knownUsers = [ "tokhir" ];

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
    };

    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
    };
  };
  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
