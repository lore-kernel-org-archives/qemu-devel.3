Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1E1606A322
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=F7sCJj0D;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=1FX6YbHj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX13-0008BW-IY; Thu, 29 Oct 2026 16:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0z-0008AQ-Qs
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:25 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0w-0007TJ-Fa
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=PjI68QU
 VNnnGvjf1FDhxVQPugb1Cjkrp1HZGkdcwMSr6OsiQAgABVgcUHqYnrX/UIvn6CMVtX8haU
 kisSfxkt8HDJtVY5WpAYtH1/1PE2ensWS1JuHj+nYNgGQAUu85jt9lkm2TRCUPdKAye++0
 Ta1QilRbkL+78rpwviSuEaoxmcfnY7ay3keGC5EOkY0mmFWgzh0SzYGuzox7WZO1FCVj6G
 B8VWF/Oi10kNMHZGoQIPLWh4tfPPgXQ9ZvMv0TV9KDb1Z6uEDvG6m9/5NBC0W5wH6pl8Qo
 ml+WhQ/aRtl2zWoG2Uw2LNVbigVuym2ydREYaX51WsY/Laghq5N186g==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=p
 k+vgKApg2D0X70xtAGuxiKhSbL9gNLVQCeVqq1D8Xs=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=wQnqIgB/NSB3oSU41k1ghqmrvlldSqgBDuy4YIcZB7tC8Q7LIIa8bz6uSMyk/5zUW7wv
 /vHm0gfJurVK69YK0s56f8DvXp72j01w0Zw1ZVxKRn9b8HdII/yCElMWAY0xoERPA348jE
 UrOAHEpV5yiGS98lbkuT/nHYj3mrgbXrDA1rC18UYqEWwll6FKGP+knnISRygdeseJQZ6q
 FpnPQjm3eFb8jLnOgeDao/uJBv9DM+CBGpQuaTLQQx2jUhK+xcOVNeQLw7VQE8MY7GP5Ao
 QvXlBlgCyP3HKm7Ch/W1MBuUZjU631blVN/+MYnPiJSIULIOntWwbJMMN4LTMTdg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=F7sCJj0D; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=1FX6YbHj;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=pk+vgKAp
 g2D0X70xtAGuxiKhSbL9gNLVQCeVqq1D8Xs=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=F7sCJj0DVkz6KAuYwVOn/ZnvrS7sLUoJDcM
 /1rGWPtf2a2nc3I97GjuJy/TVHU/GMpDpFH0A/h0EPoPCBrCJ1MQIf8a5bnaXdoPrAodw/
 wMOQHovsxGMTWE1thtbvnM0QDh8FCNYVz6t69ipaid08lS/Gys+vc8vqVk3yRdBsTbw/XY
 XwrsolcG88g6cYPGfOwY3VaSXvJB8ts6Grro8C/hci7i1RoxGIHs8wbJgDe/tDfDP6XrIk
 okItpj4tdSxFLOELz14DfQ/0qpfoj5ws5iUmh4kpymo1Z8yV4QET8g0EFG1wRHbylB4dx1
 OR5efknbN8LraBpxxmNo4eEKjfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=pk+vgKApg2D0X70xtAGuxiKhSbL9gNLVQCeVqq1D8Xs=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=1FX6YbHjpcg1/mOzBf
 /ufRfNfSrRiPJ66VMFKP9FkRn6pxE84Ig+3IcrGT5h3f6Z++/LFGsBIvaKEK4frrElAQ==
Received: by mx2.catap.net (OpenSMTPD) id d0924d84;
 Thu, 29 Oct 2026 21:46:17 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 5ca863b2;
 Thu, 29 Oct 2026 21:46:13 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 12/26] hw/mips: add Octeon CIU3 CPU control
Date: Thu, 29 Oct 2026 21:43:57 +0100
Message-ID: <20261029204609.38989-13-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029204609.38989-1-kirill@korins.ky>
References: <20261029204609.38989-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Model the CIU3 CPU reset, NMI and fuse registers. Park secondary
cores after reset and release them through the CIU3 reset register or
NMI path, while leaving interrupt source routing for a separate change.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/octeon.c          | 247 +++++++++++++++++++++++++++++++++++++-
 hw/mips/octeon_internal.h |   6 +
 2 files changed, 252 insertions(+), 1 deletion(-)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 4fc5a71a90..eeca7ca67e 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -20,9 +20,12 @@
 #include "hw/mips/mips.h"
 #include "system/blockdev.h"
 #include "system/address-spaces.h"
+#include "system/cpus.h"
 #include "system/memory.h"
 #include "system/reset.h"
+#include "exec/cpu-interrupt.h"
 #include "qemu/error-report.h"
+#include "qemu/atomic.h"
 #include "hw/mips/octeon_internal.h"
 #include "target/mips/cpu.h"
 
@@ -35,6 +38,10 @@ OBJECT_DECLARE_TYPE(OcteonPeripheralState, OcteonPeripheralClass,
 
 #define TYPE_OCTEON_RST "octeon-rst"
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonRstState, OCTEON_RST)
+#define TYPE_OCTEON_INTC "octeon-intc"
+OBJECT_DECLARE_SIMPLE_TYPE(OcteonIntcState, OCTEON_INTC)
+
+#define OCTEON_CSR_64BIT_SIZE       8
 
 /*
  * Clock defaults follow a Ubiquiti E1000 EBB7304 U-Boot banner.
@@ -61,6 +68,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonRstState, OCTEON_RST)
 #define OCTEON_DR1_BASE             0x020000000ULL
 #define OCTEON_DR1_SIZE             (OCTEON_MAX_PHY_MEM_SIZE - OCTEON_DR0_SIZE)
 
+#define OCTEON_CIU3_BASE            0x1010000000000ULL
+#define OCTEON_CIU3_SIZE            0xb0000000ULL
+#define OCTEON_CIU3_PP_RST          0x100
+#define OCTEON_CIU3_PP_RST_PENDING  0x110
+#define OCTEON_CIU3_NMI             0x160
+#define OCTEON_CIU3_FUSE            0x1a0
+
 /*
  * QEMU-only backing for per-core CVMSEG. Keep it outside guest DRAM;
  * the guest sees the virtual CVMSEG window, not this physical address.
@@ -108,6 +122,59 @@ struct OcteonRstState {
     uint64_t rst_pp_power;
 };
 
+struct OcteonIntcState {
+    OcteonPeripheralState parent_obj;
+    MemoryRegion ciu3;
+    uint64_t ciu3_pp_rst;
+};
+
+uint64_t octeon_read64(uint64_t value, hwaddr addr, unsigned size)
+{
+    if (size == 4) {
+        if (addr & 4) {
+            return value & 0xffffffffU;
+        }
+        return value >> 32;
+    }
+
+    return value;
+}
+
+uint64_t octeon_write64(uint64_t old, hwaddr addr,
+                        uint64_t value, unsigned size)
+{
+    if (size == 4) {
+        if (addr & 4) {
+            return (old & 0xffffffff00000000ULL) | (value & 0xffffffffU);
+        }
+        return (old & 0xffffffffULL) | ((value & 0xffffffffU) << 32);
+    }
+
+    return value;
+}
+
+static uint64_t octeon_atomic_write64(uint64_t *ptr, hwaddr addr,
+                                      uint64_t value, unsigned size,
+                                      uint64_t and_mask, uint64_t or_mask,
+                                      uint64_t *oldp)
+{
+    uint64_t old;
+    uint64_t new;
+    uint64_t cmp = qatomic_read(ptr);
+
+    do {
+        old = cmp;
+        new = (octeon_write64(old, addr, value, size) & and_mask) | or_mask;
+        cmp = qatomic_cmpxchg(ptr, old, new);
+    } while (old != cmp);
+
+    if (oldp) {
+        *oldp = old;
+    }
+
+    return new;
+}
+
 static void octeon_validate_clocks(OcteonMachineState *oms)
 {
     if (!oms->cpu_hz || !oms->ref_hz || !oms->io_hz || !oms->ddr_hz) {
@@ -132,6 +199,140 @@ static uint64_t octeon_secondary_cpu_mask(OcteonState *s)
     return octeon_present_cpu_mask(s) & ~1ULL;
 }
 
+static void octeon_cpu_park_now(MIPSCPU *cpu)
+{
+    CPUMIPSState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    env->active_tc.CP0_TCHalt = 1;
+    env->tcs[0].CP0_TCHalt = 1;
+    cs->halted = 1;
+    cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
+}
+
+static void octeon_cpu_park_work(CPUState *cs, run_on_cpu_data data)
+{
+    octeon_cpu_park_now(MIPS_CPU(cs));
+}
+
+static void octeon_cpu_start_work(CPUState *cs, run_on_cpu_data data)
+{
+    MIPSCPU *cpu = MIPS_CPU(cs);
+    CPUMIPSState *env = &cpu->env;
+
+    cpu->mvp->CP0_MVPControl |= (1 << CP0MVPCo_EVP);
+    env->CP0_VPEConf0 |= (1 << CP0VPEC0_MVP) | (1 << CP0VPEC0_VPA);
+    env->active_tc.CP0_TCHalt = 0;
+    env->tcs[0].CP0_TCHalt = 0;
+    env->active_tc.CP0_TCStatus = (1 << CP0TCSt_A);
+    env->tcs[0].CP0_TCStatus = (1 << CP0TCSt_A);
+    env->active_tc.PC = cpu_mips_phys_to_kseg1(NULL, OCTEON_FLASH_RESET_BASE);
+    cs->halted = 0;
+    cpu_interrupt(cs, CPU_INTERRUPT_WAKE | CPU_INTERRUPT_EXITTB);
+}
+
+static void octeon_start_cpu(OcteonState *s, unsigned int cpu_index)
+{
+    MIPSCPU *cpu;
+
+    if (cpu_index >= s->cpu_count || !s->cpu[cpu_index].cpu) {
+        return;
+    }
+
+    cpu = s->cpu[cpu_index].cpu;
+    async_run_on_cpu(CPU(cpu), octeon_cpu_start_work, RUN_ON_CPU_NULL);
+}
+
+static void octeon_ciu3_start_cpu(OcteonState *s, unsigned int cpu_index)
+{
+    if (qatomic_read(&s->intc->ciu3_pp_rst) & (1ULL << cpu_index)) {
+        return;
+    }
+
+    octeon_start_cpu(s, cpu_index);
+}
+
+static void octeon_ciu3_nmi(OcteonState *s, uint64_t mask)
+{
+    unsigned int cpu;
+
+    for (cpu = 1; cpu < s->cpu_count; cpu++) {
+        if (mask & (1ULL << cpu)) {
+            octeon_ciu3_start_cpu(s, cpu);
+        }
+    }
+}
+
+static uint64_t octeon_ciu3_read(void *opaque, hwaddr addr, unsigned size)
+{
+    OcteonState *s = opaque;
+    hwaddr reg = addr & ~7ULL;
+    uint64_t value;
+
+    if (reg == OCTEON_CIU3_PP_RST) {
+        return octeon_read64(qatomic_read(&s->intc->ciu3_pp_rst), addr, size);
+    }
+
+    if (reg == OCTEON_CIU3_PP_RST_PENDING) {
+        return 0;
+    }
+
+    if (reg == OCTEON_CIU3_NMI) {
+        return 0;
+    }
+
+    if (reg == OCTEON_CIU3_FUSE) {
+        value = octeon_present_cpu_mask(s);
+        return octeon_read64(value, addr, size);
+    }
+
+    return 0;
+}
+
+static void octeon_ciu3_write(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned size)
+{
+    OcteonState *s = opaque;
+    hwaddr reg = addr & ~7ULL;
+    uint64_t old;
+    unsigned int cpu;
+
+    if (reg == OCTEON_CIU3_PP_RST) {
+        value = octeon_atomic_write64(&s->intc->ciu3_pp_rst, addr, value, size,
+                                      octeon_present_cpu_mask(s), 0, &old);
+
+        for (cpu = 1; cpu < s->cpu_count; cpu++) {
+            uint64_t mask = 1ULL << cpu;
+
+            if (!((old ^ value) & mask)) {
+                continue;
+            }
+            if (value & mask) {
+                async_run_on_cpu(CPU(s->cpu[cpu].cpu), octeon_cpu_park_work,
+                                 RUN_ON_CPU_NULL);
+            } else {
+                octeon_ciu3_start_cpu(s, cpu);
+            }
+        }
+        return;
+    }
+
+    if (reg == OCTEON_CIU3_NMI) {
+        octeon_ciu3_nmi(s, octeon_write64(0, addr, value, size));
+        return;
+    }
+}
+
+static const MemoryRegionOps octeon_ciu3_ops = {
+    .read = octeon_ciu3_read,
+    .write = octeon_ciu3_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
 static void octeon_cpu_after_reset(OcteonCPUState *cs)
 {
     CPUMIPSState *env = &cs->cpu->env;
@@ -139,7 +340,13 @@ static void octeon_cpu_after_reset(OcteonCPUState *cs)
     env->CP0_CvmMemCtl = 0x100;
     env->CP0_CvmCtl = 0;
 
-    if (cs->boot_cpu && cs->board->firmware_entry) {
+    if (!cs->boot_cpu) {
+        /* Secondary cores are released by the Octeon reset controller. */
+        octeon_cpu_park_now(cs->cpu);
+        return;
+    }
+
+    if (cs->board->firmware_entry) {
         env->active_tc.PC = cs->board->firmware_entry;
     }
 }
@@ -151,6 +358,8 @@ static void octeon_create_cpus(OcteonState *s)
     s->cpuclk = clock_new(OBJECT(s->machine), "cpu-refclk");
     clock_set_hz(s->cpuclk, s->cpu_hz);
     s->cpu_count = s->machine->smp.cpus;
+    qatomic_set(&s->intc->ciu3_pp_rst, octeon_secondary_cpu_mask(s));
+
     for (i = 0; i < s->cpu_count; i++) {
         DeviceState *dev = qdev_new(s->machine->cpu_type);
 
@@ -348,6 +557,19 @@ static void octeon_rst_reset_hold(Object *obj, ResetType type)
     rst->rst_pp_power = octeon_secondary_cpu_mask(rst->parent_obj.board);
 }
 
+static void octeon_intc_reset_hold(Object *obj, ResetType type)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_GET_CLASS(obj);
+    OcteonIntcState *intc = OCTEON_INTC(obj);
+    OcteonState *s = intc->parent_obj.board;
+
+    if (opc->parent_phases.hold) {
+        opc->parent_phases.hold(obj, type);
+    }
+
+    qatomic_set(&intc->ciu3_pp_rst, octeon_secondary_cpu_mask(s));
+}
+
 static void octeon_peripheral_class_init(ObjectClass *klass,
                                           const void *data)
 {
@@ -365,6 +587,15 @@ static void octeon_rst_class_init(ObjectClass *klass, const void *data)
                                        NULL, &opc->parent_phases);
 }
 
+static void octeon_intc_class_init(ObjectClass *klass, const void *data)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    resettable_class_set_parent_phases(rc, NULL, octeon_intc_reset_hold,
+                                       NULL, &opc->parent_phases);
+}
+
 static OcteonPeripheralState *octeon_new_peripheral(OcteonState *s,
                                                      const char *type,
                                                      unsigned int index)
@@ -380,6 +611,7 @@ static OcteonPeripheralState *octeon_new_peripheral(OcteonState *s,
 static void octeon_create_peripherals(OcteonState *s)
 {
     s->rst = OCTEON_RST(octeon_new_peripheral(s, TYPE_OCTEON_RST, 0));
+    s->intc = OCTEON_INTC(octeon_new_peripheral(s, TYPE_OCTEON_INTC, 0));
 }
 
 static void octeon_realize_peripheral(OcteonPeripheralState *dev)
@@ -389,6 +621,7 @@ static void octeon_realize_peripheral(OcteonPeripheralState *dev)
 
 static void octeon_realize_peripherals(OcteonState *s)
 {
+    octeon_realize_peripheral(&s->intc->parent_obj);
     octeon_realize_peripheral(&s->rst->parent_obj);
 }
 
@@ -418,6 +651,12 @@ static void mips_octeon_init(MachineState *machine)
     octeon_load_firmware(s);
     octeon_create_cpus(s);
 
+    memory_region_init_io(&s->intc->ciu3, OBJECT(s->intc),
+                          &octeon_ciu3_ops, s,
+                          "octeon.ciu3", OCTEON_CIU3_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_CIU3_BASE,
+                                &s->intc->ciu3);
+
     octeon_realize_peripherals(s);
 }
 
@@ -490,6 +729,12 @@ static const TypeInfo octeon_machine_types[] = {
         .instance_size = sizeof(OcteonRstState),
         .class_init = octeon_rst_class_init,
     },
+    {
+        .name = TYPE_OCTEON_INTC,
+        .parent = TYPE_OCTEON_PERIPHERAL,
+        .instance_size = sizeof(OcteonIntcState),
+        .class_init = octeon_intc_class_init,
+    },
     {
         .name = TYPE_OCTEON_MACHINE,
         .parent = TYPE_MACHINE,
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index 9c1baee292..884eed8994 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -16,6 +16,7 @@
 #define OCTEON_MAX_CPUS             16
 typedef struct OcteonState OcteonState;
 typedef struct OcteonRstState OcteonRstState;
+typedef struct OcteonIntcState OcteonIntcState;
 
 typedef struct OcteonCPUState {
     OcteonState *board;
@@ -41,6 +42,11 @@ struct OcteonState {
     MemoryRegion boot_flash_alias;
     MemoryRegion cvmseg;
     OcteonRstState *rst;
+    OcteonIntcState *intc;
 };
 
+uint64_t octeon_read64(uint64_t value, hwaddr addr, unsigned size);
+uint64_t octeon_write64(uint64_t old, hwaddr addr,
+                        uint64_t value, unsigned size);
+
 #endif
-- 
2.56.0


