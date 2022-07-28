#!/usr/bin/env ruby

#// The MIT License (MIT).
#// Copyright (c) 2022 ALIF-FUSOBAR (Xcod3bughunt3r).

require "fileutils"

class Package
  FILTERED_PARTS = %w[rpm x86_64]

  INSTALL_SECTIONS = %w[pre_install post_install pre_upgrade
                        post_upgrade pre_remove post_remove].freeze

  RPM_INSTALL_SECTIONS = %w[preinstall postinstall preupgrade
                            postupgrade preuninstall postuninstall].freeze

  attr_accessor :path_to_rpm, :pwd

  def initialize(path_to_rpm)
    @path_to_rpm = path_to_rpm
    @pwd = Dir.pwd
  end

  def run
    create_dir
    copy_rpm_file
    create_pkgbuild
    scripts = extract_scripts
    create_install_script(scripts)
    # Extract install scripts from rpm
    # Create install script
  end

  def pkgbuild
    <<-PKGBUILD.gsub(/\ {6}/, "")
      pkgname=#{package_name}
      pkgver=unknown
      pkgrel=1
      epoch=
      pkgdesc=""
      arch=("x86_64")
      url=""
      license=('Unknown')
      groups=()
      depends=()
      makedepends=()
      checkdepends=()
      optdepends=()
      provides=()
      conflicts=()
      replaces=()
      backup=()
      options=()
      install="#{package_name}.install"
      changelog=
      source=()
      noextract=()
      md5sums=()
      validpgpkeys=()

      prepare() {
        cp ../#{rpm_basename} $srcdir/
      }

      package() {
        rpm2cpio #{rpm_basename} | cpio -idmv -D $pkgdir/
      }
    PKGBUILD
  end

  def extract_scripts
    Dir.chdir(package_name)
    rpm_scripts = %x(rpm -qp --scripts #{rpm_basename})
    rpm_scripts = rpm_scripts.encode!("UTF-8", "UTF-8", invalid: :replace)
    Dir.chdir(pwd)
    parse_blocks(rpm_scripts)
  end

  def parse_blocks(rpm_scripts)
    current_block = nil
    rpm_scripts.split("\n").each_with_object({}) do |line, blocks|
      if section = find_section_in_line(line)
        blocks[section] = []
        current_block = blocks[section]
      elsif current_block
        current_block << line
      end
    end
  end

  def find_section_in_line(line)
    RPM_INSTALL_SECTIONS.each_with_index do |section, idx|
      return INSTALL_SECTIONS[idx] if line =~ /#{section}/
    end && nil
  end

  def create_install_script(scripts)
    File.open(install_script_path, "w") do |f|
      install_script = scripts.map do |function_name, code|
        <<-CODE.gsub(/\ {8}/, "")

        #{function_name}() {

        #{code.join("\n")}

        }

        CODE
      end.join("\n")
      f.write(install_script)
    end
  end

  def create_pkgbuild
    File.open(pkgbuild_path, "w") do |f|
      f.write(pkgbuild)
    end
  end

  def copy_rpm_file
    FileUtils.cp(rpm_basename, "#{package_name}/")
  end

  def create_dir
    Dir.mkdir(package_name) unless Dir.exists?(package_name)
  end

  def rpm_basename
    @_rpm_basename ||= File.basename(@path_to_rpm)
  end

  def install_script_path
    "#{package_name}/#{package_name}.install"
  end

  def pkgbuild_path
    "#{package_name}/PKGBUILD"
  end

  def package_name
    @_package_name ||= begin
      rpm_basename.split(".").reject do |p|
        FILTERED_PARTS.include?(p.to_s)
      end.join("_")
    end
  end
end

package = Package.new(ARGV[0])

puts "Basename: #{package.rpm_basename}"
puts "Package_name: #{package.package_name}"
puts "RUN: #{package.run}"

#// The MIT License (MIT).
#// Copyright (c) 2022 ALIF-FUSOBAR (Xcod3bughunt3r).
