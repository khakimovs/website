{ pkgs ? import <nixpkgs> { } }:
pkgs.stdenv.mkDerivation {
  name = "khakimovs";

  nativeBuildInputs = with pkgs; [
    # Hail the Nix
    nixd
    nixpkgs-fmt

    # Nodejs
    nodejs_20
  ];

  buildInputs = with pkgs; [
    openssl
    cacert
  ];
}
