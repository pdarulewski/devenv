{
  description = "zig";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-darwin-x86_64.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    nixpkgs-darwin-x86_64,
    flake-utils,
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
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.zig
            pkgs.zig-zlint
            pkgs.zls
          ];
        };
      }
    );
}
