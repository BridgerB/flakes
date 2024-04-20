{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  environment = {
    shells = with pkgs; [zsh];
    sessionVariables = {GTK_THEME = "Adwaita:dark";};
    systemPackages = with pkgs; [sudo helix rustc rustup cargo sway];
  };
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      (nerdfonts.override {fonts = ["Meslo"];})
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Meslo LG M Regular Nerd Font Complete Mono"];
        serif = ["Noto Serif" "Source Han Serif"];
        sansSerif = ["Noto Sans" "Source Han Sans"];
      };
    };
  };
  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
    bluetooth = {
      enable = true;
      settings = {General = {Enable = "Source, Sink, Media, Socket";};};
    };
  };
  i18n.defaultLocale = "en_US.UTF-8";
  imports = [./hardware-configuration.nix];
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = ["nix-command" "flakes"];
  };
  # needed for steam or vscode etc.
  nixpkgs.config = {
    allowUnfree = true;
  };
  powerManagement.enable = false;
  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        home = ''
          alejandra /home/tyler/github/nix/ &>/dev/null
          sudo -E hx /home/tyler/github/nix/home.nix
        '';
        config = ''
          alejandra /home/tyler/github/nix/ &>/dev/null
          sudo -E hx /home/tyler/github/nix/configuration.nix
        '';
        rebuild = ''
          cd /home/tyler/github/nix/
          git --no-pager diff -U0 *.nix
          alejandra /home/tyler/github/nix/ &>/dev/null
          sudo nixos-rebuild switch --flake '/home/tyler/github/nix/#tyler';
        '';
        gpt = ''
          for file in *; do echo -e "===''${file}===
          $(cat $file)
          ===EOF===
          "; done'';
      };
    };
    steam.enable = true;
    noisetorch.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [thunar-volman thunar-archive-plugin];
    };
  };
  security = {
    pam.services.swaylock = {};
    polkit.enable = true;
  };
  services = {
    blueman.enable = true;
    xserver = {
      enable = true;
      autorun = true;
      displayManager.startx.enable = true;
      windowManager.i3.enable = true;
    };

    udisks2.enable = true;
    mullvad-vpn.enable = true;
    getty.autologinUser = "tyler";
    gvfs.enable = true;
    tumbler.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
  system = {stateVersion = "24.05";};
  time.timeZone = "America/Denver";
  users = {
    users.tyler = {
      isNormalUser = true;
      description = "tyler";
      extraGroups = ["networkmanager" "wheel"];
    };
    defaultUserShell = pkgs.zsh;
  };
}
