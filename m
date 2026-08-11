Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24241C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wti47-0003Ea-10; Tue, 11 Aug 2026 04:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wti44-0003EQ-P0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:42:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wti42-00010p-Dk
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:42:28 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxC9Jr4Hpqih4AAA--.375S3;
 Tue, 11 Aug 2026 16:42:19 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJAxnM5q4Hpq114AAA--.1042S2;
 Tue, 11 Aug 2026 16:42:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Subject: [PATCH] hw/intc/loongarch_dintc: Add loongarch_dintc_cpu_by_arch_id()
 function
Date: Tue, 11 Aug 2026 16:43:31 +0800
Message-ID: <20260811084331.23526-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxnM5q4Hpq114AAA--.1042S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw43Xr4DCr4kZrykAw15Jrc_yoW5AFW7pr
 Wxurn0qr1UAanrXa9xJa4rZr4fCrn3u3W2q3WakF97CF4kJr1UXr48GryDXF9Fka4UWr1j
 qwn7J3WUuF17J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
 AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
 r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
 IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
 w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
 0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU
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

Similar with IPI, add function loongarch_dintc_cpu_by_arch_id() for
dintc driver. It searches dintc device from physical CPUID, also it
used binary search method, rather than one by one with common API
cpu_by_arch_id().

And use this newly added API in loongarch_dintc_get_cpu() and
loongarch_dintc_mem_write().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_dintc.c | 49 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index e40292887c..68c1cfce43 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -26,6 +26,25 @@ FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
 FIELD(MSG_ADDR, CPU_NUM, 12, 8)
 FIELD(MSG_ADDR, FIX, 28, 12)
 
+static int loongarch_dintc_cmp(const void *a, const void *b)
+{
+    DINTCCore *dintc_a = (DINTCCore *)a;
+    DINTCCore *dintc_b = (DINTCCore *)b;
+
+    return dintc_a->arch_id - dintc_b->arch_id;
+}
+
+static DINTCCore *loongarch_dintc_cpu_by_arch_id(LoongArchDINTCState *s,
+                                                 int64_t arch_id)
+{
+    DINTCCore dintc, *found;
+
+    dintc.arch_id = arch_id;
+    found = bsearch(&dintc, s->cpu, s->num_cpu, sizeof(DINTCCore),
+                    loongarch_dintc_cmp);
+    return found;
+}
+
 static uint64_t loongarch_dintc_mem_read(void *opaque,
                                         hwaddr addr, unsigned size)
 {
@@ -49,23 +68,20 @@ static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
 {
     int irq_num, cpu_num = 0;
     LoongArchDINTCState *s = LOONGARCH_DINTC(opaque);
-    uint64_t msg_addr = addr + VIRT_DINTC_BASE;
+    uint64_t msg_addr = addr + VIRT_DINTC_BASE, arch_id;
+    DINTCCore *core;
     CPUState *cs;
 
-    cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
-
-    /* Validate cpu_num against the configured number of CPUs */
-    if (cpu_num >= s->num_cpu) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "loongarch-dintc: invalid cpu number%d\n", cpu_num);
-        return;
-    }
-    cs = cpu_by_arch_id(cpu_num);
-    if (!cs) {
+    arch_id = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
+    core = loongarch_dintc_cpu_by_arch_id(s, arch_id);
+    if (!core || !core->cpu) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "loongarch-dintc: no CPU for arch_id %d\n", cpu_num);
+                      "loongarch-dintc: no CPU for arch_id %"PRId64"\n",
+                      arch_id);
         return;
     }
+    cpu_num = core - s->cpu;
+    cs = core->cpu;
     irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
 
     async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
@@ -135,15 +151,8 @@ static DINTCCore *loongarch_dintc_get_cpu(LoongArchDINTCState *s,
 {
     CPUClass *k = CPU_GET_CLASS(dev);
     uint64_t arch_id = k->get_arch_id(CPU(dev));
-    int i;
-
-    for (i = 0; i < s->num_cpu; i++) {
-        if (s->cpu[i].arch_id == arch_id) {
-            return &s->cpu[i];
-        }
-    }
 
-    return NULL;
+    return loongarch_dintc_cpu_by_arch_id(s, arch_id);
 }
 
 static void loongarch_dintc_cpu_plug(HotplugHandler *hotplug_dev,

base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
-- 
2.54.0


