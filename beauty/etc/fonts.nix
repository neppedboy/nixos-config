{ pkgs, ... }: {

fonts.packages = with pkgs; [
  montserrat
  roboto
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka" ]; })
];

}
