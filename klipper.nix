{ stdenv
, fetchFromGitHub
, gcc-arm-embedded
, lib
, pkgsCross
, python2
, configFile ? null
}: stdenv.mkDerivation rec {
  name = "klipper";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "KevinOConnor";
    repo = "klipper";
    rev = "3ac636b33e0dd770d2608d9a7c05c267f1b12149";
    sha256 = "1wwggsrlzhjik2gglkkxg7a3fyvhzpmkzhd5g3szjk8gsww83kha";
  };

  buildInputs = [ gcc-arm-embedded pkgsCross.avr.stdenv.cc python2 ];

  preBuild = lib.optionalString (configFile != null) ''
    cp ${configFile} ./.config
  '';

  installPhase = ''
    mkdir -p $out
    cp out/klipper.bin $out || true
    cp out/klipper.elf $out || true
  '';
}
