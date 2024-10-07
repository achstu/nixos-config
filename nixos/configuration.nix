# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/bash.nix
  ];

  boot.loader = {  
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Warsaw";

  # nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable sound.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
  };
  
  # for obsidian
  nixpkgs.config.allowUnfree = true;

   users.users.achstu = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "audio" ];
   };

  environment.systemPackages = with pkgs; [
    (import ./scripts/mvd.nix { inherit pkgs; })
    # essential dev tools
    zip unzip p7zip
    helix
    git tree

    xdg-utils # needed by vscode
    ollama
   
    # cpp dev
    clang clang-tools
    gcc gnumake gdb libcxx

    # rust dev
    cargo rustc
    rustfmt
    rust-analyzer
    cargo-modules

    # python dev
    python3
    virtualenv

    # nix dev
    nil

    # json support
    jq
    
    # audio
    pavucontrol
        
    # desktop apps
    firefox
    kitty
    hyprpaper
    obsidian
    inkscape
    xfce.thunar
    vscode

    # cli tools
    yt-dlp-light
    ffmpeg
    transmission_4
  ];

  programs.hyprland.enable = true;
  programs.firefox.enable = true;


  # Multiple bugs leading to info leak and remote code execution. More info:
  # https://github.com/OpenPrinting/cups-browsed/security/advisories/GHSA-rj88-6mr5-rcw8
  services.printing.enable = false;
  # Printing
  # services.printing.enable = true;
  # services.avahi = {
    # enable = true;
    # nssmdns4 = true;
    # openFirewall = true;
  # };

  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  system.stateVersion = "24.05";
}

