Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D25CC54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuIh-0002aT-AY; Tue, 27 Aug 2024 07:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIc-0002Mr-1M
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:47 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIa-0000i5-45
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:45 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5bf0261f162so6401670a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724757821; x=1725362621; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VBrGB2rIabK5bRnXDdQUAS0ChrK3HI/3tgD35y925mM=;
 b=Zs/UjZlRI7iPK7pTM4lfnK1/6iGtb4s+M5P7BSicLULwSp0NSKiQ+4EMVeeHXz6drB
 IbfzPJICYpKgCgVlYUH2wV2UPcpLZeBxQ+QNoiFJ4NWWvsiUjFoidn8ubNUZdcH0B87a
 ypSW/K4DhvcOZMsWg9F9eo/6Xj1pwinzX1U5ZjozRL8eNuYy2DEhk5whva7onr7O3umW
 J+3hXIvHTcN3ScSANhwzufWTrCVKOBHE71In+CxY4pZ+/vJS8G3/3iAAcKfs+7yAIl/4
 ndLJfULB4kxV7c3a/gq/c3FRGVD5ea+4OKqaRNxhiNKwwcJYWCQ1TSIrAVGrpId7bghK
 WvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724757821; x=1725362621;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBrGB2rIabK5bRnXDdQUAS0ChrK3HI/3tgD35y925mM=;
 b=syQe6SyyBmDLS8hcONW4EDtyhf2Z22V8tIlgb4vKg4jxT8mGIkZ7qyowZ2vwzxMgzj
 InDIQZTCFE+iz+eY+4JyeZyzbbvaclnwvKr5RfManXd+44pA3QscS9RzUkm2zjD9TlVm
 JvHk3wjnMf9qThJgi8xi0bcLTDL4+/lko86YuYNcBTHdpa1kNw/pP/47ui4/l+kRAnVo
 ilqz9lOVTUZ4zoI56lcCFNMVZisAOBgLcWg8NZRoDznK/UoB/2/wYIe8ZcUH/0AB+vUE
 P9z5VvcDud/+avPFMPz0yQqPFaMVkatSw76geyvKVkUv06+SvJQwp+HdsgEPkkXXRPVc
 6kzQ==
X-Gm-Message-State: AOJu0YwYJAOyktwiMCEeXP6COYwYFE7pNmY34bYeS3BagyyuOdnr6sbO
 y/U4ZoiYVfs66LAvZFqDi+8gMaMScrLfp+tYwe3e+Vugnn+jJ8Cl8WRHqbQ2Qe8=
X-Google-Smtp-Source: AGHT+IHNc+0VNpANIwhoFDLBOJA0FLWrq7dKBQo7uAoBKBh+Th2zVXXor79/oGv8gn60QovMRlTPsg==
X-Received: by 2002:a17:907:3f9c:b0:a86:829d:317d with SMTP id
 a640c23a62f3a-a86a54f1d7bmr886132666b.64.1724757820937; 
 Tue, 27 Aug 2024 04:23:40 -0700 (PDT)
Received: from [127.0.1.1] (adsl-242.37.6.163.tellas.gr. [37.6.163.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594fa62sm96280066b.198.2024.08.27.04.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 04:23:40 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 27 Aug 2024 14:23:11 +0300
Subject: [PATCH v9 2/9] build-sys: Add rust feature option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-rust-pl011-v9-2-e90b9c28f861@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5382;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=3LMB6uiIZAXVyWYVGKFI5y1FnJ9yr/XphSJDOwWdl1c=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16YmMwYkxYSEcvc3M5TzJqU3g2SWpFVmg1ZWlLCnNoQThzUnM3YUpwOU1OSlNP
 V2VKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnMyM05BQUt
 DUkIzS2Nkd2YzNEowTEhnRC85SGVNNlFIaUNVUmF6KzZhRS9MbFBESlZ3M3pKZjBjMlYwSzRxVA
 plWWozTFMreEdud01ONFhlczQ0SDR4Q3lYQVY4a1lJbm1tMUEzdWNiTU5qQnU3a0hEcXFHTWVCa
 EwwWjVETVRqCkYrU3hTM1RSaEFJakdGcEFTK05jNVcrdjZ6QllEVTRVRzIrOGphZENhRG9SSVk3
 VDVKWUplWHZibmFGcG5XWHYKWG51bm5xeExZcHdiM0NlWVprZjQyMDh4WHVCcU44cmcyOCtnZ0M
 0TkFSOG5xdkxJTHZxVkhjMU82VUlJREJITgprM1k2ZkdZU2ZXbWxJL2xkWHF0Q3BWcm9mYTZOb1
 ArMUtFWEFNOTB4VldQQVN0Rk1iVGo4ZmdtakYzTCt0SU9ZCkFpRXh6NlJETnBkbWR6TndlTlpRM
 k0xQngvcDRSSk1zVzVRUS80cGZuaTNSRkRhekVFaUhEVXhOT0VoWXJENlMKSGxGS0Y1SjcxS3Ay
 emVCblBFZXBNa1g1MGF1dmVNYVRHeHphbVY5R3FsQXdKVnFNdFptMDhkZHdIV3NIYTcxMwphdVh
 LSzl6RUdSazUrMS8xcHpDcVFpM0UzTVd2ZmpMemc1VFhsUXhyWTNabDI1empxUzdQbkRkZ0s0dE
 RkWkVuCmk4Y3ZaM2s3ZHplbGpLaWxkZEE4ZEFkdXhub3NzWVBCbFd1Wm1SOG0rZ2hvdkwrZW53d
 2UxQU96NTZuWkFzK08KVm9ySXN2Q21IVHFTNDNybS9lMjYwQ0wxTzNwaXUwWnBXdlRNT3diL2x2
 d25wMUtLZ3ZPYWhlTGsxKzRvdXJnZwpuc2ZZS0NDMXNwNWVpWUgwVGN2dFRXeHZKMHI3MlJCTWF
 Ldk9RVVJXWXRmc2NLMm1Kb1FjRHdIeHI5OXdhaGxZCkpEaXZCZz09Cj0zdmpECi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
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
index 3584d6a6c6..0bc8e515da 100644
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
index 7eb4b8a41c..67eb4eda64 100644
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
index fb6a24a2de..63ca7f46df 100644
--- a/Kconfig
+++ b/Kconfig
@@ -4,3 +4,4 @@ source accel/Kconfig
 source target/Kconfig
 source hw/Kconfig
 source semihosting/Kconfig
+source rust/Kconfig
diff --git a/Kconfig.host b/Kconfig.host
index 17f405004b..4ade7899d6 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -52,3 +52,6 @@ config VFIO_USER_SERVER_ALLOWED
 
 config HV_BALLOON_POSSIBLE
     bool
+
+config HAVE_RUST
+    bool
diff --git a/meson_options.txt b/meson_options.txt
index 0269fa0f16..fa94a5ce97 100644
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
index 0000000000..e69de29bb2
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c97079a38c..5e8a225a6b 100644
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


