#### How to install packages manual on [Arch Linux](https://averagelinuxuser.com/install-aur-manually-helpers/).

****

#### How to install rpm packages on [Arch Linux](https://www.marcelocubillos.com/blog/how-to-install-rpm-packages-on-arch-linux) or check [rpmtoarch.rb](https://github.com/Xcod3bughunt3r/BLACKARCHLINUXME/blob/master/rpmtoarch.rb).

  * Seve to ````/usr/bin/rpmtoarch ````
  * And install => ````sudo pacman -S ruby rpm-tools````
  * Atau letakkan skrip di direktori yang sama dengan file RPM Anda.
  * Next => ````chmod 777 rpmtoarch.rb````
  * Next => ````sudo ./rpmtoarch.rb {YOUR_RPM}.rpm````
  * Setelah skrip berjalan, maka akan menghasilkan ````sub-direktori```` baru dengan nama yang sama dengan paket RPM. Ambil kepemilikan sub-direktori kemudian ubah direktori ke dalamnya lalu instal paket seperti biasa (misalnya, dengan cara yang sama Anda menginstal paket AUR secara manual).
  * Next => ````sudo chown -R {YOUR_USERNAME} {NAME_OF_PKG_DIR}````
  * Next => ````cd {NAME_OF_PKG_DR}````
  * Next => ````makepkg -s````
  * Next => ````sudo pacman -U {PAKET}.pkg.tar.zst````
    
    
    