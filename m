Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB37C54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuIl-0002gl-GP; Tue, 27 Aug 2024 07:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuId-0002UC-Rp
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:48 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIb-0000iS-PX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:47 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53349d3071eso6501600e87.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724757824; x=1725362624; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ejIq34eU8g4lAxI8GBYvWXzFq8igCRIQX1rzGEt4Sjo=;
 b=r9Bvuy3Q3XViU+oVIOMVrSp9oz5w9UTeg/TIGI7mYS1Zlyy9bEUClV5tf4e1y4hugz
 mCkSVfhjlxEyNzuIwHVuQtkTfXkVP4InkXkxwiFyd3Ukp11HEq/giT/IHiULQd9zmqyH
 utfirihQNPX2caGiWOT112YsNQeTc4KZejTMTyfkmGVZfMzPHNQTqrSa2sarb07OnL8t
 OAsbr3RukweYmfXfvx0mwLeeuAVfahT7UgoQEGIPkQHyZuHLR3u5/f17ankJBXr5jGxM
 ocRvN2yHed3EE4LNVGsUh0Fb3MOO/F4cZruyEJ5/EW5q3Ljo4sNekUs+jGYiNSvPwXb6
 U/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724757824; x=1725362624;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejIq34eU8g4lAxI8GBYvWXzFq8igCRIQX1rzGEt4Sjo=;
 b=Bow9Abim0H+uq30CxQsd752hJVB00mPjKBbKplWy8SVy9GDBJXL2moaarAJ+8NdKKz
 HNosWqJsVoiiXj3nHR8HZ13sKakomuBFuuJYXgkIIgFT6qtQHnmKGSKlm6KUqoRxYOxj
 GfVfy0qZahLyVS6v3ZSx9sewR5KFNy28QFx4eX/LhitDELYWGbeEYaxG/LP268psutK4
 2ShXnVxCYOMvN51R6lRQ2aU2F+uwd53+V03Pa4UnBCpf6yRqGGDL+uIxKfH5UAa5vFBI
 sgz5vHL+gVj+3jRcEX1iBUrFZwK6QiIJ16vMALsDdLMdyQMANFlFe8DhSuSuhXiNs1XK
 1OqQ==
X-Gm-Message-State: AOJu0YyXt+82abnDTv0LveWNl/keOYbWyFfzI1hfri3aOc5ToZcSpnHe
 kG2+khRV3wB2+MrVOzFzWyzn1umDfABHRUYRUX7JCGlMe7a1wdki2cqxhJMX3cE=
X-Google-Smtp-Source: AGHT+IEz2XOWXqggUQvLXvHScLYqUR+hu8JPTfEfnUWUPcooRe7/SnTURBfzu785qEjpCIqOW1ds0g==
X-Received: by 2002:a05:6512:b1c:b0:52e:74f5:d13 with SMTP id
 2adb3069b0e04-5343878504emr9343459e87.30.1724757823741; 
 Tue, 27 Aug 2024 04:23:43 -0700 (PDT)
Received: from [127.0.1.1] (adsl-242.37.6.163.tellas.gr. [37.6.163.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594fa62sm96280066b.198.2024.08.27.04.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 04:23:43 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 27 Aug 2024 14:23:12 +0300
Subject: [PATCH v9 3/9] configure, meson: detect Rust toolchain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-rust-pl011-v9-3-e90b9c28f861@linaro.org>
References: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
In-Reply-To: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=6784;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=pJ5CgorGDzauB+8u0nygLE2C+mcB16PY5jVjS+FWntY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16YmMweDcyd3VlVTB1K3BSbGZ4SjJYbnJ3WkQ0CmE2NXVtcDFlZzF3dDNkcVpr
 Q0NKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnMyM05BQUt
 DUkIzS2Nkd2YzNEowT1h3RC80aEJkWTI3RGQ2YkRRQURxdEdCQjFQS2g3U3FEWXRqV3NUQTYrcg
 pScGJxeVJHM1RhczcvRGM5TGFGMXVQQ2RkQjl3UzhOQXcxQnJJSFloanoxREZOaGU0ajFhNmdJL
 0tCNmZJeXhjCmlEeDUxSllVZHBuVWJ0bkZQNDhmUHNwdDRFNFZlZUdkVGRONHhaZ3JQZmZ3WE91
 VDNqUTRCcDJJNDZ5Tm5qK1QKL1Q4c1JzKzJXQnBHblpYTlBsWlRJVVJQanF6VkNuakJKbStCWGN
 kMnRjbHZFeFdjM3ZidnJTcWNEN2hjTWl4bApwRWIxK1JZYThXY2JIOUxRTS8wZ2hDWTY3OHFzWT
 lnTWUwL01jN0lCZitpVXJCNEluaGNCbjJXMW5tSVUxamVYCmQxSjlMNFRIYkJJRTI1NGZqN3BXV
 DdqQmlzZzVsbTdTMjdiVERkMk1FMkw5RUtXMUh3cEFxV0tUQjkzQXg1Z2YKbE1QeHEzQ2tBclRk
 QVZ5MGdTRW9pMzdBdzNrYVdHN1FsUzRZdytGT0ExSjQrSitJRWd2UCs0Zm0ydERJaFdwNwpGZjB
 XRE1PeGoyVTNjcHAzS3pYaUpCS083cU1jOHNGSzdmTExrMUk5Z1VCQmtSQVhaek9ZZXc2U2o2bj
 ZyWEVLCnF1TzFTSUE5TldIVndIVGQyUEpGdzBoZW90UHdIZ0dCeHpXTnRweFh3TFVTaTZFVERDT
 1U3WUhXN1R1bXJjVWUKaG1DOFgvSTROaFVMM3VUZVVJcmFXNEYwaVg4R2R6S3Y3amFKMUNtMWp3
 YlpUeldkRFczWldEdE1LTk9rRGx2ZApSTmNuK1Bya3dwZXkwYXBKMTQ0WDk1SGJSU01zREZzN2Q
 4cUFlSGF1RTIwTTg3V1ViaHQrMGliT0txOFdoSUpOClQxWlRXQT09Cj1DS0pGCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Include the correct path and arguments to rustc in the native
and cross files (native compilation is needed for procedural
macros).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 meson.build |  8 +++-----
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 019fcbd0ef..9ef6005c55 100755
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
@@ -252,6 +254,9 @@ python=
 download="enabled"
 skip_meson=no
 use_containers="yes"
+# do not enable by default because cross compilation requires --rust-target-triple
+rust="disabled"
+rust_target_triple=""
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 gdb_arches=""
 
@@ -317,6 +322,8 @@ windmc="${WINDMC-${cross_prefix}windmc}"
 pkg_config="${PKG_CONFIG-${cross_prefix}pkg-config}"
 sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
 
+rustc="${RUSTC-rustc}"
+
 check_define() {
 cat > $TMPC <<EOF
 #if !defined($1)
@@ -636,6 +643,8 @@ for opt do
   ;;
   --objcc=*)
   ;;
+  --rustc=*)
+  ;;
   --make=*)
   ;;
   --install=*)
@@ -755,8 +764,14 @@ for opt do
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
@@ -859,6 +874,7 @@ Advanced options (experts only):
                            at build time [$host_cc]
   --cxx=CXX                use C++ compiler CXX [$cxx]
   --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
+  --rustc=RUSTC            use Rust compiler RUSTC [$rustc]
   --extra-cflags=CFLAGS    append extra C compiler flags CFLAGS
   --extra-cxxflags=CXXFLAGS append extra C++ compiler flags CXXFLAGS
   --extra-objcflags=OBJCFLAGS append extra Objective C compiler flags OBJCFLAGS
@@ -869,8 +885,9 @@ Advanced options (experts only):
   --python=PYTHON          use specified python [$python]
   --ninja=NINJA            use specified ninja [$ninja]
   --static                 enable static build [$static]
-  --without-default-features default all --enable-* options to "disabled"
-  --without-default-devices  do not include any device that is not needed to
+  --rust-target-triple=TRIPLE  target for Rust cross compilation
+  --without-default-features   default all --enable-* options to "disabled"
+  --without-default-devices    do not include any device that is not needed to
                            start the emulator (only use if you are including
                            desired devices in configs/devices/)
   --with-devices-ARCH=NAME override default configs/devices
@@ -1139,6 +1156,21 @@ EOF
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
+  rust_target_triple=$rust_host_triple
+fi
+
+##########################################
 # functions to probe cross compilers
 
 container="no"
@@ -1604,6 +1636,9 @@ if test "$container" != no; then
     echo "RUNC=$runc" >> $config_host_mak
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
+if test "$rust" != disabled; then
+  echo "RUST_TARGET_TRIPLE=$rust_target_triple" >> $config_host_mak
+fi
 echo "PYTHON=$python" >> $config_host_mak
 echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
@@ -1735,6 +1770,13 @@ if test "$skip_meson" = no; then
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
@@ -1770,6 +1812,9 @@ if test "$skip_meson" = no; then
     echo "# Automatically generated by configure - do not modify" > $native
     echo "[binaries]" >> $native
     echo "c = [$(meson_quote $host_cc)]" >> $native
+    if test "$rust" != disabled; then
+      echo "rust = [$(meson_quote $rustc)]" >> $cross
+    fi
     mv $native config-meson.native
     meson_option_add --native-file
     meson_option_add config-meson.native
@@ -1788,6 +1833,7 @@ if test "$skip_meson" = no; then
   test "$pie" = no && meson_option_add -Db_pie=false
 
   # QEMU options
+  test "$rust" != "auto" && meson_option_add "-Drust=$rust"
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi" "-Db_lto=$cfi"
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
diff --git a/meson.build b/meson.build
index 67eb4eda64..065739ccb7 100644
--- a/meson.build
+++ b/meson.build
@@ -70,9 +70,6 @@ if host_os == 'darwin' and \
   all_languages += ['objc']
   objc = meson.get_compiler('objc')
 endif
-if get_option('rust').enabled() and meson.version().version_compare('<1.0.0')
-  error('Rust support requires Meson version >=1.0.0')
-endif
 have_rust = false
 if not get_option('rust').disabled() and add_languages('rust', required: get_option('rust'), native: false)
   rustc = meson.get_compiler('rust')
@@ -4307,8 +4304,9 @@ else
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
2.45.2


