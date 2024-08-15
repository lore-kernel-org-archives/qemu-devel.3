Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1D7C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 11:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seYsb-0008Fo-1k; Thu, 15 Aug 2024 07:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsZ-00089C-96
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:55 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsX-0002Dl-5C
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:54 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7d26c2297eso106656666b.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 04:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723722172; x=1724326972; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OBCPMa6ua93lVX7G+DgkIWdqT327/XeExtyzrU5tOUM=;
 b=YPku5peN9gdxCpEgcum4KB+fbm4TCls3YK0anDemtRHcIapCBcZgyq2moXUzoTX/qZ
 WrwGGqawuld9p+LArYRXZQuPbs7CxAYWq2Dxw/DougU78Z4XNoRL9c5BUkef0A+1pTLK
 YaAc+E3kcv35JcnkC6tM8VzeqSm+STVdRKAa2P5duvS5xROzFXPBQ7lgsHKfnpLcz1FJ
 TKzWay/bbR2SMbOUBbHJY9ras6c8YAkfgNnNcSkvPxQ99913yY4j0a9k+ol4q1UNagFU
 qs5gnkVQAJ3HlA+mlq1tiRWMYf/uLnF4kyS+Jzy2G4N+C1LRs9LpV/Z/JGqg2DFDG/rQ
 IUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723722172; x=1724326972;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBCPMa6ua93lVX7G+DgkIWdqT327/XeExtyzrU5tOUM=;
 b=KSPuFC2MauAXlB8ndVHVN+7ksbV0D9uCY56O1O/Nyvl0xm+xC3nBq/oyLZQlivFInV
 1ZS9skxvwvlvLLlL88pmn7bMaDj8Hrae9Yut32nDTL2jhhma/aUJh1cRhG6O+Rcd3L2z
 TPYRZw5T2O6laZV5DPyZv0Wa5XsqgumMe7eAoEsWv9y11wX/NG9E66AXOn5P9UqVSZFT
 YBTz6IfRmkmouDdtiJ/xB3SQze8k8LQVXW3h7YOgBcH1/bQxHlzaPQtBwnIcbAJcE5Z3
 7CrIDc/FJEJdKHED0PNbQpOtHwZCNGun+Isgz11hquBgjj/iq8sZJR2GLp7c4dQ9tuiS
 c+2A==
X-Gm-Message-State: AOJu0YzjlNPDjLwkkbK9MKpSpooQ3arqz2bobSnpi5dMRTRGQUBzmRtz
 TD7tZIuLCUutb6tq/UmAcNLtiCXRlf88s93HXO3zlB9THADwHCNEPIlieqa2lNM=
X-Google-Smtp-Source: AGHT+IG68LcRAfERN/LX2ntqlMKHx5ZZ8hR96oV5Q/9GgCoULr1iToiE6PoGL0McWBbpn7rd2RQzaQ==
X-Received: by 2002:a17:907:7e97:b0:a77:c0f5:69cc with SMTP id
 a640c23a62f3a-a8367068777mr381238866b.61.1723722171627; 
 Thu, 15 Aug 2024 04:42:51 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6bf1sm89547966b.21.2024.08.15.04.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 04:42:51 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 15 Aug 2024 14:42:20 +0300
Subject: [PATCH v7 3/7] configure, meson: detect Rust toolchain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-rust-pl011-v7-3-975135e98831@linaro.org>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
In-Reply-To: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Junjie Mao <junjie.mao@intel.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com, 
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6784;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=byrrNLUPrf2hGX1UUEPx3AUY6uJHKDQhCEIJCILIBSw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm12ZW11dXRZdXZQelAzdDhWZzdNa1hEVTN6OFFFCjVSd0hSdDM5cVdITnJyQWdT
 SEdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnIzcHJnQUt
 DUkIzS2Nkd2YzNEowRDQzRC80L21DN0IrYlB2dlVZa2taRnFnbjdocHVRYnRuZExIQWh1WG5Ccg
 pleGdHRy9rUW1OYzlQTUNWS1EwZFJ3QUpZd3dsRWRlM1MxNExjU1g2elExYjdiNHlNYlI5VksxV
 nMvbFJnTmlkCmZGYzZuV0M1MDJYODVXcGoyVjJWWFg1WFhCMXpUams2U2dWclkxa1VWMFpKSitt
 WTB1aEYvMStNT25HczMvWjUKR2hRUVQwTktvQnh2TnJSVkF5K1g3aGluYW9EdFhaZnpnWEpkV1d
 uTExZUHA5U2ZucVMwV1NKUXo2ZFcyWW1acwp5ZW9xRHl0N2JyT3pkZnlyMnFqdFpiNTI1NTBTVU
 lLK3Y0QkFFb1ljek9pVTRWTFV5a080cjV1L2RHdUxCTXdhCm91M2ZUYWRnTWR3T2Y3SDVuUGU5d
 itHNFdBb3MyQ1pKUVlCanZtY3NubGlTNi95dFA0TE9IRzI4UDFocHlpcHMKZ0ljNDMwUlM1NllB
 dzY4V1ppOVE3MVVvQWl1NnBMaXZlWngyVHVWQm1aT20yWCs0MnZBVVdqTVFvNG9YVnNEeApXMmN
 3TE5pbHJTUFhvdHNzcXVBYkZ0U05QWmVCaUNONFRicXdHL0VhOTRmKzZoakprMkN3RGpXRWpyMH
 JtU3VICmJQbTVqTTk4SUdNSlhxT3RNc3hiRUIwVGV5YWxLbGo0MktlS3NPdjkyN0ZpZWZkOGZsR
 3MycUNkeVdsU2luUlkKcEdIWDI5bDF3UzFMVk94SmEvbEx3b0JyRXJVTEJ2d1cyNEVEU2UzQUtX
 SEFwd3BwbWZTYlVucERrYU1QUFpGZApianhmK2hvSFBEWXRXS0FXSnMwc1YwMEpCTnJuUFVWaWp
 ZTHlYaE50c2x3NklmSjdsZm1RMWxQd25hUUFLemFlCnI4NGNIQT09Cj1wOERMCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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
2.44.0


