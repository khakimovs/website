{
  description = "Khakimov's Website";

  inputs = {
  # Too old to work with most libraries
  # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

  # Perfect!
  nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  # The flake-utils library
  flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
  { nixpkgs
  , flake-utils
  , ...
  } @ inputs:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    # Nix script formatter
    formatter = pkgs.nixpkgs-fmt;

    # Development environment
    devShells.default = import ./shell.nix { inherit pkgs; };

    # Output package
    packages.default = pkgs.callPackage ./. { };
  });
}
