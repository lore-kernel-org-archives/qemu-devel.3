Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DADD606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTUzI-0006EO-U0; Tue, 17 Nov 2026 21:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xTUzE-00068J-Mv
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 21:01:24 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xTUzC-0004z9-Kd
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 21:01:24 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxhvDwBv1qzaggAA--.28269S3;
 Wed, 18 Nov 2026 10:01:20 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBx6c3nBv1q7ng1AA--.29919S3;
 Wed, 18 Nov 2026 10:01:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PULL 1/2] Revert "target/loongarch: Remove TLB entry in vmstate"
Date: Wed, 18 Nov 2026 10:02:45 +0800
Message-ID: <20261118020246.2432333-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118020246.2432333-1-maobibo@loongson.cn>
References: <20261118020246.2432333-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx6c3nBv1q7ng1AA--.29919S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr1DuF1xuFW7Xr4kGw4xKrX_yoW5WFWUpF
 n8Ca4YkFy8KrZ7W3yfJ345uFs8Wr18G342qFsxGw1FgayfGw1rXrs7t39FqFWfAa45Xr1I
 vF1Fq34DWF4UZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
 AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
 r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6x
 IIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
 w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
 0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8QJ57UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This reverts commit 9e771d547b72d1eecd962725fad7508af3b97183.

The reverted change drops the vmstate_tlb fields on the assumption that
LoongArch guests can rebuild TLB entries from scratch.  That assumption is
functionally valid, but the change was not gated behind a new machine type,
so it altered the migration stream layout of the already-released
virt-11.1 machine. As a result, migration from QEMU 11.1 to current
master fails.

With the revert applied, migration succeeds with:
(receiver, current master)
  qemu-system-loongarch64 -M virt-11.1 -m 256M -display none \
      -incoming "exec:cat /tmp/loongarch-virt-11.1.mig" -monitor stdio

using the stream produced by QEMU 11.1 (sender):
  qemu-system-loongarch64 -M virt-11.1 -m 256M -display none -monitor stdio
  (qemu) migrate "exec:cat > /tmp/loongarch-virt-11.1.mig"

Revert restores the virt-11.1 migration layout. If the TLB-dropping
optimisation is still desirable, it should be re-introduced behind a new
machine type (e.g. virt-11.2) so that existing guests remain migratable.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4879
Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/machine.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 4acab2a4a3..957dc2ed71 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -175,6 +175,38 @@ static const VMStateDescription vmstate_pmu = {
     },
 };
 
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+static bool tlb_needed(void *opaque)
+{
+    return tcg_enabled();
+}
+
+/* TLB state */
+static const VMStateDescription vmstate_tlb_entry = {
+    .name = "cpu/tlb_entry",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(tlb_misc, LoongArchTLB),
+        VMSTATE_UINT64(tlb_entry0, LoongArchTLB),
+        VMSTATE_UINT64(tlb_entry1, LoongArchTLB),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_tlb = {
+    .name = "cpu/tlb",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = tlb_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
+                             0, vmstate_tlb_entry, LoongArchTLB),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
@@ -251,6 +283,9 @@ const VMStateDescription vmstate_loongarch_cpu = {
         &vmstate_fpu,
         &vmstate_lsx,
         &vmstate_lasx,
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+        &vmstate_tlb,
+#endif
         &vmstate_lbt,
         &vmstate_msgint,
         &vmstate_pmu,
-- 
2.54.0


