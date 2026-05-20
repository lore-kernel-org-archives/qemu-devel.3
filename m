Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6A8CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmXE-00081u-HQ; Wed, 20 May 2026 15:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWu-0007aA-NP
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmWo-0001rk-AE
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490229aa522so19575095e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305064; x=1779909864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+xInswaBJ32C70oJLCcsoTU6R8qZ9x+KpsqUFZrzU04=;
 b=w9rPzil8Jt2gExvho4o/BxkcjVX5w+Lp95DL6KpIu3nh2OzLmS1GvPW79Tp2409lJ9
 FcwVKgnujK9dq1Ho+kU8VcgR4KBnKBoBuH715kKtYQU8vaaW/roTshOnUn/dbJtevhev
 ZAh+iQOvk6vIvdlUEKPYYskWdcNZZD+NawfcI8n7TxWBCDOO7PIXIy0W+ZMeyNVAqYJX
 SQY3YFftZMvOGV1c4FO51W6MxRn1rcusZwbsyI6bXQ8pLwN6+IuWRdBKdC4bu9qF/SNt
 Cgxx6VdWwd3kE2SBMKZIpSd3yZOWS2SF5wNq8Y4sXdlbjZmhBwlMkhvYzJV/XcB3Nptf
 E9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305064; x=1779909864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+xInswaBJ32C70oJLCcsoTU6R8qZ9x+KpsqUFZrzU04=;
 b=HJxNxOQ8S4GozJTJXcE2ZjKUhRhDddpwV0+XFBfz/RanGRtqwB1dSdxbnX8OoQ+Ta0
 UQjUZ5SQMBz6O5fbDDgcghwg5sqrFpxBVnyPGlZSRZkZA/EVolVlL6P2D9UhDfj+5x4N
 oLlluYLhA5SMKjc7sdkCO6Ya7gg/cAB9o36G8q/ijm5MhfU3uaB//AFTNNWOoV/DAhb9
 lXUoZ9UNKkTA0jJcv9+Vlw8KKym9vWNyMTFj87AT3+nipeRp9qoOaktkewWsXgof9gg3
 4zMuRn1Ha8/R29ewg39ZjvFJrzV+XaljaKXYPcAtD6DN9Ggk2BQGeAuUerNEj9Ou0D7Y
 Rekg==
X-Gm-Message-State: AOJu0YwQECTue9YYlfg1ZohHE8TAwFmBxuf+uMsB7nVjWEdDr39VV+UI
 RekpnJbQ9p4cRh3iA8uxTK/ljc/vvliXggfkLsyOcVEIdgV2Xhtn3a/1b/K5UuP7Hf8t7z6Oj2U
 swVGWvd4=
X-Gm-Gg: Acq92OFr59dPK9nxlTv0Z7W2VdLDJz7hpsCO2n59QyVT/oo02tBa4QIaQoFBarglKm0
 b67taUGJ/hcEvtPktcPaBTqFbXqLz/Y9qMs+dIioswNfNaJeIftgVkomYKDuAlvO2bTfylfRm8L
 /a6C4JG9FT0zlHrRgAmkitPcuES33/YEGMZAF1fEnbm2cC3O591t7BPdx9XG78Dpv12Z3JcauIO
 3n24Jje6SO0fFgQ3esgZwZjbO6Hao9HzCZDSyg0zoJZim2+kiX7Iw6560jydKov4DeWwlMNgAQL
 6wdKxnqrGZAhRV9MjdBA2K8LMQj014xk2Z3k1+wQsrGXwcE7x9ZU/f8tFmVAqN3S3ZnOfOruzr7
 z+YwfRlbsK+Dmw2u+D5lL7RF12S4chgfeuY49UebxKfoPNrUdj2KPpSQBLBArL5gYTt7VRgFLlQ
 k/X6VrASfn+Xmn7Bkm+fMiGUR4bYbTti4/9Z93BR10MGnq66gPJUZKd7narDf55Wc274QzeCUO
X-Received: by 2002:a05:600c:4ed0:b0:490:778:4fec with SMTP id
 5b1f17b1804b1-49007785052mr263438165e9.33.1779305063652; 
 Wed, 20 May 2026 12:24:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d3f0d1sm13669065e9.5.2026.05.20.12.24.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:24:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/33] buildsys: Remove MIPS KVM
Date: Wed, 20 May 2026 21:23:11 +0200
Message-ID: <20260520192338.40036-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

We removed support for MIPS host. The KVM MIPS code
is now unreachable, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260511135312.38705-5-philmd@linaro.org>
---
 MAINTAINERS                    |    6 -
 docs/system/target-mips.rst    |    2 -
 meson.build                    |    2 -
 target/mips/kvm_mips.h         |   28 -
 hw/intc/mips_gic.c             |   11 +-
 hw/mips/loongson3_virt.c       |   66 +-
 hw/mips/malta.c                |    1 -
 hw/mips/mips_int.c             |    6 -
 target/mips/cpu.c              |    5 -
 target/mips/kvm.c              | 1283 --------------------------------
 target/mips/system/cp0_timer.c |   12 +-
 target/mips/system/physaddr.c  |    1 -
 target/mips/meson.build        |    6 +-
 13 files changed, 21 insertions(+), 1408 deletions(-)
 delete mode 100644 target/mips/kvm_mips.h
 delete mode 100644 target/mips/kvm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b75f3222f2f..bd7ea53f950 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -483,12 +483,6 @@ S: Supported
 F: target/arm/kvm.c
 F: tests/functional/aarch64/test_kvm.py
 
-MIPS KVM CPUs
-M: Huacai Chen <chenhuacai@kernel.org>
-S: Odd Fixes
-F: target/mips/kvm*
-F: target/mips/system/
-
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index 2a152e13380..aebad0c86e9 100644
--- a/docs/system/target-mips.rst
+++ b/docs/system/target-mips.rst
@@ -76,8 +76,6 @@ The Loongson-3 virtual platform emulation supports:
 
 -  GPEX and virtio as peripheral devices
 
--  Both KVM and TCG supported
-
 .. include:: cpu-models-mips.rst.inc
 
 .. _nanoMIPS-System-emulator:
diff --git a/meson.build b/meson.build
index fe5211b2122..eb074918193 100644
--- a/meson.build
+++ b/meson.build
@@ -282,8 +282,6 @@ elif cpu == 's390x'
   kvm_targets = ['s390x-softmmu']
 elif cpu == 'ppc64'
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
-elif cpu == 'mips64'
-  kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
 elif cpu == 'riscv64'
   kvm_targets = ['riscv64-softmmu']
 elif cpu == 'loongarch64'
diff --git a/target/mips/kvm_mips.h b/target/mips/kvm_mips.h
deleted file mode 100644
index c711269d0af..00000000000
--- a/target/mips/kvm_mips.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * KVM/MIPS: MIPS specific KVM APIs
- *
- * Copyright (C) 2012-2014 Imagination Technologies Ltd.
- * Authors: Sanjay Lal <sanjayl@kymasys.com>
- */
-
-#ifndef KVM_MIPS_H
-#define KVM_MIPS_H
-
-#include "cpu.h"
-
-/**
- * kvm_mips_reset_vcpu:
- * @cpu: MIPSCPU
- *
- * Called at reset time to set kernel registers to their initial values.
- */
-void kvm_mips_reset_vcpu(MIPSCPU *cpu);
-
-int kvm_mips_set_interrupt(MIPSCPU *cpu, int irq, int level);
-int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level);
-
-#endif /* KVM_MIPS_H */
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index ad9363a4c7d..23478df4b46 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -15,9 +15,7 @@
 #include "qapi/error.h"
 #include "hw/core/sysbus.h"
 #include "system/memory.h"
-#include "system/kvm.h"
 #include "system/reset.h"
-#include "kvm_mips.h"
 #include "hw/intc/mips_gic.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
@@ -45,14 +43,7 @@ static void mips_gic_set_vp_irq(MIPSGICState *gic, int vp, int pin)
         ored_level |= (gic->vps[vp].pend & GIC_VP_MASK_CMP_MSK) >>
                       GIC_VP_MASK_CMP_SHF;
     }
-    if (kvm_enabled())  {
-        kvm_mips_set_ipi_interrupt(env_archcpu(gic->vps[vp].env),
-                                   pin + GIC_CPU_PIN_OFFSET,
-                                   ored_level);
-    } else {
-        qemu_set_irq(gic->vps[vp].env->irq[pin + GIC_CPU_PIN_OFFSET],
-                     ored_level);
-    }
+    qemu_set_irq(gic->vps[vp].env->irq[pin + GIC_CPU_PIN_OFFSET], ored_level);
 }
 
 static void gic_update_pin_for_irq(MIPSGICState *gic, int n_IRQ)
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index c29cae86872..7de3fb09c17 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -45,7 +45,6 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/usb/usb.h"
 #include "net/net.h"
-#include "system/kvm.h"
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "system/runstate.h"
@@ -157,21 +156,6 @@ static const MemoryRegionOps loongson3_pm_ops = {
 
 static uint64_t get_cpu_freq_hz(const MIPSCPU *cpu)
 {
-#ifdef CONFIG_KVM
-    int ret;
-    uint64_t freq;
-    struct kvm_one_reg freq_reg = {
-        .id = KVM_REG_MIPS_COUNT_HZ,
-        .addr = (uintptr_t)(&freq)
-    };
-
-    if (kvm_enabled()) {
-        ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_ONE_REG, &freq_reg);
-        if (ret >= 0) {
-            return freq * 2;
-        }
-    }
-#endif
     return DEF_LOONGSON3_FREQ;
 }
 
@@ -511,23 +495,13 @@ static void mips_loongson3_virt_init(MachineState *machine)
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
     MemoryRegion *iocsr = g_new(MemoryRegion, 1);
 
-    /* TODO: TCG will support all CPU types */
-    if (!kvm_enabled()) {
-        if (!machine->cpu_type) {
-            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
-        }
-        if (!cpu_type_supports_isa(machine->cpu_type, INSN_LOONGSON3A)) {
-            error_report("Loongson-3/TCG needs a Loongson-3 series cpu");
-            exit(1);
-        }
-    } else {
-        if (!machine->cpu_type) {
-            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
-        }
-        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
-            error_report("Loongson-3/KVM needs cpu type Loongson-3A4000");
-            exit(1);
-        }
+    /* TODO: Support all CPU types */
+    if (!machine->cpu_type) {
+        machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
+    }
+    if (!cpu_type_supports_isa(machine->cpu_type, INSN_LOONGSON3A)) {
+        error_report("Loongson-3/TCG needs a Loongson-3 series cpu");
+        exit(1);
     }
 
     if (ram_size < 512 * MiB) {
@@ -545,16 +519,13 @@ static void mips_loongson3_virt_init(MachineState *machine)
 
     memory_region_init(iocsr, OBJECT(machine), "loongson3.iocsr", UINT32_MAX);
 
-    /* IPI controller is in kernel for KVM */
-    if (!kvm_enabled()) {
-        ipi = qdev_new(TYPE_LOONGSON_IPI);
-        qdev_prop_set_uint32(ipi, "num-cpu", machine->smp.cpus);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
-        memory_region_add_subregion(iocsr, SMP_IPI_MAILBOX,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
-        memory_region_add_subregion(iocsr, MAIL_SEND_ADDR,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
-    }
+    ipi = qdev_new(TYPE_LOONGSON_IPI);
+    qdev_prop_set_uint32(ipi, "num-cpu", machine->smp.cpus);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+    memory_region_add_subregion(iocsr, SMP_IPI_MAILBOX,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
+    memory_region_add_subregion(iocsr, MAIL_SEND_ADDR,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
 
     liointc = qdev_new("loongson.liointc");
     sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
@@ -575,6 +546,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         int node = i / LOONGSON3_CORE_PER_NODE;
         int core = i % LOONGSON3_CORE_PER_NODE;
         int ip;
+        hwaddr ipi_base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
 
         /* init CPUs */
         cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, false);
@@ -584,12 +556,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
         cpu_mips_clock_init(cpu);
         qemu_register_reset(i ? generic_cpu_reset : main_cpu_reset, cpu);
 
-        if (!kvm_enabled()) {
-            hwaddr base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
-            base += core * 0x100;
-            qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);
-            sysbus_mmio_map(SYS_BUS_DEVICE(ipi), i + 2, base);
-        }
+        qdev_connect_gpio_out(ipi, i, cpu->env.irq[6]);
+        sysbus_mmio_map(SYS_BUS_DEVICE(ipi), i + 2, ipi_base + core * 0x100);
 
         if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
             MemoryRegion *core_iocsr = g_new(MemoryRegion, 1);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 845b8d339e8..38c71f66f2e 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -55,7 +55,6 @@
 #include "system/system.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "system/kvm.h"
 #include "semihosting/semihost.h"
 #include "hw/mips/cps.h"
 #include "hw/core/qdev-clock.h"
diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index fa9c78e74de..26e7dd6d5f5 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -23,8 +23,6 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "hw/core/irq.h"
-#include "system/kvm.h"
-#include "kvm_mips.h"
 #include "target/mips/cpu.h"
 
 static void cpu_mips_irq_request(void *opaque, int irq, int level)
@@ -45,10 +43,6 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
         env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
     }
 
-    if (kvm_enabled() && (irq == 2 || irq == 3)) {
-        kvm_mips_set_interrupt(cpu, irq, level);
-    }
-
     if (env->CP0_Cause & CP0Ca_IP_mask) {
         cpu_interrupt(cs, CPU_INTERRUPT_HARD);
     } else {
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 88bb59d506b..99d43613828 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -25,9 +25,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "internal.h"
-#include "kvm_mips.h"
 #include "qemu/module.h"
-#include "system/kvm.h"
 #include "system/qtest.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
@@ -416,9 +414,6 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
         /* UHI interface can be used to obtain argc and argv */
         env->active_tc.gpr[4] = -1;
     }
-    if (kvm_enabled()) {
-        kvm_mips_reset_vcpu(cpu);
-    }
 #endif
 }
 
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
deleted file mode 100644
index a85e162409c..00000000000
--- a/target/mips/kvm.c
+++ /dev/null
@@ -1,1283 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * KVM/MIPS: MIPS specific KVM APIs
- *
- * Copyright (C) 2012-2014 Imagination Technologies Ltd.
- * Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
-
-#include "qemu/osdep.h"
-#include <sys/ioctl.h>
-
-#include <linux/kvm.h>
-
-#include "cpu.h"
-#include "internal.h"
-#include "qemu/error-report.h"
-#include "qemu/main-loop.h"
-#include "system/kvm.h"
-#include "system/kvm_int.h"
-#include "system/runstate.h"
-#include "kvm_mips.h"
-#include "hw/core/boards.h"
-#include "fpu_helper.h"
-
-#define DEBUG_KVM 0
-
-#define DPRINTF(fmt, ...) \
-    do { if (DEBUG_KVM) { fprintf(stderr, fmt, ## __VA_ARGS__); } } while (0)
-
-static int kvm_mips_fpu_cap;
-static int kvm_mips_msa_cap;
-
-const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
-    KVM_CAP_LAST_INFO
-};
-
-static void kvm_mips_update_state(void *opaque, bool running, RunState state);
-
-unsigned long kvm_arch_vcpu_id(CPUState *cs)
-{
-    return cs->cpu_index;
-}
-
-int kvm_arch_init(MachineState *ms, KVMState *s)
-{
-    /* MIPS has 128 signals */
-    kvm_set_sigmask_len(s, 16);
-
-    kvm_mips_fpu_cap = kvm_check_extension(s, KVM_CAP_MIPS_FPU);
-    kvm_mips_msa_cap = kvm_check_extension(s, KVM_CAP_MIPS_MSA);
-
-    DPRINTF("%s\n", __func__);
-    return 0;
-}
-
-int kvm_arch_irqchip_create(KVMState *s)
-{
-    return 0;
-}
-
-int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
-{
-    return 0;
-}
-
-int kvm_arch_init_vcpu(CPUState *cs)
-{
-    CPUMIPSState *env = cpu_env(cs);
-    int ret = 0;
-
-    qemu_add_vm_change_state_handler(kvm_mips_update_state, cs);
-
-    if (kvm_mips_fpu_cap && env->CP0_Config1 & (1 << CP0C1_FP)) {
-        ret = kvm_vcpu_enable_cap(cs, KVM_CAP_MIPS_FPU, 0, 0);
-        if (ret < 0) {
-            /* mark unsupported so it gets disabled on reset */
-            kvm_mips_fpu_cap = 0;
-            ret = 0;
-        }
-    }
-
-    if (kvm_mips_msa_cap && ase_msa_available(env)) {
-        ret = kvm_vcpu_enable_cap(cs, KVM_CAP_MIPS_MSA, 0, 0);
-        if (ret < 0) {
-            /* mark unsupported so it gets disabled on reset */
-            kvm_mips_msa_cap = 0;
-            ret = 0;
-        }
-    }
-
-    DPRINTF("%s\n", __func__);
-    return ret;
-}
-
-int kvm_arch_destroy_vcpu(CPUState *cs)
-{
-    return 0;
-}
-
-void kvm_mips_reset_vcpu(MIPSCPU *cpu)
-{
-    CPUMIPSState *env = &cpu->env;
-
-    if (!kvm_mips_fpu_cap && env->CP0_Config1 & (1 << CP0C1_FP)) {
-        warn_report("KVM does not support FPU, disabling");
-        env->CP0_Config1 &= ~(1 << CP0C1_FP);
-    }
-    if (!kvm_mips_msa_cap && ase_msa_available(env)) {
-        warn_report("KVM does not support MSA, disabling");
-        env->CP0_Config3 &= ~(1 << CP0C3_MSAP);
-    }
-
-    DPRINTF("%s\n", __func__);
-}
-
-int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
-{
-    DPRINTF("%s\n", __func__);
-    return 0;
-}
-
-int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
-{
-    DPRINTF("%s\n", __func__);
-    return 0;
-}
-
-static inline int cpu_mips_io_interrupts_pending(MIPSCPU *cpu)
-{
-    CPUMIPSState *env = &cpu->env;
-
-    return env->CP0_Cause & (0x1 << (2 + CP0Ca_IP));
-}
-
-
-void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
-{
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    int r;
-    struct kvm_mips_interrupt intr;
-
-    bql_lock();
-
-    if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
-            cpu_mips_io_interrupts_pending(cpu)) {
-        intr.cpu = -1;
-        intr.irq = 2;
-        r = kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &intr);
-        if (r < 0) {
-            error_report("%s: cpu %d: failed to inject IRQ %x",
-                         __func__, cs->cpu_index, intr.irq);
-        }
-    }
-
-    bql_unlock();
-}
-
-MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
-{
-    return MEMTXATTRS_UNSPECIFIED;
-}
-
-int kvm_arch_process_async_events(CPUState *cs)
-{
-    return cs->halted;
-}
-
-int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
-{
-    int ret;
-
-    DPRINTF("%s\n", __func__);
-    switch (run->exit_reason) {
-    default:
-        error_report("%s: unknown exit reason %d",
-                     __func__, run->exit_reason);
-        ret = -1;
-        break;
-    }
-
-    return ret;
-}
-
-bool kvm_arch_stop_on_emulation_error(CPUState *cs)
-{
-    DPRINTF("%s\n", __func__);
-    return true;
-}
-
-void kvm_arch_init_irq_routing(KVMState *s)
-{
-}
-
-int kvm_mips_set_interrupt(MIPSCPU *cpu, int irq, int level)
-{
-    CPUState *cs = CPU(cpu);
-    struct kvm_mips_interrupt intr;
-
-    assert(kvm_enabled());
-
-    intr.cpu = -1;
-
-    if (level) {
-        intr.irq = irq;
-    } else {
-        intr.irq = -irq;
-    }
-
-    kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &intr);
-
-    return 0;
-}
-
-int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level)
-{
-    CPUState *cs = current_cpu;
-    CPUState *dest_cs = CPU(cpu);
-    struct kvm_mips_interrupt intr;
-
-    assert(kvm_enabled());
-
-    intr.cpu = dest_cs->cpu_index;
-
-    if (level) {
-        intr.irq = irq;
-    } else {
-        intr.irq = -irq;
-    }
-
-    DPRINTF("%s: CPU %d, IRQ: %d\n", __func__, intr.cpu, intr.irq);
-
-    kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &intr);
-
-    return 0;
-}
-
-#define MIPS_CP0_32(_R, _S)                                     \
-    (KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U32 | (8 * (_R) + (_S)))
-
-#define MIPS_CP0_64(_R, _S)                                     \
-    (KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U64 | (8 * (_R) + (_S)))
-
-#define KVM_REG_MIPS_CP0_INDEX          MIPS_CP0_32(0, 0)
-#define KVM_REG_MIPS_CP0_RANDOM         MIPS_CP0_32(1, 0)
-#define KVM_REG_MIPS_CP0_CONTEXT        MIPS_CP0_64(4, 0)
-#define KVM_REG_MIPS_CP0_USERLOCAL      MIPS_CP0_64(4, 2)
-#define KVM_REG_MIPS_CP0_PAGEMASK       MIPS_CP0_32(5, 0)
-#define KVM_REG_MIPS_CP0_PAGEGRAIN      MIPS_CP0_32(5, 1)
-#define KVM_REG_MIPS_CP0_PWBASE         MIPS_CP0_64(5, 5)
-#define KVM_REG_MIPS_CP0_PWFIELD        MIPS_CP0_64(5, 6)
-#define KVM_REG_MIPS_CP0_PWSIZE         MIPS_CP0_64(5, 7)
-#define KVM_REG_MIPS_CP0_WIRED          MIPS_CP0_32(6, 0)
-#define KVM_REG_MIPS_CP0_PWCTL          MIPS_CP0_32(6, 6)
-#define KVM_REG_MIPS_CP0_HWRENA         MIPS_CP0_32(7, 0)
-#define KVM_REG_MIPS_CP0_BADVADDR       MIPS_CP0_64(8, 0)
-#define KVM_REG_MIPS_CP0_COUNT          MIPS_CP0_32(9, 0)
-#define KVM_REG_MIPS_CP0_ENTRYHI        MIPS_CP0_64(10, 0)
-#define KVM_REG_MIPS_CP0_COMPARE        MIPS_CP0_32(11, 0)
-#define KVM_REG_MIPS_CP0_STATUS         MIPS_CP0_32(12, 0)
-#define KVM_REG_MIPS_CP0_CAUSE          MIPS_CP0_32(13, 0)
-#define KVM_REG_MIPS_CP0_EPC            MIPS_CP0_64(14, 0)
-#define KVM_REG_MIPS_CP0_PRID           MIPS_CP0_32(15, 0)
-#define KVM_REG_MIPS_CP0_EBASE          MIPS_CP0_64(15, 1)
-#define KVM_REG_MIPS_CP0_CONFIG         MIPS_CP0_32(16, 0)
-#define KVM_REG_MIPS_CP0_CONFIG1        MIPS_CP0_32(16, 1)
-#define KVM_REG_MIPS_CP0_CONFIG2        MIPS_CP0_32(16, 2)
-#define KVM_REG_MIPS_CP0_CONFIG3        MIPS_CP0_32(16, 3)
-#define KVM_REG_MIPS_CP0_CONFIG4        MIPS_CP0_32(16, 4)
-#define KVM_REG_MIPS_CP0_CONFIG5        MIPS_CP0_32(16, 5)
-#define KVM_REG_MIPS_CP0_CONFIG6        MIPS_CP0_32(16, 6)
-#define KVM_REG_MIPS_CP0_XCONTEXT       MIPS_CP0_64(20, 0)
-#define KVM_REG_MIPS_CP0_ERROREPC       MIPS_CP0_64(30, 0)
-#define KVM_REG_MIPS_CP0_KSCRATCH1      MIPS_CP0_64(31, 2)
-#define KVM_REG_MIPS_CP0_KSCRATCH2      MIPS_CP0_64(31, 3)
-#define KVM_REG_MIPS_CP0_KSCRATCH3      MIPS_CP0_64(31, 4)
-#define KVM_REG_MIPS_CP0_KSCRATCH4      MIPS_CP0_64(31, 5)
-#define KVM_REG_MIPS_CP0_KSCRATCH5      MIPS_CP0_64(31, 6)
-#define KVM_REG_MIPS_CP0_KSCRATCH6      MIPS_CP0_64(31, 7)
-
-static inline int kvm_mips_put_one_reg(CPUState *cs, uint64_t reg_id,
-                                       int32_t *addr)
-{
-    struct kvm_one_reg cp0reg = {
-        .id = reg_id,
-        .addr = (uintptr_t)addr
-    };
-
-    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &cp0reg);
-}
-
-static inline int kvm_mips_put_one_ureg(CPUState *cs, uint64_t reg_id,
-                                        uint32_t *addr)
-{
-    struct kvm_one_reg cp0reg = {
-        .id = reg_id,
-        .addr = (uintptr_t)addr
-    };
-
-    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &cp0reg);
-}
-
-static inline int kvm_mips_put_one_ulreg(CPUState *cs, uint64_t reg_id,
-                                         target_ulong *addr)
-{
-    uint64_t val64 = *addr;
-    struct kvm_one_reg cp0reg = {
-        .id = reg_id,
-        .addr = (uintptr_t)&val64
-    };
-
-    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &cp0reg);
-}
-
-static inline int kvm_mips_put_one_reg64(CPUState *cs, uint64_t reg_id,
-                                         int64_t *addr)
-{
-    struct kvm_one_reg cp0reg = {
-        .id = reg_id,
-        .addr = (uintptr_t)addr
-    };
-
-    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &cp0reg);
-}
-
-static inline int kvm_mips_put_one_ureg64(CPUState *cs, uint64_t reg_id,
-                                          uint64_t *addr)
-{
-    struct kvm_one_reg cp0reg = {
-        .id = reg_id,
-        .addr = (uintptr_t)addr
-    };
-
-    return kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &cp0reg);
-}
-
-static inline int kvm_mips_get_one_reg(CPUState *cs, uint64_t reg_id,
-                                       int32_t *addr)
-{
-    struct kvm_one_reg cp0reg = {
-        .id = reg_id,
-        .addr = (uintptr_t)addr
-    };
-
-    return kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &cp0reg);
-}
-
-static inline int kvm_mips_get_one_ureg(CPUState *cs, uint64_t reg_id,
-                                        uint32_t *addr)
-{
-    struct kvm_one_reg cp0reg = {
-        .id = reg_id,
-        .addr = (uintptr_t)addr
-    };
-
-    return kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &cp0reg);
-}
-
-static inline int kvm_mips_get_one_ulreg(CPUState *cs, uint64_t reg_id,
-                                         target_ulong *addr)
-{
-    int ret;
-    uint64_t val64 = 0;
-    struct kvm_one_reg cp0reg = {
-        .id = reg_id,
-        .addr = (uintptr_t)&val64
-    };
-
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &cp0reg);
-    if (ret >= 0) {
-        *addr = val64;
-    }
-    return ret;
-}
-
-static inline int kvm_mips_get_one_reg64(CPUState *cs, uint64_t reg_id,
-                                         int64_t *addr)
-{
-    struct kvm_one_reg cp0reg = {
-        .id = reg_id,
-        .addr = (uintptr_t)addr
-    };
-
-    return kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &cp0reg);
-}
-
-static inline int kvm_mips_get_one_ureg64(CPUState *cs, uint64_t reg_id,
-                                          uint64_t *addr)
-{
-    struct kvm_one_reg cp0reg = {
-        .id = reg_id,
-        .addr = (uintptr_t)addr
-    };
-
-    return kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &cp0reg);
-}
-
-#define KVM_REG_MIPS_CP0_CONFIG_MASK    (1U << CP0C0_M)
-#define KVM_REG_MIPS_CP0_CONFIG1_MASK   ((1U << CP0C1_M) | \
-                                         (1U << CP0C1_FP))
-#define KVM_REG_MIPS_CP0_CONFIG2_MASK   (1U << CP0C2_M)
-#define KVM_REG_MIPS_CP0_CONFIG3_MASK   ((1U << CP0C3_M) | \
-                                         (1U << CP0C3_MSAP))
-#define KVM_REG_MIPS_CP0_CONFIG4_MASK   (1U << CP0C4_M)
-#define KVM_REG_MIPS_CP0_CONFIG5_MASK   ((1U << CP0C5_MSAEn) | \
-                                         (1U << CP0C5_UFE) | \
-                                         (1U << CP0C5_FRE) | \
-                                         (1U << CP0C5_UFR))
-#define KVM_REG_MIPS_CP0_CONFIG6_MASK   ((1U << CP0C6_BPPASS) | \
-                                         (0x3fU << CP0C6_KPOS) | \
-                                         (1U << CP0C6_KE) | \
-                                         (1U << CP0C6_VTLBONLY) | \
-                                         (1U << CP0C6_LASX) | \
-                                         (1U << CP0C6_SSEN) | \
-                                         (1U << CP0C6_DISDRTIME) | \
-                                         (1U << CP0C6_PIXNUEN) | \
-                                         (1U << CP0C6_SCRAND) | \
-                                         (1U << CP0C6_LLEXCEN) | \
-                                         (1U << CP0C6_DISVC) | \
-                                         (1U << CP0C6_VCLRU) | \
-                                         (1U << CP0C6_DCLRU) | \
-                                         (1U << CP0C6_PIXUEN) | \
-                                         (1U << CP0C6_DISBLKLYEN) | \
-                                         (1U << CP0C6_UMEMUALEN) | \
-                                         (1U << CP0C6_SFBEN) | \
-                                         (1U << CP0C6_FLTINT) | \
-                                         (1U << CP0C6_VLTINT) | \
-                                         (1U << CP0C6_DISBTB) | \
-                                         (3U << CP0C6_STPREFCTL) | \
-                                         (1U << CP0C6_INSTPREF) | \
-                                         (1U << CP0C6_DATAPREF))
-
-static inline int kvm_mips_change_one_reg(CPUState *cs, uint64_t reg_id,
-                                          int32_t *addr, int32_t mask)
-{
-    int err;
-    int32_t tmp, change;
-
-    err = kvm_mips_get_one_reg(cs, reg_id, &tmp);
-    if (err < 0) {
-        return err;
-    }
-
-    /* only change bits in mask */
-    change = (*addr ^ tmp) & mask;
-    if (!change) {
-        return 0;
-    }
-
-    tmp = tmp ^ change;
-    return kvm_mips_put_one_reg(cs, reg_id, &tmp);
-}
-
-/*
- * We freeze the KVM timer when either the VM clock is stopped or the state is
- * saved (the state is dirty).
- */
-
-/*
- * Save the state of the KVM timer when VM clock is stopped or state is synced
- * to QEMU.
- */
-static int kvm_mips_save_count(CPUState *cs)
-{
-    CPUMIPSState *env = cpu_env(cs);
-    uint64_t count_ctl;
-    int err, ret = 0;
-
-    /* freeze KVM timer */
-    err = kvm_mips_get_one_ureg64(cs, KVM_REG_MIPS_COUNT_CTL, &count_ctl);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get COUNT_CTL (%d)\n", __func__, err);
-        ret = err;
-    } else if (!(count_ctl & KVM_REG_MIPS_COUNT_CTL_DC)) {
-        count_ctl |= KVM_REG_MIPS_COUNT_CTL_DC;
-        err = kvm_mips_put_one_ureg64(cs, KVM_REG_MIPS_COUNT_CTL, &count_ctl);
-        if (err < 0) {
-            DPRINTF("%s: Failed to set COUNT_CTL.DC=1 (%d)\n", __func__, err);
-            ret = err;
-        }
-    }
-
-    /* read CP0_Cause */
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CAUSE, &env->CP0_Cause);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_CAUSE (%d)\n", __func__, err);
-        ret = err;
-    }
-
-    /* read CP0_Count */
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_COUNT, &env->CP0_Count);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_COUNT (%d)\n", __func__, err);
-        ret = err;
-    }
-
-    return ret;
-}
-
-/*
- * Restore the state of the KVM timer when VM clock is restarted or state is
- * synced to KVM.
- */
-static int kvm_mips_restore_count(CPUState *cs)
-{
-    CPUMIPSState *env = cpu_env(cs);
-    uint64_t count_ctl;
-    int err_dc, err, ret = 0;
-
-    /* check the timer is frozen */
-    err_dc = kvm_mips_get_one_ureg64(cs, KVM_REG_MIPS_COUNT_CTL, &count_ctl);
-    if (err_dc < 0) {
-        DPRINTF("%s: Failed to get COUNT_CTL (%d)\n", __func__, err_dc);
-        ret = err_dc;
-    } else if (!(count_ctl & KVM_REG_MIPS_COUNT_CTL_DC)) {
-        /* freeze timer (sets COUNT_RESUME for us) */
-        count_ctl |= KVM_REG_MIPS_COUNT_CTL_DC;
-        err = kvm_mips_put_one_ureg64(cs, KVM_REG_MIPS_COUNT_CTL, &count_ctl);
-        if (err < 0) {
-            DPRINTF("%s: Failed to set COUNT_CTL.DC=1 (%d)\n", __func__, err);
-            ret = err;
-        }
-    }
-
-    /* load CP0_Cause */
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_CAUSE, &env->CP0_Cause);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_CAUSE (%d)\n", __func__, err);
-        ret = err;
-    }
-
-    /* load CP0_Count */
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_COUNT, &env->CP0_Count);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_COUNT (%d)\n", __func__, err);
-        ret = err;
-    }
-
-    /* resume KVM timer */
-    if (err_dc >= 0) {
-        count_ctl &= ~KVM_REG_MIPS_COUNT_CTL_DC;
-        err = kvm_mips_put_one_ureg64(cs, KVM_REG_MIPS_COUNT_CTL, &count_ctl);
-        if (err < 0) {
-            DPRINTF("%s: Failed to set COUNT_CTL.DC=0 (%d)\n", __func__, err);
-            ret = err;
-        }
-    }
-
-    return ret;
-}
-
-/*
- * Handle the VM clock being started or stopped
- */
-static void kvm_mips_update_state(void *opaque, bool running, RunState state)
-{
-    CPUState *cs = opaque;
-    int ret;
-    uint64_t count_resume;
-
-    /*
-     * If state is already dirty (synced to QEMU) then the KVM timer state is
-     * already saved and can be restored when it is synced back to KVM.
-     */
-    if (!running) {
-        if (!cs->vcpu_dirty) {
-            ret = kvm_mips_save_count(cs);
-            if (ret < 0) {
-                warn_report("Failed saving count");
-            }
-        }
-    } else {
-        /* Set clock restore time to now */
-        count_resume = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-        ret = kvm_mips_put_one_ureg64(cs, KVM_REG_MIPS_COUNT_RESUME,
-                                      &count_resume);
-        if (ret < 0) {
-            warn_report("Failed setting COUNT_RESUME");
-            return;
-        }
-
-        if (!cs->vcpu_dirty) {
-            ret = kvm_mips_restore_count(cs);
-            if (ret < 0) {
-                warn_report("Failed restoring count");
-            }
-        }
-    }
-}
-
-static int kvm_mips_put_fpu_registers(CPUState *cs, KvmPutState level)
-{
-    CPUMIPSState *env = cpu_env(cs);
-    int err, ret = 0;
-    unsigned int i;
-
-    /* Only put FPU state if we're emulating a CPU with an FPU */
-    if (env->CP0_Config1 & (1 << CP0C1_FP)) {
-        /* FPU Control Registers */
-        if (level == KVM_PUT_FULL_STATE) {
-            err = kvm_mips_put_one_ureg(cs, KVM_REG_MIPS_FCR_IR,
-                                        &env->active_fpu.fcr0);
-            if (err < 0) {
-                DPRINTF("%s: Failed to put FCR_IR (%d)\n", __func__, err);
-                ret = err;
-            }
-        }
-        err = kvm_mips_put_one_ureg(cs, KVM_REG_MIPS_FCR_CSR,
-                                    &env->active_fpu.fcr31);
-        if (err < 0) {
-            DPRINTF("%s: Failed to put FCR_CSR (%d)\n", __func__, err);
-            ret = err;
-        }
-
-        /*
-         * FPU register state is a subset of MSA vector state, so don't put FPU
-         * registers if we're emulating a CPU with MSA.
-         */
-        if (!ase_msa_available(env)) {
-            /* Floating point registers */
-            for (i = 0; i < 32; ++i) {
-                if (env->CP0_Status & (1 << CP0St_FR)) {
-                    err = kvm_mips_put_one_ureg64(cs, KVM_REG_MIPS_FPR_64(i),
-                                                  &env->active_fpu.fpr[i].d);
-                } else {
-                    err = kvm_mips_get_one_ureg(cs, KVM_REG_MIPS_FPR_32(i),
-                                    &env->active_fpu.fpr[i].w[FP_ENDIAN_IDX]);
-                }
-                if (err < 0) {
-                    DPRINTF("%s: Failed to put FPR%u (%d)\n", __func__, i, err);
-                    ret = err;
-                }
-            }
-        }
-    }
-
-    /* Only put MSA state if we're emulating a CPU with MSA */
-    if (ase_msa_available(env)) {
-        /* MSA Control Registers */
-        if (level == KVM_PUT_FULL_STATE) {
-            err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_MSA_IR,
-                                       &env->msair);
-            if (err < 0) {
-                DPRINTF("%s: Failed to put MSA_IR (%d)\n", __func__, err);
-                ret = err;
-            }
-        }
-        err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_MSA_CSR,
-                                   &env->active_tc.msacsr);
-        if (err < 0) {
-            DPRINTF("%s: Failed to put MSA_CSR (%d)\n", __func__, err);
-            ret = err;
-        }
-
-        /* Vector registers (includes FP registers) */
-        for (i = 0; i < 32; ++i) {
-            /* Big endian MSA not supported by QEMU yet anyway */
-            err = kvm_mips_put_one_reg64(cs, KVM_REG_MIPS_VEC_128(i),
-                                         env->active_fpu.fpr[i].wr.d);
-            if (err < 0) {
-                DPRINTF("%s: Failed to put VEC%u (%d)\n", __func__, i, err);
-                ret = err;
-            }
-        }
-    }
-
-    return ret;
-}
-
-static int kvm_mips_get_fpu_registers(CPUState *cs)
-{
-    CPUMIPSState *env = cpu_env(cs);
-    int err, ret = 0;
-    unsigned int i;
-
-    /* Only get FPU state if we're emulating a CPU with an FPU */
-    if (env->CP0_Config1 & (1 << CP0C1_FP)) {
-        /* FPU Control Registers */
-        err = kvm_mips_get_one_ureg(cs, KVM_REG_MIPS_FCR_IR,
-                                    &env->active_fpu.fcr0);
-        if (err < 0) {
-            DPRINTF("%s: Failed to get FCR_IR (%d)\n", __func__, err);
-            ret = err;
-        }
-        err = kvm_mips_get_one_ureg(cs, KVM_REG_MIPS_FCR_CSR,
-                                    &env->active_fpu.fcr31);
-        if (err < 0) {
-            DPRINTF("%s: Failed to get FCR_CSR (%d)\n", __func__, err);
-            ret = err;
-        } else {
-            restore_fp_status(env);
-        }
-
-        /*
-         * FPU register state is a subset of MSA vector state, so don't save FPU
-         * registers if we're emulating a CPU with MSA.
-         */
-        if (!ase_msa_available(env)) {
-            /* Floating point registers */
-            for (i = 0; i < 32; ++i) {
-                if (env->CP0_Status & (1 << CP0St_FR)) {
-                    err = kvm_mips_get_one_ureg64(cs, KVM_REG_MIPS_FPR_64(i),
-                                                  &env->active_fpu.fpr[i].d);
-                } else {
-                    err = kvm_mips_get_one_ureg(cs, KVM_REG_MIPS_FPR_32(i),
-                                    &env->active_fpu.fpr[i].w[FP_ENDIAN_IDX]);
-                }
-                if (err < 0) {
-                    DPRINTF("%s: Failed to get FPR%u (%d)\n", __func__, i, err);
-                    ret = err;
-                }
-            }
-        }
-    }
-
-    /* Only get MSA state if we're emulating a CPU with MSA */
-    if (ase_msa_available(env)) {
-        /* MSA Control Registers */
-        err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_MSA_IR,
-                                   &env->msair);
-        if (err < 0) {
-            DPRINTF("%s: Failed to get MSA_IR (%d)\n", __func__, err);
-            ret = err;
-        }
-        err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_MSA_CSR,
-                                   &env->active_tc.msacsr);
-        if (err < 0) {
-            DPRINTF("%s: Failed to get MSA_CSR (%d)\n", __func__, err);
-            ret = err;
-        } else {
-            restore_msa_fp_status(env);
-        }
-
-        /* Vector registers (includes FP registers) */
-        for (i = 0; i < 32; ++i) {
-            /* Big endian MSA not supported by QEMU yet anyway */
-            err = kvm_mips_get_one_reg64(cs, KVM_REG_MIPS_VEC_128(i),
-                                         env->active_fpu.fpr[i].wr.d);
-            if (err < 0) {
-                DPRINTF("%s: Failed to get VEC%u (%d)\n", __func__, i, err);
-                ret = err;
-            }
-        }
-    }
-
-    return ret;
-}
-
-
-static int kvm_mips_put_cp0_registers(CPUState *cs, KvmPutState level)
-{
-    CPUMIPSState *env = cpu_env(cs);
-    int err, ret = 0;
-
-    (void)level;
-
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_INDEX, &env->CP0_Index);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_INDEX (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_RANDOM, &env->CP0_Random);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_RANDOM (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_CONTEXT,
-                                 &env->CP0_Context);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_CONTEXT (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_USERLOCAL,
-                                 &env->active_tc.CP0_UserLocal);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_USERLOCAL (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_PAGEMASK,
-                               &env->CP0_PageMask);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_PAGEMASK (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_PAGEGRAIN,
-                               &env->CP0_PageGrain);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_PAGEGRAIN (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_PWBASE,
-                               &env->CP0_PWBase);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_PWBASE (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_PWFIELD,
-                               &env->CP0_PWField);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_PWField (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_PWSIZE,
-                               &env->CP0_PWSize);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_PWSIZE (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_WIRED, &env->CP0_Wired);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_WIRED (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_PWCTL, &env->CP0_PWCtl);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_PWCTL (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_HWRENA, &env->CP0_HWREna);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_HWRENA (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_BADVADDR,
-                                 &env->CP0_BadVAddr);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_BADVADDR (%d)\n", __func__, err);
-        ret = err;
-    }
-
-    /* If VM clock stopped then state will be restored when it is restarted */
-    if (runstate_is_running()) {
-        err = kvm_mips_restore_count(cs);
-        if (err < 0) {
-            ret = err;
-        }
-    }
-
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_ENTRYHI,
-                                 &env->CP0_EntryHi);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_ENTRYHI (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_COMPARE,
-                               &env->CP0_Compare);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_COMPARE (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_STATUS, &env->CP0_Status);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_STATUS (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_EPC, &env->CP0_EPC);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_EPC (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_PRID, &env->CP0_PRid);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_PRID (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_EBASE, &env->CP0_EBase);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_EBASE (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_change_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG,
-                                  &env->CP0_Config0,
-                                  KVM_REG_MIPS_CP0_CONFIG_MASK);
-    if (err < 0) {
-        DPRINTF("%s: Failed to change CP0_CONFIG (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_change_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG1,
-                                  &env->CP0_Config1,
-                                  KVM_REG_MIPS_CP0_CONFIG1_MASK);
-    if (err < 0) {
-        DPRINTF("%s: Failed to change CP0_CONFIG1 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_change_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG2,
-                                  &env->CP0_Config2,
-                                  KVM_REG_MIPS_CP0_CONFIG2_MASK);
-    if (err < 0) {
-        DPRINTF("%s: Failed to change CP0_CONFIG2 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_change_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG3,
-                                  &env->CP0_Config3,
-                                  KVM_REG_MIPS_CP0_CONFIG3_MASK);
-    if (err < 0) {
-        DPRINTF("%s: Failed to change CP0_CONFIG3 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_change_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG4,
-                                  &env->CP0_Config4,
-                                  KVM_REG_MIPS_CP0_CONFIG4_MASK);
-    if (err < 0) {
-        DPRINTF("%s: Failed to change CP0_CONFIG4 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_change_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG5,
-                                  &env->CP0_Config5,
-                                  KVM_REG_MIPS_CP0_CONFIG5_MASK);
-    if (err < 0) {
-        DPRINTF("%s: Failed to change CP0_CONFIG5 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_change_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG6,
-                                  &env->CP0_Config6,
-                                  KVM_REG_MIPS_CP0_CONFIG6_MASK);
-    if (err < 0) {
-        DPRINTF("%s: Failed to change CP0_CONFIG6 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_XCONTEXT,
-                                 &env->CP0_XContext);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_XCONTEXT (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_ERROREPC,
-                                 &env->CP0_ErrorEPC);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_ERROREPC (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH1,
-                                 &env->CP0_KScratch[0]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_KSCRATCH1 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH2,
-                                 &env->CP0_KScratch[1]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_KSCRATCH2 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH3,
-                                 &env->CP0_KScratch[2]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_KSCRATCH3 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH4,
-                                 &env->CP0_KScratch[3]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_KSCRATCH4 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH5,
-                                 &env->CP0_KScratch[4]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_KSCRATCH5 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH6,
-                                 &env->CP0_KScratch[5]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to put CP0_KSCRATCH6 (%d)\n", __func__, err);
-        ret = err;
-    }
-
-    return ret;
-}
-
-static int kvm_mips_get_cp0_registers(CPUState *cs)
-{
-    CPUMIPSState *env = cpu_env(cs);
-    int err, ret = 0;
-
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_INDEX, &env->CP0_Index);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_INDEX (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_RANDOM, &env->CP0_Random);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_RANDOM (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_CONTEXT,
-                                 &env->CP0_Context);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_CONTEXT (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_USERLOCAL,
-                                 &env->active_tc.CP0_UserLocal);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_USERLOCAL (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_PAGEMASK,
-                               &env->CP0_PageMask);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_PAGEMASK (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_PAGEGRAIN,
-                               &env->CP0_PageGrain);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_PAGEGRAIN (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_PWBASE,
-                               &env->CP0_PWBase);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_PWBASE (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_PWFIELD,
-                               &env->CP0_PWField);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_PWFIELD (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_PWSIZE,
-                               &env->CP0_PWSize);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_PWSIZE (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_WIRED, &env->CP0_Wired);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_WIRED (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_PWCTL, &env->CP0_PWCtl);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_PWCtl (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_HWRENA, &env->CP0_HWREna);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_HWRENA (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_BADVADDR,
-                                 &env->CP0_BadVAddr);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_BADVADDR (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_ENTRYHI,
-                                 &env->CP0_EntryHi);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_ENTRYHI (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_COMPARE,
-                               &env->CP0_Compare);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_COMPARE (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_STATUS, &env->CP0_Status);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_STATUS (%d)\n", __func__, err);
-        ret = err;
-    }
-
-    /* If VM clock stopped then state was already saved when it was stopped */
-    if (runstate_is_running()) {
-        err = kvm_mips_save_count(cs);
-        if (err < 0) {
-            ret = err;
-        }
-    }
-
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_EPC, &env->CP0_EPC);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_EPC (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_PRID, &env->CP0_PRid);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_PRID (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_EBASE, &env->CP0_EBase);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_EBASE (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG, &env->CP0_Config0);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_CONFIG (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG1, &env->CP0_Config1);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_CONFIG1 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG2, &env->CP0_Config2);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_CONFIG2 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG3, &env->CP0_Config3);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_CONFIG3 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG4, &env->CP0_Config4);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_CONFIG4 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG5, &env->CP0_Config5);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_CONFIG5 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG6, &env->CP0_Config6);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_CONFIG6 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_XCONTEXT,
-                                 &env->CP0_XContext);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_XCONTEXT (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_ERROREPC,
-                                 &env->CP0_ErrorEPC);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_ERROREPC (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH1,
-                                 &env->CP0_KScratch[0]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_KSCRATCH1 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH2,
-                                 &env->CP0_KScratch[1]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_KSCRATCH2 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH3,
-                                 &env->CP0_KScratch[2]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_KSCRATCH3 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH4,
-                                 &env->CP0_KScratch[3]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_KSCRATCH4 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH5,
-                                 &env->CP0_KScratch[4]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_KSCRATCH5 (%d)\n", __func__, err);
-        ret = err;
-    }
-    err = kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH6,
-                                 &env->CP0_KScratch[5]);
-    if (err < 0) {
-        DPRINTF("%s: Failed to get CP0_KSCRATCH6 (%d)\n", __func__, err);
-        ret = err;
-    }
-
-    return ret;
-}
-
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
-{
-    CPUMIPSState *env = cpu_env(cs);
-    struct kvm_regs regs;
-    int ret;
-    int i;
-
-    /* Set the registers based on QEMU's view of things */
-    for (i = 0; i < 32; i++) {
-        regs.gpr[i] = (int64_t)(target_long)env->active_tc.gpr[i];
-    }
-
-    regs.hi = (int64_t)(target_long)env->active_tc.HI[0];
-    regs.lo = (int64_t)(target_long)env->active_tc.LO[0];
-    regs.pc = (int64_t)(target_long)env->active_tc.PC;
-
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_REGS, &regs);
-
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret = kvm_mips_put_cp0_registers(cs, level);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret = kvm_mips_put_fpu_registers(cs, level);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return ret;
-}
-
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
-{
-    CPUMIPSState *env = cpu_env(cs);
-    int ret = 0;
-    struct kvm_regs regs;
-    int i;
-
-    /* Get the current register set as KVM seems it */
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_REGS, &regs);
-
-    if (ret < 0) {
-        return ret;
-    }
-
-    for (i = 0; i < 32; i++) {
-        env->active_tc.gpr[i] = regs.gpr[i];
-    }
-
-    env->active_tc.HI[0] = regs.hi;
-    env->active_tc.LO[0] = regs.lo;
-    env->active_tc.PC = regs.pc;
-
-    kvm_mips_get_cp0_registers(cs);
-    kvm_mips_get_fpu_registers(cs);
-
-    return ret;
-}
-
-int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
-                             uint64_t address, uint32_t data, PCIDevice *dev)
-{
-    return 0;
-}
-
-int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
-                                int vector, PCIDevice *dev)
-{
-    return 0;
-}
-
-int kvm_arch_release_virq_post(int virq)
-{
-    return 0;
-}
-
-int kvm_arch_msi_data_to_gsi(uint32_t data)
-{
-    abort();
-}
-
-int kvm_arch_get_default_type(MachineState *machine)
-{
-#if defined(KVM_CAP_MIPS_VZ)
-    int r;
-    KVMState *s = KVM_STATE(machine->accelerator);
-
-    r = kvm_check_extension(s, KVM_CAP_MIPS_VZ);
-    if (r > 0) {
-        return KVM_VM_MIPS_VZ;
-    }
-#endif
-
-    error_report("KVM_VM_MIPS_VZ type is not available");
-    return -1;
-}
-
-void kvm_arch_accel_class_init(ObjectClass *oc)
-{
-}
diff --git a/target/mips/system/cp0_timer.c b/target/mips/system/cp0_timer.c
index 634c2a66bbd..6aed5d3af24 100644
--- a/target/mips/system/cp0_timer.c
+++ b/target/mips/system/cp0_timer.c
@@ -23,7 +23,6 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "qemu/timer.h"
-#include "system/kvm.h"
 #include "internal.h"
 
 /* MIPS R4K timer */
@@ -84,8 +83,7 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
 {
     /*
      * This gets called from cpu_state_reset(), potentially before timer init.
-     * So env->timer may be NULL, which is also the case with KVM enabled so
-     * treat timer as disabled in that case.
+     * So env->timer may be NULL, so treat timer as disabled in that case.
      */
     MIPSCPU *cpu = env_archcpu(env);
     if (env->CP0_Cause & (1 << CP0Ca_DC) || !env->timer) {
@@ -141,11 +139,5 @@ void cpu_mips_clock_init(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
 
-    /*
-     * If we're in KVM mode, don't create the periodic timer, that is handled in
-     * kernel.
-     */
-    if (!kvm_enabled()) {
-        env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &mips_timer_cb, env);
-    }
+    env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &mips_timer_cb, env);
 }
diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index fbbbcf6e006..746dbf8aa4e 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -126,7 +126,6 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
     int KX = (env->CP0_Status & (1 << CP0St_KX)) != 0;
 #endif
     int ret = TLBRET_MATCH;
-    /* effective address (modified for KVM T&E kernel segments) */
     target_ulong address = real_address;
 
     if (address <= USEG_LIMIT) {
diff --git a/target/mips/meson.build b/target/mips/meson.build
index abf0ce3e8b9..5acb3a2dcf5 100644
--- a/target/mips/meson.build
+++ b/target/mips/meson.build
@@ -13,11 +13,7 @@ if have_system
   subdir('system')
 endif
 
-if 'CONFIG_TCG' in config_all_accel
-  subdir('tcg')
-endif
-
-mips_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
+subdir('tcg')
 
 target_arch += {'mips': mips_ss}
 target_system_arch += {'mips': mips_system_ss}
-- 
2.53.0


