Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E46606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 04:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=MGbtxJTo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLvKd-0007aI-FJ; Wed, 28 Oct 2026 00:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvKQ-0007Xn-Q6
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:32:05 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvKM-0001eO-KK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:31:57 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ad6499e88fso59093a91.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 21:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793161913; x=1793766713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rK4+ypnQTZhhOcJIA4YJU8OvpNb5JEMgbR5fN2fOn90=;
 b=MGbtxJTo5j7sLKhCRRDUnvj5zc1D/tdLFVgvTN8CHEwzxEh86gFWClZs84Q8sIEPr8
 cl2tjrjfSe/yyeGjswHlNZ33GjRg6203PuszwQNpFAR9E9o03g5uCs9Vzjzb+ozbBAJG
 HJ5shl3njx4G2CHAAXZfZoSmtqGdZNCAqodOmXLIgMSFYxetEhv52HeMHwUVds1pWuUh
 ccb2Dh9mz9Z5TGNKkFe7mUFJYp5C6MRxxvQEhEygJG3ELyZSnC32WcX3MEbTrrQB+uKz
 pk9fPGrWgSd8sAUJ/XBQsy9LzAA+DCFkDe+c1OyIoG7kN641G2GVV7+25Igtg/yRrZhw
 YrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793161913; x=1793766713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rK4+ypnQTZhhOcJIA4YJU8OvpNb5JEMgbR5fN2fOn90=;
 b=FG9uQMB896QQj+M5Wrt5LVT8VSptZCGw/X8XjMXllrLZL3J4wY+2G2yzC1mIXXzofN
 jxvBCJdJBiahCrkCgOylFzwjz4fgHRUVYRBN8n/5EexZG1mGRd5EbQk/6jAjNTCh4mJM
 BDCTehOlC5vsxWZhN26xSPtCd6xmtVv6YkWzdZnvdMjTrhgv/9wv+OU8k8m7j4uylEiD
 yZbQ9GIYqvnbQvPoUbvf/fbHgCDz7i+nR4lPYEDshks31XoZx42XLgBxLyawUrp2rdiU
 JM5uGlQ/q0txC6o6jZpvuIjSynTGO5YcxcatMGEJof4mUolHtd14tVNUEQGR0VaOCaue
 c+Ew==
X-Gm-Message-State: AFq9FYKDpQfeI/Sqyw+KCYFYuP+n07hTfxsws4+Bk55Jcv0CVIxYY071
 J+GHEZDRz7Zm/SEFwYGTRHLQZ1zrATQ+G+lzOrX6iOdUAYEE8jZ/z0DxtsDAy+PkqHeEBJd0T/x
 08V5KgGY=
X-Gm-Gg: AYBFou2cYEq++S9m+em2XZ9Slo9Le9kyVWwAa60wqpjVn6XZLIJj0ViRIlAFFbwdqzT
 sSQi9eufXTN5CZUuWMettQrapXMVv5uleYz9cbTPAAP850fG7Az8c/GC1y+7qbO+bExWcMv6Y9L
 Kc9+/phxPp3Biqum1TTi5GQWewLuhFNBbXgPcrlCPze9cfM2eVsEjKw8bMBC5cxjiCilMSgb7oH
 aCr3MlBGt7EiBfLW0rtcjchr4pjMlU/v+fkF1GCIIXAxXUwKOhERpcU9nUaYL/0ExVYrqos8BM3
 v21qGS9oUxBUWlbBUo2slHCwFjnSgvTZyN3W0E5I6mYanLp7VLc493lE7sptR1KGOD9ce+zVbQV
 rSqBpxVax3CKaQIX3IyOh5UHh3m84RSH9vQybA8h+N+CW4S6oigpWHBx0klrnEyNHqKt7ygYzrl
 i1qbtvpVFSj8NbbMyZr2Z+IZ7dfk7QR8IIlGrAhUU9je82wb5EcDOp+jPWTdubn2BdKofoQs6gV
 CQ9oIpUdwDODJLuF34KBCMkGkUXa+7kVVoorqjqUa6ZtzfEJqnqX5rd6I7YRInGPwlLYjtXNER4
 JYpQmZqFm36rxum1n9B/gO5WAndz/X0G62DEc+x4KBZtymCPwKv1ykWQ8pNTseG+8f/hTyenvtk
 N5g==
X-Received: by 2002:a17:90b:1cd0:b0:3ac:a11a:7c88 with SMTP id
 98e67ed59e1d1-3ae581cece4mr1513251a91.3.1793161911555; 
 Tue, 27 Oct 2026 21:31:51 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a5d45a8sm1024470a91.17.2026.10.27.21.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 21:31:51 -0700 (PDT)
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
Subject: [PATCH v2 06/10] hw/riscv/atlantis: Add the RCPU to the Atlantis SoC
Date: Wed, 28 Oct 2026 14:30:55 +1000
Message-ID: <20261028043059.600498-7-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028043059.600498-1-portias@oss.tenstorrent.com>
References: <20261028043059.600498-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x1034.google.com
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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
 hw/riscv/tt_atlantis.c         | 278 ++++++++++++++++++++++++++++++++-
 include/hw/riscv/tt_atlantis.h |  45 ++++++
 2 files changed, 317 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 587c6ea733..edf2180a98 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -51,6 +51,7 @@ QEMU_BUILD_BUG_ON(TT_IMSIC_STRIDE != (0x1000 << TT_IMSIC_GUEST_BITS));
 #define TT_ACLINT_TIMEBASE_FREQ 1000000000
 
 #define ASCALON_CLUSTER_ID     0
+#define RCPU_CLUSTER_ID        1
 
 static const MemMapEntry tt_atlantis_memmap[] = {
     /* Keep sorted with :'<,'>!sort -g -k 4 */
@@ -78,6 +79,44 @@ static const MemMapEntry tt_atlantis_memmap[] = {
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
 static I2CBus *i2c_get_bus(TTAtlantisSoCState *s, unsigned busnr)
 {
     assert(busnr < TT_ATL_NUM_I2C);
@@ -549,6 +588,78 @@ static inline int tt_atlantis_uart_index(int uart_dev)
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
+}
+
+static void tt_rcpu_cluster_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = tt_rcpu_cluster_realize;
+}
+
 static void tt_ascalon_cluster_init(Object *obj)
 {
     TTAscalonClusterState *ac = TT_ASCALON_CLUSTER(obj);
@@ -645,11 +756,48 @@ static void tt_atlantis_soc_init(Object *obj)
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
@@ -661,6 +809,14 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
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
@@ -706,6 +862,23 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
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
@@ -716,6 +889,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
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
@@ -725,6 +905,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
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
@@ -734,6 +921,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
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
@@ -743,8 +937,15 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
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
 
@@ -759,6 +960,16 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
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
@@ -779,6 +990,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 static const Property tt_atlantis_soc_props[] = {
     DEFINE_PROP_LINK("dram", TTAtlantisSoCState, dram,
                      TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_BOOL("has-rcpu", TTAtlantisSoCState, has_rcpu, false)
 };
 
 static void tt_atlantis_soc_class_init(ObjectClass *oc, const void *data)
@@ -796,20 +1008,40 @@ static void tt_atlantis_machine_init(MachineState *machine)
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
+    num_asc_harts = machine->smp.cpus;
+    if (ams->has_rcpu) {
+        if (num_asc_harts <= 1) {
+            error_report("smp.cpus must be at least 2 when RCPU is enabled. " \
+                         "Run with ,rcpu=off to disable RCPU.");
+            exit(1);
+        }
+        num_asc_harts--;
+    }
+
+    /* Default smp with be 9 even when RCPU is disabled */
+    num_asc_harts = MIN(num_asc_harts, 8);
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
 
@@ -828,19 +1060,47 @@ static void tt_atlantis_machine_init(MachineState *machine)
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
+    mc->default_cpus = 9;
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
+    object_property_set_default_bool(prop, true);
+
 }
 
 static const TypeInfo tt_atlantis_types[] = {
@@ -850,6 +1110,12 @@ static const TypeInfo tt_atlantis_types[] = {
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
index e5fce1f675..ceb138dc88 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -27,6 +27,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisSoCState, TT_ATLANTIS_SOC)
 #define TYPE_TT_ASCALON_CLUSTER "riscv.tt-ascalon-cluster"
 OBJECT_DECLARE_SIMPLE_TYPE(TTAscalonClusterState, TT_ASCALON_CLUSTER)
 
+#define TYPE_TT_RCPU_CLUSTER "riscv.tt-rcpu-cluster"
+OBJECT_DECLARE_SIMPLE_TYPE(TTRCPUClusterState, TT_RCPU_CLUSTER)
+
 #define TT_ATL_NUM_I2C 5
 #define TT_ATL_NUM_PRCM 4
 #define TT_ATL_NUM_UARTS 5
@@ -48,12 +51,27 @@ struct TTAscalonClusterState {
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
@@ -63,6 +81,8 @@ struct TTAtlantisSoCState {
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
     DW8250State uart[TT_ATL_NUM_UARTS];
     TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
+
+    bool has_rcpu;              /* Enable RCPU */
 };
 
 struct TTAtlantisState {
@@ -73,6 +93,8 @@ struct TTAtlantisState {
     Notifier machine_done;
 
     TTAtlantisSoCState soc;
+
+    bool has_rcpu;              /* Enable RCPU */
 };
 
 enum {
@@ -93,15 +115,28 @@ enum {
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
@@ -111,6 +146,16 @@ enum {
     TT_ATL_PRCM_HSIO,
     TT_ATL_PRCM_PCIE,
     TT_ATL_PRCM_MM,
+    TT_ATL_PRCM_DDRC0,
+    TT_ATL_PRCM_DDRC1,
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


