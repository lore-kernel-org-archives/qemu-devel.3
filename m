Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F20606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUDKx-0006qh-0I; Thu, 19 Nov 2026 20:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xUDKr-0006o2-10
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:22:41 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xUDKn-0007SR-VZ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:22:40 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8BxLNDcoP9qFGIhAA--.2392S3;
 Fri, 20 Nov 2026 09:22:36 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxlMzaoP9qtws2AA--.15398S5;
 Fri, 20 Nov 2026 09:22:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 11/16] target/loongarch: Return sign-extended value when
 reading 32-bit CSR registers
Date: Fri, 20 Nov 2026 09:23:51 +0800
Message-ID: <20261120012356.2656317-12-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120012356.2656317-1-maobibo@loongson.cn>
References: <20261120012356.2656317-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxlMzaoP9qtws2AA--.15398S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw4xWr1UXrWrurWfGFWDZFc_yoW5Jr1fpr
 nrCr1jvr1UJrW5Za93Cws8KF98W3W8Ga12qas3K34rCrW3Jrn8ta1vyrya93WUA3yrZr4F
 9FWrAw1kua1UZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUco7KUUUUU
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

For a 32-bit CSR register, when it is read by a CSR read instruction,
the result is sign-extended and written to the destination general-purpose
register.

Add this behavior according to the manual.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/csr.h                         |  5 +++++
 .../tcg/insn_trans/trans_privileged.c.inc      | 18 +++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index 87790aa84c..0d36805756 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -37,4 +37,9 @@ static inline unsigned int get_csr_offset(const CSRInfo *csr, int vm_level)
 {
     return csr->offset + offsetof(CPULoongArchState, sys_states[vm_level]);
 }
+
+static inline bool csr_is_width32(const CSRInfo *csr)
+{
+    return !(csr->flags & CSRFL_WIDTH64);
+}
 #endif /* TARGET_LOONGARCH_CSR_H */
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 7a4f215283..024fd9073a 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -122,7 +122,11 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
             readfn(dest, tcg_env);
         } else {
             offset = get_csr_offset(csr, 0);
-            tcg_gen_ld_tl(dest, tcg_env, offset);
+            if (csr_is_width32(csr)) {
+                tcg_gen_ld32s_tl(dest, tcg_env, offset);
+            } else {
+                tcg_gen_ld_tl(dest, tcg_env, offset);
+            }
         }
     }
     gen_set_gpr(a->rd, dest, EXT_NONE);
@@ -160,7 +164,11 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
     } else {
         dest = tcg_temp_new();
         offset = get_csr_offset(csr, 0);
-        tcg_gen_ld_tl(dest, tcg_env, offset);
+        if (csr_is_width32(csr)) {
+            tcg_gen_ld32s_tl(dest, tcg_env, offset);
+        } else {
+            tcg_gen_ld_tl(dest, tcg_env, offset);
+        }
 
         if (!rdonly) {
             tcg_gen_st_tl(src1, tcg_env, offset);
@@ -196,7 +204,11 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     temp = tcg_temp_new();
 
     offset = get_csr_offset(csr, 0);
-    tcg_gen_ld_tl(oldv, tcg_env, offset);
+    if (csr_is_width32(csr)) {
+        tcg_gen_ld_tl(oldv, tcg_env, offset);
+    } else {
+        tcg_gen_ld32s_tl(oldv, tcg_env, offset);
+    }
     if (rdonly) {
         /* So far only readonly csrs have readfn. */
         assert(csr->readfn == NULL);
-- 
2.54.0


