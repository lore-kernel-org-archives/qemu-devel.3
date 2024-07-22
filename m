Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99EBC3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrSZ-0008Ne-JL; Mon, 22 Jul 2024 07:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sVrST-0008L7-UA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:44:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sVrSP-0002Ov-Sq
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:44:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso19673275e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721648635; x=1722253435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faagu3ZRFEUTlJZCSFm/DYZNyGfC2rcfLqmxjbWfHKM=;
 b=ITVj12TDXZAwgOFYtd6z71HHRe2DnUzEKrtpUEhr3ac+ZvyB1GjxSxFYlElYS5NlL5
 5HSG7yfVZ49KAJpx/2cuHaOh3wre9G9kHIgBXnlNQUlqQttWBf2OcnlR0qGguwXbnuGc
 RvgVNFK9+IqhMgPNGAUW2xqkVqekueS/VeCrR8vLG0VW7EEJ7pyKkwDByGVEY1t+BHCE
 kqZZE6ob3tAMMTRxcriOLB8cPRNLhu4wxFV94BNyNHMA8XwtJ8unHIOicPrapnzEKi5a
 XENayU7+9H2Uo0X91yX1oga7E7aeXSI8rCdzppIo8S7/fqKge+UVC1F5VFtGY0D3nIfn
 DEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721648635; x=1722253435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=faagu3ZRFEUTlJZCSFm/DYZNyGfC2rcfLqmxjbWfHKM=;
 b=KDZ8Op1tyhvx5pk5Ro8939SKNlSXTYc6pn4Jf9sYIfpfiFNPLPsRJczAHQ2Kwo5iep
 kVqt0RWMVkVVzFrBYWD+GxKM3CsPbR1FYpIzEFFX3GnrK12/KI7nmLGq74XCek1KjA9A
 BN4c0psBvHspcHkobBjyC8vWBDO0e1kEYxtaIY7kduG2BFlNyjENrpHrgjTbNJXtAGli
 wDbAyYQrg0/8DxgkBFu2v4fQIwxx8sdwfqFMVi+s8+zJ6kiMByBzTAVf/LoyXtv8Grms
 +R8hT8nfebikkl7nsRxMYgFj5TbZEWW/nBKrCu6svw2TuAtN2Pef2kju3NcEv4ip6/Rp
 zL3g==
X-Gm-Message-State: AOJu0YytB3OEaKVPJCjS+4VJ1SawMwfzagGIfZ+cKRkEG8QaVhgXiwaE
 UWY/4CGAtnqkVhZtSzz6+lPM4ItoqSisANxAdZ5DUnx6woc2kTZX9SuoaFplg43JIARGZJBFKUa
 GuWg=
X-Google-Smtp-Source: AGHT+IElJHbs59kq7VY/dzTlGdg9hRCCSniWs0YNKKN2Z/BUAAVQUuJYGw6fIFCqKjRYLjWs0yhvsw==
X-Received: by 2002:a5d:6ac1:0:b0:366:ea4a:17ec with SMTP id
 ffacd0b85a97d-36873dc19aemr6333045f8f.2.1721648634896; 
 Mon, 22 Jul 2024 04:43:54 -0700 (PDT)
Received: from localhost.localdomain (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787eba8csm8323513f8f.91.2024.07.22.04.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:43:54 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v5 1/8] build-sys: Add rust feature option
Date: Mon, 22 Jul 2024 14:43:31 +0300
Message-ID: <cdba13875d38feb836468a73509d24a88c8332ca.1721648163.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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
---
 MAINTAINERS                   |  5 +++++
 configure                     | 12 ++++++++++++
 meson.build                   | 17 ++++++++++++++++-
 Kconfig                       |  1 +
 Kconfig.host                  |  3 +++
 meson_options.txt             |  5 +++++
 rust/Kconfig                  |  0
 scripts/meson-buildoptions.sh |  3 +++
 8 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 rust/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d9811458c..d427f13b79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4228,6 +4228,11 @@ F: docs/sphinx/
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
diff --git a/configure b/configure
index 019fcbd0ef..8476968b96 100755
--- a/configure
+++ b/configure
@@ -173,6 +173,7 @@ fi
 
 # default parameters
 container_engine="auto"
+have_rust="no"
 cpu=""
 cross_compile="no"
 cross_prefix=""
@@ -757,6 +758,15 @@ for opt do
   ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
+  --enable-rust)
+    have_rust="yes" ;
+    meson_option_add -Dhave_rust=true
+  ;;
+  --disable-rust)
+    have_rust="no" ;
+    meson_option_add -Dhave_rust=false
+    meson_option_add -Ddisable_rust=true
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -874,6 +884,8 @@ Advanced options (experts only):
                            start the emulator (only use if you are including
                            desired devices in configs/devices/)
   --with-devices-ARCH=NAME override default configs/devices
+  --enable-rust            enable compilation of Rust code
+  --disable-rust           disable compilation of Rust code
   --enable-debug           enable common debug build options
   --cpu=CPU                Build for host CPU [$cpu]
   --disable-containers     don't use containers for cross-building
diff --git a/meson.build b/meson.build
index a1e51277b0..a3f346ab3c 100644
--- a/meson.build
+++ b/meson.build
@@ -70,6 +70,14 @@ if host_os == 'darwin' and \
   all_languages += ['objc']
   objc = meson.get_compiler('objc')
 endif
+if get_option('have_rust') and meson.version().version_compare('<1.0.0')
+  error('Rust support requires Meson version >=1.0.0')
+endif
+have_rust = false
+if not get_option('disable_rust') and add_languages('rust', required: get_option('have_rust'), native: false)
+  rustc = meson.get_compiler('rust')
+  have_rust = true
+endif
 
 dtrace = not_found
 stap = not_found
@@ -2119,6 +2127,7 @@ endif
 
 config_host_data = configuration_data()
 
+config_host_data.set('CONFIG_HAVE_RUST', have_rust)
 audio_drivers_selected = []
 if have_system
   audio_drivers_available = {
@@ -3038,7 +3047,8 @@ host_kconfig = \
   (host_os == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
-  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : [])
+  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
+  (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
@@ -4242,6 +4252,11 @@ if 'objc' in all_languages
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
index 0269fa0f16..9eef45f85b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -371,3 +371,8 @@ option('hexagon_idef_parser', type : 'boolean', value : true,
 
 option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
        description: 'tweak required x86_64 architecture version beyond compiler default')
+
+option('have_rust', type: 'boolean', value: false,
+       description: 'Have Rust support')
+option('disable_rust', type: 'boolean', value: false,
+       description: 'Disable Rust support')
diff --git a/rust/Kconfig b/rust/Kconfig
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c97079a38c..bb5854115a 100644
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
@@ -556,6 +557,8 @@ _meson_option_parse() {
     --enable-whpx) printf "%s" -Dwhpx=enabled ;;
     --disable-whpx) printf "%s" -Dwhpx=disabled ;;
     --x86-version=*) quote_sh "-Dx86_version=$2" ;;
+    --enable-with-rust) printf "%s" -Dhave_rust=true ;;
+    --disable-with-rust) printf "%s" -Dhave_rust=false ;;
     --enable-xen) printf "%s" -Dxen=enabled ;;
     --disable-xen) printf "%s" -Dxen=disabled ;;
     --enable-xen-pci-passthrough) printf "%s" -Dxen_pci_passthrough=enabled ;;
-- 
γαῖα πυρί μιχθήτω


