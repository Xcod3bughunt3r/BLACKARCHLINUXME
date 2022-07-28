#!/bin/sh
#!/usr/bin/bash
#!/root/bin/bash
clear
sleep 3
echo "# strap.sh - install and setup BlackArch Linux keyring"
sleep 1
echo "# mirror file to fetch and write"
MIRROR_F="blackarch-mirrorlist"

# simple error message wrapper
err()
{
  echo >&2 "$(tput bold; tput setaf 1)[-] ERROR: ${*}$(tput sgr0)"

  exit 1337
}

# simple warning message wrapper
warn()
{
  echo >&2 "$(tput bold; tput setaf 1)[!] WARNING: ${*}$(tput sgr0)"
}

# simple echo wrapper
msg()
{
  echo "$(tput bold; tput setaf 2)[+] ${*}$(tput sgr0)"
}

# check for root privilege
check_priv()
{
  if [ "$(id -u)" -ne 0 ]; then
    err "you must be root.!"
  fi
}

# make a temporary directory and cd into
make_tmp_dir()
{
  tmp="$(mktemp -d /tmp/blackarch_strap.XXXXXXXX)"

  trap 'rm -rf $tmp' EXIT

  cd "$tmp" || err "Could not enter directory $tmp"
}

set_umask()
{
  OLD_UMASK=$(umask)

  umask 0022

  trap 'reset_umask' TERM
}

reset_umask()
{
  umask $OLD_UMASK
}

check_internet()
{
  tool='curl'
  tool_opts='-s --connect-timeout 5'

  if ! $tool $tool_opts https://blackarch.org/ > /dev/null 2>&1; then
    err "You don't have an Internet connection.!"
  fi

  return $SUCCESS
}

# retrieve the BlackArch Linux keyring
fetch_keyring()
{
  curl -s -O \
  'https://www.blackarch.org/keyring/blackarch-keyring.pkg.tar.xz'

  curl -s -O \
  'https://www.blackarch.org/keyring/blackarch-keyring.pkg.tar.xz.sig'
}

# verify the keyring signature
# note: this is pointless if you do not verify the key fingerprint
verify_keyring()
{
  if ! gpg --keyserver keyserver.ubuntu.com \
     --recv-keys 4345771566D76038C7FEB43863EC0ADBEA87E4E3 > /dev/null 2>&1
  then
    if ! gpg --keyserver hkps://keyserver.ubuntu.com:443 \
       --recv-keys 4345771566D76038C7FEB43863EC0ADBEA87E4E3 > /dev/null 2>&1
    then
      if ! gpg --keyserver hkp://pgp.mit.edu:80 \
         --recv-keys 4345771566D76038C7FEB43863EC0ADBEA87E4E3 > /dev/null 2>&1
      then
        err "Could not verify the key. Please check: https://blackarch.org/faq.html"
      fi
    fi
  fi

  if ! gpg --keyserver-options no-auto-key-retrieve \
    --with-fingerprint blackarch-keyring.pkg.tar.xz.sig > /dev/null 2>&1
  then
    err "Invalid keyring signature. Please stop by https://matrix.to/#/#/BlackaArch:matrix.org"
  fi
}

# delete the signature files
delete_signature()
{
  if [ -f "blackarch-keyring.pkg.tar.xz.sig" ]; then
    rm blackarch-keyring.pkg.tar.xz.sig
  fi
}

# make sure /etc/pacman.d/gnupg is usable
check_pacman_gnupg()
{
  pacman-key --init
}

# install the keyring
install_keyring()
{
  if ! pacman --config /dev/null --noconfirm \
    -U blackarch-keyring.pkg.tar.xz ; then
      err 'Keyring installation failed'
  fi

  # just in case
  pacman-key --populate
}

# ask user for mirror
get_mirror()
{
  mirror_p="/etc/pacman.d"
  mirror_r="https://blackarch.org"

  msg "Fetching new mirror list..."
  if ! curl -s "$mirror_r/$MIRROR_F" -o "$mirror_p/$MIRROR_F" ; then
    err "We couldn't fetch the mirror list from: $mirror_r/$MIRROR_F"
  fi

  msg "You can change the default mirror under $mirror_p/$MIRROR_F"
}

# update pacman.conf
update_pacman_conf()
{
  # delete blackarch related entries if existing
  sed -i '/blackarch/{N;d}' /etc/pacman.conf

  cat >> "/etc/pacman.conf" << EOF
[blackarch]
Include = /etc/pacman.d/$MIRROR_F
EOF
}

# synchronize and update
pacman_update()
{
  if pacman -Syy; then
    return $SUCCESS
  fi

  warn "Synchronizing pacman has failed. Please try manually: pacman -Syy"

  return $FAILURE
}


pacman_upgrade()
{
  echo 'Perform full system upgrade? (pacman -Su) [Yn]:'
  read conf < /dev/tty
  case "$conf" in
    ''|y|Y) pacman -Su ;;
    n|N) warn 'Some blackarch packages may not work without an up-to-date system.' ;;
  esac
}

# setup blackarch linux
blackarch_setup()
{
  check_priv
  msg 'Installing Blackarch Keyring...'
  set_umask
  make_tmp_dir
  check_internet
  fetch_keyring
  verify_keyring
  delete_signature
  check_pacman_gnupg
  install_keyring
  echo
  msg 'Keyring Installed Successfully'
  # check if pacman.conf has already a mirror
  if ! grep -q "\[blackarch\]" /etc/pacman.conf; then
    msg 'configuring pacman'
    get_mirror
    msg 'updating pacman.conf'
    update_pacman_conf
  fi
  msg 'updating package databases'
  pacman_update
  reset_umask
  msg 'BlackArch Linux is ready!'
}

blackarch_setup