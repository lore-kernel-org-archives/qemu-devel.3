Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A15C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 05:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLy8s-0002z9-Jq; Mon, 02 Jun 2025 01:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3H-0001f7-Fj
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:49:41 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLy3D-0007KM-0s
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:49:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso32542675ad.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 22:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843363; x=1749448163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9eLvDalIjlXyUkR8wTsvfaoz94Xil7ORIqzjzFs5NQ=;
 b=bMipBCcB8qmyjnr0ic6+E7MPyFow8vKLXV+zpBra9v+cDtu+2xzbwjxLNOdRzo8Wgw
 8YM3Hw+wL9KsFWj82kQHXcsQwsrJiBFV+7Rh3Ftumytc0Ih54qWEoGs90oK/NqCSH74w
 tf2gbdl4Oy9Nl1zn0GeW3sSoy8Fde6w3jOhGR8p/kMyVaXyBVUBdnwYclCMtEmJvLplT
 +Aux2q0I0GU07U+NI/7zljchw/IfkdVUT9jNozoFvRyyibLTRCdkggOMUcywkSGPmomv
 A7eFUeMyUHPPMVng5rmPXzlBDPvVuMB0wv2+0yEWrG7iDcB/xw+h1mQDcvhBdg8qFH4M
 WW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843363; x=1749448163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9eLvDalIjlXyUkR8wTsvfaoz94Xil7ORIqzjzFs5NQ=;
 b=GvktLKNiSWAQFnL71SgLfMHxJLrGR6ZUZ/zDPIsl3+g/FOM9mnvDhca/+ju1BKmVoE
 55stiaVT312xjO0aCP6aYyz2GYIJNYC+SohVuhQc2fnjF9kaMqyA+pk/TqyoCJKt4cdp
 zRyMz2wglz+nGKK1YkwC2P78XvqRtH4RBPWInGSjfD14qPjZAcWiDGjURVM/13tZLaUe
 6S7qh7Xb9SnZSta46FZ37RduRhB3Aha9hMPavtSloZnmZ0Zu3FCgoDIP10aYncS7BFYY
 9GTTsBL7sou6YBBPcq0QfSo5HwNKtwWW0MFhflxQNzbf7hiiBq27+wQJz8k3UJg0Gtvq
 RUog==
X-Gm-Message-State: AOJu0YzUeNIWGS4Hskq+qnIuoggsUm41tiP90Wuy6KllhBN1IvzJBo91
 nEahbDV1se39rKi59adPPqZ5+cRACV7nc60rvkwQKNS30i6xOOAwG6NAhyO/W1aVTkE=
X-Gm-Gg: ASbGncvRB3W64JPtjzp7oxx4GXSHok3rGgHVISThj3LVwerCFD8qPleLh6n2ykg0xy9
 Kr/7o9huppbCMzxo5DUx3srVk4avt2AcTUYyrurpNTLVn3YnM/EnGMYoPZ/vLyvdgwLuaXlQIHL
 WRt7RxkNOXt/6kGVfjgQ3oYz+no6cJip2gwA/wko61iBDT3F86JhB7RGEB8pQycrnLlYSk+YCNX
 f+yGqxG2QxeTinU+qZE3fPq4B7CjmPm6Lim4chBc1yQ+/R/yVYUdVVEYq7VlSfD5wMGXJ+/loBv
 +LDk7rbgpy4qzC7Wd1gG/5IDWR4iwEDn2H+ob7Qxj/mb/+X51VqBZimjwch1zg==
X-Google-Smtp-Source: AGHT+IGlhN3VH6a4HT7ytWDYdR+afffqz1dXQEO4gUsei3xuQ3vbvPM0Rq4BIiZyjwoV5+QYB/dHwA==
X-Received: by 2002:a17:903:2346:b0:234:d366:58b0 with SMTP id
 d9443c01a7336-2355f7832ecmr102723535ad.47.1748843363387; 
 Sun, 01 Jun 2025 22:49:23 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bdce12sm63464085ad.99.2025.06.01.22.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 22:49:23 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v5 6/9] plugins: Add patcher plugin and test
Date: Sun,  1 Jun 2025 22:49:13 -0700
Message-ID: <20250602054917.302638-7-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602054917.302638-1-rowanbhart@gmail.com>
References: <20250602054917.302638-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

This patch adds a plugin that exercises the virtual and hardware memory
read-write API functions added in a previous patch. The plugin takes a
target and patch byte sequence, and will overwrite any instruction
matching the target byte sequence with the patch.

Signed-off-by: novafacing <rowanbhart@gmail.com>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 tests/tcg/Makefile.target                 |   1 +
 tests/tcg/plugins/meson.build             |   2 +-
 tests/tcg/plugins/patch.c                 | 302 ++++++++++++++++++++++
 tests/tcg/x86_64/Makefile.softmmu-target  |  32 ++-
 tests/tcg/x86_64/system/patch-target.c    |  32 +++
 tests/tcg/x86_64/system/validate-patch.py |  39 +++
 6 files changed, 402 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 95ff76ea44..4b709a9d18 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -176,6 +176,7 @@ RUN_TESTS+=$(EXTRA_RUNS)
 # Some plugins need additional arguments above the default to fully
 # exercise things. We can define them on a per-test basis here.
 run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true
+run-plugin-%-with-libpatch.so: PLUGIN_ARGS=$(COMMA)target=ffffffff$(COMMA)patch=00000000
 
 ifeq ($(filter %-softmmu, $(TARGET)),)
 run-%: %
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 41f02f2c7f..163042e601 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall']
+  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
new file mode 100644
index 0000000000..3767d14a53
--- /dev/null
+++ b/tests/tcg/plugins/patch.c
@@ -0,0 +1,302 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2025, Rowan Hart <rowanbhart@gmail.com>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * This plugin patches instructions matching a pattern to a different
+ * instruction as they execute
+ *
+ */
+
+#include "glib.h"
+#include "glibconfig.h"
+
+#include <qemu-plugin.h>
+#include <string.h>
+#include <stdio.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static bool use_hwaddr;
+static bool debug_insns;
+static GByteArray *target_data;
+static GByteArray *patch_data;
+
+/**
+ * Parse a string of hexadecimal digits into a GByteArray. The string must be
+ * even length
+ */
+static GByteArray *str_to_bytes(const char *str)
+{
+    GByteArray *bytes = g_byte_array_new();
+    char byte[3] = {0};
+    size_t len = strlen(str);
+    guint8 value = 0;
+
+    if (len % 2 != 0) {
+        g_byte_array_free(bytes, true);
+        return NULL;
+    }
+
+    for (size_t i = 0; i < len; i += 2) {
+        byte[0] = str[i];
+        byte[1] = str[i + 1];
+        value = (guint8)g_ascii_strtoull(byte, NULL, 16);
+        g_byte_array_append(bytes, &value, 1);
+    }
+
+    return bytes;
+}
+
+static void patch_hwaddr(unsigned int vcpu_index, void *userdata)
+{
+    uint64_t addr = (uint64_t)userdata;
+    GString *str = g_string_new(NULL);
+    g_string_printf(str, "patching: @0x%"
+                    PRIx64 "\n",
+                    addr);
+    qemu_plugin_outs(str->str);
+    g_string_free(str, true);
+
+    enum qemu_plugin_hwaddr_operation_result result =
+        qemu_plugin_write_memory_hwaddr(addr, patch_data);
+
+
+    if (result != QEMU_PLUGIN_HWADDR_OPERATION_OK) {
+        GString *errmsg = g_string_new(NULL);
+        g_string_printf(errmsg, "Failed to write memory: %d\n", result);
+        qemu_plugin_outs(errmsg->str);
+        g_string_free(errmsg, true);
+        return;
+    }
+
+    GByteArray *read_data = g_byte_array_new();
+
+    result = qemu_plugin_read_memory_hwaddr(addr, read_data,
+                                            patch_data->len);
+
+    qemu_plugin_outs("Reading memory...\n");
+
+    if (result != QEMU_PLUGIN_HWADDR_OPERATION_OK) {
+        GString *errmsg = g_string_new(NULL);
+        g_string_printf(errmsg, "Failed to read memory: %d\n", result);
+        qemu_plugin_outs(errmsg->str);
+        g_string_free(errmsg, true);
+        return;
+    }
+
+    if (memcmp(patch_data->data, read_data->data, patch_data->len) != 0) {
+        qemu_plugin_outs("Failed to read back written data\n");
+    }
+
+    qemu_plugin_outs("Success!\n");
+
+    return;
+}
+
+static void patch_vaddr(unsigned int vcpu_index, void *userdata)
+{
+    uint64_t addr = (uint64_t)userdata;
+    uint64_t hwaddr = 0;
+    if (!qemu_plugin_translate_vaddr(addr, &hwaddr)) {
+        qemu_plugin_outs("Failed to translate vaddr\n");
+        return;
+    }
+    GString *str = g_string_new(NULL);
+    g_string_printf(str, "patching: @0x%"
+                    PRIx64 " hw: @0x%" PRIx64 "\n",
+                    addr, hwaddr);
+    qemu_plugin_outs(str->str);
+    g_string_free(str, true);
+
+    qemu_plugin_outs("Writing memory (vaddr)...\n");
+
+    if (!qemu_plugin_write_memory_vaddr(addr, patch_data)) {
+        qemu_plugin_outs("Failed to write memory\n");
+        return;
+    }
+
+    qemu_plugin_outs("Reading memory (vaddr)...\n");
+
+
+    GByteArray *read_data = g_byte_array_new();
+
+    if (!qemu_plugin_read_memory_vaddr(addr, read_data, patch_data->len)) {
+        qemu_plugin_outs("Failed to read memory\n");
+        return;
+    }
+
+    if (memcmp(patch_data->data, read_data->data, patch_data->len) != 0) {
+        qemu_plugin_outs("Failed to read back written data\n");
+    }
+
+    qemu_plugin_outs("Success!\n");
+
+    return;
+}
+
+static void debug_disas(unsigned int vcpu_index, void *userdata)
+{
+    GString *debug_info = (GString *)userdata;
+    qemu_plugin_outs(debug_info->str);
+}
+
+static void debug_print_newline(unsigned int vcpu_index, void *userdata)
+{
+    qemu_plugin_outs("\n");
+}
+
+/*
+ * Callback on translation of a translation block.
+ */
+static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    uint64_t addr = 0;
+    GByteArray *insn_data = g_byte_array_new();
+    for (size_t i = 0; i < qemu_plugin_tb_n_insns(tb); i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+
+        if (use_hwaddr) {
+            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
+            if (!qemu_plugin_translate_vaddr(vaddr, &addr)) {
+                qemu_plugin_outs("Failed to translate vaddr\n");
+                continue;
+            }
+        } else {
+            addr = qemu_plugin_insn_vaddr(insn);
+        }
+
+        g_byte_array_set_size(insn_data, qemu_plugin_insn_size(insn));
+        qemu_plugin_insn_data(insn, insn_data->data, insn_data->len);
+
+        if (insn_data->len >= target_data->len &&
+            !memcmp(insn_data->data, target_data->data,
+                    MIN(target_data->len, insn_data->len))) {
+            if (use_hwaddr) {
+                qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_hwaddr,
+                                                     QEMU_PLUGIN_CB_NO_REGS,
+                                                     (void *)addr);
+            } else {
+                qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_vaddr,
+                                                     QEMU_PLUGIN_CB_NO_REGS,
+                                                     (void *)addr);
+            }
+        }
+    }
+    for (size_t i = 0; i < qemu_plugin_tb_n_insns(tb); i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
+        uint64_t hwaddr = (uint64_t)qemu_plugin_insn_haddr(insn);
+        uint64_t translated_hwaddr = 0;
+        if (!qemu_plugin_translate_vaddr(vaddr, &translated_hwaddr)) {
+            qemu_plugin_outs("Failed to translate vaddr\n");
+            continue;
+        }
+        char *disas = qemu_plugin_insn_disas(insn);
+        GString *str = g_string_new(NULL);
+        g_string_printf(str,
+                        "vaddr: 0x%" PRIx64 " hwaddr: 0x%" PRIx64
+                        " translated: 0x%" PRIx64 " : %s\n",
+                        vaddr, hwaddr, translated_hwaddr, disas);
+        g_free(disas);
+        if (debug_insns) {
+            qemu_plugin_register_vcpu_insn_exec_cb(insn, debug_disas,
+                                                   QEMU_PLUGIN_CB_NO_REGS,
+                                                   str);
+        }
+
+    }
+
+    if (debug_insns) {
+        qemu_plugin_register_vcpu_tb_exec_cb(tb, debug_print_newline,
+                                             QEMU_PLUGIN_CB_NO_REGS,
+                                             NULL);
+    }
+
+    g_byte_array_free(insn_data, true);
+}
+
+static void usage(void)
+{
+    fprintf(stderr, "Usage: <lib>,target=<target>,patch=<patch>"
+            "[,use_hwaddr=<use_hwaddr>]"
+            "[,debug_insns=<debug_insns>]\n");
+}
+
+/*
+ * Called when the plugin is installed
+ */
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int argc,
+                                           char **argv)
+{
+
+    use_hwaddr = true;
+    debug_insns = false;
+    target_data = NULL;
+    patch_data = NULL;
+
+    if (argc > 4) {
+        usage();
+        return -1;
+    }
+
+    for (size_t i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "use_hwaddr") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &use_hwaddr)) {
+                fprintf(stderr,
+                        "Failed to parse boolean argument use_hwaddr\n");
+                return -1;
+            }
+        } else if (g_strcmp0(tokens[0], "debug_insns") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &debug_insns)) {
+                fprintf(stderr,
+                        "Failed to parse boolean argument debug_insns\n");
+                return -1;
+            }
+        } else if (g_strcmp0(tokens[0], "target") == 0) {
+            target_data = str_to_bytes(tokens[1]);
+            if (!target_data) {
+                fprintf(stderr,
+                         "Failed to parse target bytes.\n");
+                return -1;
+            }
+        } else if (g_strcmp0(tokens[0], "patch") == 0) {
+            patch_data = str_to_bytes(tokens[1]);
+            if (!patch_data) {
+                fprintf(stderr, "Failed to parse patch bytes.\n");
+                return -1;
+            }
+        } else {
+            fprintf(stderr, "Unknown argument: %s\n", tokens[0]);
+            usage();
+            return -1;
+        }
+    }
+
+    if (!target_data) {
+        fprintf(stderr, "target argument is required\n");
+        usage();
+        return -1;
+    }
+
+    if (!patch_data) {
+        fprintf(stderr, "patch argument is required\n");
+        usage();
+        return -1;
+    }
+
+    if (target_data->len != patch_data->len) {
+        fprintf(stderr, "Target and patch data must be the same length\n");
+        return -1;
+    }
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans_cb);
+
+    return 0;
+}
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index ef6bcb4dc7..8d3a067c33 100644
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -7,18 +7,27 @@
 #
 
 I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
-X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
+X86_64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
 
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
 
-CRT_PATH=$(X64_SYSTEM_SRC)
-LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
+X86_64_TEST_C_SRCS=$(wildcard $(X86_64_SYSTEM_SRC)/*.c)
+X86_64_TEST_S_SRCS=
+
+X86_64_C_TESTS = $(patsubst $(X86_64_SYSTEM_SRC)/%.c, %, $(X86_64_TEST_C_SRCS))
+X86_64_S_TESTS = $(patsubst $(X86_64_SYSTEM_SRC)/%.S, %, $(X86_64_TEST_S_SRCS))
+
+X86_64_TESTS = $(X86_64_C_TESTS)
+X86_64_TESTS += $(X86_64_S_TESTS)
+
+CRT_PATH=$(X86_64_SYSTEM_SRC)
+LINK_SCRIPT=$(X86_64_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
-TESTS+=$(MULTIARCH_TESTS)
+TESTS+=$(X86_64_TESTS) $(MULTIARCH_TESTS)
 EXTRA_RUNS+=$(MULTIARCH_RUNS)
 
 # building head blobs
@@ -27,11 +36,24 @@ EXTRA_RUNS+=$(MULTIARCH_RUNS)
 %.o: $(CRT_PATH)/%.S
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
 
-# Build and link the tests
+# Build and link the multiarch tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
+# Build and link the arch tests
+%: $(X86_64_SYSTEM_SRC)/%.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
 memory: CFLAGS+=-DCHECK_UNALIGNED=1
+patch-target: CFLAGS+=-O0
 
 # Running
 QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
+
+# Add patch-target to ADDITIONAL_PLUGINS_TESTS
+ADDITIONAL_PLUGINS_TESTS += patch-target
+
+run-plugin-patch-target-with-libpatch.so:		\
+	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true$(COMMA)debug_insns=false
+run-plugin-patch-target-with-libpatch.so:		\
+	CHECK_PLUGIN_OUTPUT_COMMAND=$(X86_64_SYSTEM_SRC)/validate-patch.py $@.out
\ No newline at end of file
diff --git a/tests/tcg/x86_64/system/patch-target.c b/tests/tcg/x86_64/system/patch-target.c
new file mode 100644
index 0000000000..671987a873
--- /dev/null
+++ b/tests/tcg/x86_64/system/patch-target.c
@@ -0,0 +1,32 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2025, Rowan Hart <rowanbhart@gmail.com>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * This test target increments a value 100 times. The patcher converts the
+ * inc instruction to a nop, so it only increments the value once.
+ *
+ */
+#include <minilib.h>
+
+int main(void)
+{
+    ml_printf("Running test...\n");
+#if defined(__x86_64__)
+    ml_printf("Testing insn memory read/write...\n");
+    unsigned int x = 0;
+    for (int i = 0; i < 100; i++) {
+        asm volatile (
+            "inc %[x]"
+            : [x] "+a" (x)
+        );
+    }
+    ml_printf("Value: %d\n", x);
+#else
+    #error "This test is only valid for x86_64 architecture."
+#endif
+    return 0;
+}
diff --git a/tests/tcg/x86_64/system/validate-patch.py b/tests/tcg/x86_64/system/validate-patch.py
new file mode 100755
index 0000000000..700950eae5
--- /dev/null
+++ b/tests/tcg/x86_64/system/validate-patch.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env python3
+#
+# validate-patch.py: check the patch applies
+#
+# This program takes two inputs:
+#   - the plugin output
+#   - the binary output
+#
+# Copyright (C) 2024
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import sys
+from argparse import ArgumentParser
+
+def main() -> None:
+    """
+    Process the arguments, injest the program and plugin out and
+    verify they match up and report if they do not.
+    """
+    parser = ArgumentParser(description="Validate patch")
+    parser.add_argument('test_output',
+                        help="The output from the test itself")
+    parser.add_argument('plugin_output',
+                        help="The output from plugin")
+    args = parser.parse_args()
+
+    with open(args.test_output, 'r') as f:
+        test_data = f.read()
+    with open(args.plugin_output, 'r') as f:
+        plugin_data = f.read()
+    if "Value: 1" in test_data:
+        sys.exit(0)
+    else:
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
+
-- 
2.49.0


