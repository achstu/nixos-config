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
  
  boot.kernelModules = [ "video" "acpi_video" ];
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
  # for obsidian
  nixpkgs.config.allowUnfree = true;
  
  users.users.achstu = {
    # shell = pkgs.bash;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

  environment.systemPackages = with pkgs; [
    (import ./scripts/mvd.nix { inherit pkgs; })
    # essential dev tools
    zip unzip p7zip
    helix wget
    git tree rlwrap

    xdg-utils # needed by vscode
    ollama jetbrains-toolbox
   
    # cpp dev
    clang clang-tools cmake
    gcc gnumake gdb libcxx nasm

    # beacause why not    
    jetbrains-toolbox

    # rust dev
    cargo rustc
    rustfmt
    rust-analyzer
    cargo-modules


    # python dev
    python3
    # uv
    # poetry
    # jupyter-all
    # python312Packages.jupyterlab
    # virtualenv
    # python312Packages.python-lsp-server
    # pypy3
    # pypy310

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
    jq
    vscode-langservers-extracted # html/css/json lsp
    
    # audio
    pavucontrol
        
    # desktop apps
    firefox
    kitty

    # handwriten and digital notes
    obsidian
    inkscape
    # xournalpp
    
    xfce.thunar
    vscode-fhs

    # desktop
    waybar
    hyprlock
    hypridle
    hyprpaper
    # for other suckmore tools
    xwayland wlroots xdg-desktop-portal-wlr
    
    light

    # cli tools
    yt-dlp-light
    ffmpeg
    transmission_4
  ];

  fonts.packages = with pkgs; [
    dejavu_fonts
    
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

