Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBB606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl0X-0005IB-K1; Tue, 24 Nov 2026 02:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xVl0W-0005Hn-MW
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:32:04 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xVl0U-000084-KS
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:32:04 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Cxf9NvPQVr4HwiAA--.32675S3;
 Tue, 24 Nov 2026 15:31:59 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front2 (Coremail) with SMTP id qciowJAxjn9oPQVrMaYNAA--.317S4;
 Tue, 24 Nov 2026 15:31:56 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 6/6] target/loongarch: Set exception.badv for memory access
Date: Tue, 24 Nov 2026 15:33:21 +0800
Message-ID: <20261124073321.3015041-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124073321.3015041-1-maobibo@loongson.cn>
References: <20261124073321.3015041-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowJAxjn9oPQVrMaYNAA--.317S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGrWxWFWrtF47CF13Zw48Zrc_yoWrArWDpF
 yIkry7KFW8CrWDZ3s7t3y5tF15Cr4xC3yjgF1xJ3ySkw4Sqr1Fqr4kt39I9Fy5G3y5Wr1j
 vFsYvw1j9ayUWacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU
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

For some memory access exceptions, record the badv address in the
software state field exception.badv instead of writing CSR_BADV
directly. The hardware CSR_BADV register is then set in
loongarch_cpu_do_interrupt().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/op_helper.c  | 23 ++++++++---------------
 target/loongarch/tcg/tcg_cpu.c    | 12 ++++++++----
 target/loongarch/tcg/tlb_helper.c |  5 ++---
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index 18994f5dc0..1f1d1ac079 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -26,41 +26,34 @@ void HELPER(raise_exception)(CPULoongArchState *env, uint32_t exception)
 /* loongarch assert op */
 void HELPER(asrtle_d)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
-    CPUSysState *sys = env_sys(env);
 
     if ((target_long)rj > (target_long)rk) {
-        sys->CSR_BADV = rj;
-        do_raise_exception(env, EXCCODE_BCE, GETPC());
+        raise_exception_full(env, EXCCODE_BCE, GETPC(), LOONGARCH_EXCEPTION_MM,
+                             rj);
     }
 }
 
 void HELPER(asrtgt_d)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
-    CPUSysState *sys = env_sys(env);
-
     if ((target_long)rj <= (target_long)rk) {
-        sys->CSR_BADV = rj;
-        do_raise_exception(env, EXCCODE_BCE, GETPC());
+        raise_exception_full(env, EXCCODE_BCE, GETPC(), LOONGARCH_EXCEPTION_MM,
+                             rj);
     }
 }
 
 void HELPER(asrtle_du)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
-    CPUSysState *sys = env_sys(env);
-
     if (rj > rk) {
-        sys->CSR_BADV = rj;
-        do_raise_exception(env, EXCCODE_BCE, GETPC());
+        raise_exception_full(env, EXCCODE_BCE, GETPC(), LOONGARCH_EXCEPTION_MM,
+                             rj);
     }
 }
 
 void HELPER(asrtgt_du)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
-    CPUSysState *sys = env_sys(env);
-
     if (rj <= rk) {
-        sys->CSR_BADV = rj;
-        do_raise_exception(env, EXCCODE_BCE, GETPC());
+        raise_exception_full(env, EXCCODE_BCE, GETPC(), LOONGARCH_EXCEPTION_MM,
+                             rj);
     }
 }
 
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 3d0d6a5a2a..f6c3fd8d1a 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -140,6 +140,10 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA,
                                       PC, (env->pc >> 2));
     } else {
+        if (flags & LOONGARCH_EXCEPTION_MM) {
+            sys->CSR_BADV = address;
+        }
+
         if (flags & LOONGARCH_EXCEPTION_TLB) {
             if (!FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
                 sys->CSR_BADV = address;
@@ -215,13 +219,13 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                                 uintptr_t retaddr)
 {
     CPULoongArchState *env = cpu_env(cs);
-    CPUSysState *sys = env_sys(env);
 
-    sys->CSR_BADV = addr;
     if (access_type == MMU_INST_FETCH) {
-        do_raise_exception(env, EXCCODE_ADEF, retaddr);
+        raise_exception_full(env, EXCCODE_ADEF, retaddr, LOONGARCH_EXCEPTION_MM,
+                             addr);
     } else {
-        do_raise_exception(env, EXCCODE_ADEM, retaddr);
+        raise_exception_full(env, EXCCODE_ADEM, retaddr, LOONGARCH_EXCEPTION_MM,
+                             addr);
     }
 }
 
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 52ac326df0..566555734f 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -696,14 +696,13 @@ G_NORETURN void loongarch_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                                   uintptr_t retaddr)
 {
     CPULoongArchState *env = cpu_env(cs);
-    CPUSysState *sys = env_sys(env);
 
     /*
      * Unaligned accesses are currently triggered by atomic instructions
      * that impose alignment requirements on memory operands.
      */
-    sys->CSR_BADV = vaddr;
-    do_raise_exception(env, EXCCODE_ALE, retaddr);
+    raise_exception_full(env, EXCCODE_ALE, retaddr, LOONGARCH_EXCEPTION_MM,
+                         vaddr);
 }
 
 static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
-- 
2.54.0


