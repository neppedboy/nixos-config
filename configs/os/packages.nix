{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fuse
    ntfs3g
    bindfs
    appimage-run
  ];
}