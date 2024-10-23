{
  description = "Khakimov's Website";

  inputs = {
  # Nixpkgs
  nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

  # You can access packages and modules from different nixpkgs revs
  # at the same time. Here's an working example:
  # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  # Also see the 'unstable-packages' overlay at 'overlays/home.nix'.

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
