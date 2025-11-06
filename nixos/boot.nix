{pkgs, ...}: {
  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/vda";
      useOSProber = false;
      enableCryptodisk = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    initrd = {
      secrets = {"/boot/crypto_keyfile.bin" = null;};
      luks.devices."luks-86dc2790-84d4-4cf6-8414-d733ec3f4493".keyFile = "/boot/crypto_keyfile.bin";
    };
    kernelParams = ["amdgpu.sg_display=0" "amd_iommu=on" "fips=1"];
  };
}
