{ config, ... }:

{

  fileSystems."/mnt/nvme1" =
    { 
      device = "/dev/nvme0n1p7";
      fsType = "auto";
      options = ["nosuid" "nodev" "nofail" "x-gvfs-show"];
    };
  
  fileSystems."/mnt/nvme2" =
    { 
      device = "/dev/nvme0n1p8";
      fsType = "auto";
      options = ["nosuid" "nodev" "nofail" "x-gvfs-show" "uid=1000" "gid=984" "umask=0000"];
    };

  # NTFS 2TB
  fileSystems."/mnt/hdd1" =
    { 
      device = "/dev/disk/by-uuid/1E12792F12790D51";
      fsType = "ntfs-3g";
      options = ["nosuid" "nodev" "nofail" "x-gvfs-show" "uid=1000" "gid=984" "umask=0000"];
    };
  
  # EXT4 0.5 TB 
  fileSystems."/mnt/hdd2" =
    { 
      device = "/dev/disk/by-uuid/d2391530-49e0-42bf-b2dd-cc22b1c43442";
      fsType = "auto";
      options = ["nosuid" "nodev" "nofail" "x-gvfs-show"];
    };

}