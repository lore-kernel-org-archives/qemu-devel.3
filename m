Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D089C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMW1-0002Oi-5Q; Sat, 26 Sep 2026 03:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMS4-0005Wz-A3
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:04:09 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMS1-0000h4-0D
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:04:04 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-33be7dfcfc1so2110291eec.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406238; x=1791011038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qCXIFUQwlVnS7FqE0wXM3scWpVNsZr5+GJNgga1dkVI=;
 b=LzaZGrGuq955ASToIs59s71h7MI6S2QKxTySRo5dmv8RUmY08GEfLJG6UoGokdVoSJ
 1rp67tSRlOvAU1LUSLWDgricPWCcdJCuASMopFgrY1WdOLnNh4l9eHpIlPpLOc0K9TTk
 JjfGTmfv6RcPFPyjZWZhQmLeZeTxh9YcUaOpkL48N5NUVbNZ4CVYjKUG65U5/i7BpFf9
 S9APD2aoe2QOUDi9PeXBfVLx3eBYv6dSyaYRCYxKeA1MjoLbZK1etTpXNrysQxnO404k
 l3VQmpKKVy4C6qAA+ujTMx0P16BxJZLqgMLpCZlwC5/H3ZV0qeimi6p9NdUQWX+bFZ9O
 +2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406238; x=1791011038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qCXIFUQwlVnS7FqE0wXM3scWpVNsZr5+GJNgga1dkVI=;
 b=jpn3nCE6Czd4qDDIEQExPjkW2C3nTJevH4PRjOUgoXg7CQJTFAH39q5c9z+sGJ4x1O
 VSfL7mNE7o5RJ5ZnkZ7LAvPSfhWtHNbHj0q2EAUckhQsnjIbzBnRMoKkpL5PdZ3Vh8az
 YNooGul0ZNi9TmDS2WuX2aBohzFMDCtHAFlBrHtOh4yN3QrwsEwU5caNlRIlKZR4yuOr
 0a16w3zNaLBMDPaXYm9Qv3bXSSPiOVyO5R9O8qLssVSGBc4LOXZi4D/trGk0fKw4geGg
 2CHJWrJ8kQp7FYiiYaYtYXCwfQrOw8B/ennbKzwdtjOlLrbm3P/MxCvnqBmndF3zXeCy
 VSDQ==
X-Gm-Message-State: AFuF++mOth65p1PZzplEEk7QtJYv5uX9W47cDgBw8+oE5NZE4QNSjBpf
 0TktMw/cUq5wHe+ftvjVC+zDYPhz95bLKqod+3GD+6yxOufWLaudisXSPmQzO07q
X-Gm-Gg: AYBFou3eBZn4fZasLuGGkchJ/QeTuewbuHJIW9fMv2fvC9UKLYGJ6cxzqrktxQP/HBG
 YmTIW5kUUMc+bAvNYnf+5wd47aXEiK+OqBQVlhcARR1o/vPnD+0gw9dUCEd1a2Qm2dK18RckW69
 6pgiDjeipEwYV09e5hIMvbeXttwf3tpefezMAZrriFwD2nRQyXKwXX9TgUBx2S0eRYs2ZTWqIZI
 nPkwc435ExK2YPgffw2ly5JDT1WDPpHKaq6rmDs1dtDV9Q3g0LK9XwQqNAIwwZb53OFpXnjI5ll
 0+QxRes1f3a6Sk2PUhX3udUa2+j8FkNdQeC+tcmJHfVVv9KZY7JJgzvZKMgr07jr7TY8RZyv6Zf
 udoieO4kb3C8Y/swbwpFInCUK7s5WTaTJ4S3SlHDZEatQsL38MIPIcXCj33wFEBhYtMWkc34KzB
 0SS1jNOrDtk+sGTlRTJb79FIXTs6AkBdi6p7bJeIwy8bUWEz6sac3WcW2yrk2ePwd9kKBD7RE6p
 6ossR2IYEDuRNJ6zMCBqCXzULfEzf8=
X-Received: by 2002:a05:7300:d0a7:b0:33b:dab1:d6b5 with SMTP id
 5a478bee46e88-342705aee26mr2037757eec.11.1790406237841; 
 Sat, 26 Sep 2026 00:03:57 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:03:57 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 44/55] target-info: select combined qemu-system target by
 name
Date: Sat, 26 Sep 2026 15:00:43 +0800
Message-ID: <20260926070057.1234-45-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The combined qemu-system binary can select a registered target by
name, or stay on SYS_EMU_TARGET_NONE. A single-target binary does
not switch target.

The none entry is the same target-info-def.c stub as other targets,
compiled with TARGET_BASE_ARCH NONE. target/none/cpu.h supplies
ArchCPU for that stub, and cpu-param.h sets
TARGET_VIRT_ADDR_SPACE_BITS. TYPE_NONE_CPU is NULL because there is
no none CPU QOM type.

type_register_internal() keeps types on the combined binary and
filters them with TypeInfo.is_available. A single-target binary
still omits types that cannot run.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info-select.h | 24 +++++++++++++++++++++
 meson.build                       | 35 +++++++++++++++++++++++++++++++
 qom/object.c                      |  8 ++++++-
 stubs/meson.build                 |  1 +
 stubs/target-info-select.c        | 14 +++++++++++++
 system/target-info-select.c       | 26 +++++++++++++++++++++++
 target/none/cpu-param.h           |  7 +++++++
 target/none/cpu-qom.h             |  6 ++++++
 target/none/cpu.h                 | 18 ++++++++++++++++
 9 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 include/qemu/target-info-select.h
 create mode 100644 stubs/target-info-select.c
 create mode 100644 system/target-info-select.c
 create mode 100644 target/none/cpu-param.h
 create mode 100644 target/none/cpu-qom.h
 create mode 100644 target/none/cpu.h

diff --git a/include/qemu/target-info-select.h b/include/qemu/target-info-select.h
new file mode 100644
index 00000000000..0659bb47567
--- /dev/null
+++ b/include/qemu/target-info-select.h
@@ -0,0 +1,24 @@
+#ifndef QEMU_TARGET_INFO_SELECT_H
+#define QEMU_TARGET_INFO_SELECT_H
+
+/**
+ * target_combined_binary:
+ *
+ * Returns: %true if this is the combined qemu-system binary.
+ */
+bool target_combined_binary(void);
+
+typedef struct Error Error;
+
+/**
+ * target_info_select_by_name:
+ * @name: target_name to select, or NULL
+ * @errp: error location
+ *
+ * Combined qemu-system only. NULL selects "none". Every name, including
+ * "none", is looked up in target_info_list(). The stub is a no-op on
+ * single-target binaries.
+ */
+void target_info_select_by_name(const char *name, Error **errp);
+
+#endif
diff --git a/meson.build b/meson.build
index 7ab5c7971a8..96f493cb746 100644
--- a/meson.build
+++ b/meson.build
@@ -4618,6 +4618,41 @@ if single_binary_available
   endforeach
   single_binary_objects += single_binary_target_info_objects
 
+  none_config_target_data = configuration_data()
+  none_config_target_data.set_quoted('TARGET_NAME', 'none')
+  none_config_target_data.set('TARGET_ARCH', 'NONE')
+  none_config_target_data.set('TARGET_BASE_ARCH', 'NONE')
+  none_config_target_data.set('TARGET_LONG_BITS', 64)
+  none_config_target_data.set('TARGET_BIG_ENDIAN', 0)
+  none_config_target_h = configure_file(output: 'none-config-target.h',
+                                        configuration: none_config_target_data)
+  none_config_devices_data = configuration_data()
+  foreach k, v : single_binary_config
+    if v == 'y'
+      none_config_devices_data.set(k, 1)
+    endif
+  endforeach
+  none_config_devices_h = configure_file(output: 'none-config-devices.h',
+                                         configuration: none_config_devices_data)
+  qemu_none_ss = ss.source_set()
+  qemu_none_ss.add(files('system/target-info-select.c'))
+  qemu_none_ss.add(target_info_def)
+  qemu_none_src = qemu_none_ss.apply(single_binary_config, strict: false)
+  qemu_none = static_library('qemu-none',
+                             sources: qemu_none_src.sources() + genh +
+                                      [none_config_target_h,
+                                       none_config_devices_h],
+                             dependencies: qemu_none_src.dependencies(),
+                             include_directories: include_directories(
+                               'target' / 'none'),
+                             c_args: [
+                               '-DCOMPILING_PER_TARGET',
+                               '-DCONFIG_TARGET="none-config-target.h"',
+                               '-DCONFIG_DEVICES="none-config-devices.h"',
+                             ],
+                             build_by_default: false)
+  single_binary_objects += qemu_none.extract_objects(qemu_none_src.sources())
+
   single_binary_link_args = emulator_link_args
   single_binary_link_args += enable_modules ? ['@block.syms', '@qemu.syms'] : []
   qemu_system_name = 'qemu-system'
diff --git a/qom/object.c b/qom/object.c
index 76b0b0806b3..2ce6c369df5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -16,6 +16,7 @@
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "qemu/target-info-qapi.h"
+#include "qemu/target-info-select.h"
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 #include "qapi/visitor.h"
@@ -171,7 +172,12 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
         abort();
     }
 
-    if (info->is_available && !info->is_available(target_info())) {
+    /*
+     * Single-target binaries omit types that cannot run. The combined
+     * binary keeps them and filters with is_available per target.
+     */
+    if (!target_combined_binary() && info->is_available &&
+        !info->is_available(target_info())) {
         return NULL;
     }
 
diff --git a/stubs/meson.build b/stubs/meson.build
index 29b6644b254..3765537778d 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -3,6 +3,7 @@
 # below, so that it is clear who needs the stubbed functionality.
 
 stub_ss.add(files('cpu-get-clock.c'))
+stub_ss.add(files('target-info-select.c'))
 stub_ss.add(files('fdset.c'))
 stub_ss.add(files('iothread-lock.c'))
 stub_ss.add(files('is-daemonized.c'))
diff --git a/stubs/target-info-select.c b/stubs/target-info-select.c
new file mode 100644
index 00000000000..5c9e8dc6e19
--- /dev/null
+++ b/stubs/target-info-select.c
@@ -0,0 +1,14 @@
+#include "qemu/osdep.h"
+#include "qemu/target-info-select.h"
+#include "qapi/error.h"
+
+bool target_combined_binary(void)
+{
+    return false;
+}
+
+void target_info_select_by_name(const char *name, Error **errp)
+{
+    (void)name;
+    (void)errp;
+}
diff --git a/system/target-info-select.c b/system/target-info-select.c
new file mode 100644
index 00000000000..4b4a9fdf256
--- /dev/null
+++ b/system/target-info-select.c
@@ -0,0 +1,26 @@
+#include "qemu/osdep.h"
+#include "qemu/target-info-def.h"
+#include "qemu/target-info-select.h"
+#include "qapi/error.h"
+
+bool target_combined_binary(void)
+{
+    return true;
+}
+
+void target_info_select_by_name(const char *name, Error **errp)
+{
+    TargetInfoNode *node;
+
+    if (!name) {
+        name = "none";
+    }
+
+    QLIST_FOREACH(node, target_info_list(), next) {
+        if (!strcmp(name, node->info->target_name)) {
+            target_info_select(node->info);
+            return;
+        }
+    }
+    error_setg(errp, "target '%s' is not available", name);
+}
diff --git a/target/none/cpu-param.h b/target/none/cpu-param.h
new file mode 100644
index 00000000000..3c0818a2f02
--- /dev/null
+++ b/target/none/cpu-param.h
@@ -0,0 +1,7 @@
+#ifndef NONE_CPU_PARAM_H
+#define NONE_CPU_PARAM_H
+
+#define TARGET_PAGE_BITS 9
+#define TARGET_VIRT_ADDR_SPACE_BITS 64
+
+#endif
diff --git a/target/none/cpu-qom.h b/target/none/cpu-qom.h
new file mode 100644
index 00000000000..114faa8077a
--- /dev/null
+++ b/target/none/cpu-qom.h
@@ -0,0 +1,6 @@
+#ifndef QEMU_NONE_CPU_QOM_H
+#define QEMU_NONE_CPU_QOM_H
+
+#define TYPE_NONE_CPU NULL
+
+#endif
diff --git a/target/none/cpu.h b/target/none/cpu.h
new file mode 100644
index 00000000000..ffb9a0d28dc
--- /dev/null
+++ b/target/none/cpu.h
@@ -0,0 +1,18 @@
+#ifndef QEMU_NONE_CPU_H
+#define QEMU_NONE_CPU_H
+
+#include "cpu-qom.h"
+#include "hw/core/cpu.h"
+
+#define CPU_RESOLVING_TYPE TYPE_NONE_CPU
+
+typedef struct CPUArchState {
+    uint64_t unused;
+} CPUArchState;
+
+struct ArchCPU {
+    CPUState parent_obj;
+    CPUArchState env;
+};
+
+#endif
-- 
2.52.0.windows.1


