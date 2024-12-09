{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.gtk.enable {
    home-manager.users.${user}.gtk = {
      enable = true;
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
      };
    };
  };
}