Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DB3C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MNN-00031C-17; Fri, 04 Sep 2026 01:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNL-0002ud-Cr
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:07 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNJ-0001VG-HH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:07 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-853e2610bb4so1252476b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499324; x=1789104124; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NrJNrHysR2BX0IvWpeHPxmBAQ2CbZcOJut4XXuAuY+k=;
 b=K+ZeGEEFD+PXLT3671OAmBFwc66bIfTDzsiTa/a/GNHU1MNPzn+Z0ZsJj5c0kKHdmK
 CbmR/2LBqZXIp/vMCPM8gJbaGT42e7y5061/t4ipqnGtrjkle3LA64iKzdFm49BJARJY
 bOb4nd9QoQVjPicg0o3MqPZBLdrAUblpmkShq5WOPpfuNgTq7vJfWmLNnkS6aJnnLGjn
 LFSFhUDHMmxW7VTPd/Y2P89bxwBvWhL/+AdxkcYjpol0bqR3K6dWA7qJ0egL4MaFXPbh
 EDTxQRUNxmOcNRMsF735s6gP6BynRX29/sCGnQfj++vi/6t0rClOxwYZCbnAXB4CJ9ww
 PRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499324; x=1789104124;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NrJNrHysR2BX0IvWpeHPxmBAQ2CbZcOJut4XXuAuY+k=;
 b=UDCObz1GyHU1QRD3wFspSzUnlcT2khGLwoH8SaiiZlqUqwfrR+ZXz3a1nFxP8e4A7N
 goQzXPhDGsFzXTvafX3X4NQ4pHjAAlHZUbz7edmCzVJU6kguczdXQUsROUQWtFOEK0zS
 T9WMi6xK59+jfTXsdFPTd/CWl8wjFi0FVxP9cAJWd0CUY0nuikfzZzoXcqEx64WNDsu+
 5LC0sEZwUycuZUYMn5pCpGsdJsXW5IiYtg+11NLK6CKCkenBsmFkAduFKLS+XWBL4Epq
 g2BaJDlfMKDkH4tGfqfuNUSE7Ap8JZ2PUBXww820x1ZQw/BuXJ7Og0soqxO2QaaPvtPC
 52QA==
X-Gm-Message-State: AFuF++nx5S/DW9SzVfPz737eaM5Y+1QPvWlLXjmcbCLlCY6a16JJhbVV
 BQpx1Ns8jx2IvXT/d7I8EhhnmNqFS971vuavH+HuW1nEpiMcZvnXabPySHmAeA==
X-Gm-Gg: AYBFou0iH/IZAUH8J4W5uSsC1YZfcyj92ESI0LI43sGciUL2VGCO3P08cUgUpjQ52tR
 44RgfQzjOkxXCWfAWnR39UFz7ARzQySdbD1qvGj6YPSSyvIIBcAnsh+d8ZTThjbjJn5xo8tHuLW
 IRYbBTt8Np4JJ1ojxeICjlqchZA6dUmRZ25pfmTTjFHkEINUPw9EbPGL1Dwrk1H4mRf4+LI6sUi
 y9qGstXtj/g+wVLq+uO58WYmOVhf4g+h8suVhTWvRtV6F0JlJVFaXfFBZTHly6xvSX5j08F04xV
 Yp3n9BqDPpehQNRQALLS3BI86V7Y+IN7XkAEVwRi4ZwyPMpGOSDcqawyTADwNcOlzDq3PhA4t5j
 rcY8NcAOnMV+60wHrqZNzoLMLoivs6zSeCNBh9qRftUh7zc6fIK0GWZ0IheB1NgnAmW30PTWTfk
 51yf/HJE02zOQVGs4VgtAjnRZ6R2Ze8XvRQXQDyDHi/ZZeOvZFYMkiZpTqZ5Ts2AoZ9a2DxZy8q
 cDaSg==
X-Received: by 2002:a05:6a21:139a:b0:3c3:750f:3cf9 with SMTP id
 adf61e73a8af0-3da2142cfdcmr10500890637.11.1788499324199; 
 Thu, 03 Sep 2026 22:22:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:22:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 41/47] hw/riscv/atlantis: Rework device tree creation
Date: Fri,  4 Sep 2026 15:19:37 +1000
Message-ID: <20260904051943.799041-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: Joel Stanley <joel@jms.id.au>

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
Message-ID: <20260903055131.257903-11-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/tt_atlantis.c | 51 +++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 62e902f930..940f982e6b 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -79,9 +79,8 @@ static uint32_t next_phandle(void)
     return fdt_phandle++;
 }
 
-static void create_fdt_memory(TTAtlantisState *s)
+static void create_fdt_memory(void *fdt, TTAtlantisState *s)
 {
-    void *fdt = MACHINE(s)->fdt;
     hwaddr size_lo = MACHINE(s)->ram_size;
     hwaddr size_hi = 0;
 
@@ -104,9 +103,9 @@ static void create_fdt_memory(TTAtlantisState *s)
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
@@ -206,10 +205,9 @@ static void create_fdt_one_aplic(void *fdt,
     qemu_fdt_setprop_cell(fdt, name, "phandle", aplic_phandle);
 }
 
-static void create_fdt_pmu(TTAtlantisState *s)
+static void create_fdt_pmu(void *fdt, TTAtlantisState *s)
 {
     char pmu_name[] = "/pmu";
-    void *fdt = MACHINE(s)->fdt;
     RISCVCPU *hart = &s->cpus.harts[0];
 
     qemu_fdt_add_subnode(fdt, pmu_name);
@@ -217,32 +215,29 @@ static void create_fdt_pmu(TTAtlantisState *s)
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
 
@@ -252,13 +247,13 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
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
@@ -317,10 +312,9 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
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
@@ -330,14 +324,15 @@ static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
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
@@ -359,8 +354,8 @@ static void finalize_fdt(TTAtlantisState *s)
     }
 
     /* I2C peripherals: qemu specific */
-    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
-    create_fdt_i2c_device(s, 4, "ti,tmp105", 0x48);
+    create_fdt_i2c_device(fdt, s, 0, "dallas,ds1338", 0x6f);
+    create_fdt_i2c_device(fdt, s, 4, "ti,tmp105", 0x48);
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -377,7 +372,7 @@ static void create_fdt(TTAtlantisState *s)
 
     qemu_fdt_add_subnode(ms->fdt, "/aliases");
 
-    create_fdt_pmu(s);
+    create_fdt_pmu(ms->fdt, s);
 }
 
 static void load_fdt(TTAtlantisState *s)
@@ -408,7 +403,7 @@ static void load_fdt(TTAtlantisState *s)
         g_strfreev(node_path);
     }
 
-    create_fdt_memory(s);
+    create_fdt_memory(ms->fdt, s);
 }
 
 static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
@@ -439,7 +434,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
      * dynamic sysbus devices. Our FDT needs to be finalized.
      */
     if (machine->dtb == NULL) {
-        finalize_fdt(s);
+        finalize_fdt(machine->fdt, s);
     }
 
     mem_size = machine->ram_size;
-- 
2.55.0


