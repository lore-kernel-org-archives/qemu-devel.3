Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C440CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn3J-0003dL-0q; Thu, 23 Oct 2025 00:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3H-0003d8-6i
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:51 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3E-0001Mr-FA
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:35:50 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so276199b3a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194145; x=1761798945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2N1o/4PGfY8Zaf9Rn/zroA3qIDhjCQByDWV9IpdZRE=;
 b=hMB3KyW9mKJzhaCpCfOoQJC232TorAPkYjjEjIyzoeOn6Kuj7HacTrf89/wptBlxWW
 QndP5JLXZVENFLg+6In7vPU5oOlCgy6+8kap9kRLS653GZ6jIkNV9w9wJ2nHBNKjoXGH
 ivANTrYfQ5hgfu4n81wUCIQLmlgwEoCiII4/6Pi48rUHTAIO44EU2816fHdRyjbIY/fW
 5NtUDAAuvJL0SQ17/QG0FUCjTQFItO3NXo4yoaKXRJhQQL1CFDA/yJfLiCTeIZ1+wmmu
 qaSvKR+Wkuq2bmoeRI+X7ShKDgDSCoTF2F9Id6FG7iY/RwPfBUj6b7An8YI3AlSv5c1U
 FVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194145; x=1761798945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2N1o/4PGfY8Zaf9Rn/zroA3qIDhjCQByDWV9IpdZRE=;
 b=hu4vyr4lPrX549d3P554A2lr7T3wYXKfueRJ9A5dKNECeKUgtOvZF5B6d5xlMYTYce
 0S3hO2rQGyCdb1F2Eh22AVnhCTS79vzltE/E0t1Ucml+3QOwGa1P2oKLAq/On9ipgxud
 SiePvEGuIZPtDrnwkNyWqxIylcRcYEw1DIwVHLWuTXByv2/9ingi1+MGJrfQSHrPT0Qe
 pomtZNFPuSR9NtXBJ7Hi5cEniQDBmeANeZaouZ4JnFGSQJO7TMOYFws25tJSKoV2VWZH
 wfpVHcOp7IOGu44BFwx0dZbF5/AA1EKJse7ja1Dg74vZFt8Up7zgXkNNNGYh1NdEGxm1
 OpuQ==
X-Gm-Message-State: AOJu0YzXQhQMNBIzE23oR0EnT4aOsAu1c0YWpq7LQAg8O0T6cUOnPeL5
 0fzZbqVyJaExgRzwa4hqYPK2kTe5Yso+iiC0jKcU+ELErCPEME1i0vos2efzxQ==
X-Gm-Gg: ASbGncuw4YD6Qgl5Y7NRNr2NBriRaC6mP2jl2ywTWzHwe+1G9aIJW9N6WxRCQGLfXQY
 YwG9Ni4Q67BgWXaxu5Cvc9xBgB0OU7YIL8AXixX2/UDOvGzi61F/Z9uhS0JRxytekmmLVD1U25c
 Ff5b/SnoPVufmxoBvQhScDcAlV2mCuTxolm7xQOTUJEScqLbrgmogOF4oFJoH6ccjz67nKe7jCV
 rIxGIFeIoU1SIXizyhTwvCA3lGrhtR6PD421SffS9ouyN5Mmhk2r1gCQCgjwf/PFQaIY82eD0GM
 clEkXBIgL/hNhsp1z4FZXUJUUbUvpYY9FsvnGMSD7/Fm7nOp9kDZeBLaINXzn/Qh+6KSPynHA7c
 V+qH2TnpELsJktFrbviUNFJyoAC0onvOGLpwanXvjew/oW7poDoZxYUByqkXr/8aE5NKUnSRbV5
 aGWi/JhwtTGdaNghv+vrt2xh0FBMfRxStuUNjJ3L/24COiqhqw7Oo02TFf1hy4mBCZXf3iQVmGx
 Pp6rwo2XSPlyJm4C+Y=
X-Google-Smtp-Source: AGHT+IFd1I+Iy2HIndUDxfhaQP63+yTfl08fH00q+aDmDX366ENuFxWHKAe5ybmyukJOU5Jxy8TR6Q==
X-Received: by 2002:a17:902:e80e:b0:293:623:3260 with SMTP id
 d9443c01a7336-2930623372dmr47919345ad.57.1761194144989; 
 Wed, 22 Oct 2025 21:35:44 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:35:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/37] hw/misc: Add RISC-V CMGCR device implementation
Date: Thu, 23 Oct 2025 14:35:09 +1000
Message-ID: <20251023043520.1777130-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

Add RISC-V implementation of the Coherent Manager Global Control
Register (CMGCR) device. It is based on the existing MIPS CMGCR
implementation but adapted for RISC-V systems.

The CMGCR device provides global system control for multi-core
configurations in RISC-V systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20251018154522.745788-9-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/misc/riscv_cmgcr.h |  50 +++++++
 hw/misc/riscv_cmgcr.c         | 248 ++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig               |   9 ++
 hw/misc/meson.build           |   2 +
 4 files changed, 309 insertions(+)
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 hw/misc/riscv_cmgcr.c

diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..c57d4ada1c
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CMGCR_H
+#define RISCV_CMGCR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_GCR "riscv-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
+
+#define GCR_BASE_ADDR           0x1fb80000ULL
+#define GCR_MAX_VPS             256
+
+typedef struct RISCVGCRVPState RISCVGCRVPState;
+struct RISCVGCRVPState {
+    uint64_t reset_base;
+};
+
+typedef struct RISCVGCRState RISCVGCRState;
+struct RISCVGCRState {
+    SysBusDevice parent_obj;
+
+    int32_t gcr_rev;
+    uint32_t cluster_id;
+    uint32_t num_vps;
+    uint32_t num_hart;
+    uint32_t num_core;
+    hwaddr gcr_base;
+    MemoryRegion iomem;
+    MemoryRegion *cpc_mr;
+
+    uint64_t cpc_base;
+
+    /* VP Local/Other Registers */
+    RISCVGCRVPState *vps;
+};
+
+#endif /* RISCV_CMGCR_H */
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..8e7b86867a
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,248 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/qdev-properties.h"
+
+#include "cpu.h"
+
+#define CM_RESET_VEC 0x1FC00000
+#define GCR_ADDRSPACE_SZ        0x8000
+
+/* Offsets to register blocks */
+#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
+#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
+#define RISCV_CORE_REG_STRIDE 0x100 /* Stride between core-specific registers */
+
+/* Global Control Block Register Map */
+#define GCR_CONFIG_OFS      0x0000
+#define GCR_BASE_OFS        0x0008
+#define GCR_REV_OFS         0x0030
+#define GCR_CPC_STATUS_OFS  0x00F0
+#define GCR_L2_CONFIG_OFS   0x0130
+
+/* GCR_L2_CONFIG register fields */
+#define GCR_L2_CONFIG_BYPASS_SHF    20
+#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
+
+/* GCR_BASE register fields */
+#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
+
+/* GCR_CPC_BASE register fields */
+#define GCR_CPC_BASE_CPCEN_MSK   1
+#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
+#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MSK)
+
+/* GCR_CL_RESETBASE_OFS register fields */
+#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
+#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
+
+static inline bool is_cpc_connected(RISCVGCRState *s)
+{
+    return s->cpc_mr != NULL;
+}
+
+static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
+{
+    if (is_cpc_connected(gcr)) {
+        gcr->cpc_base = val & GCR_CPC_BASE_MSK;
+        memory_region_transaction_begin();
+        memory_region_set_address(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK);
+        memory_region_set_enabled(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
+        memory_region_transaction_commit();
+    }
+}
+
+static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
+{
+    gcr->gcr_base = val & GCR_BASE_GCRBASE_MSK;
+    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
+
+    /*
+     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+     * cpc automatically.
+     */
+    update_cpc_base(gcr, val + 0x8001);
+}
+
+/* Read GCR registers */
+static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RISCVGCRState *gcr = (RISCVGCRState *) opaque;
+
+    switch (addr) {
+    /* Global Control Block Register */
+    case GCR_CONFIG_OFS:
+        /* Set PCORES to 0 */
+        return 0;
+    case GCR_BASE_OFS:
+        return gcr->gcr_base;
+    case GCR_REV_OFS:
+        return gcr->gcr_rev;
+    case GCR_CPC_STATUS_OFS:
+        return is_cpc_connected(gcr);
+    case GCR_L2_CONFIG_OFS:
+        /* L2 BYPASS */
+        return GCR_L2_CONFIG_BYPASS_MSK;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_PRIx
+                      "\n", size, addr);
+    }
+    return 0;
+}
+
+static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
+{
+    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
+}
+
+/* Write GCR registers */
+static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
+{
+    RISCVGCRState *gcr = (RISCVGCRState *)opaque;
+    RISCVGCRVPState *current_vps;
+    int cpu_index, c, h;
+
+    for (c = 0; c < gcr->num_core; c++) {
+        for (h = 0; h < gcr->num_hart; h++) {
+            if (addr == RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h * 8) {
+                cpu_index = c * gcr->num_hart + h;
+                current_vps = &gcr->vps[cpu_index];
+                current_vps->reset_base = data & GCR_CL_RESET_BASE_MSK;
+                cpu_set_exception_base(cpu_index + gcr->cluster_id *
+                                       gcr->num_core * gcr->num_hart,
+                                       get_exception_base(current_vps));
+                return;
+            }
+        }
+    }
+
+    switch (addr) {
+    case GCR_BASE_OFS:
+        update_gcr_base(gcr, data);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR_PRIx
+                      " 0x%" PRIx64 "\n", size, addr, data);
+        break;
+    }
+}
+
+static const MemoryRegionOps gcr_ops = {
+    .read = gcr_read,
+    .write = gcr_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .max_access_size = 8,
+    },
+};
+
+static void riscv_gcr_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RISCVGCRState *s = RISCV_GCR(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
+                          "riscv-gcr", GCR_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void riscv_gcr_reset(DeviceState *dev)
+{
+    RISCVGCRState *s = RISCV_GCR(dev);
+    int i;
+
+    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically. */
+    update_cpc_base(s, s->gcr_base + 0x8001);
+
+    for (i = 0; i < s->num_vps; i++) {
+        s->vps[i].reset_base = CM_RESET_VEC & GCR_CL_RESET_BASE_MSK;
+        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
+    }
+}
+
+static const VMStateDescription vmstate_riscv_gcr = {
+    .name = "riscv-gcr",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(cpc_base, RISCVGCRState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_gcr_properties[] = {
+    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
+    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
+    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
+    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADDR),
+    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void riscv_gcr_realize(DeviceState *dev, Error **errp)
+{
+    RISCVGCRState *s = RISCV_GCR(dev);
+
+    /* Validate num_vps */
+    if (s->num_vps == 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vps > GCR_MAX_VPS) {
+        error_setg(errp, "num-vp cannot exceed %d", GCR_MAX_VPS);
+        return;
+    }
+
+    /* Create local set of registers for each VP */
+    s->vps = g_new(RISCVGCRVPState, s->num_vps);
+}
+
+static void riscv_gcr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_props(dc, riscv_gcr_properties);
+    dc->vmsd = &vmstate_riscv_gcr;
+    device_class_set_legacy_reset(dc, riscv_gcr_reset);
+    dc->realize = riscv_gcr_realize;
+}
+
+static const TypeInfo riscv_gcr_info = {
+    .name          = TYPE_RISCV_GCR,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RISCVGCRState),
+    .instance_init = riscv_gcr_init,
+    .class_init    = riscv_gcr_class_init,
+};
+
+static void riscv_gcr_register_types(void)
+{
+    type_register_static(&riscv_gcr_info);
+}
+
+type_init(riscv_gcr_register_types)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..222efb12fb 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -121,6 +121,15 @@ config MIPS_ITU
     bool
     depends on TCG
 
+config RISCV_MIPS_CMGCR
+    bool
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_MIPS_CMGCR
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..489f0f3319 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,6 +157,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
 
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmgcr.c'))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
-- 
2.51.0


