{
  # I don't know much about these but they were generated by hardware-configuration.nix
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "sd_mod"
  ];
}