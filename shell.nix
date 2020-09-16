let
  pkgs = import ./nix;
in
pkgs.mkShell {
  name = "voronator";
  buildInputs = with pkgs; [
    niv
    nixpkgs-fmt
  ];
}
