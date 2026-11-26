Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED484606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWTgG-0004I0-Qc; Thu, 26 Nov 2026 02:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xWTg1-00041y-Jn
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:54 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xWTfx-0003De-3i
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:52 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Dxl7Ud3Adr7yojAA--.6457S3;
 Thu, 26 Nov 2026 15:13:34 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAx3c4c3AdrvX03AA--.44576S2;
 Thu, 26 Nov 2026 15:13:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 12/18] target/loongarch: Add write mask to CSRInfo
Date: Thu, 26 Nov 2026 15:14:34 +0800
Message-ID: <20261126071440.3293877-13-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126071440.3293877-1-maobibo@loongson.cn>
References: <20261126071440.3293877-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx3c4c3AdrvX03AA--.44576S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKF1rWr15uFW5AFyxWw43XFc_yoWfCF15pr
 47KFy8GryjqFy2k3WrXayYy3ZrWa1IywsIvwsxCr4xtr17Z34rt3ykZw1fJFy5Jr95tryU
 Z3Z5A3yI9r4fJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2F4iUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some bits in LoongArch CSRs are read-only; writes to those bits are
ignored by the hardware. Add a wrmask field to struct CSRInfo so the
set of writable bits can be described per CSR.

This is a preparatory change.
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-csr.h | 51 ++++++++++++++++++++++++++++++++++++++
 target/loongarch/csr.c     |  6 +++--
 target/loongarch/csr.h     |  1 +
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index faad2bbb17..3dff6395b1 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -12,6 +12,9 @@
 
 /* Based on kernel definitions: arch/loongarch/include/asm/loongarch.h */
 
+#define CSR_WRMASK(name, shift, length)                 \
+     enum { LOONGARCH_CSR_##name ##_MASK = MAKE_64BIT_MASK(shift, length)};
+
 /* Basic CSRs */
 #define LOONGARCH_CSR_CRMD           0x0 /* Current mode info */
 FIELD(CSR_CRMD, PLV, 0, 2)
@@ -21,17 +24,20 @@ FIELD(CSR_CRMD, PG, 4, 1)
 FIELD(CSR_CRMD, DATF, 5, 2)
 FIELD(CSR_CRMD, DATM, 7, 2)
 FIELD(CSR_CRMD, WE, 9, 1)
+CSR_WRMASK(CRMD, 0, 10)
 
 #define LOONGARCH_CSR_PRMD           0x1 /* Prev-exception mode info */
 FIELD(CSR_PRMD, PPLV, 0, 2)
 FIELD(CSR_PRMD, PIE, 2, 1)
 FIELD(CSR_PRMD, PWE, 3, 1)
+CSR_WRMASK(PRMD, 0, 4)
 
 #define LOONGARCH_CSR_EUEN           0x2 /* Extended unit enable */
 FIELD(CSR_EUEN, FPE, 0, 1)
 FIELD(CSR_EUEN, SXE, 1, 1)
 FIELD(CSR_EUEN, ASXE, 2, 1)
 FIELD(CSR_EUEN, BTE, 3, 1)
+CSR_WRMASK(EUEN, 0, 4)
 
 #define LOONGARCH_CSR_MISC           0x3 /* Misc config */
 FIELD(CSR_MISC, VA32, 0, 4)
@@ -39,35 +45,44 @@ FIELD(CSR_MISC, DRDTL, 4, 4)
 FIELD(CSR_MISC, RPCNTL, 8, 4)
 FIELD(CSR_MISC, ALCL, 12, 4)
 FIELD(CSR_MISC, DWPL, 16, 3)
+CSR_WRMASK(MISC, 1, 18)
 
 #define LOONGARCH_CSR_ECFG           0x4 /* Exception config */
 FIELD(CSR_ECFG, LIE, 0, 15)        /* bit 15 is msg interrupt enabled */
 FIELD(CSR_ECFG, MSGINT, 14, 1)
 FIELD(CSR_ECFG, VS, 16, 3)
+CSR_WRMASK(ECFG, 0, 19)
 
 #define LOONGARCH_CSR_ESTAT          0x5 /* Exception status */
 FIELD(CSR_ESTAT, IS, 0, 15)        /* bit 15 is msg interrupt enabled */
 FIELD(CSR_ESTAT, MSGINT, 14, 1)
 FIELD(CSR_ESTAT, ECODE, 16, 6)
 FIELD(CSR_ESTAT, ESUBCODE, 22, 9)
+CSR_WRMASK(ESTAT, 0, 2)
 
 #define LOONGARCH_CSR_ERA            0x6 /* Exception return address */
+CSR_WRMASK(ERA, 0, 64)
 
 #define LOONGARCH_CSR_BADV           0x7 /* Bad virtual address */
+CSR_WRMASK(BADV, 0, 64)
 
 #define LOONGARCH_CSR_BADI           0x8 /* Bad instruction */
+CSR_WRMASK(BADI, 0, 1)         /* fail to compile with (BADI, 0, 0) */
 
 #define LOONGARCH_CSR_EENTRY         0xc /* Exception entry address */
+CSR_WRMASK(EENTRY, 12, 52)
 
 /* TLB related CSRs */
 #define LOONGARCH_CSR_TLBIDX         0x10 /* TLB Index, EHINV, PageSize, NP */
 FIELD(CSR_TLBIDX, INDEX, 0, 12)
 FIELD(CSR_TLBIDX, PS, 24, 6)
 FIELD(CSR_TLBIDX, NE, 31, 1)
+CSR_WRMASK(TLBIDX, 0, 32)
 
 #define LOONGARCH_CSR_TLBEHI         0x11 /* TLB EntryHi */
 FIELD(CSR_TLBEHI_32, VPPN, 13, 19)
 FIELD(CSR_TLBEHI_64, VPPN, 13, 35)
+CSR_WRMASK(TLBEHI, 13, 35)
 
 #define LOONGARCH_CSR_TLBELO0        0x12 /* TLB EntryLo0 */
 #define LOONGARCH_CSR_TLBELO1        0x13 /* TLB EntryLo1 */
@@ -86,17 +101,23 @@ FIELD(TLBENTRY_64, PPN, 12, 36)
 FIELD(TLBENTRY_64, NR, 61, 1)
 FIELD(TLBENTRY_64, NX, 62, 1)
 FIELD(TLBENTRY_64, RPLV, 63, 1)
+CSR_WRMASK(TLBELO0, 0, 64)
+CSR_WRMASK(TLBELO1, 0, 64)
 
 #define LOONGARCH_CSR_ASID           0x18 /* Address space identifier */
 FIELD(CSR_ASID, ASID, 0, 10)
 FIELD(CSR_ASID, ASIDBITS, 16, 8)
+CSR_WRMASK(ASID, 0, 10)
 
 /* Page table base address when badv[47] = 0 */
 #define LOONGARCH_CSR_PGDL           0x19
+CSR_WRMASK(PGDL, 12, 52)
 /* Page table base address when badv[47] = 1 */
 #define LOONGARCH_CSR_PGDH           0x1a
+CSR_WRMASK(PGDH, 12, 52)
 
 #define LOONGARCH_CSR_PGD            0x1b /* Page table base address */
+CSR_WRMASK(PGD, 0, 1)
 
 /* Page walk controller's low addr */
 #define LOONGARCH_CSR_PWCL           0x1c
@@ -107,6 +128,7 @@ FIELD(CSR_PWCL, DIR1_WIDTH, 15, 5)
 FIELD(CSR_PWCL, DIR2_BASE, 20, 5)
 FIELD(CSR_PWCL, DIR2_WIDTH, 25, 5)
 FIELD(CSR_PWCL, PTEWIDTH, 30, 2)
+CSR_WRMASK(PWCL, 0, 32)
 
 /* Page walk controller's high addr */
 #define LOONGARCH_CSR_PWCH           0x1d
@@ -116,87 +138,113 @@ FIELD(CSR_PWCH, DIR4_BASE, 12, 6)
 FIELD(CSR_PWCH, DIR4_WIDTH, 18, 6)
 FIELD(CSR_PWCH, HPTW_EN, 24, 1)
 FIELD(CSR_PWCH, RESERVE, 25, 7)
+CSR_WRMASK(PWCH, 0, 24)
 
 #define LOONGARCH_CSR_STLBPS         0x1e /* Stlb page size */
 FIELD(CSR_STLBPS, PS, 0, 5)
 FIELD(CSR_STLBPS, RESERVE, 5, 27)
+CSR_WRMASK(STLBPS, 0, 6)
 
 #define LOONGARCH_CSR_RVACFG         0x1f /* Reduced virtual address config */
 FIELD(CSR_RVACFG, RBITS, 0, 4)
+CSR_WRMASK(RVACFG, 0, 4)
 
 /* Config CSRs */
 #define LOONGARCH_CSR_CPUID          0x20 /* CPU core id */
+CSR_WRMASK(CPUID, 0, 1)
 
 #define LOONGARCH_CSR_PRCFG1         0x21 /* Config1 */
 FIELD(CSR_PRCFG1, SAVE_NUM, 0, 4)
 FIELD(CSR_PRCFG1, TIMER_BITS, 4, 8)
 FIELD(CSR_PRCFG1, VSMAX, 12, 3)
+CSR_WRMASK(PRCFG1, 0, 1)
 
 #define LOONGARCH_CSR_PRCFG2         0x22 /* Config2 */
+CSR_WRMASK(PRCFG2, 0, 1)
 
 #define LOONGARCH_CSR_PRCFG3         0x23 /* Config3 */
 FIELD(CSR_PRCFG3, TLB_TYPE, 0, 4)
 FIELD(CSR_PRCFG3, MTLB_ENTRY, 4, 8)
 FIELD(CSR_PRCFG3, STLB_WAYS, 12, 8)
 FIELD(CSR_PRCFG3, STLB_SETS, 20, 8)
+CSR_WRMASK(PRCFG3, 0, 1)
 
 /*
  * Save registers count can read from PRCFG1.SAVE_NUM
  * The Min count is 1. Max count is 15.
  */
 #define LOONGARCH_CSR_SAVE(N)        (0x30 + N)
+CSR_WRMASK(SAVE, 0, 64)
 
 /* Timer CSRs */
 #define LOONGARCH_CSR_TID            0x40 /* Timer ID */
+CSR_WRMASK(TID, 0, 32)
 
 #define LOONGARCH_CSR_TCFG           0x41 /* Timer config */
 FIELD(CSR_TCFG, EN, 0, 1)
 FIELD(CSR_TCFG, PERIODIC, 1, 1)
 FIELD(CSR_TCFG, INIT_VAL, 2, 46)
+CSR_WRMASK(TCFG, 0, 48)
 
 #define LOONGARCH_CSR_TVAL           0x42 /* Timer ticks remain */
+CSR_WRMASK(TVAL, 0, 1)
 
 #define LOONGARCH_CSR_CNTC           0x43 /* Timer offset */
+CSR_WRMASK(CNTC, 0, 64)
 
 #define LOONGARCH_CSR_TICLR          0x44 /* Timer interrupt clear */
+CSR_WRMASK(TICLR, 0, 1)
 
 /* LLBCTL CSRs */
 #define LOONGARCH_CSR_LLBCTL         0x60 /* LLBit control */
 FIELD(CSR_LLBCTL, ROLLB, 0, 1)
 FIELD(CSR_LLBCTL, WCLLB, 1, 1)
 FIELD(CSR_LLBCTL, KLO, 2, 1)
+CSR_WRMASK(LLBCTL, 1, 2)
 
 /* Implement dependent */
 #define LOONGARCH_CSR_IMPCTL1        0x80 /* LoongArch config1 */
+CSR_WRMASK(IMPCTL1, 0, 64)
 
 #define LOONGARCH_CSR_IMPCTL2        0x81 /* LoongArch config2*/
+CSR_WRMASK(IMPCTL2, 0, 64)
 
 /* TLB Refill CSRs */
 #define LOONGARCH_CSR_TLBRENTRY      0x88 /* TLB refill exception address */
+CSR_WRMASK(TLBRENTRY, 12, 36)
 #define LOONGARCH_CSR_TLBRBADV       0x89 /* TLB refill badvaddr */
+CSR_WRMASK(TLBRBADV, 0, 64)
 #define LOONGARCH_CSR_TLBRERA        0x8a /* TLB refill ERA */
 FIELD(CSR_TLBRERA, ISTLBR, 0, 1)
 FIELD(CSR_TLBRERA, PC, 2, 62)
+CSR_WRMASK(TLBRERA, 0, 64)
 #define LOONGARCH_CSR_TLBRSAVE       0x8b /* KScratch for TLB refill */
+CSR_WRMASK(TLBRSAVE, 0, 64)
 #define LOONGARCH_CSR_TLBRELO0       0x8c /* TLB refill entrylo0 */
+CSR_WRMASK(TLBRELO0, 0, 64)
 #define LOONGARCH_CSR_TLBRELO1       0x8d /* TLB refill entrylo1 */
+CSR_WRMASK(TLBRELO1, 0, 64)
 #define LOONGARCH_CSR_TLBREHI        0x8e /* TLB refill entryhi */
 FIELD(CSR_TLBREHI, PS, 0, 6)
 FIELD(CSR_TLBREHI_32, VPPN, 13, 19)
 FIELD(CSR_TLBREHI_64, VPPN, 13, 35)
+CSR_WRMASK(TLBREHI, 0, 48)
 #define LOONGARCH_CSR_TLBRPRMD       0x8f /* TLB refill mode info */
 FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
 FIELD(CSR_TLBRPRMD, PIE, 2, 1)
 FIELD(CSR_TLBRPRMD, PWE, 4, 1)
+CSR_WRMASK(TLBRPRMD, 0, 5)
 
 /*Msg interrupt registers */
 #define N_MSGIS                      4
 #define LOONGARCH_CSR_MSGIS(N)       (0xa0 + N)
 FIELD(CSR_MSGIS, IS, 0, 63)
+CSR_WRMASK(MSGIS, 0, 1)
 
 #define LOONGARCH_CSR_MSGIR               0xa4
 FIELD(CSR_MSGIR, INTNUM, 0, 8)
 FIELD(CSR_MSGIR, ACTIVE, 31, 1)
+CSR_WRMASK(MSGIR, 0, 1)
 
 FIELD(CSR_MSGIE, PT, 0, 8)
 
@@ -210,11 +258,14 @@ FIELD(CSR_DMW, MAT, 4, 2)
 FIELD(CSR_DMW_32, PSEG, 25, 3)
 FIELD(CSR_DMW_32, VSEG, 29, 3)
 FIELD(CSR_DMW_64, VSEG, 60, 4)
+CSR_WRMASK(DMW, 0, 64)
 
 /* Performance Counter registers */
 #define MAX_PERF_EVENTS              16
 #define LOONGARCH_CSR_PERFCTRL(N)    (0x200 + 2 * N)
 #define LOONGARCH_CSR_PERFCNTR(N)    (0x201 + 2 * N)
+CSR_WRMASK(PERFCTRL, 0, 21)
+CSR_WRMASK(PERFCNTR, 0, 64)
 
 #define LOONGARCH_CSR_MAX            (LOONGARCH_CSR_PERFCTRL(MAX_PERF_EVENTS))
 
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index d93eefd1d7..3e7e2ed971 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -10,14 +10,16 @@
     [LOONGARCH_CSR_##NAME] = {                             \
         .name   = (stringify(NAME)),                       \
         .offset = CSR_OFFSET(CSR_##NAME),                  \
-        .flags  = FL                                       \
+        .flags  = FL,                                      \
+        .wrmask = LOONGARCH_CSR_##NAME## _ ## MASK         \
     }
 
 #define CSR_OFF_ARRAY_FLAGS(NAME, N, FL)                   \
     [LOONGARCH_CSR_##NAME(N)] = {                          \
         .name   = (stringify(NAME##N)),                    \
         .offset = CSR_OFFSET(CSR_##NAME[N]),               \
-        .flags  = FL                                       \
+        .flags  = FL,                                      \
+        .wrmask = LOONGARCH_CSR_##NAME## _ ## MASK         \
     }
 
 #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, CSRFL_BASIC)
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index 2108cd596d..33b091a549 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -25,6 +25,7 @@ enum {
 
 typedef struct {
     const char *name;
+    uint64_t wrmask;
     int offset;
     int flags;
     GenCSRFunc readfn;
-- 
2.54.0


