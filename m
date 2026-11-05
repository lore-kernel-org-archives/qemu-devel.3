Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165C606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrLQ-00074v-Dw; Thu, 05 Nov 2026 01:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xOrLJ-00073o-1w; Thu, 05 Nov 2026 01:53:02 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1xOrLH-0000oI-BS; Thu, 05 Nov 2026 01:53:00 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxztK0J+xqa48cAA--.16777S3;
 Thu, 05 Nov 2026 14:52:36 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBxKs6zJ+xq_IEyAA--.18062S3;
 Thu, 05 Nov 2026 14:52:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 13/13] target/loongarch: Clear PAGE_READ when PTE.NR is set
Date: Thu,  5 Nov 2026 14:53:45 +0800
Message-ID: <20261105065345.966691-14-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105065345.966691-1-maobibo@loongson.cn>
References: <20261105065345.966691-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxKs6zJ+xq_IEyAA--.18062S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrZw1fWF15Cw4xtw45Xw47GFX_yoW8Jr4xpr
 ZrZr9FkF4UGFZ3A3Wqva4q9wn8Gwn3GF1IganIkry0v398JwnYgF1rt34q9F18JayUJ3WY
 9a40yFy5XF48XacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
 aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
 kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
 xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42
 IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
 6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
 CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU84xRDUUUUU==
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On LoongArch the NR bit in a PTE indicates that the page is not
readable, i.e. it is write-only. When translating a PTE to QEMU
protection bits, clear PAGE_READ if PTE.NR is set instead of always
exposing PAGE_READ.

This avoids incorrectly marking a write-only page as readable.

Cc: qemu-stable@nongnu.org
Fixes: 7392cb1c7b24 ("target/loongarch: Add common function loongarch_check_pte()")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
---
 target/loongarch/cpu_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 271b4adc17..6b98fff691 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -101,7 +101,10 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
 
     context->physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
                         (context->addr & MAKE_64BIT_MASK(0, tlb_ps));
-    context->prot = PAGE_READ;
+    context->prot = 0;
+    if (!tlb_nr) {
+        context->prot |= PAGE_READ;
+    }
     context->mmu_index = tlb_plv;
     if (tlb_d) {
         context->prot |= PAGE_WRITE;
-- 
2.54.0


