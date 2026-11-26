Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A92606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWTfb-0003lH-Ue; Thu, 26 Nov 2026 02:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xWTfX-0003j8-MS
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:23 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xWTfU-0003BK-KT
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:23 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxpvAJ3Adr0yojAA--.34259S3;
 Thu, 26 Nov 2026 15:13:13 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxg8wA3AdrsX03AA--.16771S4;
 Thu, 26 Nov 2026 15:13:11 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 02/18] target/loongarch: Remove debug exception support
Date: Thu, 26 Nov 2026 15:14:24 +0800
Message-ID: <20261126071440.3293877-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126071440.3293877-1-maobibo@loongson.cn>
References: <20261126071440.3293877-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxg8wA3AdrsX03AA--.16771S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKF1rWr1DGw17WrWxWF1DXFc_yoW7WF1rpr
 4S9rykKay8KFZIya4rXa90vFn8Xr4xCw42va1SyryfCrs8XrW8XF4kt39F9F15J34rJry0
 vFn5A3yUXF4xW3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UMpBfUUUUU=
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

The debug exception is not clear on LoongArch manual, and Linux kernel
does not support debug exception now. Here remove debug exception
support for the present.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-csr.h                     | 13 +------------
 target/loongarch/cpu.c                         |  2 +-
 target/loongarch/csr.c                         |  3 ---
 target/loongarch/disas.c                       |  3 ---
 .../tcg/insn_trans/trans_privileged.c.inc      |  7 ++-----
 target/loongarch/tcg/tcg_cpu.c                 | 18 +-----------------
 target/loongarch/tcg/tlb_helper.c              |  4 +---
 7 files changed, 6 insertions(+), 44 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index d860417af2..7830573601 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -211,17 +211,6 @@ FIELD(CSR_DMW_64, VSEG, 60, 4)
 #define LOONGARCH_CSR_PERFCTRL(N)    (0x200 + 2 * N)
 #define LOONGARCH_CSR_PERFCNTR(N)    (0x201 + 2 * N)
 
-/* Debug CSRs */
-#define LOONGARCH_CSR_DBG            0x500 /* debug config */
-FIELD(CSR_DBG, DST, 0, 1)
-FIELD(CSR_DBG, DREV, 1, 7)
-FIELD(CSR_DBG, DEI, 8, 1)
-FIELD(CSR_DBG, DCL, 9, 1)
-FIELD(CSR_DBG, DFW, 10, 1)
-FIELD(CSR_DBG, DMW, 11, 1)
-FIELD(CSR_DBG, ECODE, 16, 6)
-
-#define LOONGARCH_CSR_DERA           0x501 /* Debug era */
-#define LOONGARCH_CSR_DSAVE          0x502 /* Debug save */
+#define LOONGARCH_CSR_MAX            (LOONGARCH_CSR_PERFCTRL(MAX_PERF_EVENTS))
 
 #endif /* LOONGARCH_CPU_CSR_H */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 1f3022265a..83664a7c7d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -769,7 +769,7 @@ static void loongarch_cpu_dump_csr(CPUState *cs, FILE *f)
     qemu_fprintf(f, "\n");
 
     /* Dump all generic CSR register */
-    for (i = 0; i < LOONGARCH_CSR_DBG; i++) {
+    for (i = 0; i < LOONGARCH_CSR_MAX; i++) {
         csr_info = get_csr(i);
         if (!csr_info || (csr_info->flags & CSRFL_UNUSED)) {
             if (i == (col + 3)) {
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index e474941337..89b4240fe5 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -118,9 +118,6 @@ static CSRInfo csr_info[] = {
     CSR_OFF_ARRAY(PERFCNTR, 14),
     CSR_OFF_ARRAY(PERFCTRL, 15),
     CSR_OFF_ARRAY(PERFCNTR, 15),
-    CSR_OFF(DBG),
-    CSR_OFF(DERA),
-    CSR_OFF(DSAVE),
     CSR_OFF_ARRAY(MSGIS, 0),
     CSR_OFF_ARRAY(MSGIS, 1),
     CSR_OFF_ARRAY(MSGIS, 2),
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 928b8b94c2..42ee106df0 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -103,9 +103,6 @@ static const char * const csr_names[] = {
     CSR_NAME(DMW(1)),
     CSR_NAME(DMW(2)),
     CSR_NAME(DMW(3)),
-    CSR_NAME(DBG),
-    CSR_NAME(DERA),
-    CSR_NAME(DSAVE),
 };
 
 static const char *get_csr_name(unsigned num)
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 7d12e06b35..300361a1da 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -402,11 +402,8 @@ static bool trans_ertn(DisasContext *ctx, arg_ertn *a)
 
 static bool trans_dbcl(DisasContext *ctx, arg_dbcl *a)
 {
-    if (check_plv(ctx)) {
-        return false;
-    }
-    generate_exception(ctx, EXCCODE_DBP);
-    return true;
+    /* Not implemented */
+    return false;
 }
 
 static bool trans_idle(DisasContext *ctx, arg_idle *a)
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 0549506035..0f9f34dcb5 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -54,21 +54,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     }
 
     switch (cs->exception_index) {
-    case EXCCODE_DBP:
-        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DCL, 1);
-        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, ECODE, 0xC);
-        goto set_DERA;
-    set_DERA:
-        sys->CSR_DERA = env->pc;
-        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 1);
-        set_pc(env, sys->CSR_EENTRY + 0x480);
-        break;
     case EXCCODE_INT:
-        if (FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
-            sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DEI, 1);
-            goto set_DERA;
-        }
-        QEMU_FALLTHROUGH;
     case EXCCODE_PIF:
     case EXCCODE_PNX:
     case EXCCODE_ADEF:
@@ -203,9 +189,7 @@ static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
     bool ret = 0;
     CPUSysState *sys = env_sys(env);
 
-    ret = (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE) &&
-          !(FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)));
-
+    ret = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE);
     return ret;
 }
 
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 5662b2c49a..f14b50a547 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -105,9 +105,7 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
                                         VPPN, extract64(address, 13, 19));
         }
     } else {
-        if (!FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
-            sys->CSR_BADV = address;
-        }
+        sys->CSR_BADV = address;
         sys->CSR_TLBEHI = address & (TARGET_PAGE_MASK << 1);
    }
 }
-- 
2.54.0


