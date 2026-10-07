Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97016CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENw2-00031u-Tw; Wed, 07 Oct 2026 05:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAN-0004Ff-Vj; Wed, 07 Oct 2026 04:38:24 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENAL-0006Xp-Aj; Wed, 07 Oct 2026 04:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=5QzqLwKWwe4F/b+fjM/vA68Zbgknheq+S88Wd6hHmho=; b=iIKb+skgYXPiaNA
 LbcVcH3LFK+LHmtmmNHN5+oHoV5t+3998G5aOE1/7Z1lXvxuMzHzmySbh0tNg0IrvQRRSf4hkm5F1
 IGgHiEcG5Tcm2qCBruX5wCOrZlU49cybZnSwAjMZWCaHc7/sK4ldPNy5K8yXd7b7HXnT4VN7til/G
 yI=;
Date: Wed, 07 Oct 2026 10:43:17 +0200
Subject: [PATCH v2 11/18] target/riscv: Compile cpu_helper.c once for
 system-mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-11-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=14859;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=z1/zYjvOzncT9MmrVFHowntWe9aLl1V8L6xxvumvF50=;
 b=uncx0w9TtYP5ck4lmbzZyfWLk9X72W5i30cHzEzYN7NOiqhQm2mWTNzpHB5z38xCNkmMaWgmI
 659toK3Ih4pDVccoyiWmdso9Z4l6MREPR/hdCnxIw4nzxdYOfECKtVO
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Makes cpu_helper.c agnostic to compile-time target specifics, allowing
it to be compiled twice (once for user- and once for system mode).
target_[u]long is widened to [u]int64_t and runtime target_long_bits()
is used in place of the equivalent macro.  Most changes are straight
forward and no behavioural change is intended.

Note: the following change might be a bit unclear at first glance

  #define PTE_PPN_MASK 0x3FFFFFFFFFFC00ULL

  - target_ulong pte;
  + uint64_t pte;

  - ppn = (pte & (target_ulong)PTE_PPN_MASK) >> PTE_PPN_SHIFT;
  + ppn = (pte & PTE_PPN_MASK) >> PTE_PPN_SHIFT;

but retains expected behaviour as pte is written a uint32_t for
MXL_RV32, meaning the top bits of PTE_PPN_MASK or chopped of in the &,
rather than truncated.

Note: This commit will print all addresses as 64-bit values, even for a
32-bit target. If breaking this interface is not an option we can
instead opt for more runtime branching, as done by Joel Stanley
in commit 409c7d8682a.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/tcg/cpu_helper.c | 79 ++++++++++++++++++++++---------------------
 target/riscv/tcg/meson.build  |  3 +-
 2 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..ee433a88fe 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "qemu/target-info.h"
 #include "cpu.h"
 #include "internals.h"
 #include "pmu.h"
@@ -28,7 +29,6 @@
 #include "exec/target_page.h"
 #include "system/memory.h"
 #include "instmap.h"
-#include "tcg/tcg-op.h"
 #include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 #include "trace.h"
@@ -1017,7 +1017,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     bool use_background = false;
     hwaddr ppn;
     int napot_bits = 0;
-    target_ulong napot_mask;
+    uint64_t napot_mask;
     bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
     bool sstack_page = false;
 
@@ -1101,7 +1101,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     int sxlen_bytes = sxlen / 8;
 
     if (first_stage == true) {
-        target_ulong mask, masked_msbs;
+        uint64_t mask, masked_msbs;
 
         if (sxlen > (va_bits - 1)) {
             mask = (1L << (sxlen - (va_bits - 1))) - 1;
@@ -1131,7 +1131,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     }
 
     int ptshift;
-    target_ulong pte;
+    uint64_t pte;
     hwaddr pte_addr;
     const hwaddr base_root = base;
     const bool be = mo_endian_env(env) == MO_BE;
@@ -1141,7 +1141,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     ptshift = (levels - 1) * ptidxbits;
     base = base_root;
     for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
-        target_ulong idx;
+        uint64_t idx;
         if (i == 0) {
             idx = (addr >> (PGSHIFT + ptshift)) &
                            ((1 << (ptidxbits + widened)) - 1);
@@ -1214,7 +1214,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         } else {
             if (pte & PTE_RESERVED(svrsw60t59b)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
-                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                              "addr: 0x%" HWADDR_PRIx
+                              " pte: 0x%016" PRIx64 "\n",
                               __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
@@ -1223,7 +1224,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                 /* Reserved without Svpbmt. */
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
                               "and Svpbmt extension is disabled: "
-                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                              "addr: 0x%" HWADDR_PRIx
+                              " pte: 0x%016" PRIx64 "\n",
                               __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
@@ -1242,7 +1244,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             if ((pte & PTE_PBMT) == PTE_PBMT) {
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits 62 and 61 are "
                         "reserved but are set in PTE: "
-                        "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                        "addr: 0x%" HWADDR_PRIx " pte: 0x%016" PRIx64 "\n",
                         __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
@@ -1251,12 +1253,13 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                 /* Reserved without Svnapot extension */
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: N bit set in PTE, "
                               "and Svnapot extension is disabled: "
-                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                              "addr: 0x%" HWADDR_PRIx
+                              " pte: 0x%016" PRIx64 "\n",
                               __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
 
-            ppn = (pte & (target_ulong)PTE_PPN_MASK) >> PTE_PPN_SHIFT;
+            ppn = (pte & PTE_PPN_MASK) >> PTE_PPN_SHIFT;
         }
 
         if (!(pte & PTE_V)) {
@@ -1271,7 +1274,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         if (pte & (PTE_D | PTE_A | PTE_U | PTE_ATTR)) {
             /* D, A, and U bits are reserved in non-leaf/inner PTEs */
             qemu_log_mask(LOG_GUEST_ERROR, "%s: D, A, or U bits set in non-leaf PTE: "
-                          "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                          "addr: 0x%" HWADDR_PRIx " pte: 0x%016" PRIx64 "\n",
                           __func__, pte_addr, pte);
             return TRANSLATE_FAIL;
         }
@@ -1286,7 +1289,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     if (ppn & ((1ULL << ptshift) - 1)) {
         /* Misaligned PPN */
         qemu_log_mask(LOG_GUEST_ERROR, "%s: PPN bits in PTE is misaligned: "
-                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x%016" PRIx64 "\n",
                       __func__, pte_addr, pte);
         return TRANSLATE_FAIL;
     }
@@ -1294,7 +1297,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         /* Reserved without Svpbmt. */
         qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
                       "and Svpbmt extension is disabled: "
-                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x%016" PRIx64 "\n",
                       __func__, pte_addr, pte);
         return TRANSLATE_FAIL;
     }
@@ -1311,12 +1314,12 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     if ((pte & PTE_PBMT) == PTE_PBMT) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits 62 and 61 are "
                       "reserved but are set in leaf PTE: "
-                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x%016" PRIx64 "\n",
                       __func__, pte_addr, pte);
         return TRANSLATE_FAIL;
     }
 
-    target_ulong rwx = pte & (PTE_R | PTE_W | PTE_X);
+    uint64_t rwx = pte & (PTE_R | PTE_W | PTE_X);
     /* Check for reserved combinations of RWX flags. */
     switch (rwx) {
     case PTE_W | PTE_X:
@@ -1403,7 +1406,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
     }
 
-    target_ulong updated_pte = pte;
+    uint64_t updated_pte = pte;
 
     /*
      * If ADUE is enabled, set accessed and dirty bits.
@@ -1471,7 +1474,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     }
 
     /* For superpage mappings, make a fake leaf PTE for the TLB's benefit. */
-    target_ulong vpn = addr >> PGSHIFT;
+    uint64_t vpn = addr >> PGSHIFT;
 
     if (riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
         napot_bits = ctzl(ppn) + 1;
@@ -1482,7 +1485,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 
     napot_mask = (1 << napot_bits) - 1;
     *physical = (((ppn & ~napot_mask) | (vpn & napot_mask) |
-                  (vpn & (((target_ulong)1 << ptshift) - 1))
+                  (vpn & ((1ULL << ptshift) - 1))
                  ) << PGSHIFT) | (addr & ~TARGET_PAGE_MASK);
 
     /*
@@ -1498,7 +1501,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     return TRANSLATE_SUCCESS;
 }
 
-static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
+static void raise_mmu_exception(CPURISCVState *env, vaddr address,
                                 MMUAccessType access_type,
                                 bool pmp_pma_violation,
                                 bool first_stage, bool two_stage,
@@ -1795,12 +1798,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     return true;
 }
 
-static target_ulong riscv_transformed_insn(CPURISCVState *env,
-                                           target_ulong insn,
-                                           target_ulong taddr)
+static uint64_t riscv_transformed_insn(CPURISCVState *env,
+                                           uint64_t insn,
+                                           uint64_t taddr)
 {
-    target_ulong xinsn = 0;
-    target_ulong access_rs1 = 0, access_imm = 0, access_size = 0;
+    uint64_t xinsn = 0;
+    uint64_t access_rs1 = 0, access_imm = 0, access_size = 0;
 
     /*
      * Only Quadrant 0 and Quadrant 2 of RVC instruction space need to
@@ -1956,7 +1959,7 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
          * Clear Bit1 of transformed instruction to indicate that
          * original insruction was a 16bit instruction
          */
-        xinsn &= ~((target_ulong)0x2);
+        xinsn &= ~((uint64_t)0x2);
     } else {
         /* Transform 32bit (or wider) instructions */
         switch (MASK_OP_MAJOR(insn)) {
@@ -2000,7 +2003,7 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
     return xinsn;
 }
 
-static target_ulong promote_load_fault(target_ulong orig_cause)
+static uint64_t promote_load_fault(uint64_t orig_cause)
 {
     switch (orig_cause) {
     case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
@@ -2020,7 +2023,7 @@ static target_ulong promote_load_fault(target_ulong orig_cause)
     return orig_cause;
 }
 
-static void riscv_do_nmi(CPURISCVState *env, target_ulong cause, bool virt)
+static void riscv_do_nmi(CPURISCVState *env, uint64_t cause, bool virt)
 {
     env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
     env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPV, virt);
@@ -2059,7 +2062,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
      * so we mask off the MSB and separate into trap type and cause.
      */
     bool async = !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
-    target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
+    uint64_t cause = cs->exception_index & RISCV_EXCP_INT_MASK;
     uint64_t deleg = async ? env->mideleg : env->medeleg;
     bool s_injected = env->mvip & (1ULL << cause) & env->mvien &&
         !(env->mip & (1ULL << cause));
@@ -2070,17 +2073,17 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     const bool prev_virt = env->virt_enabled;
     const privilege_mode_t prev_priv = env->priv;
     uint64_t last_pc = env->pc;
-    target_ulong tval = 0;
-    target_ulong tinst = 0;
-    target_ulong htval = 0;
-    target_ulong mtval2 = 0;
-    target_ulong src;
+    uint64_t tval = 0;
+    uint64_t tinst = 0;
+    uint64_t htval = 0;
+    uint64_t mtval2 = 0;
+    uint64_t src;
     int sxlen = 0;
     int mxlen = 16 << riscv_cpu_mxl(env);
     bool nnmi_excep = false;
 
     if (cpu->cfg.ext_smrnmi && env->rnmip && async) {
-        riscv_do_nmi(env, cause | ((target_ulong)1U << (mxlen - 1)),
+        riscv_do_nmi(env, cause | (1ULL << (mxlen - 1)),
                      env->virt_enabled);
         return;
     }
@@ -2173,8 +2176,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                      riscv_cpu_get_trap_name(cause, async));
 
     qemu_log_mask(CPU_LOG_INT,
-                  "%s: hart:%"PRIu64", async:%d, cause:"TARGET_FMT_lx", "
-                  "epc:0x%"PRIx64", tval:0x"TARGET_FMT_lx", desc=%s\n",
+                  "%s: hart:%"PRIu64", async:%d, cause:%016"PRIx64", "
+                  "epc:0x%016"PRIx64", tval:0x%016"PRIx64", desc=%s\n",
                   __func__, env->mhartid, async, cause, env->pc,
                   tval, riscv_cpu_get_trap_name(cause, async));
 
@@ -2253,7 +2256,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
         env->mstatus = s;
         sxlen = 16 << riscv_cpu_sxl(env);
-        env->scause = cause | ((target_ulong)async << (sxlen - 1));
+        env->scause = cause | ((uint64_t)async << (sxlen - 1));
         env->sepc = env->pc;
         env->stval = tval;
         env->htval = htval;
@@ -2325,7 +2328,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             s = set_field(s, MSTATUS_MDT, 1);
         }
         env->mstatus = s;
-        env->mcause = cause | ((target_ulong)async << (mxlen - 1));
+        env->mcause = cause | ((uint64_t)async << (mxlen - 1));
         if (smode_double_trap) {
             env->mtval2 = env->mcause;
             env->mcause = RISCV_EXCP_DOUBLE_TRAP;
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 8f95c8f400..cc50f3764c 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -4,7 +4,6 @@ endif
 
 riscv_ss.add(files(
   'bitmanip_helper.c',
- 'cpu_helper.c',
   'crypto_helper.c',
   'fpu_helper.c',
   'm128_helper.c',
@@ -24,11 +23,13 @@ riscv_system_ss.add(files(
 
 
 riscv_user_ss.add(files(
+  'cpu_helper.c',
   'csr.c',
 ))
 
 
 riscv_common_system_ss.add(files(
+  'cpu_helper.c',
   'csr.c',
   'mips_csr.c',
   'pmu.c',

-- 
2.52.0


