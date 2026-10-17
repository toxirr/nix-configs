{ ... }:
{

  homebrew = {
    enable = true;
    casks = [
      "iina" # media player
      "font-hack-nerd-font"
      "element" # uchar o'rin bosari
      "spotify"
      "mullvad-vpn"
      "yandex-music"
    ];
    brews = [
      "ca-certificates"
      "libpq"
      "colima"
      "tailscale"
    ];
    onActivation.cleanup = "zap";
  };
}
