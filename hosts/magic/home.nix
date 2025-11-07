{
  lib,
  homeManagerModules,
  ...
}: {
  home.username = "jr";
  home.homeDirectory = lib.mkDefault "/home/jr";
  home.stateVersion = "25.05";

  imports = [../../home/sway homeManagerModules];
  # programs.git.enable = true;
  custom = {
    magic.hm.enable = true;
    git.enable = false;
    gpg.enable = true;
    yazi.enable = true;
    helix.enable = true;
    jj.enable = true;
    # nh.enable = true;
  };
  # Enable Sway as your Wayland window manager
  # wayland.windowManager.sway = {
  #   enable = true;

  # Enable GTK wrapper features for better compatibility with GTK apps
  # wrapperFeatures.gtk = true;

  # Minimal Configuration
  # config = rec {
  #   # Set the modifier key (Mod4 is the Super/Windows key)
  #   modifier = "Mod4";

  #   # Set your preferred terminal emulator
  #   terminal = "${pkgs.kitty}/bin/kitty"; # Example: using 'kitty' terminal

  #   # Status bar configuration (uses swaybar by default)
  #   bars = [{
  #     position = "top";
  #   }];

  #   # Startup commands (optional)
  #   startup = [
  #     # Example: Start a notification daemon
  #     { command = "${pkgs.mako}/bin/mako"; }
  #     # Example: Start a utility for managing outputs (monitors)
  #     # { command = "${pkgs.kanshi}/bin/kanshi"; }
  #   ];

  #   # Basic keybindings
  #   keybindings = {
  #     # Launch terminal
  #     "${modifier}+Return" = "exec ${terminal}";

  #     # Launch an application launcher (e.g., wofi)
  #     "${modifier}+space" = "exec ${pkgs.wofi}/bin/wofi --show drun,run";

  #     # Kill the focused window
  #     "${modifier}+q" = "kill";

  #     # Exit Sway (with confirmation)
  #     "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

  #     # Move focus
  #     "${modifier}+h" = "focus left";
  #     "${modifier}+j" = "focus down";
  #     "${modifier}+k" = "focus up";
  #     "${modifier}+l" = "focus right";

  #     # Move window
  #     "${modifier}+Shift+h" = "move left";
  #     "${modifier}+Shift+j" = "move down";
  #     "${modifier}+Shift+k" = "move up";
  #     "${modifier}+Shift+l" = "move right";
  #   };
  # };
  # };

  # Essential packages for a minimal Wayland desktop experience
  # home.packages = with pkgs; [
  # Terminal (set above in the config)
  # kitty
  # # Application launcher
  # wofi
  # # Notification daemon
  # mako
  # # Utilities for screenshots/copy-paste
  # grim  # Capture images
  # slurp # Select a region
  # wl-clipboard
  # ];

  # home.sessionVariables = {
  #   XDG_SESSION_TYPE = "wayland";
  #   XDG_CURRENT_DESKTOP = "sway";
  #   MOZ_ENABLE_WAYLAND = "1";
  # };
  programs.home-manager.enable = true;
  # ... other home-manager options
}
