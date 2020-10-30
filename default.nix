{ pkgs ? import <nixpkgs> { } }: {
  klipper = pkgs.callPackage ./klipper.nix { configFile = ./cfg/klipper.cfg; };
}
