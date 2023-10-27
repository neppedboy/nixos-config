{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
      jnoortheen.nix-ide
      mskelton.one-dark-theme 
      ms-vsliveshare.vsliveshare
      esbenp.prettier-vscode
      pkief.material-icon-theme
      catppuccin.catppuccin-vsc
      ];
    })
    wezterm
    github-desktop
    nodejs_18
  ];




}