{ pkgs ? import ./nix }: {
  klipper = pkgs.callPackage ./klipper.nix { configFile = ./cfg/klipper.cfg; };
  klippy = pkgs.callPackage ./klippy.nix { };
}
