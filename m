Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B33CF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLtT-0008Sj-Mo; Thu, 03 Oct 2024 09:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtR-0008S4-FI
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtP-0005wW-J3
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:21 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a90349aa7e5so135180366b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727962157; x=1728566957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2ZKKykwImDhoaWZeHGDZQxSxR5oO5NarAAhJf0FEpE=;
 b=qFHaoIrF+0W4EbBDQkxHEKngaS5a2wEOe8m9CPzAnpVJWnkHt0kZZS3ieiqia04KJs
 AAq2SAjaFQbAtOVZn/yjxpPbEeMcOhA8l/dssl7cPWXTRXUfuULKJWwNro1FAETKaW+5
 5hi98svrwnMLM9NuDvT2A8tbAiojWj04NTIhKdFhw3VUDXmJ29tXBEpfDYK7PLBMEzWg
 0CruvuDoh2rfTG6UdTDpEDFutkEL3gaE6wnDMjcVUQnpe3Zs2Nm8gLdlv5CK0Y3/R7Rh
 7td7ZMyxZyeGH4WmnDFulUKkpU/KxAxpKPh1ihVPx4gR5xwVGCzZTvk/AZlsWT5vhyOG
 X4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727962157; x=1728566957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2ZKKykwImDhoaWZeHGDZQxSxR5oO5NarAAhJf0FEpE=;
 b=XUkxQm27wDTTZAaOdYOYd2B0K4FVOFbK20FUXw+f4kFzlevolI4mTQad6vp/gzifqo
 XZkDh+fHKeLTdFl/kdS7TbjJFcAX2hhAtDZUrQA2wbbrE94U2kQ5IQ0vvKYKRqx75svY
 SzSovrxupe8gHriGsCNBEqWLd/btSVAUvDG0qB4e+Ikl3MUd3ZATn/KcsHuS4VDdTI2q
 323BQiLlNmUxj4QfUEIL6CjGoej0zR0BgEuWipfqIQaM5UUkVBLIjkdWFse5SI21XHBF
 xQJw+D1Wf5sZ4FNv4xeRV2iUFOpyuyQ9eUGDRxzqs5UAd2xZ/HAW8rSMX4TkDRZvTqBW
 Ow3Q==
X-Gm-Message-State: AOJu0YxDwOzk1w8xK6vEUYrkmZ96D2zc8JT5N+20jQT3Qof1+AqnjmPK
 lpZI43CaqdmKq6GDNwBAKhPzpmYzSJYXIJSPbZqrfeo8GXld+JNX/821LGiQbIyrQq35AT47Rfh
 579Q=
X-Google-Smtp-Source: AGHT+IFMPh42cK0C4Rj5sg4KyfpMi6Wo/u22LHgV3NwHDo457VjUXlbuxdyjmRrLr60R4cOakYmTsA==
X-Received: by 2002:a17:906:f589:b0:a8a:7bed:d327 with SMTP id
 a640c23a62f3a-a98f825aa3dmr523652066b.36.1727962156909; 
 Thu, 03 Oct 2024 06:29:16 -0700 (PDT)
Received: from localhost.localdomain (adsl-122.37.6.160.tellas.gr.
 [37.6.160.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99102a4cdcsm86528366b.57.2024.10.03.06.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 06:29:16 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Junjie Mao <junjie.mao@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, berrange@redhat.com, hi@alyssa.is
Subject: [PATCH v11 2/9] build-sys: Add rust feature option
Date: Thu,  3 Oct 2024 16:28:44 +0300
Message-ID: <14642d80fbccbc60f7aa78b449a7deb5e2784ed9.1727961605.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
References: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

Add rust feature in meson.build, configure, to prepare for adding Rust
code in the followup commits.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS                   |  5 +++++
 meson.build                   | 22 +++++++++++++++++++++-
 Kconfig                       |  1 +
 Kconfig.host                  |  3 +++
 meson_options.txt             |  3 +++
 rust/Kconfig                  |  0
 scripts/meson-buildoptions.sh |  3 +++
 7 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 rust/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ee2699543..35278c016a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4195,6 +4195,11 @@ F: docs/sphinx/
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
index 127b673540..8a106e39c2 100644
--- a/meson.build
+++ b/meson.build
@@ -70,6 +70,19 @@ if host_os == 'darwin' and \
   all_languages += ['objc']
   objc = meson.get_compiler('objc')
 endif
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
@@ -2158,6 +2171,7 @@ endif
 
 config_host_data = configuration_data()
 
+config_host_data.set('CONFIG_HAVE_RUST', have_rust)
 audio_drivers_selected = []
 if have_system
   audio_drivers_available = {
@@ -3104,7 +3118,8 @@ host_kconfig = \
   (host_os == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
-  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : [])
+  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
+  (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
@@ -4315,6 +4330,11 @@ if 'objc' in all_languages
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
index 783b56bcb9..bf0d5d2d2f 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -375,3 +375,6 @@ option('hexagon_idef_parser', type : 'boolean', value : true,
 
 option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
        description: 'tweak required x86_64 architecture version beyond compiler default')
+
+option('rust', type: 'feature', value: 'auto',
+       description: 'Rust support')
diff --git a/rust/Kconfig b/rust/Kconfig
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 107a8f69ce..e2a22c0ee7 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -172,6 +172,7 @@ meson_options_help() {
   printf "%s\n" '  rbd             Ceph block device driver'
   printf "%s\n" '  rdma            Enable RDMA-based migration'
   printf "%s\n" '  replication     replication support'
+  printf "%s\n" '  rust            Rust support'
   printf "%s\n" '  rutabaga-gfx    rutabaga_gfx support'
   printf "%s\n" '  sdl             SDL user interface'
   printf "%s\n" '  sdl-image       SDL Image support for icons'
@@ -458,6 +459,8 @@ _meson_option_parse() {
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
     --disable-rng-none) printf "%s" -Drng_none=false ;;
+    --enable-rust) printf "%s" -Drust=enabled ;;
+    --disable-rust) printf "%s" -Drust=disabled ;;
     --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=enabled ;;
     --disable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=disabled ;;
     --enable-safe-stack) printf "%s" -Dsafe_stack=true ;;
-- 
γαῖα πυρί μιχθήτω


