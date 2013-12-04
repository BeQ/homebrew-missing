require 'formula'

class Cherokee < Formula
  homepage 'http://cherokee-project.com/'
  url 'http://pkgs.fedoraproject.org/repo/pkgs/cherokee/cherokee-1.2.103.tar.gz/527b3de97ef9727bfd5f6832043cf916/cherokee-1.2.103.tar.gz'
  sha1 '8af2b93eb08f3719d21c7ae8fd94b9a99fb674c0'

  head do
    url 'https://github.com/cherokee/webserver.git'

    depends_on :autoconf
    depends_on :automake
    depends_on :libtool
    depends_on 'wget' => :build
  end

  depends_on 'gettext'

  def install
    if build.head?
      ENV['LIBTOOL'] = 'glibtool'
      ENV['LIBTOOLIZE'] = 'glibtoolize'
      cmd = './autogen.sh'
    else
      cmd = './configure'
    end

    system cmd, "--disable-dependency-tracking",
                "--prefix=#{prefix}",
                "--sysconfdir=#{etc}",
                "--localstatedir=#{var}/cherokee",
                "--with-wwwuser=#{ENV['USER']}",
                "--with-wwwgroup=staff",
                "--enable-internal-pcre",
                # Don't install to /Library
                "--with-wwwroot=/srv/www/localhost"
    system "make install"

    prefix.install "org.cherokee.webserver.plist"
    (prefix+'org.cherokee.webserver.plist').chmod 0644
    (share+'cherokee/admin/server.py').chmod 0755
  end

  def caveats
    <<-EOS.undent
      Cherokee is setup to run with your user permissions as part of the
      'staff' group on port 80. This can be changed in the cherokee-admin
      but be aware the new user will need permissions to write to:
        #{var}/cherokee
      for logging and runtime files.

      By default, documents will be served out of:
        /srv/www/localhost

       If this is your first install, automatically load on startup with:
          sudo cp #{prefix}/org.cherokee.webserver.plist /Library/LaunchDaemons
          sudo launchctl load -w /Library/LaunchDaemons/org.cherokee.webserver.plist

      If this is an upgrade and you already have the plist loaded:
          sudo launchctl unload -w /Library/LaunchDaemons/org.cherokee.webserver.plist
          sudo cp #{prefix}/org.cherokee.webserver.plist /Library/LaunchDaemons
          sudo launchctl load -w /Library/LaunchDaemons/org.cherokee.webserver.plist
    EOS
  end
end

__END__
diff --git a/admin/SystemStats.py b/admin/SystemStats.py
index 2f93e5c..62358e3 100644
--- a/admin/SystemStats.py
+++ b/admin/SystemStats.py
@@ -97,7 +97,11 @@ class System_stats__Darwin (Thread, System_stats):
         self._page_size = int (re.findall("page size of (\d+) bytes", line)[0])
 
         first_line = self.vm_stat_fd.stdout.readline()
-        if 'spec' in first_line:
+        if 'comprs' in first_line:
+            # OSX 10.9, https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/vm_stat.1.html
+            # free active specul inactive throttle wired prgable faults copy 0fill reactive purged file-backed anonymous cmprssed cmprssor dcomprs comprs pageins pageout swapins swapouts
+            self.vm_stat_type = 22
+        elif 'spec' in first_line:
             # free active spec inactive wire faults copy 0fill reactive pageins pageout
             self.vm_stat_type = 11
         else:
@@ -173,7 +177,11 @@ class System_stats__Darwin (Thread, System_stats):
         tmp = filter (lambda x: x, line.split(' '))
         values = [(to_int(x) * self._page_size) / 1024 for x in tmp]
 
-        if self.vm_stat_type == 11:
+        if self.vm_stat_type == 22:
+            # free active specul inactive throttle wired prgable faults copy 0fill reactive purged file-backed anonymous cmprssed cmprssor dcomprs comprs pageins pageout swapins swapouts
+            free, active, spec, inactive, throttle, wired, prgable, faults, copy, fill, reactive, purged, filebacked, anonymous, cmprssed, cmprssor, dcomprs, comprs, pageins, pageout, swapins, swapouts = values
+            self.mem.total = free + active + spec + inactive + wired
+        elif self.vm_stat_type == 11:
             # free active spec inactive wire faults copy 0fill reactive pageins pageout
             free, active, spec, inactive, wired, faults, copy, fill, reactive, pageins, pageout = values
             self.mem.total = free + active + spec + inactive + wired