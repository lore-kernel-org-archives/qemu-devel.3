Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11B0606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 04:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=OXdvRaUq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMds0-0002AN-F3; Fri, 30 Oct 2026 00:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMdry-00029F-JX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:05:34 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMdrw-0004nx-AU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:05:34 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-35159e0092aso41691eec.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 21:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793333131; x=1793937931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Sy58H3dDBdRod4hvVO4yDknBVa4biH7i4I2S5L9ZQM=;
 b=OXdvRaUqEikBrEdz00dnAHDFwm0o9TV0Oz+05M0Dk2dODyoM/LRNpxeXGdzPqtYvq5
 JOK7Ub/VbfxCt1nSRtvi1ZExhor7PDyD0kcg2CxC4za30idF5smyXAtWS7+AsUa+8q5x
 4PSWBmtJj4WtfXW4PWc/0oYXM63hZOi5n2tpSE//PQ16d488ejeYsLmxRfeot9ljdDBz
 V+4zq4DVNRAcS/ITAOvjXCvmUVZsss5eZyGug3o92IxeIgwTLpg07NV+zgcElAwj5XN9
 BJWTvSYDcBQbIxhekJTl6q0mQUaKiYYDsZ+5eJhxNrWHiH4sFjBEgEtYZtwo5Fnbluja
 35FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793333131; x=1793937931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Sy58H3dDBdRod4hvVO4yDknBVa4biH7i4I2S5L9ZQM=;
 b=bECgLeVonmAe+zMC7HZT7GajPmFE+lV4WBNzbjn+gkLANNrYTRWKrgwsc+n0Uw0YiR
 +SPi58E4fJUG84Fmcq9R+nJSrv1YoBL7eD6yjew/+E0PFIdYGrrkaoKztlhwESUELz6p
 YsGUehw/xVKbE581Iy2F8K7/ACbnW2q0Gog/vP5X8kkABLuLb6vlRb90MOpSTJ9/ah70
 a9pvvya4sXMnRoPbeP1X6Qa3SXJYAnxhRmzdljt0nhCWMBp50COg1ACBIq/X2zPBvsRe
 M4pNdS1FaFio0zW6Jv/YSXoekT7M4GSErMATtMsEH0jQQG1ANF2/fOASoBn6O2SFbTEc
 6v9g==
X-Gm-Message-State: AFq9FYJA/5I9q4AnV/ajyMVO9mRZo4CaP2zctNvWcDjOBaUJWIC6uiZU
 4daL28SmweP6bPE0cG1rjrarEOLde82QfPxb9U8cjUfVMb1X6iCwdKWi2BUIrPcHA2RSpW+tgsj
 +Fl+P/8g=
X-Gm-Gg: AYBFou24/GxX7qC3BIpT36Xqla7VdOFB6/LAEKPtilGwVFJS/6rT0BOGhfDkErrxcoL
 JsRBfj5npuDhlhYUh+pgwJAmmGePb1+rpF0Z9hvvi4QDIsfpG9kUr0V7fv8GzU3dgPCK33BA3/F
 52tk1BMIeT81InwDVeVqBzTjGv96WOzKXTj9QMV2/LkRyH6Y/g5Fylm1N/fm5PBcVoQji3cyhF9
 W8w3pRi74pX+cY93Ln/AZq4rfrSx3SKjs6lI+GClNwNfQaemZvobf8rUSwRRtt4DKBPorNBcuCA
 EkgSQX2/mMn8QuWvaq5fEwt7m4HXZuySzdq+ARBEs9eJy6VQ7wXnlFyqAijpwz9iiK0vWWQmSjn
 R8hfXpmejGDdYdP7WR9tp974poq2WrzTk2tlSz6tWsrx98IZb//Q4alN1E+29C1ch0PEidpRZrS
 nmR7xTMg+qYvpi1hdgGvemKUQsEpFqdePbaOBOQPPEz4XIKwPZGPDeuRGl5eenqnuspq0lP2x5i
 zMDl1GBDYTdYFIu57lRZ49CifmikYMKX9Lan51lJKRUz/MKLyAp7SbRXM4sEJtknaab0LRVDegW
 4Rj4mGzcltR4dJSnOxkKG/WalmRXJzdcMy5im1uuuCtVwyy/2vQeN1CUK0u0q2ZqXXAGUaN7ytm
 Stw==
X-Received: by 2002:a05:693c:6304:b0:369:289a:d31a with SMTP id
 5a478bee46e88-36a42059799mr2938968eec.0.1793333130409; 
 Thu, 29 Oct 2026 21:05:30 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1easm2957687eec.5.2026.10.29.21.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 21:05:30 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Michael Ellerman <mpe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Zhao Liu <zhao1.liu@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v3 1/9] hw/riscv/atlantis: Update fdt functions to take
 generic parameters
Date: Fri, 30 Oct 2026 14:05:07 +1000
Message-ID: <20261030040516.853444-2-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030040516.853444-1-portias@oss.tenstorrent.com>
References: <20261030040516.853444-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=portias@tenstorrent.com; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


