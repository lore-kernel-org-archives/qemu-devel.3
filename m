Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D68C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0H-0004jW-OB; Sat, 27 Jan 2024 23:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0G-0004j0-Da
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:44 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0C-0004Ii-Gi
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:44 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-290b1e19101so2168716a91.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416959; x=1707021759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fv+pc/a9zag0QS85JnFIDYR2iyAM3R7hb/CB3POH4c=;
 b=WoUSTUWFUqyt3AppJFDzmnOGUy2EMgcn7BoNYIN7vIb0dAEhuGefSnZGSA44o32b9X
 l0wIjopagk64YnwVG40SbLsmoIuNeT71vLdpleUJtrqvnxOYAJ9wYBEVGYRO/blU1wWW
 A/2U+ltPpGJ7e+qXv5dQz1ysVhG/GEF2l5f0MYVviuEVTo2UTCYrUneV8WM2XMvWoOze
 FacGRVuEKZuRNS6dTGQEhgYlDOuJpf41NIrxsoqb0iVyVJdQPElS/4CZM9ZAcw2GV/Eb
 bBBSW+SK6fOdv+q0D67vi45E000k5vq+eEwI2yCFHhx92pFeyovPgwM/9S7JdQCfVqvJ
 UfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416959; x=1707021759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fv+pc/a9zag0QS85JnFIDYR2iyAM3R7hb/CB3POH4c=;
 b=dRXVC6Zg/oJpSAhSeBjyDReMyo0hsOBZQ/I/NbeNrseCtycd3H3CDuRCem6x+XbSvN
 0UVrD2duDN5eDvTLPHZSbvo8Th4F80g2Nv2TeNrYYuoVx75ifpPtRoheZloKJnHVUZCy
 2Pap3zpajOPaoX+kIPbCz3jnlXfXEQtZ+s/R88Bso+EdRH/x7awTMEGELn4ogzZE/LYK
 jXLgWdaFvcsb/prebnOd1/1AKfnHf4zg+VXkSzqVEXfXFrFKgNrQ4V46xb2wlDpo2HB/
 nDWmM8zKNhrmzj4212sW8i2UF4Ymdt4chKAXOxzOkBkYnp/sK0pNRXP4o28a0ETjg+B7
 5nkA==
X-Gm-Message-State: AOJu0YwUf7ScWzQM5xy7rrzYYTVqQ6+OrckUMRKpuFopRMOTtPoEFVD5
 Gw0KQOeQE05kj1J27Uco1bGbZZut2jxs3uqUCx8VIFUXR+Fm59+hGs5wbabDQbbgieVbl2Bn14h
 RnVOETA==
X-Google-Smtp-Source: AGHT+IESYEeW59RezkKc+iGAA9IDIOm2uZrJlYov7bJahUW4y4r7EHwAfYV5sxdYZK3V1cHQPiZCPA==
X-Received: by 2002:a17:90a:5216:b0:28f:eede:244f with SMTP id
 v22-20020a17090a521600b0028feede244fmr2617710pjh.36.1706416958939; 
 Sat, 27 Jan 2024 20:42:38 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH 08/33] target: Uninline cpu_get_tb_cpu_state()
Date: Sun, 28 Jan 2024 14:41:48 +1000
Message-Id: <20240128044213.316480-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Anton Johansson <anjo@rev.ng>

Required to compile accel/tcg/translate-all.c once for softmmu targets.
The function gets quite big for some targets so uninlining makes sense.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-14-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h |  3 ++
 target/alpha/cpu.h        | 11 -------
 target/arm/cpu.h          |  3 --
 target/avr/cpu.h          | 18 -----------
 target/cris/cpu.h         | 10 ------
 target/hexagon/cpu.h      | 12 -------
 target/hppa/cpu.h         | 42 ------------------------
 target/i386/cpu.h         | 14 --------
 target/loongarch/cpu.h    | 12 -------
 target/m68k/cpu.h         | 16 ---------
 target/microblaze/cpu.h   |  8 -----
 target/mips/cpu.h         |  9 ------
 target/nios2/cpu.h        | 12 -------
 target/openrisc/cpu.h     | 10 ------
 target/ppc/cpu.h          | 13 --------
 target/riscv/cpu.h        |  3 --
 target/rx/cpu.h           |  9 ------
 target/s390x/cpu.h        | 24 --------------
 target/sh4/cpu.h          | 15 ---------
 target/sparc/cpu.h        | 33 -------------------
 target/tricore/cpu.h      | 12 -------
 target/xtensa/cpu.h       | 68 ---------------------------------------
 target/alpha/cpu.c        | 11 +++++++
 target/avr/cpu.c          | 18 +++++++++++
 target/cris/cpu.c         | 10 ++++++
 target/hexagon/cpu.c      | 12 +++++++
 target/hppa/cpu.c         | 42 ++++++++++++++++++++++++
 target/i386/cpu.c         | 14 ++++++++
 target/loongarch/cpu.c    | 12 +++++++
 target/m68k/cpu.c         | 16 +++++++++
 target/microblaze/cpu.c   |  7 ++++
 target/mips/cpu.c         |  9 ++++++
 target/nios2/cpu.c        | 12 +++++++
 target/openrisc/cpu.c     | 10 ++++++
 target/ppc/helper_regs.c  | 17 +++++-----
 target/rx/cpu.c           |  9 ++++++
 target/s390x/cpu.c        | 22 +++++++++++++
 target/sh4/cpu.c          | 15 +++++++++
 target/sparc/cpu.c        | 33 +++++++++++++++++++
 target/tricore/cpu.c      | 12 +++++++
 target/xtensa/cpu.c       | 68 +++++++++++++++++++++++++++++++++++++++
 41 files changed, 344 insertions(+), 362 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 4724135f30..1a8fad9222 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -44,6 +44,9 @@ unsigned int cpu_list_generation_id_get(void);
  */
 int cpu_mmu_index(CPUArchState *env, bool ifetch);
 
+void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags);
+
 void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index abf778735a..2b0173577c 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -458,17 +458,6 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      MemTxResult response, uintptr_t retaddr);
 #endif
 
-static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *pflags = env->flags & ENV_FLAG_TB_MASK;
-#ifdef CONFIG_USER_ONLY
-    *pflags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
-#endif
-}
-
 #ifdef CONFIG_USER_ONLY
 /* Copied from linux ieee_swcr_to_fpcr.  */
 static inline uint64_t alpha_ieee_swcr_to_fpcr(uint64_t swcr)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b0edf2e540..a4ec37c8ed 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3313,9 +3313,6 @@ static inline bool arm_cpu_bswap_data(CPUARMState *env)
 }
 #endif
 
-void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags);
-
 enum {
     QEMU_PSCI_CONDUIT_DISABLED = 0,
     QEMU_PSCI_CONDUIT_SMC = 1,
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index d185d20dcb..284041a87a 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -193,24 +193,6 @@ enum {
     TB_FLAGS_SKIP = 2,
 };
 
-static inline void cpu_get_tb_cpu_state(CPUAVRState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    uint32_t flags = 0;
-
-    *pc = env->pc_w * 2;
-    *cs_base = 0;
-
-    if (env->fullacc) {
-        flags |= TB_FLAGS_FULL_ACCESS;
-    }
-    if (env->skip) {
-        flags |= TB_FLAGS_SKIP;
-    }
-
-    *pflags = flags;
-}
-
 static inline int cpu_interrupts_enabled(CPUAVRState *env)
 {
     return env->sregI != 0;
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 3904e5448c..6df53f49c4 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -273,14 +273,4 @@ enum {
 
 #include "exec/cpu-all.h"
 
-static inline void cpu_get_tb_cpu_state(CPUCRISState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = env->dslot |
-            (env->pregs[PR_CCS] & (S_FLAG | P_FLAG | U_FLAG
-				     | X_FLAG | PFIX_FLAG));
-}
-
 #endif
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 3eef58fe8f..1d42c33827 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -134,18 +134,6 @@ struct ArchCPU {
 
 FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
 
-static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    uint32_t hex_flags = 0;
-    *pc = env->gpr[HEX_REG_PC];
-    *cs_base = 0;
-    if (*pc == env->gpr[HEX_REG_SA0]) {
-        hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
-    }
-    *flags = hex_flags;
-}
-
 typedef HexagonCPU ArchCPU;
 
 void hexagon_translate_init(void);
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7a181e8f33..b449ceea6b 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -314,48 +314,6 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
 
-static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    uint32_t flags = env->psw_n * PSW_N;
-
-    /* TB lookup assumes that PC contains the complete virtual address.
-       If we leave space+offset separate, we'll get ITLB misses to an
-       incomplete virtual address.  This also means that we must separate
-       out current cpu privilege from the low bits of IAOQ_F.  */
-#ifdef CONFIG_USER_ONLY
-    *pc = env->iaoq_f & -4;
-    *cs_base = env->iaoq_b & -4;
-    flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
-#else
-    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
-    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
-    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
-
-    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
-                            env->iaoq_f & -4);
-    *cs_base = env->iasq_f;
-
-    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
-       low 32-bits of CS_BASE.  This will succeed for all direct branches,
-       which is the primary case we care about -- using goto_tb within a page.
-       Failure is indicated by a zero difference.  */
-    if (env->iasq_f == env->iasq_b) {
-        target_long diff = env->iaoq_b - env->iaoq_f;
-        if (diff == (int32_t)diff) {
-            *cs_base |= (uint32_t)diff;
-        }
-    }
-    if ((env->sr[4] == env->sr[5])
-        & (env->sr[4] == env->sr[6])
-        & (env->sr[4] == env->sr[7])) {
-        flags |= TB_FLAG_SR_SAME;
-    }
-#endif
-
-    *pflags = flags;
-}
-
 target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong);
 void cpu_hppa_loaded_fr0(CPUHPPAState *env);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6a5b180ccb..4352d0d163 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2315,20 +2315,6 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
 #include "hw/i386/apic.h"
 #endif
 
-static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *flags = env->hflags |
-        (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
-    if (env->hflags & HF_CS64_MASK) {
-        *cs_base = 0;
-        *pc = env->eip;
-    } else {
-        *cs_base = env->segs[R_CS].base;
-        *pc = (uint32_t)(*cs_base + env->eip);
-    }
-}
-
 void do_cpu_init(X86CPU *cpu);
 
 #define MCE_INJECT_BROADCAST    1
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 64eac07a16..dd375d115f 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -443,18 +443,6 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
 
-static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
-    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
-    *flags |= is_va32(env) * HW_FLAGS_VA32;
-}
-
 #include "exec/cpu-all.h"
 
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index aca4aa610b..54dcfe1194 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -601,22 +601,6 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_TRACE          16
 #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
 
-static inline void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
-    if (env->sr & SR_S) {
-        *flags |= TB_FLAGS_MSR_S;
-        *flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
-        *flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
-    }
-    if (M68K_SR_TRACE(env->sr) == M68K_SR_TRACE_ANY_INS) {
-        *flags |= TB_FLAGS_TRACE;
-    }
-}
-
 void dump_mmu(CPUM68KState *env);
 
 #endif
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 446af5dd4c..27ccfc92b4 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -415,14 +415,6 @@ void mb_tcg_init(void);
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
-static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK);
-    *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
-}
-
 #if !defined(CONFIG_USER_ONLY)
 bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 4c9dc09a66..05e9c902d1 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1359,15 +1359,6 @@ void cpu_mips_clock_init(MIPSCPU *cpu);
 /* helper.c */
 target_ulong exception_resume_pc(CPUMIPSState *env);
 
-static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->active_tc.PC;
-    *cs_base = 0;
-    *flags = env->hflags & (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK |
-                            MIPS_HFLAG_HWRENA_ULR);
-}
-
 /**
  * mips_cpu_create_with_clock:
  * @typename: a MIPS CPU type.
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 4164a3432e..d0616723fe 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -286,16 +286,4 @@ FIELD(TBFLAGS, CRS0, 0, 1)  /* Set if CRS == 0. */
 FIELD(TBFLAGS, U, 1, 1)     /* Overlaps CR_STATUS_U */
 FIELD(TBFLAGS, R0_0, 2, 1)  /* Set if R0 == 0. */
 
-static inline void cpu_get_tb_cpu_state(CPUNios2State *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    unsigned crs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, CRS);
-
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = (env->ctrl[CR_STATUS] & CR_STATUS_U)
-           | (crs ? 0 : R_TBFLAGS_CRS0_MASK)
-           | (env->regs[0] ? 0 : R_TBFLAGS_R0_0_MASK);
-}
-
 #endif /* NIOS2_CPU_H */
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b1b7db5cbd..6997c7534e 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -351,16 +351,6 @@ static inline void cpu_set_gpr(CPUOpenRISCState *env, int i, uint32_t val)
     env->shadow_gpr[0][i] = val;
 }
 
-static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = (env->dflag ? TB_FLAGS_DFLAG : 0)
-           | (cpu_get_gpr(env, 0) ? 0 : TB_FLAGS_R0_0)
-           | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
-}
-
 static inline uint32_t cpu_get_sr(const CPUOpenRISCState *env)
 {
     return (env->sr
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 59587a8aba..3bb10f0188 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2652,19 +2652,6 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer);
  */
 #define is_book3s_arch2x(ctx) (!!((ctx)->insns_flags & PPC_SEGMENT_64B))
 
-#ifdef CONFIG_DEBUG_TCG
-void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *flags);
-#else
-static inline void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->nip;
-    *cs_base = 0;
-    *flags = env->hflags;
-}
-#endif
-
 G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception);
 G_NORETURN void raise_exception_ra(CPUPPCState *env, uint32_t exception,
                                    uintptr_t raddr);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bca27278ed..625ffc7622 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -688,9 +688,6 @@ static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
     return cpu->cfg.vlen >> (sew + 3 - lmul);
 }
 
-void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags);
-
 void riscv_cpu_update_mask(CPURISCVState *env);
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index c53593d7aa..dcda762212 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -149,15 +149,6 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
 #define RX_CPU_IRQ 0
 #define RX_CPU_FIR 1
 
-static inline void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = FIELD_DP32(0, PSW, PM, env->psw_pm);
-    *flags = FIELD_DP32(*flags, PSW, U, env->psw_u);
-}
-
 static inline uint32_t rx_cpu_pack_psw(CPURXState *env)
 {
     uint32_t psw = 0;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 61c893b1b9..dd5b145539 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -382,31 +382,7 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define MMU_REAL_IDX            3
 
 #ifdef CONFIG_TCG
-
 #include "tcg/tcg_s390x.h"
-
-static inline void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    if (env->psw.addr & 1) {
-        /*
-         * Instructions must be at even addresses.
-         * This needs to be checked before address translation.
-         */
-        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
-        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
-    }
-    *pc = env->psw.addr;
-    *cs_base = env->ex_value;
-    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
-    if (env->cregs[0] & CR0_AFP) {
-        *flags |= FLAG_MASK_AFP;
-    }
-    if (env->cregs[0] & CR0_VECTOR) {
-        *flags |= FLAG_MASK_VECTOR;
-    }
-}
-
 #endif /* CONFIG_TCG */
 
 /* PER bits from control register 9 */
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 9211da6bde..36aff035cf 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -370,19 +370,4 @@ static inline void cpu_write_sr(CPUSH4State *env, target_ulong sr)
     env->sr = sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
 }
 
-static inline void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    /* For a gUSA region, notice the end of the region.  */
-    *cs_base = env->flags & TB_FLAG_GUSA_MASK ? env->gregs[0] : 0;
-    *flags = env->flags
-            | (env->fpscr & TB_FLAG_FPSCR_MASK)
-            | (env->sr & TB_FLAG_SR_MASK)
-            | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 3 */
-#ifdef CONFIG_USER_ONLY
-    *flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
-#endif
-}
-
 #endif /* SH4_CPU_H */
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 51856152fa..60c72f06f5 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -749,39 +749,6 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_HYPER        (1 << 7)
 #define TB_FLAG_ASI_SHIFT    24
 
-static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    uint32_t flags;
-    *pc = env->pc;
-    *cs_base = env->npc;
-    flags = cpu_mmu_index(env, false);
-#ifndef CONFIG_USER_ONLY
-    if (cpu_supervisor_mode(env)) {
-        flags |= TB_FLAG_SUPER;
-    }
-#endif
-#ifdef TARGET_SPARC64
-#ifndef CONFIG_USER_ONLY
-    if (cpu_hypervisor_mode(env)) {
-        flags |= TB_FLAG_HYPER;
-    }
-#endif
-    if (env->pstate & PS_AM) {
-        flags |= TB_FLAG_AM_ENABLED;
-    }
-    if ((env->pstate & PS_PEF) && (env->fprs & FPRS_FEF)) {
-        flags |= TB_FLAG_FPU_ENABLED;
-    }
-    flags |= env->asi << TB_FLAG_ASI_SHIFT;
-#else
-    if (env->psref) {
-        flags |= TB_FLAG_FPU_ENABLED;
-    }
-#endif
-    *pflags = flags;
-}
-
 static inline bool tb_fpu_enabled(int tb_flags)
 {
 #if defined(CONFIG_USER_ONLY)
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 220af69fc2..9537fef2b9 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -253,18 +253,6 @@ FIELD(TB_FLAGS, PRIV, 0, 2)
 void cpu_state_reset(CPUTriCoreState *s);
 void tricore_tcg_init(void);
 
-static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    uint32_t new_flags = 0;
-    *pc = env->PC;
-    *cs_base = 0;
-
-    new_flags |= FIELD_DP32(new_flags, TB_FLAGS, PRIV,
-            extract32(env->PSW, 10, 2));
-    *flags = new_flags;
-}
-
 #define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
 
 /* helpers.c */
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 6b8d0636d2..2b6f2bdea7 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -734,74 +734,6 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 
 #include "exec/cpu-all.h"
 
-static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *flags = 0;
-    *flags |= xtensa_get_ring(env);
-    if (env->sregs[PS] & PS_EXCM) {
-        *flags |= XTENSA_TBFLAG_EXCM;
-    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_LOOP)) {
-        target_ulong lend_dist =
-            env->sregs[LEND] - (env->pc & -(1u << TARGET_PAGE_BITS));
-
-        /*
-         * 0 in the csbase_lend field means that there may not be a loopback
-         * for any instruction that starts inside this page. Any other value
-         * means that an instruction that ends at this offset from the page
-         * start may loop back and will need loopback code to be generated.
-         *
-         * lend_dist is 0 when LEND points to the start of the page, but
-         * no instruction that starts inside this page may end at offset 0,
-         * so it's still correct.
-         *
-         * When an instruction ends at a page boundary it may only start in
-         * the previous page. lend_dist will be encoded as TARGET_PAGE_SIZE
-         * for the TB that contains this instruction.
-         */
-        if (lend_dist < (1u << TARGET_PAGE_BITS) + env->config->max_insn_size) {
-            target_ulong lbeg_off = env->sregs[LEND] - env->sregs[LBEG];
-
-            *cs_base = lend_dist;
-            if (lbeg_off < 256) {
-                *cs_base |= lbeg_off << XTENSA_CSBASE_LBEG_OFF_SHIFT;
-            }
-        }
-    }
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_EXTENDED_L32R) &&
-            (env->sregs[LITBASE] & 1)) {
-        *flags |= XTENSA_TBFLAG_LITBASE;
-    }
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_DEBUG)) {
-        if (xtensa_get_cintlevel(env) < env->config->debug_level) {
-            *flags |= XTENSA_TBFLAG_DEBUG;
-        }
-        if (xtensa_get_cintlevel(env) < env->sregs[ICOUNTLEVEL]) {
-            *flags |= XTENSA_TBFLAG_ICOUNT;
-        }
-    }
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_COPROCESSOR)) {
-        *flags |= env->sregs[CPENABLE] << XTENSA_TBFLAG_CPENABLE_SHIFT;
-    }
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGISTER) &&
-        (env->sregs[PS] & (PS_WOE | PS_EXCM)) == PS_WOE) {
-        uint32_t windowstart = xtensa_replicate_windowstart(env) >>
-            (env->sregs[WINDOW_BASE] + 1);
-        uint32_t w = ctz32(windowstart | 0x8);
-
-        *flags |= (w << XTENSA_TBFLAG_WINDOW_SHIFT) | XTENSA_TBFLAG_CWOE;
-        *flags |= extract32(env->sregs[PS], PS_CALLINC_SHIFT,
-                            PS_CALLINC_LEN) << XTENSA_TBFLAG_CALLINC_SHIFT;
-    } else {
-        *flags |= 3 << XTENSA_TBFLAG_WINDOW_SHIFT;
-    }
-    if (env->yield_needed) {
-        *flags |= XTENSA_TBFLAG_YIELD;
-    }
-}
-
 XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type,
                                         Clock *cpu_refclk);
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index ce18bedcca..ce20a56270 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -34,6 +34,17 @@ int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
     return ret;
 }
 
+void cpu_get_tb_cpu_state(CPUAlphaState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *pflags = env->flags & ENV_FLAG_TB_MASK;
+#ifdef CONFIG_USER_ONLY
+    *pflags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+#endif
+}
+
 static void alpha_cpu_set_pc(CPUState *cs, vaddr value)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index ffb2234ecf..76dbe56284 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -32,6 +32,24 @@ int cpu_mmu_index(CPUAVRState *env, bool ifetch)
     return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
 }
 
+void cpu_get_tb_cpu_state(CPUAVRState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    uint32_t flags = 0;
+
+    *pc = env->pc_w * 2;
+    *cs_base = 0;
+
+    if (env->fullacc) {
+        flags |= TB_FLAGS_FULL_ACCESS;
+    }
+    if (env->skip) {
+        flags |= TB_FLAGS_SKIP;
+    }
+
+    *pflags = flags;
+}
+
 static void avr_cpu_set_pc(CPUState *cs, vaddr value)
 {
     AVRCPU *cpu = AVR_CPU(cs);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 1a8a544e31..6512ef8ee2 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -32,6 +32,16 @@ int cpu_mmu_index(CPUCRISState *env, bool ifetch)
     return !!(env->pregs[PR_CCS] & U_FLAG);
 }
 
+void cpu_get_tb_cpu_state(CPUCRISState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = env->dslot |
+            (env->pregs[PR_CCS] & (S_FLAG | P_FLAG | U_FLAG
+                                   | X_FLAG | PFIX_FLAG));
+}
+
 static void cris_cpu_set_pc(CPUState *cs, vaddr value)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index fd8dafad31..b2bbb21b59 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -35,6 +35,18 @@ int cpu_mmu_index(CPUHexagonState *env, bool ifetch)
 #endif
 }
 
+void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    uint32_t hex_flags = 0;
+    *pc = env->gpr[HEX_REG_PC];
+    *cs_base = 0;
+    if (*pc == env->gpr[HEX_REG_SA0]) {
+        hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
+    }
+    *flags = hex_flags;
+}
+
 static void hexagon_v67_cpu_init(Object *obj) { }
 static void hexagon_v68_cpu_init(Object *obj) { }
 static void hexagon_v69_cpu_init(Object *obj) { }
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 04f0b927b6..2cc8e43b33 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -41,6 +41,48 @@ int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 #endif
 }
 
+void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    uint32_t flags = env->psw_n * PSW_N;
+
+    /* TB lookup assumes that PC contains the complete virtual address.
+       If we leave space+offset separate, we'll get ITLB misses to an
+       incomplete virtual address.  This also means that we must separate
+       out current cpu privilege from the low bits of IAOQ_F.  */
+#ifdef CONFIG_USER_ONLY
+    *pc = env->iaoq_f & -4;
+    *cs_base = env->iaoq_b & -4;
+    flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+#else
+    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
+    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
+    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
+
+    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
+                            env->iaoq_f & -4);
+    *cs_base = env->iasq_f;
+
+    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
+       low 32-bits of CS_BASE.  This will succeed for all direct branches,
+       which is the primary case we care about -- using goto_tb within a page.
+       Failure is indicated by a zero difference.  */
+    if (env->iasq_f == env->iasq_b) {
+        target_long diff = env->iaoq_b - env->iaoq_f;
+        if (diff == (int32_t)diff) {
+            *cs_base |= (uint32_t)diff;
+        }
+    }
+    if ((env->sr[4] == env->sr[5])
+        & (env->sr[4] == env->sr[6])
+        & (env->sr[4] == env->sr[7])) {
+        flags |= TB_FLAG_SR_SAME;
+    }
+#endif
+
+    *pflags = flags;
+}
+
 static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d0adfb381b..da32929558 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -53,6 +53,20 @@ int cpu_mmu_index(CPUX86State *env, bool ifetch)
         ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
 }
 
+void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *flags = env->hflags |
+        (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
+    if (env->hflags & HF_CS64_MASK) {
+        *cs_base = 0;
+        *pc = env->eip;
+    } else {
+        *cs_base = env->segs[R_CS].base;
+        *pc = (uint32_t)(*cs_base + env->eip);
+    }
+}
+
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp);
 
 /* Helpers for building CPUID[2] descriptors: */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 316a85bacd..ea4281e177 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -43,6 +43,18 @@ int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 #endif
 }
 
+void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
+    *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
+    *flags |= is_va32(env) * HW_FLAGS_VA32;
+}
+
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
     "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 604cdd5faf..f9dc447897 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -29,6 +29,22 @@ int cpu_mmu_index(CPUM68KState *env, bool ifetch)
     return (env->sr & SR_S) == 0 ? 1 : 0;
 }
 
+void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = (env->macsr >> 4) & TB_FLAGS_MACSR;
+    if (env->sr & SR_S) {
+        *flags |= TB_FLAGS_MSR_S;
+        *flags |= (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) & TB_FLAGS_SFC_S;
+        *flags |= (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) & TB_FLAGS_DFC_S;
+    }
+    if (M68K_SR_TRACE(env->sr) == M68K_SR_TRACE_ANY_INS) {
+        *flags |= TB_FLAGS_TRACE;
+    }
+}
+
 static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 {
     M68kCPU *cpu = M68K_CPU(cs);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f8891de41e..4c270e941f 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -47,6 +47,13 @@ int cpu_mmu_index(CPUMBState *env, bool ifetch)
     return MMU_KERNEL_IDX;
 }
 
+void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *flags = (env->iflags & IFLAGS_TB_MASK) | (env->msr & MSR_TB_MASK);
+    *cs_base = (*flags & IMM_FLAG ? env->imm : 0);
+}
 
 static const struct {
     const char *name;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 34c0e40d32..4c3e1ec2d9 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -40,6 +40,15 @@ int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
     return hflags_mmu_index(env->hflags);
 }
 
+void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->active_tc.PC;
+    *cs_base = 0;
+    *flags = env->hflags & (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK |
+                            MIPS_HFLAG_HWRENA_ULR);
+}
+
 const char regnames[32][3] = {
     "r0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
     "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7",
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 976b8c50ad..3e42889ce6 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -32,6 +32,18 @@ int cpu_mmu_index(CPUNios2State *env, bool ifetch)
                                                   MMU_SUPERVISOR_IDX;
 }
 
+void cpu_get_tb_cpu_state(CPUNios2State *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    unsigned crs = FIELD_EX32(env->ctrl[CR_STATUS], CR_STATUS, CRS);
+
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = (env->ctrl[CR_STATUS] & CR_STATUS_U)
+           | (crs ? 0 : R_TBFLAGS_CRS0_MASK)
+           | (env->regs[0] ? 0 : R_TBFLAGS_R0_0_MASK);
+}
+
 static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index fedeba3a3f..fda0dc9470 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -37,6 +37,16 @@ int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
     return ret;
 }
 
+void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = (env->dflag ? TB_FLAGS_DFLAG : 0)
+           | (cpu_get_gpr(env, 0) ? 0 : TB_FLAGS_R0_0)
+           | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
+}
+
 static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index e0b2dcd02e..a506f9823c 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -217,26 +217,27 @@ void hreg_update_pmu_hflags(CPUPPCState *env)
     env->hflags |= hreg_compute_pmu_hflags_value(env);
 }
 
-#ifdef CONFIG_DEBUG_TCG
 void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *flags)
 {
+#ifdef CONFIG_DEBUG_TCG
+    uint32_t hflags_rebuilt = hreg_compute_hflags_value(env);
     uint32_t hflags_current = env->hflags;
-    uint32_t hflags_rebuilt;
 
-    *pc = env->nip;
-    *cs_base = 0;
-    *flags = hflags_current;
-
-    hflags_rebuilt = hreg_compute_hflags_value(env);
     if (unlikely(hflags_current != hflags_rebuilt)) {
         cpu_abort(env_cpu(env),
                   "TCG hflags mismatch (current:0x%08x rebuilt:0x%08x)\n",
                   hflags_current, hflags_rebuilt);
     }
-}
+    *flags = hflags_current;
+#else
+    *flags = env->hflags;
 #endif
 
+    *pc = env->nip;
+    *cs_base = 0;
+}
+
 void cpu_interrupt_exittb(CPUState *cs)
 {
     /*
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index b9f2bff9ce..de1cc7a5e6 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -31,6 +31,15 @@ int cpu_mmu_index(CPURXState *env, bool ifetch)
     return 0;
 }
 
+void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = FIELD_DP32(0, PSW, PM, env->psw_pm);
+    *flags = FIELD_DP32(*flags, PSW, U, env->psw_u);
+}
+
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
     RXCPU *cpu = RX_CPU(cs);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index bbb0b65bee..db1590472e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -74,6 +74,28 @@ int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 #endif
 }
 
+void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    if (env->psw.addr & 1) {
+        /*
+         * Instructions must be at even addresses.
+         * This needs to be checked before address translation.
+         */
+        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
+    }
+    *pc = env->psw.addr;
+    *cs_base = env->ex_value;
+    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
+    if (env->cregs[0] & CR0_AFP) {
+        *flags |= FLAG_MASK_AFP;
+    }
+    if (env->cregs[0] & CR0_VECTOR) {
+        *flags |= FLAG_MASK_VECTOR;
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool is_early_exception_psw(uint64_t mask, uint64_t addr)
 {
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index e99fba7778..eb7eb6f30a 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -41,6 +41,21 @@ int cpu_mmu_index(CPUSH4State *env, bool ifetch)
     }
 }
 
+void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    /* For a gUSA region, notice the end of the region.  */
+    *cs_base = env->flags & TB_FLAG_GUSA_MASK ? env->gregs[0] : 0;
+    *flags = env->flags
+            | (env->fpscr & TB_FLAG_FPSCR_MASK)
+            | (env->sr & TB_FLAG_SR_MASK)
+            | (env->movcal_backup ? TB_FLAG_PENDING_MOVCA : 0); /* Bit 3 */
+#ifdef CONFIG_USER_ONLY
+    *flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+#endif
+}
+
 static void superh_cpu_set_pc(CPUState *cs, vaddr value)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e2b1feac2f..99d57cc209 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -57,6 +57,39 @@ int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
 #endif
 }
 
+void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    uint32_t flags;
+    *pc = env->pc;
+    *cs_base = env->npc;
+    flags = cpu_mmu_index(env, false);
+#ifndef CONFIG_USER_ONLY
+    if (cpu_supervisor_mode(env)) {
+        flags |= TB_FLAG_SUPER;
+    }
+#endif
+#ifdef TARGET_SPARC64
+#ifndef CONFIG_USER_ONLY
+    if (cpu_hypervisor_mode(env)) {
+        flags |= TB_FLAG_HYPER;
+    }
+#endif
+    if (env->pstate & PS_AM) {
+        flags |= TB_FLAG_AM_ENABLED;
+    }
+    if ((env->pstate & PS_PEF) && (env->fprs & FPRS_FEF)) {
+        flags |= TB_FLAG_FPU_ENABLED;
+    }
+    flags |= env->asi << TB_FLAG_ASI_SHIFT;
+#else
+    if (env->psref) {
+        flags |= TB_FLAG_FPU_ENABLED;
+    }
+#endif
+    *pflags = flags;
+}
+
 static void sparc_cpu_reset_hold(Object *obj)
 {
     CPUState *s = CPU(obj);
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index a2bb1038ff..dff88184c9 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -29,6 +29,18 @@ int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
     return 0;
 }
 
+void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    uint32_t new_flags = 0;
+    *pc = env->PC;
+    *cs_base = 0;
+
+    new_flags |= FIELD_DP32(new_flags, TB_FLAGS, PRIV,
+            extract32(env->PSW, 10, 2));
+    *flags = new_flags;
+}
+
 static inline void set_feature(CPUTriCoreState *env, int feature)
 {
     env->features |= 1ULL << feature;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7d69cef8cc..dfe0ff5c98 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -44,6 +44,74 @@ int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
     return xtensa_get_cring(env);
 }
 
+void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = 0;
+    *flags |= xtensa_get_ring(env);
+    if (env->sregs[PS] & PS_EXCM) {
+        *flags |= XTENSA_TBFLAG_EXCM;
+    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_LOOP)) {
+        target_ulong lend_dist =
+            env->sregs[LEND] - (env->pc & -(1u << TARGET_PAGE_BITS));
+
+        /*
+         * 0 in the csbase_lend field means that there may not be a loopback
+         * for any instruction that starts inside this page. Any other value
+         * means that an instruction that ends at this offset from the page
+         * start may loop back and will need loopback code to be generated.
+         *
+         * lend_dist is 0 when LEND points to the start of the page, but
+         * no instruction that starts inside this page may end at offset 0,
+         * so it's still correct.
+         *
+         * When an instruction ends at a page boundary it may only start in
+         * the previous page. lend_dist will be encoded as TARGET_PAGE_SIZE
+         * for the TB that contains this instruction.
+         */
+        if (lend_dist < (1u << TARGET_PAGE_BITS) + env->config->max_insn_size) {
+            target_ulong lbeg_off = env->sregs[LEND] - env->sregs[LBEG];
+
+            *cs_base = lend_dist;
+            if (lbeg_off < 256) {
+                *cs_base |= lbeg_off << XTENSA_CSBASE_LBEG_OFF_SHIFT;
+            }
+        }
+    }
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_EXTENDED_L32R) &&
+            (env->sregs[LITBASE] & 1)) {
+        *flags |= XTENSA_TBFLAG_LITBASE;
+    }
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_DEBUG)) {
+        if (xtensa_get_cintlevel(env) < env->config->debug_level) {
+            *flags |= XTENSA_TBFLAG_DEBUG;
+        }
+        if (xtensa_get_cintlevel(env) < env->sregs[ICOUNTLEVEL]) {
+            *flags |= XTENSA_TBFLAG_ICOUNT;
+        }
+    }
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_COPROCESSOR)) {
+        *flags |= env->sregs[CPENABLE] << XTENSA_TBFLAG_CPENABLE_SHIFT;
+    }
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGISTER) &&
+        (env->sregs[PS] & (PS_WOE | PS_EXCM)) == PS_WOE) {
+        uint32_t windowstart = xtensa_replicate_windowstart(env) >>
+            (env->sregs[WINDOW_BASE] + 1);
+        uint32_t w = ctz32(windowstart | 0x8);
+
+        *flags |= (w << XTENSA_TBFLAG_WINDOW_SHIFT) | XTENSA_TBFLAG_CWOE;
+        *flags |= extract32(env->sregs[PS], PS_CALLINC_SHIFT,
+                            PS_CALLINC_LEN) << XTENSA_TBFLAG_CALLINC_SHIFT;
+    } else {
+        *flags |= 3 << XTENSA_TBFLAG_WINDOW_SHIFT;
+    }
+    if (env->yield_needed) {
+        *flags |= XTENSA_TBFLAG_YIELD;
+    }
+}
+
 static void xtensa_cpu_set_pc(CPUState *cs, vaddr value)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
-- 
2.34.1


