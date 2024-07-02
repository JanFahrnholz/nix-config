{
  lib,
  pkgs,
  user,
  ...
}:
{
    environment.systemPackages = with pkgs; [
        nodejs_22
        lazygit
    ];

    homebrew = {
      enable = true;
      onActivation.autoUpdate = true;

      taps = [];
      brews = [
        "k9s"
      ];
      casks = [
        "slack" 
        "docker"
        "visual-studio-code"
        "jetbrains-toolbox"
        "warp"
        "tableplus"
        "whatsapp"
        "spotify"
      ];
    };
}
