Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127C1C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5Ct-000614-Vh; Thu, 23 Jan 2025 16:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Cb-0005TG-CV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:35 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5CV-0002ue-CY
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:28 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so674748f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669442; x=1738274242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQvGQxqb2s4eo/Vg/P6MC8jMAn7f9RTwB8e0Ug3F7Es=;
 b=PnEWl4Nn79P9Lh74eUdSRw5oi56PYciNQUiyicf6srMoMdcqGe96MMb/4wmKiWxmVz
 Za/hfkZiZnoRKWXD2VmT+qQTeZ5J/q5L1kIf8LjPxxFJdjzKuEcQIwCRtmR1ptXPZqJM
 6qva8C8TXDfIGECWkiqfmHTN2mMokK3PE2PflndPHFo5XJq6znkU70LjuL+yD7Vuk4Kd
 fpD7wKeV2vL2DhOBBnZ6Q/EdcyhQgcEz8ftdSJWOj1GfEW6U7B1VRVExB2QL53G6eKE2
 HHbwLcCeRHpIzO3fyscLSJD4jvNBjDJQOU0oPNEpYOW4SSK1q0AT/Ug6F6m2N6KW8HOj
 sf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669442; x=1738274242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQvGQxqb2s4eo/Vg/P6MC8jMAn7f9RTwB8e0Ug3F7Es=;
 b=bHko8z30D4T6vy81YvR8OtVfrtm5rpbF5yYF90k5AKckS3Jc4cM/k5gdHL/bx3Pq6H
 7+WFQv/vl7agRg0giiEIv1j7Kx2x0n6Tx8uAhJqB4I2BR+cih3aIjOFV1lotoU3MgUxq
 D5m8+/Jc+ZNRfX2vgPiW+8AxeAWMY+xGYuQWVpL6MxhD4gppOiFHCMdawsYd7Oth+ooC
 Zm/GeYJJgYyX7bexueImjfZJbZ4Z+aD1ch43tgT/HUxdV6RKkCHFEOyBhf3z2HQAy4Oe
 OR7HdwOCXUk7if/ewVMCpZufqb2scDjYAJ1XiW+ipFbiyKXmgxgJsBLRc1GKHTm3ArLS
 vN6g==
X-Gm-Message-State: AOJu0Yz2A/6mWIqyeF8VzrSyudekS2MdhW2EfS1vbzw480ot0xWjD2S5
 fwoh3wviRxzawxrPOFYD6sDv340DQDZ/Bje8KZYVU1ezZl2K6hxfj6gWPsCUmCvlym0zvseaeLG
 wn3k=
X-Gm-Gg: ASbGncv+1JT26h0NccsVhe1TWQ1SsLf8eccLmyKr8HYfycstIBu6iAEvlXn8gZP7r2w
 l2jYvvQs5RbsBdo72G5pgyQHvldGtMwDHSMsV05rDSEqX/yuX0f5Rtl0R+BwBDO7dSq5w9hI0wA
 XrW2mqh/Zqdz20tpf5/h28oZRp3jobuQdvQovLEIDVi8FHQRb4cMJNIirJpUYxJrJY1lgCiMrkI
 erQuOx5f1ND6DYxIetXQg8zlgkjr8T8eugxiQmeJQcQv9+TYwWPsqWQkStXPIVZP5GU5TpE0Ggi
 u4x0z4QfBDe0J3rFo+3Eo93T+X/hfJYeYMY2ccrYKomHjty1pBwGXgU=
X-Google-Smtp-Source: AGHT+IHaocaa9NUMmOILsYM3OGv8nYHqu/kWGnc+LMqdD7/sBQTRR23aZXZqfEqtnK2v8Y1DCL7Qmw==
X-Received: by 2002:a5d:588f:0:b0:38b:e109:1e0d with SMTP id
 ffacd0b85a97d-38bf57b9dffmr24983892f8f.49.1737669441428; 
 Thu, 23 Jan 2025 13:57:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188d5dsm822998f8f.55.2025.01.23.13.57.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:57:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 14/15] target/ppc: Restrict various system helpers to TCG
Date: Thu, 23 Jan 2025 22:56:08 +0100
Message-ID: <20250123215609.30432-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We don't need to expose ppc_ldl_code() anymore.
Similarly, make raise_exception() scope local.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h             |   1 -
 target/ppc/internal.h        |   2 -
 target/ppc/excp_helper.c     | 414 ----------------------------------
 target/ppc/tcg-excp_helper.c | 416 ++++++++++++++++++++++++++++++++++-
 4 files changed, 414 insertions(+), 419 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4ca27d6b389..ca5bbd263cb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2752,7 +2752,6 @@ static inline void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
 }
 #endif
 
-G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception);
 G_NORETURN void raise_exception_err(CPUPPCState *env, uint32_t exception,
                                     uint32_t error_code);
 G_NORETURN void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 779305f09d1..adb7a5c20d2 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -268,8 +268,6 @@ static inline void pte_invalidate(target_ulong *pte0)
 #define PTE_PTEM_MASK 0x7FFFFFBF
 #define PTE_CHECK_MASK (TARGET_PAGE_MASK | 0x7B)
 
-uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr);
-
 #ifdef CONFIG_USER_ONLY
 void ppc_cpu_record_sigsegv(CPUState *cs, vaddr addr,
                             MMUAccessType access_type,
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index f0e734e1412..2d4d47ee384 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2426,417 +2426,3 @@ bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 
 #endif /* !CONFIG_USER_ONLY */
-
-#ifdef CONFIG_TCG
-
-#ifndef CONFIG_USER_ONLY
-void helper_store_msr(CPUPPCState *env, target_ulong val)
-{
-    uint32_t excp = hreg_store_msr(env, val, 0);
-
-    if (excp != 0) {
-        cpu_interrupt_exittb(env_cpu(env));
-        raise_exception(env, excp);
-    }
-}
-
-void helper_ppc_maybe_interrupt(CPUPPCState *env)
-{
-    ppc_maybe_interrupt(env);
-}
-
-#ifdef TARGET_PPC64
-void helper_scv(CPUPPCState *env, uint32_t lev)
-{
-    if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
-        raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
-    } else {
-        raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
-    }
-}
-
-void helper_pminsn(CPUPPCState *env, uint32_t insn)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->halted = 1;
-
-    /* Condition for waking up at 0x100 */
-    env->resume_as_sreset = (insn != PPC_PM_STOP) ||
-        (env->spr[SPR_PSSCR] & PSSCR_EC);
-
-    /* HDECR is not to wake from PM state, it may have already fired */
-    if (env->resume_as_sreset) {
-        PowerPCCPU *cpu = env_archcpu(env);
-        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
-    }
-
-    ppc_maybe_interrupt(env);
-}
-#endif /* TARGET_PPC64 */
-
-static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
-{
-    /* MSR:POW cannot be set by any form of rfi */
-    msr &= ~(1ULL << MSR_POW);
-
-    /* MSR:TGPR cannot be set by any form of rfi */
-    if (env->flags & POWERPC_FLAG_TGPR) {
-        msr &= ~(1ULL << MSR_TGPR);
-    }
-
-#ifdef TARGET_PPC64
-    /* Switching to 32-bit ? Crop the nip */
-    if (!msr_is_64bit(env, msr)) {
-        nip = (uint32_t)nip;
-    }
-#else
-    nip = (uint32_t)nip;
-#endif
-    /* XXX: beware: this is false if VLE is supported */
-    env->nip = nip & ~((target_ulong)0x00000003);
-    hreg_store_msr(env, msr, 1);
-    trace_ppc_excp_rfi(env->nip, env->msr);
-    /*
-     * No need to raise an exception here, as rfi is always the last
-     * insn of a TB
-     */
-    cpu_interrupt_exittb(env_cpu(env));
-    /* Reset the reservation */
-    env->reserve_addr = -1;
-
-    /* Context synchronizing: check if TCG TLB needs flush */
-    check_tlb_flush(env, false);
-}
-
-void helper_rfi(CPUPPCState *env)
-{
-    do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1] & 0xfffffffful);
-}
-
-#ifdef TARGET_PPC64
-void helper_rfid(CPUPPCState *env)
-{
-    /*
-     * The architecture defines a number of rules for which bits can
-     * change but in practice, we handle this in hreg_store_msr()
-     * which will be called by do_rfi(), so there is no need to filter
-     * here
-     */
-    do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
-}
-
-void helper_rfscv(CPUPPCState *env)
-{
-    do_rfi(env, env->lr, env->ctr);
-}
-
-void helper_hrfid(CPUPPCState *env)
-{
-    do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
-}
-
-void helper_rfebb(CPUPPCState *env, target_ulong s)
-{
-    target_ulong msr = env->msr;
-
-    /*
-     * Handling of BESCR bits 32:33 according to PowerISA v3.1:
-     *
-     * "If BESCR 32:33 != 0b00 the instruction is treated as if
-     *  the instruction form were invalid."
-     */
-    if (env->spr[SPR_BESCR] & BESCR_INVALID) {
-        raise_exception_err(env, POWERPC_EXCP_PROGRAM,
-                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
-    }
-
-    env->nip = env->spr[SPR_EBBRR];
-
-    /* Switching to 32-bit ? Crop the nip */
-    if (!msr_is_64bit(env, msr)) {
-        env->nip = (uint32_t)env->spr[SPR_EBBRR];
-    }
-
-    if (s) {
-        env->spr[SPR_BESCR] |= BESCR_GE;
-    } else {
-        env->spr[SPR_BESCR] &= ~BESCR_GE;
-    }
-}
-
-/*
- * Triggers or queues an 'ebb_excp' EBB exception. All checks
- * but FSCR, HFSCR and msr_pr must be done beforehand.
- *
- * PowerISA v3.1 isn't clear about whether an EBB should be
- * postponed or cancelled if the EBB facility is unavailable.
- * Our assumption here is that the EBB is cancelled if both
- * FSCR and HFSCR EBB facilities aren't available.
- */
-static void do_ebb(CPUPPCState *env, int ebb_excp)
-{
-    PowerPCCPU *cpu = env_archcpu(env);
-
-    /*
-     * FSCR_EBB and FSCR_IC_EBB are the same bits used with
-     * HFSCR.
-     */
-    helper_fscr_facility_check(env, FSCR_EBB, 0, FSCR_IC_EBB);
-    helper_hfscr_facility_check(env, FSCR_EBB, "EBB", FSCR_IC_EBB);
-
-    if (ebb_excp == POWERPC_EXCP_PERFM_EBB) {
-        env->spr[SPR_BESCR] |= BESCR_PMEO;
-    } else if (ebb_excp == POWERPC_EXCP_EXTERNAL_EBB) {
-        env->spr[SPR_BESCR] |= BESCR_EEO;
-    }
-
-    if (FIELD_EX64(env->msr, MSR, PR)) {
-        powerpc_excp(cpu, ebb_excp);
-    } else {
-        ppc_set_irq(cpu, PPC_INTERRUPT_EBB, 1);
-    }
-}
-
-void raise_ebb_perfm_exception(CPUPPCState *env)
-{
-    bool perfm_ebb_enabled = env->spr[SPR_POWER_MMCR0] & MMCR0_EBE &&
-                             env->spr[SPR_BESCR] & BESCR_PME &&
-                             env->spr[SPR_BESCR] & BESCR_GE;
-
-    if (!perfm_ebb_enabled) {
-        return;
-    }
-
-    do_ebb(env, POWERPC_EXCP_PERFM_EBB);
-}
-#endif /* TARGET_PPC64 */
-
-/*****************************************************************************/
-/* Embedded PowerPC specific helpers */
-void helper_40x_rfci(CPUPPCState *env)
-{
-    do_rfi(env, env->spr[SPR_40x_SRR2], env->spr[SPR_40x_SRR3]);
-}
-
-void helper_rfci(CPUPPCState *env)
-{
-    do_rfi(env, env->spr[SPR_BOOKE_CSRR0], env->spr[SPR_BOOKE_CSRR1]);
-}
-
-void helper_rfdi(CPUPPCState *env)
-{
-    /* FIXME: choose CSRR1 or DSRR1 based on cpu type */
-    do_rfi(env, env->spr[SPR_BOOKE_DSRR0], env->spr[SPR_BOOKE_DSRR1]);
-}
-
-void helper_rfmci(CPUPPCState *env)
-{
-    /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
-    do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
-}
-
-/* Embedded.Processor Control */
-static int dbell2irq(target_ulong rb)
-{
-    int msg = rb & DBELL_TYPE_MASK;
-    int irq = -1;
-
-    switch (msg) {
-    case DBELL_TYPE_DBELL:
-        irq = PPC_INTERRUPT_DOORBELL;
-        break;
-    case DBELL_TYPE_DBELL_CRIT:
-        irq = PPC_INTERRUPT_CDOORBELL;
-        break;
-    case DBELL_TYPE_G_DBELL:
-    case DBELL_TYPE_G_DBELL_CRIT:
-    case DBELL_TYPE_G_DBELL_MC:
-        /* XXX implement */
-    default:
-        break;
-    }
-
-    return irq;
-}
-
-void helper_msgclr(CPUPPCState *env, target_ulong rb)
-{
-    int irq = dbell2irq(rb);
-
-    if (irq < 0) {
-        return;
-    }
-
-    ppc_set_irq(env_archcpu(env), irq, 0);
-}
-
-void helper_msgsnd(target_ulong rb)
-{
-    int irq = dbell2irq(rb);
-    int pir = rb & DBELL_PIRTAG_MASK;
-    CPUState *cs;
-
-    if (irq < 0) {
-        return;
-    }
-
-    bql_lock();
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-        CPUPPCState *cenv = &cpu->env;
-
-        if ((rb & DBELL_BRDCAST_MASK) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
-            ppc_set_irq(cpu, irq, 1);
-        }
-    }
-    bql_unlock();
-}
-
-/* Server Processor Control */
-
-static bool dbell_type_server(target_ulong rb)
-{
-    /*
-     * A Directed Hypervisor Doorbell message is sent only if the
-     * message type is 5. All other types are reserved and the
-     * instruction is a no-op
-     */
-    return (rb & DBELL_TYPE_MASK) == DBELL_TYPE_DBELL_SERVER;
-}
-
-static inline bool dbell_bcast_core(target_ulong rb)
-{
-    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_CORE;
-}
-
-static inline bool dbell_bcast_subproc(target_ulong rb)
-{
-    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
-}
-
-/*
- * Send an interrupt to a thread in the same core as env).
- */
-static void msgsnd_core_tir(CPUPPCState *env, uint32_t target_tir, int irq)
-{
-    PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
-
-    if (ppc_cpu_lpar_single_threaded(cs)) {
-        if (target_tir == 0) {
-            ppc_set_irq(cpu, irq, 1);
-        }
-    } else {
-        CPUState *ccs;
-
-        /* Does iothread need to be locked for walking CPU list? */
-        bql_lock();
-        THREAD_SIBLING_FOREACH(cs, ccs) {
-            PowerPCCPU *ccpu = POWERPC_CPU(ccs);
-            if (target_tir == ppc_cpu_tir(ccpu)) {
-                ppc_set_irq(ccpu, irq, 1);
-                break;
-            }
-        }
-        bql_unlock();
-    }
-}
-
-void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
-{
-    if (!dbell_type_server(rb)) {
-        return;
-    }
-
-    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
-}
-
-void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
-{
-    int pir = rb & DBELL_PROCIDTAG_MASK;
-    bool brdcast = false;
-    CPUState *cs, *ccs;
-    PowerPCCPU *cpu;
-
-    if (!dbell_type_server(rb)) {
-        return;
-    }
-
-    /* POWER8 msgsnd is like msgsndp (targets a thread within core) */
-    if (!(env->insns_flags2 & PPC2_ISA300)) {
-        msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_HDOORBELL);
-        return;
-    }
-
-    /* POWER9 and later msgsnd is a global (targets any thread) */
-    cpu = ppc_get_vcpu_by_pir(pir);
-    if (!cpu) {
-        return;
-    }
-    cs = CPU(cpu);
-
-    if (dbell_bcast_core(rb) || (dbell_bcast_subproc(rb) &&
-                                 (env->flags & POWERPC_FLAG_SMT_1LPAR))) {
-        brdcast = true;
-    }
-
-    if (ppc_cpu_core_single_threaded(cs) || !brdcast) {
-        ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
-        return;
-    }
-
-    /*
-     * Why is bql needed for walking CPU list? Answer seems to be because ppc
-     * irq handling needs it, but ppc_set_irq takes the lock itself if needed,
-     * so could this be removed?
-     */
-    bql_lock();
-    THREAD_SIBLING_FOREACH(cs, ccs) {
-        ppc_set_irq(POWERPC_CPU(ccs), PPC_INTERRUPT_HDOORBELL, 1);
-    }
-    bql_unlock();
-}
-
-#ifdef TARGET_PPC64
-void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
-{
-    helper_hfscr_facility_check(env, HFSCR_MSGP, "msgclrp", HFSCR_IC_MSGP);
-
-    if (!dbell_type_server(rb)) {
-        return;
-    }
-
-    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_DOORBELL, 0);
-}
-
-/*
- * sends a message to another thread  on the same
- * multi-threaded processor
- */
-void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
-{
-    helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
-
-    if (!dbell_type_server(rb)) {
-        return;
-    }
-
-    msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_DOORBELL);
-}
-#endif /* TARGET_PPC64 */
-
-/* Single-step tracing */
-void helper_book3s_trace(CPUPPCState *env, target_ulong prev_ip)
-{
-    uint32_t error_code = 0;
-    if (env->insns_flags2 & PPC2_ISA207S) {
-        /* Load/store reporting, SRR1[35, 36] and SDAR, are not implemented. */
-        env->spr[SPR_POWER_SIAR] = prev_ip;
-        error_code = PPC_BIT(33);
-    }
-    raise_exception_err(env, POWERPC_EXCP_TRACE, error_code);
-}
-
-#endif /* !CONFIG_USER_ONLY */
-#endif /* CONFIG_TCG */
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 124a81fd699..072a7fd0947 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu/log.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
@@ -61,7 +62,7 @@ void raise_exception_err(CPUPPCState *env, uint32_t exception,
     raise_exception_err_ra(env, exception, error_code, 0);
 }
 
-void raise_exception(CPUPPCState *env, uint32_t exception)
+static G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception)
 {
     raise_exception_err_ra(env, exception, 0, 0);
 }
@@ -209,6 +210,8 @@ HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
 
 #ifndef CONFIG_USER_ONLY
 
+static uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr);
+
 void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                  MMUAccessType access_type,
                                  int mmu_idx, uintptr_t retaddr)
@@ -415,7 +418,7 @@ static inline bool insn_need_byteswap(CPUArchState *env)
     return !!(env->msr & ((target_ulong)1 << MSR_LE));
 }
 
-uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
+static uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 {
     uint32_t insn = cpu_ldl_code(env, addr);
 
@@ -497,4 +500,413 @@ void ppc_tcg_hv_emu(CPUPPCState *env, target_ulong *new_msr,
     *new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
 }
 
+void helper_store_msr(CPUPPCState *env, target_ulong val)
+{
+    uint32_t excp = hreg_store_msr(env, val, 0);
+
+    if (excp != 0) {
+        cpu_interrupt_exittb(env_cpu(env));
+        raise_exception(env, excp);
+    }
+}
+
+void helper_ppc_maybe_interrupt(CPUPPCState *env)
+{
+    ppc_maybe_interrupt(env);
+}
+
+#ifdef TARGET_PPC64
+void helper_scv(CPUPPCState *env, uint32_t lev)
+{
+    if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
+        raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
+    } else {
+        raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
+    }
+}
+
+void helper_pminsn(CPUPPCState *env, uint32_t insn)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->halted = 1;
+
+    /* Condition for waking up at 0x100 */
+    env->resume_as_sreset = (insn != PPC_PM_STOP) ||
+        (env->spr[SPR_PSSCR] & PSSCR_EC);
+
+    /* HDECR is not to wake from PM state, it may have already fired */
+    if (env->resume_as_sreset) {
+        PowerPCCPU *cpu = env_archcpu(env);
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
+    }
+
+    ppc_maybe_interrupt(env);
+}
+
+#endif /* TARGET_PPC64 */
+
+static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
+{
+    /* MSR:POW cannot be set by any form of rfi */
+    msr &= ~(1ULL << MSR_POW);
+
+    /* MSR:TGPR cannot be set by any form of rfi */
+    if (env->flags & POWERPC_FLAG_TGPR) {
+        msr &= ~(1ULL << MSR_TGPR);
+    }
+
+#ifdef TARGET_PPC64
+    /* Switching to 32-bit ? Crop the nip */
+    if (!msr_is_64bit(env, msr)) {
+        nip = (uint32_t)nip;
+    }
+#else
+    nip = (uint32_t)nip;
+#endif
+    /* XXX: beware: this is false if VLE is supported */
+    env->nip = nip & ~((target_ulong)0x00000003);
+    hreg_store_msr(env, msr, 1);
+    trace_ppc_excp_rfi(env->nip, env->msr);
+    /*
+     * No need to raise an exception here, as rfi is always the last
+     * insn of a TB
+     */
+    cpu_interrupt_exittb(env_cpu(env));
+    /* Reset the reservation */
+    env->reserve_addr = -1;
+
+    /* Context synchronizing: check if TCG TLB needs flush */
+    check_tlb_flush(env, false);
+}
+
+void helper_rfi(CPUPPCState *env)
+{
+    do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1] & 0xfffffffful);
+}
+
+#ifdef TARGET_PPC64
+void helper_rfid(CPUPPCState *env)
+{
+    /*
+     * The architecture defines a number of rules for which bits can
+     * change but in practice, we handle this in hreg_store_msr()
+     * which will be called by do_rfi(), so there is no need to filter
+     * here
+     */
+    do_rfi(env, env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
+}
+
+void helper_rfscv(CPUPPCState *env)
+{
+    do_rfi(env, env->lr, env->ctr);
+}
+
+void helper_hrfid(CPUPPCState *env)
+{
+    do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
+}
+
+void helper_rfebb(CPUPPCState *env, target_ulong s)
+{
+    target_ulong msr = env->msr;
+
+    /*
+     * Handling of BESCR bits 32:33 according to PowerISA v3.1:
+     *
+     * "If BESCR 32:33 != 0b00 the instruction is treated as if
+     *  the instruction form were invalid."
+     */
+    if (env->spr[SPR_BESCR] & BESCR_INVALID) {
+        raise_exception_err(env, POWERPC_EXCP_PROGRAM,
+                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
+    }
+
+    env->nip = env->spr[SPR_EBBRR];
+
+    /* Switching to 32-bit ? Crop the nip */
+    if (!msr_is_64bit(env, msr)) {
+        env->nip = (uint32_t)env->spr[SPR_EBBRR];
+    }
+
+    if (s) {
+        env->spr[SPR_BESCR] |= BESCR_GE;
+    } else {
+        env->spr[SPR_BESCR] &= ~BESCR_GE;
+    }
+}
+
+/*
+ * Triggers or queues an 'ebb_excp' EBB exception. All checks
+ * but FSCR, HFSCR and msr_pr must be done beforehand.
+ *
+ * PowerISA v3.1 isn't clear about whether an EBB should be
+ * postponed or cancelled if the EBB facility is unavailable.
+ * Our assumption here is that the EBB is cancelled if both
+ * FSCR and HFSCR EBB facilities aren't available.
+ */
+static void do_ebb(CPUPPCState *env, int ebb_excp)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+
+    /*
+     * FSCR_EBB and FSCR_IC_EBB are the same bits used with
+     * HFSCR.
+     */
+    helper_fscr_facility_check(env, FSCR_EBB, 0, FSCR_IC_EBB);
+    helper_hfscr_facility_check(env, FSCR_EBB, "EBB", FSCR_IC_EBB);
+
+    if (ebb_excp == POWERPC_EXCP_PERFM_EBB) {
+        env->spr[SPR_BESCR] |= BESCR_PMEO;
+    } else if (ebb_excp == POWERPC_EXCP_EXTERNAL_EBB) {
+        env->spr[SPR_BESCR] |= BESCR_EEO;
+    }
+
+    if (FIELD_EX64(env->msr, MSR, PR)) {
+        powerpc_excp(cpu, ebb_excp);
+    } else {
+        ppc_set_irq(cpu, PPC_INTERRUPT_EBB, 1);
+    }
+}
+
+void raise_ebb_perfm_exception(CPUPPCState *env)
+{
+    bool perfm_ebb_enabled = env->spr[SPR_POWER_MMCR0] & MMCR0_EBE &&
+                             env->spr[SPR_BESCR] & BESCR_PME &&
+                             env->spr[SPR_BESCR] & BESCR_GE;
+
+    if (!perfm_ebb_enabled) {
+        return;
+    }
+
+    do_ebb(env, POWERPC_EXCP_PERFM_EBB);
+}
+#endif /* TARGET_PPC64 */
+
+/*****************************************************************************/
+/* Embedded PowerPC specific helpers */
+void helper_40x_rfci(CPUPPCState *env)
+{
+    do_rfi(env, env->spr[SPR_40x_SRR2], env->spr[SPR_40x_SRR3]);
+}
+
+void helper_rfci(CPUPPCState *env)
+{
+    do_rfi(env, env->spr[SPR_BOOKE_CSRR0], env->spr[SPR_BOOKE_CSRR1]);
+}
+
+void helper_rfdi(CPUPPCState *env)
+{
+    /* FIXME: choose CSRR1 or DSRR1 based on cpu type */
+    do_rfi(env, env->spr[SPR_BOOKE_DSRR0], env->spr[SPR_BOOKE_DSRR1]);
+}
+
+void helper_rfmci(CPUPPCState *env)
+{
+    /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
+    do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
+}
+
+/* Embedded.Processor Control */
+static int dbell2irq(target_ulong rb)
+{
+    int msg = rb & DBELL_TYPE_MASK;
+    int irq = -1;
+
+    switch (msg) {
+    case DBELL_TYPE_DBELL:
+        irq = PPC_INTERRUPT_DOORBELL;
+        break;
+    case DBELL_TYPE_DBELL_CRIT:
+        irq = PPC_INTERRUPT_CDOORBELL;
+        break;
+    case DBELL_TYPE_G_DBELL:
+    case DBELL_TYPE_G_DBELL_CRIT:
+    case DBELL_TYPE_G_DBELL_MC:
+        /* XXX implement */
+    default:
+        break;
+    }
+
+    return irq;
+}
+
+void helper_msgclr(CPUPPCState *env, target_ulong rb)
+{
+    int irq = dbell2irq(rb);
+
+    if (irq < 0) {
+        return;
+    }
+
+    ppc_set_irq(env_archcpu(env), irq, 0);
+}
+
+void helper_msgsnd(target_ulong rb)
+{
+    int irq = dbell2irq(rb);
+    int pir = rb & DBELL_PIRTAG_MASK;
+    CPUState *cs;
+
+    if (irq < 0) {
+        return;
+    }
+
+    bql_lock();
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+        CPUPPCState *cenv = &cpu->env;
+
+        if ((rb & DBELL_BRDCAST_MASK) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
+            ppc_set_irq(cpu, irq, 1);
+        }
+    }
+    bql_unlock();
+}
+
+/* Server Processor Control */
+
+static bool dbell_type_server(target_ulong rb)
+{
+    /*
+     * A Directed Hypervisor Doorbell message is sent only if the
+     * message type is 5. All other types are reserved and the
+     * instruction is a no-op
+     */
+    return (rb & DBELL_TYPE_MASK) == DBELL_TYPE_DBELL_SERVER;
+}
+
+static inline bool dbell_bcast_core(target_ulong rb)
+{
+    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_CORE;
+}
+
+static inline bool dbell_bcast_subproc(target_ulong rb)
+{
+    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
+}
+
+/*
+ * Send an interrupt to a thread in the same core as env).
+ */
+static void msgsnd_core_tir(CPUPPCState *env, uint32_t target_tir, int irq)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+
+    if (ppc_cpu_lpar_single_threaded(cs)) {
+        if (target_tir == 0) {
+            ppc_set_irq(cpu, irq, 1);
+        }
+    } else {
+        CPUState *ccs;
+
+        /* Does iothread need to be locked for walking CPU list? */
+        bql_lock();
+        THREAD_SIBLING_FOREACH(cs, ccs) {
+            PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+            if (target_tir == ppc_cpu_tir(ccpu)) {
+                ppc_set_irq(ccpu, irq, 1);
+                break;
+            }
+        }
+        bql_unlock();
+    }
+}
+
+void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
+{
+    if (!dbell_type_server(rb)) {
+        return;
+    }
+
+    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
+}
+
+void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
+{
+    int pir = rb & DBELL_PROCIDTAG_MASK;
+    bool brdcast = false;
+    CPUState *cs, *ccs;
+    PowerPCCPU *cpu;
+
+    if (!dbell_type_server(rb)) {
+        return;
+    }
+
+    /* POWER8 msgsnd is like msgsndp (targets a thread within core) */
+    if (!(env->insns_flags2 & PPC2_ISA300)) {
+        msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_HDOORBELL);
+        return;
+    }
+
+    /* POWER9 and later msgsnd is a global (targets any thread) */
+    cpu = ppc_get_vcpu_by_pir(pir);
+    if (!cpu) {
+        return;
+    }
+    cs = CPU(cpu);
+
+    if (dbell_bcast_core(rb) || (dbell_bcast_subproc(rb) &&
+                                 (env->flags & POWERPC_FLAG_SMT_1LPAR))) {
+        brdcast = true;
+    }
+
+    if (ppc_cpu_core_single_threaded(cs) || !brdcast) {
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
+        return;
+    }
+
+    /*
+     * Why is bql needed for walking CPU list? Answer seems to be because ppc
+     * irq handling needs it, but ppc_set_irq takes the lock itself if needed,
+     * so could this be removed?
+     */
+    bql_lock();
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        ppc_set_irq(POWERPC_CPU(ccs), PPC_INTERRUPT_HDOORBELL, 1);
+    }
+    bql_unlock();
+}
+
+#ifdef TARGET_PPC64
+void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
+{
+    helper_hfscr_facility_check(env, HFSCR_MSGP, "msgclrp", HFSCR_IC_MSGP);
+
+    if (!dbell_type_server(rb)) {
+        return;
+    }
+
+    ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_DOORBELL, 0);
+}
+
+/*
+ * sends a message to another thread  on the same
+ * multi-threaded processor
+ */
+void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
+{
+    helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
+
+    if (!dbell_type_server(rb)) {
+        return;
+    }
+
+    msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_DOORBELL);
+}
+#endif /* TARGET_PPC64 */
+
+/* Single-step tracing */
+void helper_book3s_trace(CPUPPCState *env, target_ulong prev_ip)
+{
+    uint32_t error_code = 0;
+    if (env->insns_flags2 & PPC2_ISA207S) {
+        /* Load/store reporting, SRR1[35, 36] and SDAR, are not implemented. */
+        env->spr[SPR_POWER_SIAR] = prev_ip;
+        error_code = PPC_BIT(33);
+    }
+    raise_exception_err(env, POWERPC_EXCP_TRACE, error_code);
+}
+
 #endif /* !CONFIG_USER_ONLY */
-- 
2.47.1


