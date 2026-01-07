Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ABBD0D171
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vda6h-0003hj-PA; Wed, 07 Jan 2026 15:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda6b-0003ae-Od
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:12 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda6Z-0006Of-NV
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso11974115e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767817566; x=1768422366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3f+WElhWajbfxthtkIQaNZgHaZBpzZYhHfL8j7tnPo=;
 b=JxaKhb52IZGYMbfAU8iQ8X3SVpSUuPVvUgImfXStoFuL5aegkZeW50KnzuHB/Sm3ok
 jvqNkw7epdLRvg/yKePU7RG+R8beVSaku846OxAtuQAKfxSi7kmnKp1FjdaToja8QzE5
 RkwsBZvxUfgRLro3BNFuMg2He7Fu109NX+IVy68zXfQbuTl9gNqUgcn+big9X3TU+GCi
 ciZs5euPZAF4W0uFV6dtrPJCPlTUP+bWpRuwDRSz9EE74sxwOR/MuPUrTaqzqH1NeItp
 clIDbr8vZvUlFFEPdk9nH05+3/ZJRghW57gZ+JeYh2rciba3C7K8bG9ZzRfKQdQoROfD
 9fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817566; x=1768422366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p3f+WElhWajbfxthtkIQaNZgHaZBpzZYhHfL8j7tnPo=;
 b=UqUDRtCTH1cKONbSTCGPDFtD8RBSeE56FYJmA4GoNUadzWHOP939Kf4+2JCfcskFyU
 Xt71g6RjqUscpwm7uEl6n68SRGdJqW5S9Z7YHaPhKU7hHXqL3Q6t5uOZOIxBPKaCcvrp
 knJCIIQTXDih6QyvIY4F3OSaDTTDZcg+w8D7GqD0I5QPp08I5FFnE8EFmPcDoMOnthD3
 DOIWJji0tnwLIAje5BTj0tpSAeqEzzF+n7QxeuQYY7YZtNcy+qDO6MYEM8zjTZ4xqnxx
 eIFCadtvE/cpjVjjWEvQq9IAcVx4LflQZYrzZTqy4rdp9emRjSGeIOuXQPZiKD+ty72b
 mkaA==
X-Gm-Message-State: AOJu0YzE/EHaZXAL3s5Hf6tyfTkiB7+Ygr8bqk0tqVywDhZdYrWeZayN
 76eaw4Tu1N2EuzPwI5PM6R6yUFyOkszc5rOhI8MJDvN8chDU8/9IrUNyT9XiSpAkbzHlMHFE3Zj
 GrqXaHtA=
X-Gm-Gg: AY/fxX6qWN+Mt++haXqIIOg2vV9Ni05o0ejnbUsUE76Z4oeBDkEjfHb3L+LBnWtVhCS
 q1nZRQULWCE9t2YFR0IMcMnkeSUGo6obIDu3dgdPhFANFSb920yD5XaDlk3QAyCtaT3B6k4z37F
 lcnkRz3dvKnyAcA5E+jspwMVMHqtAvRQkL4z4LklLoDrgpilOMRivRVKH/U+bbs3MvJYuJLCWmx
 FplL/xbEGUXI+HyQo4d5hDdQlU7GuDzCV0Mpub4SbDvSVhHE1iWd6Autt1MnsHmBqKTysW2wJHu
 6aNvrvhr5v1rUiIRXNv6K7u23WaNGGDjDzW1CMMFaXXuYcg8zO9229C5eMtVnT3sKUjzHDvBEAo
 EwOoJbyK30KwZjjxCtMT7o1PnEziGQHFvNvZbiz/WasrELLhIrP54MHekF/7QqioJ72nxPUyVr1
 Q+WcSIcENF1Sqk5jt5BLGQuKg54s9nTgTibkLJoGJmrponJuvNuY8oOh66o8/A
X-Google-Smtp-Source: AGHT+IGXJA4s/xpVZwrTyfFZ/89WB51CBD9JuCI6C8wmdy1hmAtsVbH3lhB267owWYE528WtrM3L/Q==
X-Received: by 2002:a05:600c:4447:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-47d84b3b8b9mr45355865e9.32.1767817565925; 
 Wed, 07 Jan 2026 12:26:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f668e03sm119868075e9.14.2026.01.07.12.26.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:26:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] target/xtensa: Convert XTENSA_DEFAULT_CPU_MODEL to
 runtime helper (MMU)
Date: Wed,  7 Jan 2026 21:25:50 +0100
Message-ID: <20260107202556.55787-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107202556.55787-1-philmd@linaro.org>
References: <20260107202556.55787-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

In order to remove the TARGET_BIG_ENDIAN use in "cpu.h",
introduce the xtensa_default_cpu_model() helper which
returns the current XTENSA_DEFAULT_CPU_MODEL but evaluating
endianness at runtime. Update the machines using it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/cpu-qom.h     |  2 ++
 target/xtensa/cpu.h         |  4 ----
 hw/xtensa/sim.c             | 10 ++++++++--
 hw/xtensa/virt.c            | 11 +++++++++--
 hw/xtensa/xtfpga.c          | 17 +++++++++--------
 linux-user/xtensa/elfload.c |  4 ++--
 target/xtensa/cpu.c         |  5 +++++
 7 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/target/xtensa/cpu-qom.h b/target/xtensa/cpu-qom.h
index d932346b5fe..66992d08c2e 100644
--- a/target/xtensa/cpu-qom.h
+++ b/target/xtensa/cpu-qom.h
@@ -38,4 +38,6 @@ OBJECT_DECLARE_CPU_TYPE(XtensaCPU, XtensaCPUClass, XTENSA_CPU)
 #define XTENSA_CPU_TYPE_SUFFIX "-" TYPE_XTENSA_CPU
 #define XTENSA_CPU_TYPE_NAME(model) model XTENSA_CPU_TYPE_SUFFIX
 
+const char *xtensa_default_cpu_model(void);
+
 #endif
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 22192924841..fe2f25e527c 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -606,14 +606,10 @@ G_NORETURN void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 #define CPU_RESOLVING_TYPE TYPE_XTENSA_CPU
 
 #if TARGET_BIG_ENDIAN
-#define XTENSA_DEFAULT_CPU_MODEL "fsf"
 #define XTENSA_DEFAULT_CPU_NOMMU_MODEL "fsf"
 #else
-#define XTENSA_DEFAULT_CPU_MODEL "dc232b"
 #define XTENSA_DEFAULT_CPU_NOMMU_MODEL "de212"
 #endif
-#define XTENSA_DEFAULT_CPU_TYPE \
-    XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_MODEL)
 #define XTENSA_DEFAULT_CPU_NOMMU_TYPE \
     XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_NOMMU_MODEL)
 
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 994460d0414..03dbe69c2d4 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -36,6 +36,7 @@
 #include "qemu/error-report.h"
 #include "xtensa_memory.h"
 #include "xtensa_sim.h"
+#include "target/xtensa/cpu-qom.h"
 
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
@@ -119,12 +120,17 @@ static void xtensa_sim_init(MachineState *machine)
 
 static void xtensa_sim_machine_init(MachineClass *mc)
 {
-    mc->desc = "sim machine (" XTENSA_DEFAULT_CPU_MODEL ")";
+    if (target_big_endian()) {
+        mc->default_cpu_type = XTENSA_CPU_TYPE_NAME("fsf");
+        mc->desc = "sim machine (fsf)";
+    } else {
+        mc->default_cpu_type = XTENSA_CPU_TYPE_NAME("dc232b");
+        mc->desc = "sim machine (dc232b)";
+    }
     mc->is_default = true;
     mc->init = xtensa_sim_init;
     mc->max_cpus = 4;
     mc->no_serial = 1;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
 DEFINE_MACHINE("sim", xtensa_sim_machine_init)
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 271f06e0953..2275953ce67 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -35,8 +35,10 @@
 #include "elf.h"
 #include "system/memory.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info.h"
 #include "xtensa_memory.h"
 #include "xtensa_sim.h"
+#include "target/xtensa/cpu-qom.h"
 
 static void create_pcie(MachineState *ms, CPUXtensaState *env, int irq_base,
                         hwaddr addr_base)
@@ -117,10 +119,15 @@ static void xtensa_virt_init(MachineState *machine)
 
 static void xtensa_virt_machine_init(MachineClass *mc)
 {
-    mc->desc = "virt machine (" XTENSA_DEFAULT_CPU_MODEL ")";
+    if (target_big_endian()) {
+        mc->default_cpu_type = XTENSA_CPU_TYPE_NAME("fsf");
+        mc->desc = "virt machine (fsf)";
+    } else {
+        mc->default_cpu_type = XTENSA_CPU_TYPE_NAME("dc232b");
+        mc->desc = "virt machine (dc232b)";
+    }
     mc->init = xtensa_virt_init;
     mc->max_cpus = 32;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_nic = "virtio-net-pci";
 }
 
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index d427d68e505..5fd4d655557 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -51,6 +51,7 @@
 #include "hw/xtensa/mx_pic.h"
 #include "exec/cpu-common.h"
 #include "migration/vmstate.h"
+#include "target/xtensa/cpu-qom.h"
 
 typedef struct XtfpgaFlashDesc {
     hwaddr base;
@@ -591,10 +592,10 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "lx60 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
+    mc->desc = g_strdup_printf("lx60 EVB (%s)", xtensa_default_cpu_model());
     mc->init = xtfpga_lx60_init;
     mc->max_cpus = 32;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = xtensa_default_cpu_model();
     mc->default_ram_size = 64 * MiB;
 }
 
@@ -625,10 +626,10 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "lx200 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
+    mc->desc = g_strdup_printf("lx200 EVB (%s)", xtensa_default_cpu_model());
     mc->init = xtfpga_lx200_init;
     mc->max_cpus = 32;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = xtensa_default_cpu_model();
     mc->default_ram_size = 96 * MiB;
 }
 
@@ -659,10 +660,10 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "ml605 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
+    mc->desc = g_strdup_printf("ml605 EVB (%s)", xtensa_default_cpu_model());
     mc->init = xtfpga_ml605_init;
     mc->max_cpus = 32;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = xtensa_default_cpu_model();
     mc->default_ram_size = 512 * MiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
 }
 
@@ -693,10 +694,10 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "kc705 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
+    mc->desc = g_strdup_printf("kc705 EVB (%s)", xtensa_default_cpu_model());
     mc->init = xtfpga_kc705_init;
     mc->max_cpus = 32;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = xtensa_default_cpu_model();
     mc->default_ram_size = 1 * GiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
 }
 
diff --git a/linux-user/xtensa/elfload.c b/linux-user/xtensa/elfload.c
index 68aeed855f9..9bb740d357e 100644
--- a/linux-user/xtensa/elfload.c
+++ b/linux-user/xtensa/elfload.c
@@ -4,11 +4,11 @@
 #include "qemu.h"
 #include "loader.h"
 #include "target_elf.h"
-
+#include "target/xtensa/cpu-qom.h"
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
-    return XTENSA_DEFAULT_CPU_MODEL;
+    return xtensa_default_cpu_model();
 }
 
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUXtensaState *env)
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ecc5e093a40..6220edda976 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "fpu/softfloat.h"
@@ -40,6 +41,10 @@
 #include "system/memory.h"
 #endif
 
+const char *xtensa_default_cpu_model(void)
+{
+    return target_big_endian() ? "fsf" : "dc232b";
+}
 
 static void xtensa_cpu_set_pc(CPUState *cs, vaddr value)
 {
-- 
2.52.0


