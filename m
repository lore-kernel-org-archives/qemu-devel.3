Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464C5C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qLw-0002Ay-8F; Tue, 08 Sep 2026 03:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x3qLt-0002A7-Ee
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:34:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x3qLr-00006n-9h
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:34:45 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Bx69GLup9qs7cJAA--.27945S3;
 Tue, 08 Sep 2026 15:34:35 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxDc+Eup9qSQ0dAA--.29522S5;
 Tue, 08 Sep 2026 15:34:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 3/5] hw/intc/loongarch_ipi: Add ipi interrupt status display
Date: Tue,  8 Sep 2026 15:35:46 +0800
Message-ID: <20260908073548.3249551-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908073548.3249551-1-maobibo@loongson.cn>
References: <20260908073548.3249551-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxDc+Eup9qSQ0dAA--.29522S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF13Zw47Kry8Xr15ArWDGFX_yoW5WrWkpF
 W3uF4Ykr48AFsrGrZxAasIqFn8Gw1xuFy7uFs7C348AFWDJrn0q3yIyr9xXFyUC3y8GF1Y
 qw4fJa4q9a1UCrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wNVDUUUUU==
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When irqchip in kernel is enabled, the register status of ipi irqchip is
in KVM kernel. Here add interrupt status display in user side in order to
debug irqchip driver.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
---
 hw/intc/loongarch_ipi.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 5d8b8c96df..28d816e3f5 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -9,6 +9,7 @@
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
 #include "qapi/error.h"
+#include "hw/intc/intc.h"
 #include "hw/intc/loongarch_ipi.h"
 #include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
@@ -193,8 +194,47 @@ static int loongarch_ipi_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static void loongarch_ipi_print_info(InterruptStatsProvider *obj, GString *buf)
+{
+    LoongsonIPICommonState *lics = LOONGSON_IPI_COMMON(obj);
+    int i, j;
+    IPICore *core;
+    uint64_t mbx;
+    unsigned long pos;
+
+    loongarch_ipi_pre_save(lics);
+
+    g_string_append_printf(buf, "%s:\n", object_get_typename(OBJECT(obj)));
+    for (i = 0; i < lics->num_cpu; i++) {
+        core = lics->cpu + i;
+        /* IPI with targeted CPU available however not present */
+        if (!core->cpu) {
+            continue;
+        }
+
+        g_string_append_printf(buf, "  CPU %-3u status=0x%x en=0x%x\n",
+                                    i, core->status, core->en);
+
+        pos = find_first_bit((unsigned long *)core->buf, IPI_MBX_NUM * 64);
+        /* All zero in mailbox */
+        if (pos == (IPI_MBX_NUM * 64)) {
+            continue;
+        }
+
+        for (j = 0; j < IPI_MBX_NUM; j++) {
+            mbx = *(uint64_t *)&core->buf[2 * j];
+            if (mbx) {
+                g_string_append_printf(buf, "  MBX[%-1u] 0x%016"PRIx64, j, mbx);
+            }
+        }
+
+        g_string_append_c(buf, '\n');
+    }
+}
+
 static void loongarch_ipi_class_init(ObjectClass *klass, const void *data)
 {
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
     LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
     LoongarchIPIClass *lic = LOONGARCH_IPI_CLASS(klass);
@@ -211,6 +251,7 @@ static void loongarch_ipi_class_init(ObjectClass *klass, const void *data)
     hc->unplug = loongarch_ipi_cpu_unplug;
     licc->pre_save = loongarch_ipi_pre_save;
     licc->post_load = loongarch_ipi_post_load;
+    ic->print_info = loongarch_ipi_print_info;
 }
 
 static const TypeInfo loongarch_ipi_types[] = {
@@ -222,6 +263,7 @@ static const TypeInfo loongarch_ipi_types[] = {
         .class_init         = loongarch_ipi_class_init,
         .interfaces         = (const InterfaceInfo[]) {
             { TYPE_HOTPLUG_HANDLER },
+            { TYPE_INTERRUPT_STATS_PROVIDER },
             { }
         },
     }
-- 
2.54.0


