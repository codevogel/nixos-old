{ pkgs, ... }:

{
  imports = [
    ./waybar/waybar.nix
    ./mako/mako.nix
    ./peck/peck.nix
  ];

  # Hint electron apps to use WL
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    killall
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "firefox";

      windowrule = [
        {
          name = "Godot Float Internal Windows";
          "match:class" = "^Godot$";
          tile = "off";
          float = "on";
        }
        {
          name = "Godot Tile Main Window";
          "match:class" = "^Godot$";
          "match:initial_title" = "^Godot$";
          tile = "on";
          float = "off";
        }
      ];

      animation = [
        "workspaces, 0"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        no_focus_fallback = true;
        resize_on_border = true;
        border_size = 1;
      };

      exec-once = [
        "waybar"
        "walker --gapplication-service"
      ];

      bind = [
        # Close windows
        "$mainMod SHIFT, C, killactive"

        # Quit Hyprland
        "$mainMod SHIFT, Q, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"

        # Launch programs
        "$mainMod, Return, exec, $terminal"
        "$mainMod, R, exec, walker"
        "$mainMod, B, exec, $browser"
        "$mainMod, M, exec, spotify"

        # Cycle through workspaces with mouse wheel
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Enter submaps
        "$mainMod, W, submap, move_focus"
        "$mainMod SHIFT, W, submap, resize_windows"

        "$mainMod SHIFT, S, exec, peck --clipboard --temp --freeze"
        "$mainMod SHIFT, R, exec, peck --record --clipboard --temp"
        "$mainMod SHIFT, G, exec, peck --record --clipboard --temp --format=gif"

        "$mainMod, F, fullscreen"
      ]
      ++ (
        # workspaces
        # binds $mod + [ shift +] {1..5} to [move to] workspace {1..5}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mainMod, code:1${toString i}, workspace, ${toString ws}"
              "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 5
        )
      );
    };
    submaps = {
      move_focus = {
        settings = {
          bind = [
            ", h, movefocus, l"
            ", j, movefocus, d"
            ", k, movefocus, u"
            ", l, movefocus, r"

            ", escape, submap, reset"
          ];
        };
      };
      resize_windows = {
        settings = {
          bind = [
            ", h, resizeactive, -100 0"
            ", j, resizeactive, 0 -100"
            ", k, resizeactive, 0 100"
            ", l, resizeactive, 100 0"

            ", escape, submap, reset"
          ];
        };
      };
    };
  };
}
