{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  apps = {
    dev = {
      enable = true;
      treefmt.enable = false;
    };
    tui.rclone.enable = false;
  };

  # home-manager.users.${user}.home.packages = with pkgs; [ ];

  environment.systemPackages = with pkgs; [
    inputs.goris.default
    disko
  ];

  services = {
    xserver.xkb.layout = "latam";
    getty = {
      greetingLine = "Lanky NixOS configuration is now ready";
      helpLine = lib.mkForce ''
        Install an OS with goris
      '';
    };
  };
}
