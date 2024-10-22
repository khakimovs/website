{ pkgs ? let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
  import nixpkgs { overlays = [ ]; }
, ...
}: pkgs.stdenv.mkDerivation rec {
  pname = "khakimovs";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    pnpm
    nodejs_20
    openssl
    cacert
  ];

  buildInputs = with pkgs; [
    openssl
    cacert
  ];

  buildPhase = ''
    pnpm install
    pnpm build
  '';

  installPhase = ''
    mkdir -p $out/www
    mv ./out/* $out/www
  '';

  SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
}
