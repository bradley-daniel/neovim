{
  description = "Flake for my neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    ...
  }:
    utils.lib.eachDefaultSystem (
      system: let
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.${system};

        nvim =
          pkgs.wrapNeovimUnstable (pkgs.neovim-unwrapped)
          (pkgs.neovimUtils.makeNeovimConfig
            {
              customRC = ''
                set runtimepath^=${./.}
                source ${./.}/init.lua
              '';
            }
            // {
              wrapperArgs = [
                "--prefix"
                "PATH"
                ":"
                "${lib.makeBinPath [pkgs.gcc pkgs.nil pkgs.lua-language-server]}"
                # "${lib.makeBinPath [pkgs.gcc pkgs.nil pkgs.lua-language-server pkgs.nodePackages_latest.pyright pkgs.python311Packages.flake8 pkgs.python311Packages.black]}"
              ];
            });
      in {
        overlays = {
          neovim = _: prev: {
            neovim = nvim;
          };
          default = self.overlays.neovim;
        };

        packages = rec {
          neovim = nvim;
          default = neovim;
        };

        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.stylua
            pkgs.alejandra
          ];
        };
      }
    );
}
