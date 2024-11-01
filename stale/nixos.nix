{
  pkgs,
  config,
  user,
  host,
  hm,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./hm/home-manager.nix
    hm.nixosModules.home-manager
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 2 * 1024;
    }
  ];

  boot = {
    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    plymouth.enable = false;
    tmp.cleanOnBoot = true;
    initrd = {
      verbose = false;
      availableKernelModules = ["nvidia_drm"];
    };
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "udev.log_level=0"
    ];
  };

  security = {
    rtkit.enable = true;
    sudo.extraConfig = ''
      Defaults timestamp_timeout=0
    '';
  };

  networking = {
    hostName = host;
    networkmanager.enable = true;
    firewall.enable = false;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "-d";
    };
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      auto-optimise-store = false;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  documentation = {
    enable = true;
    nixos.enable = false;
    man.enable = true;
    doc.enable = false;
    info.enable = false;
  };

  console = {
    earlySetup = true; # Test true
    useXkbConfig = true;
  };

  services = {
    getty = {
      autologinUser = user;
      autologinOnce = true;
      # greetingLine = "";
      # helpLine = "";
    };
    # kmscon = {
    #   enable = true;
    #   autologinUser = user;
    #   useXkbConfig = true;
    #   hwRender = false; # Test true
    #   # fonts options
    #   # extraConfig
    #   # extraOptions
    # };
    displayManager.enable = false;
    xserver = {
      enable = false;
      xkb.layout = "latam";
      videoDrivers = ["nvidia"];
    };
    blueman.enable = true;
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
    };
  };

  time.timeZone = "Chile/Continental";
  i18n.defaultLocale = "en_US.UTF-8";

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  programs = {
    hyprland.enable = true;
    steam.enable = true;
    gamemode.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["0xProto"];})
    ];
    enableDefaultPackages = true;
    enableGhostscriptFonts = false;
    fontDir = {
      enable = true;
      decompressFonts = false;
    };
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = false;
      allowType1 = false;
      allowBitmaps = false;
      subpixel = {
        rgba = "none";
        lcdfilter = "light";
      };
      hinting = {
        style = "medium";
        enable = true;
        autohint = false;
      };
      includeUserConf = true;
      useEmbeddedBitmaps = false;
      defaultFonts = {
        serif = ["DejaVu Serif"];
        sansSerif = ["TeX Gyre Adventor"];
        monospace = ["0xProto Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };
  system.stateVersion = "24.05";
}
