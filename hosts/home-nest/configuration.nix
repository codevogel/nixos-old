{ ... }:

{
  imports = [
    ../shared.nix
    ./hardware-configuration.nix
    ../../modules/home-nest/system/nvidia.nix
    ../../modules/home-nest/system/networking.nix

    ../../modules/home-nest/system/home-manager.nix
  ];
}
