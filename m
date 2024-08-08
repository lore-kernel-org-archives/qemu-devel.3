Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD12DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbyDj-000569-LF; Thu, 08 Aug 2024 04:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sbyDh-00054t-27
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sbyDe-0001aQ-Oj
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723104597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aKxd0cXP1y+N4k27JWws9HQ06YzVciEcPutqHkmvU8g=;
 b=RaWSHIQSDPiICsHr1pcczevOEi/eVDojxzXtl1RFDW6e2hnhJnHt2u91wKATs9Igo0kC3N
 Wkf9RLUhFw9tuHaPJEKXrbQY69JDxnw33IPnzfkGlSK0B+ShIuKQGOpwS42tQl6C2wtNPh
 TMBGiKMm7B0tq+F2agd/B+vdPVAJG4E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-nEi0qjiyMYmolSsUO0vgkQ-1; Thu, 08 Aug 2024 04:09:53 -0400
X-MC-Unique: nEi0qjiyMYmolSsUO0vgkQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7a83f54fdeso63137366b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 01:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723104592; x=1723709392;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aKxd0cXP1y+N4k27JWws9HQ06YzVciEcPutqHkmvU8g=;
 b=NT5IEfRrNS46G3ICpY0LGTegIsBH9bZiJu1Z6vhTWZwJlzTJv8X2m6eg9AVIDX75ge
 lhUTRPO/enLqqVHq5qJ6uPinFIIUMOlSK7QTqJ0jFzRjd5Xon3Y81lwH8pQ8EzSLdMIZ
 8o1GVmumgcqSjYo2vlAPBdncyF0PlcAam696QAFxyrgxMBilEhg7C5sGxqHrhVcLwryL
 O4eyU8Ox3jRhwdGfquwaogxtTGmHJtdw2Z4fvXFR+Ew/lOYKY3/dGHv/KVMEAjwgWn+w
 xBR98bDfqI1yVi4X1pjxdw0T0MQC1ZHr2y+iqCerf7k2zQNKbPzQF/guH4+tZgy5f8p4
 Sw1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVo6cG+5h+/vMjoxhRMUW93LCAw3iyf/6RBIMiLkyLpjQS/pTeB64AD+fci2ZPlU84R8Kjv1BWBHnH4yBFTZJ270LeSlc=
X-Gm-Message-State: AOJu0Yx+jyNhZxIk2Gr9anAXf20o/doBPzVI4NGmDDcxAZ26sFJE6rGR
 GVCD4rW12jaLXl2tIeODTc7IVqojPGEbDyxarKnCV5z/N/bHILKisoANbaD6mavozwd+hmvFuF7
 CgtsSHPvR7uCIFZb7SQu4wwh6JuoDxN90M0+5mi04aDCtW5N0KjIr
X-Received: by 2002:a17:906:4783:b0:a7a:a212:be4e with SMTP id
 a640c23a62f3a-a8090c29b81mr85853166b.7.1723104592529; 
 Thu, 08 Aug 2024 01:09:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUusoL149Zvb9EZUOCLZvO56qko1QjRrxz/Ccc7VybB5+PRrGL2zkQu51bQ9R0kKjqBFaqDA==
X-Received: by 2002:a17:906:4783:b0:a7a:a212:be4e with SMTP id
 a640c23a62f3a-a8090c29b81mr85849666b.7.1723104591961; 
 Thu, 08 Aug 2024 01:09:51 -0700 (PDT)
Received: from [10.168.67.37] ([131.175.147.29])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e8674dsm729292966b.146.2024.08.08.01.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 01:09:51 -0700 (PDT)
Message-ID: <d3aee5cd-b92c-40d5-8f37-c0cc0facfe48@redhat.com>
Date: Thu, 8 Aug 2024 10:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 1/5] build-sys: Add rust feature option
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
 <rust-pl011-rfc-v6-1.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <rust-pl011-rfc-v6-1.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/4/24 23:04, Manos Pitsidianakis wrote:
> diff --git a/configure b/configure
> index 019fcbd0ef..aac7f29f25 100755
> --- a/configure
> +++ b/configure
> @@ -874,6 +874,8 @@ Advanced options (experts only):
>                              start the emulator (only use if you are including
>                              desired devices in configs/devices/)
>     --with-devices-ARCH=NAME override default configs/devices
> +  --enable-rust            enable compilation of Rust code
> +  --disable-rust           disable compilation of Rust code

Not needed ("rust" is included in the features list emitted by meson-build-options.sh)

>     --enable-debug           enable common debug build options
>     --cpu=CPU                Build for host CPU [$cpu]
>     --disable-containers     don't use containers for cross-building
> diff --git a/meson.build b/meson.build
> index 97f63aa86c..9593fce47f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -70,6 +70,22 @@ if host_os == 'darwin' and \
>     all_languages += ['objc']
>     objc = meson.get_compiler('objc')
>   endif
> +if get_option('rust').enabled() and meson.version().version_compare('<1.0.0')
> +  error('Rust support requires Meson version >=1.0.0')
> +endif

Also not needed (1.1.0 is the minimum supported meson version).

> +have_rust = false
> +if not get_option('rust').disabled() and add_languages('rust', required: get_option('rust'), native: false)
> +  rustc = meson.get_compiler('rust')

The main missing part here is setting rustc in the native and cross
files.  This is a small change to the patch I had for cargo:

diff --git a/configure b/configure
index aac7f29f25c..f2d5a9a8d40 100755
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
@@ -869,13 +885,12 @@ Advanced options (experts only):
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
-  --enable-rust            enable compilation of Rust code
-  --disable-rust           disable compilation of Rust code
    --enable-debug           enable common debug build options
    --cpu=CPU                Build for host CPU [$cpu]
    --disable-containers     don't use containers for cross-building
@@ -1140,6 +1155,21 @@ EOF
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
+  rust_target_triple=$rust_host_triple
+fi
+
  ##########################################
  # functions to probe cross compilers
  
@@ -1606,6 +1636,9 @@ if test "$container" != no; then
      echo "RUNC=$runc" >> $config_host_mak
  fi
  echo "SUBDIRS=$subdirs" >> $config_host_mak
+if test "$rust" != disabled; then
+  echo "RUST_TARGET_TRIPLE=$rust_target_triple" >> $config_host_mak
+fi
  echo "PYTHON=$python" >> $config_host_mak
  echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
  echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
@@ -1737,6 +1770,13 @@ if test "$skip_meson" = no; then
    echo "c = [$(meson_quote $cc $CPU_CFLAGS)]" >> $cross
    test -n "$cxx" && echo "cpp = [$(meson_quote $cxx $CPU_CFLAGS)]" >> $cross
    test -n "$objcc" && echo "objc = [$(meson_quote $objcc $CPU_CFLAGS)]" >> $cross
+  if test "$rust" != disabled; then
+    if test "$rust_host_triple" != "$rust_target_triple"; then
+      echo "rustc = [$(meson_quote $rustc --target "$rust_target_triple")]" >> $cross
+    else
+      echo "rustc = [$(meson_quote $rustc)]" >> $cross
+    fi
+  fi
    echo "ar = [$(meson_quote $ar)]" >> $cross
    echo "dlltool = [$(meson_quote $dlltool)]" >> $cross
    echo "nm = [$(meson_quote $nm)]" >> $cross
@@ -1772,6 +1812,9 @@ if test "$skip_meson" = no; then
      echo "# Automatically generated by configure - do not modify" > $native
      echo "[binaries]" >> $native
      echo "c = [$(meson_quote $host_cc)]" >> $native
+    if test "$rust" != disabled; then
+      echo "rustc = [$(meson_quote $rustc)]" >> $cross
+    fi
      mv $native config-meson.native
      meson_option_add --native-file
      meson_option_add config-meson.native
@@ -1790,6 +1833,7 @@ if test "$skip_meson" = no; then
    test "$pie" = no && meson_option_add -Db_pie=false
  
    # QEMU options
+  test "$rust" != "auto" && meson_option_add "-Drust=$rust"
    test "$cfi" != false && meson_option_add "-Dcfi=$cfi" "-Db_lto=$cfi"
    test "$docs" != auto && meson_option_add "-Ddocs=$docs"
    test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
diff --git a/meson.build b/meson.build
index b89ce025c1a..e656ef34aab 100644
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
@@ -4305,8 +4302,9 @@ else
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



