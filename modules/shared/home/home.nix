{
  ...
}:

{
  imports = [
    ./terminal/emulator/kitty/kitty.nix
    ./terminal/tmux/tmux.nix
    ./shell/git/git.nix
    ./shell/git/lazygit.nix
    ./shell/zsh/zsh.nix
    ./shell/oh-my-posh/oh-my-posh.nix
    ./browser/firefox/firefox.nix
    ./browser/chromium/ungoogled-chromium.nix
    ./editor/nvim/nvim.nix
    ./wm/hypr/hyprland.nix
    ./audio/wiremix/wiremix.nix
    ./audio/pamixer/pamixer.nix
    ./launcher/walker/walker.nix
    ./music/spotify/spotify.nix
    ./music/playerctl/playerctl.nix
    ./file-explorer/yazi/yazi.nix
    ./file-explorer/nautilus/nautilus.nix
    ./networking/gazelle/gazelle.nix
    ./media-player/vlc/vlc.nix
    ./downloader/qbittorrent/qbittorrent.nix
    ./dev/bashly/bashly.nix
    ./dev/pls/pls.nix
    ./dev/godot/godot.nix
    ./dev/unity/unity.nix
    ./dev/nodejs/nodejs.nix
    ./dev/blender/blender.nix
    ./dev/vhs/vhs.nix
    ./dev/vscode/vscode.nix
    ./dev/dotnet/dotnet.nix
    ./dev/formatters-and-linters/formatters-and-linters.nix
    ./docs/obsidian.nix
    ./calendar/khal/khal.nix
    ./recording/obs.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "codevogel";
  home.homeDirectory = "/home/codevogel";

  home.stateVersion = "25.11"; # Read up on this before changing!

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Enable XDG MIME handling
  xdg.mimeApps.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
