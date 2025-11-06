{
  pkgs,
  lib,
  ...
}: {
  users.users.jr = {
    isNormalUser = true;
    description = "jr";
    uid = 1000;
    extraGroups = lib.mkForce ["networkmanager"];
    group = "jr";
    ignoreShellProgramCheck = true;
    packages = with pkgs; [
      zoxide
      #  thunderbird
    ];
    shell = pkgs.zsh;
    initialHashedPassword = "$y$j9T$iw3SD4j3NJaO42w3d28bz0$I24HkUwFfXn0Nk0dcZH.yoTcg93kCCn6hO.HRjSkuOD";
  };
  users.mutableUsers = false;

  users.groups.jr = {
    # gid = lib.mkForce 1000;
  };
  users.users.admin = {
    isNormalUser = true;
    description = "admin account";
    extraGroups = ["wheel"];
    group = "admin";
    packages = with pkgs; [
      #  thunderbird
    ];
    initialHashedPassword = "$y$j9T$iw3SD4j3NJaO42w3d28bz0$I24HkUwFfXn0Nk0dcZH.yoTcg93kCCn6hO.HRjSkuOD";
  };

  users.groups.admin = {};
}
