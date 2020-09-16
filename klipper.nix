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
    rev = "3ac636b33e0dd770d2608d9a7c05c267f1b12149";
    sha256 = "1wwggsrlzhjik2gglkkxg7a3fyvhzpmkzhd5g3szjk8gsww83kha";
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
