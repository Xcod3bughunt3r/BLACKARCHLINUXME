# [BLACK ARCH LINUX](https://wiki.archlinux.org/index.php/Unofficial\_User\_Repositories).

### Panduan Pengguna :
#### Bagian ini akan menunjukkan kepada Anda cara mempersiapkan repositori BlackArch dan instalasi paket. BlackArch mendukung keduanya, instalasi dari repositori meggunakan paket biner serta kompilasi dan instalasi dari source.

### Instalasi di atas ArchLinux :
#### [Jalankan](https://blackarch.org/strap.sh) strap.sh sebagai root dan ikuti perintah-perintah. Lihat conth berikut.
   * ``curl -O https://blackarch.org/strap.sh``
   * ``sha1sum strap.sh # should match: d062038042c5f141755ea39dbd615e6ff9e23121``
   * ``sudo chmod 777 strap.sh``
   * ``sudo ./strap.sh``

#### Sekarang unduh salinan baru dari daftar paket master dan sinkronisasi paket :
   * ``sudo pacman -Syyu``
   * ``sudo pacman -Syy``

#### Anda sekarang dapat menginstal alat dari repositori BlackArch. Untuk melihat daftar semua alat yang tersedia, jalankan
   * ``sudo pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u``

#### Untuk instalasi semua alat, jalankan
   * ``sudo pacman -S blackarch``

#### Untuk instalasi alat berdasarkan kategori, jalankan
   * ``sudo pacman -S blackarch-category``

#### Untuk melihat kategori blackarch, jalankan
   * ``sudo pacman -Sg | grep blackarch``

### Menginstal paket dari sumber : 
#### Sebagai bagian dari metode instalasi alternatif, Anda dapat membangun BlackArch paket dari sumber. Anda dapat menemukan PKGBUILD [di]({https://github.com/BlackArch/blackarch/tree/master/packages}) github. Untuk membangun seluruh repo, Anda dapat [menggunakan](https://github.com/BlackArch/blackman) slat Blackman.

#### Pertama, Anda harus menginstal Blackman. Jika repositori paket BlackArch sudah diatur pada mesin Anda, Anda dapat menginstal Blackman :
  * ``sudo pacman -S blackman``

#### Anda dapat membangun dan menginstal Blackman dari sumber :
  * ``mkdir blackman``
  * ``cd blackman``
  * ``wget https://raw2.github.com/BlackArch/blackarch/master/packages/blackman/PKGBUILD``

#### Pastikan PKGBUILD tidak dirusak dengan maksud jahat.
  * ``sudo makepkg -s``

#### Atau Anda dapat menginstal Blackman dari AUR :
  * ``pacman`` Or ``yay -S blackman``

### Penggunaan dasar Blackman. 
#### Blackman sangat mudah digunakan, meskipun benderanya berbeda dari Anda biasanya diharapkan dari sesuatu seperti pacman. Penggunaan dasar telah diuraikan di bawah ini. Unduh, kompilasi, dan instal paket :
  * ``sudo blackman -i paket``

#### Unduh, kompilasi, dan instal seluruh kategori :
  * ``sudo blackman -g paket-kelompok``

#### Unduh, kompilasi, dan instal semua alat BlackArch :
  * ``sudo blackman -a``

#### Untuk membuat daftar kategori blackarch :
  * ``sudo blackman -l``

#### Untuk membuat daftar alat katagori :
  * ``sudo blackman -p kategori``

<br>

##### [Wiki Arch Linux :](https://wiki.archlinux.org/index.php/Creating_Packages)
##### [Arch Wiki: Creating Packages](https://wiki.archlinux.org/index.php/Makepkg)
##### [Arch Wiki: makepkg](https://wiki.archlinux.org/index.php/PKGBUILD)
##### [Arch Wiki: PKGBUILD](https://wiki.archlinux.org/index.php/Arch_Packaging_Standardsg)

<br>

### Mengaktifkan multilib
#### Untuk mengaktifkan repositori multilib, batalkan komentar pada [multilib]bagian di /etc/pacman.conf:
   * ``sudo nano /etc/pacman.conf``
````
[multilib]
Include = /etc/pacman.d/mirrorlist
````

#### Kemudian tingkatkan sistem dan instal paket multilib yang diinginkan. Jalankan 
  * ``sudo pacman -Sl multilib``

#### untuk mendaftar semua paket di repositori multilib. Nama paket perpustakaan 32-bit dimulai dengan lib32-.

<br><br><br>

##### [GITHUB BLACK ARCH LINUX :](https://github.com/BlackArch/blackarch/)
##### [REPO :](https://blackarch.org/blackarch/$repo/os/$arch|blackarch)
##### Sebuah HTTP(S) URL yang menunjuk ke file 'lastupdate' pada mirror pilihan Anda.
##### Gunakan URL HTTP(S) dari mirror pilihan Anda.
  * ``lastupdate_url='https://blackarch.org/blackarch/blackarch/lastupdate'``

##### MIRROR BLACKARCH : 
  * ``https://blackarch.org/strap.sh``
  * ``https://blackarch.unixpeople.org/$repo/os/$arch|unixpeople``


