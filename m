Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92742C61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rZO-0003bJ-Rf; Sun, 30 Aug 2026 22:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rZN-0003at-9N
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:16:21 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rZL-0007bF-JX
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:16:21 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so3016536a91.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 19:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788142578; x=1788747378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OFYmGuYlL+4/TOCTKu3JsnhGO4Hq3PGwlVqkQXuCBNs=;
 b=aa2kGH349JqU9XuwZ/BMLtvVKdhcCleAptEgRMMyTpJyQS8BDPHen8fymoVqPRe3Gl
 gB+wYlJXQAZzS3pjQ7Ypd/CfWMBdueznEb3+XCEATcWYc+6QLA33nNMO8Yk/c3Z5WAz4
 BAo2bJbr6A3JQCsD6BJKUFVmWLM8nTqkn1hwStkeQv/PzXPxYUilWBNYO07jjh1hfI2V
 HkvD5ooH35K5ZhbtO5OuHLNO7x+8YWoRVGWTUb202xBQe9wKlNjrrMtOneMiYFWzxbT2
 VNNuiDa/Z2/0Tt6uNEGz4nm26jiVmmzx0AlV/oxfYhHsEdXueEhitxVhFIae7P/19/7n
 WxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788142578; x=1788747378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OFYmGuYlL+4/TOCTKu3JsnhGO4Hq3PGwlVqkQXuCBNs=;
 b=GNMY8bNtX33OV+We9vLQStyLzMc+bYFy9pRxHBBp/rxyO7cdkpaGmCnl4Ut4+PwAY6
 TzeXRj2zDI0EIzhjAKn9VRkwhKURD3rXp0rJfyB/14r/mey2wGOEwfTsGa7mUYxcGJqK
 wiC23AnP0q4GxPCRI6tDDvFW/xl/+byB88u1TX0DGW/IqmFluRGpB2D5pMA/tgK5zT1w
 rmZcxVnPHxc7ZTT6pPhU8+XquVE5ZCDluscmCmKJFnQ4bK2hMpOjtfgJBsQ1Vv3A71IN
 L8V4Sgvfbfu8ZWr9Hx+oteQuKjB7DcJCXDKT8krqYvWzjhwcpBg7VnY98v/VAaTMnxHV
 53cQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWVLOnRC58atbUxUuJ5iCaAyjrPxt2EuUqIpzYpwzjnqJDOwnn8sCixpX3alK9hILWB2XJoHMbXQCz@nongnu.org
X-Gm-Message-State: AFuF++lpQBiF4nZO6p5IIL6wbTrmh85UXR8UAs8J5grOsNOz+IoJ9KsW
 mL5cbxzzOfDyKta3QzaB9PlGb7gYV0CtvvPtTMKVH8um9lgx9uoF7ixR
X-Gm-Gg: AYBFou0nhk0DjCNx3B5bVuCPRFakC+l0yqMThy0iYXb1JJtc3V6sizmBj4PhQnaozJ6
 ir5Db3CSBe5awQ9125wNTxcI45kZI0y1cMyalMipPaW5sA0wULmEHwEoKlHZm0RAg5rgnrR8dNm
 nPbYRG/Qo2JKVl+MMjutlCRvjMFhsvf906FZo3RLc9ZzGrpLRpys6rlQthkQ8yhoRzEzmivshx+
 MsLO5zrP16J59w2naRWBJJiKWrkmnOIxXzh4tCpX1Qu8YuoRKbPFT5Lqd0zANXhNXz9F9LdVJBg
 Cvubrj9xqHkTxWIZ8CN5/fLNZK7YLggwAvHlSu+zaKyVP3xBGKb8ktW0hL0/PLxc6HPqpYiuH75
 xQEL4zQwjUT+Dn51+Xx8DI+jiibO6d4XTyR46eErRrQbTlAfURQ5KBhHqlz3srlFk1gaGutS5tr
 3glmti1TXiMA2BNfZcQt1sMCgFPFtjp7l7aIH1NeWu10R0Blc5POyeo6hH8OleTucLgWDpbd9yw
 iU6wnJ2vVDOh1h6Nd3kpRGsu/oftdqJNd5hc3kVnv1lzDS2NXVHmsOLXfD4dpsizUu1+JZjKVhr
 aaUAUw44xIgv8hDSpCDn
X-Received: by 2002:a17:90a:2c86:b0:398:9bd4:d1a with SMTP id
 98e67ed59e1d1-3989bd40dd1mr16366819a91.25.1788142578108; 
 Sun, 30 Aug 2026 19:16:18 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186807bsm20071240a91.12.2026.08.30.19.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:16:17 -0700 (PDT)
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
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 09/16] hw/riscv/atlantis: Rename hart array 'soc' to 'cpus'
Date: Mon, 31 Aug 2026 11:44:50 +0930
Message-ID: <20260831021500.82565-10-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831021500.82565-1-joel@jms.id.au>
References: <20260831021500.82565-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102e.google.com
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

The RISCVHartArrayState member is named soc, but it's an array of cpus,
not the entire SoC. Use cpus instead as an accurate description of the
hart array.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  2 +-
 hw/riscv/tt_atlantis.c         | 34 +++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index d0cca3b02424..642490d21743 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -29,7 +29,7 @@ struct TTAtlantisState {
     Notifier machine_done;
     const MemMapEntry *memmap;
 
-    RISCVHartArrayState soc;
+    RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
     UnimplementedDeviceState uart1;
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 127c89be4f60..35b3be072a06 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -112,13 +112,13 @@ static void create_fdt_aclint(TTAtlantisState *s, uint32_t *intc_phandles)
     uint32_t aclint_cells_size;
     hwaddr addr;
 
-    aclint_mtimer_cells = g_new0(uint32_t, s->soc.num_harts * 2);
+    aclint_mtimer_cells = g_new0(uint32_t, s->cpus.num_harts * 2);
 
-    for (int cpu = 0; cpu < s->soc.num_harts; cpu++) {
+    for (int cpu = 0; cpu < s->cpus.num_harts; cpu++) {
         aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
         aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
     }
-    aclint_cells_size = s->soc.num_harts * sizeof(uint32_t) * 2;
+    aclint_cells_size = s->cpus.num_harts * sizeof(uint32_t) * 2;
 
     addr = s->memmap[TT_ATL_ACLINT].base;
 
@@ -210,7 +210,7 @@ static void create_fdt_pmu(TTAtlantisState *s)
 {
     char pmu_name[] = "/pmu";
     void *fdt = MACHINE(s)->fdt;
-    RISCVCPU *hart = &s->soc.harts[0];
+    RISCVCPU *hart = &s->cpus.harts[0];
 
     qemu_fdt_add_subnode(fdt, pmu_name);
     qemu_fdt_setprop_string(fdt, pmu_name, "compatible", "riscv,pmu");
@@ -227,8 +227,8 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
 
     fdt_create_cpu_socket_subnode(fdt, TT_ACLINT_TIMEBASE_FREQ);
 
-    create_fdt_socket_cpus(fdt, s->soc.harts, 0, s->soc.num_harts,
-                           s->soc.hartid_base, &fdt_phandle, intc_phandles,
+    create_fdt_socket_cpus(fdt, s->cpus.harts, 0, s->cpus.num_harts,
+                           s->cpus.hartid_base, &fdt_phandle, intc_phandles,
                            false, false);
 
     create_fdt_memory(s);
@@ -252,13 +252,13 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
     create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_MAPLIC],
                          msi_m_phandle, intc_phandles,
                          aplic_m_phandle, aplic_s_phandle,
-                         IRQ_M_EXT, s->soc.num_harts);
+                         IRQ_M_EXT, s->cpus.num_harts);
 
     /* S-level APLIC node */
     create_fdt_one_aplic(fdt, &s->memmap[TT_ATL_SAPLIC],
                          imsic_s_phandle, intc_phandles,
                          aplic_s_phandle, 0,
-                         IRQ_S_EXT, s->soc.num_harts);
+                         IRQ_S_EXT, s->cpus.num_harts);
 }
 
 static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
@@ -429,7 +429,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
     hwaddr start_addr = s->memmap[TT_ATL_DDR_LO].base;
     hwaddr mem_size;
     target_ulong firmware_end_addr, kernel_start_addr;
-    const char *firmware_name = riscv_default_firmware_name(&s->soc);
+    const char *firmware_name = riscv_default_firmware_name(&s->cpus);
     uint64_t fdt_load_addr;
     uint64_t kernel_entry;
     RISCVBootInfo boot_info;
@@ -446,7 +446,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
     if (mem_size > s->memmap[TT_ATL_DDR_LO].size) {
         mem_size = s->memmap[TT_ATL_DDR_LO].size;
     }
-    riscv_boot_info_init_discontig_mem(&boot_info, &s->soc,
+    riscv_boot_info_init_discontig_mem(&boot_info, &s->cpus,
                                        s->memmap[TT_ATL_DDR_LO].base,
                                        mem_size);
 
@@ -476,7 +476,7 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
-    riscv_setup_rom_reset_vec(machine, &s->soc, start_addr,
+    riscv_setup_rom_reset_vec(machine, &s->cpus, start_addr,
                               s->memmap[TT_ATL_BOOTROM].base,
                               s->memmap[TT_ATL_BOOTROM].size,
                               kernel_entry,
@@ -496,18 +496,18 @@ static void tt_atlantis_machine_init(MachineState *machine)
 
     s->memmap = tt_atlantis_memmap;
 
-    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+    object_initialize_child(OBJECT(machine), "soc", &s->cpus,
                             TYPE_RISCV_HART_ARRAY);
-    object_property_set_str(OBJECT(&s->soc), "cpu-type", machine->cpu_type,
+    object_property_set_str(OBJECT(&s->cpus), "cpu-type", machine->cpu_type,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), "hartid-base", 0,
+    object_property_set_int(OBJECT(&s->cpus), "hartid-base", 0,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), "num-harts", hart_count,
+    object_property_set_int(OBJECT(&s->cpus), "num-harts", hart_count,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), "resetvec",
+    object_property_set_int(OBJECT(&s->cpus), "resetvec",
                             s->memmap[TT_ATL_BOOTROM].base,
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
 
     s->irqchip = riscv_create_aia(system_memory,
                                   true, TT_IMSIC_GUESTS,
-- 
2.47.3


