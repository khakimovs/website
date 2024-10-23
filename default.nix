{ pkgs ? let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
  import nixpkgs { overlays = [ ]; }
, ...
}: pkgs.buildNpmPackage rec {
  name = "khakimovs";

  buildInputs = with pkgs; [
    nodejs_20
  ];

  src = ./.;
  npmDepsHash = "sha256-ynuszgmpe+cRG5hgy2YtRQbZJUxBzNXMTw0vdhJu74U=";

  installPhase = ''
    mkdir -p $out/www
    npm run build
    mv ./out/* $out/www
  '';
}
