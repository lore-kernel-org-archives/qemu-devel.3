Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1975C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UL3-0003KW-OE; Thu, 03 Apr 2025 19:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKz-000336-RC
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:51:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKx-0000pM-L8
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:51:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so14689145e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724265; x=1744329065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHI9FfBHfNNt6d2GHyCNA9IUMx30aclMNhMOJHynnN4=;
 b=Gg18yEAH7e877bX9WGbqlPTrywrNlOSjPjEvmcvh7VQ28VUZD8uC1WHzjw+QVZ7PgI
 0w3QAwO53HIYIRH0b0+jhcoX8xqHoJi3czymQGLPpvP4BEbcDwwuQp7HV0dUIJTo6Ftg
 H4BgWfeeMTz+xA+0/BPgdXopqBtwhvQ+plFJPYg/YNeFLcXGJVjK767u/5HbgxxxR8sI
 wgv0F82qfjR7s6HhEAn9E3rKEtQB5TNz7ENjB1ZBTahTwnOC72PzsjKOrXdg3csNBCrB
 8Ycv4AFhY1SAGUptzOWZGZvIkgfv8cPRDLVUkPOG6vPetWVrLF7bobB+HNXhuJ64vodV
 MRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724265; x=1744329065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHI9FfBHfNNt6d2GHyCNA9IUMx30aclMNhMOJHynnN4=;
 b=rLxmdzITISvwDuoFKh7eiZ4YZJE/Wr2mvjVFn4VHQEOewN1KJLpBC6v4ZtvRjN9dTB
 LGzzaUI9GepO3+2anv/avMZGiLDEQW+8jYrMxweJnLvL6xFYqabVE3DvYx5Wy1qIDLV8
 l4TUNpi2F8PkIVF6l6ebYo95IR+484yghj1n4mBFxlKcE5LrADdWo4CgueSphU5iysLg
 GQMmTsLXElis3uFU9/xKimKYTi8ICKfnDPdKahnvm/jUiKMyrtyCCRMz3v5AbshFr8jD
 wXs0qqHXOplYw7EDG/OnwNYsV0M+s7Gf2Ud2EMAeqazAZMnWDaSjUoydq1ty00Fyz6Oc
 btoA==
X-Gm-Message-State: AOJu0YyE3OPuT99e4aQwR8vEN9n0WSjXWJRfNtJvJIQQ1QHROk6cikBe
 aW50vgfVhjMPeTM74POamshM9jVHLK3tR++ciaUix542bWTaTK3tHqi3A2SPMXoNqqLYb+wYBF/
 i
X-Gm-Gg: ASbGncsiH1H4/7MyRGBsjnpCMg8hsH0A70yxAOY3atjP6vpHLT4VdoiyFkfAUKzTGRN
 Kv2dv9oCvvd9glHYveJ9s6UNMwJpFo4LTlFj8lNMHmrhsFfDRerb/c9qcnzwDbcaer6bWmedqPa
 h8LMwtmAzPphncpO0FPkLBWw0EYB5LrBm+rCOlgYXPdSEgGeXUjGSeVKVH34C1RSmak77pxq3ST
 jRgK0TkpDS0WsUqI5y4KUuRx/W+CTBHS3u1lTS7w6cRoomcnvesOZt64GKWu/uouA7kmp20vEbQ
 6YjQjlrkSWBNuVFtBVmLJMQePi37vqlC/9aQsLs8aMPB2UZ/DrRkgGehNuNDx/q5cHocMb5ua91
 XpOmrwq3dL2p3oOKRacc=
X-Google-Smtp-Source: AGHT+IFwmBjwvR4D+ddltqDgiwC4CAXPCcL4AGk7x55yazsi16N0uPNlsRWM9mN5zrgpebnpDsQTPw==
X-Received: by 2002:a05:6000:2211:b0:391:952:c74a with SMTP id
 ffacd0b85a97d-39c2e610f88mr4784201f8f.8.1743724265173; 
 Thu, 03 Apr 2025 16:51:05 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c300968c4sm2999981f8f.9.2025.04.03.16.51.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:51:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 17/19] accel: Move target-agnostic code from
 accel-target.c -> accel-common.c
Date: Fri,  4 Apr 2025 01:49:12 +0200
Message-ID: <20250403234914.9154-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/accel-common.c | 142 +++++++++++++++++++++++++++++++++++++++++++
 accel/accel-target.c | 129 ---------------------------------------
 accel/meson.build    |   1 +
 3 files changed, 143 insertions(+), 129 deletions(-)
 create mode 100644 accel/accel-common.c

diff --git a/accel/accel-common.c b/accel/accel-common.c
new file mode 100644
index 00000000000..f505461fc88
--- /dev/null
+++ b/accel/accel-common.c
@@ -0,0 +1,142 @@
+/*
+ * QEMU accel class, components common to system emulation and user mode
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2014 Red Hat Inc.
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "qemu/target_info.h"
+#include "accel/accel-cpu.h"
+#include "accel-internal.h"
+
+/* Lookup AccelClass from opt_name. Returns NULL if not found */
+AccelClass *accel_find(const char *opt_name)
+{
+    char *class_name = g_strdup_printf(ACCEL_CLASS_NAME("%s"), opt_name);
+    AccelClass *ac = ACCEL_CLASS(module_object_class_by_name(class_name));
+    g_free(class_name);
+    return ac;
+}
+
+/* Return the name of the current accelerator */
+const char *current_accel_name(void)
+{
+    AccelClass *ac = ACCEL_GET_CLASS(current_accel());
+
+    return ac->name;
+}
+
+static void accel_init_cpu_int_aux(ObjectClass *klass, void *opaque)
+{
+    CPUClass *cc = CPU_CLASS(klass);
+    AccelCPUClass *accel_cpu = opaque;
+
+    /*
+     * The first callback allows accel-cpu to run initializations
+     * for the CPU, customizing CPU behavior according to the accelerator.
+     *
+     * The second one allows the CPU to customize the accel-cpu
+     * behavior according to the CPU.
+     *
+     * The second is currently only used by TCG, to specialize the
+     * TCGCPUOps depending on the CPU type.
+     */
+    cc->accel_cpu = accel_cpu;
+    if (accel_cpu->cpu_class_init) {
+        accel_cpu->cpu_class_init(cc);
+    }
+    if (cc->init_accel_cpu) {
+        cc->init_accel_cpu(accel_cpu, cc);
+    }
+}
+
+/* initialize the arch-specific accel CpuClass interfaces */
+static void accel_init_cpu_interfaces(AccelClass *ac)
+{
+    const char *ac_name; /* AccelClass name */
+    char *acc_name;      /* AccelCPUClass name */
+    ObjectClass *acc;    /* AccelCPUClass */
+    const char *cpu_resolving_type = target_cpu_type();
+
+    ac_name = object_class_get_name(OBJECT_CLASS(ac));
+    g_assert(ac_name != NULL);
+
+    acc_name = g_strdup_printf("%s-%s", ac_name, cpu_resolving_type);
+    acc = object_class_by_name(acc_name);
+    g_free(acc_name);
+
+    if (acc) {
+        object_class_foreach(accel_init_cpu_int_aux,
+                             cpu_resolving_type, false, acc);
+    }
+}
+
+void accel_init_interfaces(AccelClass *ac)
+{
+    accel_init_ops_interfaces(ac);
+    accel_init_cpu_interfaces(ac);
+}
+
+void accel_cpu_instance_init(CPUState *cpu)
+{
+    if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
+        cpu->cc->accel_cpu->cpu_instance_init(cpu);
+    }
+}
+
+bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    /* target specific realization */
+    if (cpu->cc->accel_cpu
+        && cpu->cc->accel_cpu->cpu_target_realize
+        && !cpu->cc->accel_cpu->cpu_target_realize(cpu, errp)) {
+        return false;
+    }
+
+    /* generic realization */
+    if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
+void accel_cpu_common_unrealize(CPUState *cpu)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    /* generic unrealization */
+    if (acc->cpu_common_unrealize) {
+        acc->cpu_common_unrealize(cpu);
+    }
+}
+
+int accel_supported_gdbstub_sstep_flags(void)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    if (acc->gdbstub_supported_sstep_flags) {
+        return acc->gdbstub_supported_sstep_flags();
+    }
+    return 0;
+}
+
+static const TypeInfo accel_types[] = {
+    {
+        .name           = TYPE_ACCEL,
+        .parent         = TYPE_OBJECT,
+        .class_size     = sizeof(AccelClass),
+        .instance_size  = sizeof(AccelState),
+        .abstract       = true,
+    },
+};
+
+DEFINE_TYPES(accel_types)
diff --git a/accel/accel-target.c b/accel/accel-target.c
index 769a90230bf..7fd392fbc4a 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -24,135 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/accel.h"
-#include "qemu/target_info.h"
-
 #include "accel/accel-cpu-target.h"
-#include "accel-internal.h"
-
-static const TypeInfo accel_type = {
-    .name = TYPE_ACCEL,
-    .parent = TYPE_OBJECT,
-    .class_size = sizeof(AccelClass),
-    .instance_size = sizeof(AccelState),
-    .abstract = true,
-};
-
-/* Lookup AccelClass from opt_name. Returns NULL if not found */
-AccelClass *accel_find(const char *opt_name)
-{
-    char *class_name = g_strdup_printf(ACCEL_CLASS_NAME("%s"), opt_name);
-    AccelClass *ac = ACCEL_CLASS(module_object_class_by_name(class_name));
-    g_free(class_name);
-    return ac;
-}
-
-/* Return the name of the current accelerator */
-const char *current_accel_name(void)
-{
-    AccelClass *ac = ACCEL_GET_CLASS(current_accel());
-
-    return ac->name;
-}
-
-static void accel_init_cpu_int_aux(ObjectClass *klass, void *opaque)
-{
-    CPUClass *cc = CPU_CLASS(klass);
-    AccelCPUClass *accel_cpu = opaque;
-
-    /*
-     * The first callback allows accel-cpu to run initializations
-     * for the CPU, customizing CPU behavior according to the accelerator.
-     *
-     * The second one allows the CPU to customize the accel-cpu
-     * behavior according to the CPU.
-     *
-     * The second is currently only used by TCG, to specialize the
-     * TCGCPUOps depending on the CPU type.
-     */
-    cc->accel_cpu = accel_cpu;
-    if (accel_cpu->cpu_class_init) {
-        accel_cpu->cpu_class_init(cc);
-    }
-    if (cc->init_accel_cpu) {
-        cc->init_accel_cpu(accel_cpu, cc);
-    }
-}
-
-/* initialize the arch-specific accel CpuClass interfaces */
-static void accel_init_cpu_interfaces(AccelClass *ac)
-{
-    const char *ac_name; /* AccelClass name */
-    char *acc_name;      /* AccelCPUClass name */
-    ObjectClass *acc;    /* AccelCPUClass */
-    const char *cpu_resolving_type = target_cpu_type();
-
-    ac_name = object_class_get_name(OBJECT_CLASS(ac));
-    g_assert(ac_name != NULL);
-
-    acc_name = g_strdup_printf("%s-%s", ac_name, cpu_resolving_type);
-    acc = object_class_by_name(acc_name);
-    g_free(acc_name);
-
-    if (acc) {
-        object_class_foreach(accel_init_cpu_int_aux,
-                             cpu_resolving_type, false, acc);
-    }
-}
-
-void accel_init_interfaces(AccelClass *ac)
-{
-    accel_init_ops_interfaces(ac);
-    accel_init_cpu_interfaces(ac);
-}
-
-void accel_cpu_instance_init(CPUState *cpu)
-{
-    if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
-        cpu->cc->accel_cpu->cpu_instance_init(cpu);
-    }
-}
-
-bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
-{
-    AccelState *accel = current_accel();
-    AccelClass *acc = ACCEL_GET_CLASS(accel);
-
-    /* target specific realization */
-    if (cpu->cc->accel_cpu
-        && cpu->cc->accel_cpu->cpu_target_realize
-        && !cpu->cc->accel_cpu->cpu_target_realize(cpu, errp)) {
-        return false;
-    }
-
-    /* generic realization */
-    if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
-        return false;
-    }
-
-    return true;
-}
-
-void accel_cpu_common_unrealize(CPUState *cpu)
-{
-    AccelState *accel = current_accel();
-    AccelClass *acc = ACCEL_GET_CLASS(accel);
-
-    /* generic unrealization */
-    if (acc->cpu_common_unrealize) {
-        acc->cpu_common_unrealize(cpu);
-    }
-}
-
-int accel_supported_gdbstub_sstep_flags(void)
-{
-    AccelState *accel = current_accel();
-    AccelClass *acc = ACCEL_GET_CLASS(accel);
-    if (acc->gdbstub_supported_sstep_flags) {
-        return acc->gdbstub_supported_sstep_flags();
-    }
-    return 0;
-}
 
 static const TypeInfo accel_cpu_type = {
     .name = TYPE_ACCEL_CPU,
@@ -163,7 +35,6 @@ static const TypeInfo accel_cpu_type = {
 
 static void register_accel_types(void)
 {
-    type_register_static(&accel_type);
     type_register_static(&accel_cpu_type);
 }
 
diff --git a/accel/meson.build b/accel/meson.build
index 5eaeb683385..52909314bfa 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,3 +1,4 @@
+common_ss.add(files('accel-common.c'))
 specific_ss.add(files('accel-target.c'))
 system_ss.add(files('accel-system.c', 'accel-blocker.c'))
 user_ss.add(files('accel-user.c'))
-- 
2.47.1


