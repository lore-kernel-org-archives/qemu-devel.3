Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224DECCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn3L-0003dx-3x; Thu, 23 Oct 2025 00:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3J-0003dX-Er
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:53 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3G-0001N6-SU
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:53 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-27c369f898fso5642665ad.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194149; x=1761798949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRyvacnqtI4si+nQ4b5gxD62fETZ2OPFAQhTwKMxPDU=;
 b=OyaLcdQvz9Oz1Czs3pC6vUcvuoMzNWew3zCauxgP2gURWKml4UopDNrNtZHCcPOEHZ
 NbjJ/atNvJHCSZy27/Nz2FFdXRxHVBu4WMM+LPI0S59lKpmmtgm8Aep7WEzurgR7Swcw
 k8xNPxiRwy0Yt61q4tQ3RMYcKnoLxmx0mZbP9gxSCIDWwFZ7oXoHq4ghV+S0/wdKYFfy
 NUHbZSjX9t2bJ+fJlND4cJe1m4u4VhVGEY71PujuFi2w7PPCo5YNdAggI0lT1atyc11u
 HpL69w8yp/QJ8aHTlAl04/u2bmoJctpjOn/qmm8qWyM1lMVHWVxBFB1fD6vOWYo2RM6Q
 jmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194149; x=1761798949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sRyvacnqtI4si+nQ4b5gxD62fETZ2OPFAQhTwKMxPDU=;
 b=JpzgaFXlWJRpQo6Cts+9iMAorzYtb0g9/d3rFsiCPasb78Tl/pbsM2LYGQxkDlwAL3
 bCniTF4GE01bLDRxyAGsq8Y8JB5GV6gapmvPK7hAqGuoNOHcEQowduILvg7VQesoTQlo
 d58zSDWMtWg31nXqDenXdVkzZZb3tsYslv15Lhs3xTt/GbfqR0j/MBGWCXvJVEwqijkW
 s5vUPjXiBLqK2t52wDSSgzYmEAQcnfD/tCiUyDVdwE7J34XbwJ/EJGa+OcuWZo9NfO4t
 m6oY9h9IJpwvnhdAu7DlIBKqx5BoOns4e7Yw9E3HSRAGV8pR24bHJgYloiI5S3/XnVnW
 fkHQ==
X-Gm-Message-State: AOJu0YwrbSa3zA4SjNM0jYTfwwLQE9SZND9hWV/rHGcNTI6dPsH+kEEe
 c0WEqd/fMdT5k5QWxnEDpx20b00TVASvjD8Zw765+xu3ATd0Mb6i+YJ6P4tONQ==
X-Gm-Gg: ASbGncvUJdoURmDFknzRanE+kXXt/AQglyUoyURlsIl17p3Uaw4fDArRDf7Uf2Ue2HC
 KGPh7Qe0nGRbk8W/Jyq2crq/0ombLYFZSTo24otY205oTB7jELjyiyC7kqCkyABZk/d4/IFH2S/
 hsD/tak5MSNPkZnzRcBqYr3W4Sa7q3QSscLzyolk4uOZuhgOBbW5cNYqqtljXFm9Uo3qzMgnNR/
 povMoBkAzTGg6jKFEnkwAMhyeY/PaHyEi4+wyXhnN3TkBM4l3qzYHk8LiOk/zHgLvbLdm6KS8ok
 nrXpkAyWR4dIXhs/BTL2xStV/1qa96SSB0hA6z0+vOJLflJ1+/O9Fr5v1lHWuX2hVnUVAqpkFdF
 pXtJN6bL4zTwZlDxDKIWPWaD0aRpPOFSxc4phybT99Vo1xiG8sWusZ7hmufI297Fb/vOlZYkGEO
 An+uxpQcSjeGPIlYlErEU5hYoOaHlNucqcI4g79I3mLCmqsfHKSKBBFKVm/Z6npPygZd0xUVt7M
 AVrlp+2Ilm9q9y3z00=
X-Google-Smtp-Source: AGHT+IF2hLOfWVeaPjkZSGdiz/C2PhtVLUghlALgdtXiXnKVGaHTABI0CSjsuMjJOfD/UvQ42e6vXQ==
X-Received: by 2002:a17:902:f542:b0:24f:dbe7:73a2 with SMTP id
 d9443c01a7336-290ca121a7bmr306304505ad.31.1761194148953; 
 Wed, 22 Oct 2025 21:35:48 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:35:48 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/37] hw/misc: Add RISC-V CPC device implementation
Date: Thu, 23 Oct 2025 14:35:10 +1000
Message-ID: <20251023043520.1777130-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add RISC-V implementation of the Cluster Power Controller (CPC) device.
It is based on the existing MIPS CPC implementations but adapted for
RISC-V systems.

The CPC device manages power control for CPU clusters in RISC-V
systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20251018154522.745788-10-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/misc/riscv_cpc.h |  64 +++++++++
 hw/misc/riscv_cpc.c         | 265 ++++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig             |   4 +
 hw/misc/meson.build         |   1 +
 4 files changed, 334 insertions(+)
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 hw/misc/riscv_cpc.c

diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
new file mode 100644
index 0000000000..713455eb83
--- /dev/null
+++ b/include/hw/misc/riscv_cpc.h
@@ -0,0 +1,64 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPC_H
+#define RISCV_CPC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define CPC_ADDRSPACE_SZ    0x6000
+
+/* CPC global register offsets relative to base address */
+#define CPC_MTIME_REG_OFS   0x50
+
+#define CPC_CM_STAT_CONF_OFS   0x1008
+
+/* CPC blocks offsets relative to base address */
+#define CPC_CL_BASE_OFS     0x2000
+#define CPC_CORE_REG_STRIDE 0x100 /* Stride between core-specific registers */
+
+/* CPC register offsets relative to block offsets */
+#define CPC_STAT_CONF_OFS   0x08
+#define CPC_VP_STOP_OFS     0x20
+#define CPC_VP_RUN_OFS      0x28
+#define CPC_VP_RUNNING_OFS  0x30
+
+#define SEQ_STATE_BIT       19
+#define SEQ_STATE_U5        0x6
+#define SEQ_STATE_U6        0x7
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U5      (SEQ_STATE_U5 << SEQ_STATE_BIT)
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U6      (SEQ_STATE_U6 << SEQ_STATE_BIT)
+
+#define TYPE_RISCV_CPC "xmips-cpc"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
+
+typedef struct RISCVCPCState {
+    SysBusDevice parent_obj;
+
+    uint32_t cluster_id;
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    /* VPs running from restart mask */
+    uint64_t vps_start_running_mask;
+
+    MemoryRegion mr;
+    /* Indicates which VPs are in the run state mask */
+    uint64_t vps_running_mask;
+
+    /* Array of CPUs managed by this CPC */
+    CPUState **cpus;
+} RISCVCPCState;
+
+#define CPC_MAX_VPS 64  /* Maximum number of VPs supported */
+
+#endif /* RISCV_CPC_H */
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..344f855847
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,265 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/resettable.h"
+
+static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
+{
+    return MAKE_64BIT_MASK(0, cpc->num_vp);
+}
+
+static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPCState *cpc = (RISCVCPCState *) data.host_ptr;
+    int i;
+
+    cpu_reset(cs);
+    cs->halted = 0;
+
+    /* Find this CPU's index in the CPC's CPU array */
+    for (i = 0; i < cpc->num_vp; i++) {
+        if (cpc->cpus[i] == cs) {
+            cpc->vps_running_mask |= BIT_ULL(i);
+            break;
+        }
+    }
+}
+
+static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vps_run_mask)
+{
+    int vp;
+
+    for (vp = 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs = cpc->cpus[vp];
+
+        if (!extract64(vps_run_mask, vp, 1)) {
+            continue;
+        }
+
+        if (extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        /*
+         * To avoid racing with a CPU we are just kicking off.
+         * We do the final bit of preparation for the work in
+         * the target CPUs context.
+         */
+        async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
+                              RUN_ON_CPU_HOST_PTR(cpc));
+    }
+}
+
+static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vps_stop_mask)
+{
+    int vp;
+
+    for (vp = 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs = cpc->cpus[vp];
+
+        if (!extract64(vps_stop_mask, vp, 1)) {
+            continue;
+        }
+
+        if (!extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+        cpc->vps_running_mask &= ~BIT_ULL(vp);
+    }
+}
+
+static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
+                      unsigned size)
+{
+    RISCVCPCState *s = opaque;
+    int cpu_index, c;
+
+    for (c = 0; c < s->num_core; c++) {
+        cpu_index = c * s->num_hart +
+                    s->cluster_id * s->num_core * s->num_hart;
+        if (offset ==
+            CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+        if (offset ==
+            CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_stop_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+    }
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        break;
+    }
+
+    return;
+}
+
+static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RISCVCPCState *s = opaque;
+    int c;
+
+    for (c = 0; c < s->num_core; c++) {
+        if (offset ==
+            CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * CPC_CORE_REG_STRIDE) {
+            /* Return the state as U6. */
+            return CPC_Cx_STAT_CONF_SEQ_STATE_U6;
+        }
+    }
+
+    switch (offset) {
+    case CPC_CM_STAT_CONF_OFS:
+        return CPC_Cx_STAT_CONF_SEQ_STATE_U5;
+    case CPC_MTIME_REG_OFS:
+        return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                        NANOSECONDS_PER_SECOND);
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        return 0;
+    }
+}
+
+static const MemoryRegionOps cpc_ops = {
+    .read = cpc_read,
+    .write = cpc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 8,
+    },
+};
+
+static void riscv_cpc_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RISCVCPCState *s = RISCV_CPC(obj);
+    int i;
+
+    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "xmips-cpc",
+                          CPC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+
+    /* Allocate CPU array */
+    s->cpus = g_new0(CPUState *, CPC_MAX_VPS);
+
+    /* Create link properties for each possible CPU slot */
+    for (i = 0; i < CPC_MAX_VPS; i++) {
+        char *propname = g_strdup_printf("cpu[%d]", i);
+        object_property_add_link(obj, propname, TYPE_CPU,
+                                 (Object **)&s->cpus[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+        g_free(propname);
+    }
+}
+
+static void riscv_cpc_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPCState *s = RISCV_CPC(dev);
+    int i;
+
+    if (s->vps_start_running_mask & ~cpc_vp_run_mask(s)) {
+        error_setg(errp,
+                   "incorrect vps-start-running-mask 0x%" PRIx64
+                   " for num_vp = %d",
+                   s->vps_start_running_mask, s->num_vp);
+        return;
+    }
+
+    /* Verify that required CPUs have been linked */
+    for (i = 0; i < s->num_vp; i++) {
+        if (!s->cpus[i]) {
+            error_setg(errp, "CPU %d has not been linked", i);
+            return;
+        }
+    }
+}
+
+static void riscv_cpc_reset_hold(Object *obj, ResetType type)
+{
+    RISCVCPCState *s = RISCV_CPC(obj);
+
+    /* Reflect the fact that all VPs are halted on reset */
+    s->vps_running_mask = 0;
+
+    /* Put selected VPs into run state */
+    cpc_run_vp(s, s->vps_start_running_mask);
+}
+
+static const VMStateDescription vmstate_riscv_cpc = {
+    .name = "xmips-cpc",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(vps_running_mask, RISCVCPCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_cpc_properties[] = {
+    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
+    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
+    DEFINE_PROP_UINT64("vps-start-running-mask", RISCVCPCState,
+                       vps_start_running_mask, 0x1),
+};
+
+static void riscv_cpc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = riscv_cpc_realize;
+    rc->phases.hold = riscv_cpc_reset_hold;
+    dc->vmsd = &vmstate_riscv_cpc;
+    device_class_set_props(dc, riscv_cpc_properties);
+    dc->user_creatable = false;
+}
+
+static const TypeInfo riscv_cpc_info = {
+    .name          = TYPE_RISCV_CPC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RISCVCPCState),
+    .instance_init = riscv_cpc_init,
+    .class_init    = riscv_cpc_class_init,
+};
+
+static void riscv_cpc_register_types(void)
+{
+    type_register_static(&riscv_cpc_info);
+}
+
+type_init(riscv_cpc_register_types)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 222efb12fb..2b308ec9b0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -124,11 +124,15 @@ config MIPS_ITU
 config RISCV_MIPS_CMGCR
     bool
 
+config RISCV_MIPS_CPC
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
+    select RISCV_MIPS_CPC
 
 config MPS2_FPGAIO
     bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 489f0f3319..32b878e035 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -158,6 +158,7 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cp
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
 
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmgcr.c'))
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CPC', if_true: files('riscv_cpc.c'))
 
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
-- 
2.51.0


