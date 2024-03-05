Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A115AC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV9O-0002t2-26; Tue, 05 Mar 2024 08:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhV98-0002hy-6r
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhV8y-0004zN-8a
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709646463;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2idW8IV7hyHW9hEMqnu+ZCLQv9RRHgUm4zdzxZFVXKM=;
 b=M+EuGDLZHv/2PMJUC2HcCuvVp8/ko3gBkhaVicSQPwIlFYlgM2xVy9DeytDgyYLE7jax3n
 yOtpyPXjvooKT3A/uaGAxKg+wH6Pqi8Y7p9poeDEC6AQpI0eQAJOUC9yMDp9uRmCh0pmrr
 d2f/UVkANa1H1T3toAaj0j2DMMSNrYo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-4tqRHRB9NwS1nhx_4F1zjw-1; Tue,
 05 Mar 2024 08:47:41 -0500
X-MC-Unique: 4tqRHRB9NwS1nhx_4F1zjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A49063C02449;
 Tue,  5 Mar 2024 13:47:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BEA7C04122;
 Tue,  5 Mar 2024 13:47:38 +0000 (UTC)
Date: Tue, 5 Mar 2024 13:47:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tyler Fanelli <tfanelli@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 stefanha@redhat.com, philmd@linaro.org, marcandre.lureau@gmail.com
Subject: Re: [RFC PATCH v2 1/9] Add Rust SEV library as subproject
Message-ID: <ZecieNcFinT76L0k@redhat.com>
References: <20231004203418.56508-1-tfanelli@redhat.com>
 <20231004203418.56508-2-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231004203418.56508-2-tfanelli@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 04, 2023 at 04:34:10PM -0400, Tyler Fanelli wrote:
> The Rust sev library provides a C API for the AMD SEV launch ioctls, as
> well as the ability to build with meson. Add the Rust sev library as a
> QEMU subproject with the goal of outsourcing all SEV launch ioctls to C
> APIs provided by it.
> 
> Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
> ---
>  meson.build                   | 8 ++++++++
>  meson_options.txt             | 2 ++
>  scripts/meson-buildoptions.sh | 3 +++
>  subprojects/sev.wrap          | 6 ++++++
>  target/i386/meson.build       | 2 +-
>  5 files changed, 20 insertions(+), 1 deletion(-)
>  create mode 100644 subprojects/sev.wrap
> 
> diff --git a/meson.build b/meson.build
> index 20ceeb8158..8a17c29de8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -960,6 +960,13 @@ if not get_option('slirp').auto() or have_system
>    endif
>  endif
>  
> +sev = not_found
> +if not get_option('sev').auto()
> +  sev = dependency('sev',
> +                   method: 'pkg-config',
> +                   required: get_option('sev'))
> +endif
> +

I've revisited this series and tested it now. As Stefan already
mentioned, this logic is flawed.

Currently QEMU is self-contained for SEV support. If we swap to the
sev crate, then we introduce libsev.so as a build time system library
dependancy, and it is highly unlikely that many existing distros will
add the package. IOW we'll cause a regression for users.

Thus we need to be able to *statically* link to the sev crate when it
is not available in the system.

I had a crack at changing this patch to support that and came up with
this diff on top of your patch here:

diff --git a/meson.build b/meson.build
index 1beb9e9f40..d6aba3fd7d 100644
--- a/meson.build
+++ b/meson.build
@@ -1116,12 +1116,6 @@ if not get_option('slirp').auto() or have_system
   endif
 endif
 
-sev = not_found
-if not get_option('sev').auto()
-  sev = dependency('sev',
-                   method: 'pkg-config',
-                   required: get_option('sev'))
-endif
 
 vde = not_found
 if not get_option('vde').auto() or have_system or have_tools
@@ -3003,6 +2997,7 @@ ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
 fdt_required = []
+sev_required = []
 foreach target : target_dirs
   config_target = { 'TARGET_NAME': target.split('-')[0] }
   if target.endswith('linux-user')
@@ -3124,6 +3119,9 @@ foreach target : target_dirs
     foreach k, v: config_devices
       config_devices_data.set(k, 1)
     endforeach
+    if 'CONFIG_SEV' in config_devices
+        sev_required += target
+    endif
     config_devices_mak_list += config_devices_mak
     config_devices_h += {target: configure_file(output: target + '-config-devices.h',
                                                 configuration: config_devices_data)}
@@ -3206,6 +3204,39 @@ if have_libvduse
   libvduse = libvduse_proj.get_variable('libvduse_dep')
 endif
 
+sev = not_found
+sev_opt = get_option('sev')
+if sev_required.length() > 0 or sev_opt == 'enabled'
+  if sev_opt == 'disabled'
+    error('sev disabled but required by targets ' + ', '.join(fdt_required))
+  endif
+
+  if sev_opt in ['enabled', 'auto', 'system']
+      if get_option('wrap_mode') == 'nodownload'
+          sev_opt = 'system'
+      endif
+      sev = dependency('sev',
+                       method: 'pkg-config',
+                       required: sev_opt == 'system')
+      if sev.found()
+          sev_opt = 'system'
+      elif sev_opt == 'system'
+          error('system libsev requested')
+      else
+          sev_opt = 'internal'
+          sev = not_found
+      endif
+  endif
+  if not sev.found()
+      assert(sev_opt == 'internal')
+      libsev_proj = subproject('sev', required: true,
+                               default_options: ['default_library=static'])
+      sev = libsev_proj.get_variable('sev_dep')
+  endif
+else
+  sev_opt = 'disabled'
+endif
+
 #####################
 # Generated sources #
 #####################
@@ -4453,7 +4484,7 @@ summary_info += {'libudev':           libudev}
 # Dummy dependency, keep .found()
 summary_info += {'FUSE lseek':        fuse_lseek.found()}
 summary_info += {'selinux':           selinux}
-summary_info += {'sev':               sev}
+summary_info += {'sev support':       sev_opt == 'disabled' ? false : sev_opt}
 summary_info += {'libdw':             libdw}
 if host_os == 'freebsd'
   summary_info += {'libinotify-kqueue': inotify}
diff --git a/meson_options.txt b/meson_options.txt
index 749fc87fd7..405d1abfd4 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -208,8 +208,6 @@ option('sdl_image', type : 'feature', value : 'auto',
        description: 'SDL Image support for icons')
 option('seccomp', type : 'feature', value : 'auto',
        description: 'seccomp support')
-option('sev', type : 'feature', value : 'auto',
-        description: 'Rust AMD SEV library')
 option('smartcard', type : 'feature', value : 'auto',
        description: 'CA smartcard emulation support')
 option('snappy', type : 'feature', value : 'auto',
@@ -313,6 +311,9 @@ option('capstone', type: 'feature', value: 'auto',
 option('fdt', type: 'combo', value: 'auto',
        choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
        description: 'Whether and how to find the libfdt library')
+option('sev', type: 'combo', value: 'auto',
+       choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
+       description: 'Whether and how to find the libsev library')
 
 option('selinux', type: 'feature', value: 'auto',
        description: 'SELinux support in qemu-nbd')




The caveat is that this does not actually work because the way the
meson rules in the sev crate are written prevents building it as a
static library:

$ cd sev
$ meson build -Ddefault_library=static
The Meson build system
Version: 1.2.3

...snip...

src/meson.build:18:6: ERROR: Cannot link_whole a custom or Rust target 'libsev.a' into a static library 'sev'. Instead, pass individual object files with the "objects:" keyword argument if possible.


The problem is that it is running 'cargo-build.sh' to compile the
SEV crate, which creates a libsev.a static library. It is then
using that as an input to "library('sev',....)" which will also
want to create a new static library with the contents of the first
static library. Never mind that the 2nd library will also be called
libsev.so, meson simply doesn't support linking static libraries
into static libraries AFAICT. There's an open RFE for it that has
no recent attention.


I observe, however, that if cargo-build.sh has already created a
libsev.a static library, then there's no need to tell meson to
create another static library from that. We should be able to use
the first libsev.a directly.

So I tried this change to the 'sev' crate:

diff --git a/meson.build b/meson.build
index 2bf68c3..915ebfb 100644
--- a/meson.build
+++ b/meson.build
@@ -16,5 +16,10 @@ subdir('docs')
 subdir('include')
 subdir('src') # requires: include
 
-sev_dep = declare_dependency(include_directories: inc,
-                             link_with: lib)
+if get_option('default_library') != 'static'
+  sev_dep = declare_dependency(include_directories: inc,
+                               link_with: libsev_so)
+else
+  sev_dep = declare_dependency(include_directories: inc,
+                               link_with: libsev_a)
+endif
diff --git a/src/meson.build b/src/meson.build
index 30bfe49..0632303 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -2,25 +2,27 @@ cargo_build = find_program('cargo-build.sh')
 
 v = meson.project_version().split('.')
 
-staticlib_name = 'libsev.a'
+libsev_a_name = 'libsev.a'
 
-staticlib_target = custom_target(staticlib_name,
+libsev_a = custom_target(libsev_a_name,
   build_by_default : true,
   build_always_stale : true,
   command : [cargo_build, get_option('debug').to_string(),
              get_option('optimization'), meson.current_build_dir() / 'target',
              '@OUTPUT@'],
   console : true,
-  output : [staticlib_name])
+  output : [libsev_a_name])
 
 math = meson.get_compiler('c').find_library('m', required: true)
 
-lib = library('sev',
-  link_whole: staticlib_target,
-  dependencies: [math],
-  install: true,
-  soversion: meson.project_version())
-
+if get_option('default_library') != 'static'
+  libsev_so = shared_library('sev',
+    link_whole: libsev_a,
+    dependencies: [math],
+    install: true,
+    soversion: meson.project_version())
+endif
+  
 # generate pkg-config file
 
 import('pkgconfig').generate(libraries : ['-lsev'],


It is a little bit gross, but it seems to work making it possible to
static link to the sev crate from QEMU with my QEMU patch earlier.


Now, the second issue is that my patch to QEMU's meson.build where
I look for "CONFIG_SEV" is wrong. I've not tested whether it behaves
correctly on non-x86 hosts - basically I'm hoping that CONFIG_SEV is
*NOT* present if building qemu-system-x86_64 on an aarch64 host.

Assuming we get this logic correct though, this unblocks one issue
with getting this merged - Rust platform support.

We've said we want Rust platform support to be a match for QEMU's
platform support. We're probably pretty close, but still it is a
review stumbling block.

If, however, we demonstrate that we /only/ try to use libsev crate
when building on an x86_64 host, then we don't need to think about
Rust platform support in any detail. We know Rust is fully supported
on x86_64 on Linux, and we're not introducing any Rust dependency
for QEMU on other build target arches.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


