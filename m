Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F1AC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 08:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shPPD-0004L8-Ug; Fri, 23 Aug 2024 04:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1shPPB-00049Z-7F
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:12:22 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1shPP9-0004oU-2U
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:12:20 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a86883231b4so226488066b.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724400737; x=1725005537; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OBCPMa6ua93lVX7G+DgkIWdqT327/XeExtyzrU5tOUM=;
 b=f0E/CmMgY2/PgV0ko9UJpD5Oa4nq1/FuHcHm5NDAhhEyLcsiKpfR4GYuoTh04Aw/qy
 C5wjGb4W/DitOy5uC8p6seXs7lvfiLDKFCz2ZJUul6fq+oM0eqd0VQ2S2LVw0/y96zDo
 gLinPNkkNdSlbLnTJjT0+eo9meLNikycEKFP5aIVvDrHDSLtaLXzlhgEUIWRm2TRHL26
 5K3Wrv1tU4EVjGNv6siHlLduAtAXpswTKvzg+z9w3rHMcpkYDah68nPWsUju/vjT1kEo
 X2V9deQUOKnYf9a1y3w29NBNDmEWCpbP4lf9cUToB5dZoP7FqodwBt5v8JWCKIEB2aZX
 vy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724400737; x=1725005537;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBCPMa6ua93lVX7G+DgkIWdqT327/XeExtyzrU5tOUM=;
 b=IF1MKTBLK7FshkUWl5qYnUFtLO7iq9srlPfnp9u/tjoHSN0+HRRwm6btYPSuOXnjvN
 17fIl5dQ/FRVEPQakAIj3n8cg+/0vKqrnyVNT0Fil4Ua98WxmDop3MlmqJNKS+7Sa6ZT
 FXGYIGOyzAQp1Et6kx1QSEitFX51JVQpL+xhp8MhgLbZJBkIYjiIXq6ON2SitKnBVTCq
 9/SMCVADEM3nyLykjmqLkkwIv4Wt3q+4euIsVn2XM6UYDWbitbYJ2By/oAmOqIgCFnEJ
 ouExZ9KQoXN8a4MoubGgw68izBwOr7F3I2BUpVdJ6WTHUsOTg/68w3hfddAEqKOG58E5
 OKWA==
X-Gm-Message-State: AOJu0Yw1vtPYsVi/+EO2pbpjuCYOj4riq0451sNYnsC48dYpWpS6kZdx
 c0m7IU/eYLNrOyejIbwA+SFa2qAcL5gYllhierYmCMpCMHX/BPu+LR0CJzXGZ94=
X-Google-Smtp-Source: AGHT+IFS9w6gVzJgtGoz2XQl0umhwyzLyv9a9fvju3FKcvqtsqVGxp8peLeJT/z+E2K4zR+bynd+jg==
X-Received: by 2002:a17:907:f7a8:b0:a86:8953:e1fe with SMTP id
 a640c23a62f3a-a86a54d2d4bmr110318666b.47.1724400736975; 
 Fri, 23 Aug 2024 01:12:16 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868ee6b390sm223620066b.0.2024.08.23.01.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 01:12:16 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 23 Aug 2024 11:11:51 +0300
Subject: [PATCH v8 3/8] configure, meson: detect Rust toolchain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-rust-pl011-v8-3-b9f5746bdaf3@linaro.org>
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
In-Reply-To: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
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
 Zhao Liu <zhao1.liu@intel.com>
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=6784;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=byrrNLUPrf2hGX1UUEPx3AUY6uJHKDQhCEIJCILIBSw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm15RVJZSHJkeUpIQ3BOS2N6akxQd0JoSC9qQUVNCmtLVFhWbER5eFc1VENHVTlL
 VUdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnNoRVdBQUt
 DUkIzS2Nkd2YzNEowSFJLRUFDVFVQSktJZG9qSU5EdzVQSUR2M09mRDdPR2RnWFVMSy9HZmVOYQ
 orcDRiMTlHdjA5elNKMUZvRnE0WXNyVldTRlJoUXFTSTVPVDBFYURHeVpPOWZ2NlQweEI3SWZ4V
 W1Qd2REdXFzCk1iUXY5UFNFcmZPYmtnaHZSL0dEU0J6TE13Zy9BMHI5dHVHV0FoU3NZMkhQNjYy
 VDFSMVFFdkRhblJ6WDNhM2kKUDJrTW1OaGVBdHk0VmNDUy8xKzdxcDc5bTVXVTdXTXFib2FEeG1
 2VmJTcWlLd1ZScDBYZDUxM3hIYmorNUFNNApsL0pCQmtaaEJOM29WNWk2OW1lNHNCeGZvanZuQj
 A1eGViRU5jV3dBZVRkY000eWk4bVBVUXZ6R3NuOTNMQm1ZCkVZaFliM1lxek1nVitQejhaT2xuK
 3BRcGFIeXY2NC8vU2U5MWpDcjZTK3FCcndMbFo1YnpmTlhuSXNyeE5kbFMKaEc0TGh2aVlXcXgr
 TkorUml2Ujl3eTZKblRsR2tMT25aSE42Zzg0L09Ub1ZaUGNiVFlmdnpQSnpLOTVEUHA5eQphUmx
 nMmxtUkFiYlRjU1FqSFdXeFI3RnIrZGZzcXVwdzNoK2UraWxiSm5lYTRPa2NCUG52UWpTdTN6T1
 VwT2ptCnNiRjNQMmFRVXNPeTRSblBQZkJpcmx4TExMamtKeG1VVzc2RGRKVEFmeTlMODYvc0JRU
 2ZPTmlBQ0x4amtlcTUKL1I2ZDR5alE3NVdxNks5cnVBdkEva2NUb2tURk43TDZxRnNqZC82NHoy
 SnZBY0dRRzJlMTBCVno5eGdLNlNtRwpobXpQYVhQVFh0RjRUK2JNOEFXMjFOK3NaUTg4ejdsVEN
 uWEd6Q3RWZHVYOUNBbDBzSVhZV2VldndVTjJYRGxvCmJoSmpBdz09Cj1rWEs5Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x636.google.com
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


