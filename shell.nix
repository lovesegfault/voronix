let
  pkgs = import ./nix;
in
pkgs.mkShell {
  name = "voronix";
  buildInputs = with pkgs; [
    niv
    nixpkgs-fmt
  ];
}
