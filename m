Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5676C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbMN-0000g2-TS; Tue, 18 Jun 2024 12:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMB-0000RW-VD
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:56 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbM8-0007oq-OY
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:51 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6f11a2d18aso739220666b.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726806; x=1719331606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOeXVUMAZHBjW9XDQ/kaolb4y+LTzn2/7YBfwTD0b4w=;
 b=gneVIZUT5bC/wIv8I8GHGXueWGc1wTmDYrUT3uknGan6hQHrd0kuegJP6JxMKj+Ieh
 0dLJ60RZ0jhKM4HFG6jj0FO4nugQwOTUbacuGoMQjgxf+ks9Gg07OMCCcIJ8tcvWknza
 hKocRA1r+G9brw5pb1Z5JcMsSoHoZedPdYtgsTkwlyfgi8Q/BtDedZqB6pFPp1ZsjRmf
 nQi6zEPKAKxqihSIK0LFVgWDhUipAyFM7NuXaXRQRqhSOBo8sdwannGgs0Tr/pUFasgK
 0NwoZgKsQYYAVXSGmIWrW1XrrmTwcKZTedrLsGBtsoHq5rwXOIMituhmCcFc0JIKYpHt
 dDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726806; x=1719331606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOeXVUMAZHBjW9XDQ/kaolb4y+LTzn2/7YBfwTD0b4w=;
 b=gB6a8IN1KSlJ8P9w4W3tBMM+7RwiFtK8V6Hdrhtlb/hQwVJ9RAXRGVTpcBYoHGGWKF
 wP4+VF10Yni+84K3gH5Lhn7lJzflaHlNP+PdI2Q5q07K/hZfDcSisPnPz6nFfNP/gehg
 OEVYd6AXJt6T71sLC6G03D98/AoPb6kHcwcGuriPkRReFoxRcUvLoN0bTgFPnhj+EcYj
 VmjZi/9x2f6pnd3bfVgezHnnopYQ8/JXXUjCBl6RowG5mH6vmNbdfjZ0qOX4RoAFaWVt
 kD9A7jEQJJQDVbfE2rzTTwIdflugTqy/1zLIfoIxMi/kWaHGeLlMX1V3FCDOacU/nIAZ
 ZNJg==
X-Gm-Message-State: AOJu0YyPgvSxDyIWRXFanuMOL9F41DP9HBpN5v5GkEyx2s934yejB+Ug
 6PDzYRP3NcM5JC8msptODAGlcP9CoacDoTMiQp5AnKwce54AyAEvzHiPGKtnnaDDkRe9rIWHwA+
 4
X-Google-Smtp-Source: AGHT+IE5aW6MS7RXRscOH+XeeUKpXp3cuqnyI91Z/DoFv8ql3WRCtb/DxvvL8QMcfkpoEFbcq5YaQA==
X-Received: by 2002:a17:906:3890:b0:a6f:4fc8:265f with SMTP id
 a640c23a62f3a-a6f60d41459mr745614766b.42.1718726806557; 
 Tue, 18 Jun 2024 09:06:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360917c264bsm7145160f8f.56.2024.06.18.09.06.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:06:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 63/76] hw/intc/loongson_ipi: Provide per core MMIO address
 spaces
Date: Tue, 18 Jun 2024 18:00:25 +0200
Message-ID: <20240618160039.36108-64-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

The real IPI hardware have dedicated MMIO registers mapped into
memory address space for every core. This is not used by LoongArch
guest software but it is essential for CPU without IOCSR such as
Loongson-3A1000.

Implement it with existing infrastructure.

Acked-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <20240605-loongson3-ipi-v3-2-ddd2c0e03fa3@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/loongson_ipi.h |  2 +
 hw/intc/loongson_ipi.c         | 86 +++++++++++++++++++++++++---------
 2 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 2c0e8820f5..3f795edbf3 100644
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
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 93cc50a37a..08a74a0b4f 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -23,16 +23,14 @@
 #endif
 #include "trace.h"
 
-static MemTxResult loongson_ipi_readl(void *opaque, hwaddr addr,
-                                       uint64_t *data,
-                                       unsigned size, MemTxAttrs attrs)
+static MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr,
+                                           uint64_t *data,
+                                           unsigned size, MemTxAttrs attrs)
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
+                                            uint64_t *data,
+                                            unsigned size, MemTxAttrs attrs)
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
@@ -282,7 +318,8 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), &loongson_ipi_ops,
+    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev),
+                          &loongson_ipi_iocsr_ops,
                           s, "loongson_ipi_iocsr", 0x48);
 
     /* loongson_ipi_iocsr performs re-entrant IO through ipi_send */
@@ -297,11 +334,18 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
 
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
-- 
2.41.0


