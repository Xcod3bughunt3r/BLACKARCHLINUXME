## HOW TO INSTALL DRIVERS IN ARCHLINUX.

#### For Nvidia graphics processing unit :
  * ``sudo pacman -S nvidia nvidia-utils``

#### For amd discreet and integrated graphics processing unit :
  * ``sudo pacman -S xf86-video-amdgpu``

#### For intel integrated graphics processing unit :
  * ``sudo pacman -S xf86-video-intel``

<br>

#### ARCH LINUX COMMAND :
  * ``sudo pacman -S paket`` : Install paket
  * ``sudo pacman -R/-Rs paket`` : -R/-Rs hapus paket
  * ``sudo pacman -Syy / Syyu`` : Update/Upgrade Semua Paket
  * ``sudo pacman -Qdtq | pacman -Rs -`` : Autoremove
  * ``sudo pacman -Ss / Qs paket`` : Cari Paket yang ada di database.
  * ``sudo pacman -Sy / -Syu paket`` : Update Paket
  * ``sudo pacman -Si paket`` : Informasi Paket
  * ``sudo pacman -namapaket Qi / Qii`` : Paket lokal
  * ``sudo pacman -Scc`` : hapus semua file cache
  * ``sudo pacman -Sw paket`` : Unduh tanpa di.install
  * ``sudo pacman -U`` : Install paket yg di unduh
  * ``sudo pacman -Qe / Qd`` : info paket
  * ``sudo pacman -Fy`` : Sinkron file dari database

<br>

#### How To Install Packages Using a Helper / yay :
  * ``sudo pacman -S git``
  * ``git clone https://aur.archlinux.org/yay.git && cd yay``
  * ``makepkg -si``
  * ``yay -S visual-studio-code-bin`` : Instaall Paket

<br>

#### YAY COMMAND :
  * ``yay -S [--noconfirm] <paket>`` : Instal paket
  * ``yay -Ss <paket>`` : Cari paket
  * ``yay -Si <paket>`` : Informasi paket
  * ``yay -U`` : jalan Instal paket lokal
  * ``yay -paket Qq`` : Daftar semua paket
  * ``yay -Qm`` : Daftar paket non-resmi
  * ``yay -Pu`` : Daftar paket yang perlu diperbarui
  * ``yay -R <paket>`` : Hapus paket
  * ``yay -Rnsc <paket>`` : Hapus paket, dependensi, dan konfigurasi
  * ``yay -Sya`` : Perbarui sistem

<br>

#### More Information :
  * ``uname`` : Kernel name
  * ``uname -v`` : Kernel version
  * ``lscpu`` : List CPU information
  * ``neofetch`` : Arch Linux system information
  * ``hwinfo`` : All hardware information
  * ``lspci`` : List PCI
  * ``lsusb`` : List USB
  * ``fdisk -l`` : List disk partitions
  * ``top`` : System processes monitoring
  * ``inxi -G`` : List installed drivers
  * ``ls`` : mencari
  * ``ls -a`` : Show all
  * ``ls -R`` : Recursive list
  * ``ls -S`` : Sort by size
  * ``ls -l`` : Long listing
  * ``ls -d`` : Only directories
  * ``ls -a`` : Hidden files/directories
  * ``ls -lias`` : Full listing

<br>

#### PACMAN COMMAND :
  * ``pacman -Syu`` : update system
  * ``pacman -Q`` : list installed packages
  * ``pacman -Qdtq`` : list packages no longer required by others
  * ``pacman -Qs <name>`` : search installed packages
  * ``pacman -Ss <name>`` : search packages
  * ``pacman -S <name>`` : install packages
  * ``pacman -Rns <name>`` : remove package, its dependencies and config file backups
  * ``pacman -Sc`` : clean old packages in cache

<br>

#### SYSTEMD :
  * unit files : ``/usr/lib/systemd/system/`` or ``/etc/systemd/system/``
  * ``systemctl`` : list running units
  * ``systemctl status <unit>`` : check status
  * ``systemctl start/stop <unit>`` : start/stop a service
  * ``systemctl enable/disable <unit>`` : enable/disable a service at bootup
  * ``systemctl daemon-reload`` : reload systemd

<br>

#### Manual install of AUR packages :
  * ``pacman -Sy`` : update repositories
  * ``curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz`` : grab the package
  * ``tar xzvf package.tar.gz`` : untar package
  * ``cd <package>`` : change into package directory
  * ``makepkg -si`` : build and install
  * ``archlinux-java status`` : check status
  * ``archlinux-java set <version>`` : set default version

