{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      unstable = import inputs.nixpkgs-unstable {
        system = pkgs.stdenv.hostPlatform.system;
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    micro
    curl
    bat
    zellij
    helix
    jujutsu

    gcc
    pkg-config
    alejandra
    zsh
    fish
    pnpm
    postman
    git

    tmux # just in case
    neovim # texting
    alt-tab-macos # i hate macos cmd+tab
    betterdisplay # scale monitor
    lazygit # tui for git operations
    google-chrome # holy chrome

    direnv
    starship

    tableplus
    bruno
    python3

    docker
    docker-compose
    dockerfile-language-server
    docker-color-output
    dockerfmt
  ];
}
