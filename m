Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C6ACF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLtW-0008T9-2J; Thu, 03 Oct 2024 09:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtT-0008Sa-7d
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:23 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtR-0005wx-00
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:22 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c896b9b3e1so1298541a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727962159; x=1728566959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3Xdhp6yyQlwRtRuGyDS4ZcnYai095EmGKb8STz9hr8=;
 b=PNzpLWbk49WOkDtLr9rP8lDi/71ahljOlTDLCLAZgesRaasWdPWCVEg+HWQrQnxYSQ
 dOoyzp+G/t3mTZPVJI0Dv6GDicj2cfUNEdud96yQS28ZLM22hZdC2PRiY85aQBGe2OAK
 Kh67x2eyfXlPudR4jYoF3SyG3JIiw7fZ5jOzBs+XJ5Ut0d8kGiIldD9yw0k0L9s51g3q
 fS4atba9LOh8BH7pAcyzAmWLPlVl3NUkrEm9Ke/Irk5xnb98UNypVYyFTVl4pDNFD46D
 dxm1zUwQDxaj+5/ZaWly6y90+Pi4MgjjBO9Z5M/AaIaVHnaLBjEO2vGvCWFXnyeLjdDC
 Vrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727962159; x=1728566959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3Xdhp6yyQlwRtRuGyDS4ZcnYai095EmGKb8STz9hr8=;
 b=FsQHq2KP9K7AmvUZ57DYHOUDzccLU/2cQ+MTO76PU0Jmf9plfU8uxSEPDQ892W3xHg
 MMsFLEeNhjQlDDk0cdRkVSllcPF+YzfsUTJqShPxFr+Perhpxdf1RJv0rcTf4m4owNgE
 /cjErcGa92vYZBPdCcKbLNEpUgDhnFkYq/0yI0CORRfab70wF2nN8eQjLX9hwrL2mrPy
 +rbfQ0PTk02bZ520jhp6eYVOQMzJ6hhZ0nSXAyx0x6Bhc03UHYA38yc1l7vH612CKA3c
 /SruEjdnwKdJsEXKk5z1mJfYoe6kTN/864OVhwxlw0T2PlQA59tb44/fT6nJCn57basS
 vMYQ==
X-Gm-Message-State: AOJu0Yx9JqlE9SoN9y7NsxG3ZZyoBls8fbhf9c7q6d/Sf6r2aR9Lkmxd
 2d/m4b1RImry+YPhkr1226rOxWwqbfSDZpNDIkCrgIlhVnvQI0ba0iAJbxrfs6sAALkDPvQZKXJ
 0AdE=
X-Google-Smtp-Source: AGHT+IG4NnM/UtmyXr+Nov1tC1qsgf39k+yeBIjF011U1lkmtJNBws9rut2khJNLZBOXNn6GZArVcg==
X-Received: by 2002:a17:907:920a:b0:a99:a89:47cd with SMTP id
 a640c23a62f3a-a990a894c5bmr239464266b.3.1727962159266; 
 Thu, 03 Oct 2024 06:29:19 -0700 (PDT)
Received: from localhost.localdomain (adsl-122.37.6.160.tellas.gr.
 [37.6.160.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99102a4cdcsm86528366b.57.2024.10.03.06.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 06:29:19 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Junjie Mao <junjie.mao@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, berrange@redhat.com, hi@alyssa.is
Subject: [PATCH v11 3/9] configure, meson: detect Rust toolchain
Date: Thu,  3 Oct 2024 16:28:45 +0300
Message-ID: <207d2640b32d511e9c27478ce3192f5bb0bf3169.1727961605.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
References: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

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
---
 configure   | 163 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 meson.build |   5 +-
 2 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index aa7aae70fa..0ccc92074e 100755
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
+rust="auto"
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
@@ -1167,6 +1185,132 @@ EOF
 fi
 
 ##########################################
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
+##########################################
 # functions to probe cross compilers
 
 container="no"
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
index 8a106e39c2..8ddb5fa38d 100644
--- a/meson.build
+++ b/meson.build
@@ -4332,8 +4332,9 @@ else
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
γαῖα πυρί μιχθήτω


