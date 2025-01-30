{ config, pkgs, ... }:

{
  # Multiple bugs leading to info leak and remote code execution. More info:
  # https://github.com/OpenPrinting/cups-browsed/security/advisories/GHSA-rj88-6mr5-rcw8
  # services.printing.enable = false;
  # Printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
