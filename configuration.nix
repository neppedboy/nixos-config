# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ## Based 
      ./hardware-configuration.nix
      ./configs/os/mounts.nix

      ## GUI 
      ./configs/os/xorg.nix
      ./configs/os/DE/KDE/plasma.nix
      ./beauty/etc/fonts.nix

      ## HARDWARE
      ./configs/os/hardware/sound.nix
      ./configs/os/hardware/radeon-gpu.nix
      
      ## Some needed things
      ./configs/os/lifehacks.nix
      ./configs/os/packages.nix
      ./configs/os/system.nix
      ./configs/os/users.nix
      ./configs/os/appimage.nix
      
      ## Tips and tricks
      ./configs/apps/usual.nix
      ./configs/apps/other.nix
      ./configs/apps/gaming.nix
      ./configs/apps/coding.nix
      ./configs/shell/terminal.nix

      

    ];

            

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.05"; # Did you read the comment?
  services.flatpak.enable = true;

}
