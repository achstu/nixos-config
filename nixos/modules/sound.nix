{ config, pkgs, ... }:

{
  # hex-address for known devices
  # Device CC:98:8B:31:37:8A LE_WH-1000XM3
  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
}

# old config
# TODO cleanup

  # Enable sound.
  # sound.enable = true;
  # security.rtkit.enable = true;
  # services.pipewire = {
    # enable = true;

    # alsa.enable = true;
    # alsa.support32Bit = true;

    # pulse.enable = true;
  # };
