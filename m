Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EE0C27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 02:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEgBU-00036x-LC; Tue, 04 Jun 2024 22:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEgBP-000364-FU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:15:23 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEgBI-0001gH-IZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:15:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id D651D11401FD;
 Tue,  4 Jun 2024 22:15:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 04 Jun 2024 22:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717553712;
 x=1717640112; bh=qsdV9vskjuBmzS46VzX1Mqyfv9fGhQMQDsiIY2hOhAw=; b=
 vwZjD6EKtKNXclIPIOFCad4jlUgSUky50GONNkKHEt3yXtiqbG9zVIupv6QU18Ms
 7BqRtCeFw3HxE/KezdIfxXrG871jhInnQeTiEsxLPGrVCtQdRSoqUsK/vcPtYlfY
 a0WscSSENc+AxV3489Kvxxo55GhOz2a9N20sS4vacQCXj2rdVorYqGq4xp12JTB8
 NGvb9jDBcgS3XGlktx+al4gLb4ITZWNeKPn9cWjHmuWvYOk49H+WqqVfiGdMZ6X5
 izj3MXwMQM5Q8DVA6KS/ey0lZ8mnlj04btRSBAb+k3Igsqb0o85OOO4zq21bsOoQ
 MEtK4nBn0X+/bc8m0xYaHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717553712; x=
 1717640112; bh=qsdV9vskjuBmzS46VzX1Mqyfv9fGhQMQDsiIY2hOhAw=; b=T
 4SSEQEk0uRrAfn2ewt8k8ISh8lk7swrQT7HmME94ozx7yrVKfvL0yPz7KcDP63+x
 7TcCsu1kuYj9czNLr9FzlNHLq4/CyhwkJQlCUjNwl6XVHfSkF/6Dq7mIBlRDFIUC
 pNjra0DbkU02Y4/T61GRLufc7coVeSnFf6ug3vt4/DveTudLJ1o6nFPji/CtNqjd
 JkSGzi0Pi65AsogROSo1sgAjQ5+tMnPQezcoEQmDt6Ki9R8Jpo13ml4N4l3CzDme
 in5uYSXj5GCJH4WSiTXDic9l2GcEmgvj4LAZE4bsBtVqDPi0vxaPJsjGMGeZM33Z
 1mJHRgxLxo95URlplZFYw==
X-ME-Sender: <xms:MMpfZqNoXtLdUdcQDlT3VA8mVb7NdQdo0PG74urJ5wgWNWUZr-fAYg>
 <xme:MMpfZo8bb3w7Pncm4A6NqxyXgOE_Kzf-pX1DZs03V4mX-WEyhU7hUo8F09J7wwwdh
 Q8lOrenwnyJnzo9pQQ>
X-ME-Received: <xmr:MMpfZhSORS8YcZzXAscgbSyrifmN3kYMOXya9fDZxrIXdvI-eF_Bekg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:MMpfZqviljUWtzLFqGt--etTAJtliiiinPKiPAwemEzmtyXS4wTrSQ>
 <xmx:MMpfZifpy9wf1on5FBTa-101dfrxTXKeUZmd3zIti9lVbH26VMLspg>
 <xmx:MMpfZu3rJXm-NRcy3jU_38bhDUuWq2h-tf5XRZ4uOWWM0wjrBXpVfQ>
 <xmx:MMpfZm_zNR7nYEqGXYcT7t1HiUzp8qLwIxVJ3xrKslO8ma0A7IKtYg>
 <xmx:MMpfZvHDC9FdT3j2yxlefEd4GsZeWtrLAT3xkXp7Gwe3GpkYZ8wZF3Fp>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 22:15:11 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 05 Jun 2024 03:15:03 +0100
Subject: [PATCH v3 2/4] hw/intc/loongson_ipi: Provide per core MMIO address
 spaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-loongson3-ipi-v3-2-ddd2c0e03fa3@flygoat.com>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
In-Reply-To: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6577;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=LZOgZg61JSx7cogFY2kbLtUvCEt/U75uCJMoXwV6gt0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT4U3rmEpferWeZebnRa0nJooVTXnqcn+674Wu+X1xlS
 opiWCZDRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExkAQ/DP63UKfvvHp6/ls9/
 43bBh1pfDEuWN3Byyx+yLiltqTxg+YuRYdIMY8mLd7fyTNrzr+nFRBn71V98inz5+TPO6d+SWLW
 xjBcA
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


