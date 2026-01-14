flake:
{
  pkgs,
  ...
}:
let
  # Hostplatform system
  system = pkgs.hostPlatform.system;

  # Production package
  base = flake.packages.${system}.default;

in
pkgs.mkShell {
  inputsFrom = [ base ];

  packages = with pkgs; [
    # Hail the Nix
    nixd
    statix
    deadnix
    nixfmt-tree

    # Nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
}
