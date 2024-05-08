Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75AAC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h0g-0007vG-0u; Wed, 08 May 2024 09:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0Z-0007sJ-Hd
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:56 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0X-0006PV-H6
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:55 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.nyi.internal (Postfix) with ESMTP id F045113803A6;
 Wed,  8 May 2024 09:06:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Wed, 08 May 2024 09:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715173612;
 x=1715260012; bh=RLUTVcMYeWlv3Ho8uYbWMdwj3HHOqbbEKZcxsF1spRI=; b=
 EKvpRoIRzGOONjbj1NA0zVLqT67uAJZrLlUUMrsHuWuYfKwtM+E/tEt7OgVwMHfW
 7UrdizTCC4RZsnSaTITv7U8uY6rMZV7hUt+wH13v/XmTUxTMzfEThPdccXuxsSjA
 RiG4ux7amRKP9YDIZizKPmb6egvUx6M1iSIMWCjxA0AC8wOO9LoSbChJ/fm0jGf7
 RyIS03tWt86dxG5zKtfS0pU1/bOA7KyJv/0nKXewsAePwjSUQlxzSr5OMJMwmygP
 ABtElHhga5fOw/tlsb6SuJytuN10cUPLg5v03eu5ZCFv8lYGC6ikwxLCB6ueri0y
 EabIR8EdqQMkqtCrCEEO0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715173612; x=
 1715260012; bh=RLUTVcMYeWlv3Ho8uYbWMdwj3HHOqbbEKZcxsF1spRI=; b=W
 h0O2hh9JDU4XopLx2mw0nYaQmcWkpGeds7pNP33gl+2j2M85IyH93BbTLEXla1+G
 XIyjklK0OaedPdB1moOfVPR3GS6XKIo3BEVgY143I+CATn+R6Cr01vjO4XDEOGh1
 bb5yIl/L0x3E4OycFxPlZ7QH3HRg/wlHEbJfvAAMO+S9ojapBJ8Sp/ZhQoPx16bx
 zIyvwlUmNDsXR5kfTdIhXZmadj6UZAqx6V5+MhjFkxIgHaffmMfsmRiktOeOq1mB
 RBGyGsNX1q/RbcBRoo9mVjK+dXeflxPOW98Rf8AIpT9O2ufuR0Olj5PzxrUGN6ll
 kB7VAZJN52kTJz6WW2y0w==
X-ME-Sender: <xms:7Hg7ZgUIOrQa8tsPv7dLL8H-n2w6h1QLmsKyaW1VzVHL2BcruehVdQ>
 <xme:7Hg7ZkkEfOL6ZHAOvvnBSUFR4D2RT7qcP2-p6PFrSz6Cinb1H1CwzfxGsKEzygeQR
 vyQySvWqbexLG7K7lc>
X-ME-Received: <xmr:7Hg7ZkbBUxMqGcxVO_IY_LZwUuI2nqpBwBd6IZyQGz43fwb3OZtQtts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:7Hg7ZvWauZ-XS3_qjjYJiNs0X_mU3JOaC2iGppZ4QIafPgPeNda2QA>
 <xmx:7Hg7ZqncXk9qwfYGWdque_7VAQhn-yZaexUULmtee43LeFvrmw3n2w>
 <xmx:7Hg7ZkdmVoAQuzEWEFh48S1NwU6fj6UZoM_rzrMQRGXSudcUYWkwRQ>
 <xmx:7Hg7ZsHnvpKndTfjufjBso-jzVE9s4yUxHPsoT5IxSGnqvQH4f2RMw>
 <xmx:7Hg7ZhsqndfLeEq14FOd9y0-dFneFO6_Q_zgpxudbtG2gk1bW5duxBmV>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 09:06:51 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 08 May 2024 14:06:49 +0100
Subject: [PATCH 4/5] hw/intc/loongson_ipi: Provide per core MMIO address spaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-loongson3-ipi-v1-4-1a7b67704664@flygoat.com>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
In-Reply-To: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6535;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=VxxrJORtTvGfo3DCiIMPAxsYETXSZd6msJZevyJnYpo=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTriucOLLeSWg3a5x55x8Zbx3F7zz6LcyczF+qtmX701
 2cNbXHpjlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjI44+MDA+cFDfxa+8Kf7Ui
 5ejSOyfkmuySMy9qGe+cVWi51yzY0IXhr2zqwsDSdZc+eAhlNn/xUVMRSZR7/NPwrJEhfwjb8vt
 xXAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

The real IPI hardware have dedicated MMIO registers mapped into
memory address space for every core. This is not used by LoongArch
guest software but it is essential for CPU without IOCSR such as
Loongson-3A1000.

Implement it with existing infrastructure.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/intc/loongson_ipi.c         | 81 ++++++++++++++++++++++++++++++++----------
 include/hw/intc/loongson_ipi.h |  2 ++
 2 files changed, 64 insertions(+), 19 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 93cc50a37a11..c8a25b4eb8e2 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -23,16 +23,14 @@
 #endif
 #include "trace.h"
 
-static MemTxResult loongson_ipi_readl(void *opaque, hwaddr addr,
+static MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr,
                                        uint64_t *data,
                                        unsigned size, MemTxAttrs attrs)
 {
-    IPICore *s;
-    LoongsonIPI *ipi = opaque;
+    IPICore *s = opaque;
     uint64_t ret = 0;
     int index = 0;
 
-    s = &ipi->cpu[attrs.requester_id];
     addr &= 0xff;
     switch (addr) {
     case CORE_STATUS_OFF:
@@ -61,6 +59,21 @@ static MemTxResult loongson_ipi_readl(void *opaque, hwaddr addr,
     return MEMTX_OK;
 }
 
+static MemTxResult loongson_ipi_iocsr_readl(void *opaque, hwaddr addr,
+                                       uint64_t *data,
+                                       unsigned size, MemTxAttrs attrs)
+{
+    LoongsonIPI *ipi = opaque;
+    IPICore *s;
+
+    if (attrs.requester_id >= ipi->num_cpu) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    s = &ipi->cpu[attrs.requester_id];
+    return loongson_ipi_core_readl(s, addr, data, size, attrs);
+}
+
 static AddressSpace *get_cpu_iocsr_as(CPUState *cpu)
 {
 #ifdef TARGET_LOONGARCH64
@@ -174,17 +187,17 @@ static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
     return send_ipi_data(cs, val, addr, attrs);
 }
 
-static MemTxResult loongson_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
-                                        unsigned size, MemTxAttrs attrs)
+static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
+                                            uint64_t val, unsigned size,
+                                            MemTxAttrs attrs)
 {
-    LoongsonIPI *ipi = opaque;
-    IPICore *s;
+    IPICore *s = opaque;
+    LoongsonIPI *ipi = s->ipi;
     int index = 0;
     uint32_t cpuid;
     uint8_t vector;
     CPUState *cs;
 
-    s = &ipi->cpu[attrs.requester_id];
     addr &= 0xff;
     trace_loongson_ipi_write(size, (uint64_t)addr, val);
     switch (addr) {
@@ -215,13 +228,11 @@ static MemTxResult loongson_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
         /* IPI status vector */
         vector = extract8(val, 0, 5);
         cs = ipi_getcpu(cpuid);
-        if (cs == NULL) {
+        if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
             return MEMTX_DECODE_ERROR;
         }
-
-        /* override requester_id */
-        attrs.requester_id = cs->cpu_index;
-        loongson_ipi_writel(ipi, CORE_SET_OFF, BIT(vector), 4, attrs);
+        loongson_ipi_core_writel(&ipi->cpu[cs->cpu_index], CORE_SET_OFF,
+                                 BIT(vector), 4, attrs);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
@@ -231,9 +242,34 @@ static MemTxResult loongson_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
     return MEMTX_OK;
 }
 
-static const MemoryRegionOps loongson_ipi_ops = {
-    .read_with_attrs = loongson_ipi_readl,
-    .write_with_attrs = loongson_ipi_writel,
+static MemTxResult loongson_ipi_iocsr_writel(void *opaque, hwaddr addr,
+                                            uint64_t val, unsigned size,
+                                            MemTxAttrs attrs)
+{
+    LoongsonIPI *ipi = opaque;
+    IPICore *s;
+
+    if (attrs.requester_id >= ipi->num_cpu) {
+        return MEMTX_DECODE_ERROR;
+    }
+
+    s = &ipi->cpu[attrs.requester_id];
+    return loongson_ipi_core_writel(s, addr, val, size, attrs);
+}
+
+static const MemoryRegionOps loongson_ipi_core_ops = {
+    .read_with_attrs = loongson_ipi_core_readl,
+    .write_with_attrs = loongson_ipi_core_writel,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 8,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static const MemoryRegionOps loongson_ipi_iocsr_ops = {
+    .read_with_attrs = loongson_ipi_iocsr_readl,
+    .write_with_attrs = loongson_ipi_iocsr_writel,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
     .valid.min_access_size = 4,
@@ -282,7 +318,7 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), &loongson_ipi_ops,
+    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), &loongson_ipi_iocsr_ops,
                           s, "loongson_ipi_iocsr", 0x48);
 
     /* loongson_ipi_iocsr performs re-entrant IO through ipi_send */
@@ -297,11 +333,18 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
 
     s->cpu = g_new0(IPICore, s->num_cpu);
     if (s->cpu == NULL) {
-        error_setg(errp, "Memory allocation for ExtIOICore faile");
+        error_setg(errp, "Memory allocation for IPICore faile");
         return;
     }
 
     for (i = 0; i < s->num_cpu; i++) {
+        s->cpu[i].ipi = s;
+        s->cpu[i].ipi_mmio_mem = g_new0(MemoryRegion, 1);
+        g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
+        memory_region_init_io(s->cpu[i].ipi_mmio_mem, OBJECT(dev),
+                              &loongson_ipi_core_ops, &s->cpu[i], name, 0x48);
+        sysbus_init_mmio(sbd, s->cpu[i].ipi_mmio_mem);
+
         qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
     }
 }
diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 2c0e8820f5ec..3f795edbf3cd 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -34,6 +34,8 @@
 OBJECT_DECLARE_SIMPLE_TYPE(LoongsonIPI, LOONGSON_IPI)
 
 typedef struct IPICore {
+    LoongsonIPI *ipi;
+    MemoryRegion *ipi_mmio_mem;
     uint32_t status;
     uint32_t en;
     uint32_t set;

-- 
2.34.1


