{
  description = "Nix ikari flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
    spicetify-nix,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      nix-ikari = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs spicetify-nix;};
        modules = 
        [
          ./configuration.nix
          ./configs/flakes/spicetify.nix
          # ./configs/os/DE/KDE/sddm.nix
        ];
      };
    };
  };
}