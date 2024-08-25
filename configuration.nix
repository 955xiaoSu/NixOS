# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  boot.loader = {
	grub = {
		enable = true;
		device = "nodev";
		efiSupport = true;
		extraEntries = ''
			menuentry "Windows" {
				search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
				chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
			}
		'';
		};
	efi = {
		canTouchEfiVariables = true;
		efiSysMountPoint = "/boot";
	};
};
  

  networking = {
	hostName = "nixos"; # Define your hostname.
	networkmanager.enable = true;
  };
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver = {
	enable = true;
	desktopManager.plasma5.enable = true;
  };
  hardware.pulseaudio.enable = true;
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     alacritty
  ];

  nix.settings.substituters = ["https://mirror.sjtu.edu.cn/nix-channels/store"];
  system.stateVersion = "24.05"; # Did you read the comment?
}
