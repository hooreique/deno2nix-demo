{
  description = "deno2nix demo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
      ];
      perSystem =
        { pkgs, system, ... }:
        let
          deno2nix-demo = pkgs.callPackage ./package.nix {
            deno2nix = import (pkgs.fetchFromGitHub {
              owner = "aMOPel";
              repo = "deno2nix";
              rev = "adb4dcea663cd61c19e01c8c36dd73db4af358a5";
              hash = "sha256-ZGKHKRB7K5aUIyJenXwOcX21F2yTXLa19q3YXQM3E48=";
            }) { inherit pkgs; };
          };
        in
        {
          packages = {
            inherit deno2nix-demo;
            default = deno2nix-demo;
          };

          devShells.default = pkgs.mkShell {
            packages = [ pkgs.deno ];
          };
        };
    };
}
