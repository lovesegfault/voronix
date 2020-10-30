{ pkgs ? import ./nix }: {
  klipper = pkgs.callPackage ./klipper.nix { configFile = ./cfg/klipper.cfg; };
}
