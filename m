Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9158EC369A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 02:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LJj-0006Vt-PJ; Tue, 08 Apr 2025 22:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u2LJh-0006Ui-FR
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:37:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u2LJc-0007nB-KS
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:37:29 -0400
Received: from loongson.cn (unknown [10.2.10.34])
 by gateway (Coremail) with SMTP id _____8AxTWta3fVnE6+1AA--.39486S3;
 Wed, 09 Apr 2025 10:37:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
 by front1 (Coremail) with SMTP id qMiowMBxLsdY3fVnnsR1AA--.28294S5;
 Wed, 09 Apr 2025 10:37:14 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 03/16] hw/intc/loongarch_pch: Remove some duplicate macro
Date: Wed,  9 Apr 2025 10:36:58 +0800
Message-Id: <20250409023711.2960618-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250409023711.2960618-1-maobibo@loongson.cn>
References: <20250409023711.2960618-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsdY3fVnnsR1AA--.28294S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr48Cw15Cw18Xw4kGF4fCrX_yoW5Wr4fpF
 9xAFsIgrsrGry7XFn2ya45Zr1DJFnrur9F9anIkryF9Fs8Zry8X3WkJ3y5WF1UK3y5Jryq
 grsxua1av3WUWrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UUUUU==
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

The meaning of macro definition STATUS_LO_START is simliar with
PCH_PIC_INT_STATUS, only that offset is different, the same for
macro POL_LO_START. Now remove these duplicated macro definitions.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c            | 20 ++++++++++----------
 include/hw/intc/loongarch_pic_common.h |  5 -----
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 4c845ba5e9..a2d9930ac9 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -208,19 +208,19 @@ static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint64_t val = 0;
-    uint32_t offset = addr & 0xfff;
+    uint32_t offset = addr + PCH_PIC_INT_STATUS;
 
     switch (offset) {
-    case STATUS_LO_START:
+    case PCH_PIC_INT_STATUS:
         val = (uint32_t)(s->intisr & (~s->int_mask));
         break;
-    case STATUS_HI_START:
+    case PCH_PIC_INT_STATUS + 4:
         val = (s->intisr & (~s->int_mask)) >> 32;
         break;
-    case POL_LO_START:
+    case PCH_PIC_INT_POL:
         val = (uint32_t)s->int_polarity;
         break;
-    case POL_HI_START:
+    case PCH_PIC_INT_POL + 4:
         val = s->int_polarity >> 32;
         break;
     default:
@@ -236,21 +236,21 @@ static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint32_t offset, data = (uint32_t)value;
-    offset = addr & 0xfff;
+    offset = addr + PCH_PIC_INT_STATUS;
 
     trace_loongarch_pch_pic_high_writew(size, addr, data);
 
     switch (offset) {
-    case STATUS_LO_START:
+    case PCH_PIC_INT_STATUS:
         s->intisr = get_writew_val(s->intisr, data, 0);
         break;
-    case STATUS_HI_START:
+    case PCH_PIC_INT_STATUS + 4:
         s->intisr = get_writew_val(s->intisr, data, 1);
         break;
-    case POL_LO_START:
+    case PCH_PIC_INT_POL:
         s->int_polarity = get_writew_val(s->int_polarity, data, 0);
         break;
-    case POL_HI_START:
+    case PCH_PIC_INT_POL + 4:
         s->int_polarity = get_writew_val(s->int_polarity, data, 1);
         break;
     default:
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index b33bebb129..ef6edc15bf 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -26,11 +26,6 @@
 #define PCH_PIC_INT_STATUS              0x3a0
 #define PCH_PIC_INT_POL                 0x3e0
 
-#define STATUS_LO_START                 0
-#define STATUS_HI_START                 0x4
-#define POL_LO_START                    0x40
-#define POL_HI_START                    0x44
-
 #define TYPE_LOONGARCH_PIC_COMMON "loongarch_pic_common"
 OBJECT_DECLARE_TYPE(LoongArchPICCommonState,
                     LoongArchPICCommonClass, LOONGARCH_PIC_COMMON)
-- 
2.39.3


