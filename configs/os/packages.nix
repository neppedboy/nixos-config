{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ntfs3g
    fuse
  ];
}