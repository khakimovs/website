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
  npmDepsHash = "sha256-G0S51ozondkRrhW1jd2LCWhIIsdaNHGIzYxcX8xfbXo=";

  nativeBuildInputs = with pkgs; [
    nodejs
    vips
    corepack
    typescript
  ];

  buildInputs = with pkgs; [
    openssl
    vips
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
