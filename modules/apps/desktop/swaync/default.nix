{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.swaync.enable {
    home-manager.users.${user}.services.swaync = lib.mkIf config.generic.home-manager.enable {
      enable = true;
      settings = {
        positionX = "left";
        positionY = "top";
        layer = "overlay";
        cssPriority = "application";
        timeout = 2;
        timeout-low = 1;
        timeout-critical = 4;
        notification-window-width = 700;
        keyboard-shortcuts = false;
        image-visibility = "always";
        transition-time = 1000;
        hide-on-clear = false;
        hide-on-action = false;
        fit-to-screen = true;
        control-center-width = 700;
      };
    };
  };
}
