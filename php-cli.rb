require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class PhpCli < Formula
  homepage 'http://php.net'
  url 'http://php.net/get/php-5.6.0.tar.bz2/from/this/mirror'
  sha1 '4ab8ddc1b33abd87bcfd148553f4558697dbe719'
  version '5.6.0'
  
  depends_on :autoconf
  depends_on :automake
  depends_on 'wget' => :build
  depends_on 'imagemagick'
  depends_on 't1lib'
  depends_on 'jpeg'
  depends_on 'libpng'
  depends_on 'mcrypt'
  depends_on 'gettext'
  depends_on 'gmp'
  depends_on 'aspell' => %w{with-lang-en with-lang-ru with-lang-uk}
  depends_on 'pkg-config'
  depends_on 'enchant'
  depends_on 'icu4c'
  depends_on 'readline'
  depends_on 'intltool'
  depends_on 'libevent'
  depends_on 'imap-uw'

  def install  
=begin
=end
    puts "Install PHP #{version} CLI:"
    system './configure',
                "--prefix=#{prefix}",
                "--mandir=#{man}",
                "--sysconfdir=#{etc}/php/cli",
                "--with-config-file-path=#{etc}/php/cli",
                "--with-config-file-scan-dir=#{etc}/php/cli/ext",
                "--disable-cgi",
                "--enable-mysqlnd",
                "--with-readline=shared,#{HOMEBREW_PREFIX}/opt/readline"
    system 'make install'
    
=begin
    puts "Install Xdebug:"
    system 'pecl install xdebug'
=end
  end
end
