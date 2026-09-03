Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11F6C624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20OA-0006yn-5b; Thu, 03 Sep 2026 01:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20O3-0006ox-Ob
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:24 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20O0-0006UE-P2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:22 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d560775ca2so17537125ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414799; x=1789019599; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dmJ98Ok+tV+6RHMJZnUGNJToi1vKAKqDHGwjk1bkfQc=;
 b=kWICzBtcvsWgDXmeQDTcqv+AvGngn3mlq2w1lyFZFCd+u7LBHsdwx5Lnv/0+I3x8Kx
 4/4MlgUTscjzYwFeic+kVT29lDGS5zlbCBS6huQDQQN7cmuv60vycAsDUoh0//hACN4E
 sZYNT/BV0VYbzQQBgP7a6+Hyi7rLJLHFZ//tXK5ymaOaByZGkQ21NCPr5bsJB3896KyX
 8fyuTn7cSh77yJ6cl9zmbB8JX7A7K+JDRL/BCQiRXpF0ytpiSPGlxGjPzmhWeKVp3k1a
 Sv8upQ+AogxKwDDGrM0EKzpQHBR2kAYdLbA/dc5FYKazUMQ13KNV3hmY4LWbOSMTX3+a
 dBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414799; x=1789019599;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dmJ98Ok+tV+6RHMJZnUGNJToi1vKAKqDHGwjk1bkfQc=;
 b=cO4QcgTyVXzXSNG9bjIU5Ka5X3EhI7/f2Pg1cniGlrwmWLLsCQEu3dSQh8mL587XCM
 UeZzfr83BFDydv4xo8q38PwhK+OoMF5HMYuIgPiO2drOq/lny0TwODs5mnCKcK7gM8jj
 EHyisWq/IfCyw+43Kg9vMQYgrCgq9E1ZUGOogi8gw1RRpEqEyQq/3CxUAy9PdqtXiS8O
 2LLbd4DrWsrlaiVJjxlM9Va/tnBEqTklb31iP6WG2uZAhLimMUJVYIfE6DlKmueQVYXk
 IMLUljLoMMVJB5FD70etO6vaMnLFtyB99u5xalQ6J/y8Rifz0o0cpsaWJDgsLD7xt4I5
 50nw==
X-Forwarded-Encrypted: i=1;
 AKwUvByIJsL/1rrxLr3/OHD07ciDrZnRpVvy09B6tdFYEouzu5UMhBq7WU2QoDuvQfpQ/3+izujeZ8Ik7USs@nongnu.org
X-Gm-Message-State: AFuF++mYVZIAJahSknwT4CF2PR3/2GTFR7tB+qZNQSRi3oV2J0XulgVv
 RFjttSeVvwsVQ602YSHg8V53xyMD+571U+P6DNZ6oNgsQQYZyaxwWNTK
X-Gm-Gg: AYBFou12KxMDZh6+d2U7NDLeGVuBnx/SLe2sWjbHiSdaXPrLAd9eBHNmVwork61T4ti
 Q0Bk9Uv85oxVbQ1zGWT9HXRbbfUBZ6d3TkK0scPqIYhtbm0Iu+xmVwmS6iDdvTBaCMeQGd0URtr
 /DDTk7VYhGvTyBYRJsQYjqNPhxw/AtFEcpi5TnNwUWYwv4RmGOkQpbxwBTpAkMDB/hUJ7cHHHzI
 i/cK/I0MhXme0tKsyVJApuZW/g/6z233liRVPs69MwbX50mywfr+I1rLxeeOl/TQHYeXQIm20pn
 2FnS5Anq1VUDMhM34C6krjCRW80yWcAblsHMEqDO2/vCMNziZm4+YOBrxwixBLgGVLG6Euv6t5G
 u3zSN46EIuctnRPoh/ptmQm/FfQRzXFmrxHs/n/dBS83XOuyg6TFlvfs/YM1g6pmOaSMfUBJ7/l
 mTf/d/fcrtD9UQ4O0wZRTxIeK5hBWf+ZCOZfKIb2Ci2jewVwSXZwfR4hMB2Q5XhW4DPRQW6OxHA
 +hFedu5Vl17p1G7BkDyV/Z67YxmgL2R6/HRnG2S4KPt6tTMJqJoMp1u9FkqysZLAVARrHCCyMkl
 7cYvQzz5De8ibQAIxAl5
X-Received: by 2002:a17:90b:1dc1:b0:398:d6f4:c61a with SMTP id
 98e67ed59e1d1-39aee13c22dmr15826781a91.17.1788414799183; 
 Wed, 02 Sep 2026 22:53:19 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:53:18 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 10/16] hw/riscv/atlantis: Rework device tree creation
Date: Thu,  3 Sep 2026 15:21:24 +0930
Message-ID: <20260903055131.257903-11-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Remove the direct use of MachineState from the device tree creation to
allow separation between the SoC (TTAtlantisState) and the QEMU
MachineState.

Fix this for the device tree pointer by passing it directly to the
functions that use it, instead of casting the TTAtlantisState to a
MachineState.

MachineState::smp.cpus is replaced with TTAtlantisState::cpus.num_harts,
as these are equivalent after tt_atlantis_machine_init.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/tt_atlantis.c | 51 +++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 80300a18a4ab..f2a4a051d1f6 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -80,9 +80,8 @@ static uint32_t next_phandle(void)
     return fdt_phandle++;
 }
 
-static void create_fdt_memory(TTAtlantisState *s)
+static void create_fdt_memory(void *fdt, TTAtlantisState *s)
 {
-    void *fdt = MACHINE(s)->fdt;
     hwaddr size_lo = MACHINE(s)->ram_size;
     hwaddr size_hi = 0;
 
@@ -105,9 +104,9 @@ static void create_fdt_memory(TTAtlantisState *s)
     }
 }
 
-static void create_fdt_aclint(TTAtlantisState *s, uint32_t *intc_phandles)
+static void create_fdt_aclint(void *fdt, TTAtlantisState *s,
+                              uint32_t *intc_phandles)
 {
-    void *fdt = MACHINE(s)->fdt;
     g_autofree char *name = NULL;
     g_autofree uint32_t *aclint_mtimer_cells = NULL;
     uint32_t aclint_cells_size;
@@ -207,10 +206,9 @@ static void create_fdt_one_aplic(void *fdt,
     qemu_fdt_setprop_cell(fdt, name, "phandle", aplic_phandle);
 }
 
-static void create_fdt_pmu(TTAtlantisState *s)
+static void create_fdt_pmu(void *fdt, TTAtlantisState *s)
 {
     char pmu_name[] = "/pmu";
-    void *fdt = MACHINE(s)->fdt;
     RISCVCPU *hart = &s->cpus.harts[0];
 
     qemu_fdt_add_subnode(fdt, pmu_name);
@@ -218,32 +216,29 @@ static void create_fdt_pmu(TTAtlantisState *s)
     riscv_pmu_generate_fdt_node(fdt, hart->pmu_avail_ctrs, pmu_name);
 }
 
-static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
+static void create_fdt_cpu(void *fdt, TTAtlantisState *s,
                            uint32_t aplic_s_phandle,
                            uint32_t imsic_s_phandle)
 {
-    MachineState *ms = MACHINE(s);
-    void *fdt = MACHINE(s)->fdt;
-    g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
+    g_autofree uint32_t *intc_phandles = g_new0(uint32_t, s->cpus.num_harts);
+    int num_harts = s->cpus.num_harts;
 
     riscv_fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
 
-    riscv_create_fdt_socket_cpus(fdt, s->cpus.harts, 0, s->cpus.num_harts,
+    riscv_create_fdt_socket_cpus(fdt, s->cpus.harts, 0, num_harts,
                                  s->cpus.hartid_base, &fdt_phandle,
                                  intc_phandles, false, false);
 
-    create_fdt_memory(s);
-
-    create_fdt_aclint(s, intc_phandles);
+    create_fdt_aclint(fdt, s, intc_phandles);
 
     /* M-level IMSIC node */
     uint32_t msi_m_phandle = next_phandle();
-    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_MIMSIC], ms->smp.cpus,
+    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_MIMSIC], num_harts,
                          intc_phandles, msi_m_phandle,
                          IRQ_M_EXT, TT_IMSIC_GUEST_BITS);
 
     /* S-level IMSIC node */
-    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_SIMSIC], ms->smp.cpus,
+    create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_SIMSIC], num_harts,
                          intc_phandles, imsic_s_phandle,
                          IRQ_S_EXT, TT_IMSIC_GUEST_BITS);
 
@@ -253,13 +248,13 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
     create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_MAPLIC],
                          msi_m_phandle, intc_phandles,
                          aplic_m_phandle, aplic_s_phandle,
-                         IRQ_M_EXT, s->cpus.num_harts);
+                         IRQ_M_EXT, num_harts);
 
     /* S-level APLIC node */
     create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_SAPLIC],
                          imsic_s_phandle, intc_phandles,
                          aplic_s_phandle, 0,
-                         IRQ_S_EXT, s->cpus.num_harts);
+                         IRQ_S_EXT, num_harts);
 }
 
 static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
@@ -318,10 +313,9 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
     qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
 }
 
-static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
+static void create_fdt_i2c_device(void *fdt, TTAtlantisState *s, int bus,
                                   const char *compat, int addr)
 {
-    void *fdt = MACHINE(s)->fdt;
     hwaddr base = s->memmap[TT_ATL_I2C0 + bus].base;
     g_autofree char *name = g_strdup_printf("/soc/i2c@%"HWADDR_PRIX"/sensor@%x",
                                             base, addr);
@@ -331,14 +325,15 @@ static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
     qemu_fdt_setprop_cell(fdt, name, "reg", addr);
 }
 
-static void finalize_fdt(TTAtlantisState *s)
+static void finalize_fdt(void *fdt, TTAtlantisState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
     uint32_t periph_clk_phandle = next_phandle();
-    void *fdt = MACHINE(s)->fdt;
 
-    create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
+    create_fdt_cpu(fdt, s, aplic_s_phandle, imsic_s_phandle);
+
+    create_fdt_memory(fdt, s);
 
     /*
      * We want to do this, but the Linux aplic driver was broken before v6.16
@@ -360,8 +355,8 @@ static void finalize_fdt(TTAtlantisState *s)
     }
 
     /* I2C peripherals: qemu specific */
-    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
-    create_fdt_i2c_device(s, 4, "ti,tmp105", 0x48);
+    create_fdt_i2c_device(fdt, s, 0, "dallas,ds1338", 0x6f);
+    create_fdt_i2c_device(fdt, s, 4, "ti,tmp105", 0x48);
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -378,7 +373,7 @@ static void create_fdt(TTAtlantisState *s)
 
     qemu_fdt_add_subnode(ms->fdt, "/aliases");
 
-    create_fdt_pmu(s);
+    create_fdt_pmu(ms->fdt, s);
 }
 
 static void load_fdt(TTAtlantisState *s)
@@ -409,7 +404,7 @@ static void load_fdt(TTAtlantisState *s)
         g_strfreev(node_path);
     }
 
-    create_fdt_memory(s);
+    create_fdt_memory(ms->fdt, s);
 }
 
 static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
@@ -440,7 +435,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
      * dynamic sysbus devices. Our FDT needs to be finalized.
      */
     if (machine->dtb == NULL) {
-        finalize_fdt(s);
+        finalize_fdt(machine->fdt, s);
     }
 
     mem_size = machine->ram_size;
-- 
2.47.3


