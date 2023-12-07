{
  description = "Nixvim talk @NeovimConf 2023";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = {
    nixpkgs,
    nixvim,
    flake-parts,
    ...
  } @ inputs: let
    config = import ./nixvim-config.nix; # import the module directly
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        presenterm = with pkgs;
          rustPlatform.buildRustPackage {
            name = "presenterm";
            version = "0.3.0";
            src = fetchFromGitHub {
              owner = "mfontanini";
              repo = "presenterm";
              rev = "33e48fc0086b226bab9c5a8a076022c51303f626";
              hash = "sha256-gPJkG3fJXc7YIiWNv6TxtCeTqkHX2yoWPsXUbkgeh5o=";
            };

            cargoHash = "sha256-H+DNQs30twrVEumJqA8GZrcdyiPVEGTLRZFLFfmADK8=";

            checkFlags = [
              "--skip=execute::test::shell_code_execution"
            ];

            buildInputs = [libsixel];
            buildFeatures = ["sixel"];
          };

        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};
        nvim = nixvim'.makeNixvimWithModule {
          inherit pkgs;
          module = config;
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            presenterm
          ];
        };
        packages = {
          # Lets you run `nix run .` to start nixvim
          default = nvim;
          slides = pkgs.writeShellApplication {
            name = "slides";
            runtimeInputs = [presenterm];
            text = ''
              cd ${./.}
              presenterm slides.md
            '';
          };
        };

        formatter = pkgs.alejandra;

        checks = {
          # Run `nix flake check .` to verify that your config is not broken
          default = nixvimLib.check.mkTestDerivationFromNvim {
            inherit nvim;
            name = "A nixvim configuration";
          };
        };
      };
    };
}
