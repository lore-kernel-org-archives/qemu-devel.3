Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC65C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 09:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tweFf-0007G7-5y; Mon, 24 Mar 2025 05:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tweFb-0007Ed-8t
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tweFY-0001Rf-6D
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:43 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxbeLeJ+FnMPujAA--.40891S3;
 Mon, 24 Mar 2025 17:37:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPsfaJ+FnGn1dAA--.15661S4;
 Mon, 24 Mar 2025 17:37:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/16] hw/intc/loongarch_pch: Modify register name
 PCH_PIC_xxx_OFFSET with PCH_PIC_xxx
Date: Mon, 24 Mar 2025 17:37:16 +0800
Message-Id: <20250324093730.3683378-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250324093730.3683378-1-maobibo@loongson.cn>
References: <20250324093730.3683378-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPsfaJ+FnGn1dAA--.15661S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Macro PCH_PIC_HTMSI_VEC_OFFSET and PCH_PIC_ROUTE_ENTRY_OFFSET is renamed
as PCH_PIC_HTMSI_VEC and PCH_PIC_ROUTE_ENTRY separately, it is easier to
understand.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c            | 20 ++++++++++----------
 hw/loongarch/virt.c                    |  2 +-
 include/hw/intc/loongarch_pic_common.h |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 2b90ccd1ff..4c845ba5e9 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -263,18 +263,18 @@ static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint64_t val = 0;
-    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY_OFFSET;
+    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY;
     int64_t offset_tmp;
 
     switch (offset) {
-    case PCH_PIC_HTMSI_VEC_OFFSET ... PCH_PIC_HTMSI_VEC_END:
-        offset_tmp = offset - PCH_PIC_HTMSI_VEC_OFFSET;
+    case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
+        offset_tmp = offset - PCH_PIC_HTMSI_VEC;
         if (offset_tmp >= 0 && offset_tmp < 64) {
             val = s->htmsi_vector[offset_tmp];
         }
         break;
-    case PCH_PIC_ROUTE_ENTRY_OFFSET ... PCH_PIC_ROUTE_ENTRY_END:
-        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY_OFFSET;
+    case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
+        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY;
         if (offset_tmp >= 0 && offset_tmp < 64) {
             val = s->route_entry[offset_tmp];
         }
@@ -292,19 +292,19 @@ static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     int32_t offset_tmp;
-    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY_OFFSET;
+    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY;
 
     trace_loongarch_pch_pic_writeb(size, addr, data);
 
     switch (offset) {
-    case PCH_PIC_HTMSI_VEC_OFFSET ... PCH_PIC_HTMSI_VEC_END:
-        offset_tmp = offset - PCH_PIC_HTMSI_VEC_OFFSET;
+    case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
+        offset_tmp = offset - PCH_PIC_HTMSI_VEC;
         if (offset_tmp >= 0 && offset_tmp < 64) {
             s->htmsi_vector[offset_tmp] = (uint8_t)(data & 0xff);
         }
         break;
-    case PCH_PIC_ROUTE_ENTRY_OFFSET ... PCH_PIC_ROUTE_ENTRY_END:
-        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY_OFFSET;
+    case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
+        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY;
         if (offset_tmp >= 0 && offset_tmp < 64) {
             s->route_entry[offset_tmp] = (uint8_t)(data & 0xff);
         }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 8c0cc98c72..1f1cca667e 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -429,7 +429,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     memory_region_add_subregion(get_system_memory(), VIRT_IOAPIC_REG_BASE,
                             sysbus_mmio_get_region(d, 0));
     memory_region_add_subregion(get_system_memory(),
-                            VIRT_IOAPIC_REG_BASE + PCH_PIC_ROUTE_ENTRY_OFFSET,
+                            VIRT_IOAPIC_REG_BASE + PCH_PIC_ROUTE_ENTRY,
                             sysbus_mmio_get_region(d, 1));
     memory_region_add_subregion(get_system_memory(),
                             VIRT_IOAPIC_REG_BASE + PCH_PIC_INT_STATUS,
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index c04471b08d..b33bebb129 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -19,9 +19,9 @@
 #define PCH_PIC_INT_CLEAR               0x80
 #define PCH_PIC_AUTO_CTRL0              0xc0
 #define PCH_PIC_AUTO_CTRL1              0xe0
-#define PCH_PIC_ROUTE_ENTRY_OFFSET      0x100
+#define PCH_PIC_ROUTE_ENTRY             0x100
 #define PCH_PIC_ROUTE_ENTRY_END         0x13f
-#define PCH_PIC_HTMSI_VEC_OFFSET        0x200
+#define PCH_PIC_HTMSI_VEC               0x200
 #define PCH_PIC_HTMSI_VEC_END           0x23f
 #define PCH_PIC_INT_STATUS              0x3a0
 #define PCH_PIC_INT_POL                 0x3e0
-- 
2.39.3


