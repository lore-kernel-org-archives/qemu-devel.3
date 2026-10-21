Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82457606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJN6U-0007Mq-8D; Tue, 20 Oct 2026 23:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xJN6S-0007Mi-0B
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:35:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xJN6O-0005Gs-Jj
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:34:59 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxPNLYMthqr+cXAA--.4227S3;
 Wed, 21 Oct 2026 11:34:48 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxPs_XMthquK8uAA--.31952S2;
 Wed, 21 Oct 2026 11:34:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Subject: [PATCH] hw/intc: Acess LoongArch irqchip data with align method
Date: Wed, 21 Oct 2026 11:36:15 +0800
Message-ID: <20261021033615.3619988-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPs_XMthquK8uAA--.31952S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3AryxWry8uw4DWrWkJw4rCrX_yoW3GFW8pr
 Wa93sxWr40qFnrJ34DXw45XFnaqr4I9a47XF9Fyw18uFZ7G3WDZFyxtFy7WFy7Ga4fCr1I
 kwn5trWjq3WDJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the clang sanitizer configured with
"--enable-ubsan --cc=clang --cxx=clang++" and run 'make check'. The
test-hmp test falls over with this backtrace:
    ../../hw/intc/loongarch_extioi.c:439:33: runtime error: load of
misaligned address 0x5b0a281448b4 for type 'uint64_t' (aka 'unsigned
long'), which requires 8 byte alignment.

Here LoongArch irqchip information is accessed by its natual aligned
method, and here is output of command 'info pic'
loongarch_ipi:
  CPU 0   status=0x0 en=0xffffffff
          MBX[6] 0x00082270
  CPU 1   status=0x0 en=0xffffffff
  CPU 2   status=0x0 en=0xffffffff
  CPU 3   status=0x0 en=0xffffffff
loongarch_pic:
  mask     0xffffffffffffff7b msi_en 0xffffffffffffffff edge 0x0000000000000080 clr    0x0000000000000000
  last_irr 0x0000000000000040 irr    0x0000000000000040 isr  0x0000000000000000 polary 0x0000000000000000
  MSI map:
    [ 0 -  3] 0x00 0x01 0x02 0x03
    ...
    [60 - 63] 0x3c 0x3d 0x3e 0x3f
loongarch.extioi:
  ISR     0x00000000 0x00000000 0x00000000 0x00000000
          0x00000000 0x00000000 0x00000000 0x00000000
  ENABLE  0xffffffff 0xffffffff 0xffffffff 0xffffffff
          0xffffffff 0xffffffff 0xffffffff 0xffffffff
  IPMAP   0x02020202 0x02020202
  IRQ route:
    [0   - 15 ] 0x01010101 0x01010101 0x01010101 0x01010101
    ...
    [240 - 255] 0x01010101 0x01010101 0x01010101 0x01010101

Fixes: 970657e490c0 ("hw/intc/loongarch_extioi: Add extioi interrupt status display")
Fixes: 761eb76a3bc7 ("hw/intc/loongarch_ipi: Add ipi interrupt status display")
Fixes: 82f472fa380a ("hw/intc/loongarch_pch_pic: Add pic interrupt status display")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c  | 51 ++++++++++++++++++++++++-------------
 hw/intc/loongarch_ipi.c     |  9 ++++---
 hw/intc/loongarch_pch_pic.c | 28 +++++++++++---------
 3 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 06f2aa7b14..ccc4eed199 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -425,7 +425,7 @@ static void loongarch_extioi_print_info(InterruptStatsProvider *obj,
                                         GString *buf)
 {
     LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(obj);
-    uint64_t *val;
+    uint32_t *val;
     unsigned long irq;
     ExtIOICore *core;
     int i;
@@ -433,22 +433,35 @@ static void loongarch_extioi_print_info(InterruptStatsProvider *obj,
     vmstate_extioi_pre_save(s);
     g_string_append_printf(buf, "%s:\n", object_get_typename(OBJECT(obj)));
 
-    val = (uint64_t *)s->isr;
-    g_string_append_printf(buf, "  ISR     0x%016"PRIx64" 0x%016"PRIx64
-                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
+    val = s->isr;
+    g_string_append_printf(buf, "  ISR     0x%08"PRIx32" 0x%08"PRIx32
+                                " 0x%08"PRIx32" 0x%08"PRIx32"\n",
                                 *val, *(val + 1), *(val + 2), *(val + 3));
-    val = (uint64_t *)s->enable;
-    g_string_append_printf(buf, "  ENABLE  0x%016"PRIx64" 0x%016"PRIx64
-                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
+    val += 4;
+    g_string_append_printf(buf, "          0x%08"PRIx32" 0x%08"PRIx32
+                                " 0x%08"PRIx32" 0x%08"PRIx32"\n",
+                                *val, *(val + 1), *(val + 2), *(val + 3));
+    val = s->enable;
+    g_string_append_printf(buf, "  ENABLE  0x%08"PRIx32" 0x%08"PRIx32
+                                " 0x%08"PRIx32" 0x%08"PRIx32"\n",
+                                *val, *(val + 1), *(val + 2), *(val + 3));
+    val += 4;
+    g_string_append_printf(buf, "          0x%08"PRIx32" 0x%08"PRIx32
+                                " 0x%08"PRIx32" 0x%08"PRIx32"\n",
                                 *val, *(val + 1), *(val + 2), *(val + 3));
-    val = (uint64_t *)s->ipmap;
-    g_string_append_printf(buf, "  IPMAP   0x%016"PRIx64"\n", *val);
 
-    val = (uint64_t *)s->coremap;
-    for (i = 0; i < EXTIOI_IRQS; i += 32) {
-        g_string_append_printf(buf, "  COREMAP 0x%016"PRIx64" 0x%016"PRIx64
-                                    " 0x%016"PRIx64" 0x%016"PRIx64"\n",
-                                    *val, *(val + 1), *(val + 2), *(val + 3));
+    val = s->ipmap;
+    g_string_append_printf(buf, "  IPMAP   0x%08"PRIx32" 0x%08"PRIx32"\n",
+                                *val, *(val + 1));
+
+    val = s->coremap;
+    g_string_append_printf(buf, "  IRQ route:\n");
+    for (i = 0; i < (EXTIOI_IRQS / 4); i += 4) {
+        g_string_append_printf(buf, "    [%-3u - %-3u] 0x%08"PRIx32
+                                    " 0x%08"PRIx32" 0x%08"PRIx32
+                                    " 0x%08"PRIx32"\n",
+                                    i * 4, i * 4 + 15, *val, *(val + 1),
+                                    *(val + 2), *(val + 3));
         val += 4;
     }
 
@@ -464,11 +477,15 @@ static void loongarch_extioi_print_info(InterruptStatsProvider *obj,
             continue;
         }
 
-        val = (uint64_t *)core->coreisr;
-        g_string_append_printf(buf, "  CPU[%d] ISR 0x%016"PRIx64" 0x%016"PRIx64
-                                    " 0x%016"PRIx64" 0x%016"PRIx64"\n",
+        val = core->coreisr;
+        g_string_append_printf(buf, "  CPU[%-3u] ISR 0x%08"PRIx32" 0x%08"PRIx32
+                                    " 0x%08"PRIx32" 0x%08"PRIx32"\n",
                                     i, *val, *(val + 1), *(val + 2),
                                     *(val + 3));
+        val += 4;
+        g_string_append_printf(buf, "              0x%08"PRIx32" 0x%08"PRIx32
+                                    " 0x%08"PRIx32" 0x%08"PRIx32"\n",
+                                    *val, *(val + 1), *(val + 2), *(val + 3));
     }
 }
 
diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index c8f775a93e..7efdfc904d 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -199,7 +199,7 @@ static void loongarch_ipi_print_info(InterruptStatsProvider *obj, GString *buf)
     LoongsonIPICommonState *lics = LOONGSON_IPI_COMMON(obj);
     int i, j;
     IPICore *core;
-    uint64_t mbx;
+    uint32_t mbx;
     unsigned long pos;
 
     loongarch_ipi_pre_save(lics);
@@ -221,10 +221,11 @@ static void loongarch_ipi_print_info(InterruptStatsProvider *obj, GString *buf)
             continue;
         }
 
-        for (j = 0; j < IPI_MBX_NUM; j++) {
-            mbx = *(uint64_t *)&core->buf[2 * j];
+        for (j = 0; j < (IPI_MBX_NUM * 2); j++) {
+            mbx = core->buf[j];
             if (mbx) {
-                g_string_append_printf(buf, "  MBX[%-1u] 0x%016"PRIx64, j, mbx);
+                g_string_append_printf(buf, "          MBX[%-1u] 0x%08"PRIx32,
+                                            j, mbx);
             }
         }
 
diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 34090514ec..555575a377 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -335,7 +335,8 @@ static int loongarch_pic_post_load(LoongArchPICCommonState *opaque,
 static void loongarch_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(obj);
-    uint64_t *vector;
+    uint8_t *vector, val;
+    int i;
 
     loongarch_pic_pre_save(s);
     g_string_append_printf(buf, "%s:\n", object_get_typename(OBJECT(obj)));
@@ -350,17 +351,20 @@ static void loongarch_pic_print_info(InterruptStatsProvider *obj, GString *buf)
                                 s->last_intirr, s->intirr, s->intisr,
                                 s->int_polarity);
 
-    vector = (uint64_t *)s->htmsi_vector;
-    g_string_append_printf(buf, "  MSI map  0x%016"PRIx64" 0x%016"PRIx64
-                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
-                                *vector, *(vector + 1), *(vector + 2),
-                                *(vector + 3));
-
-    vector += 4;
-    g_string_append_printf(buf, "           0x%016"PRIx64" 0x%016"PRIx64
-                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
-                                *vector, *(vector + 1), *(vector + 2),
-                                *(vector + 3));
+    vector = s->htmsi_vector;
+    g_string_append_printf(buf, "  MSI map:\n");
+    for (i = 0; i < 64; i += 4, vector += 4) {
+        val = *vector | *(vector + 1) | *(vector + 2) | *(vector + 3);
+        /* skip zero mapping */
+        if (val == 0) {
+            continue;
+        }
+
+        g_string_append_printf(buf, "    [%2d - %2d] 0x%02"PRIx8" 0x%02"PRIx8
+                                    " 0x%02"PRIx8" 0x%02"PRIx8"\n",
+                                    i, i + 3, *vector, *(vector + 1),
+                                    *(vector + 2), *(vector + 3));
+    }
 }
 
 static void loongarch_pic_class_init(ObjectClass *klass, const void *data)

base-commit: 8967b2fe1b2aaae3c29e207d85fab901d580a2dc
-- 
2.54.0


