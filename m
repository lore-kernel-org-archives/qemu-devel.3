Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF06FC5472D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 04:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjA2v-0006Am-CW; Wed, 28 Aug 2024 00:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2r-0005wU-CP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:33 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2b-0000lN-44
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:32 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f3f68dd44bso71360031fa.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 21:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724818335; x=1725423135; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9WoYTkRlZjZ2IZzUB0XlbV4XpCuF84zvKRFt/cs2e0E=;
 b=uUmg8zxk7iICXM/rHzrsLZiTVwUpZc/LaogpiInIRxm2TMyQT8fsJnEQUUOrMc/mPM
 Hr/jtLYjQ9nQP7bH3UmqWnKYyEiEC1RlTwzTLlbgqIt5q1UIVGwZI2VS4QCYxalew1A5
 dcgUMtT/RvHAlsFBua68jnRfbFE5iLDiV5A8EfYQycSNRLfLZRtWdQakcdlIpMKu7N4A
 QjEb92AwSUVdSe451Fb1uzUY5aKXSfMJXRCtMi1U6giWdwWN1ONY04p3Gg3FhlPfPZOA
 5mns0sPKn2VOGLEru5moXn5sYMZxSI5bSyxPzykQDn3jQpBFW2N1hKw54vx/5848LneJ
 dMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724818335; x=1725423135;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WoYTkRlZjZ2IZzUB0XlbV4XpCuF84zvKRFt/cs2e0E=;
 b=IgbSGsD1ln3zjEUYYt7JgVF8L1iAvn7WcEybOPeoY71Dwz0GmLUv2Ct2xoDXWUBdbZ
 8KDbkhBou+99TU/eJRFln/xcoWwndzqzXqjqG2PRVVKVBKv6hrs+q9a5BrvXX+x1UBJR
 mfMeMc+C4xzWQ4YjjJZJmMVZYkWKreBSZqvxJjSPZyhUwUkTq9L4nO/kmIuDEPYx+ewg
 S5fWwcTCyqWdiUxPHLukKJv+bbtw80HYA7bt5stMtl4E3HV/Oqea75UU/qXLfeR2epbZ
 Org1ETfab9q8wcHcExBdTFoXCkuiT+Yed4uDa2IZZpaEbe0/jkO2RZO8W/TMWIcokiKq
 mUJQ==
X-Gm-Message-State: AOJu0Yyt1FWdp6iZC3UwmDRvfWs26izkw1wSY5Wj5tzpGTkCFF5ATDi0
 eBP3smurMGElE1J2/esUlk2aJp3pshflhYARXiimOxgyTjSrgShvL1prrXj7szs=
X-Google-Smtp-Source: AGHT+IGzVWr2eP+ZnL9PCFFkpa0auntXgXcG10Mtkv6A3g/V+jfXbdDPzO9WOtrKyLdtzsLgze+wDg==
X-Received: by 2002:a2e:9ec7:0:b0:2f5:6b4:1d2b with SMTP id
 38308e7fff4ca-2f55b68e409mr3487811fa.13.1724818334330; 
 Tue, 27 Aug 2024 21:12:14 -0700 (PDT)
Received: from [127.0.1.1] (adsl-98.109.242.227.tellas.gr. [109.242.227.98])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb1c29b9sm1712814a12.18.2024.08.27.21.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 21:12:13 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 28 Aug 2024 07:11:43 +0300
Subject: [PATCH RESEND v9 2/9] build-sys: Add rust feature option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-rust-pl011-v9-2-35579191f17c@linaro.org>
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
In-Reply-To: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
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
X-Mailer: b4 0.15-dev-c2c95
X-Developer-Signature: v=1; a=openpgp-sha256; l=5802;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=Yp49pdC3qe7SuaqJZKWE381hHC9X4adl+M5esNSQkcc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16cU9MSTYyL1QzbGZQREVLNFRqYjhMYXoyYkh1CnFPalc0ZDBJVVRybU02b3Zu
 N1dKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnM2aml3QUt
 DUkIzS2Nkd2YzNEowRE0xRUFDV3dJOFYvOG96NFdvK1MwL2NDTFcwbndwYmF5dktjdjNmdHNyTA
 plNFAzK3RTRGlVM2ovbWMyYjlGcC8xcy9FcCs3dkxNR1ZNUlF2NkNWWHdUNHozZHdCZHhZUklFd
 Dc1V1RQZEZVCm9adFphUUFQSjN4UlhZcmZ4bjQzTWlSWHRQMTgyNGRjYUU4Rm42KzZmYmN5SWtC
 YlJRMXBXd3ZCREhQbDZTN0MKNkxucjdZKzJVWFhOWXdYajlMQ0FaNWw4YkhpRTBNcXkreE9Fa2Z
 NWTQxNUR4N2tqQVpUTU5SVmY4U1JKSmNxMgo5aFJ0c29ZVmZobytxVk9QSm96ZFNGRWtUU2N2aT
 B4MHQrb2JLNVY5aTV2cGUxK2NudnA5VDA3ZE9zQXVncFMzCmRQQkx2cGQ0Y3RuTHBDM3lvaXFzd
 TdvOW1TbWlZRE1hMENsQXE0NXkzS3p5d1R5NTUrUnkwMWpCTk5YMUIrUGoKNmNTc2hjTTFtK1R3
 MjJYRHRzUWVHaE9mRjlvejZSTFUvSU16S3FPWW1INGRNaE1JZnR6dUdSTndlcEdJUkp5Qgo3U0V
 keGZkclJjNm1qWUluUkptN1JVQk5UNjV2a2lpVURBbkcrWE9pTlNnV0FuUGM2dGhveklJN2YrSl
 ZhMXBECnRDUjhrNEFwaEdPNDRQbGRxdmtCVy9IVkJTNWgyeHRTVHZHRWIzU2MzV3hhNE90Q20ze
 XUvMThrTEYxZnVyVXIKNUh0bHFHd1hNRzg1K0lCUEdLT3Q0TVBuTW9lMUtkUVQvQTNFdjBsUWlI
 SnBGNEcveksvd2hIWDRvUGRwL29WdgpsTk9MNVo5RDBabEpoSERNRVkwS2VGNWFqRlEwQm9uM0J
 yQUt6aTRGR0NKdm5YYUoydkM0ZWNuUHYwNy9BR0s4CnVjYkZ6UT09Cj1SOHdnCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add rust feature in meson.build, configure, to prepare for adding Rust
code in the followup commits.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                   |  5 +++++
 meson.build                   | 25 ++++++++++++++++++++++++-
 Kconfig                       |  1 +
 Kconfig.host                  |  3 +++
 meson_options.txt             |  3 +++
 rust/Kconfig                  |  0
 scripts/meson-buildoptions.sh |  3 +++
 7 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3584d6a6c6da9a3210150534d640d29ddf329dce..0bc8e515daf7e63320620b52b42a799b99dbe035 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4243,6 +4243,11 @@ F: docs/sphinx/
 F: docs/_templates/
 F: docs/devel/docs.rst
 
+Rust build system integration
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Maintained
+F: rust/Kconfig
+
 Miscellaneous
 -------------
 Performance Tools and Tests
diff --git a/meson.build b/meson.build
index 7eb4b8a41c0a667cacf693cfa2764f326ba72b1f..67eb4eda649d5f0566de2b75466b5a9d9ca87ab4 100644
--- a/meson.build
+++ b/meson.build
@@ -70,6 +70,22 @@ if host_os == 'darwin' and \
   all_languages += ['objc']
   objc = meson.get_compiler('objc')
 endif
+if get_option('rust').enabled() and meson.version().version_compare('<1.0.0')
+  error('Rust support requires Meson version >=1.0.0')
+endif
+have_rust = false
+if not get_option('rust').disabled() and add_languages('rust', required: get_option('rust'), native: false)
+  rustc = meson.get_compiler('rust')
+  have_rust = true
+  if rustc.version().version_compare('<1.80.0')
+    if get_option('rust').enabled()
+      error('rustc version ' + rustc.version() + ' is unsupported: Please upgrade to at least 1.80.0')
+    else
+      warning('rustc version ' + rustc.version() + ' is unsupported: Disabling Rust compilation. Please upgrade to at least 1.80.0 to use Rust.')
+      have_rust = false
+    endif
+  endif
+endif
 
 dtrace = not_found
 stap = not_found
@@ -2131,6 +2147,7 @@ endif
 
 config_host_data = configuration_data()
 
+config_host_data.set('CONFIG_HAVE_RUST', have_rust)
 audio_drivers_selected = []
 if have_system
   audio_drivers_available = {
@@ -3076,7 +3093,8 @@ host_kconfig = \
   (host_os == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
-  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : [])
+  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
+  (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
@@ -4287,6 +4305,11 @@ if 'objc' in all_languages
 else
   summary_info += {'Objective-C compiler': false}
 endif
+summary_info += {'Rust support':      have_rust}
+if have_rust
+  summary_info += {'rustc version':      rustc.version()}
+  summary_info += {'rustc':      ' '.join(rustc.cmd_array())}
+endif
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
   option_cflags += ['-O' + get_option('optimization')]
diff --git a/Kconfig b/Kconfig
index fb6a24a2de8c3ff11d4ee432d65ad000ba9d6c4d..63ca7f46df788144864b26ef5a64b29ad6547435 100644
--- a/Kconfig
+++ b/Kconfig
@@ -4,3 +4,4 @@ source accel/Kconfig
 source target/Kconfig
 source hw/Kconfig
 source semihosting/Kconfig
+source rust/Kconfig
diff --git a/Kconfig.host b/Kconfig.host
index 17f405004b3bc765890688304322a1937ca8c01c..4ade7899d67a5ed91928f8ee1e287f5ba3331949 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -52,3 +52,6 @@ config VFIO_USER_SERVER_ALLOWED
 
 config HV_BALLOON_POSSIBLE
     bool
+
+config HAVE_RUST
+    bool
diff --git a/meson_options.txt b/meson_options.txt
index 0269fa0f16ed6b6f734fcefa2cfa94aa029fa837..fa94a5ce97bb14ab108e21cccb651923ac6a58f8 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -371,3 +371,6 @@ option('hexagon_idef_parser', type : 'boolean', value : true,
 
 option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
        description: 'tweak required x86_64 architecture version beyond compiler default')
+
+option('rust', type: 'feature', value: 'auto',
+       description: 'Rust support')
diff --git a/rust/Kconfig b/rust/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c97079a38c9e4ed24a0fe9b44e492b7108481048..5e8a225a6b343cf506950a3146af718d52a6c1a0 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -170,6 +170,7 @@ meson_options_help() {
   printf "%s\n" '  rbd             Ceph block device driver'
   printf "%s\n" '  rdma            Enable RDMA-based migration'
   printf "%s\n" '  replication     replication support'
+  printf "%s\n" '  rust            Rust support'
   printf "%s\n" '  rutabaga-gfx    rutabaga_gfx support'
   printf "%s\n" '  sdl             SDL user interface'
   printf "%s\n" '  sdl-image       SDL Image support for icons'
@@ -452,6 +453,8 @@ _meson_option_parse() {
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
     --disable-rng-none) printf "%s" -Drng_none=false ;;
+    --enable-rust) printf "%s" -Drust=enabled ;;
+    --disable-rust) printf "%s" -Drust=disabled ;;
     --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=enabled ;;
     --disable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=disabled ;;
     --enable-safe-stack) printf "%s" -Dsafe_stack=true ;;

-- 
2.45.2


