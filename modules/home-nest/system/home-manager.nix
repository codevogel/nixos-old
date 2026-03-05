{ self, inputs, ... }:

{
  home-manager = {
    users = {
      "codevogel" = {
        imports = [
          ../home/home.nix
        ];
      };
    };
  };
}
