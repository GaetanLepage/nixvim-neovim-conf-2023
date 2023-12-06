{
  description = "Nixvim talk @NeovimConf 2023";

  inputs = {
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
    # nixpkgs = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
    ...
  }: let
    config = import ./nixvim-config.nix; # import the module directly
  in
    flake-utils.lib.eachDefaultSystem (system: let
      nixvimLib = nixvim.lib.${system};
      pkgs = import nixpkgs {inherit system;};
      nixvim' = nixvim.legacyPackages.${system};
      nvim = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        module = config;
        # You can use `extraSpecialArgs` to pass additional arguments to your module files
        # extraSpecialArgs = {
        #   inherit self;
        # };
      };
    in {
      checks = {
        # Run `nix flake check .` to verify that your config is not broken
        default = nixvimLib.check.mkTestDerivationFromNvim {
          inherit nvim;
          name = "A nixvim configuration";
        };
      };

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          (rustPlatform.buildRustPackage {
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
            cargoBuildFlags = ["--features" "sixel"];
          })
        ];
      };

      packages = {
        # Lets you run `nix run .` to start nixvim
        default = nvim;
      };

      formatter = pkgs.alejandra;
    });
}
