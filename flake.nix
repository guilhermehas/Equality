{
  description = "Equality";

  inputs.flake-utils.url = github:numtide/flake-utils;

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs { inherit system; };
        agda-p = pkgs.agda.withPackages (p: with p; [ cubical ]);
        name = "Equality";
    in rec {
      packages.${name} = with pkgs;
        stdenv.mkDerivation {
            name = name;
            src = ./.;
            buildInputs = [
              agda-p
            ];
          };
      defaultPackage = packages.${name};
    });
}
