Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B49C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHjL-0001tE-RJ; Thu, 20 Jun 2024 09:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHjH-0001ss-5h
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHjE-0001VW-K1
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718889687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z47dqQVwPbEfDl4OieNGpfA9uRFwpbr52+huqD3lgBo=;
 b=WKByFmY/9iTt3XvyI4JLsLFsPG5tf5lI+qZK6hhcfmDtqIyBSdzazkrgTrcIp+8dlpj7H8
 NlRkno7PwoZa7FveDgOTL6HB28Asjw95+I/oS+byhUNzPeG+qikwznFuJnGetj4ysWAfpg
 xHe+iGiCd+9s6DbrTg334qhY7NkBVD8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-P2_78G5wNbyurk8DZhhz-g-1; Thu, 20 Jun 2024 09:21:24 -0400
X-MC-Unique: P2_78G5wNbyurk8DZhhz-g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57c6979daf7so462866a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718889683; x=1719494483;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z47dqQVwPbEfDl4OieNGpfA9uRFwpbr52+huqD3lgBo=;
 b=vuZ4PBsxAToW1S5IUJ6//FfGzqaleQlEmTYPm5cpMv90u4EvgDD8IQ84x29UHSTMkq
 WsvqSqIwvEFdxjHFdW2Xk6KfSaZFBz6GjFtYAlCckiGEKoCVuvlfYNgpkgfXfEv51lbP
 q2+/aheX2viSpCUZVYa8jIWvrJeTcXUgT/GTQNmAHKMevED8yvtzMRMKnd0cylmDzVJO
 SJFDLYhZCrQ1MTa7EU/D/aPZDCobrRMuZa/9QQNshF2DERPKhg/kPNN/dnKLrwBQ8h2N
 v+QHcpNI9OelHqyES5Mq5cFo/kDk7Wzm21GcfgOaM0mQ7hJdRIIQpWbFrKyTA5tGCOTC
 XtkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVglskkQmR1DICznJjGEUjdxpz4brBTGGJJkN5RHSzRcQOpbgCwEnB+vllhT0MpS93ge4ib+4lArzknSeLmlBNBotciHa4=
X-Gm-Message-State: AOJu0Yw2K4Vpsk1z0D8KywMkWIkPGlvbnNplEUBdFBN7ZCo4VgyBPPOm
 Wm1i4XgBYkC7kH9BAh/5P6MftzxfqZ0HejamU1ZAp82qThTC5CC5iyxKZpRJeFZwaVKmhrTb6xG
 8pIWWd/njzQwRZpu/VkbvrzSse7SiC2zDflb4krQ+jXLbLK0egxw7
X-Received: by 2002:aa7:d055:0:b0:57d:10c7:aa4b with SMTP id
 4fb4d7f45d1cf-57d10c7aa78mr3064725a12.30.1718889683651; 
 Thu, 20 Jun 2024 06:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuRhQo45SeRyWBmqH4Yt9Ol0ZHLYf0jb/JJB4lfrxvRaolMROiEkm3R7sHRAygxmx8XW1KDA==
X-Received: by 2002:aa7:d055:0:b0:57d:10c7:aa4b with SMTP id
 4fb4d7f45d1cf-57d10c7aa78mr3064693a12.30.1718889683234; 
 Thu, 20 Jun 2024 06:21:23 -0700 (PDT)
Received: from [192.168.10.81] ([151.62.196.71])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57cbbb5576csm9097047a12.89.2024.06.20.06.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 06:21:22 -0700 (PDT)
Message-ID: <ae1397b5-4154-4aeb-bf5f-3a62adcc05fd@redhat.com>
Date: Thu, 20 Jun 2024 15:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
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
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/19/24 22:13, Manos Pitsidianakis wrote:
> Add options for Rust in meson_options.txt, meson.build, configure to
> prepare for adding Rust code in the followup commits.
> 
> `rust` is a reserved meson name, so we have to use an alternative.
> `with_rust` was chosen.
> 
> A cargo_wrapper.py script is added that is heavily based on the work of
> Marc-André Lureau from 2021.
> 
> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com/
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The cargo_wrapper.py script is not used yet, so it should be
delayed until it's used.

For the detection of the toolchain, I'd rather do everything in
configure since that's where the cross file is built.  Something like:

diff --git a/configure b/configure
index 8b6a2f16ceb..6412a1021c3 100755
--- a/configure
+++ b/configure
@@ -173,6 +173,8 @@ fi
  
  # default parameters
  container_engine="auto"
+rust_target_triple=""
+with_rust="no"
  cpu=""
  cross_compile="no"
  cross_prefix=""
@@ -201,6 +202,8 @@ for opt do
    --cross-prefix=*) cross_prefix="$optarg"
                      cross_compile="yes"
    ;;
+  --cargo=*) CARGO="$optarg"
+  ;;
    --cc=*) CC="$optarg"
    ;;
    --cxx=*) CXX="$optarg"
@@ -317,6 +322,8 @@ windmc="${WINDMC-${cross_prefix}windmc}"
  pkg_config="${PKG_CONFIG-${cross_prefix}pkg-config}"
  sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
  
+cargo="${CARGO-cargo}"
+
  check_define() {
  cat > $TMPC <<EOF
  #if !defined($1)
@@ -628,6 +635,8 @@ for opt do
    ;;
    --cross-prefix=*)
    ;;
+  --cargo=*)
+  ;;
    --cc=*)
    ;;
    --host-cc=*) host_cc="$optarg"
@@ -755,8 +764,14 @@ for opt do
    ;;
    --container-engine=*) container_engine="$optarg"
    ;;
+  --rust-target-triple=*) rust_target_triple="$optarg"
+  ;;
    --gdb=*) gdb_bin="$optarg"
    ;;
+  --with-rust) with_rust=yes
+  ;;
+  --without-rust) with_rust=no
+  ;;
    # everything else has the same name in configure and meson
    --*) meson_option_parse "$opt" "$optarg"
    ;;
@@ -854,6 +869,7 @@ $(echo Available targets: $default_target_list | \
  Advanced options (experts only):
    -Dmesonoptname=val       passthrough option to meson unmodified
    --cross-prefix=PREFIX    use PREFIX for compile tools, PREFIX can be blank [$cross_prefix]
+  --cargo=CARGO            use Cargo binary CARGO [$cargo]
    --cc=CC                  use C compiler CC [$cc]
    --host-cc=CC             when cross compiling, use C compiler CC for code run
                             at build time [$host_cc]
@@ -869,11 +885,13 @@ Advanced options (experts only):
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
+  --with-rust              enable experimental Rust code
    --enable-debug           enable common debug build options
    --cpu=CPU                Build for host CPU [$cpu]
    --disable-containers     don't use containers for cross-building
@@ -1138,6 +1159,20 @@ EOF
    fi
  fi
  
+##########################################
+# detect rust triples
+
+if test "$with_rust" = yes; then
+  $CARGO -vV > "${TMPDIR1}/${TMPB}.out"
+  if test $? != 0; then
+    error_exit "could not execute cargo binary \"$CARGO\""
+  fi
+  rust_host_triple=$(sed -n 's/^host: //p' "${TMPDIR1}/${TMPB}.out")
+  if test "$rust_target_triple" = ""; then
+    rust_target_triple=$rust_host_triple
+  fi
+fi
+
  ##########################################
  # functions to probe cross compilers
  
@@ -1604,6 +1639,10 @@ if test "$container" != no; then
      echo "RUNC=$runc" >> $config_host_mak
  fi
  echo "SUBDIRS=$subdirs" >> $config_host_mak
+if test "$with_rust" = yes; then
+  echo "RUST_HOST_TRIPLE=$rust_host_triple" >> $config_host_mak
+  echo "RUST_TARGET_TRIPLE=$rust_target_triple" >> $config_host_mak
+fi
  echo "PYTHON=$python" >> $config_host_mak
  echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
  echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
@@ -1731,6 +1770,13 @@ if test "$skip_meson" = no; then
    echo "c = [$(meson_quote $cc $CPU_CFLAGS)]" >> $cross
    test -n "$cxx" && echo "cpp = [$(meson_quote $cxx $CPU_CFLAGS)]" >> $cross
    test -n "$objcc" && echo "objc = [$(meson_quote $objcc $CPU_CFLAGS)]" >> $cross
+  if test "$with_rust" = yes; then
+    if test "$rust_host_triple" != "$rust_target_triple"; then
+      echo "cargo = [$(meson_quote $cargo --target "$rust_target_triple")]" >> $cross
+    else
+      echo "cargo = [$(meson_quote $cargo)]" >> $cross
+    fi
+  fi
    echo "ar = [$(meson_quote $ar)]" >> $cross
    echo "dlltool = [$(meson_quote $dlltool)]" >> $cross
    echo "nm = [$(meson_quote $nm)]" >> $cross
diff --git a/meson.build b/meson.build
index c5360fbd299..ad7dbc0d641 100644
--- a/meson.build
+++ b/meson.build
@@ -290,6 +290,11 @@ foreach lang : all_languages
    endif
  endforeach
  
+cargo = not_found
+if 'RUST_TARGET_TRIPLE' in config_host
+  cargo = find_program('cargo', required: true)
+endif
+
  # default flags for all hosts
  # We use -fwrapv to tell the compiler that we require a C dialect where
  # left shift of signed integers is well defined and has the expected
@@ -4239,6 +4244,10 @@ if 'objc' in all_languages
  else
    summary_info += {'Objective-C compiler': false}
  endif
+summary_info += {'Rust support':      cargo.found()}
+if cargo.found() and config_host['RUST_TARGET_TRIPLE']) != config_host['RUST_HOST_TRIPLE']
+  summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
+endif
  option_cflags = (get_option('debug') ? ['-g'] : [])
  if get_option('optimization') != 'plain'
    option_cflags += ['-O' + get_option('optimization')]



