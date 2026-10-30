Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD260A2600
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 04:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=NOlVGuty
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMdsf-0002JN-G7; Fri, 30 Oct 2026 00:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMdsT-0002HB-8w
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:06:06 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMdsQ-0004py-6X
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:06:04 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-36a1c464349so49409eec.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 21:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793333160; x=1793937960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mYDs5k7AS5dUZwCkZJhE4i7iKCSoS5L1b5ihGB6AbAc=;
 b=NOlVGutyT23HX2nT4betinGMIh8DjIQrdhWbC9v6aS36ETo+RUWXIQutZT5FJqAstu
 faAP1YvSx4B89vomo0lx5LO1VIlr4wI8TZVvIU/iszgkQQQccFcGBl/rS7AkSvUlkjX9
 oWqozAPaYgBzHCIoahwUO7gz8/VuH8OhgY6chDsAjuWL1gCX5FsG9XX0zLSm59EQ11nL
 T503s4uBgbBsV56sFwQOeFXdre7VgbyRKUwnqP+SpgnNCWfqLR3bR0YBn2IXGatSD8oI
 bYu1p3EL6Bn/0NsI4wO6Dt9uliENiqHyyEqN3E/JSOq4t1PYu0MoYyUD3ypUBq75yeBR
 7J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793333160; x=1793937960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mYDs5k7AS5dUZwCkZJhE4i7iKCSoS5L1b5ihGB6AbAc=;
 b=HVpROHRqyrnwSVLAg8h94i9GSixHmlIavXS/W5j8tcAtkQxTyUWW3ORjMC2iHoz2/E
 jw6IjMOzcRjrK2t+rEEty+dldVeHD24eh/0BuMvKMvfbtScULjkn8f6gF/+v064l2Zua
 KOU2ZWDiB9uiAwSrsoeyjlX+rVgNAtjVIDG9Q3G/dqHUE6Dif2Lgw5Pzfuc2wSRlSqLF
 iIenQGHl0NFnjPfw6KOW9aHeajEHBhuz93cKyCSvfTCTsKOvRr+ANAJLxAfy1AKWPZ80
 +15c1EHhN4Yk6AhX//jNcFg9Sp6aSYD6fAyeF+xwHBfpUjacvjRIg/le0GR3GDaR+1e2
 314A==
X-Gm-Message-State: AFq9FYLdIGZEF0DsM9FxCWBE6G18bVqS9lDcU6/Dnwcj7e/E4a0SL6VC
 HLs4fPq0dH+IL7+RK92fDgBrxkgR8r960Z5Hif5fzJBpWkXlVV1YQABeFL33l/nvM7UK1kTmBdw
 rsnSSQ20=
X-Gm-Gg: AYBFou1ZccHmqC6humR7vrPqcaPAdAO4IKMcSUb+jw8fLGR8K5/QTDJt52mzQiJDH79
 hgQxxfUmAncYzHlbCDG8+NQGOr6tZaXpBAdEJU1RV9z8qwQlcpXSYiZ2qINMLXXGrLsUEdsmPGO
 Bg4+eT7Us2vPlCZRuupXh4a66PlVnjIAUDkduo714MLPrSYZ4jBv3N39tAqYZVN8qtCmDrZSVA7
 X6d3kYNWLM7crVXaknmS0d9fLUyKHUalDVGJZ64VmaufxjDnzSuWbIiYST/ZJV1WoACuqXUe2FV
 OabOub1LcO/RZBMVe/5URrpZgWeDszrf6e4TOOZF1WYCwnipueOreCZY9UySlhtV8lAhWbDuQK2
 wh2xdX+07Bo6at7eOlD4s7Gw4m1pausAWY3m0Dm6ML4XE4InvZXSjbs8eq4lDRU2dg0/JTooOnL
 H3KoBfRCNV8PtsWojpfjro4v4K1K6IQOc/gN1my7iivGMMdw6iSqe7Eyk2iGN0OH6EokmkiUsm8
 T8dCfouewpgnDn4Y6Byc1Vvmzzw6q3s4m+7FWNYJ2r2rPdzeO1S/b6qeYQWs/ehyqzqzcxueJsK
 vcIrcFWGLsxVwuANnvurWVqxoDQHTFuu7AELmAdCXgEyc4sluz4O/GwiFpW23lNpTDXkQG9eoE3
 b0g==
X-Received: by 2002:a05:7300:e9d7:10b0:36a:1452:8da9 with SMTP id
 5a478bee46e88-36a4231f759mr3300484eec.1.1793333159980; 
 Thu, 29 Oct 2026 21:05:59 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1easm2957687eec.5.2026.10.29.21.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 21:05:59 -0700 (PDT)
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
Subject: [PATCH v3 6/9] hw/riscv/atlantis: Add the RCPU to the Atlantis SoC
Date: Fri, 30 Oct 2026 14:05:12 +1000
Message-ID: <20261030040516.853444-7-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030040516.853444-1-portias@oss.tenstorrent.com>
References: <20261030040516.853444-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=portias@tenstorrent.com; helo=mail-dy1-x132e.google.com
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

The Atlantis SoC has a Realtime CPU, RV32 core. It is part of
the security subsystem and is responsible for booting the Ascalon
cluster. The RCPU has a different memory view from the Ascalon cores but
shares access to many peripherals.

This adds the RCPU to the Atlantis SoC with the minimum changes
to allow the bootrom to run and wait for the next stage
bootloader (FSBL) over UART. The RCPU has its own console (uart0),
separate from Ascalon which is exposed on serial_hd 1 on the command
line.

On hardware, the RCPU will be responsible for loading the Ascalon images
into DRAM and releasing the resets of the Ascalon cores. For now the
Ascalon cores are still bootstrapping their images directly into DRAM
via the command line arguments.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/Kconfig               |   1 +
 hw/riscv/tt_atlantis.c         | 298 ++++++++++++++++++++++++++++++++-
 include/hw/riscv/tt_atlantis.h |  44 +++++
 3 files changed, 337 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 4eccfa443e..8e1812923a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -150,6 +150,7 @@ config TENSTORRENT
     select DS1338
     select TMP105
     select CPU_CLUSTER
+    select UNIMP
 
 config XIANGSHAN_KUNMINGHU
     bool
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 076f2321e0..f778091e91 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -51,6 +51,7 @@ QEMU_BUILD_BUG_ON(TT_IMSIC_STRIDE != (0x1000 << TT_IMSIC_GUEST_BITS));
 #define TT_ACLINT_TIMEBASE_FREQ 1000000000
 
 #define ASCALON_CLUSTER_ID     0
+#define RCPU_CLUSTER_ID        1
 
 static const MemMapEntry tt_atlantis_memmap[] = {
     /* Keep sorted with :'<,'>!sort -g -k 4 */
@@ -78,6 +79,53 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
 };
 
+static const MemMapEntry tt_atlantis_rcpu_memmap[] = {
+    /* Keep sorted with :'<,'>!sort -g -k 4 */
+    [TT_ATL_BOOTROM] =           { 0x00040000,    0x40000 },
+    [TT_ATL_RCPU_SRAM] =         { 0x20100000,   0x100000 },
+    [TT_ATL_PRCM_RCPU] =         { 0x40000000,    0x10000 },
+    [TT_ATL_WDT0] =              { 0x40030000,    0x10000 },
+    [TT_ATL_WDT1] =              { 0x40040000,    0x10000 },
+    [TT_ATL_IO_CTRL] =           { 0x40060000,    0x10000 },
+    [TT_ATL_RCPU_MAILBOX] =      { 0x40100000,    0x10000 },
+    [TT_ATL_RCPU_SMN_FIREWALL] = { 0x41010000,    0x10000 },
+    [TT_ATL_NOCM_FIREWALL] =     { 0x41020000,    0x10000 },
+    [TT_ATL_UART0] =             { 0x48100000,    0x10000 },
+    [TT_ATL_UART1] =             { 0x48110000,    0x10000 },
+    [TT_ATL_UART2] =             { 0x48120000,    0x10000 },
+    [TT_ATL_UART3] =             { 0x48130000,    0x10000 },
+    [TT_ATL_UART4] =             { 0x48140000,    0x10000 },
+    [TT_ATL_GPIO] =              { 0x48150000,    0x10000 },
+    [TT_ATL_QSPI] =              { 0x4a000000,  0x2000000 },
+    [TT_ATL_OTP] =               { 0x50000000,   0x100000 },
+    [TT_ATL_PRCM_TRNG] =         { 0x50600000,    0x10000 },
+    [TT_ATL_SPACC] =             { 0x50800000,   0x100000 },
+    [TT_ATL_DDR_LO] =            { 0x60000000, 0x40000000 },
+    [TT_ATL_MIMSIC] =            { 0xa0000000,  0x8000000 },
+    [TT_ATL_PRCM_PCIE] =         { 0xa8000000,    0x10000 },
+    [TT_ATL_PRCM_MM] =           { 0xb0000000,   0x100000 },
+    [TT_ATL_SDHCI0] =            { 0xb4020000,    0x10000 },
+    [TT_ATL_SDHCI1] =            { 0xb4030000,    0x10000 },
+    [TT_ATL_PRCM_HSIO] =         { 0xb40c0000,    0x10000 },
+    [TT_ATL_PRCM_DDR0] =         { 0xb8000000,    0x10000 },
+    [TT_ATL_PRCM_DDR1] =         { 0xb8800000,    0x10000 },
+    [TT_ATL_DDRC0_CTRL] =        { 0xb9000000,   0x800000 },
+    [TT_ATL_DDRC1_CTRL] =        { 0xb9800000,   0x800000 },
+    [TT_ATL_MAPLIC] =            { 0xbc000000,  0x3000000 },
+    [TT_ATL_PRCM_ASC] =          { 0xbf000000,  0x1000000 },
+    [TT_ATL_RCPU_CLIC] =         { 0xe000e000,     0x2000 },
+    [TT_ATL_RCPU_CLINT] =        { 0xe0020000,     0xc000 },
+};
+
+/*
+ * Map the entire 4G memory view as unimplemented to prevent faults from
+ * devices that have not been modeled yet.
+ */
+static const UnimplementedDeviceConfig rcpu_unimp_dev[] = {
+    {"unimp", "tt-rcpu.unimp", 0x0, UINT32_MAX,  -1000},
+    { }
+};
+
 static I2CBus *i2c_get_bus(TTAtlantisSoCState *s, unsigned busnr)
 {
     assert(busnr < TT_ATL_NUM_I2C);
@@ -549,6 +597,85 @@ static inline int tt_atlantis_uart_index(int uart_dev)
     return uart_dev - TT_ATL_UART0;
 }
 
+static void tt_rcpu_cluster_init(Object *obj)
+{
+    TTRCPUClusterState *rc = TT_RCPU_CLUSTER(obj);
+
+    object_initialize_child(obj, "tt-rcpu.cluster", &rc->cluster,
+                            TYPE_CPU_CLUSTER);
+    object_initialize_child(OBJECT(&rc->cluster), "cpus", &rc->cpus,
+                            TYPE_RISCV_HART_ARRAY);
+}
+
+static void tt_rcpu_cluster_realize(DeviceState *dev, Error **errp)
+{
+    TTRCPUClusterState *rc = TT_RCPU_CLUSTER(dev);
+
+    rc->memmap = tt_atlantis_rcpu_memmap;
+
+    /* The RCPU has its own memory view. Create it here before the CPU uses it */
+    memory_region_init(&rc->memory, OBJECT(rc), "tt-rcpu.memory",
+                       UINT32_MAX);
+
+    /* The RCPU's maskrom which is inaccessible outside of the RCPU */
+    if (!memory_region_init_rom(&rc->bootrom, OBJECT(rc),
+                                "tt-rcpu.bootrom",
+                                rc->memmap[TT_ATL_BOOTROM].size, errp)) {
+        return;
+    }
+    memory_region_add_subregion(&rc->memory,
+                                rc->memmap[TT_ATL_BOOTROM].base,
+                                &rc->bootrom);
+
+    /* RCPU SRAM */
+    if (!memory_region_init_ram(&rc->sram, OBJECT(rc),
+                                "tt-rcpu.sram",
+                                rc->memmap[TT_ATL_RCPU_SRAM].size, errp)) {
+        return;
+    }
+    memory_region_add_subregion(&rc->memory,
+                                rc->memmap[TT_ATL_RCPU_SRAM].base,
+                                &rc->sram);
+
+    /* CPUs */
+    object_property_set_str(OBJECT(&rc->cpus), "cpu-type", TYPE_RISCV_CPU_TT_RCPU,
+                            &error_abort);
+    object_property_set_int(OBJECT(&rc->cpus), "hartid-base", 0,
+                            &error_abort);
+    object_property_set_int(OBJECT(&rc->cpus), "num-harts", 1,
+                            &error_abort);
+    object_property_set_int(OBJECT(&rc->cpus), "resetvec",
+                            rc->memmap[TT_ATL_BOOTROM].base,
+                            &error_abort);
+    object_property_set_link(OBJECT(&rc->cpus), "memory",
+                             OBJECT(&rc->memory),
+                             &error_abort);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&rc->cpus), errp)) {
+        return;
+    }
+
+    qdev_prop_set_int32(DEVICE(&rc->cluster), "cluster-id", RCPU_CLUSTER_ID);
+    /* cluster must be realized after the hart array */
+    if (!qdev_realize(DEVICE(&rc->cluster), NULL, errp)) {
+        return;
+    }
+
+    create_unimplemented_devices(OBJECT(rc), &rc->memory, rcpu_unimp_dev);
+
+    /* no bootrom image is provided, don't let the core run */
+    CPU(&rc->cpus.harts[0])->start_powered_off = true;
+}
+
+static void tt_rcpu_cluster_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = tt_rcpu_cluster_realize;
+    /* The cluster must be instantiated by a machine or SoC */
+    dc->user_creatable = false;
+}
+
 static void tt_ascalon_cluster_init(Object *obj)
 {
     TTAscalonClusterState *ac = TT_ASCALON_CLUSTER(obj);
@@ -647,11 +774,48 @@ static void tt_atlantis_soc_init(Object *obj)
     }
 }
 
+/*
+ * Create and add a new alias to a memory container
+ * @obj
+ * @m MemoryRegion container for the alias to be added to
+ * @orig MemoryRegion original region to be aliased
+ *    Ascalon memory
+ * @size of the subregion
+ * @base address of the subregion
+ * @name for the alias being added to the RCPU memory
+ */
+static void create_alias(Object *obj, MemoryRegion *m,
+        MemoryRegion *orig, hwaddr size, hwaddr base, const char *name)
+{
+    MemoryRegion *alias = g_new(MemoryRegion, 1);
+
+    memory_region_init_alias(alias, obj, name, orig, 0,
+                             size);
+    memory_region_add_subregion(m, base, alias);
+}
+
+/*
+ * Alias a device to a memory container
+ * @obj
+ * @m MemoryRegion container for the alias to be added to
+ * @dev Device to be added.
+ * @size of the subregion
+ * @base address of the subregion
+ * @name for the alias being added to the RCPU memory
+ */
+static void create_device_alias(Object *obj, MemoryRegion *m, DeviceState *dev,
+        hwaddr size, hwaddr base, const char *name)
+{
+    MemoryRegion *orig = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    create_alias(obj, m, orig, size, base, name);
+}
+
 static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 {
     TTAtlantisSoCState *s = TT_ATLANTIS_SOC(dev);
     TTAscalonClusterState *ac = &s->ascalon;
-    ram_addr_t lo_ram_size, ram_size;
+    TTRCPUClusterState *rc = &s->rcpu;
+    ram_addr_t lo_ram_size, ram_size, rcpu_ram_size;
     int hart_count = ac->num_harts;
 
     if (!s->dram) {
@@ -663,6 +827,14 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->has_rcpu) {
+        /* Only create the RCPU if it is enabled */
+        object_initialize_child(OBJECT(s), "rcpu", &s->rcpu, TYPE_TT_RCPU_CLUSTER);
+        if (!qdev_realize(DEVICE(&s->rcpu), NULL, errp)) {
+            return;
+        }
+    }
+
     ram_size = memory_region_size(s->dram);
 
     s->irqchip = riscv_create_aia(&ac->memory,
@@ -708,6 +880,23 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
                              0, lo_ram_size);
     memory_region_add_subregion(&ac->memory,
                                 ac->memmap[TT_ATL_DDR_LO].base, &s->ram_lo);
+    if (s->has_rcpu) {
+        /*
+         * The RCPU has a 1G view of lower DDR. DDR low size can be configured by
+         * the command line parameters so pick the minimum between 1G and the user
+         * provided size.
+         */
+        rcpu_ram_size = MIN(rc->memmap[TT_ATL_DDR_LO].size, lo_ram_size);
+        create_alias(OBJECT(s), &rc->memory, &s->ram_lo,
+                     rcpu_ram_size,
+                     rc->memmap[TT_ATL_DDR_LO].base,
+                     "tt-rcpu.ram");
+
+        /* UART0, the RCPU console */
+        qdev_prop_set_chr(DEVICE(&s->uart[tt_atlantis_uart_index(TT_ATL_UART0)]),
+                          "chardev", serial_hd(1));
+    }
+
 
     /* 4 PRCM blocks */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]),
@@ -718,6 +907,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         &ac->memory, ac->memmap[TT_ATL_PRCM_RCPU].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]), 0));
+    if (s->has_rcpu) {
+        create_device_alias(OBJECT(s), &rc->memory,
+                            DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]),
+                            rc->memmap[TT_ATL_PRCM_RCPU].size,
+                            rc->memmap[TT_ATL_PRCM_RCPU].base,
+                            "tt-rcpu.rcpu-prcm");
+    }
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO]),
                         errp)) {
@@ -727,6 +923,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         &ac->memory, ac->memmap[TT_ATL_PRCM_HSIO].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO]), 0));
+    if (s->has_rcpu) {
+        create_device_alias(OBJECT(s), &rc->memory,
+                            DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO]),
+                            rc->memmap[TT_ATL_PRCM_HSIO].size,
+                            rc->memmap[TT_ATL_PRCM_HSIO].base,
+                            "tt-rcpu.rcpu-hsio");
+    }
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE]),
                         errp)) {
@@ -736,6 +939,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         &ac->memory, ac->memmap[TT_ATL_PRCM_PCIE].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE]), 0));
+    if (s->has_rcpu) {
+        create_device_alias(OBJECT(s), &rc->memory,
+                            DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE]),
+                            rc->memmap[TT_ATL_PRCM_PCIE].size,
+                            rc->memmap[TT_ATL_PRCM_PCIE].base,
+                            "tt-rcpu.rcpu-pcie");
+    }
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]),
                         errp)) {
@@ -745,8 +955,15 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         &ac->memory, ac->memmap[TT_ATL_PRCM_MM].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]), 0));
+    if (s->has_rcpu) {
+        create_device_alias(OBJECT(s), &rc->memory,
+                            DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]),
+                            rc->memmap[TT_ATL_PRCM_MM].size,
+                            rc->memmap[TT_ATL_PRCM_MM].base,
+                            "tt-rcpu.rcpu-mm");
+    }
 
-    /* UART1, the soc console (UART0 is for the boot microcontroller) */
+    /* UART1, the soc console */
     qdev_prop_set_chr(DEVICE(&s->uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
                       "chardev", serial_hd(0));
 
@@ -761,6 +978,16 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
                                     sysbus_mmio_get_region(sbd, 0));
         sysbus_connect_irq(sbd, 0,
                            qdev_get_gpio_in(s->irqchip, TT_ATL_UART0_IRQ + i));
+
+        if (s->has_rcpu) {
+            /* Alias the devices to the rcpu memory view */
+            g_autofree char *name = g_strdup_printf("tt-rcpu.uart%d", i);
+
+            create_device_alias(OBJECT(s), &rc->memory, DEVICE(&s->uart[i]),
+                                rc->memmap[TT_ATL_UART0 + i].size,
+                                rc->memmap[TT_ATL_UART0 + i].base,
+                                name);
+        }
     }
 
     /* I2C */
@@ -781,6 +1008,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 static const Property tt_atlantis_soc_props[] = {
     DEFINE_PROP_LINK("dram", TTAtlantisSoCState, dram,
                      TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_BOOL("has-rcpu", TTAtlantisSoCState, has_rcpu, false)
 };
 
 static void tt_atlantis_soc_class_init(ObjectClass *oc, const void *data)
@@ -798,20 +1026,44 @@ static void tt_atlantis_machine_init(MachineState *machine)
     TTAtlantisState *ams = TT_ATLANTIS_MACHINE(machine);
     TTAtlantisSoCState *s = &ams->soc;
     TTAscalonClusterState *ac = &s->ascalon;
+    uint32_t num_asc_harts;
 
     object_initialize_child(OBJECT(machine), "soc", &ams->soc,
                             TYPE_TT_ATLANTIS_SOC);
 
-    /* User input machine properties, cpu_type and smp.cpus apply to Ascalon */
+    /*
+     * The smp must include the RCPU since smp.cpus limits the total number of
+     * CPUs that TCG creates. If RCPU is enabled, remove it from the hart count
+     * passed to Ascalon.
+     */
+    if (ams->has_rcpu) {
+        if (machine->smp.cpus <= 1) {
+            error_report("smp.cpus must be at least 2 when RCPU is enabled. " \
+                         "Run with ,rcpu=off to disable RCPU.");
+            exit(1);
+        }
+        num_asc_harts = machine->smp.cpus - 1;
+    } else {
+        if (machine->smp.cpus > 8) {
+            error_report("smp.cpus must be 8 or less when RCPU is not enabled. " \
+                         "Run with ,rcpu=off -smp cpus=8 for 8 Ascalon cores " \
+                         "and no RCPU.");
+            exit(1);
+        }
+        num_asc_harts = machine->smp.cpus;
+    }
+
     object_property_set_str(OBJECT(ac), "cpu-type",
                             machine->cpu_type,
                             &error_abort);
     object_property_set_int(OBJECT(ac), "num-harts",
-                            machine->smp.cpus,
+                            num_asc_harts,
                             &error_abort);
 
     object_property_set_link(OBJECT(s), "dram", OBJECT(machine->ram),
                              &error_abort);
+    object_property_set_bool(OBJECT(&ams->soc), "has-rcpu", ams->has_rcpu,
+                             &error_abort);
 
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
 
@@ -830,19 +1082,47 @@ static void tt_atlantis_machine_init(MachineState *machine)
     qemu_add_machine_init_done_notifier(&ams->machine_done);
 }
 
+static bool tt_atlantis_machine_get_rcpu(Object *obj, Error **errp)
+{
+    TTAtlantisState *s = TT_ATLANTIS_MACHINE(obj);
+
+    return s->has_rcpu;
+}
+
+static void tt_atlantis_machine_set_rcpu(Object *obj, bool value, Error **errp)
+{
+    TTAtlantisState *s = TT_ATLANTIS_MACHINE(obj);
+
+    s->has_rcpu = value;
+}
+
 static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    ObjectProperty *prop;
 
     mc->desc = "Tenstorrent Atlantis RISC-V SoC (Experimental)";
     mc->init = tt_atlantis_machine_init;
-    mc->max_cpus = 8;
-    mc->default_cpus = 8;
+    /*
+     * The smp count must include the RCPU since tcg limits the number of
+     * threads created based on it. When rcpu=on, the number of Ascalon harts
+     * created is smp.cpus - 1. When rcpu=off, the number of Ascalon harts is
+     * smp.cpus.
+     */
+    mc->max_cpus = 9;
+    mc->default_cpus = 8; /* Default to no RCPU */
     mc->default_ram_size = 4 * GiB;
     mc->default_cpu_type = TYPE_RISCV_CPU_TT_ASCALON;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->default_ram_id = "tt_atlantis.ram";
+
+    prop = object_class_property_add_bool(oc, "rcpu", tt_atlantis_machine_get_rcpu,
+                                   tt_atlantis_machine_set_rcpu);
+    object_class_property_set_description(oc, "rcpu",
+                                          "Set to enable/disable modeling the RCPU.");
+    object_property_set_default_bool(prop, false);
+
 }
 
 static const TypeInfo tt_atlantis_types[] = {
@@ -852,6 +1132,12 @@ static const TypeInfo tt_atlantis_types[] = {
         .instance_size = sizeof(TTAscalonClusterState),
         .instance_init = tt_ascalon_cluster_init,
         .class_init = tt_ascalon_cluster_class_init,
+    }, {
+        .name       = TYPE_TT_RCPU_CLUSTER,
+        .parent     = TYPE_DEVICE,
+        .instance_size = sizeof(TTRCPUClusterState),
+        .instance_init = tt_rcpu_cluster_init,
+        .class_init = tt_rcpu_cluster_class_init,
     }, {
         .name       = TYPE_TT_ATLANTIS_SOC,
         .parent     = TYPE_DEVICE,
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index e5fce1f675..5a200410f3 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -16,6 +16,7 @@
 #include "hw/misc/tt_atlantis_prcm.h"
 #include "hw/char/dw8250.h"
 #include "hw/cpu/cluster.h"
+#include "hw/misc/unimp.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
@@ -27,6 +28,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisSoCState, TT_ATLANTIS_SOC)
 #define TYPE_TT_ASCALON_CLUSTER "riscv.tt-ascalon-cluster"
 OBJECT_DECLARE_SIMPLE_TYPE(TTAscalonClusterState, TT_ASCALON_CLUSTER)
 
+#define TYPE_TT_RCPU_CLUSTER "riscv.tt-rcpu-cluster"
+OBJECT_DECLARE_SIMPLE_TYPE(TTRCPUClusterState, TT_RCPU_CLUSTER)
+
 #define TT_ATL_NUM_I2C 5
 #define TT_ATL_NUM_PRCM 4
 #define TT_ATL_NUM_UARTS 5
@@ -48,12 +52,27 @@ struct TTAscalonClusterState {
     char *cpu_type;
 };
 
+struct TTRCPUClusterState {
+    /*< private >*/
+    DeviceState parent;
+
+    /*< public >*/
+    const MemMapEntry *memmap;
+    MemoryRegion memory;
+
+    RISCVHartArrayState cpus;
+    CPUClusterState cluster;
+    MemoryRegion bootrom;
+    MemoryRegion sram;
+};
+
 struct TTAtlantisSoCState {
     /*< private >*/
     DeviceState parent;
 
     /*< public >*/
     TTAscalonClusterState ascalon;
+    TTRCPUClusterState rcpu;
 
     MemoryRegion *dram;
     MemoryRegion ram_hi;
@@ -63,6 +82,8 @@ struct TTAtlantisSoCState {
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
     DW8250State uart[TT_ATL_NUM_UARTS];
     TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
+
+    bool has_rcpu;              /* Enable RCPU */
 };
 
 struct TTAtlantisState {
@@ -73,6 +94,8 @@ struct TTAtlantisState {
     Notifier machine_done;
 
     TTAtlantisSoCState soc;
+
+    bool has_rcpu;              /* Enable RCPU */
 };
 
 enum {
@@ -93,15 +116,28 @@ enum {
     TT_ATL_BOOTROM,
     TT_ATL_DDR_LO,
     TT_ATL_DDR_HI,
+    TT_ATL_GPIO,
     TT_ATL_I2C0,
     TT_ATL_I2C1,
     TT_ATL_I2C2,
     TT_ATL_I2C3,
     TT_ATL_I2C4,
+    TT_ATL_IO_CTRL,
     TT_ATL_MAPLIC,
     TT_ATL_MIMSIC,
+    TT_ATL_NOCM_FIREWALL,
+    TT_ATL_OTP,
+    TT_ATL_QSPI,
+    TT_ATL_RCPU_CLIC,
+    TT_ATL_RCPU_CLINT,
+    TT_ATL_RCPU_MAILBOX,
+    TT_ATL_RCPU_SMN_FIREWALL,
+    TT_ATL_RCPU_SRAM,
     TT_ATL_SAPLIC,
+    TT_ATL_SDHCI0,
+    TT_ATL_SDHCI1,
     TT_ATL_SIMSIC,
+    TT_ATL_SPACC,
     TT_ATL_UART0,
     TT_ATL_UART1,
     TT_ATL_UART2,
@@ -111,6 +147,14 @@ enum {
     TT_ATL_PRCM_HSIO,
     TT_ATL_PRCM_PCIE,
     TT_ATL_PRCM_MM,
+    TT_ATL_PRCM_ASC,
+    TT_ATL_PRCM_DDR0,
+    TT_ATL_PRCM_DDR1,
+    TT_ATL_DDRC0_CTRL,
+    TT_ATL_DDRC1_CTRL,
+    TT_ATL_PRCM_TRNG,
+    TT_ATL_WDT0,
+    TT_ATL_WDT1,
 };
 
 /*
-- 
2.43.0


