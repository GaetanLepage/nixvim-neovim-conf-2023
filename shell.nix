{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    (rustPlatform.buildRustPackage rec {
      name = "presenterm";
      version = "0.3.0";
      # src = /home/gaetan/temp/presenterm;
      src = fetchFromGitHub {
        owner = "mfontanini";
        repo = "presenterm";
        rev = "refs/tags/v${version}";
        hash = "sha256-uwLVg/bURz2jLAQZgLujDR2Zewu5pcE9bwEBg/DQ4Iw=";
      };

      cargoHash = "sha256-nL2EGbNekOHHXffzWa3KuGTjaAVUDJI91WUK3Fw05rQ=";

      checkFlags = [
        "--skip=execute::test::shell_code_execution"
      ];

      buildInputs = [libsixel];
      cargoBuildFlags = ["--features" "sixel"];
    })
  ];
}
