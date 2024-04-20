{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "tyler";
    homeDirectory = "/home/tyler";
    stateVersion = "24.05";
    packages = with pkgs; [
      alejandra # nixfmt but wirtten in rust!!!
      alacritty # A cross-platform, GPU-accelerated terminal emulator
      audio-recorder # A utility for audio recording
      brave # A privacy-focused web browser
      btop # A resource monitor that shows usage and stats for processor, memory, disks, network and processes
      dua # A disk usage analyzer with console interface
      feh # background image for i3?
      git # Distributed version control system
      github-cli # GitHub’s official command line tool
      gnome.gnome-disk-utility
      grim # A simple screenshot utility for Wayland
      gzip # A software application used for file compression and decompression
      hyprpicker # A color picker for the wlroots-based Wayland compositors
      i3
      i3lock
      i3status
      lf # this is a good one. keep it and use it more.
      libreoffice
      lxde.lxsession # This is what I use for polkit/session management
      mako # A lightweight notification daemon for Wayland
      man-db # A database-driven manual pager suite
      mupdf # A lightweight PDF, XPS, and E-book viewer
      neofetch # A command-line system information tool
      nodejs_20 # Node.js is a JavaScript runtime built on Chrome's V8 JavaScript engine
      onefetch # A command-line tool that displays information about your Git project directly on your terminal
      openssh # The premier connectivity tool for remote login with the SSH protocol
      opusTools # better audio format for audio recording.
      pamixer # Pulseaudio command line mixer
      pavucontrol # PulseAudio Volume Control (pavucontrol) is a simple GTK based volume control tool ("mixer") for the PulseAudio sound server # I use to mute -BB
      pipewire # Multimedia processing graphs
      playerctl # Command-line utility and library for controlling media players that implement the MPRIS D-Bus Interface Specification
      pulseaudio # A sound system for POSIX OSes, meaning that it is a proxy for your sound applications
      rofi
      slurp # Select a region in a Wayland compositor and print it to the standard output
      sudo # A program designed to provide a way for a system administrator to allow some users to execute some commands as root (or another user)
      swappy # A Wayland native snapshot and editor tool, inspired by Snappy on macOS
      swayidle # Idle management daemon for Wayland
      swayimg # A small utility to view images in sway
      swaylock # Screen locker for Wayland
      time # A command for timing the execution of computer programs
      trashy # use 'trash' not 'rm'|'rm -rf'
      tree # A recursive directory listing command that produces a depth indented listing of files
      unzip # A utility that extracts files from .zip archives
      usermount
      wdisplays
      wl-color-picker
      wf-recorder
      wget # A free utility for non-interactive download of files from the web
      which # A utility that shows the full path of (shell) commands
      xcolor # a hyprpicker but for x (i3)
      xfce.mousepad # nice simple text editor
      xfce.thunar # Thunar is a modern file manager for the Xfce Desktop Environment
      xfce.thunar-volman # Thunar Volume Manager for automatic management of removable drives and media
      xfce.tumbler # Tumbler is a D-Bus service for applications to request thumbnails for various URI schemes and MIME types
      xfce.thunar-archive-plugin
      xfce.xfce4-screenshooter
      xwayland # X server compatibility layer for Wayland
      nload # view network traffic and usage
      # signal-desktop # Signal — Private Messenger for Windows, Mac, and Linux
      # element-desktop # A glossy Matrix collaboration client for the desktop
      # gphoto2
      # hello
      # bat # A cat clone with syntax highlighting and Git integration
      # bitwarden # A free and open-source password management service
      # mullvad # A VPN serv      
      # ffmpegthumbnailer # A lightweight video thumbnailer
      # filezilla # A free software, cross-platform FTP application
      # firefox
      # gcc #BB needs to build rust packages
      # gimp # GNU Image Manipulation Program, a raster graphics editorice offered by the Swedish company Amagicom AB
      # glib # A low-level core library that forms the basis of GTK and GNOME #BB NEEDED FOR STABLE DIFFUSION
      # yt-dlp # A youtube-dl fork with additional features and fixes
      # telegram-desktop # Telegram is a messaging app with a focus on speed and security
      # heroic
      # thunderbird # A free and open-source cross-platform email client, news client, RSS, and chat client developed by the Mozilla Foundation
      # popsicle # A powerful and flexible graphical utility for flashing OS images to USB drives
      # insomnia
      # deluge
      # mupen64plus
      # bottom #like btop but wirtten in rust
      # vlc # The VLC media player is a free and open-source portable cross-platform media player software
      # nvtopPackages.nvidia # btop for nvidia?
      # chromium # An open-source web browser developed by Google
      # cinny-desktop # Matrix client
      # darktable # adobe lightroom alt? space for forward, backspace for backward
      # deno # A secure runtime for JavaScript and TypeScript
      # dmenu
      
      #UNFREE ZONE
      # slack # Proprietary business communication platform
      # discord # A proprietary freeware VoIP application designed for gaming communities
      # obsidian
      # spotify # A digital music streaming service
      # minecraft
      # prismlauncher
      # surrealdb
      # factorio
      #UNFREE ZONE
    ];
  };
  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      history = {
        extended = true; # Save timestamp in history file.
        ignoreAllDups = true;
        share = true;
      };
      prezto = {
        enable = true;
        color = true;
        editor.keymap = "vi";
        pmodules = ["git" "history-substring-search"];
      };
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
    };
    i3status-rust = {
      enable = true;
      bars = {
        default = {
          blocks = [
            {
              block = "sound";
              format = " $icon $volume ";
            }
            {
              block = "memory";
              format = " $icon $mem_used_percents.eng(w:2) ";
              interval = 1;
            }
            {
              block = "cpu";
              interval = 1;
              format = " $icon $utilization ";
            }
            {
              block = "time";
              format = "$timestamp.datetime(f:'%Y-%m-%d %I:%M:%S %p') ";
              interval = 1;
            }
          ];
          icons = "awesome6";
          theme = "solarized-dark";
        };
      };
    };
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = ["sway/workspaces"];
          # modules-center = ["sway/window"];
          modules-right = ["pulseaudio" "memory" "cpu" "clock"];

          clock = {
            format = "{:%Y-%m-%d %I:%M:%S %p}";
            interval = 1;
          };

          "custom/spotify" = {
            exec = "playerctl --player=spotify metadata --format '{{ title }} - {{ artist }}'";
            interval = 5;
          };

          "sway/workspaces" = {disable-scroll = true;};
          memory = {
            "format" = "  {}%";
            "interval" = 1;
          };
          cpu = {
            "format" = "  {usage}%";
            "interval" = 1;
          };
          pulseaudio = {
            "format" = "{icon}  {volume}%";
            "format-muted" = "muted";
            "states" = {
              "high" = "";
              "medium" = "";
              "low" = "";
            };
            "format-icons" = {"default" = ["" "" ""];};
            "on-click" = "pavucontrol";
          };
        };
      };
      style = ''
        * {
        border: none;
        border-radius: 0;
        font-family: 'Source Code Pro', sans-serif;
        }
        window#waybar {
        background: #1E1E1E;
        color: #C0C0C0;
        font-size: 20px;
        }
        #workspaces button {
        margin-right: 10px;
        padding: 2px 10px;
        background: #333;
        color: #EEE;
        border: none;
        border-radius: 4px;
        }
        #pulseaudio, #memory, #cpu {
        padding-right: 15px;
        }
      '';
    };
    helix = {
      enable = true;
      settings = {
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
        };
        theme = "everblush";
      };
    };

    alacritty = {
      enable = true;
      settings = {
        font.size = 15;
        colors = {
          primary = {
            background = "#181B20";
            foreground = "#9B9081";
          };
          cursor = {
            text = "#181B20";
            cursor = "#9B9081";
          };
          normal = {
            black = "#353535";
            red = "#744B40";
            green = "#6D6137";
            yellow = "#765636";
            blue = "#61564B";
            magenta = "#6B4A49";
            cyan = "#435861";
            white = "#B3B3B3";
          };
          bright = {
            black = "#5F5F5F";
            red = "#785850";
            green = "#6F6749";
            yellow = "#776049";
            blue = "#696057";
            magenta = "#6F5A59";
            cyan = "#525F66";
            white = "#CDCDCD";
          };
        };
      };
    };
    ssh = {
      enable = true;
      matchBlocks = {
        "Host nameOfRemoteServer" = {
          hostname = "1.1.1.1";
          user = "tyler";
          port = 42069;
          identityFile = "~/.ssh/id_ed25519";
        };
      };
    };
    swaylock = {
      enable = true;
      settings = {
        "font-size" = 24;
        "indicator-radius" = 50;
        "show-failed-attempts" = true;
        image = "${config.home.homeDirectory}/github/nix/stars.jpg";
        "indicator-thickness" = "5";
        line-color = "2d1209";
        ring-color = "2d1209";
        key-hl-color = "2d1209";
        ring-ver-color = "2d1209";
        inside-ver-color = "2d1209";
      };
    };
    btop = {
      enable = true;
      settings = {
        update_ms = 100;
        proc_sorting = "memory";
      };
    };
    git = {
      enable = true;
      userName = "tylerGithubName";
      userEmail = "3838347+tyler@users.noreply.github.com"; #i use my public github email find it in your settings.
    };
    #vscode is unfree
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        svelte.svelte-vscode
        github.copilot
        jnoortheen.nix-ide
      ];
    };
  };
  services = {
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 600;
          command = "/run/current-system/sw/bin/swaylock";
        }
      ];
    };
    mako = {
      enable = true;
      defaultTimeout = 7000;
    };
  };
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      input."*" = {
        accel_profile = "flat";
        pointer_accel = "0.1";
      };
      menu = "rofi -show drun -show-icons";
      bars = [
        {
          position = "top";
          command = "waybar";
          fonts = {
            names = ["dejavu sans mono" "fontawesome5free"];
            style = "bold semi-condensed";
            size = 15.0;
          };
        }
      ];
      output.DP-3 = {
        bg = "${config.home.homeDirectory}/github/nix/stars.jpg fill";
      };
      window = {
        titlebar = false;
        border = 1;
      };
      colors = {
        focused = {
          border = "#FFFFFF";
          background = "#FFFFFF";
          text = "#FFFFFF";
          indicator = "#FFFFFF";
          childBorder = "#FFFFFF";
        };
      };

      gaps = {
        inner = 10;
        outer = 5;
      };
    };
    extraConfig = ''
      bindsym XF86AudioRaiseVolume exec pamixer -i 5
      bindsym XF86AudioLowerVolume exec pamixer -d 5
      bindsym XF86AudioMute exec pamixer -t
      bindsym XF86AudioStop exec playerctl -a stop
      bindsym XF86Audioplay exec playerctl -a play-pause
      bindsym XF86AudioNext exec playerctl -a next
      bindsym XF86AudioPrev exec playerctl -a previous
      bindsym Print exec grim -g "$(slurp)" - | swappy -f -
      bindsym Pause exec swaylock
      bindsym Mod1+space exec thunar;
      bindsym Mod1+Return exec brave;


      exec lxpolkit

    '';
  };
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = rec {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "rofi -show drun -show-icons";
        bars = [
          {
            fonts = {
              names = ["DejaVu Sans Mono" "FontAwesome5Free"];
              style = "Bold Semi-Condensed";
              size = 14.0;
            };
            position = "top";
            statusCommand = "i3status-rs ~/.config/i3status-rust/config-default.toml";
          }
        ];

        keybindings = pkgs.lib.mkOptionDefault {
          "XF86AudioMute" = "exec pamixer -t";
          "XF86AudioRaiseVolume" = "exec pamixer -i 5";
          "XF86AudioLowerVolume" = "exec pamixer -d 5";
          "XF86AudioStop" = "exec playerctl -a stop";
          "XF86AudioPlay" = "exec playerctl -a play-pause";
          "XF86AudioNext" = "exec playerctl -a next";
          "XF86AudioPrev" = "exec playerctl -a previous";
        };
        gaps = {
          inner = 10;
          outer = 5;
        };
        window = {
          titlebar = false;
          border = 1;
        };
      };
      extraConfig = ''
        bindsym Pause exec i3lock -f -i ${config.home.homeDirectory}/github/nix/stars.jpg
        bindsym Print exec xfce4-screenshooter
        bindsym Mod1+space exec thunar;
        bindsym Mod1+Return exec brave;
        exec lxpolkit
        exec --no-startup-id xrandr --output DP-2 --mode 2560x1440 --rate 144
      '';
    };
  };
}
