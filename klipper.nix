{ stdenv
, klipper
, gcc-arm-embedded
, lib
, pkgsCross
, python2

, configFile ? null

, armSupport ? true
, avrSupport ? true
}: stdenv.mkDerivation rec {
  name = "klipper";
  version = "unstable";

  src = klipper.src;

  buildInputs = [ python2 ]
    ++ lib.optional armSupport gcc-arm-embedded
    ++ lib.optional avrSupport pkgsCross.avr.stdenv.cc;

  postPatch = ''
    sed -i 's/return version/return "${version}"/g' ./scripts/buildcommands.py
  '';

  preBuild = lib.optionalString (configFile != null) "cp ${configFile} ./.config";

  installPhase = ''
    mkdir -p $out
    cp ./.config $out/config
    cp out/klipper.bin $out
  '';
}
