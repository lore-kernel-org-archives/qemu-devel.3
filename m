Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74142606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=KHJHLcof
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLvKE-0007VZ-Uq; Wed, 28 Oct 2026 00:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvJr-0007Sr-Bl
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:31:28 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvJm-0001bX-27
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:31:21 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ab3f899c8aso79602a91.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 21:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793161876; x=1793766676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H/BezYbKGtKPmI0AKJzZPJ0PhsQqP58AHnLNWt5l9nU=;
 b=KHJHLcofkA613kPx8HOmkhLlVj/XepagU1dZ/G2kCAP0CZk++ab6s7Vp3SJPjNZL0R
 44nKoZBJDNo5XgkijOGhcOdAy96fUsLRWWrEqJEYeRyDuAc9Mq3k9gTqeO2cStjs2nEy
 1rMXmC+TkCFef1QCxp+zLvVbzmzHO2qnwKKwaCLGm5F46bX9ZtkNSQv2uxaK9NX7Qiw+
 /iXJS1sRWMtzQqlwF/QY/5psmxOZZAtHS+EYJ5j6xdRQ0MMPLWFPOD3PPXbVn6emPzz9
 7b9qMggug+2ewh5+x9XJ9L1yNsChgC8NaJpk+wBs7+GuO38GBued/SDPEWrK6ITeo50J
 20DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793161876; x=1793766676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H/BezYbKGtKPmI0AKJzZPJ0PhsQqP58AHnLNWt5l9nU=;
 b=ABdIMDevixN/Weivbpx6yALisznuoTR6InvQ1YbjoMZzUNBWyDB9F/qeGw4/oAaNs7
 cTs4j1rtF6miAsbj7nn9IBuHlwGS3fZS5s58qHIC8BxvURoCCgLs5qgPQ1sw2sgBRV8g
 SXrO7TFSudlWrFqHYyVvqkB+0y9Aow2VVJf6YOmomp1BZiKzDy7rH4gom/M7LInyI1vR
 +5gF8t/UQmYg2VxFcsSoqbe/1jiZ8BXBs5F1gAf2sva4m85zpsvHkgLgXudoZTh9/85Y
 SvhFOgM4OoqMBHhNT41u/6BNsi/m3whpSe9ggnpCv8bmAY+Jlgo3fwxzA0hDEpfxH8ip
 A/iQ==
X-Gm-Message-State: AFq9FYJaOVoQYWGJPI5+b2RM6043jbvDgN4MTCP820QLzBlu/TKQyI+H
 dxBqfN351NRVDKH8Ts9NATqcWu7O504Trd96ESdB24gHBJ52+IA+Ubp3uokicbjtixGtkdhU5hK
 AHfaoDiw=
X-Gm-Gg: AYBFou2Rv09kx7rrfzzuIqj0/Ecx7bKG0m+eiYIVlWxz7n5pVBXwkU2MDc60xfs0j29
 3Xr+ByyUawt4m+lE78ETaV7smuEGO4f7Zojv+569HGeWcE7Uar53BOoOX9Yw+Fkb45IXxS9LpvA
 t9dSGSvX9owYb4r8nynKizGJCHzPwaMEiMM5DKYJQW6W+A8PfVLGhjqJGoIioKz224ook57se66
 UyOpIZFlPLESQbiKXdJlLQhk0rWHR1djA4Fs+Fz7OkOf1uE1oE6zng7WPIMiGEQ4kdg8hHAhBBV
 Cqu2017n/iUjj+byCu3dxYmi6YPoD3IrCBz69omx6/NtdBtpGIl0Tus0hPtEkKegsAJ59ozGa/2
 oi1WulvPPFnAXRmhKCPfryS//LklT+m9UCgkuFz9PXoOws594f51/lYdPrpK7jDawRqFMLKVzsn
 quYPUw67syPEfVoOk0RlN4mejayGDZPtyufpRauT3rxS2PtIa7LYxosJFyVm2GeBviOlyixbbP9
 WcgUeghJioHyge1pNUFVlLklTrOjS4M2S4MfUpgTrdDnPcb+AXAEwALrE1YvArXu+41EtCLmjou
 ymYLt10aCD5y/QWdSec2P3gQd8ODZ4W7VRFHKKrfG2tk+7kjsIF5Ct31/IDvYzaZ8u7uZ4VMb2c
 EOA==
X-Received: by 2002:a17:90b:4b89:b0:3ad:a84b:df1e with SMTP id
 98e67ed59e1d1-3ae57e15ffemr1546543a91.1.1793161876305; 
 Tue, 27 Oct 2026 21:31:16 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a5d45a8sm1024470a91.17.2026.10.27.21.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 21:31:15 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 01/10] hw/riscv/atlantis: Update fdt functions to take
 generic parameters
Date: Wed, 28 Oct 2026 14:30:50 +1000
Message-ID: <20261028043059.600498-2-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028043059.600498-1-portias@oss.tenstorrent.com>
References: <20261028043059.600498-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x102e.google.com
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
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_SPF_HELO_TEMPERROR,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently the Atlantis fdt functions take TTAtlantisSoCState as
parameter and derive all needed values from there. This doesn't easily
allow for using these functions once the system has multiple memmaps and
hart arrays. This change updates the fdt functions to take more generic
parameters. This is in preparation for adding more hart arrays of
different clusters to the Atlantis SoC.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/tt_atlantis.c | 83 ++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 311de64eda..25745998ad 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -89,18 +89,18 @@ static uint32_t next_phandle(void)
     return fdt_phandle++;
 }
 
-static void create_fdt_memory(void *fdt, TTAtlantisSoCState *s)
+static void create_fdt_memory(void *fdt, const MemMapEntry *memmap,
+                              hwaddr ram_size)
 {
-    hwaddr ram_size = memory_region_size(s->dram);
     hwaddr size_lo = ram_size;
     hwaddr size_hi = 0;
 
-    if (size_lo > s->memmap[TT_ATL_DDR_LO].size) {
-        size_lo = s->memmap[TT_ATL_DDR_LO].size;
+    if (size_lo > memmap[TT_ATL_DDR_LO].size) {
+        size_lo = memmap[TT_ATL_DDR_LO].size;
         size_hi = ram_size - size_lo;
     }
 
-    riscv_create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base,
+    riscv_create_fdt_socket_memory(fdt, memmap[TT_ATL_DDR_LO].base,
                                    size_lo, 0, false);
     if (size_hi) {
         /*
@@ -109,12 +109,13 @@ static void create_fdt_memory(void *fdt, TTAtlantisSoCState *s)
          * (or good reason) to describe that aliasing 2GB with DT?
          */
         riscv_create_fdt_socket_memory(fdt,
-                                       s->memmap[TT_ATL_DDR_HI].base + size_lo,
+                                       memmap[TT_ATL_DDR_HI].base + size_lo,
                                        size_hi, 0, false);
     }
 }
 
-static void create_fdt_aclint(void *fdt, TTAtlantisSoCState *s,
+static void create_fdt_aclint(void *fdt, RISCVHartArrayState *harts,
+                              const MemMapEntry *memmap,
                               uint32_t *intc_phandles)
 {
     g_autofree char *name = NULL;
@@ -122,15 +123,15 @@ static void create_fdt_aclint(void *fdt, TTAtlantisSoCState *s,
     uint32_t aclint_cells_size;
     hwaddr addr;
 
-    aclint_mtimer_cells = g_new0(uint32_t, s->cpus.num_harts * 2);
+    aclint_mtimer_cells = g_new0(uint32_t, harts->num_harts * 2);
 
-    for (int cpu = 0; cpu < s->cpus.num_harts; cpu++) {
+    for (int cpu = 0; cpu < harts->num_harts; cpu++) {
         aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
         aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
     }
-    aclint_cells_size = s->cpus.num_harts * sizeof(uint32_t) * 2;
+    aclint_cells_size = harts->num_harts * sizeof(uint32_t) * 2;
 
-    addr = s->memmap[TT_ATL_ACLINT].base;
+    addr = memmap[TT_ATL_ACLINT].base;
 
     name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIX, addr);
     qemu_fdt_add_subnode(fdt, name);
@@ -216,52 +217,53 @@ static void create_fdt_one_aplic(void *fdt,
     qemu_fdt_setprop_cell(fdt, name, "phandle", aplic_phandle);
 }
 
-static void create_fdt_pmu(void *fdt, TTAtlantisSoCState *s)
+static void create_fdt_pmu(void *fdt, RISCVHartArrayState *harts)
 {
     char pmu_name[] = "/pmu";
-    RISCVCPU *hart = &s->cpus.harts[0];
+    RISCVCPU *hart = &harts->harts[0];
 
     qemu_fdt_add_subnode(fdt, pmu_name);
     qemu_fdt_setprop_string(fdt, pmu_name, "compatible", "riscv,pmu");
     riscv_pmu_generate_fdt_node(fdt, hart->pmu_avail_ctrs, pmu_name);
 }
 
-static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
+static void create_fdt_cpu(void *fdt, RISCVHartArrayState *harts,
+                           const MemMapEntry *memmap,
                            uint32_t aplic_s_phandle,
                            uint32_t imsic_s_phandle)
 {
-    g_autofree uint32_t *intc_phandles = g_new0(uint32_t, s->cpus.num_harts);
-    int num_harts = s->cpus.num_harts;
+    int num_harts = harts->num_harts;
+    g_autofree uint32_t *intc_phandles = g_new0(uint32_t, num_harts);
 
     riscv_fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
 
-    riscv_create_fdt_socket_cpus(fdt, s->cpus.harts, 0, num_harts,
-                                 s->cpus.hartid_base, &fdt_phandle,
+    riscv_create_fdt_socket_cpus(fdt, harts->harts, 0, num_harts,
+                                 harts->hartid_base, &fdt_phandle,
                                  intc_phandles, false, false);
 
-    create_fdt_aclint(fdt, s, intc_phandles);
+    create_fdt_aclint(fdt, harts, memmap, intc_phandles);
 
     /* M-level IMSIC node */
     uint32_t msi_m_phandle = next_phandle();
-    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_MIMSIC], num_harts,
+    create_fdt_one_imsic(fdt, &memmap[TT_ATL_MIMSIC], num_harts,
                          intc_phandles, msi_m_phandle,
                          IRQ_M_EXT, TT_IMSIC_GUEST_BITS);
 
     /* S-level IMSIC node */
-    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_SIMSIC], num_harts,
+    create_fdt_one_imsic(fdt, &memmap[TT_ATL_SIMSIC], num_harts,
                          intc_phandles, imsic_s_phandle,
                          IRQ_S_EXT, TT_IMSIC_GUEST_BITS);
 
     uint32_t aplic_m_phandle = next_phandle();
 
     /* M-level APLIC node */
-    create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_MAPLIC],
+    create_fdt_one_aplic(fdt, &memmap[TT_ATL_MAPLIC],
                          msi_m_phandle, intc_phandles,
                          aplic_m_phandle, aplic_s_phandle,
                          IRQ_M_EXT, num_harts);
 
     /* S-level APLIC node */
-    create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_SAPLIC],
+    create_fdt_one_aplic(fdt, &memmap[TT_ATL_SAPLIC],
                          imsic_s_phandle, intc_phandles,
                          aplic_s_phandle, 0,
                          IRQ_S_EXT, num_harts);
@@ -333,10 +335,10 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
     qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
 }
 
-static void create_fdt_i2c_device(void *fdt, TTAtlantisSoCState *s, int bus,
-                                  const char *compat, int addr)
+static void create_fdt_i2c_device(void *fdt, const MemMapEntry *memmap,
+                                  int bus, const char *compat, int addr)
 {
-    hwaddr base = s->memmap[TT_ATL_I2C0 + bus].base;
+    hwaddr base = memmap[TT_ATL_I2C0 + bus].base;
     g_autofree char *name = g_strdup_printf("/soc/i2c@%"HWADDR_PRIX"/sensor@%x",
                                             base, addr);
 
@@ -365,7 +367,8 @@ static char *create_fdt_prcm(void *fdt, const MemMapEntry *mem,
     return name;
 }
 
-static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
+static void finalize_fdt(void *fdt, RISCVHartArrayState *harts,
+                         const MemMapEntry *memmap, hwaddr ram_size)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
@@ -373,9 +376,9 @@ static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
     uint32_t prcm_rcpu_phandle;
     g_autofree char *rcpu_name, *hsio_name, *pcie_name, *mm_name;
 
-    create_fdt_cpu(fdt, s, aplic_s_phandle, imsic_s_phandle);
+    create_fdt_cpu(fdt, harts, memmap, aplic_s_phandle, imsic_s_phandle);
 
-    create_fdt_memory(fdt, s);
+    create_fdt_memory(fdt, memmap, ram_size);
 
     /*
      * We want to do this, but the Linux aplic driver was broken before v6.16
@@ -386,7 +389,7 @@ static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
 
     create_fdt_clk(fdt, "osc-24m", 24000000, osc_24m_phandle);
 
-    rcpu_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_RCPU], "rcpu");
+    rcpu_name = create_fdt_prcm(fdt, &memmap[TT_ATL_PRCM_RCPU], "rcpu");
     prcm_rcpu_phandle = qemu_fdt_get_phandle(fdt, rcpu_name);
     qemu_fdt_setprop_cells(fdt, rcpu_name, "clocks", osc_24m_phandle);
     qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clocks",
@@ -396,33 +399,33 @@ static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
                            prcm_rcpu_phandle, TT_ATL_CLK_RCPU_PLL,
                            prcm_rcpu_phandle, TT_ATL_CLK_NOC_PLL);
 
-    hsio_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_HSIO], "hsio");
+    hsio_name = create_fdt_prcm(fdt, &memmap[TT_ATL_PRCM_HSIO], "hsio");
     qemu_fdt_setprop_cells(fdt, hsio_name, "clocks", osc_24m_phandle,
                            prcm_rcpu_phandle, TT_ATL_CLK_HSIO_PLL);
 
-    pcie_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_PCIE], "pcie");
+    pcie_name = create_fdt_prcm(fdt, &memmap[TT_ATL_PRCM_PCIE], "pcie");
     qemu_fdt_setprop_cells(fdt, pcie_name, "clocks", osc_24m_phandle,
                            prcm_rcpu_phandle, TT_ATL_CLK_PCIE_PLL);
 
-    mm_name = create_fdt_prcm(fdt, &s->memmap[TT_ATL_PRCM_MM], "mm");
+    mm_name = create_fdt_prcm(fdt, &memmap[TT_ATL_PRCM_MM], "mm");
     qemu_fdt_setprop_cells(fdt, mm_name, "clocks", osc_24m_phandle,
                            prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL0,
                            prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL1);
 
-    create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
+    create_fdt_uart(fdt, &memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
                     aplic_s_phandle, prcm_rcpu_phandle, TT_ATL_CLK_UART1_PCLK);
 
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         create_fdt_i2c(fdt,
-                       &s->memmap[TT_ATL_I2C0 + i],
+                       &memmap[TT_ATL_I2C0 + i],
                        TT_ATL_I2C0_IRQ + i,
                        aplic_s_phandle, prcm_rcpu_phandle,
                        TT_ATL_CLK_I2C0_PCLK + i);
     }
 
     /* I2C peripherals: qemu specific */
-    create_fdt_i2c_device(fdt, s, 0, "dallas,ds1338", 0x6f);
-    create_fdt_i2c_device(fdt, s, 4, "ti,tmp105", 0x48);
+    create_fdt_i2c_device(fdt, memmap, 0, "dallas,ds1338", 0x6f);
+    create_fdt_i2c_device(fdt, memmap, 4, "ti,tmp105", 0x48);
 }
 
 static void create_fdt(TTAtlantisState *ams)
@@ -439,7 +442,7 @@ static void create_fdt(TTAtlantisState *ams)
 
     qemu_fdt_add_subnode(ms->fdt, "/aliases");
 
-    create_fdt_pmu(ms->fdt, &ams->soc);
+    create_fdt_pmu(ms->fdt, &ams->soc.cpus);
 }
 
 static void load_fdt(TTAtlantisState *ams)
@@ -470,7 +473,7 @@ static void load_fdt(TTAtlantisState *ams)
         g_strfreev(node_path);
     }
 
-    create_fdt_memory(ms->fdt, &ams->soc);
+    create_fdt_memory(ms->fdt, ams->soc.memmap, ms->ram_size);
 }
 
 static void tt_atlantis_machine_done(Notifier *n, void *data)
@@ -491,7 +494,7 @@ static void tt_atlantis_machine_done(Notifier *n, void *data)
      * dynamic sysbus devices. Our FDT needs to be finalized.
      */
     if (machine->dtb == NULL) {
-        finalize_fdt(machine->fdt, s);
+        finalize_fdt(machine->fdt, &s->cpus, s->memmap, machine->ram_size);
     }
 
     mem_size = machine->ram_size;
-- 
2.43.0


