{pkgs, ...}: {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock"; # or "${pkgs.swaylock}/bin/swaylock -f -i /home/jr/flakes/modules/wallpapers/wallpaper1.png"; if you want wallpaper on all locks.
      }
    ];
    timeouts = [
      {
        timeout = 500;
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      # {
      #   timeout = 900; # 15 minutes (900 seconds)
      #   command = "${pkgs.systemd}/bin/systemctl suspend";
      # }
    ];
  };
}
