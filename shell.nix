let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {
  name = "voronix";
  buildInputs = with pkgs; [
    niv
    nixpkgs-fmt
  ];
}
