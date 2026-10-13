{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;

    userKeymaps = import ./keymaps.nix { };

    userSettings = import ./settings.nix { };

    extraPackages = with pkgs; [
      biome
    ];

    extensions = [
      "wakatime"
      "zig"
      "material-icon-theme"
      "toml"
      "biome"
      "nix"
      "make"
      "env"
      "git-firefly"
    ];
  };
}
