{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.discord.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      home.packages = with pkgs; [
        discord
      ];
    };
  };
}
