{ config, pkgs, ... }:


{
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # default
  };

  # Ensure the necessary system packages are installed
  environment.systemPackages = with pkgs; [
    bluez
    # bluez-utils
    pavucontrol         # Optional: GUI for managing audio
  ];
}


# {
#   # hex-address for known devices
#   # Device CC:98:8B:31:37:8A LE_WH-1000XM3

#   hardware = {
#     pulseaudio.enable = true;
#     pulseaudio.package = pkgs.pulseaudioFull;

#     bluetooth.enable = true;
#     bluetooth.powerOnBoot = true;
#   };

#   systemd.user.services.mpris-proxy = {
#     description = "Mpris proxy";
#     after = [ "network.target" "sound.target" ];
#     wantedBy = [ "default.target" ];
#     serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
#   };
# }
