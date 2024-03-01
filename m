Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CEBC54E49
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 15:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg4PW-0004z5-NC; Fri, 01 Mar 2024 10:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liyongtai@iscas.ac.cn>)
 id 1rg4PG-0004yL-U7
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:02:41 -0500
Received: from [159.226.251.81] (helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liyongtai@iscas.ac.cn>)
 id 1rg4P4-0005An-JU
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:02:38 -0500
Received: from localhost.localdomain (unknown [27.198.242.149])
 by APP-03 (Coremail) with SMTP id rQCowAC3thKh7OFlU9nVAw--.18391S2;
 Fri, 01 Mar 2024 22:56:36 +0800 (CST)
From: SiHuaN <liyongtai@iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: SiHuaN <liyongtai@iscas.ac.cn>
Subject: [PATCH] Fix unexpected Illegal instruction error on RISC-V.
Date: Fri,  1 Mar 2024 22:55:46 +0800
Message-ID: <20240301145545.333810-2-liyongtai@iscas.ac.cn>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAC3thKh7OFlU9nVAw--.18391S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyxuF48uFy8Zr13Kr4kZwb_yoW3ZFb_Wr
 s2gF98u3yUWa1jyanxCr90kr4Uuay8WrnrK3y7tr10k34UC343Cwnrt3Z3ZF129rW5Gr9a
 y3ZrGry7GrW2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbwxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
 v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
 xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYwIDUUUUU
X-Originating-IP: [27.198.242.149]
X-CM-SenderInfo: pol100pjwdxq5lvft2wodfhubq/
X-Host-Lookup-Failed: Reverse DNS lookup failed for 159.226.251.81 (deferred)
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=liyongtai@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Avoid right-shifting by a negative number of bits when lmul is 8.

Signed-off-by: SiHuaN <liyongtai@iscas.ac.cn>
---
 target/riscv/vector_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 84cec73eb2..f0158ea237 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -53,10 +53,11 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
          * VLEN * LMUL >= SEW
          * VLEN >> (8 - lmul) >= sew
          * (vlenb << 3) >> (8 - lmul) >= sew
+         * Considering that lmul may be 8, the following form cannot be used.
          * vlenb >> (8 - 3 - lmul) >= sew
          */
         if (vlmul == 4 ||
-            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
+            (cpu->cfg.vlenb << 3) >> (8 - vlmul) < sew) {
             vill = true;
         }
     }
-- 
2.44.0


