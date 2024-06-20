Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB46CC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMHy-0002He-PT; Thu, 20 Jun 2024 14:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sKMHw-0002H5-Hq
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:13:36 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sKMHu-0008TE-Cq
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:13:36 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52c32d934c2so1224743e87.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718907212; x=1719512012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=k95cah6sBDyDZorFF/3tD9YMPNzfD4GlEXWHUtjJ33A=;
 b=f+BxhcPbZgy2L6fkY7PwqLO2Egvv5Ggvr8SJwk8OXfyuwR3/MHbR3i8mKAARBwiWEA
 yR/WtplYd1xa42u/ak7oQOYnROH0+smEFMqgnysd3fuDxGuNSniwAKCG/wnGPVeNJK1g
 FpB4SPXdGqadexcXejXKcukIMJqLfLS4Qyw93HGG74BlbLXvgz53Sn34tSeR3GuXtDKG
 NSkbqqN3mK/bWkScqXsKWmv53AJkR4ByaNGZRws567q05HPATW7tobswAFQCsg++apNm
 Wfo2GkQJKG4s2o3G7dw/6n4HJpGvF9Z7hwwJKBczYvQXVHAV68V1ylSfwJyJg3SJycnd
 tH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718907212; x=1719512012;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k95cah6sBDyDZorFF/3tD9YMPNzfD4GlEXWHUtjJ33A=;
 b=srSjB6j/3rSMaFssYMcxyJ+sR072h5SHU/vfMwmR1FB8nN3VDVGTUK/gkZ1AKYCjQH
 pFhjk1r3NPzVnP0yt/Wkqn0NWL7Vr7oafztefnHaszw7K3uuz09LBrP5j4V4x+cNrSHX
 ap4u63DabA0n562MDudIrW1Gxb+uIsRVQ8MxcYUh3OyNjyn9ADaEVCgLEEZzZ8O2h4ky
 JbMVf8Qg1JXbw/di8miG4sMy7T5UZpbcK7ETYfKFhWSbyyV0fQySVHDuRQVzhQOzJJrW
 SurxLl4CtQagpHXzu8NgsIwqeY7OLIBsyJ2/kqUn9hoguhVnmjC+5SxwYw/T6L7KZZ5+
 mLlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6jkwhG9KI0suzdlb3RqRdJkiC9qbxs1EE8cHfkE8vZTxkxJb/s4MVnOTumLGjFleVQ0R/M55d+KSjrr/5yqQ8EuHhPuI=
X-Gm-Message-State: AOJu0Yy1GTOp8pT8el7W5nn7Ngy9WdbwlDB+s9QEBsqAs7YC++YuzOpt
 3Wqv/zHzVndzquzRlHxHPTxi4gV+GFsrcsQzp2P6i4wvb+qz/vT9kyWfOetoL1M=
X-Google-Smtp-Source: AGHT+IGU52vjmsj/wzHnjf/8YkolludOtvkGpmF331xjXuCbU37X43fmtPE1X4UJDKHwRtwqy0DQuA==
X-Received: by 2002:a05:6512:5d3:b0:52b:c192:c19c with SMTP id
 2adb3069b0e04-52ccaa33fd4mr3293302e87.21.1718907211958; 
 Thu, 20 Jun 2024 11:13:31 -0700 (PDT)
Received: from meli-email.org (adsl-31.37.6.1.tellas.gr. [37.6.1.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0b8d9csm34052775e9.7.2024.06.20.11.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 11:13:31 -0700 (PDT)
Date: Thu, 20 Jun 2024 21:06:41 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
 <ae1397b5-4154-4aeb-bf5f-3a62adcc05fd@redhat.com>
In-Reply-To: <ae1397b5-4154-4aeb-bf5f-3a62adcc05fd@redhat.com>
Message-ID: <fe5ah.cugg8hrhlzn0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x132.google.com
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

On Thu, 20 Jun 2024 16:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On 6/19/24 22:13, Manos Pitsidianakis wrote:
>> Add options for Rust in meson_options.txt, meson.build, configure to
>> prepare for adding Rust code in the followup commits.
>> 
>> `rust` is a reserved meson name, so we have to use an alternative.
>> `with_rust` was chosen.
>> 
>> A cargo_wrapper.py script is added that is heavily based on the work of
>> Marc-André Lureau from 2021.
>> 
>> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com/
>> 
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
>The cargo_wrapper.py script is not used yet, so it should be
>delayed until it's used.

That's true, I just wanted to make review easier by splitting it out. 
Can we squash them later or do you think I should I do it for the next 
series version?



>
>For the detection of the toolchain, I'd rather do everything in
>configure since that's where the cross file is built.  Something like:
>
>diff --git a/configure b/configure
>index 8b6a2f16ceb..6412a1021c3 100755
>--- a/configure
>+++ b/configure
>@@ -173,6 +173,8 @@ fi
>  
>  # default parameters
>  container_engine="auto"
>+rust_target_triple=""
>+with_rust="no"
>  cpu=""
>  cross_compile="no"
>  cross_prefix=""
>@@ -201,6 +202,8 @@ for opt do
>    --cross-prefix=*) cross_prefix="$optarg"
>                      cross_compile="yes"
>    ;;
>+  --cargo=*) CARGO="$optarg"
>+  ;;
>    --cc=*) CC="$optarg"
>    ;;
>    --cxx=*) CXX="$optarg"
>@@ -317,6 +322,8 @@ windmc="${WINDMC-${cross_prefix}windmc}"
>  pkg_config="${PKG_CONFIG-${cross_prefix}pkg-config}"
>  sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
>  
>+cargo="${CARGO-cargo}"
>+
>  check_define() {
>  cat > $TMPC <<EOF
>  #if !defined($1)
>@@ -628,6 +635,8 @@ for opt do
>    ;;
>    --cross-prefix=*)
>    ;;
>+  --cargo=*)
>+  ;;
>    --cc=*)
>    ;;
>    --host-cc=*) host_cc="$optarg"
>@@ -755,8 +764,14 @@ for opt do
>    ;;
>    --container-engine=*) container_engine="$optarg"
>    ;;
>+  --rust-target-triple=*) rust_target_triple="$optarg"
>+  ;;
>    --gdb=*) gdb_bin="$optarg"
>    ;;
>+  --with-rust) with_rust=yes
>+  ;;
>+  --without-rust) with_rust=no
>+  ;;
>    # everything else has the same name in configure and meson
>    --*) meson_option_parse "$opt" "$optarg"
>    ;;
>@@ -854,6 +869,7 @@ $(echo Available targets: $default_target_list | \
>  Advanced options (experts only):
>    -Dmesonoptname=val       passthrough option to meson unmodified
>    --cross-prefix=PREFIX    use PREFIX for compile tools, PREFIX can be blank [$cross_prefix]
>+  --cargo=CARGO            use Cargo binary CARGO [$cargo]
>    --cc=CC                  use C compiler CC [$cc]
>    --host-cc=CC             when cross compiling, use C compiler CC for code run
>                             at build time [$host_cc]
>@@ -869,11 +885,13 @@ Advanced options (experts only):
>    --python=PYTHON          use specified python [$python]
>    --ninja=NINJA            use specified ninja [$ninja]
>    --static                 enable static build [$static]
>-  --without-default-features default all --enable-* options to "disabled"
>-  --without-default-devices  do not include any device that is not needed to
>+  --rust-target-triple=TRIPLE  target for Rust cross compilation
>+  --without-default-features   default all --enable-* options to "disabled"
>+  --without-default-devices    do not include any device that is not needed to
>                             start the emulator (only use if you are including
>                             desired devices in configs/devices/)
>    --with-devices-ARCH=NAME override default configs/devices
>+  --with-rust              enable experimental Rust code
>    --enable-debug           enable common debug build options
>    --cpu=CPU                Build for host CPU [$cpu]
>    --disable-containers     don't use containers for cross-building
>@@ -1138,6 +1159,20 @@ EOF
>    fi
>  fi
>  
>+##########################################
>+# detect rust triples
>+
>+if test "$with_rust" = yes; then
>+  $CARGO -vV > "${TMPDIR1}/${TMPB}.out"
>+  if test $? != 0; then
>+    error_exit "could not execute cargo binary \"$CARGO\""
>+  fi
>+  rust_host_triple=$(sed -n 's/^host: //p' "${TMPDIR1}/${TMPB}.out")
>+  if test "$rust_target_triple" = ""; then
>+    rust_target_triple=$rust_host_triple
>+  fi
>+fi
>+
>  ##########################################
>  # functions to probe cross compilers
>  
>@@ -1604,6 +1639,10 @@ if test "$container" != no; then
>      echo "RUNC=$runc" >> $config_host_mak
>  fi
>  echo "SUBDIRS=$subdirs" >> $config_host_mak
>+if test "$with_rust" = yes; then
>+  echo "RUST_HOST_TRIPLE=$rust_host_triple" >> $config_host_mak
>+  echo "RUST_TARGET_TRIPLE=$rust_target_triple" >> $config_host_mak
>+fi
>  echo "PYTHON=$python" >> $config_host_mak
>  echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
>  echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
>@@ -1731,6 +1770,13 @@ if test "$skip_meson" = no; then
>    echo "c = [$(meson_quote $cc $CPU_CFLAGS)]" >> $cross
>    test -n "$cxx" && echo "cpp = [$(meson_quote $cxx $CPU_CFLAGS)]" >> $cross
>    test -n "$objcc" && echo "objc = [$(meson_quote $objcc $CPU_CFLAGS)]" >> $cross
>+  if test "$with_rust" = yes; then
>+    if test "$rust_host_triple" != "$rust_target_triple"; then
>+      echo "cargo = [$(meson_quote $cargo --target "$rust_target_triple")]" >> $cross
>+    else
>+      echo "cargo = [$(meson_quote $cargo)]" >> $cross
>+    fi
>+  fi


Hm that looks better indeed, thanks!


>    echo "ar = [$(meson_quote $ar)]" >> $cross
>    echo "dlltool = [$(meson_quote $dlltool)]" >> $cross
>    echo "nm = [$(meson_quote $nm)]" >> $cross
>diff --git a/meson.build b/meson.build
>index c5360fbd299..ad7dbc0d641 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -290,6 +290,11 @@ foreach lang : all_languages
>    endif
>  endforeach
>  
>+cargo = not_found
>+if 'RUST_TARGET_TRIPLE' in config_host
>+  cargo = find_program('cargo', required: true)
>+endif
>+
>  # default flags for all hosts
>  # We use -fwrapv to tell the compiler that we require a C dialect where
>  # left shift of signed integers is well defined and has the expected
>@@ -4239,6 +4244,10 @@ if 'objc' in all_languages
>  else
>    summary_info += {'Objective-C compiler': false}
>  endif
>+summary_info += {'Rust support':      cargo.found()}
>+if cargo.found() and config_host['RUST_TARGET_TRIPLE']) != config_host['RUST_HOST_TRIPLE']
>+  summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
>+endif
>  option_cflags = (get_option('debug') ? ['-g'] : [])
>  if get_option('optimization') != 'plain'
>    option_cflags += ['-O' + get_option('optimization')]
>
>

