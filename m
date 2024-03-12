Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22B5C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5WR-0000tG-Sf; Tue, 12 Mar 2024 13:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UI-0005z5-La; Tue, 12 Mar 2024 13:00:35 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UE-0008Jo-9X; Tue, 12 Mar 2024 13:00:25 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so3772515b3a.2; 
 Tue, 12 Mar 2024 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262818; x=1710867618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+eCNzO1amSLOFV/LcUWxHyVkIEDf7pPlXvdB+h7ATA=;
 b=VXSVk4fd9UOGi3/+uVG0W+ZMvMfoj9o8mv3Z15sWXcTi8Kjqoiwa0DKQiNgI0yuwv7
 6T/VuV3crMo6pXyMu6RR0tA5rUO257uXsJJIh/PyOOexylp9rKPbNFEjVOVmFq+Vp1sD
 kIFLtJbvAvCp+c9N342uxLzDTkgCGHsKwLBCucZC6WK1oKIirAEkFVFGn6jA6x2gF+Ld
 xRmtdmC07R0k2NH5wctykEe+ucAqt3PNcNQgxUNEBowTEQRQbL7EEv2TzLkNETY2zlcP
 R/OliUGSNP3jygWuMyLjp0HRJEAkxOwhVmVMDvAEmEiVi3O6ixLPPI1/6xb4z9+PNlg6
 3g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262818; x=1710867618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+eCNzO1amSLOFV/LcUWxHyVkIEDf7pPlXvdB+h7ATA=;
 b=Z1dIODyNaUD9E+YzW+IYUPpmvxsOLh+dtuNEvFmbCfzqF3BnFLQL9aUbR9OG633Dhw
 0DNcOXi0kcrCbku76afGLpahc2pmWYFgUFCUgm3daGhiwgTHWCwduLl+pbsRPKfnlyZq
 rQakShc8txRagbeG7zrG4Fo4fdkOS6cpPqQZsfeNxBKoM85tNgbVWlEp4VBeQ1rg/sYY
 ySe1VNrCOm5jKG8wz+brnlH3hkBmnzsMzF4BIBAgxF0qC5Bxm3jHxIYGoWQjYMx6BPEs
 PBa56HdfTLlgf43yq297CvTjd0l8wgNVohcoeJ0kwYmNuRKfMMwWyJ1HFyLU0F3jmpiw
 +epg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5jl/JuZG/BZ7JBau23XXOab04oiOsWYAuItpNr+7TlYQj6BS7PtIByMCbGmRzPEpg2z9Bg0pk1/E0LGFf0Nlo7yzh
X-Gm-Message-State: AOJu0YwRJWI5iwWemXE4dVIDMoaqfecXYZFfquRGmpvm3lNyraVasTYB
 s/yfPXN3tBVFoIULRBpt9Zx6OlIpqg5fhF8OGsSx8VpLCBW+USVyQOKeZMcFl+U=
X-Google-Smtp-Source: AGHT+IHPAe3WTc+GxK8j8VsbTE6Jqp3/jnepXwMw+D77EI5v8fTRdzGRb0+tAF4alzy2Nbggyu8Oow==
X-Received: by 2002:a05:6a00:21d0:b0:6e6:9dfb:7eff with SMTP id
 t16-20020a056a0021d000b006e69dfb7effmr33788pfj.20.1710262818478; 
 Tue, 12 Mar 2024 10:00:18 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 21/38] target/ppc: Clean up ifdefs in excp_helper.c, part 1
Date: Wed, 13 Mar 2024 02:58:32 +1000
Message-ID: <20240312165851.2240242-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Use #ifdef, #ifndef for brevity and add comments to #endif that are
more than a few lines apart for clarity.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 49 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index c15cd904d1..32337c67f4 100644
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
@@ -1163,7 +1163,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
     if (env->spr[SPR_BOOKE_EPCR] & EPCR_ICM) {
         /* Cat.64-bit: EPCR.ICM is copied to MSR.CM */
         new_msr |= (target_ulong)1 << MSR_CM;
@@ -1594,7 +1594,7 @@ static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
     g_assert_not_reached();
 }
-#endif
+#endif /* TARGET_PPC64 */
 
 static void powerpc_excp(PowerPCCPU *cpu, int excp)
 {
@@ -1645,7 +1645,7 @@ void ppc_cpu_do_interrupt(CPUState *cs)
     powerpc_excp(cpu, cs->exception_index);
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 #define P7_UNUSED_INTERRUPTS \
     (PPC_INTERRUPT_RESET | PPC_INTERRUPT_HVIRT | PPC_INTERRUPT_CEXT |       \
      PPC_INTERRUPT_WDT | PPC_INTERRUPT_CDOORBELL | PPC_INTERRUPT_FIT |      \
@@ -1976,7 +1976,7 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env)
 
     return 0;
 }
-#endif
+#endif /* TARGET_PPC64 */
 
 static int ppc_next_unmasked_interrupt_generic(CPUPPCState *env)
 {
@@ -2093,7 +2093,7 @@ static int ppc_next_unmasked_interrupt_generic(CPUPPCState *env)
 static int ppc_next_unmasked_interrupt(CPUPPCState *env)
 {
     switch (env->excp_model) {
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
     case POWERPC_EXCP_POWER7:
         return p7_next_unmasked_interrupt(env);
     case POWERPC_EXCP_POWER8:
@@ -2132,7 +2132,7 @@ void ppc_maybe_interrupt(CPUPPCState *env)
     }
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
@@ -2334,7 +2334,7 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
                   interrupt);
     }
 }
-#endif
+#endif /* TARGET_PPC64 */
 
 static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
 {
@@ -2443,7 +2443,7 @@ static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
 static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
     switch (env->excp_model) {
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
     case POWERPC_EXCP_POWER7:
         p7_deliver_interrupt(env, interrupt);
         break;
@@ -2553,9 +2553,9 @@ void helper_raise_exception(CPUPPCState *env, uint32_t exception)
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
@@ -2572,7 +2572,7 @@ void helper_ppc_maybe_interrupt(CPUPPCState *env)
     ppc_maybe_interrupt(env);
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 void helper_scv(CPUPPCState *env, uint32_t lev)
 {
     if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
@@ -2600,7 +2600,7 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
 
     ppc_maybe_interrupt(env);
 }
-#endif /* defined(TARGET_PPC64) */
+#endif /* TARGET_PPC64 */
 
 static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
 {
@@ -2611,7 +2611,7 @@ static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
     if (env->flags & POWERPC_FLAG_TGPR)
         msr &= ~(1ULL << MSR_TGPR);
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
     /* Switching to 32-bit ? Crop the nip */
     if (!msr_is_64bit(env, msr)) {
         nip = (uint32_t)nip;
@@ -2640,7 +2640,7 @@ void helper_rfi(CPUPPCState *env)
     do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1] & 0xfffffffful);
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 void helper_rfid(CPUPPCState *env)
 {
     /*
@@ -2661,7 +2661,7 @@ void helper_hrfid(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
 }
-#endif
+#endif /* TARGET_PPC64 */
 
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
 void helper_rfebb(CPUPPCState *env, target_ulong s)
@@ -2738,7 +2738,7 @@ void raise_ebb_perfm_exception(CPUPPCState *env)
 
     do_ebb(env, POWERPC_EXCP_PERFM_EBB);
 }
-#endif
+#endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
 
 /*****************************************************************************/
 /* Embedded PowerPC specific helpers */
@@ -2780,7 +2780,7 @@ void helper_tw(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
     }
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 void helper_td(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                uint32_t flags)
 {
@@ -2793,8 +2793,8 @@ void helper_td(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                                POWERPC_EXCP_TRAP, GETPC());
     }
 }
-#endif
-#endif
+#endif /* TARGET_PPC64 */
+#endif /* CONFIG_TCG */
 
 #ifdef CONFIG_TCG
 static uint32_t helper_SIMON_LIKE_32_64(uint32_t x, uint64_t key, uint32_t lane)
@@ -2909,8 +2909,7 @@ HELPER_HASH(HASHSTP, env->spr[SPR_HASHPKEYR], true, PHIE)
 HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
 #endif /* CONFIG_TCG */
 
-#if !defined(CONFIG_USER_ONLY)
-
+#ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
 
 /* Embedded.Processor Control */
@@ -3019,7 +3018,7 @@ void helper_book3s_msgsnd(target_ulong rb)
     book3s_msgsnd_common(pir, PPC_INTERRUPT_HDOORBELL);
 }
 
-#if defined(TARGET_PPC64)
+#ifdef TARGET_PPC64
 void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
 {
     helper_hfscr_facility_check(env, HFSCR_MSGP, "msgclrp", HFSCR_IC_MSGP);
-- 
2.42.0


