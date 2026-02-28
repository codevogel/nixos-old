{ pkgs, ... }:

{
  home.packages = with pkgs; [
    prettier
    gdtoolkit_4
    markdownlint-cli2
  ];
}
