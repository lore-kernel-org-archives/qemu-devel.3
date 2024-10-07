Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EFDCFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlX7-0001lc-NO; Mon, 07 Oct 2024 07:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlX5-0001km-KT
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlX3-0006Ti-Hd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728299044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CeV6EY183bfuM+XUE1UfKE7DRa4bTrUF6uqcDnlyIPg=;
 b=D+eHeIyjEsmjGadx0ZMGIMES6tFEpcd2Ed62SO3IMWjlWwf/H6wfnUJvkXvnMQWJmRcELp
 2CfePaG+1lE1oAxlGfYFmGgyct9oCg6WNZPIMdM7G6IbaEDrQaMSUwULmXC+hE5y/e2vvG
 UNnCgeLZecRZv+2tDQXhADRjB4LvXk4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-WjlwII2QPxOPV4Bwo1wKgA-1; Mon, 07 Oct 2024 07:04:02 -0400
X-MC-Unique: WjlwII2QPxOPV4Bwo1wKgA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42ac185e26cso38119305e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728299040; x=1728903840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CeV6EY183bfuM+XUE1UfKE7DRa4bTrUF6uqcDnlyIPg=;
 b=ta3o1aCq7COt5WGVoCyHYnBW67XzPQFJjBoHsi1MmIrx43qRY10mL46AkNtutSfK58
 W9AWF10aOVDhqMh5fCDpOHlfiajhdRc1JXEW9WqnZ7Yz0yrRMcSQUnOogaw47K+kKxUU
 xx4IwYlaoPnMQvM6KS3aXAOZ5gg05cGzO6aj0+c6KuPrFwfQy+KYCINRMLcYY1LDf2Zy
 RbMC2uzaL21G8AZ5aFAieOQQmaLT5t9f4q7fDl0RL9WdafYtn1ivVlSsUFdKX5gBReBi
 5vk1S0yYwaVtt0Y3uYGy0ygcmyK9A4vSyG+19GtiTsVX7gfkDqmLqQb00xGh+Om3Afb7
 7qDQ==
X-Gm-Message-State: AOJu0YzDD7+MB+vBT6hPY/BF6YWxIGSpy+QzMPg9V5/Ou2Dqg9j72ORQ
 a2in4eUAHM0XGl8/U9e/0gd/Eg76PrvXISypm8eElxNpVeGtGhRlln7glBGeJgw0DSNzvo+iNc1
 ljUR6UdjFo1ltJeQgSLgNsBUcp6aFQLwVoByNxmYiuwt0NbvUUz9WY9UwVMLvEqZox8UaeV+SE3
 L5t0QCNE6En7Gw7sGArrl7MihTd9u4EjG3rNM9FYU=
X-Received: by 2002:a05:600c:3c90:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-42f85aef748mr80289005e9.30.1728299039976; 
 Mon, 07 Oct 2024 04:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkod+hjeZrHuwTg1czjijAflyqQfqXRVeLz4Ihc8KO+RUO2BcR0IGQeJc561F0DKRH+r4hzA==
X-Received: by 2002:a05:600c:3c90:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-42f85aef748mr80288755e9.30.1728299039456; 
 Mon, 07 Oct 2024 04:03:59 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1695e62bsm5489247f8f.81.2024.10.07.04.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 04:03:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com, junjie.mao@intel.com,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org
Subject: [PULL 02/12] build-sys: Add rust feature option
Date: Mon,  7 Oct 2024 13:03:30 +0200
Message-ID: <20241007110342.1298598-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007110342.1298598-1-pbonzini@redhat.com>
References: <20241007110342.1298598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add rust feature in meson.build, configure, to prepare for adding Rust
code in the followup commits.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://lore.kernel.org/r/14642d80fbccbc60f7aa78b449a7deb5e2784ed9.1727961605.git.manos.pitsidianakis@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 72359066d39..fb3188c053e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4188,6 +4188,11 @@ F: docs/sphinx/
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
index e6a65463ff9..93ddaef500f 100644
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
@@ -3097,7 +3111,8 @@ host_kconfig = \
   (host_os == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
-  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : [])
+  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
+  (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
@@ -4308,6 +4323,11 @@ if 'objc' in all_languages
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
index fb6a24a2de8..63ca7f46df7 100644
--- a/Kconfig
+++ b/Kconfig
@@ -4,3 +4,4 @@ source accel/Kconfig
 source target/Kconfig
 source hw/Kconfig
 source semihosting/Kconfig
+source rust/Kconfig
diff --git a/Kconfig.host b/Kconfig.host
index 17f405004b3..4ade7899d67 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -52,3 +52,6 @@ config VFIO_USER_SERVER_ALLOWED
 
 config HV_BALLOON_POSSIBLE
     bool
+
+config HAVE_RUST
+    bool
diff --git a/meson_options.txt b/meson_options.txt
index 5ee1d95c9ca..5a5c2300261 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -373,3 +373,6 @@ option('hexagon_idef_parser', type : 'boolean', value : true,
 
 option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
        description: 'tweak required x86_64 architecture version beyond compiler default')
+
+option('rust', type: 'feature', value: 'auto',
+       description: 'Rust support')
diff --git a/rust/Kconfig b/rust/Kconfig
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3bee1c56df3..6d08605b771 100644
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
@@ -456,6 +457,8 @@ _meson_option_parse() {
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
     --disable-rng-none) printf "%s" -Drng_none=false ;;
+    --enable-rust) printf "%s" -Drust=enabled ;;
+    --disable-rust) printf "%s" -Drust=disabled ;;
     --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=enabled ;;
     --disable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=disabled ;;
     --enable-safe-stack) printf "%s" -Dsafe_stack=true ;;
-- 
2.46.1


