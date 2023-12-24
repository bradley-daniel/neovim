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

        runtimeDeps = with pkgs; [
            # Treesitter
            gcc
            
            # LSP/Linters
            nil

            lua-language-server

            # Telescope
            ripgrep

        ];

        nvim = pkgs.wrapNeovimUnstable (pkgs.neovim-unwrapped) (pkgs.neovimUtils.makeNeovimConfig
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
              "${lib.makeBinPath runtimeDeps}"
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
          nativeBuildInputs = with pkgs; [
            alejandra
            git
            stylua
          ];
        };
      }
    );
}
