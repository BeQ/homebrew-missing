require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class PhpFpm < Formula
  homepage 'http://php.net'
  url 'http://php.net/get/php-5.5.14.tar.bz2/from/this/mirror'
  sha1 '062d351da165aa0568e4d8cbc53a18d73b99f49a'
  version '5.5.14'
  
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
    args = [
      "--prefix=#{prefix}",
      "--mandir=#{man}",
      "--sysconfdir=#{etc}/php/fastcgi",
      "--with-config-file-path=#{etc}/php/fastcgi",
      "--with-config-file-scan-dir=#{etc}/php/fastcgi/ext",
      "--disable-cli",
      "--enable-phar=shared",
      "--enable-session=shared",
      "--with-pcre-regex",
      "--enable-xml=shared",
      "--enable-simplexml=shared",
      "--enable-filter=shared",
      "--disable-debug",
      "--enable-inline-optimization",
      "--disable-static",
      "--enable-shared",
      "--with-pic=shared",
      "--enable-bcmath=shared",
      "--enable-calendar=shared",
      "--enable-ctype=shared",
      "--enable-dom=shared",
      "--enable-exif=shared",
      "--enable-ftp=shared",
      "--enable-mbstring=shared",
      "--enable-mbregex",
      "--enable-xmlreader=shared",
      "--enable-xmlwriter=shared",
      "--enable-pcntl=shared",
      "--enable-shmop=shared",
      "--enable-soap=shared",
      "--enable-sockets=shared",
      "--enable-sysvmsg=shared",
      "--enable-tokenizer=shared",
      "--enable-wddx=shared",
      "--with-zlib=shared",
      "--with-bz2=shared",
      "--with-curl=shared",
      "--with-jpeg-dir=#{HOMEBREW_PREFIX}",
      "--with-png-dir=#{HOMEBREW_PREFIX}",
      "--with-freetype-dir=#{HOMEBREW_PREFIX}",
      #"--with-freetype-dir=/opt/X11",
      #"--with-xpm-dir=/opt/X11",
      "--with-gmp=shared",
      "--enable-hash=shared",
      "--with-iconv=shared",
      "--with-openssl=shared",
      "--enable-json=shared",
      "--with-ldap=shared",
      "--with-ldap-sasl=/usr",
      "--with-zlib-dir=/usr",
      "--with-libedit=shared",
      "--with-mcrypt=shared",
      "--with-pspell=shared",
      "--with-snmp=shared",
      "--with-xmlrpc=shared",
      "--with-xsl=shared",
      "--with-tidy=shared",
      "--with-mysql-sock=/tmp/mysql.sock",
      "--with-mysql=shared,mysqlnd",
      "--with-mysqli=shared,mysqlnd",
      "--enable-pdo",
      "--with-pdo-pgsql=shared,/Applications/Postgres.app/Contents/Versions/9.3/bin",
      "--with-pdo-mysql=shared,mysqlnd",
      "--with-pdo-sqlite=shared",
      "--enable-zip=shared",
      "--enable-inline-optimization",
      "--enable-pcntl=shared",
      "--with-enchant=shared",
      "--with-pear=shared,/srv/.libs/PHP/PEAR",
      "--with-pcre-dir=/usr",
      "--with-gd=shared",
      "--enable-gd-native-ttf",
      "--enable-posix=shared",
      "--enable-fileinfo=shared",
      "--enable-sockets=shared",
      "--enable-opcache=shared",
      "--with-t1lib",
      "--enable-sysvsem=shared",
      "--enable-sysvshm=shared",
      "--enable-sysvmsg=shared",
      "--with-pgsql=shared",
      "--enable-fpm=shared",
      "--with-gettext=shared,#{HOMEBREW_PREFIX}/opt/gettext",
      "--enable-intl=shared,#{HOMEBREW_PREFIX}/opt/gettext",
      "--with-icu-dir=#{HOMEBREW_PREFIX}/opt/icu4c",
      "--enable-mysqlnd",
    ]
    
=begin
=end
    puts 'Set environment:'
    system 'export EXTRA_LIBS="-lstdc++ -lresolv"'
    system 'export MACOSX_DEPLOYMENT_TARGET="10.9"'
    system 'export CFLAGS="-arch x86_64 -g -O3 -pipe -no-cpp-precomp"'
    system 'export CCFLAGS="-arch x86_64 -g -O3 -pipe"'
    system 'export CXXFLAGS="-arch x86_64 -g -O3 -pipe"'
    system 'export LDFLAGS="-arch x86_64 -bind_at_load"'
    system 'export ARCHFLAGS="-arch x86_64"'
    system 'export PATH=/usr/local/mysql/bin:$PATH'

        
    puts "Install PHP #{version} FPM & FastCGI:"
    system './configure', *args
    system 'make install'
  end
  
  def post_install
    puts "Create log directory"
    system "mkdir -p #{prefix}/var/log"
  end
end
