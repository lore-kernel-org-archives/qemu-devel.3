Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9C4CEFC5D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syTHX-00017N-Iw; Wed, 09 Oct 2024 05:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHO-00014W-7H
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHL-0008QY-Eb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728467206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VlwmpVy2w/QD9YP3xzNOkfTQnvqr8zW8EiRH1TOvN34=;
 b=UEfy8TUOxsY16fj1PGUQ8hbJqRxiRZotTH945At9ZbAmLi9hOjr0uTu2jRUyL5WHxdVP67
 qhUkauE+xMOAaHle5qVA3eK86bUkjnZwNm+mgShJ2JH3GUedus6w8Jet3cwctb3qQHEuKP
 icf6gQIs3Kxwrm6qphw8h7ccRH9Lig4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-w_u1qvZHNPWfHrh45XuboA-1; Wed, 09 Oct 2024 05:46:38 -0400
X-MC-Unique: w_u1qvZHNPWfHrh45XuboA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43057565db5so3916695e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467196; x=1729071996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlwmpVy2w/QD9YP3xzNOkfTQnvqr8zW8EiRH1TOvN34=;
 b=bPRXz2s+2FdpkecId9PeGAVEuANFpF5j33iTvYoPPzEvxVpsTgfXToXQtAkxxvGPjG
 coin1qtHfkxfGRZGmkCihn+AvGWaG0X4tH5UD/xg14v3DuNKbUK/t0Z0n7W6Ku5bAfpp
 egYhQI4LsoAARVG98Ice93DAfG54JzpKi4WRFpRyBV9+3LEW2O/dmtE9vDV8tByvXbpM
 +3tcDu4fFAlS+ldfmcTB8DfmJM5P61bmLBeJ/zV0R9rRaetCH5Plhp5MkvxtxnebNSI+
 U35D8Zsf7gVnzmrE05Ba11WimBl4+OTr4Dj/2nLRWsk5kxOP/Ibttd5Tv0vV3kjawGGd
 HMqw==
X-Gm-Message-State: AOJu0YwCxIg/ZgezvRUOz1iEQB8PcfuYoPfira8DMDkb1pdElchCx58e
 Pgecb7FFgZr49rY0V1ZdX8lFqvLTJ8MSJqi03nxEOJbEbodHnIPy87rlCcOHuIdPTGxnSNK46mb
 Le7FUKpChKs+a1toUinFstUCXFGvlKybkBpzAPdqxgWd1KJt8T6C6y6p6kjATyNqmu9wpFZgWdK
 nymFJi1o5qJUraZ609tN2SS7JnOyIqG5Xu0cdD37w=
X-Received: by 2002:a05:600c:5104:b0:42c:b991:98bc with SMTP id
 5b1f17b1804b1-42f94b71121mr39238715e9.0.1728467195627; 
 Wed, 09 Oct 2024 02:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOjZMiU8+tMDp8kpAwne1ufqzCXnd12KzBfG/8FKJnGS7J0ZXqOPQGu6DVgNrzgdaIZBGPrw==
X-Received: by 2002:a05:600c:5104:b0:42c:b991:98bc with SMTP id
 5b1f17b1804b1-42f94b71121mr39238555e9.0.1728467195175; 
 Wed, 09 Oct 2024 02:46:35 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4304efc2b1bsm33174995e9.1.2024.10.09.02.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:46:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 03/14] configure, meson: detect Rust toolchain
Date: Wed,  9 Oct 2024 11:46:04 +0200
Message-ID: <20241009094616.1648511-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009094616.1648511-1-pbonzini@redhat.com>
References: <20241009094616.1648511-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Include the correct path and arguments to rustc in the native
and cross files (native compilation is needed for procedural
macros).

Based on the host architecture and OS, the compiler and optionally the argument
to --cpu, the Rust target triple can be detected automatically for either a
native or a cross compiler.

In general, it is only a matter of translating the architecture and OS, and
adding a machine to form the triple, but there are some special cases (e.g.
detecting soft vs. hard floating point on ARM) and some inconsistencies.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/207d2640b32d511e9c27478ce3192f5bb0bf3169.1727961605.git.manos.pitsidianakis@linaro.org
[Leave disabled by default until CI covers the Rust code on supported
 distros. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 163 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 meson.build |   5 +-
 2 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index aa7aae70fa1..6cc3d6b4793 100755
--- a/configure
+++ b/configure
@@ -207,6 +207,8 @@ for opt do
   ;;
   --objcc=*) objcc="$optarg"
   ;;
+  --rustc=*) RUSTC="$optarg"
+  ;;
   --cpu=*) cpu="$optarg"
   ;;
   --extra-cflags=*)
@@ -252,6 +254,8 @@ python=
 download="enabled"
 skip_meson=no
 use_containers="yes"
+rust="disabled"
+rust_target_triple=""
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 gdb_arches=""
 
@@ -310,6 +314,7 @@ objcopy="${OBJCOPY-${cross_prefix}objcopy}"
 ld="${LD-${cross_prefix}ld}"
 ranlib="${RANLIB-${cross_prefix}ranlib}"
 nm="${NM-${cross_prefix}nm}"
+readelf="${READELF-${cross_prefix}readelf}"
 strip="${STRIP-${cross_prefix}strip}"
 widl="${WIDL-${cross_prefix}widl}"
 windres="${WINDRES-${cross_prefix}windres}"
@@ -317,6 +322,8 @@ windmc="${WINDMC-${cross_prefix}windmc}"
 pkg_config="${PKG_CONFIG-${cross_prefix}pkg-config}"
 sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
 
+rustc="${RUSTC-rustc}"
+
 check_define() {
 cat > $TMPC <<EOF
 #if !defined($1)
@@ -425,6 +432,7 @@ fi
 # Please keep it sorted and synchronized with meson.build's host_arch.
 host_arch=
 linux_arch=
+raw_cpu=$cpu
 case "$cpu" in
   aarch64)
     host_arch=aarch64
@@ -658,6 +666,8 @@ for opt do
   ;;
   --objcc=*)
   ;;
+  --rustc=*)
+  ;;
   --make=*)
   ;;
   --install=*)
@@ -777,8 +787,14 @@ for opt do
   ;;
   --container-engine=*) container_engine="$optarg"
   ;;
+  --rust-target-triple=*) rust_target_triple="$optarg"
+  ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
+  --enable-rust) rust=enabled
+  ;;
+  --disable-rust) rust=disabled
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -881,6 +897,7 @@ Advanced options (experts only):
                            at build time [$host_cc]
   --cxx=CXX                use C++ compiler CXX [$cxx]
   --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
+  --rustc=RUSTC            use Rust compiler RUSTC [$rustc]
   --extra-cflags=CFLAGS    append extra C compiler flags CFLAGS
   --extra-cxxflags=CXXFLAGS append extra C++ compiler flags CXXFLAGS
   --extra-objcflags=OBJCFLAGS append extra Objective C compiler flags OBJCFLAGS
@@ -891,8 +908,9 @@ Advanced options (experts only):
   --python=PYTHON          use specified python [$python]
   --ninja=NINJA            use specified ninja [$ninja]
   --static                 enable static build [$static]
-  --without-default-features default all --enable-* options to "disabled"
-  --without-default-devices  do not include any device that is not needed to
+  --rust-target-triple=TRIPLE  compilation target for Rust code [autodetect]
+  --without-default-features   default all --enable-* options to "disabled"
+  --without-default-devices    do not include any device that is not needed to
                            start the emulator (only use if you are including
                            desired devices in configs/devices/)
   --with-devices-ARCH=NAME override default configs/devices
@@ -1166,6 +1184,132 @@ EOF
   fi
 fi
 
+##########################################
+# detect rust triple
+
+if test "$rust" != disabled && has "$rustc" && $rustc -vV > "${TMPDIR1}/${TMPB}.out"; then
+  rust_host_triple=$(sed -n 's/^host: //p' "${TMPDIR1}/${TMPB}.out")
+else
+  if test "$rust" = enabled; then
+    error_exit "could not execute rustc binary \"$rustc\""
+  fi
+  rust=disabled
+fi
+if test "$rust" != disabled && test -z "$rust_target_triple"; then
+  # arch and os generally matches between meson and rust
+  rust_arch=$host_arch
+  rust_os=$host_os
+  rust_machine=unknown
+  rust_osvariant=
+
+  # tweak rust_os if needed; also, machine and variant depend on the OS
+  android=no
+  case "$host_os" in
+  darwin)
+    # e.g. aarch64-apple-darwin
+    rust_machine=apple
+    ;;
+
+  linux)
+    # detect android/glibc/musl
+    if check_define __ANDROID__; then
+      rust_osvariant=android
+      android=yes
+    else
+      cat > $TMPC << EOF
+#define _GNU_SOURCE
+#include <features.h>
+#ifndef __USE_GNU
+error using musl
+#endif
+EOF
+      if compile_object; then
+        rust_osvariant=gnu
+      else
+        rust_osvariant=musl
+      fi
+    fi
+
+    case "$host_arch" in
+    arm)
+      # e.g. arm-unknown-linux-gnueabi, arm-unknown-linux-gnueabihf
+      write_c_skeleton
+      compile_object
+      if $READELF -A $TMPO | grep Tag_API_VFP_args: > /dev/null; then
+        rust_osvariant=${rust_osvariant}eabihf
+      else
+        rust_osvariant=${rust_osvariant}eabi
+      fi
+      ;;
+
+    mips64)
+      # e.g. mips64-unknown-linux-gnuabi64
+      rust_osvariant=${rust_osvariant}abi64
+      ;;
+    esac
+    ;;
+
+  netbsd)
+    # e.g. arm-unknown-netbsd-eabihf
+    test "$host_arch" = arm && rust_osvariant=eabihf
+    ;;
+
+  sunos)
+    rust_machine=pc
+    rust_os=solaris
+    ;;
+
+  windows)
+    # e.g. aarch64-pc-windows-gnullvm, x86_64-pc-windows-gnu (MSVC not supported)
+    rust_machine=pc
+    if test "$host_arch" = aarch64; then
+      rust_osvariant=gnullvm
+    else
+      rust_osvariant=gnu
+    fi
+    ;;
+  esac
+
+  # now tweak the architecture part, possibly based on pre-canonicalization --cpu
+  case "$host_arch" in
+  arm)
+    # preserve ISA version (armv7 etc.) from $raw_cpu if passed via --cpu
+    rust_arch=$raw_cpu
+    test "$rust_arch" = arm && test "$rust_os" != linux && rust_arch=armv7
+    ;;
+
+  mips|mips64)
+    # preserve ISA version (mipsisa64r6 etc.) and include endianness
+    rust_arch=${raw_cpu%el}
+    test "$bigendian" = no && rust_arch=${rust_arch}el
+    ;;
+
+  riscv32|riscv64)
+    # e.g. riscv64gc-unknown-linux-gnu, but riscv64-linux-android
+    test "$android" = no && rust_arch=${rust_arch}gc
+    ;;
+
+  sparc64)
+    if test "$rust_os" = solaris; then
+      rust_arch=sparcv9
+      rust_machine=sun
+    fi
+    ;;
+
+  x86_64)
+    # e.g. x86_64-unknown-linux-gnux32
+    test "$raw_cpu" = x32 && rust_osvariant=${rust_osvariant}x32
+    ;;
+  esac
+
+  if test "$android" = yes; then
+    # e.g. aarch64-linux-android
+    rust_target_triple=$rust_arch-$rust_os-$rust_osvariant
+  else
+    rust_target_triple=$rust_arch-$rust_machine-$rust_os${rust_osvariant+-$rust_osvariant}
+  fi
+fi
+
 ##########################################
 # functions to probe cross compilers
 
@@ -1628,6 +1772,9 @@ if test "$container" != no; then
     echo "RUNC=$runc" >> $config_host_mak
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
+if test "$rust" != disabled; then
+  echo "RUST_TARGET_TRIPLE=$rust_target_triple" >> $config_host_mak
+fi
 echo "PYTHON=$python" >> $config_host_mak
 echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
@@ -1764,12 +1911,20 @@ if test "$skip_meson" = no; then
   echo "c = [$(meson_quote $cc $CPU_CFLAGS)]" >> $cross
   test -n "$cxx" && echo "cpp = [$(meson_quote $cxx $CPU_CFLAGS)]" >> $cross
   test -n "$objcc" && echo "objc = [$(meson_quote $objcc $CPU_CFLAGS)]" >> $cross
+  if test "$rust" != disabled; then
+    if test "$rust_host_triple" != "$rust_target_triple"; then
+      echo "rust = [$(meson_quote $rustc --target "$rust_target_triple")]" >> $cross
+    else
+      echo "rust = [$(meson_quote $rustc)]" >> $cross
+    fi
+  fi
   echo "ar = [$(meson_quote $ar)]" >> $cross
   echo "dlltool = [$(meson_quote $dlltool)]" >> $cross
   echo "nm = [$(meson_quote $nm)]" >> $cross
   echo "pkgconfig = [$(meson_quote $pkg_config)]" >> $cross
   echo "pkg-config = [$(meson_quote $pkg_config)]" >> $cross
   echo "ranlib = [$(meson_quote $ranlib)]" >> $cross
+  echo "readelf = [$(meson_quote $readelf)]" >> $cross
   if has $sdl2_config; then
     echo "sdl2-config = [$(meson_quote $sdl2_config)]" >> $cross
   fi
@@ -1799,6 +1954,9 @@ if test "$skip_meson" = no; then
     echo "# Automatically generated by configure - do not modify" > $native
     echo "[binaries]" >> $native
     echo "c = [$(meson_quote $host_cc)]" >> $native
+    if test "$rust" != disabled; then
+      echo "rust = [$(meson_quote $rustc)]" >> $cross
+    fi
     mv $native config-meson.native
     meson_option_add --native-file
     meson_option_add config-meson.native
@@ -1817,6 +1975,7 @@ if test "$skip_meson" = no; then
   test "$pie" = no && meson_option_add -Db_pie=false
 
   # QEMU options
+  test "$rust" != "auto" && meson_option_add "-Drust=$rust"
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi" "-Db_lto=$cfi"
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
diff --git a/meson.build b/meson.build
index 93ddaef500f..f76f01f065f 100644
--- a/meson.build
+++ b/meson.build
@@ -4325,8 +4325,9 @@ else
 endif
 summary_info += {'Rust support':      have_rust}
 if have_rust
-  summary_info += {'rustc version':      rustc.version()}
-  summary_info += {'rustc':      ' '.join(rustc.cmd_array())}
+  summary_info += {'rustc version':   rustc.version()}
+  summary_info += {'rustc':           ' '.join(rustc.cmd_array())}
+  summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
 endif
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
-- 
2.46.2


