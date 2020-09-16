{ stdenv
, fetchFromGitHub
, python2
}: stdenv.mkDerivation rec {
  name = "klippy";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "KevinOConnor";
    repo = "klipper";
    rev = "3ac636b33e0dd770d2608d9a7c05c267f1b12149";
    sha256 = "1wwggsrlzhjik2gglkkxg7a3fyvhzpmkzhd5g3szjk8gsww83kha";
  } + "/klippy";

  buildInputs = [ (python2.withPackages (p: with p; [ cffi pyserial greenlet jinja2 ])) ];

  # mark the main entrypoint as an executable
  postPatch = "chmod 755 ./klippy.py";

  # we need to run this to prebuild the chelper.
  postBuild = "python2 ./chelper/__init__.py";

  installPhase = ''
    mkdir -p $out
    cp -r ./* $out
  '';
}
