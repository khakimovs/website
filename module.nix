# Refer to this for more:
# https://www.reddit.com/r/NixOS/comments/1fxf0am/setting_up_a_nextjs_project_as_a_systemd_service/
flake: {
  config,
  lib,
  pkgs,
  ...
}: let
  # Shortcut config
  cfg = config.services.khakimovs-website;

  # Packaged server
  server = flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  options = with lib; {
    services.khakimovs-website = {
      enable = mkEnableOption ''
        Khakimov's Family website.
      '';

      proxy = {
        enable = mkEnableOption ''
          Proxy reversed method of deployment
        '';

        domain = mkOption {
          type = with types; nullOr str;
          default = null;
          example = "khakimovs.uz";
          description = "Domain to use while adding configurations to web proxy server";
        };
      };

      package = mkOption {
        type = types.package;
        default = server;
        description = ''
          Packaged khakimovs.uz website contents for service.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    warnings = [
      (lib.mkIf (
        cfg.proxy.enable && cfg.proxy.domain == null
      ) "services.khakimovs-website.proxy.domain must be set in order to properly generate certificate!")
    ];

    services.nginx.virtualHosts = lib.mkIf (cfg.enable && cfg.proxy.enable) (
      lib.debug.traceIf (builtins.isNull cfg.proxy.domain)
      "proxy.domain can't be null, please specicy it properly!"
      {
        "${cfg.proxy.domain}" = {
          forceSSL = true;
          enableACME = true;
          root = cfg.package;
          locations."/" = {
            extraConfig = ''
              if ($request_uri ~ ^/(.*)\.html(\?|$)) {
                  return 302 /$1;
              }
              try_files $uri $uri.html $uri/ =404;
            '';
          };
        };
      }
    );
  };
}
