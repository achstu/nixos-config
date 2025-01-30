# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/bash.nix
    ./modules/printing.nix
    ./modules/sound.nix
  ];
  
  boot.kernelModules = [ "video" "acpi_video" "bluetooth" ];
  boot.loader = {  
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Warsaw";

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
    helix wget
    git tree rlwrap
    parallel-full
    # busybox
    killall

    xdg-utils # needed by vscode
    # ollama jetbrains-toolbox
    ollama
   
    # cpp dev
    clang clang-tools cmake
    gcc gnumake gdb libcxx nasm

    # rust dev
    cargo rustc
    rustfmt
    rust-analyzer
    cargo-modules

    # latex support
    texliveFull
  
    # python dev
    python3 pypy3
    uv virtualenv

    # ocaml dev
    ocaml
    ocamlPackages.ocamlformat
    ocamlPackages.ocaml-lsp
    ocamlPackages.utop
    dune_3
    opam

   
    # other dev
    sqlite
     
    # nix dev
    nil

    # json support
    jq vscode-langservers-extracted
    yq
    
    # desktop apps
    firefox
    kitty
    obsidian
    inkscape
    xfce.thunar
    vscode-fhs

    # desktop environment
    waybar
    hyprlock
    hypridle
    hyprpaper
    # for other suckmore tools
    xwayland wlroots xdg-desktop-portal-wlr

    # screen shots
    slurp grim

    # gnome DE
    # gnome
    

    # cli tools
    yt-dlp-light
    ffmpeg
    transmission_4
    light
  ];

  # services.xserver.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.displayManager.gdm.enable = false;  # No login manager

  # steam
  # programs.steam = {
    # enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    # localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  # };
  

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    fira-code-nerdfont
    fira
    fira-sans
    fira-math
    
    hack-font
  ];

  # to run code under Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  programs.hyprland.enable = true;
  programs.firefox.enable = true;
  # services.openssh.enable = true;

  system.stateVersion = "24.05";
}
