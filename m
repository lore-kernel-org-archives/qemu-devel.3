Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B76C27C50
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 02:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEg0w-0007PS-6D; Tue, 04 Jun 2024 22:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEg0t-0007OX-TV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:04:31 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEg0s-00076m-1Y
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:04:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 96E5411401F0;
 Tue,  4 Jun 2024 22:04:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Tue, 04 Jun 2024 22:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717553069;
 x=1717639469; bh=qsdV9vskjuBmzS46VzX1Mqyfv9fGhQMQDsiIY2hOhAw=; b=
 l8p/leYiWfSc+waSWY4rB3PctPa2dtq3xPdXXo4h8upIyv/7fm3CehScmpjdlW5E
 jf3vMGiwrqQzZtMI5ZEkvcuGB+b+yq2tBamm3QFLkOEM0FaBbPbIG7mbGns/cRTg
 biCu0HiPh3NGqhX+WQx3CaMzjPWDxVzvc/ANtte609lGwDWI8FkPM7WFesImpYmu
 /sHEnGiGB5HUh0ZiEWEbL/4+JlZzf0XmjyKPjxrx1qKTXwLoeS/NNP3XKUcNHxKT
 dhZUELy3Rrv735/oIjNkxGEFt0MlKnb328wjFDxy2CwTuYFwbw84tbEqNQ0lDMgK
 ST8lq2p1UfY9jXJzAYDWAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717553069; x=
 1717639469; bh=qsdV9vskjuBmzS46VzX1Mqyfv9fGhQMQDsiIY2hOhAw=; b=n
 LDCLHCQnahQRQoVIVyRCkUbDDkn9fI08WxBhXr+dwTIkLpe/UOwc54cokcu2vlIY
 g0XhPI/b9b/rg3mKZv31bdlxXHsAsQ4uv8ZVTkpMKnQNf6JpzdRgpsKgGETZ+69L
 5ibO2YMuPm27BftK0jHhYlS+jjzMpmBGJa8aN79a5QOFLhPS5B4qYjwDgpTGwSo3
 9SoaTxfvuw52p1PQ7AkFUaG1370GwCxXAxcMMBjEc8PXaLwyhM9iRrGvsV0i8WgI
 uVSV72aIqLa8OXP9UKcDAWL5erVaLtvcE1Qzc367GHunnz552ZHU+x36GCBAhu5M
 mBoLeiHGZlelW7RUyAt0g==
X-ME-Sender: <xms:rcdfZhGrXHKCN0juXQmlbOJQP889T8e--izCXPcezEHR6IsRRreT5w>
 <xme:rcdfZmU4yKxvXAGElc9Sg7N_QUxEPtNAqu3mhK0VLiXYjiNUt9YyNeWhZFF9SrcGy
 rYhK1Lzg-PvOqlVaV8>
X-ME-Received: <xmr:rcdfZjIZZ_5TTouTnBdNareS0QEidzPwY_6DzdnAzWBDxjVW8rxyP7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgheehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:rcdfZnEShM0HUf2Jw4ieNySl_bxz0ksikmkhmOJITVOs7vE-k7NSfg>
 <xmx:rcdfZnUkPWRbCbN6AtX-xqoMeijYZ1ZWnPFgJCSg8_yFbMF04seFYw>
 <xmx:rcdfZiNAjC9ycIpJGS5_OBQjpD6wNU9GEjD0E1oTnxW2KVGPfzc3WQ>
 <xmx:rcdfZm1SOC1JpA53QC79oaiApJLKZyExXtLdKADqv6ikywHBqlY5Bg>
 <xmx:rcdfZtfIkl-2ykKReLXqLHHtkRTGCXwVnDv0eAIh--9Yi5_oAsfAWe0w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 22:04:28 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 05 Jun 2024 03:04:25 +0100
Subject: [PATCH v2 2/4] hw/intc/loongson_ipi: Provide per core MMIO address
 spaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-loongson3-ipi-v2-2-da26282e03a5@flygoat.com>
References: <20240605-loongson3-ipi-v2-0-da26282e03a5@flygoat.com>
In-Reply-To: <20240605-loongson3-ipi-v2-0-da26282e03a5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6577;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=LZOgZg61JSx7cogFY2kbLtUvCEt/U75uCJMoXwV6gt0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT44yvl1SefWjXlJOfcOONvon8bjj6YVLzg9AKW7VyWb
 mv7TrLzd5SyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBEUioZGboDLA7Pmhq7zP2b
 u3Q5b4/nwV1P+6Ln3xOJe7vyeRH/mo8M/ytrjubpbH/3c+5nN513/bcflC+dWHh5h/njzKvtFz9
 PmMsMAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The real IPI hardware have dedicated MMIO registers mapped into
memory address space for every core. This is not used by LoongArch
guest software but it is essential for CPU without IOCSR such as
Loongson-3A1000.

Implement it with existing infrastructure.

Acked-by: Song Gao <gaosong@loongson.cn>
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
2.43.0


