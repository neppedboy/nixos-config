# based on https://github.com/h4m6urg1r/catppuccin-sddm-flake
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { flake-utils, self, nixpkgs, ... }: flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        makePackage = {
          cfg ? {
            font = "Noto Sans";
            fontSize = "9";
            clockEnabled = "true";
            customBackground = "false";
            loginBackground = "false";
            background = null;
          },
          flavour ? "mocha",
          lib,
          pkgs,
          qtbase,
          qtsvg,
          qtgraphicaleffects,
          qtquickcontrols2,
          srcPath,
          wrapQtAppsHook,
          stdenv
        }: stdenv.mkDerivation rec {
          name = "Catppuccin-${flavour}";

          src = ./src/${srcPath};
          bg = if cfg.background == null then
            null
          else if lib.strings.hasPrefix "http" cfg.background then
            lib.fetchurl{
              url = cfg.background;
            }
          else if lib.pathExists cfg.background then
            lib.fetchfile{
              url = cfg.background;
            }
          else null;

          nativeBuildInputs = [
            wrapQtAppsHook
            pkgs.imagemagick
          ];
          buildInputs = [
            qtbase
            qtsvg
            qtgraphicaleffects
            qtquickcontrols2
          ];

          installPhase = ''
            mkdir -p $out/share/sddm/themes
            if [[ ${if cfg.background == null then "false" else "true"} ]]; then
              convert ${toString bg} $out/share/sddm/themes/${name}/backgrounds/wall.jpg
            fi
            cp -aR $src $out/share/sddm/themes/${name}
          '';
            postFixup = ''
              sed -i '/^Font=/s/.*/Font="${cfg.font}"/' $out/share/sddm/themes/${name}/theme.conf
              sed -i '/^FontSize=/s/.*/FontSize="${cfg.fontSize}"/' $out/share/sddm/themes/${name}/theme.conf
              sed -i '/^ClockEnabled=/s/.*/ClockEnabled="${cfg.clockEnabled}"/' $out/share/sddm/themes/${name}/theme.conf
              sed -i '/^CustomBackground=/s/.*/CustomBackground="${if cfg.background != null then cfg.customBackground else "false"}"/' $out/share/sddm/themes/${name}/theme.conf
              sed -i '/^LoginBackground=/s/.*/LoginBackground="${cfg.loginBackground}"/' $out/share/sddm/themes/${name}/theme.conf
            '';

          meta = {
            description = "Catppuccin ${flavour} sddm theme";
            license = lib.licenses.gpl3;
          };
        };
      in {
        packages = rec {
          catppuccin-frappe = pkgs.libsForQt5.callPackage makePackage{
            flavour = "Frappe";
            srcPath = "catppuccin-frappe";
          };
          catppuccin-latte = pkgs.libsForQt5.callPackage makePackage {
            flavour = "Latte";
            srcPath = "catppuccin-latte";
          };
          catppuccin-macchiato = pkgs.libsForQt5.callPackage makePackage {
            flavour = "Macchiato";
            srcPath = "catppuccin-macchiato";
          };
          catppuccin-mocha = pkgs.libsForQt5.callPackage makePackage {
            flavour = "Mocha";
            srcPath = "catppuccin-mocha";
          };
        };
        nixosModules.${system} = { config, ... }: let
            cfg = config.catppuccin-sddm;
          in{
          options = {
              catppuccin-sddm = {
              theme = pkgs.lib.mkOption {
                type = pkgs.lib.types.str;
                default = "mocha";
              };
              font = {
                name = pkgs.lib.mkOption {
                  type = pkgs.lib.types.str;
                  default = "Noto Sans";
                };
                size = pkgs.lib.mkOption {
                  type = pkgs.lib.types.int;
                  default = 9;
                };
              };
              clock = pkgs.lib.mkEnableOption true;
              background = {
                enable = pkgs.lib.mkEnableOption false;
                image = pkgs.lib.mkOption {
                  default = null;
                };
                login = pkgs.lib.mkOption {
                  type = pkgs.lib.types.bool;
                  default = true;
                };
              };
              package = { "frappe" = self.catppuccin-frappe; "latte" = self.catppuccin-latte; "macchiato" = self.catppuccin-macchiato; "mocha" = self.catppuccin-mocha; }.theme;
              finalPackage = cfg.package.overrideAttrs {
                conf = {
                  font = cfg.font.name;
                  fontSize = cfg.font.size;
                  clockEnabled = cfg.clock;
                  customBackground = cfg.background.enable;
                  loginBackground = cfg.background.login;
                  background = cfg.background.image;
                };
              };
            };
          };
          config = {
              environment.systemPackages = [ cfg.finalPackage ];
              services.xserver.displayManager.sddm.theme = { "frappe" = "Catppuccin-Frappe"; "latte" = "Catppuccin-Latte"; "macchiato" = "Catppuccin-Macchiato"; "mocha" = "Catppuccin-Mocha"; }.theme;
          };
        };
      }
    );
}