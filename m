Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D2606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=FmDSwD8U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW2tO-0000JX-Gg; Tue, 24 Nov 2026 21:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2tB-0000EN-C0
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:42 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW2t6-0007Eg-MT
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:37:41 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-67db5e13b0cso4760723d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795574254; x=1796179054; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pusDqLe6cY6gfFOcClJIzWVqaK1H1p9p9EVKqYMdRCk=;
 b=FmDSwD8UH9LgKNfEMI0eoiOCk8tdPaqwcbDyVUKsT5Ey3RBoh+FbkuS4Mka6BVZxH+
 9W58tFwC8dJoBUw40TontaODEKDeOBJIHO6y+hf6oMtREphOs/e41mVoP7VD2XWdL1Fi
 a6N8banTjSadi6NtLiPo6FOD+gzi8RZX4l+zZ/RPjPz5ugXpFOv9iEQsTI2s9fORUEoe
 WkFWtcyqUY03ItVV24oAmbBCUnmZephVWQyMbWDggSNxM+FnmgBld9kM3yBXz9TTTBaL
 AbPPYaXWWdydQ+9hrPn+bZgqYnn8V88EeCjVbbVI/AXB9Zyh+vXiu5dBUspw1W35hwNX
 c3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795574254; x=1796179054;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pusDqLe6cY6gfFOcClJIzWVqaK1H1p9p9EVKqYMdRCk=;
 b=bEyXS4+bPMipMDpSxdRnaZwy9ftdXXTJ8+5m+d9VnZ8ocxrjnqd8fE4IMYvsQXr3DZ
 94i/a8jaxC5Zi4tJqbxeEuYQr7vD6hiodPCLAcJBvPtEDVxBviFE6MTKSvcuTWJuad/A
 dzKlakJhx1KaUn7qs4o9Em7hUyeP2l6HUce3TD7G6v1mC9aPmjm1AOZwH04+s3cLLy3q
 rmOEPlJ80TPmtMQRQVguHBdd+jj6sTbyBLuxMwkRu7Ko5RC01rfKgSBsklEfBcglPb9Y
 k64i0JKEYD2u6D03p44kIb9EebCRfQtiLww6aZ/zT/w7RrPBjJV+9y+t/sx0+JqYLWml
 tCTg==
X-Gm-Message-State: APuU4Z8QVl0oeKTbuzSDKGk+77mRYFzh8PQv1sVg8+6rXFCfM0XsqInO
 DCMo2gItDnH+Vt2XO0i8KFh9bcT/3fV9LgKwOtito3S4ISDL1Sr7wubf6nG63cZp3xI=
X-Gm-Gg: AZFdTZcb26wwoplUYHqYnUHL1agrNERSygtMKfmSc+MLOZxYyE4wdFHr34roVw/f1LF
 tVrB0VaQ6s1NfTXOVXT2WdI9HRIoKWb8xwpkgb+NvkSGeEp5htCUOMKOR3/wxDZEFeCkiCUGvY3
 z2APPDjHSph44tHQdlAQOn62A342qbkKZ4YV9IYltg+c0OojZGUWwECA/LSekzlRFpRIu6iG7Td
 IOvY6bejeDUDvy8urP616Xke2qPy1RE1HyRqgagcQLyzzJ2j1FDyThVLwnz+U5dylp/7tvalpeL
 rdeePraCHYKy/4IGpSAZ+aIviW02V3igqKTXy18p1xw/4gkhZKTD/JkfO6cgn13dtf13OulFXPJ
 2UwOUavuZC+opDXUkNieH5NT0uOpd9sheUSH8s19/vvNkf4NwHhi64TJOk/Gii3YVXPgdstgGLd
 TilIxfAJzXom5w2fyeNBZyrHMwlRihKUNwuBc82WTnFYC1eh7yuITxF8J4IdkPOo4+smOI0Y7mo
 0irQcG6eaGaWJy1b2NkwwAEsKMsIwIdfaIYtrsoGBP/oXEyyb1cWIx8MtS19u/eqehkIM4cwVp2
 jsdscMseJN9uySx59UZwaaFSCSg8WajEuhQj1x+QWEg20VaMO0DJmgwyJcwbBp2t7O5rV2Cz/uQ
 AWczk0hEw
X-Received: by 2002:a05:690c:284:b0:8b3:4ead:91cc with SMTP id
 00721157ae682-8b52050aa0bmr58204557b3.98.1795574254382; 
 Tue, 24 Nov 2026 18:37:34 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:ea8f:7897:2f4d:9891])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b52028d628sm65626717b3.8.2026.11.24.18.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 18:37:34 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 24 Nov 2026 20:37:26 -0600
Subject: [PATCH 7/8] hw/riscv/spacemit-k3: SMP support for Spacemit K3 machine
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-spacemit_k3-v1-7-e911d6e88542@oss.tenstorrent.com>
References: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
In-Reply-To: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Jeuk Kim <jeuk20.kim@samsung.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the Spacemit K3 SoC, a single X100 hart is released at reset and
executes the bootrom. This HART configures the resetvectors for the
non-boot harts by writing to registers in the CPU Config Unit. The
non-boot harts can be released from reset either via an IPI (vendor
OpenSBI does this) or writing to a register in the Syscon APMU (upstream
OpenSBI does this).

SMP support for the spacemit-k3 machine is implemented in 2 ways:
writes to specific registers in Syscon APMU can release the non-boot
harts from reset, and an overlay region is applied over the M-IMSIC to
intercept IPI writes and release the non-boot harts from reset.

The spacemit-k3 machine is updated to support 8 X100 harts. Both
min_harts and max_harts are set to 8, so the -smp value has no effect.
The 8 A100 harts are not implemented in this machine.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 hw/misc/spacemit_k3_syscon.c         | 157 ++++++++++++++++++++++++++++++++++-
 hw/misc/trace-events                 |   2 +
 hw/riscv/spacemit_k3.c               |  41 +++++++--
 include/hw/misc/spacemit_k3_syscon.h |  13 +++
 4 files changed, 206 insertions(+), 7 deletions(-)

diff --git a/hw/misc/spacemit_k3_syscon.c b/hw/misc/spacemit_k3_syscon.c
index 452cab8183..a023823564 100644
--- a/hw/misc/spacemit_k3_syscon.c
+++ b/hw/misc/spacemit_k3_syscon.c
@@ -19,6 +19,7 @@
 #include "crypto/hash.h"
 #include "hw/core/cpu.h"
 #include "hw/misc/spacemit_k3_syscon.h"
+#include "target/riscv/cpu.h"
 #include "trace.h"
 
 #define TO_REG(offset) (offset >> 2)
@@ -38,13 +39,38 @@
 /* CPU Config register offsets */
 #define BOOT_PIN_SELECT 0x20
 #define BOOT_DEV_FLAG_REG 0x110
+#define C0_RVBADDR_LO_ADDR 0x1b0
+#define C0_RVBADDR_HI_ADDR 0x1b4
+#define C1_RVBADDR_LO_ADDR 0x2b0
+#define C1_RVBADDR_HI_ADDR 0x2b4
 
 /* Syscon APMU register offsets */
+#define PMU_AP_CORE0_WAKEUP 0x12c
+#define PMU_AP_CORE1_WAKEUP 0x130
+#define PMU_AP_CORE2_WAKEUP 0x134
+#define PMU_AP_CORE3_WAKEUP 0x138
 #define APMU_RCPU_CLK_RES_CTRL 0x14c
+#define PMU_AP_CORE4_WAKEUP 0x324
+#define PMU_AP_CORE5_WAKEUP 0x328
+#define PMU_AP_CORE6_WAKEUP 0x32c
+#define PMU_AP_CORE7_WAKEUP 0x330
 
 /* Syscon MPMU register offsets */
 #define MPMU_POSR 0x10
 
+#define SPACEMIT_K3_IMSIC_MSTRIDE 0x1000
+
+#define RVBA_LO(cpu_idx) TO_REG((C0_RVBADDR_LO_ADDR + ((cpu_idx >> 2) * 0x100)))
+#define RVBA_HI(cpu_idx) TO_REG((C0_RVBADDR_HI_ADDR + ((cpu_idx >> 2) * 0x100)))
+
+static void spacemit_k3_syscon_apmu_release_hart(CPUState *cs,
+                                               run_on_cpu_data data)
+{
+    cpu_reset(cs);
+    cs->halted = 0;
+    qemu_cpu_kick(cs);
+}
+
 static uint64_t spacemit_k3_syscon_mpmu_read(void *opaque, hwaddr offset,
                                              unsigned size)
 {
@@ -97,7 +123,70 @@ static uint64_t spacemit_k3_syscon_apmu_read(void *opaque, hwaddr offset,
 static void spacemit_k3_syscon_apmu_write(void *opaque, hwaddr offset,
                                   uint64_t value, unsigned size)
 {
+    SpacemitK3SysconAPMUState *s = SPACEMIT_K3_SYSCON_APMU_UNIT(opaque);
+    int cpu_idx = -1;
+
     trace_spacemit_k3_syscon_apmu_write(offset, size, value);
+
+    switch (offset) {
+    case PMU_AP_CORE1_WAKEUP:
+    case PMU_AP_CORE2_WAKEUP:
+    case PMU_AP_CORE3_WAKEUP:
+        cpu_idx = (offset - PMU_AP_CORE0_WAKEUP) >> 2;
+        break;
+    case PMU_AP_CORE4_WAKEUP:
+    case PMU_AP_CORE5_WAKEUP:
+    case PMU_AP_CORE6_WAKEUP:
+    case PMU_AP_CORE7_WAKEUP:
+        cpu_idx = 4 + ((offset - PMU_AP_CORE4_WAKEUP) >> 2);
+        break;
+    default:
+      qemu_log_mask(LOG_UNIMP,
+                    "%s: unimplemented write (size %u, offset 0x%" HWADDR_PRIx
+                    ", value 0x%" PRIx64 ")\n",
+                    TYPE_SPACEMIT_K3_SYSCON_APMU_UNIT, size, offset, value);
+      break;
+    }
+
+    /* Release non-boot HART from reset */
+    if (cpu_idx != -1 && !s->released[cpu_idx]) {
+        CPUState *cs = s->cpus[cpu_idx];
+        s->released[cpu_idx] = true;
+
+        trace_spacemit_k3_syscon_apmu_cpu_release(cpu_idx);
+        async_safe_run_on_cpu(cs, spacemit_k3_syscon_apmu_release_hart,
+                              RUN_ON_CPU_NULL);
+    }
+}
+
+static void spacemit_k3_syscon_apmu_overlay_write(void *opaque, hwaddr offset,
+                                                  uint64_t value, unsigned size)
+{
+    SpacemitK3SysconAPMUState *s = SPACEMIT_K3_SYSCON_APMU_UNIT(opaque);
+    unsigned int hart = offset / SPACEMIT_K3_IMSIC_MSTRIDE;
+    hwaddr page_offset = offset % SPACEMIT_K3_IMSIC_MSTRIDE;
+
+    if (hart >= SPACEMIT_K3_MAX_NUM_HARTS ||
+        s->mimsic_regions[hart] == NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid overlay write (hart %u, offset 0x%"
+                      HWADDR_PRIx ", value 0x%" PRIx64 ")\n",
+                      TYPE_SPACEMIT_K3_SYSCON_APMU_UNIT, hart, offset, value);
+        return;
+    }
+
+    memory_region_dispatch_write(s->mimsic_regions[hart], page_offset, value,
+                                 MO_32, MEMTXATTRS_UNSPECIFIED);
+    trace_spacemit_k3_syscon_apmu_overlay_write(hart, offset, value);
+
+    if (!s->released[hart]) {
+        CPUState *cs = s->cpus[hart];
+        s->released[hart] = true;
+
+        trace_spacemit_k3_syscon_apmu_cpu_release(hart);
+        async_safe_run_on_cpu(cs, spacemit_k3_syscon_apmu_release_hart,
+                              RUN_ON_CPU_NULL);
+    }
 }
 
 static uint64_t spacemit_k3_ddrc_read(void *opaque, hwaddr offset,
@@ -165,10 +254,31 @@ static void spacemit_k3_cpu_config_write(void *opaque, hwaddr offset,
                                   uint64_t value, unsigned size)
 {
     SpacemitK3CPUConfigState *s = SPACEMIT_K3_CPU_CONFIG(opaque);
+    int cluster_idx = -1;
 
     trace_spacemit_k3_cpu_config_write(offset, size, value);
 
     s->regs[TO_REG(offset)] = value;
+
+    switch (offset) {
+    case C0_RVBADDR_LO_ADDR:
+    case C0_RVBADDR_HI_ADDR:
+        cluster_idx = 0;
+        break;
+    case C1_RVBADDR_LO_ADDR:
+    case C1_RVBADDR_HI_ADDR:
+        cluster_idx = 1;
+        break;
+    }
+
+    if (cluster_idx != -1) {
+        for (int cpu_idx = cluster_idx * 4; cpu_idx < cluster_idx * 4 + 4;
+           cpu_idx++) {
+            cpu_set_exception_base(cpu_idx,
+                                   s->regs[RVBA_LO(cpu_idx)] |
+                                   ((uint64_t)s->regs[RVBA_HI(cpu_idx)]) << 32);
+        }
+    }
 }
 
 static uint32_t spacemit_k3_boot_mode_value(int boot_mode)
@@ -234,6 +344,15 @@ static const MemoryRegionOps spacemit_k3_syscon_apmu_ops = {
     },
 };
 
+static const MemoryRegionOps spacemit_k3_syscon_apmu_overlay_ops = {
+    .write = spacemit_k3_syscon_apmu_overlay_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static const MemoryRegionOps spacemit_k3_ddrc_ops = {
     .read = spacemit_k3_ddrc_read,
     .write = spacemit_k3_ddrc_write,
@@ -274,6 +393,11 @@ static void spacemit_k3_syscon_apmu_init(Object *obj)
                           TYPE_SPACEMIT_K3_SYSCON_APMU_UNIT,
                           SPACEMIT_K3_SYSCON_APMU_SIZE);
     sysbus_init_mmio(dev, &s->mmio);
+
+    memory_region_init_io(&s->mimsic_overlay, obj,
+                          &spacemit_k3_syscon_apmu_overlay_ops,
+                          s, "k3.apmu.imsic-overlay",
+                          0x10000);
 }
 
 static void spacemit_k3_ddrc_init(Object *obj)
@@ -314,6 +438,34 @@ static void spacemit_k3_ddrc_class_init(ObjectClass *oc,
     rc->phases.hold = spacemit_k3_ddrc_reset_hold;
 }
 
+static void spacemit_k3_syscon_apmu_reset_hold(Object *obj, ResetType type)
+{
+    SpacemitK3SysconAPMUState *s = SPACEMIT_K3_SYSCON_APMU_UNIT(obj);
+
+    memset(s->released, 0, sizeof(s->released));
+
+    /* Mark boot hart as released from reset */
+    s->released[0] = true;
+}
+
+static const Property spacemit_k3_syscon_apmu_properties[] = {
+    DEFINE_PROP_LINK_ARRAY("cpus", SpacemitK3SysconAPMUState, num_cpus, cpus,
+                           TYPE_CPU, CPUState *),
+    DEFINE_PROP_LINK_ARRAY("mimsic-regions", SpacemitK3SysconAPMUState,
+                              num_imsics, mimsic_regions,
+                              TYPE_MEMORY_REGION, MemoryRegion *),
+};
+
+static void spacemit_k3_syscon_apmu_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    device_class_set_props(dc, spacemit_k3_syscon_apmu_properties);
+    rc->phases.hold = spacemit_k3_syscon_apmu_reset_hold;
+}
+
 static void spacemit_k3_cpu_config_reset_hold(Object *obj, ResetType type)
 {
     SpacemitK3CPUConfigState *s = SPACEMIT_K3_CPU_CONFIG(obj);
@@ -326,6 +478,8 @@ static void spacemit_k3_cpu_config_reset_hold(Object *obj, ResetType type)
 static const Property spacemit_k3_cpu_config_properties[] = {
     DEFINE_PROP_INT32("boot-mode", SpacemitK3CPUConfigState, boot_mode,
                       SPACEMIT_K3_BOOT_MODE_NOR),
+    DEFINE_PROP_LINK_ARRAY("cpus", SpacemitK3CPUConfigState, num_cpus, cpus,
+                           TYPE_CPU, CPUState *),
 };
 
 static void spacemit_k3_cpu_config_class_init(ObjectClass *klass,
@@ -336,7 +490,7 @@ static void spacemit_k3_cpu_config_class_init(ObjectClass *klass,
 
     device_class_set_props(dc, spacemit_k3_cpu_config_properties);
     rc->phases.hold = spacemit_k3_cpu_config_reset_hold;
-}
+};
 
 static const TypeInfo spacemit_k3_syscon_types[] = {
     {
@@ -350,6 +504,7 @@ static const TypeInfo spacemit_k3_syscon_types[] = {
         .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(SpacemitK3SysconAPMUState),
         .instance_init = spacemit_k3_syscon_apmu_init,
+        .class_init = spacemit_k3_syscon_apmu_class_init,
     },
     {
         .name = TYPE_SPACEMIT_K3_DDRC,
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index ec7072f309..9fe13128a0 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -478,6 +478,8 @@ tt_atlantis_prcm_write(uint32_t domain, uint64_t offset, uint64_t data) "domain
 # spacemit_k3_syscon.c
 spacemit_k3_syscon_apmu_read(uint64_t offset, unsigned size, uint64_t value) "offset 0x%04" PRIx64 " size %u value 0x%08" PRIx64
 spacemit_k3_syscon_apmu_write(uint64_t offset, unsigned size, uint64_t value) "offset 0x%04" PRIx64 " size %u value 0x%08" PRIx64
+spacemit_k3_syscon_apmu_cpu_release(int cpu) "release cpu %d from reset"
+spacemit_k3_syscon_apmu_overlay_write(int hart, uint64_t offset, uint64_t value) "hart %d offset 0x%04" PRIx64 " value 0x%08" PRIx64
 spacemit_k3_syscon_mpmu_read(uint64_t offset, unsigned size, uint64_t value) "offset 0x%04" PRIx64 " size %u value 0x%08" PRIx64
 spacemit_k3_syscon_mpmu_write(uint64_t offset, unsigned size, uint64_t value) "offset 0x%04" PRIx64 " size %u value 0x%08" PRIx64
 spacemit_k3_cpu_config_read(uint64_t offset, unsigned size, uint64_t value) "offset 0x%04" PRIx64 " size %u value 0x%08" PRIx64
diff --git a/hw/riscv/spacemit_k3.c b/hw/riscv/spacemit_k3.c
index 2ff035c239..62265978fa 100644
--- a/hw/riscv/spacemit_k3.c
+++ b/hw/riscv/spacemit_k3.c
@@ -35,6 +35,7 @@
 #include "hw/riscv/spacemit_k3.h"
 
 #include "system/qtest.h"
+#include "qobject/qlist.h"
 
 #define SPACEMIT_K3_IRQCHIP_NUM_MSIS       511
 #define SPACEMIT_K3_IRQCHIP_NUM_SOURCES    512
@@ -308,6 +309,9 @@ static void spacemit_k3_machine_init(MachineState *machine)
     MemoryRegion *ddr_train_buf = g_new(MemoryRegion, 1);
     int hart_count = machine->smp.cpus;
     int i;
+    DeviceState *imsic_m[SPACEMIT_K3_MAX_NUM_HARTS];
+    QList *cpulist = qlist_new();
+    QList *mimsiclist = qlist_new();
 
     s->memmap = spacemit_k3_memmap;
 
@@ -329,10 +333,10 @@ static void spacemit_k3_machine_init(MachineState *machine)
      * so that we get handles to misic memory regions.
      */
     for (i = 0; i < hart_count; i++) {
-        riscv_imsic_create(get_system_memory(),
-                         s->memmap[SPACEMIT_K3_MIMSIC].base +
-                             i * SPACEMIT_K3_IMSIC_MSTRIDE,
-                         i, true, 1, SPACEMIT_K3_IRQCHIP_NUM_MSIS);
+        imsic_m[i] = riscv_imsic_create(get_system_memory(),
+                                      s->memmap[SPACEMIT_K3_MIMSIC].base +
+                                          i * SPACEMIT_K3_IMSIC_MSTRIDE,
+                                      i, true, 1, SPACEMIT_K3_IRQCHIP_NUM_MSIS);
     }
 
     for (i = 0; i < hart_count; i++) {
@@ -488,10 +492,18 @@ static void spacemit_k3_machine_init(MachineState *machine)
                                 s->memmap[SPACEMIT_K3_THERMAL].base,
                                 s->memmap[SPACEMIT_K3_THERMAL].size);
 
+    for (int cpu_idx = 0; cpu_idx < hart_count; cpu_idx++) {
+        qlist_append_link(cpulist, OBJECT(&s->soc.harts[cpu_idx]));
+        qlist_append_link(mimsiclist,
+                          OBJECT(sysbus_mmio_get_region(
+                              SYS_BUS_DEVICE(imsic_m[cpu_idx]), 0)));
+    }
+
     object_initialize_child(OBJECT(machine), "spacemit-k3.cpu_config",
                             &s->cpu_config, TYPE_SPACEMIT_K3_CPU_CONFIG);
     object_property_set_int(OBJECT(&s->cpu_config),
                                 "boot-mode", s->boot_mode, &error_fatal);
+    qdev_prop_set_array(DEVICE(&s->cpu_config), "cpus", qobject_ref(cpulist));
     sysbus_realize(SYS_BUS_DEVICE(&s->cpu_config), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpu_config), 0,
                     s->memmap[SPACEMIT_K3_CPU_CONFIG_UNIT].base);
@@ -510,10 +522,19 @@ static void spacemit_k3_machine_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "spacemit-k3.syscon_apmu",
                             &s->syscon_apmu, TYPE_SPACEMIT_K3_SYSCON_APMU_UNIT);
+    qdev_prop_set_array(DEVICE(&s->syscon_apmu), "cpus", cpulist);
+    qdev_prop_set_array(DEVICE(&s->syscon_apmu), "mimsic-regions",
+                      mimsiclist);
+
     sysbus_realize(SYS_BUS_DEVICE(&s->syscon_apmu), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->syscon_apmu), 0,
                     s->memmap[SPACEMIT_K3_SYSCON_APMU].base);
 
+    /* Map IMSIC Overlay Region of Syscon APMU over MIMSIC range */
+    memory_region_add_subregion_overlap(
+        get_system_memory(), s->memmap[SPACEMIT_K3_MIMSIC].base,
+        &SPACEMIT_K3_SYSCON_APMU_UNIT(&s->syscon_apmu)->mimsic_overlay, 2);
+
     object_initialize_child(OBJECT(machine), "spacemit-k3.syscon_mpmu",
                             &s->syscon_mpmu, TYPE_SPACEMIT_K3_SYSCON_MPMU_UNIT);
     sysbus_realize(SYS_BUS_DEVICE(&s->syscon_mpmu), &error_fatal);
@@ -629,6 +650,13 @@ static void spacemit_k3_machine_init(MachineState *machine)
                    qdev_get_gpio_in(s->irqchip, SPACEMIT_K3_UART0_IRQ), 115200,
                    serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
+    /* Hold all harts but the boot hart in reset */
+    for (int cpu_idx = 1; cpu_idx < hart_count; cpu_idx++) {
+        CPUState *cs = CPU(&s->soc.harts[cpu_idx]);
+        cs->start_powered_off = true;
+        cs->halted = 1;
+    }
+
     s->machine_done.notify = spacemit_k3_machine_done;
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
@@ -684,8 +712,9 @@ static void spacemit_k3_machine_class_init(ObjectClass *oc, const void *data)
 
     mc->desc = "Spacemit K3 board";
     mc->init = spacemit_k3_machine_init;
-    mc->max_cpus = 1;
-    mc->default_cpus = 1;
+    mc->min_cpus = SPACEMIT_K3_MAX_NUM_HARTS;
+    mc->max_cpus = SPACEMIT_K3_MAX_NUM_HARTS;
+    mc->default_cpus = SPACEMIT_K3_MAX_NUM_HARTS;
     mc->default_ram_id = "spacemit-k3.dram";
     mc->default_ram_size = 16 * GiB;
     mc->default_cpu_type = TYPE_RISCV_CPU_SPACEMIT_X100;
diff --git a/include/hw/misc/spacemit_k3_syscon.h b/include/hw/misc/spacemit_k3_syscon.h
index 68450680d7..c6b1cb4f21 100644
--- a/include/hw/misc/spacemit_k3_syscon.h
+++ b/include/hw/misc/spacemit_k3_syscon.h
@@ -19,6 +19,8 @@
 #define SPACEMIT_K3_SYSCON_APMU_SIZE 0x400
 #define SPACEMIT_K3_DDRC_SIZE 0x1000000
 
+#define SPACEMIT_K3_MAX_NUM_HARTS 8
+
 #define TYPE_SPACEMIT_K3_SYSCON_MPMU_UNIT "spacemit-k3-syscon-mpmu"
 OBJECT_DECLARE_SIMPLE_TYPE(SpacemitK3SysconMPMUState,
                            SPACEMIT_K3_SYSCON_MPMU_UNIT)
@@ -45,6 +47,14 @@ struct SpacemitK3SysconAPMUState {
     /*< public >*/
 
     MemoryRegion mmio;
+
+    MemoryRegion mimsic_overlay;
+    MemoryRegion **mimsic_regions;
+    uint32_t num_imsics;
+
+    CPUState **cpus;
+    uint32_t num_cpus;
+    bool released[SPACEMIT_K3_MAX_NUM_HARTS];
 };
 
 struct SpacemitK3DDRCState {
@@ -66,6 +76,9 @@ struct SpacemitK3CPUConfigState {
     MemoryRegion mmio;
     uint32_t regs[SPACEMIT_K3_CPU_CONFIG_SIZE >> 2];
     int boot_mode;
+
+    CPUState **cpus;
+    uint32_t num_cpus;
 };
 
 enum {

-- 
2.43.0


