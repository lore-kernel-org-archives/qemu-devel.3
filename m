Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47859CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvXu-0006ms-GK; Wed, 14 Oct 2026 05:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvXf-0006S3-Pa
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:44:59 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvXc-0002Cf-7H
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:44:59 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-16ad92569b5so3783430c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791971095; x=1792575895; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sIFDeCq7ZkSNZTlC5b7kyE+3BiZiRbc8X5G6/SCg8N8=;
 b=Lo2kz5vK9IcxTGxb1w76FgxmXxhrNv01yrV1yBlC2RS9CRW55dh58U8ljb86XsXiV4
 Y/UFXzctj88Ens4KuTI3fKKePuXwP4bqfktzuwk7Vzw2OAbV1qop36hiEd2X9/gsbQ83
 ZyzxokbFUiw2kohn9qDV80nS68kmvo1DmWAnqcxGy0h9iucXv7qpBMxBLXAWoZXPbpYx
 CfwY0dzdquDJkFt6/bY+ZM4j22b+qsIX4T4Pv06ba7P0P8e0eBBTX8cvZj+wJfP7FviB
 rHIlQYNVEd6vKTEoi2s2y5IkLmOpXnbfChbIy3OCxDcGhHJhJ6E/hR5S/GqEoQFN5Mnn
 iv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791971095; x=1792575895;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sIFDeCq7ZkSNZTlC5b7kyE+3BiZiRbc8X5G6/SCg8N8=;
 b=buzcxzCeefWc9yRwjC7wNNVJ9KycDGo4Ij0XsKwRgAe/OsJH6jGxclYhY9CczqfaGh
 Sr+ZMPB9NfRHjbdfIFO6dHtuxLijtT1D7OjU6PUdxJEPCHixii0fgawXwRjUWQOTybxs
 ZuDORezu7dDEF+Prr61xGLgrsOZC/OYoPJWe96pRTMUcE6EIunrR2G6fbgfghbPoUV5L
 wg7513mmXxOrMvE5AcAMq5XdvZKw7XaJezz6TmShwL+ZjLYpsejITDeIH8VEvisztaG4
 9mzknQKySDPK6kBS2Had9S7HGUTG4/Yri48Yenfn0kiS6B7MD3Yt1dXhO426Z1R1gvqD
 Hvkg==
X-Gm-Message-State: AFq9FYJ0rJHIDWvNzCJD3ZlUVY9O0RutEI7lcxOeZoLg0A46SQ35Y5GQ
 UrPxOwaLrfqsqgerfEZXvt2mcL+ybCFWyaDHuHbcFSWsJt5fadU6gdK4XD9JULmFjF0=
X-Gm-Gg: AYBFou0SdWhAxBnyfzwG5cDsfIZRoNtQsuf/HF5MbVtE+BgNcVLGPuJRjPFglbxin+d
 uDD8d0NlLR8Pen1LBTp0mJhD5c7GObJdrpQaxXDSHhv1YwvxWH3+S05GIUdwfbFgiH2/C1YQcDP
 9ysGuG61DihoQ+++pwL5eSVQNTrvvBHLyGfVgsAGTWRNXrpGCAP8J3/+B0ffJJtTsCD5HtquTn7
 vbt3+9KaEkTAAODi+kJm7GV6yPZqtKKTMAR+/7Vu1t7/jYxGzPSC5aNhz8NeNhWOPAYILpLbvQR
 S7sBicQ7RFOpfen8hd7lWg5tIqAstITRAoFNXH0FUsSxEUqCbxqd7KwyNJ8/xJ9CfJqytNweA+P
 XG9gKFKqulXwkDhlXw6MfZZBuEy3b6jmXVTCyrQc26/zLYxxCBQoM0Ddg0rnyIBmA11PIjLDLk6
 JyxPngdVMek+AOIOmUHK4dJaWORLz1p7IBt5XS94bxy5gByqhZ1I7HpEOzh7U5tBtOfT+iI7hHD
 +n88oEZYCAUE4S5iaEKtSDnHaQS
X-Received: by 2002:a05:7022:b047:10b0:144:ddf7:2570 with SMTP id
 a92af1059eb24-16a5e8728dbmr22079430c88.39.1791971094591; 
 Wed, 14 Oct 2026 02:44:54 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:44:53 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Song Gao <17746591750@163.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 30/34] meson: build combined qemu-system for multi-target
 configurations
Date: Wed, 14 Oct 2026 17:41:45 +0800
Message-ID: <20261014094224.1976-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Build a top-level qemu-system executable when multiple supported targets
are configured.

Now the test-multi-target.c are testing under no target selected condition.
That's guard for future breakage

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 MAINTAINERS                    |  1 +
 meson.build                    | 58 ++++++++++++++++++++++++++++++++++
 qom/object.c                   |  4 ++-
 system/target-info.c           | 10 ++++++
 tests/unit/meson.build         |  4 +--
 tests/unit/test-multi-target.c |  5 ++-
 6 files changed, 76 insertions(+), 6 deletions(-)
 create mode 100644 system/target-info.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 669814d29c5..51012672b0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2147,6 +2147,7 @@ M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Supported
 F: stubs/target-info.c
+F: system/target-info.c
 F: include/qemu/target-info*.h
 F: target-info*.c
 F: tests/unit/test-multi-targets.c
diff --git a/meson.build b/meson.build
index f54687e19dc..6e90760c05a 100644
--- a/meson.build
+++ b/meson.build
@@ -4275,6 +4275,7 @@ multi_target_supported_targets = [
   'rx-softmmu',
   'tricore-softmmu',
 ]
+multi_target_final_targets = []
 
 emulators = {}
 foreach target : target_dirs
@@ -4436,6 +4437,7 @@ foreach target : target_dirs
           multi_target_crates += crate
         endif
       endforeach
+      multi_target_final_targets += target
     endif
     execs = [{
       'name': 'qemu-system-' + target_name,
@@ -4540,6 +4542,62 @@ endforeach
 multi_target_link_args = emulator_link_args
 multi_target_link_args += enable_modules ? ['@block.syms', '@qemu.syms'] : []
 
+if multi_target_final_targets.length() > 1
+  qemu_system_name = 'qemu-system'
+  if host_os == 'darwin'
+    qemu_system_name += '-unsigned'
+  endif
+  multi_target_info_sources = files('system/target-info.c')
+  qemu_system_sources = [
+    multi_target_crates,
+    files('system/main.c'),
+    multi_target_info_sources,
+  ]
+  qemu_system = executable(qemu_system_name,
+                           sources: qemu_system_sources,
+                           dependencies: multi_target_deps + [sdl],
+                           objects: multi_target_objects,
+                           link_depends: [block_syms, qemu_syms],
+                           link_args: multi_target_link_args,
+                           build_by_default: true,
+                           install: true)
+  multi_target_info_objects = qemu_system.extract_objects(
+    multi_target_info_sources)
+  if host_os == 'darwin'
+    icon = 'pc-bios/qemu.rsrc'
+    build_input = [qemu_system, files(icon)]
+    install_input = [
+      get_option('bindir') / qemu_system_name,
+      meson.current_source_dir() / icon
+    ]
+    if 'CONFIG_HVF' in multi_target_config
+      entitlements = 'accel/hvf/entitlements.plist'
+      build_input += files(entitlements)
+      install_input += meson.current_source_dir() / entitlements
+    endif
+    emulators += {'qemu-system': custom_target('qemu-system',
+                 input: build_input,
+                 output: 'qemu-system',
+                 build_by_default: true,
+                 command: [entitlement, '@OUTPUT@', '@INPUT@'])
+    }
+    meson.add_install_script(entitlement, '--install',
+                             get_option('bindir') / 'qemu-system',
+                             install_input)
+  else
+    emulators += {'qemu-system': qemu_system}
+  endif
+else
+  error_str = f'''qemu-system only support targets:
+@multi_target_supported_targets@
+
+use ./configure --target-list= to choose at least one of them'''
+  t = custom_target(command: ['sh', '-c', 'echo "' + error_str + '" && exit 1'],
+                    output: 'none',
+                    build_by_default: false)
+  alias_target('qemu-system', t)
+endif
+
 if get_option('plugins')
   install_headers('include/plugins/qemu-plugin.h')
   if host_os == 'windows'
diff --git a/qom/object.c b/qom/object.c
index 96498f3d001..f05456bd701 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/target-info.h"
 #include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
@@ -167,7 +168,8 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
         abort();
     }
 
-    if (info->is_available && !info->is_available()) {
+    if (!target_combined_binary()
+        && info->is_available && !info->is_available()) {
         return NULL;
     }
 
diff --git a/system/target-info.c b/system/target-info.c
new file mode 100644
index 00000000000..fb13ea8ad22
--- /dev/null
+++ b/system/target-info.c
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+
+#include "qemu/target-info.h"
+
+bool target_combined_binary(void)
+{
+    return true;
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d17435c1877..4bc7c4c146f 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -217,12 +217,12 @@ foreach test_name, extra: tests
 endforeach
 
 # Multi targets test
-if multi_target_objects != []
+if is_variable('qemu_system')
   test('test-multi-target',
        executable('test-multi-target',
                   sources: [multi_target_crates, files('test-multi-target.c')],
                   dependencies: multi_target_deps,
-                  objects: multi_target_objects,
+                  objects: multi_target_objects + multi_target_info_objects,
                   link_depends: [block_syms, qemu_syms],
                   link_args: multi_target_link_args),
        suite: ['unit'])
diff --git a/tests/unit/test-multi-target.c b/tests/unit/test-multi-target.c
index 704e3297ef9..ff81ea42a90 100644
--- a/tests/unit/test-multi-target.c
+++ b/tests/unit/test-multi-target.c
@@ -49,6 +49,8 @@ static bool target_arch_available(uint64_t arch_mask)
 static void test_qom_types_are_unique(void)
 {
     g_assert(targets);
+    /* Verify this test runs like the combined qemu-system binary. */
+    g_assert_true(target_combined_binary());
     /* trigger type_initialize for all types */
     object_class_get_list("", false);
 
@@ -89,9 +91,6 @@ int main(int argc, char **argv)
     target_info_qom_init();
     targets = target_info_qom_get_targets();
 
-    const TargetInfo *first_ti = TARGET_INFO_CLASS(targets->data)->target_info;
-    target_info_qom_set_target_info(first_ti);
-
     /* register all types */
     module_call_init(MODULE_INIT_QOM);
 
-- 
2.55.0.windows.3


