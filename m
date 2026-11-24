Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3316606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl0W-0005Hh-4s; Tue, 24 Nov 2026 02:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xVl0U-0005Gq-Go
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:32:02 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xVl0R-000070-QY
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:32:02 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxuLVlPQVr0HwiAA--.4737S3;
 Tue, 24 Nov 2026 15:31:49 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front2 (Coremail) with SMTP id qciowJAxjn9hPQVrL6YNAA--.315S3;
 Tue, 24 Nov 2026 15:31:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/6] target/loongarch: Use local variable for exception index
Date: Tue, 24 Nov 2026 15:33:16 +0800
Message-ID: <20261124073321.3015041-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124073321.3015041-1-maobibo@loongson.cn>
References: <20261124073321.3015041-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowJAxjn9hPQVrL6YNAA--.315S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAryxJr1fKw1UuF1xWw1rAFc_yoW5GF4xpF
 129342gFZ7tF17Zr1qqayrK3W5Ga17C3ykGw1Ig34Fk3sYqr1vkr4v939Iqr15ZFWkZa48
 Zay5ZryUJa1UurgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
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

Add local variable excp for exception index.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 5662b2c49a..4089231d04 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -47,51 +47,51 @@ bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
 static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
                                 MMUAccessType access_type, TLBRet tlb_error)
 {
+    int32_t excp = 0;
     CPUState *cs = env_cpu(env);
     CPUSysState *sys = env_sys(env);
 
     switch (tlb_error) {
     default:
     case TLBRET_BADADDR:
-        cs->exception_index = access_type == MMU_INST_FETCH
-                              ? EXCCODE_ADEF : EXCCODE_ADEM;
+        excp = (access_type == MMU_INST_FETCH) ? EXCCODE_ADEF : EXCCODE_ADEM;
         break;
     case TLBRET_NOMATCH:
         /* No TLB match for a mapped address */
         if (access_type == MMU_DATA_LOAD) {
-            cs->exception_index = EXCCODE_PIL;
+            excp = EXCCODE_PIL;
         } else if (access_type == MMU_DATA_STORE) {
-            cs->exception_index = EXCCODE_PIS;
+            excp = EXCCODE_PIS;
         } else if (access_type == MMU_INST_FETCH) {
-            cs->exception_index = EXCCODE_PIF;
+            excp = EXCCODE_PIF;
         }
         sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
         break;
     case TLBRET_INVALID:
         /* TLB match with no valid bit */
         if (access_type == MMU_DATA_LOAD) {
-            cs->exception_index = EXCCODE_PIL;
+            excp = EXCCODE_PIL;
         } else if (access_type == MMU_DATA_STORE) {
-            cs->exception_index = EXCCODE_PIS;
+            excp = EXCCODE_PIS;
         } else if (access_type == MMU_INST_FETCH) {
-            cs->exception_index = EXCCODE_PIF;
+            excp = EXCCODE_PIF;
         }
         break;
     case TLBRET_DIRTY:
         /* TLB match but 'D' bit is cleared */
-        cs->exception_index = EXCCODE_PME;
+        excp = EXCCODE_PME;
         break;
     case TLBRET_XI:
         /* Execute-Inhibit Exception */
-        cs->exception_index = EXCCODE_PNX;
+        excp = EXCCODE_PNX;
         break;
     case TLBRET_RI:
         /* Read-Inhibit Exception */
-        cs->exception_index = EXCCODE_PNR;
+        excp = EXCCODE_PNR;
         break;
     case TLBRET_PE:
         /* Privileged Exception */
-        cs->exception_index = EXCCODE_PPI;
+        excp = EXCCODE_PPI;
         break;
     }
 
@@ -109,7 +109,9 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
             sys->CSR_BADV = address;
         }
         sys->CSR_TLBEHI = address & (TARGET_PAGE_MASK << 1);
-   }
+    }
+
+    cs->exception_index = excp;
 }
 
 static void invalidate_tlb_entry(CPULoongArchState *env, int index)
-- 
2.54.0


