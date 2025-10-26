{
  pkgs ?
    let
      lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
      nixpkgs = fetchTarball {
        url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
        sha256 = lock.narHash;
      };
    in
    import nixpkgs { overlays = [ ]; },
  ...
}:
let
  manifest = pkgs.lib.importJSON ./package.json;
in
pkgs.stdenv.mkDerivation {
  name = manifest.name;

  nativeBuildInputs = with pkgs; [
    # Hail the Nix
    nixd
    nixfmt-tree

    # Nodejs
    nodejs_20
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];

  buildInputs = with pkgs; [
    openssl
    vips
  ];
}
