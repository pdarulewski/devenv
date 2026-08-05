{
  description = "python";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-darwin-x86_64.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    flake-utils.url = "github:numtide/flake-utils";
    python.url = "github:nixos/nixpkgs/ee09932cedcef15aaf476f9343d1dea2cb77e261";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-darwin-x86_64,
    flake-utils,
    ...
  } @ inputs:
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
        formatter = pkgs.nixfmt-tree;
        devShells.default = pkgs.mkShell {
          packages = [
            inputs.python.legacyPackages.${system}.python312
            pkgs.ruff
            pkgs.taplo
            pkgs.ty
            pkgs.uv
          ];
        };
      }
    );
}
