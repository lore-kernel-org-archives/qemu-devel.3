Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E013FCD11C2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKfU-0004sm-JY; Thu, 21 Mar 2024 11:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfQ-0004ds-64
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfH-0001Fv-GA
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4146feb33e1so8759355e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036146; x=1711640946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Uml8evcLi9xkWgCFD8gP1/OkUGdeyARM6PHY5ELWBs=;
 b=dTeYg3U/cwhEnshK10ojj7HgizCwdzRaO+SjS/8d4AHMV3Gtg7H+hwp+TiM90wlYkN
 N87nFIjtmoj9i9u67lWZjOjcKW992T9kuu2q01UebM1RMpc/1ECcFip9tLk+NodTiTi7
 QpH/nfdl+2Bv6j6d8YgKPbS6xre3d2K2j/QYlqQwe4mhuyxbWEZSSbT/C22ZLRxXdS51
 zIXx5x6BgqDN7zNuig46DeWiWHVhh0mRn9cvKMdQDYIRKad3x3OtxuutvsJ69lmIJxVm
 BODuy1ALwcsIX6RUGHO3QXpDUHnDaTPvJ9lc8ALGk+QO33/TsuDtAS0w2DSTF4i5WU4J
 x0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036146; x=1711640946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Uml8evcLi9xkWgCFD8gP1/OkUGdeyARM6PHY5ELWBs=;
 b=hPOL1bx49Ij/+y4Rk5VdRsrp4qwwZQ2s2MIIlGfpuNCqHvQwBSUzhgJnKafZW0iZ3T
 lySVn+VFg/IqOYFb3lkgBlIoLqOb/0T9M7YMFiS7JMK/w1zczSf7imC9/JgTUd3Ft854
 OIN9jzr0QkCeBaR5R/LqGMBNmk3d6LQnbniROu+OvE9MFip0hctFNng8Bs3JaYJpyac7
 ymjNmAEEf2BLsiCoGgObI5S0ffK98C+brjBEHO5i18jedglTN0E86Mt0UywHZaq6ZO1I
 gpE0CMm3/onHmhwIcIvq4sckTM/VBzT+9LtDr3in7WDDsyxC3nLFEhOjyfpMOqOQ4Juu
 vXNQ==
X-Gm-Message-State: AOJu0YyTHM9i2ha5IqtiKr41MONfRzC7d5f0TXwdhG6+5fZLIb3Tyxv+
 aITxQuetXHxPLIxQZo25Fre/Td40vYBNAfsIcRhtY4niGHKzU17rPaT7N5ucssKZsPIBOyDqgc+
 w2D0=
X-Google-Smtp-Source: AGHT+IFAw5OqL09R7bmcyeZ9YyOFejxWkGzyRzgg8/RdS1yUB7jjDdFHJRAFWdetwbNp/D/m0mJFLQ==
X-Received: by 2002:a05:600c:4ecf:b0:413:ee4c:57e4 with SMTP id
 g15-20020a05600c4ecf00b00413ee4c57e4mr7568498wmq.8.1711036145816; 
 Thu, 21 Mar 2024 08:49:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 fc12-20020a05600c524c00b0041477d83499sm136619wmb.16.2024.03.21.08.49.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:49:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 03/21] target/i386: Move APIC related code to
 cpu-apic.c
Date: Thu, 21 Mar 2024 16:48:19 +0100
Message-ID: <20240321154838.95771-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move APIC related code split in cpu-sysemu.c and
monitor.c to cpu-apic.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu-apic.c   | 112 +++++++++++++++++++++++++++++++++++++++
 target/i386/cpu-sysemu.c |  77 ---------------------------
 target/i386/monitor.c    |  25 ---------
 target/i386/meson.build  |   1 +
 4 files changed, 113 insertions(+), 102 deletions(-)
 create mode 100644 target/i386/cpu-apic.c

diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
new file mode 100644
index 0000000000..d397ec94dc
--- /dev/null
+++ b/target/i386/cpu-apic.c
@@ -0,0 +1,112 @@
+/*
+ * QEMU x86 CPU <-> APIC
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/error.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp-target.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/kvm.h"
+#include "sysemu/xen.h"
+#include "exec/address-spaces.h"
+#include "hw/qdev-properties.h"
+#include "hw/i386/apic_internal.h"
+#include "cpu-internal.h"
+
+APICCommonClass *apic_get_class(Error **errp)
+{
+    const char *apic_type = "apic";
+
+    /* TODO: in-kernel irqchip for hvf */
+    if (kvm_enabled()) {
+        if (!kvm_irqchip_in_kernel()) {
+            error_setg(errp, "KVM does not support userspace APIC");
+            return NULL;
+        }
+        apic_type = "kvm-apic";
+    } else if (xen_enabled()) {
+        apic_type = "xen-apic";
+    } else if (whpx_apic_in_platform()) {
+        apic_type = "whpx-apic";
+    }
+
+    return APIC_COMMON_CLASS(object_class_by_name(apic_type));
+}
+
+void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
+{
+    APICCommonState *apic;
+    APICCommonClass *apic_class = apic_get_class(errp);
+
+    if (!apic_class) {
+        return;
+    }
+
+    cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
+    object_property_add_child(OBJECT(cpu), "lapic",
+                              OBJECT(cpu->apic_state));
+    object_unref(OBJECT(cpu->apic_state));
+
+    /* TODO: convert to link<> */
+    apic = APIC_COMMON(cpu->apic_state);
+    apic->cpu = cpu;
+    apic->apicbase = APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
+
+    /*
+     * apic_common_set_id needs to check if the CPU has x2APIC
+     * feature in case APIC ID >= 255, so we need to set apic->cpu
+     * before setting APIC ID
+     */
+    qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
+}
+
+void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
+{
+    APICCommonState *apic;
+    static bool apic_mmio_map_once;
+
+    if (cpu->apic_state == NULL) {
+        return;
+    }
+    qdev_realize(DEVICE(cpu->apic_state), NULL, errp);
+
+    /* Map APIC MMIO area */
+    apic = APIC_COMMON(cpu->apic_state);
+    if (!apic_mmio_map_once) {
+        memory_region_add_subregion_overlap(get_system_memory(),
+                                            apic->apicbase &
+                                            MSR_IA32_APICBASE_BASE,
+                                            &apic->io_memory,
+                                            0x1000);
+        apic_mmio_map_once = true;
+     }
+}
+
+void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
+{
+    CPUState *cs;
+
+    if (qdict_haskey(qdict, "apic-id")) {
+        int id = qdict_get_try_int(qdict, "apic-id", 0);
+
+        cs = cpu_by_arch_id(id);
+        if (cs) {
+            cpu_synchronize_state(cs);
+        }
+    } else {
+        cs = mon_get_cpu(mon);
+    }
+
+
+    if (!cs) {
+        monitor_printf(mon, "No CPU available\n");
+        return;
+    }
+    x86_cpu_dump_local_apic_state(cs, CPU_DUMP_FPU);
+}
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 3f9093d285..227ac021f6 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -19,19 +19,12 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "sysemu/kvm.h"
-#include "sysemu/xen.h"
-#include "sysemu/whpx.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
 #include "qapi/qapi-commands-machine-target.h"
-#include "hw/qdev-properties.h"
-
-#include "exec/address-spaces.h"
-#include "hw/i386/apic_internal.h"
 
 #include "cpu-internal.h"
 
@@ -273,75 +266,6 @@ void x86_cpu_machine_reset_cb(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
-APICCommonClass *apic_get_class(Error **errp)
-{
-    const char *apic_type = "apic";
-
-    /* TODO: in-kernel irqchip for hvf */
-    if (kvm_enabled()) {
-        if (!kvm_irqchip_in_kernel()) {
-            error_setg(errp, "KVM does not support userspace APIC");
-            return NULL;
-        }
-        apic_type = "kvm-apic";
-    } else if (xen_enabled()) {
-        apic_type = "xen-apic";
-    } else if (whpx_apic_in_platform()) {
-        apic_type = "whpx-apic";
-    }
-
-    return APIC_COMMON_CLASS(object_class_by_name(apic_type));
-}
-
-void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
-{
-    APICCommonState *apic;
-    APICCommonClass *apic_class = apic_get_class(errp);
-
-    if (!apic_class) {
-        return;
-    }
-
-    cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
-    object_property_add_child(OBJECT(cpu), "lapic",
-                              OBJECT(cpu->apic_state));
-    object_unref(OBJECT(cpu->apic_state));
-
-    /* TODO: convert to link<> */
-    apic = APIC_COMMON(cpu->apic_state);
-    apic->cpu = cpu;
-    apic->apicbase = APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
-
-    /*
-     * apic_common_set_id needs to check if the CPU has x2APIC
-     * feature in case APIC ID >= 255, so we need to set apic->cpu
-     * before setting APIC ID
-     */
-    qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
-}
-
-void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
-{
-    APICCommonState *apic;
-    static bool apic_mmio_map_once;
-
-    if (cpu->apic_state == NULL) {
-        return;
-    }
-    qdev_realize(DEVICE(cpu->apic_state), NULL, errp);
-
-    /* Map APIC MMIO area */
-    apic = APIC_COMMON(cpu->apic_state);
-    if (!apic_mmio_map_once) {
-        memory_region_add_subregion_overlap(get_system_memory(),
-                                            apic->apicbase &
-                                            MSR_IA32_APICBASE_BASE,
-                                            &apic->io_memory,
-                                            0x1000);
-        apic_mmio_map_once = true;
-     }
-}
-
 GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -385,4 +309,3 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                      errp);
     qapi_free_GuestPanicInformation(panic_info);
 }
-
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 3a281dab02..2d766b2637 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -28,8 +28,6 @@
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "qapi/qmp/qdict.h"
-#include "sysemu/hw_accel.h"
-#include "sysemu/kvm.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-commands-misc.h"
@@ -647,26 +645,3 @@ const MonitorDef *target_monitor_defs(void)
 {
     return monitor_defs;
 }
-
-void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
-{
-    CPUState *cs;
-
-    if (qdict_haskey(qdict, "apic-id")) {
-        int id = qdict_get_try_int(qdict, "apic-id", 0);
-
-        cs = cpu_by_arch_id(id);
-        if (cs) {
-            cpu_synchronize_state(cs);
-        }
-    } else {
-        cs = mon_get_cpu(mon);
-    }
-
-
-    if (!cs) {
-        monitor_printf(mon, "No CPU available\n");
-        return;
-    }
-    x86_cpu_dump_local_apic_state(cs, CPU_DUMP_FPU);
-}
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 7c74bfa859..ba8dc68a34 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -18,6 +18,7 @@ i386_system_ss.add(files(
   'arch_memory_mapping.c',
   'machine.c',
   'monitor.c',
+  'cpu-apic.c',
   'cpu-sysemu.c',
 ))
 i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
-- 
2.41.0


