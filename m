Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED43C369A5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 02:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LLk-0002hq-G8; Tue, 08 Apr 2025 22:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u2LLd-0002V9-HL
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:39:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u2LLa-0007wm-85
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:39:28 -0400
Received: from loongson.cn (unknown [10.2.10.34])
 by gateway (Coremail) with SMTP id _____8DxzOJh3fVnLa+1AA--.40072S3;
 Wed, 09 Apr 2025 10:37:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
 by front1 (Coremail) with SMTP id qMiowMBxLsdY3fVnnsR1AA--.28294S16;
 Wed, 09 Apr 2025 10:37:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 14/16] hw/intc/loongarch_pch: Rename memory region
 iomem32_low with iomem
Date: Wed,  9 Apr 2025 10:37:09 +0800
Message-Id: <20250409023711.2960618-15-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250409023711.2960618-1-maobibo@loongson.cn>
References: <20250409023711.2960618-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsdY3fVnnsR1AA--.28294S16
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrW8Zw1UGFW7tF43KF4rWFX_yoW5ZF17pr
 ZrZrnxKF4kJFnrZFykZ345Xrn7Jrn2934I93ZIkryxCrnrAr1DXF1kJr9FgFyjk3yUGry2
 qFWrGa4Yq3WUGabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2F4iUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Rename memory region iomem32_low with iomem, also change ops name
as follows:
  loongarch_pch_pic_reg32_low_ops  --> loongarch_pch_pic_ops
  loongarch_pch_pic_low_readw      --> loongarch_pch_pic_read
  loongarch_pch_pic_low_writew     --> loongarch_pch_pic_write

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c            | 26 +++++++-------------------
 include/hw/intc/loongarch_pic_common.h |  2 +-
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 269de4a1bc..92c7544168 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -230,18 +230,6 @@ static void loongarch_pch_pic_write(void *opaque, hwaddr addr,
     }
 }
 
-static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
-                                            unsigned size)
-{
-    return loongarch_pch_pic_read(opaque, addr, size);
-}
-
-static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
-                                         uint64_t value, unsigned size)
-{
-    loongarch_pch_pic_write(opaque, addr, value, size);
-}
-
 static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
                                         unsigned size)
 {
@@ -270,9 +258,9 @@ static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
     loongarch_pch_pic_write(opaque, addr, data, size);
 }
 
-static const MemoryRegionOps loongarch_pch_pic_reg32_low_ops = {
-    .read = loongarch_pch_pic_low_readw,
-    .write = loongarch_pch_pic_low_writew,
+static const MemoryRegionOps loongarch_pch_pic_ops = {
+    .read = loongarch_pch_pic_read,
+    .write = loongarch_pch_pic_write,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 8,
@@ -361,15 +349,15 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_out(dev, s->parent_irq, s->irq_num);
     qdev_init_gpio_in(dev, pch_pic_irq_handler, s->irq_num);
-    memory_region_init_io(&s->iomem32_low, OBJECT(dev),
-                          &loongarch_pch_pic_reg32_low_ops,
-                          s, PCH_PIC_NAME(.reg32_part1), 0x100);
+    memory_region_init_io(&s->iomem, OBJECT(dev),
+                          &loongarch_pch_pic_ops,
+                          s, TYPE_LOONGARCH_PIC, 0x100);
     memory_region_init_io(&s->iomem8, OBJECT(dev), &loongarch_pch_pic_reg8_ops,
                           s, PCH_PIC_NAME(.reg8), 0x2a0);
     memory_region_init_io(&s->iomem32_high, OBJECT(dev),
                           &loongarch_pch_pic_reg32_high_ops,
                           s, PCH_PIC_NAME(.reg32_part2), 0xc60);
-    sysbus_init_mmio(sbd, &s->iomem32_low);
+    sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_mmio(sbd, &s->iomem8);
     sysbus_init_mmio(sbd, &s->iomem32_high);
 
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index fb848da4b8..ab8ffff780 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -65,7 +65,7 @@ struct LoongArchPICCommonState {
     uint8_t route_entry[64];  /* 0x100 - 0x138 */
     uint8_t htmsi_vector[64]; /* 0x200 - 0x238 */
 
-    MemoryRegion iomem32_low;
+    MemoryRegion iomem;
     MemoryRegion iomem32_high;
     MemoryRegion iomem8;
     unsigned int irq_num;
-- 
2.39.3


