Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7DDCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 18:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vItAI-0008RB-FK; Tue, 11 Nov 2025 13:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vIt8O-0006ZV-5n
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:30:28 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vIt8M-0007vw-1O
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:30:27 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34361025290so44895a91.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 10:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762885824; x=1763490624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ejXKSTaDA35niW7ha/aOEtXaqbxX1TLV58CYVMkvWw=;
 b=DDSNFO8J32BiEwM7EZRZtO57lpX5Hdy+vxHLWiKpjzk9nskdbRIS4uSM0UP2M8IzK4
 m180C6VACNcgo2pDro4OxxqBtT+a59wginDkz7k9zLqllF4sDU2GoWNYj7sywtWTsLea
 L01K0zDp3XCb+qQQHz7D/ZMJMqsDYDT+lWXDCZdCrnIngAhJrLxYx4epFzoF/MyLV9p8
 93b7ydr9T+J4FS16j2NrlBgnwKjYNB8bAB3t5POS9jY6Zp8GmXiBQFRdFGYEtn7Jflpc
 uJrqZaZ3FrncYBOW/VM7sywlDuoJwIp+1WEqhggkmhe7QBZTjNlPXOhTuAi02K3Z0R1l
 NWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762885824; x=1763490624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ejXKSTaDA35niW7ha/aOEtXaqbxX1TLV58CYVMkvWw=;
 b=rWULeKNEYM3o3lhoQynI1KoTmC2ZPqbGFAON0/c9Tufx+mo2PY/4c5Nd1ud7S8tDo8
 I+IoXsNbjDViByIF58CLS8GUyYd7FNs05ofo5xKiuRFvH+1V3XJgRZ1eyBysYuV1MHyX
 uhZ2NQHzxdXShTVH5gMrw+kvRDIpl2Sjvdl4m1Z56qzL4voTRB4Tzlqx+UWRUIctIkRU
 H5GKHJMXpFgx/8/T39+2E0r1v4QF5Vn/mMcDKaU6jPG/b58DczGOYGx8gVMhJEFzJL3M
 cMB+3urKBTnSGM48/O+bUfpEDYZtecS2SiuDRS159ldeRlxuhg4ofgQACmLjUif8P2Rp
 IrFA==
X-Gm-Message-State: AOJu0YzB+2bjjPaJ0LfjVRsbFC5Ng5DPBXUtlx7EFrKfBCNgsZNQwWET
 3zhhBjibEZNVN/sQuuoa4eV1Z3UsDyplyCVux7yNnRYREFMa4nPtYq6oBE7tQJ584aTaSIQMAlu
 Asxpdk4c=
X-Gm-Gg: ASbGncstw5GgOy7ZhhVbQvv0qg2NvufVKcAPMWqAzo+ZMeNIwoJCXwAyTCOJrlYAXK0
 JTPEtDPtmiSsWAP6UOn7WO1V4hK28zwOdnKZUQgSaSyNsOdyvqCwwUA0BlUezGpcWFCfnPPxPTp
 Ww/S3lwKHBdjN4482xvJDhVE/OI5+NWvO2JYhH116GMUMX7IYQaxFe7NKgFE6NUyND24E97n4OF
 QO0Hfa6bL5tIU5wvrJKtDDYW3iNP6mwX+ePWNCLH434Zan5DjNPa+zVD9jLzpWVpqiQi7XJgTv1
 otem0sQL2RN6eq0SirQhV6BaCRpZzQpZIM9/IuVAv8FK0ILXjPKy1IEphiRwCYEnmDi7obEEAYT
 qnXnYODwuUpaaZNYDr07qJ2UOaqs6FcQlADSjrfYGmMTc84aoubHQ4e3oFpTKO/bqB+SPWfYZ0W
 KqCAteXeCVZ3IF5cfiykYpJBceHXs=
X-Google-Smtp-Source: AGHT+IGWwLlNHCrTasvJmDQRp5/NBz/QZSmsHGa1z0Cyg+tdJ/j8zlYoTazvFnBYllTPaDDbJTS2tA==
X-Received: by 2002:a17:90b:3512:b0:330:7a32:3290 with SMTP id
 98e67ed59e1d1-343ddeefd91mr322726a91.37.1762885824157; 
 Tue, 11 Nov 2025 10:30:24 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3434c2ffdecsm15207419a91.2.2025.11.11.10.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 10:30:23 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v4 4/5] hw/riscv/server_platform_ref.c: add riscv-iommu-sys
Date: Tue, 11 Nov 2025 15:29:43 -0300
Message-ID: <20251111182944.2895892-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102b.google.com
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

Add an always present IOMMU platform device for the rvsp-ref board.

The IRQs being used are similar to what the 'virt' board is using: IRQs
36 to 39, one IRQ for queue.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 hw/riscv/Kconfig               |  1 +
 hw/riscv/server_platform_ref.c | 78 ++++++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 6a5085c7a5..4f8cbfe77f 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -82,6 +82,7 @@ config SERVER_PLATFORM_REF
     select RISCV_ACLINT
     select RISCV_APLIC
     select RISCV_IMSIC
+    select RISCV_IOMMU
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index ef2891a9d7..dc6caf72a6 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -31,6 +31,8 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
+#include "hw/riscv/iommu.h"
+#include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/riscv_imsic.h"
@@ -94,6 +96,7 @@ enum {
     RVSP_MROM,
     RVSP_RESET_SYSCON,
     RVSP_RTC,
+    RVSP_IOMMU_SYS,
     RVSP_ACLINT,
     RVSP_APLIC_M,
     RVSP_APLIC_S,
@@ -112,6 +115,7 @@ enum {
     RVSP_UART0_IRQ = 10,
     RVSP_RTC_IRQ = 11,
     RVSP_PCIE_IRQ = 0x20, /* 32 to 35 */
+    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */
 };
 
 /*
@@ -141,6 +145,7 @@ static const MemMapEntry rvsp_ref_memmap[] = {
     [RVSP_MROM] =           {     0x1000,        0xf000 },
     [RVSP_RESET_SYSCON] =   {   0x100000,        0x1000 },
     [RVSP_RTC] =            {   0x101000,        0x1000 },
+    [RVSP_IOMMU_SYS] =      {   0x102000,        0x1000 },
     [RVSP_ACLINT] =         {  0x2000000,       0x10000 },
     [RVSP_PCIE_PIO] =       {  0x3000000,       0x10000 },
     [RVSP_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSP_CPUS_MAX) },
@@ -638,9 +643,51 @@ static void create_fdt_sockets(RVSPMachineState *s, const MemMapEntry *memmap,
     riscv_socket_fdt_write_distance_matrix(ms);
 }
 
+static void create_fdt_iommu_sys(RVSPMachineState *s, uint32_t irq_chip,
+                                 uint32_t msi_phandle,
+                                 uint32_t *iommu_sys_phandle)
+{
+    const char comp[] = "riscv,iommu";
+    void *fdt = MACHINE(s)->fdt;
+    uint32_t iommu_phandle;
+    g_autofree char *iommu_node = NULL;
+    hwaddr addr = s->memmap[RVSP_IOMMU_SYS].base;
+    hwaddr size = s->memmap[RVSP_IOMMU_SYS].size;
+    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
+        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_CQ,
+        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_FQ,
+        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PM,
+        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PQ,
+    };
+
+    iommu_node = g_strdup_printf("/soc/iommu@%"HWADDR_PRIx,
+                                 s->memmap[RVSP_IOMMU_SYS].base);
+    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_add_subnode(fdt, iommu_node);
+
+    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
+    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
+
+    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
+                           addr >> 32, addr, size >> 32, size);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
+
+    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
+        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
+        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
+
+    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
+
+    *iommu_sys_phandle = iommu_phandle;
+}
+
 static void create_fdt_pcie(RVSPMachineState *s, const MemMapEntry *memmap,
                             uint32_t irq_pcie_phandle,
-                            uint32_t msi_pcie_phandle)
+                            uint32_t msi_pcie_phandle,
+                            uint32_t iommu_sys_phandle)
 {
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
@@ -675,6 +722,10 @@ static void create_fdt_pcie(RVSPMachineState *s, const MemMapEntry *memmap,
            memmap[RVSP_PCIE_MMIO_HIGH].size);
 
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
+
+    qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
+                           0, iommu_sys_phandle, 0, 0, 0,
+                           iommu_sys_phandle, 0, 0xffff);
 }
 
 static void create_fdt_reset(RVSPMachineState *s, const MemMapEntry *memmap,
@@ -768,12 +819,16 @@ static void create_fdt_flash(RVSPMachineState *s, const MemMapEntry *memmap)
 static void finalize_fdt(RVSPMachineState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
-    uint32_t irq_pcie_phandle = 1;
+    uint32_t irq_pcie_phandle = 1, iommu_sys_phandle;
 
     create_fdt_sockets(s, rvsp_ref_memmap, &phandle, &irq_mmio_phandle,
                        &irq_pcie_phandle, &msi_pcie_phandle);
 
-    create_fdt_pcie(s, rvsp_ref_memmap, irq_pcie_phandle, msi_pcie_phandle);
+    create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
+                         &iommu_sys_phandle);
+
+    create_fdt_pcie(s, rvsp_ref_memmap, irq_pcie_phandle,
+                    msi_pcie_phandle, iommu_sys_phandle);
 
     create_fdt_reset(s, rvsp_ref_memmap, &phandle);
 
@@ -1078,7 +1133,7 @@ static void rvsp_ref_machine_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     MemoryRegion *reset_syscon_io = g_new(MemoryRegion, 1);
-    DeviceState *mmio_irqchip, *pcie_irqchip;
+    DeviceState *mmio_irqchip, *pcie_irqchip, *iommu_sys;
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
 
@@ -1196,6 +1251,21 @@ static void rvsp_ref_machine_init(MachineState *machine)
         create_fdt(s, memmap);
     }
 
+    iommu_sys = qdev_new(TYPE_RISCV_IOMMU_SYS);
+    object_property_set_uint(OBJECT(iommu_sys), "addr",
+                             s->memmap[RVSP_IOMMU_SYS].base,
+                             &error_fatal);
+
+    object_property_set_uint(OBJECT(iommu_sys), "base-irq",
+                             IOMMU_SYS_IRQ,
+                             &error_fatal);
+
+    object_property_set_link(OBJECT(iommu_sys), "irqchip",
+                             OBJECT(mmio_irqchip),
+                             &error_fatal);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
+
     s->machine_done.notify = rvsp_ref_machine_done;
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
-- 
2.51.1


