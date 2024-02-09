Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30D8C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOfs-0000jI-Gh; Fri, 09 Feb 2024 06:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOd3-0006pa-Jm
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:11 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOd0-0000qp-MB
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:08 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e09a890341so16199b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476465; x=1708081265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fa9fGLKE6Wdf2yfyW5vw/ZmpZmU1QQLUny+iEdmohSM=;
 b=Z9EZQvmBwC1AT7IpEzBgpQBNt+tgRG4LfQjnjnLInXVKodJHRksAFWb5nyo++RDkcf
 LSvLKtTEptkd5ZEiqcaE/rQoh6MgY9GME8t6hB/ccrca/rqsx9RIGmxJN57cS8CQP0i7
 /ndcFNnKqU6v++mrrBNjmuS+FtkBwuRUOri3hE0BBD+M/Ytdiu59GWXsodeiuUapH9YD
 8N64rkF9JCZk0w7Egtjy+bhYgVFhuaHytNbIdzFLoJqJkojni/GylXhLgRswrArnJPjd
 vTLkL6VI6i1ZyuuldVIWRRJXGWQ0r/l61CA//uWxuyl0kDq2rLDjaEuKYXSVhr1aG0rZ
 xhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476465; x=1708081265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fa9fGLKE6Wdf2yfyW5vw/ZmpZmU1QQLUny+iEdmohSM=;
 b=gHt+ZZOfsycMjYoZcIpXhwNLwFKke45lvnsXEoFn63gxmukKsBpW2rqACN96L1JKvb
 Ygyxpxu63yWPCMxs6CsSQSnXzKYWeoNAG4qMqVxztqLj+XYW2Egh6IEXRb4sW5viWr3j
 BMmjs9YgfSdQ3r+yljeqKfpbsdHI6A7s3m8CdxRW0au9FLSkvoOfEdhxt1J3BBa1VHdb
 fjsrpkcZhFBoaV8vsZEA1E0j6NOEQ8THVhgIYVOHnr8jm4hv/FQ2CfiFAXbNrrbSvBpK
 O8yXiGAdjQ8GUh+rwExu7WW4LhoT7EAMohL7JNg/Amt+tASATv1oJ4Cfs1yk5KCf2KY4
 h8sg==
X-Gm-Message-State: AOJu0YzS55Iq62Z9qyfG6fUqzUs+cIawFgNdUzjtOjLRzFhQl9QGcjT8
 g0avzf4sFaCQhZf+P10cCa4aqW0SOjlnpDU9R9WiidyCFw14BJOgxofKyRYoXzIkRA==
X-Google-Smtp-Source: AGHT+IFvSX/puJkn+hu3a0k9/n+nWp1s/b2L+G3tCIAnLVu2zPrmzH0+qJQzBtqT877NhCvW4Q7bow==
X-Received: by 2002:a05:6a00:9295:b0:6e0:268c:316 with SMTP id
 jw21-20020a056a00929500b006e0268c0316mr1433320pfb.25.1707476464972; 
 Fri, 09 Feb 2024 03:01:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVh/T4Xlr4pzFV3WodIukM73AdCYZpNLsAa8u1LDrtl6yUyQOpy0FzmX2zsdTlwSUGwytULCEACzVddZCyodEKcRgewMhBbnSZAWEzOxKVGf4LQCYTDLCY6Sqz0bNegiEv2SRI=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 49/61] hw/riscv/virt.c: use g_autofree in create_fdt_*
Date: Fri,  9 Feb 2024 20:58:01 +1000
Message-ID: <20240209105813.3590056-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We have a lot of cases where a char or an uint32_t pointer is used once
to alloc a string/array, read/written during the function, and then
g_free() at the end. There's no pointer re-use - a single alloc, a
single g_free().

Use 'g_autofree' to avoid the g_free() calls.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240122221529.86562-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 78 ++++++++++++++-----------------------------------
 1 file changed, 22 insertions(+), 56 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 710fbbda2c..1c257e89d2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -285,7 +285,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
 static void create_fdt_socket_memory(RISCVVirtState *s,
                                      const MemMapEntry *memmap, int socket)
 {
-    char *mem_name;
+    g_autofree char *mem_name = NULL;
     uint64_t addr, size;
     MachineState *ms = MACHINE(s);
 
@@ -297,7 +297,6 @@ static void create_fdt_socket_memory(RISCVVirtState *s,
         addr >> 32, addr, size >> 32, size);
     qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
     riscv_socket_fdt_write_id(ms, mem_name, socket);
-    g_free(mem_name);
 }
 
 static void create_fdt_socket_clint(RISCVVirtState *s,
@@ -305,8 +304,8 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
                                     uint32_t *intc_phandles)
 {
     int cpu;
-    char *clint_name;
-    uint32_t *clint_cells;
+    g_autofree char *clint_name = NULL;
+    g_autofree uint32_t *clint_cells = NULL;
     unsigned long clint_addr;
     MachineState *ms = MACHINE(s);
     static const char * const clint_compat[2] = {
@@ -333,9 +332,6 @@ static void create_fdt_socket_clint(RISCVVirtState *s,
     qemu_fdt_setprop(ms->fdt, clint_name, "interrupts-extended",
         clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
     riscv_socket_fdt_write_id(ms, clint_name, socket);
-    g_free(clint_name);
-
-    g_free(clint_cells);
 }
 
 static void create_fdt_socket_aclint(RISCVVirtState *s,
@@ -346,9 +342,9 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
     char *name;
     unsigned long addr, size;
     uint32_t aclint_cells_size;
-    uint32_t *aclint_mswi_cells;
-    uint32_t *aclint_sswi_cells;
-    uint32_t *aclint_mtimer_cells;
+    g_autofree uint32_t *aclint_mswi_cells = NULL;
+    g_autofree uint32_t *aclint_sswi_cells = NULL;
+    g_autofree uint32_t *aclint_mtimer_cells = NULL;
     MachineState *ms = MACHINE(s);
 
     aclint_mswi_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
@@ -420,10 +416,6 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
         riscv_socket_fdt_write_id(ms, name, socket);
         g_free(name);
     }
-
-    g_free(aclint_mswi_cells);
-    g_free(aclint_mtimer_cells);
-    g_free(aclint_sswi_cells);
 }
 
 static void create_fdt_socket_plic(RISCVVirtState *s,
@@ -432,8 +424,8 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
                                    uint32_t *plic_phandles)
 {
     int cpu;
-    char *plic_name;
-    uint32_t *plic_cells;
+    g_autofree char *plic_name = NULL;
+    g_autofree uint32_t *plic_cells;
     unsigned long plic_addr;
     MachineState *ms = MACHINE(s);
     static const char * const plic_compat[2] = {
@@ -493,10 +485,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
                                        memmap[VIRT_PLATFORM_BUS].size,
                                        VIRT_PLATFORM_BUS_IRQ);
     }
-
-    g_free(plic_name);
-
-    g_free(plic_cells);
 }
 
 uint32_t imsic_num_bits(uint32_t count)
@@ -515,11 +503,12 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
                                  bool m_mode, uint32_t imsic_guest_bits)
 {
     int cpu, socket;
-    char *imsic_name;
+    g_autofree char *imsic_name = NULL;
     MachineState *ms = MACHINE(s);
     int socket_count = riscv_socket_count(ms);
-    uint32_t imsic_max_hart_per_socket;
-    uint32_t *imsic_cells, *imsic_regs, imsic_addr, imsic_size;
+    uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
+    g_autofree uint32_t *imsic_cells = NULL;
+    g_autofree uint32_t *imsic_regs = NULL;
 
     imsic_cells = g_new0(uint32_t, ms->smp.cpus * 2);
     imsic_regs = g_new0(uint32_t, socket_count * 4);
@@ -571,10 +560,6 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
                               IMSIC_MMIO_GROUP_MIN_SHIFT);
     }
     qemu_fdt_setprop_cell(ms->fdt, imsic_name, "phandle", msi_phandle);
-
-    g_free(imsic_name);
-    g_free(imsic_regs);
-    g_free(imsic_cells);
 }
 
 static void create_fdt_imsic(RISCVVirtState *s, const MemMapEntry *memmap,
@@ -606,12 +591,10 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
                                  bool m_mode, int num_harts)
 {
     int cpu;
-    char *aplic_name;
-    uint32_t *aplic_cells;
+    g_autofree char *aplic_name = NULL;
+    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
     MachineState *ms = MACHINE(s);
 
-    aplic_cells = g_new0(uint32_t, num_harts * 2);
-
     for (cpu = 0; cpu < num_harts; cpu++) {
         aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
         aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
@@ -646,9 +629,6 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
 
     riscv_socket_fdt_write_id(ms, aplic_name, socket);
     qemu_fdt_setprop_cell(ms->fdt, aplic_name, "phandle", aplic_phandle);
-
-    g_free(aplic_name);
-    g_free(aplic_cells);
 }
 
 static void create_fdt_socket_aplic(RISCVVirtState *s,
@@ -660,7 +640,7 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
                                     uint32_t *aplic_phandles,
                                     int num_harts)
 {
-    char *aplic_name;
+    g_autofree char *aplic_name = NULL;
     unsigned long aplic_addr;
     MachineState *ms = MACHINE(s);
     uint32_t aplic_m_phandle, aplic_s_phandle;
@@ -695,23 +675,18 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
                                        VIRT_PLATFORM_BUS_IRQ);
     }
 
-    g_free(aplic_name);
-
     aplic_phandles[socket] = aplic_s_phandle;
 }
 
 static void create_fdt_pmu(RISCVVirtState *s)
 {
-    char *pmu_name;
+    g_autofree char *pmu_name = g_strdup_printf("/pmu");
     MachineState *ms = MACHINE(s);
     RISCVCPU hart = s->soc[0].harts[0];
 
-    pmu_name = g_strdup_printf("/pmu");
     qemu_fdt_add_subnode(ms->fdt, pmu_name);
     qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
     riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
-
-    g_free(pmu_name);
 }
 
 static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
@@ -847,7 +822,7 @@ static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
                             uint32_t irq_pcie_phandle,
                             uint32_t msi_pcie_phandle)
 {
-    char *name;
+    g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
     name = g_strdup_printf("/soc/pci@%lx",
@@ -881,7 +856,6 @@ static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
         2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
 
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
-    g_free(name);
 }
 
 static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memmap,
@@ -928,7 +902,7 @@ static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memmap,
 static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
                             uint32_t irq_mmio_phandle)
 {
-    char *name;
+    g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
     name = g_strdup_printf("/soc/serial@%lx", (long)memmap[VIRT_UART0].base);
@@ -946,13 +920,12 @@ static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
     }
 
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
-    g_free(name);
 }
 
 static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
                            uint32_t irq_mmio_phandle)
 {
-    char *name;
+    g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
     name = g_strdup_printf("/soc/rtc@%lx", (long)memmap[VIRT_RTC].base);
@@ -968,41 +941,36 @@ static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
     } else {
         qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", RTC_IRQ, 0x4);
     }
-    g_free(name);
 }
 
 static void create_fdt_flash(RISCVVirtState *s, const MemMapEntry *memmap)
 {
-    char *name;
     MachineState *ms = MACHINE(s);
     hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
+    g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
 
-    name = g_strdup_printf("/flash@%" PRIx64, flashbase);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible", "cfi-flash");
     qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
                                  2, flashbase, 2, flashsize,
                                  2, flashbase + flashsize, 2, flashsize);
     qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
-    g_free(name);
 }
 
 static void create_fdt_fw_cfg(RISCVVirtState *s, const MemMapEntry *memmap)
 {
-    char *nodename;
     MachineState *ms = MACHINE(s);
     hwaddr base = memmap[VIRT_FW_CFG].base;
     hwaddr size = memmap[VIRT_FW_CFG].size;
+    g_autofree char *nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
 
-    nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
     qemu_fdt_add_subnode(ms->fdt, nodename);
     qemu_fdt_setprop_string(ms->fdt, nodename,
                             "compatible", "qemu,fw-cfg-mmio");
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base, 2, size);
     qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
-    g_free(nodename);
 }
 
 static void finalize_fdt(RISCVVirtState *s)
@@ -1149,7 +1117,7 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
                                      int base_hartid, int hart_count)
 {
     DeviceState *ret;
-    char *plic_hart_config;
+    g_autofree char *plic_hart_config = NULL;
 
     /* Per-socket PLIC hart topology configuration string */
     plic_hart_config = riscv_plic_hart_config_string(hart_count);
@@ -1168,8 +1136,6 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
             VIRT_PLIC_CONTEXT_STRIDE,
             memmap[VIRT_PLIC].size);
 
-    g_free(plic_hart_config);
-
     return ret;
 }
 
-- 
2.43.0


