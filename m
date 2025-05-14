Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9533C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF746-0002Yb-Jy; Wed, 14 May 2025 04:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uF744-0002XI-Hg
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:02:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uF740-0002A0-Rb
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:02:08 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx7eL5TSRoulbmAA--.12154S3;
 Wed, 14 May 2025 16:02:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn8XkTSRofwHRAA--.9319S6;
 Wed, 14 May 2025 16:02:00 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	maobibo@loongson.cn
Subject: [PULL 04/17] hw/intc/loongarch_pch: Set version information at
 initial stage
Date: Wed, 14 May 2025 15:39:14 +0800
Message-Id: <20250514073927.2424543-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250514073927.2424543-1-gaosong@loongson.cn>
References: <20250514073927.2424543-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8XkTSRofwHRAA--.9319S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

Register PCH_PIC_INT_ID constains version and supported irq number
information, and it is read only register. The detailed value can
be set at initial stage, rather than read callback.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250507023148.1877287-5-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c            |  9 ++-------
 hw/intc/loongarch_pic_common.c         | 13 +++++++++++++
 include/hw/intc/loongarch_pic_common.h | 17 +++++++++++++++--
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 17ab071a6b..f732c292f8 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -80,15 +80,10 @@ static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
 
     switch (offset) {
     case PCH_PIC_INT_ID:
-        val = PCH_PIC_INT_ID_VAL;
+        val = s->id.data & UINT_MAX;
         break;
     case PCH_PIC_INT_ID + 4:
-        /*
-         * With 7A1000 manual
-         *   bit  0-15 pch irqchip version
-         *   bit 16-31 irq number supported with pch irqchip
-         */
-        val = deposit32(PCH_PIC_INT_ID_VER, 16, 16, s->irq_num - 1);
+        val = s->id.data >> 32;
         break;
     case PCH_PIC_INT_MASK:
         val = (uint32_t)s->int_mask;
diff --git a/hw/intc/loongarch_pic_common.c b/hw/intc/loongarch_pic_common.c
index 6dccacc741..de170501cf 100644
--- a/hw/intc/loongarch_pic_common.c
+++ b/hw/intc/loongarch_pic_common.c
@@ -49,6 +49,19 @@ static void loongarch_pic_common_reset_hold(Object *obj, ResetType type)
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(obj);
     int i;
 
+    /*
+     * With Loongson 7A1000 user manual
+     * Chapter 5.2 "Description of Interrupt-related Registers"
+     *
+     * Interrupt controller identification register 1
+     *   Bit 24-31 Interrupt Controller ID
+     * Interrupt controller identification register 2
+     *   Bit  0-7  Interrupt Controller version number
+     *   Bit 16-23 The number of interrupt sources supported
+     */
+    s->id.desc.id = PCH_PIC_INT_ID_VAL;
+    s->id.desc.version = PCH_PIC_INT_ID_VER;
+    s->id.desc.irq_num = s->irq_num - 1;
     s->int_mask = UINT64_MAX;
     s->htmsi_en = 0x0;
     s->intedge  = 0x0;
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index 2b4b483c63..7a9a2bdd46 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -10,9 +10,9 @@
 #include "hw/pci-host/ls7a.h"
 #include "hw/sysbus.h"
 
-#define PCH_PIC_INT_ID_VAL              0x7000000UL
-#define PCH_PIC_INT_ID_VER              0x1UL
 #define PCH_PIC_INT_ID                  0x00
+#define  PCH_PIC_INT_ID_VAL             0x7
+#define  PCH_PIC_INT_ID_VER             0x1
 #define PCH_PIC_INT_MASK                0x20
 #define PCH_PIC_HTMSI_EN                0x40
 #define PCH_PIC_INT_EDGE                0x60
@@ -30,10 +30,23 @@
 OBJECT_DECLARE_TYPE(LoongArchPICCommonState,
                     LoongArchPICCommonClass, LOONGARCH_PIC_COMMON)
 
+union LoongArchPIC_ID {
+    struct {
+        uint8_t _reserved_0[3];
+        uint8_t id;
+        uint8_t version;
+        uint8_t _reserved_1;
+        uint8_t irq_num;
+        uint8_t _reserved_2;
+    } QEMU_PACKED desc;
+    uint64_t data;
+};
+
 struct LoongArchPICCommonState {
     SysBusDevice parent_obj;
 
     qemu_irq parent_irq[64];
+    union LoongArchPIC_ID id; /* 0x00  interrupt ID register */
     uint64_t int_mask;        /* 0x020 interrupt mask register */
     uint64_t htmsi_en;        /* 0x040 1=msi */
     uint64_t intedge;         /* 0x060 edge=1 level=0 */
-- 
2.34.1


