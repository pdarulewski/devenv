{
  description = "rust";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin-x86_64.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-darwin-x86_64,
    flake-utils,
    fenix,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs =
          import
          (
            if system == "x86_64-darwin"
            then nixpkgs-darwin-x86_64
            else nixpkgs
          )
          {inherit system;};
        toolchain = fenix.packages.${system}.default.toolchain;
      in {
        formatter = pkgs.nixfmt-tree;
        devShells.default = pkgs.mkShell {
          packages = [
            toolchain
            pkgs.bacon
            pkgs.rust-analyzer
          ];
        };
      }
    );
}
