Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3D2C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7LE-0005GP-9q; Thu, 22 Feb 2024 06:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rd7L4-0004wx-W1; Thu, 22 Feb 2024 06:34:07 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rd7L1-0006NB-R7; Thu, 22 Feb 2024 06:34:06 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 136104E6026;
 Thu, 22 Feb 2024 12:34:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 0xt9b-xl__9j; Thu, 22 Feb 2024 12:34:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 24F1B4E602B; Thu, 22 Feb 2024 12:34:00 +0100 (CET)
Message-Id: <583e05726248b8fb50ad23ca3af1d0b1902876b2.1708601065.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1708601065.git.balaton@eik.bme.hu>
References: <cover.1708601065.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 6/9] target/ppc: Clean up ifdefs in excp_helper.c, part 1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Date: Thu, 22 Feb 2024 12:34:00 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use #ifdef, #ifndef for brevity and add comments to #endif that are
more than a few lines apart for clarity.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 49 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 035a9fd968..d8eab4ff6c 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -35,7 +35,7 @@
 
 /*****************************************************************************/
 /* Exception processing */
-#if !defined(CONFIG_USER_ONLY)
+#ifndef CONFIG_USER_ONLY
 
 static const char *powerpc_excp_name(int excp)
 {
@@ -186,7 +186,7 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
              env->error_code);
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 static int powerpc_reset_wakeup(CPUPPCState *env, int excp, target_ulong *msr)
 {
     /* We no longer are in a PM state */
@@ -380,7 +380,7 @@ static void ppc_excp_apply_ail(PowerPCCPU *cpu, int excp, target_ulong msr,
         }
     }
 }
-#endif
+#endif /* TARGET_PPC64 */
 
 static void powerpc_reset_excp_state(PowerPCCPU *cpu)
 {
@@ -1123,7 +1123,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
     if (env->spr[SPR_BOOKE_EPCR] & EPCR_ICM) {
         /* Cat.64-bit: EPCR.ICM is copied to MSR.CM */
         new_msr |= (target_ulong)1 << MSR_CM;
@@ -1537,7 +1537,7 @@ static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
     g_assert_not_reached();
 }
-#endif
+#endif /* TARGET_PPC64 */
 
 static void powerpc_excp(PowerPCCPU *cpu, int excp)
 {
@@ -1588,7 +1588,7 @@ void ppc_cpu_do_interrupt(CPUState *cs)
     powerpc_excp(cpu, cs->exception_index);
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 #define P7_UNUSED_INTERRUPTS \
     (PPC_INTERRUPT_RESET | PPC_INTERRUPT_HVIRT | PPC_INTERRUPT_CEXT |       \
      PPC_INTERRUPT_WDT | PPC_INTERRUPT_CDOORBELL | PPC_INTERRUPT_FIT |      \
@@ -1919,7 +1919,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
 
     return 0;
 }
-#endif
+#endif /* TARGET_PPC64 */
 
 static int ppc_next_unmasked_interrupt_generic(CPUPPCState *env)
 {
@@ -2036,7 +2036,7 @@ static int ppc_next_unmasked_interrupt_generic(CPUPPCState *env)
 static int ppc_next_unmasked_interrupt(CPUPPCState *env)
 {
     switch (env->excp_model) {
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
     case POWERPC_EXCP_POWER7:
         return p7_next_unmasked_interrupt(env);
     case POWERPC_EXCP_POWER8:
@@ -2075,7 +2075,7 @@ void ppc_maybe_interrupt(CPUPPCState *env)
     }
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
@@ -2277,7 +2277,7 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
                   interrupt);
     }
 }
-#endif
+#endif /* TARGET_PPC64 */
 
 static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
 {
@@ -2386,7 +2386,7 @@ static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
 static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
     switch (env->excp_model) {
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
     case POWERPC_EXCP_POWER7:
         p7_deliver_interrupt(env, interrupt);
         break;
@@ -2496,9 +2496,9 @@ void helper_raise_exception(CPUPPCState *env, uint32_t exception)
 {
     raise_exception_err_ra(env, exception, 0, 0);
 }
-#endif
+#endif /* CONFIG_TCG */
 
-#if !defined(CONFIG_USER_ONLY)
+#ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
 void helper_store_msr(CPUPPCState *env, target_ulong val)
 {
@@ -2515,7 +2515,7 @@ void helper_ppc_maybe_interrupt(CPUPPCState *env)
     ppc_maybe_interrupt(env);
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 void helper_scv(CPUPPCState *env, uint32_t lev)
 {
     if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
@@ -2544,7 +2544,7 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
 
     ppc_maybe_interrupt(env);
 }
-#endif /* defined(TARGET_PPC64) */
+#endif /* TARGET_PPC64 */
 
 static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
 {
@@ -2555,7 +2555,7 @@ static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
     if (env->flags & POWERPC_FLAG_TGPR)
         msr &= ~(1ULL << MSR_TGPR);
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
     /* Switching to 32-bit ? Crop the nip */
     if (!msr_is_64bit(env, msr)) {
         nip = (uint32_t)nip;
@@ -2584,7 +2584,7 @@ void helper_rfi(CPUPPCState *env)
     do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1] & 0xfffffffful);
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 void helper_rfid(CPUPPCState *env)
 {
     /*
@@ -2605,7 +2605,7 @@ void helper_hrfid(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
 }
-#endif
+#endif /* TARGET_PPC64 */
 
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 void helper_rfebb(CPUPPCState *env, target_ulong s)
@@ -2682,7 +2682,7 @@ void raise_ebb_perfm_exception(CPUPPCState *env)
 
     do_ebb(env, POWERPC_EXCP_PERFM_EBB);
 }
-#endif
+#endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
 
 /*****************************************************************************/
 /* Embedded PowerPC specific helpers */
@@ -2724,7 +2724,7 @@ void helper_tw(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
     }
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 void helper_td(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                uint32_t flags)
 {
@@ -2737,8 +2737,8 @@ void helper_td(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                                POWERPC_EXCP_TRAP, GETPC());
     }
 }
-#endif
-#endif
+#endif /* TARGET_PPC64 */
+#endif /* CONFIG_TCG */
 
 #ifdef CONFIG_TCG
 static uint32_t helper_SIMON_LIKE_32_64(uint32_t x, uint64_t key, uint32_t lane)
@@ -2853,8 +2853,7 @@ HELPER_HASH(HASHSTP, env->spr[SPR_HASHPKEYR], true, PHIE)
 HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
 #endif /* CONFIG_TCG */
 
-#if !defined(CONFIG_USER_ONLY)
-
+#ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
 
 /* Embedded.Processor Control */
@@ -2963,7 +2962,7 @@ void helper_book3s_msgsnd(target_ulong rb)
     book3s_msgsnd_common(pir, PPC_INTERRUPT_HDOORBELL);
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
 {
     helper_hfscr_facility_check(env, HFSCR_MSGP, "msgclrp", HFSCR_IC_MSGP);
-- 
2.30.9


