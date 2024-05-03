{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        home-manager.url = github:nix-community/home-manager;
        flake-utils.url = "github:numtide/flake-utils";
#        stylix = {
#            url = "github:danth/stylix";
#            inputs.nixpkgs.follows = "nixpkgs";
#        };
    };

    outputs = inputs @ { self, nixpkgs, home-manager, flake-utils}: {
            nixosConfigurations.macbook = nixpkgs.lib.nixosSystem {
                system = "aarch64-linux";
                modules =
                    [
                    ./nixos/macbook
                    <apple-silicon-support/apple-silicon-support>
                    ./nixos/home-manager/home.nix
                    #home-manager.nixosModules.home-manager
                    #stylix.nixosModules.stylix
                    ];
            };
            nixosConfigurations.mainPc = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules =
                    [
                    ./nixos/mainPc
                    ./nixos/home-manager/home.nix
                    #home-manager.nixosModules.home-manager
                    ];
            };
        };
}
