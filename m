Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38356C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rez4O-0003Uo-5F; Tue, 27 Feb 2024 10:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rez4K-0003Rv-44; Tue, 27 Feb 2024 10:08:32 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rez46-00082D-QG; Tue, 27 Feb 2024 10:08:26 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F01594E6139;
 Tue, 27 Feb 2024 16:08:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id y6SbW4pL698e; Tue, 27 Feb 2024 16:08:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0C3434E6137; Tue, 27 Feb 2024 16:08:10 +0100 (CET)
Message-Id: <afca51c18f2d4206aec7b546c5335e31103c5568.1709045654.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1709045654.git.balaton@eik.bme.hu>
References: <cover.1709045654.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 09/10] target/ppc: Clean up ifdefs in excp_helper.c, part 3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Date: Tue, 27 Feb 2024 16:08:10 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

Concatenate #if blocks that are ending then beginning on the next line
again.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 8160dabd6a..f5e1e641ac 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2503,10 +2503,8 @@ void helper_raise_exception(CPUPPCState *env, uint32_t exception)
 {
     raise_exception_err_ra(env, exception, 0, 0);
 }
-#endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
-#ifdef CONFIG_TCG
 void helper_store_msr(CPUPPCState *env, target_ulong val)
 {
     uint32_t excp = hreg_store_msr(env, val, 0);
@@ -2612,9 +2610,7 @@ void helper_hrfid(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
 }
-#endif /* TARGET_PPC64 */
 
-#ifdef TARGET_PPC64
 void helper_rfebb(CPUPPCState *env, target_ulong s)
 {
     target_ulong msr = env->msr;
@@ -2714,10 +2710,8 @@ void helper_rfmci(CPUPPCState *env)
     /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
     do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
 }
-#endif /* CONFIG_TCG */
-#endif /* !defined(CONFIG_USER_ONLY) */
+#endif /* !CONFIG_USER_ONLY */
 
-#ifdef CONFIG_TCG
 void helper_tw(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                uint32_t flags)
 {
@@ -2745,9 +2739,7 @@ void helper_td(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
     }
 }
 #endif /* TARGET_PPC64 */
-#endif /* CONFIG_TCG */
 
-#ifdef CONFIG_TCG
 static uint32_t helper_SIMON_LIKE_32_64(uint32_t x, uint64_t key, uint32_t lane)
 {
     const uint16_t c = 0xfffc;
@@ -2858,11 +2850,8 @@ HELPER_HASH(HASHST, env->spr[SPR_HASHKEYR], true, NPHIE)
 HELPER_HASH(HASHCHK, env->spr[SPR_HASHKEYR], false, NPHIE)
 HELPER_HASH(HASHSTP, env->spr[SPR_HASHPKEYR], true, PHIE)
 HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
-#endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
-#ifdef CONFIG_TCG
-
 /* Embedded.Processor Control */
 static int dbell2irq(target_ulong rb)
 {
@@ -3209,5 +3198,5 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     return false;
 }
 
-#endif /* CONFIG_TCG */
 #endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_TCG */
-- 
2.30.9


