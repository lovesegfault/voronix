{ stdenv
, fetchFromGitHub
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

  src = fetchFromGitHub {
    owner = "KevinOConnor";
    repo = "klipper";
    rev = "0bf0cb5b547af5509cb73c567c0214e408134e1d";
    sha256 = "07600pkcdm431djk5mr12gz52dql139vh1haympjqmi1xlfrinxy";
  };

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
