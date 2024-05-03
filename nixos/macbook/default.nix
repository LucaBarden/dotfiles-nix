{ config, lib, pkgs, stylix, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [
      ./hardware-configuration.nix
      ../share/desktop.nix
    ];

  boot.loader.systemd-boot.enable = false;
  #boot.loader.grub.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.kernelParams = [ "apple_dcp.show_notch=1" "quiet" "udev.log_level=3"];
  
  boot.loader.grub = {
   enable = true;
   device = "nodev";
   efiSupport = true;
   enableCryptodisk = true;
  };
  #boot.plymouth.enable = true;
  #stylix.autoEnable = false;
  #stylix.image = pkgs.fetchurl {
  #  url = "https://pbs.twimg.com/media/EDyxVvoXsAAE9Zg.png";
  #  sha256 = "sha256-NRfish27NVTJtJ7+eEWPOhUBe8vGtuTw+Osj5AVgOmM=";
  #};
  #stylix.homeManagerIntegration.autoImport = false;

  #stylix.targets.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  virtualisation.docker.enable = true;





  console.keyMap = "de";


  nix.settings.experimental-features = [ "nix-command" "flakes"];

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
     armcord
     spotify-qt
     spotifyd
     catppuccin-plymouth
  ];
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  
  system.stateVersion = "22.05"; # Did you read the comment?

}

