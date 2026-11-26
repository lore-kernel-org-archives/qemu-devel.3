Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED937606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWTgJ-0004LT-8M; Thu, 26 Nov 2026 02:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xWTg6-00043k-64
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:58 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xWTg1-0003Dm-Oc
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:55 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Bx9bQl3Adr+yojAA--.6391S3;
 Thu, 26 Nov 2026 15:13:41 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxtMwk3AdrwX03AA--.17808S2;
 Thu, 26 Nov 2026 15:13:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 16/18] target/loongarch: Add generic csrwr helper
Date: Thu, 26 Nov 2026 15:14:38 +0800
Message-ID: <20261126071440.3293877-17-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126071440.3293877-1-maobibo@loongson.cn>
References: <20261126071440.3293877-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxtMwk3AdrwX03AA--.17808S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr47Cr4kWFyfAr4DCFyrZrc_yoW7WrWkpF
 WIkrWxur48K392v3WSg3Z09r15Zw4fKa1xXws7K3s29a13XrZ5XrW0yw1a9Fn8JrWrWryF
 y3WFyr1xZrW5X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsdb1UUUUU
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

Here add generic csrwr helper. With default path, it checks the wrmask
of specific CSR register and keep read-only bits unchanged.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/csr_helper.c             | 43 +++++++++++++++++++
 target/loongarch/tcg/helper.h                 |  1 +
 .../tcg/insn_trans/trans_privileged.c.inc     | 24 ++++++-----
 3 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 07b4b25fbd..7548993489 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -17,6 +17,7 @@
 #include "hw/core/irq.h"
 #include "cpu-csr.h"
 #include "cpu-mmu.h"
+#include "csr.h"
 
 target_ulong HELPER(csrwr_stlbps)(CPULoongArchState *env, target_ulong val)
 {
@@ -185,3 +186,45 @@ target_ulong HELPER(csrwr_pwch)(CPULoongArchState *env, target_ulong val)
     sys->CSR_PWCH = val;
     return old_v;
  }
+
+target_ulong HELPER(csrwr)(CPULoongArchState *env, target_ulong val,
+                           uint32_t csr)
+{
+    const CSRInfo *csrinfo;
+    int64_t *pcsr, offset, old_v = 0;
+
+    switch (csr) {
+    case LOONGARCH_CSR_STLBPS:
+        return HELPER(csrwr_stlbps)(env, val);
+
+    case LOONGARCH_CSR_ESTAT:
+        return HELPER(csrwr_estat)(env, val);
+
+    case LOONGARCH_CSR_ASID:
+        return HELPER(csrwr_asid)(env, val);
+
+    case LOONGARCH_CSR_TCFG:
+        return HELPER(csrwr_tcfg)(env, val);
+
+    case LOONGARCH_CSR_TICLR:
+        return HELPER(csrwr_ticlr)(env, val);
+
+    case LOONGARCH_CSR_PWCL:
+        return HELPER(csrwr_pwcl)(env, val);
+
+    case LOONGARCH_CSR_PWCH:
+        return HELPER(csrwr_pwch)(env, val);
+
+    default:
+        csrinfo = get_csr(csr);
+        if (!csrinfo) {
+            return old_v;
+        }
+
+        offset = get_csr_offset(csrinfo, 0);
+        pcsr = (int64_t *)((void*)env + offset);
+        old_v = *pcsr;
+        *pcsr = val & csrinfo->wrmask;
+        return old_v;
+    }
+}
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 60ebf35d1f..719fa8b86a 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -105,6 +105,7 @@ DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
 DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
 DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
 DEF_HELPER_2(csrwr_pwch, i64, env, tl)
+DEF_HELPER_3(csrwr, i64, env, tl, i32)
 DEF_HELPER_2(iocsrrd_b, i64, env, tl)
 DEF_HELPER_2(iocsrrd_h, i64, env, tl)
 DEF_HELPER_2(iocsrrd_w, i64, env, tl)
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index e3bd68ce36..d9fc8f2695 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -43,7 +43,7 @@ GEN_FALSE_TRANS(idle)
 #else
 
 typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env);
-typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src);
+typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src, TCGv_i32 csr);
 
 static bool check_plv(DisasContext *ctx)
 {
@@ -111,15 +111,15 @@ static void init_csr_wrmask(void)
 
 void loongarch_csr_translate_init(void)
 {
-    SET_CSR_FUNC(STLBPS, NULL, gen_helper_csrwr_stlbps);
-    SET_CSR_FUNC(ESTAT, NULL, gen_helper_csrwr_estat);
-    SET_CSR_FUNC(ASID,  NULL, gen_helper_csrwr_asid);
+    SET_CSR_FUNC(STLBPS, NULL, gen_helper_csrwr);
+    SET_CSR_FUNC(ESTAT, NULL, gen_helper_csrwr);
+    SET_CSR_FUNC(ASID,  NULL, gen_helper_csrwr);
     SET_CSR_FUNC(PGD,   gen_helper_csrrd_pgd, NULL);
-    SET_CSR_FUNC(PWCL,  NULL, gen_helper_csrwr_pwcl);
-    SET_CSR_FUNC(PWCH,  NULL, gen_helper_csrwr_pwch);
-    SET_CSR_FUNC(TCFG,  NULL, gen_helper_csrwr_tcfg);
+    SET_CSR_FUNC(PWCL,  NULL, gen_helper_csrwr);
+    SET_CSR_FUNC(PWCH,  NULL, gen_helper_csrwr);
+    SET_CSR_FUNC(TCFG,  NULL, gen_helper_csrwr);
     SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
-    SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
+    SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr);
     SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
     init_csr_wrmask();
 }
@@ -178,6 +178,7 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
     GenCSRWrite writefn;
     tcg_target_long offset;
     bool rdonly;
+    TCGv_i32 csrid;
 
     if (check_plv(ctx)) {
         return false;
@@ -198,7 +199,8 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
     writefn = (GenCSRWrite)csr->writefn;
     if (writefn) {
         dest = gpr_dst(ctx, a->rd, EXT_NONE);
-        writefn(dest, tcg_env, src1);
+        csrid = tcg_constant_i32(a->csr);
+        writefn(dest, tcg_env, src1, csrid);
     } else {
         dest = tcg_temp_new();
         offset = get_csr_offset(csr, 0);
@@ -223,6 +225,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     GenCSRWrite writefn;
     tcg_target_long offset;
     bool rdonly;
+    TCGv_i32 csrid;
 
     if (check_plv(ctx)) {
         return false;
@@ -260,7 +263,8 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
 
     writefn = (GenCSRWrite)csr->writefn;
     if (writefn) {
-        writefn(oldv, tcg_env, newv);
+        csrid = tcg_constant_i32(a->csr);
+        writefn(oldv, tcg_env, newv, csrid);
     } else {
         tcg_gen_st_tl(newv, tcg_env, offset);
     }
-- 
2.54.0


