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
pkgs.buildNpmPackage rec {
  pname = manifest.name;
  version = manifest.version;

  src = ./.;
  npmDepsHash = "sha256-U5agzXW7h7GXr89JdQkI5B+BaAXpjUuIIh1p2h0x7nM=";

  nativeBuildInputs = with pkgs; [
    nodejs
    vips
    corepack
  ];

  installPhase = ''
    # Create output directory
    mkdir -p $out

    # Copy all static contents
    cp -R ./out/* $out
  '';

  meta = with pkgs.lib; {
    homepage = "https://khakimovs.uz";
    description = "Website of Khakimovs Family";
    license = with licenses; [ cc-by-40 ];
    platforms = platforms.all;
    maintainers = with maintainers; [ orzklv ];
  };
}
