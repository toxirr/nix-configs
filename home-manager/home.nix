{ ... }:
{
  imports = [
    ../packages/home.nix
    ../modules/git.nix
    ../modules/zed
    ../modules/firefox.nix
    ../modules/additions.nix
    ../modules/alacritty.nix
    ../modules/astronvim.nix
    ../modules/zsh.nix
    ../modules/fish.nix
    ../modules/starship.nix
    ../modules/floorp.nix
  ];

  home.stateVersion = "26.05";
}
