Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445D606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4OW-0005zi-1A; Thu, 22 Oct 2026 21:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xK4OJ-0005wu-Sf
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:48:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xK4OF-0005oa-Mh
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:48:19 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxOvDYvNpqCZsYAA--.6363S3;
 Fri, 23 Oct 2026 09:48:08 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxW87SvNpqxF8vAA--.7370S4;
 Fri, 23 Oct 2026 09:48:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 02/10] target/loongarch: Use input parameter mmu_idx rather
 than current mode
Date: Fri, 23 Oct 2026 09:49:22 +0800
Message-ID: <20261023014931.4055823-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023014931.4055823-1-maobibo@loongson.cn>
References: <20261023014931.4055823-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxW87SvNpqxF8vAA--.7370S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7JF1kArykAFWUGr48CF15trc_yoW8Jry8pr
 97Cr4Ika1kGFZ2yan0v39Fvwn5X39xGw42gaykGryF9rZ8Xw1I9r18Cwn09F1UJw48X3Wj
 g3WvyF4UZa18XacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UNvtZUUUUU=
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

With PTW enabled, hardware accesses page table entry with physical
address, which equals to MMU_DA_IDX mode, even if current CPU runs in
PAGE enabled. Here use input parameter mmu_idx rather than checking
current CPU running mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>
---
 target/loongarch/cpu_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 123cad3d93..8a4f8ebc4d 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -319,13 +319,11 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     uint32_t plv, base_c, base_v;
     int64_t addr_high;
     CPUSysState *sys = env_sys(env);
-    uint8_t da = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, DA);
-    uint8_t pg = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG);
     vaddr address;
 
     /* Check PG and DA */
     address = context->addr;
-    if (da & !pg) {
+    if (mmu_idx == MMU_DA_IDX) {
         context->physical = address & loongarch_palen_mask(env);
         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         context->mmu_index = MMU_DA_IDX;
-- 
2.54.0


