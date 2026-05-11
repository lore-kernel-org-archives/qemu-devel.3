Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BB4CD4842
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVy6-0002O4-Ti; Mon, 11 May 2026 15:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxj-0002JR-G2
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:44 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxh-00086F-3p
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:43 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-47c6f914617so2407544b6e.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778526400; x=1779131200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POb/O+hM5Wokeidc3aROFh0k45r/qUp7jNKxBWzEiEw=;
 b=loCHd7yoXeuGcxQwd2KQcQVyVfhKHvXMGNJs0bBGpzfVQ4a82fbGDpkc+nMO5VAVFv
 pQVUshCjommGBeluGz1DdbdriZ/czJ5OMH+QcAE5hmBbJJVWoSzGKwczm3/I3QNQixS/
 Yrm8hn6sx2S+msuNPUosKwzx1CDPmyVRq7lgLyUyuqWrj7QgtW8SpYn6wQEkDmhXpwTI
 P4pHfLRt4gXNAuwrOLrkClj6amN98z+49M24tYxEQNK+7BWCJYNZA00q9spOK54qWTBW
 MVJjehT1Qc01oUy53ril5kzxXk/LjKRFOT3uqFlpjrg5tL1HN/Yb/xv5lZX9dMiU0ofq
 Cx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778526400; x=1779131200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=POb/O+hM5Wokeidc3aROFh0k45r/qUp7jNKxBWzEiEw=;
 b=Go5sjla6jTRIhXWxDKXkD3f2eC/opv5UndeJ/NGCzQphuOTV10/hGnRYbVeFg3ULiv
 DR45DK2VQ+NIVtaXT57Ub87FxE08QuCVAgNPd9VdLpcWWlGbGTRoH+1UDp90zGzM2dLC
 uRtCXqIkBuHvtil04Ga58Fq4zPaFMMA5BdMUOaEXokvDUGqaEU9RBDTC3yzFX5MOdguj
 P3jR1HHrqZEyk4DufMqrr5Vk9T0+8ovjgsLw/ycScxTqQymIzY20noekr6xK5owyQtbG
 MoK9u0NmXeSC682w0oOOHEdRcACe2Gi3DTbTtwolwEllnpbS2yF/N3MnShezib9NiHbI
 vk7Q==
X-Gm-Message-State: AOJu0YyFoOqkELBiEdbSZIQyUHWFsBGPRFFOP+jAyYZai75ouXS1Wnna
 tLsLYaIbP+z4FZBhiPgyTMyRQKFGEyWnP/48m1hV4wr5i0uompWWvaRLZii3Flb3xi7ecuOeOsR
 aYyxE
X-Gm-Gg: Acq92OE+BfLu5O9KYqTNsjGDahkwOGZwGB4DZIzQG0bD0UIrRk1oRbVTTY/ShqgB5kj
 Hdkb25L7Y2i5x8ydd4eqZ3cEJUpOq3+4WfH9brxzYqljjtWdo3vmID1E3l3gRBwmMWP/TFckUh6
 yzrx/T9ukBdVz32OXUlPOM7UDQUNqV9hHOlEvl2HzNMjT0C2HAZdAW5K1w+kyF3O9K/udGkmtvF
 iXBd9GBghnNoDcPSYoJykC7CHQFg3F0QwO57aObiPlwYE3m9UwNiSoeKGnvvbz9StUuZFmQ891Q
 VGR2z2iSnXHJjdEeq9VuhX7Fq+a6oZ+AT7Vk0vFRsjtQQoU1aabDb3he7+YXUZTm321T0OK9Bpk
 +qIyed+ZhQ8wrVY/jNLwoq7HnkVKY6Ve94qkYOyMcAxbX6ecdSaRNvn6fSW2lqCSW+Miaf2hU+W
 0y/T8Q9nnQ71wZGwYlsU8H3M2qD8foJC03ucY7qZ1Ib+UCLz/8800xJPGU
X-Received: by 2002:a05:6808:e3ce:b0:467:ee:7a2f with SMTP id
 5614622812f47-4824a943eb0mr4632009b6e.28.1778526399575; 
 Mon, 11 May 2026 12:06:39 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm7157011a34.23.2026.05.11.12.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 12:06:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
	philmd@linaro.org
Subject: [PATCH 2/5] target-info: Expose target_info as const data
Date: Mon, 11 May 2026 14:06:31 -0500
Message-ID: <20260511190634.472174-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511190634.472174-1-richard.henderson@linaro.org>
References: <20260511190634.472174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Expose a const TargetInfo structure instead of a function
returning a const pointer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/target-info-impl.h   | 11 ++++----
 include/qemu/target-info-init.h   | 45 ++++++++++++++++++++++---------
 configs/targets/aarch64-softmmu.c | 18 +++----------
 configs/targets/arm-softmmu.c     | 18 +++----------
 page-vary-common.c                |  8 ++----
 page-vary-system.c                |  6 ++---
 target-info-qom.c                 | 11 +++-----
 target-info-stub.c                | 28 ++++---------------
 target-info.c                     | 12 ++++-----
 9 files changed, 65 insertions(+), 92 deletions(-)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index c917d546ea..df94af4ef3 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -34,11 +34,10 @@ typedef struct TargetInfo {
     bool page_bits_vary;
 } TargetInfo;
 
-/**
- * target_info:
- *
- * Returns: The TargetInfo structure definition for this target binary.
- */
-const TargetInfo *target_info(void);
+extern
+#ifndef NONCONST_TARGET_INFO
+const
+#endif
+TargetInfo target_info;
 
 #endif
diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index a539d14d78..a70edeac21 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -20,30 +20,51 @@ static void register_##info(void)                                           \
 module_init(register_##info, MODULE_INIT_TARGET_INFO)
 
 #ifdef COMPILING_PER_TARGET
+
+#ifndef TARGET_PAGE_BITS_VARY
+# define DEF_TARGET_INFO_PB \
+    .page_bits_init = TARGET_PAGE_BITS
+#elif defined(TARGET_PAGE_BITS_LEGACY)
+# define DEF_TARGET_INFO_PB \
+    .page_bits_vary = true, .page_bits_init = TARGET_PAGE_BITS_LEGACY
+#else
+# define DEF_TARGET_INFO_PB \
+    .page_bits_vary = true
+#endif
+
+#define DEF_TARGET_INFO_VAR(DECL, TYPE, MACHINE)                            \
+const TargetInfo DECL = {                                                   \
+    .target_name = TARGET_NAME,                                             \
+    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),                      \
+    .long_bits = TARGET_LONG_BITS,                                          \
+    .cpu_type = TYPE,                                                       \
+    .machine_typename = MACHINE,                                            \
+    .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE, \
+    DEF_TARGET_INFO_PB,                                                     \
+};
+
 #ifdef CONFIG_USER_ONLY
 
 /*
  * User mode does not support multiple targets in the same binary, so just
  * define target_info().
  */
-#define target_info_init(ti_var)        \
-const TargetInfo *target_info(void)     \
-{                                       \
-    return &ti_var;                     \
-}
+#define DEF_TARGET_INFO(DECL, TYPE, MACHINE) \
+    DEF_TARGET_INFO_VAR(target_info, TYPE, MACHINE)
 
 #else /* CONFIG_USER_ONLY */
 
 #include "qemu/target-info-qom.h"
 #include "qom/object.h"
 
-#define target_info_init(ti_var)                                            \
-static const TypeInfo ti_var##_type_info = {                                \
-    .name = TYPE_TARGET_INFO"-"TARGET_NAME,                                 \
-    .parent = TYPE_TARGET_INFO,                                             \
-    .class_data = &ti_var,                                                  \
-};                                                                          \
-DEFINE_TARGET_INFO_TYPE(ti_var##_type_info)
+#define DEF_TARGET_INFO(DECL, TYPE, MACHINE)                                \
+    static DEF_TARGET_INFO_VAR(DECL, TYPE, MACHINE)                         \
+    static const TypeInfo DECL##_type_info = {                              \
+        .name = TYPE_TARGET_INFO"-"TARGET_NAME,                             \
+        .parent = TYPE_TARGET_INFO,                                         \
+        .class_data = &DECL,                                                \
+    };                                                                      \
+    DEFINE_TARGET_INFO_TYPE(DECL##_type_info)
 
 #endif /* CONFIG_USER_ONLY */
 #endif /* COMPILING_PER_TARGET */
diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 75d95b0e74..4f43f3e89a 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -7,21 +7,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/cpu-param.h"
+#include "qemu/target-info-impl.h"
+#include "qemu/target-info-init.h"
 
-static const TargetInfo target_info_aarch64_system = {
-    .target_name = "aarch64",
-    .target_arch = SYS_EMU_TARGET_AARCH64,
-    .long_bits = 64,
-    .cpu_type = TYPE_ARM_CPU,
-    .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-};
-
-target_info_init(target_info_aarch64_system)
+DEF_TARGET_INFO(target_info_aarch64_system,
+                TYPE_ARM_CPU, TYPE_TARGET_AARCH64_MACHINE)
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 73546fa573..8272ce58fd 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -7,21 +7,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/cpu-param.h"
+#include "qemu/target-info-impl.h"
+#include "qemu/target-info-init.h"
 
-static const TargetInfo target_info_arm_system = {
-    .target_name = "arm",
-    .target_arch = SYS_EMU_TARGET_ARM,
-    .long_bits = 32,
-    .cpu_type = TYPE_ARM_CPU,
-    .machine_typename = TYPE_TARGET_ARM_MACHINE,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-};
-
-target_info_init(target_info_arm_system)
+DEF_TARGET_INFO(target_info_arm_system,
+                TYPE_ARM_CPU, TYPE_TARGET_ARM_MACHINE)
diff --git a/page-vary-common.c b/page-vary-common.c
index ddd0863378..b4e8cdf405 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -29,10 +29,8 @@ TargetPageBits target_page;
 
 bool set_preferred_target_page_bits(int bits)
 {
-    const TargetInfo *ti = target_info();
-
     assert(bits >= TARGET_PAGE_BITS_MIN);
-    if (ti->page_bits_vary) {
+    if (target_info.page_bits_vary) {
 
         /*
          * The target page size is the lowest common denominator for all
@@ -55,9 +53,7 @@ void finalize_target_page_bits(void)
     int bits = target_page.bits;
 
     if (bits == 0) {
-        const TargetInfo *ti = target_info();
-
-        bits = ti->page_bits_init;
+        bits = target_info.page_bits_init;
         assert(bits != 0);
         target_page.bits = bits;
     }
diff --git a/page-vary-system.c b/page-vary-system.c
index 6c49c10e23..b2a1c45deb 100644
--- a/page-vary-system.c
+++ b/page-vary-system.c
@@ -26,8 +26,6 @@ QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
 
 int migration_legacy_page_bits(void)
 {
-    const TargetInfo *ti = target_info();
-
-    assert(ti->page_bits_init >= TARGET_PAGE_BITS_MIN);
-    return ti->page_bits_init;
+    assert(target_info.page_bits_init >= TARGET_PAGE_BITS_MIN);
+    return target_info.page_bits_init;
 }
diff --git a/target-info-qom.c b/target-info-qom.c
index 52dfc8aee4..abaf7507a0 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -6,6 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#define NONCONST_TARGET_INFO
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
@@ -44,12 +46,7 @@ static const TypeInfo target_info_parent_type = {
 
 DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
 
-static const TargetInfo *target_info_ptr;
-
-const TargetInfo *target_info(void)
-{
-    return target_info_ptr;
-}
+TargetInfo target_info;
 
 void target_info_qom_set_target(void)
 {
@@ -62,5 +59,5 @@ void target_info_qom_set_target(void)
                                  "more than one target-info is available");
     }
 
-    target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
+    target_info = *TARGET_INFO_CLASS(targets->data)->target_info;
 }
diff --git a/target-info-stub.c b/target-info-stub.c
index 22b7911201..813d562058 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -7,13 +7,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/core/boards.h"
+#include "exec/cpu-defs.h"
+#include "exec/page-vary.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
-#include "hw/core/boards.h"
-#include "cpu.h"
-#include "exec/cpu-defs.h"
-#include "exec/page-vary.h"
 
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
@@ -24,22 +24,4 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 #endif
 
-static const TargetInfo target_info_stub = {
-    .target_name = TARGET_NAME,
-    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
-    .long_bits = TARGET_LONG_BITS,
-    .cpu_type = CPU_RESOLVING_TYPE,
-    .machine_typename = TYPE_MACHINE,
-    .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
-#ifdef TARGET_PAGE_BITS_VARY
-    .page_bits_vary = true,
-# ifdef TARGET_PAGE_BITS_LEGACY
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-# endif
-#else
-    .page_bits_vary = false,
-    .page_bits_init = TARGET_PAGE_BITS,
-#endif
-};
-
-target_info_init(target_info_stub)
+DEF_TARGET_INFO(target_info_stub, CPU_RESOLVING_TYPE, TYPE_MACHINE)
diff --git a/target-info.c b/target-info.c
index 28c458fc7a..6bd3f9485f 100644
--- a/target-info.c
+++ b/target-info.c
@@ -14,32 +14,32 @@
 
 const char *target_name(void)
 {
-    return target_info()->target_name;
+    return target_info.target_name;
 }
 
 unsigned target_long_bits(void)
 {
-    return target_info()->long_bits;
+    return target_info.long_bits;
 }
 
 SysEmuTarget target_arch(void)
 {
-    return target_info()->target_arch;
+    return target_info.target_arch;
 }
 
 const char *target_cpu_type(void)
 {
-    return target_info()->cpu_type;
+    return target_info.cpu_type;
 }
 
 const char *target_machine_typename(void)
 {
-    return target_info()->machine_typename;
+    return target_info.machine_typename;
 }
 
 EndianMode target_endian_mode(void)
 {
-    return target_info()->endianness;
+    return target_info.endianness;
 }
 
 bool target_big_endian(void)
-- 
2.43.0


