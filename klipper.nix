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
    rev = "4d0d219716afb1143119d7e919fa1e896a896f11";
    sha256 = "02xv1a31ln3zkcx240c3qkfmglg1cnhdcanxv44ryvnd9fr854sj";
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
