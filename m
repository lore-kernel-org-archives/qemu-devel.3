Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0267C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3qLx-0002CE-53; Tue, 08 Sep 2026 03:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x3qLv-0002Af-3K
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:34:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x3qLr-00006o-Mi
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:34:46 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxKvCLup9qsrcJAA--.27845S3;
 Tue, 08 Sep 2026 15:34:35 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJDxDc+Eup9qSQ0dAA--.29522S4;
 Tue, 08 Sep 2026 15:34:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>
Subject: [PULL 2/5] hw/intc/loongarch_dintc: Add
 loongarch_dintc_cpu_by_arch_id() function
Date: Tue,  8 Sep 2026 15:35:45 +0800
Message-ID: <20260908073548.3249551-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908073548.3249551-1-maobibo@loongson.cn>
References: <20260908073548.3249551-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxDc+Eup9qSQ0dAA--.29522S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFW5JFyDKryxGFyfKw4xKrX_yoW5AF1Dpr
 Wxurn0gr1UAanrX39xJa4rZr4fCrn3u3W2q3WakF92kF4kXr15Xr48GryDXF9Fka4UWr1j
 qwn7J3WUWF13JFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UUUUU==
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
Reviewed-by:  Song Gao <17746591750@163.com>
---
 hw/intc/loongarch_dintc.c | 49 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index 94d418261c..c01f1fe07e 100644
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
 
     if (kvm_irqchip_in_kernel()) {
@@ -148,15 +164,8 @@ static DINTCCore *loongarch_dintc_get_cpu(LoongArchDINTCState *s,
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
-- 
2.54.0


