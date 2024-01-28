Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C64C47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0D-0004iV-I2; Sat, 27 Jan 2024 23:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0C-0004iK-GT
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:40 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx09-0004IX-DO
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:40 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42a8e6cb2ceso12622201cf.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416956; x=1707021756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VODEHWMxMF5aJBZz0S2TC6sc+IupRmg6TxWrBBUh29E=;
 b=IgdA0baFc7S4pfKZgA4ioGXevzDadvFAgqMQL1MpuYLT87R6/81IU3XVK2R18DQW2x
 T3xSIOGe0NfhBOCr9X8p8zMmMbcrF3NRnyzE0et56hJrUQuKP8dm4LpfIYj7zyJGCqj8
 gJclooiXWt3+mhxih+V7+ZJhl12YloabYDA1pX9DqwJd57KAykPyB/RtNBQaybKpbG+H
 qG54v3enaAnyAIdeNkUPoRNVAwID9uqmg8oSn02Sw7/Tt01f4pT20ZC1/muvDIm+5Vb0
 PiGkZO5XRCENSi8VI5cCWEZThaj5p7aNrqxG8EK8XS0M2z/ps8dbinmRWF73Ei8mwZQi
 u20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416956; x=1707021756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VODEHWMxMF5aJBZz0S2TC6sc+IupRmg6TxWrBBUh29E=;
 b=fGoFWakA5QWb+VD+4eSZutukvECEZyyCRZaN6wNqlz//MYvCQeb+KNY7MJIPgIwi5+
 NFdYj4lVq7ccJZBkPNVljZpnWEQViShYRvA4qXKMTv4dU+SATlkWgtRfpMj4Caw4CAj3
 0ZSvYyUIOHTnRMBE5HxB52jKuYsW6+N9dCcE8FfNkv9BWuhfHrQc+FZWm6rW2NMUiL9D
 3A91JHInjLfEHS/h58XlOW0hElVkifOKpTwN6csgA6tbpSREX8HImw31KSJMsQ+bvEO9
 vtbpqh0z/perCGdPsi3w3dF0/bm6W/Q8Q6LTdMv0h+ZXG/7twgztFcRvMv1Py7wlCwC2
 4svQ==
X-Gm-Message-State: AOJu0YxRtMUzRQ8gqleTiuNzoeHf9cvcAu37B/d6+UdIIcNPq8BtsbOk
 D0mdwSZ2Ymuv2eGfoNmirVbTiAbLwo80qC85zoKAGP2zQNCTFmPjAOitaIY3fde0UNB5L0QsuYu
 wGe81Ew==
X-Google-Smtp-Source: AGHT+IHllzqTXRtRBjNCO11lpWy8ZOAPEBDoGiRhQrrZN3ZA6Wg7d27SgqX6ZKbx3awj2GZxyeLS7Q==
X-Received: by 2002:ac8:4e93:0:b0:42a:820:b140 with SMTP id
 19-20020ac84e93000000b0042a0820b140mr3733083qtp.120.1706416956249; 
 Sat, 27 Jan 2024 20:42:36 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH 07/33] target: Uninline cpu_mmu_index()
Date: Sun, 28 Jan 2024 14:41:47 +1000
Message-Id: <20240128044213.316480-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82e.google.com
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

Uninlines the target-defined cpu_mmu_index() function by moving its
definition to target/*/cpu.c.  This allows for compiling memory access
functions in accel/tcg/cputlb.c without having to know target specifics.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-13-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 10 ++++++++++
 target/alpha/cpu.h        |  9 ---------
 target/arm/cpu.h          | 13 -------------
 target/avr/cpu.h          |  7 -------
 target/cris/cpu.h         |  4 ----
 target/hexagon/cpu.h      |  9 ---------
 target/hppa/cpu.h         | 13 -------------
 target/i386/cpu.h         |  7 -------
 target/loongarch/cpu.h    | 12 ------------
 target/m68k/cpu.h         |  4 ----
 target/microblaze/cpu.h   | 15 ---------------
 target/mips/cpu.h         |  5 -----
 target/nios2/cpu.h        |  6 ------
 target/openrisc/cpu.h     | 12 ------------
 target/ppc/cpu.h          |  8 --------
 target/riscv/cpu.h        |  3 ---
 target/rx/cpu.h           |  5 -----
 target/s390x/cpu.h        | 31 -------------------------------
 target/sh4/cpu.h          | 10 ----------
 target/sparc/cpu.h        | 28 ----------------------------
 target/tricore/cpu.h      |  5 -----
 target/xtensa/cpu.h       |  5 -----
 target/alpha/cpu.c        |  8 ++++++++
 target/arm/cpu.c          |  5 +++++
 target/avr/cpu.c          |  5 +++++
 target/cris/cpu.c         |  4 ++++
 target/hexagon/cpu.c      |  9 +++++++++
 target/hppa/cpu.c         | 13 +++++++++++++
 target/i386/cpu.c         |  7 +++++++
 target/loongarch/cpu.c    | 12 ++++++++++++
 target/m68k/cpu.c         |  5 +++++
 target/microblaze/cpu.c   | 16 ++++++++++++++++
 target/mips/cpu.c         |  5 +++++
 target/nios2/cpu.c        |  6 ++++++
 target/openrisc/cpu.c     | 12 ++++++++++++
 target/ppc/cpu.c          |  9 +++++++++
 target/riscv/cpu_helper.c |  2 +-
 target/rx/cpu.c           |  5 +++++
 target/s390x/cpu.c        | 31 +++++++++++++++++++++++++++++++
 target/sh4/cpu.c          | 13 +++++++++++++
 target/sparc/cpu.c        | 28 ++++++++++++++++++++++++++++
 target/tricore/cpu.c      |  5 +++++
 target/xtensa/cpu.c       |  4 ++++
 43 files changed, 213 insertions(+), 212 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 3109c6b67d..4724135f30 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -34,6 +34,16 @@ void cpu_list_lock(void);
 void cpu_list_unlock(void);
 unsigned int cpu_list_generation_id_get(void);
 
+/**
+ * cpu_mmu_index:
+ * @env: The cpu environment
+ * @ifetch: True for code access, false for data access.
+ *
+ * Return the core mmu index for the current translation regime.
+ * This function is used by generic TCG code paths.
+ */
+int cpu_mmu_index(CPUArchState *env, bool ifetch);
+
 void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index ce806587ca..abf778735a 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -389,15 +389,6 @@ enum {
 
 #define TB_FLAG_UNALIGN       (1u << 1)
 
-static inline int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
-{
-    int ret = env->flags & ENV_FLAG_PS_USER ? MMU_USER_IDX : MMU_KERNEL_IDX;
-    if (env->flags & ENV_FLAG_PAL_MODE) {
-        ret = MMU_KERNEL_IDX;
-    }
-    return ret;
-}
-
 enum {
     IR_V0   = 0,
     IR_T0   = 1,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ec276fcd57..b0edf2e540 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3268,19 +3268,6 @@ FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 #define EX_TBFLAG_M32(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_M32, WHICH)
 #define EX_TBFLAG_AM32(IN, WHICH)  FIELD_EX32(IN.flags2, TBFLAG_AM32, WHICH)
 
-/**
- * cpu_mmu_index:
- * @env: The cpu environment
- * @ifetch: True for code access, false for data access.
- *
- * Return the core mmu index for the current translation regime.
- * This function is used by generic TCG code paths.
- */
-static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
-{
-    return EX_TBFLAG_ANY(env->hflags, MMUIDX);
-}
-
 /**
  * sve_vq
  * @env: the cpu context
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 7d5dd42575..d185d20dcb 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -184,13 +184,6 @@ static inline void set_avr_feature(CPUAVRState *env, int feature)
     env->features |= (1U << feature);
 }
 
-#define cpu_mmu_index avr_cpu_mmu_index
-
-static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
-{
-    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
-}
-
 void avr_cpu_tcg_init(void);
 
 int cpu_avr_exec(CPUState *cpu);
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index d830dcac5b..3904e5448c 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -260,10 +260,6 @@ enum {
 
 /* MMU modes definitions */
 #define MMU_USER_IDX 1
-static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
-{
-	return !!(env->pregs[PR_CCS] & U_FLAG);
-}
 
 /* Support function regs.  */
 #define SFR_RW_GC_CFG      0][0
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 5c11ae3445..3eef58fe8f 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -146,15 +146,6 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
     *flags = hex_flags;
 }
 
-static inline int cpu_mmu_index(CPUHexagonState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_USER_IDX;
-#else
-#error System mode not supported on Hexagon yet
-#endif
-}
-
 typedef HexagonCPU ArchCPU;
 
 void hexagon_translate_init(void);
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6a153405d2..7a181e8f33 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -281,19 +281,6 @@ static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
     return hppa_is_pa20(env) ? 0 : PA10_BTLB_FIXED + PA10_BTLB_VARIABLE;
 }
 
-static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_USER_IDX;
-#else
-    if (env->psw & (ifetch ? PSW_C : PSW_D)) {
-        return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
-    }
-    /* mmu disabled */
-    return env->psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
-#endif
-}
-
 void hppa_translate_init(void);
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7f0786e8b9..6a5b180ccb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2296,13 +2296,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define MMU_NESTED_IDX  3
 #define MMU_PHYS_IDX    4
 
-static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
-{
-    return (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER_IDX :
-        (!(env->hflags & HF_SMAP_MASK) || (env->eflags & AC_MASK))
-        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
-}
-
 static inline int cpu_mmu_index_kernel(CPUX86State *env)
 {
     return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 0fa5e0ca93..64eac07a16 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -408,18 +408,6 @@ struct LoongArchCPUClass {
 #define MMU_IDX_USER     MMU_PLV_USER
 #define MMU_IDX_DA       4
 
-static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_IDX_USER;
-#else
-    if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
-        return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
-    }
-    return MMU_IDX_DA;
-#endif
-}
-
 static inline bool is_la64(CPULoongArchState *env)
 {
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d13427b0fe..aca4aa610b 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -577,10 +577,6 @@ enum {
 /* MMU modes definitions */
 #define MMU_KERNEL_IDX 0
 #define MMU_USER_IDX 1
-static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
-{
-    return (env->sr & SR_S) == 0 ? 1 : 0;
-}
 
 bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index b5374365f5..446af5dd4c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -434,21 +434,6 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                MemTxResult response, uintptr_t retaddr);
 #endif
 
-static inline int cpu_mmu_index(CPUMBState *env, bool ifetch)
-{
-    MicroBlazeCPU *cpu = env_archcpu(env);
-
-    /* Are we in nommu mode?.  */
-    if (!(env->msr & MSR_VM) || !cpu->cfg.use_mmu) {
-        return MMU_NOMMU_IDX;
-    }
-
-    if (env->msr & MSR_UM) {
-        return MMU_USER_IDX;
-    }
-    return MMU_KERNEL_IDX;
-}
-
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_mb_cpu;
 #endif
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 1163a71f3c..4c9dc09a66 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1253,11 +1253,6 @@ static inline int hflags_mmu_index(uint32_t hflags)
     }
 }
 
-static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
-{
-    return hflags_mmu_index(env->hflags);
-}
-
 #include "exec/cpu-all.h"
 
 /* Exceptions */
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 2d79b5b298..4164a3432e 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -270,12 +270,6 @@ void do_nios2_semihosting(CPUNios2State *env);
 #define MMU_SUPERVISOR_IDX  0
 #define MMU_USER_IDX        1
 
-static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
-{
-    return (env->ctrl[CR_STATUS] & CR_STATUS_U) ? MMU_USER_IDX :
-                                                  MMU_SUPERVISOR_IDX;
-}
-
 #ifndef CONFIG_USER_ONLY
 hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b454014ddd..b1b7db5cbd 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -361,18 +361,6 @@ static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
            | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
 }
 
-static inline int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
-{
-    int ret = MMU_NOMMU_IDX;  /* mmu is disabled */
-
-    if (env->sr & (ifetch ? SR_IME : SR_DME)) {
-        /* The mmu is enabled; test supervisor state.  */
-        ret = env->sr & SR_SM ? MMU_SUPERVISOR_IDX : MMU_USER_IDX;
-    }
-
-    return ret;
-}
-
 static inline uint32_t cpu_get_sr(const CPUOpenRISCState *env)
 {
     return (env->sr
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f8101ffa29..59587a8aba 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1624,14 +1624,6 @@ int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
 /* MMU modes definitions */
 #define MMU_USER_IDX 0
-static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_USER_IDX;
-#else
-    return (env->hflags >> (ifetch ? HFLAGS_IMMU_IDX : HFLAGS_DMMU_IDX)) & 7;
-#endif
-}
 
 /* Compatibility modes */
 #if defined(TARGET_PPC64)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5f3955c38d..bca27278ed 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -498,7 +498,6 @@ target_ulong riscv_cpu_get_geilen(CPURISCVState *env);
 void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
-int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
@@ -507,8 +506,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 
-#define cpu_mmu_index riscv_cpu_mmu_index
-
 #ifndef CONFIG_USER_ONLY
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 65f9cd2d0a..c53593d7aa 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -158,11 +158,6 @@ static inline void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
     *flags = FIELD_DP32(*flags, PSW, U, env->psw_u);
 }
 
-static inline int cpu_mmu_index(CPURXState *env, bool ifetch)
-{
-    return 0;
-}
-
 static inline uint32_t rx_cpu_pack_psw(CPURXState *env)
 {
     uint32_t psw = 0;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index fa3aac4f97..61c893b1b9 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -381,37 +381,6 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define MMU_HOME_IDX            2
 #define MMU_REAL_IDX            3
 
-static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
-{
-#ifdef CONFIG_USER_ONLY
-    return MMU_USER_IDX;
-#else
-    if (!(env->psw.mask & PSW_MASK_DAT)) {
-        return MMU_REAL_IDX;
-    }
-
-    if (ifetch) {
-        if ((env->psw.mask & PSW_MASK_ASC) == PSW_ASC_HOME) {
-            return MMU_HOME_IDX;
-        }
-        return MMU_PRIMARY_IDX;
-    }
-
-    switch (env->psw.mask & PSW_MASK_ASC) {
-    case PSW_ASC_PRIMARY:
-        return MMU_PRIMARY_IDX;
-    case PSW_ASC_SECONDARY:
-        return MMU_SECONDARY_IDX;
-    case PSW_ASC_HOME:
-        return MMU_HOME_IDX;
-    case PSW_ASC_ACCREG:
-        /* Fallthrough: access register mode is not yet supported */
-    default:
-        abort();
-    }
-#endif
-}
-
 #ifdef CONFIG_TCG
 
 #include "tcg/tcg_s390x.h"
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 0e6fa65bae..9211da6bde 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -273,16 +273,6 @@ void cpu_load_tlb(CPUSH4State * env);
 
 /* MMU modes definitions */
 #define MMU_USER_IDX 1
-static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
-{
-    /* The instruction in a RTE delay slot is fetched in privileged
-       mode, but executed in user mode.  */
-    if (ifetch && (env->flags & TB_FLAG_DELAY_SLOT_RTE)) {
-        return 0;
-    } else {
-        return (env->sr & (1u << SR_MD)) == 0 ? 1 : 0;
-    }
-}
 
 #include "exec/cpu-all.h"
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 12a11ecb26..51856152fa 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -708,34 +708,6 @@ static inline int cpu_supervisor_mode(CPUSPARCState *env1)
 }
 #endif
 
-static inline int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
-{
-#if defined(CONFIG_USER_ONLY)
-    return MMU_USER_IDX;
-#elif !defined(TARGET_SPARC64)
-    if ((env->mmuregs[0] & MMU_E) == 0) { /* MMU disabled */
-        return MMU_PHYS_IDX;
-    } else {
-        return env->psrs;
-    }
-#else
-    /* IMMU or DMMU disabled.  */
-    if (ifetch
-        ? (env->lsu & IMMU_E) == 0 || (env->pstate & PS_RED) != 0
-        : (env->lsu & DMMU_E) == 0) {
-        return MMU_PHYS_IDX;
-    } else if (cpu_hypervisor_mode(env)) {
-        return MMU_PHYS_IDX;
-    } else if (env->tl > 0) {
-        return MMU_NUCLEUS_IDX;
-    } else if (cpu_supervisor_mode(env)) {
-        return MMU_KERNEL_IDX;
-    } else {
-        return MMU_USER_IDX;
-    }
-#endif
-}
-
 static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
 {
 #if !defined (TARGET_SPARC64)
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 2d4446cea5..220af69fc2 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -246,11 +246,6 @@ void fpu_set_state(CPUTriCoreState *env);
 
 #define MMU_USER_IDX 2
 
-static inline int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
-{
-    return 0;
-}
-
 #include "exec/cpu-all.h"
 
 FIELD(TB_FLAGS, PRIV, 0, 2)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 4b033ee924..6b8d0636d2 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -713,11 +713,6 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 /* MMU modes definitions */
 #define MMU_USER_IDX 3
 
-static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
-{
-    return xtensa_get_cring(env);
-}
-
 #define XTENSA_TBFLAG_RING_MASK 0x3
 #define XTENSA_TBFLAG_EXCM 0x4
 #define XTENSA_TBFLAG_LITBASE 0x8
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b8ed29e343..ce18bedcca 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -25,6 +25,14 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 
+int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
+{
+    int ret = env->flags & ENV_FLAG_PS_USER ? MMU_USER_IDX : MMU_KERNEL_IDX;
+    if (env->flags & ENV_FLAG_PAL_MODE) {
+        ret = MMU_KERNEL_IDX;
+    }
+    return ret;
+}
 
 static void alpha_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 593695b424..0ee9a879f0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -49,6 +49,11 @@
 #include "fpu/softfloat.h"
 #include "cpregs.h"
 
+int cpu_mmu_index(CPUARMState *env, bool ifetch)
+{
+    return EX_TBFLAG_ANY(env->hflags, MMUIDX);
+}
+
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
     ARMCPU *cpu = ARM_CPU(cs);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f5cbdc4a8c..ffb2234ecf 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -27,6 +27,11 @@
 #include "tcg/debug-assert.h"
 #include "hw/qdev-properties.h"
 
+int cpu_mmu_index(CPUAVRState *env, bool ifetch)
+{
+    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
+}
+
 static void avr_cpu_set_pc(CPUState *cs, vaddr value)
 {
     AVRCPU *cpu = AVR_CPU(cs);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 9ba08e8b0c..1a8a544e31 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -27,6 +27,10 @@
 #include "cpu.h"
 #include "mmu.h"
 
+int cpu_mmu_index(CPUCRISState *env, bool ifetch)
+{
+    return !!(env->pregs[PR_CCS] & U_FLAG);
+}
 
 static void cris_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index c0cd739e15..fd8dafad31 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -26,6 +26,15 @@
 #include "tcg/tcg.h"
 #include "exec/gdbstub.h"
 
+int cpu_mmu_index(CPUHexagonState *env, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
+#error System mode not supported on Hexagon yet
+#endif
+}
+
 static void hexagon_v67_cpu_init(Object *obj) { }
 static void hexagon_v68_cpu_init(Object *obj) { }
 static void hexagon_v69_cpu_init(Object *obj) { }
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 14e17fa9aa..04f0b927b6 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -28,6 +28,19 @@
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
 
+int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
+    if (env->psw & (ifetch ? PSW_C : PSW_D)) {
+        return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
+    }
+    /* mmu disabled */
+    return env->psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX;
+#endif
+}
+
 static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 03822d9ba8..d0adfb381b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -46,6 +46,13 @@
 #include "disas/capstone.h"
 #include "cpu-internal.h"
 
+int cpu_mmu_index(CPUX86State *env, bool ifetch)
+{
+    return (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER_IDX :
+        (!(env->hflags & HF_SMAP_MASK) || (env->eflags & AC_MASK))
+        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
+}
+
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp);
 
 /* Helpers for building CPUID[2] descriptors: */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 064540397d..316a85bacd 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -31,6 +31,18 @@
 #include "tcg/tcg.h"
 #endif
 
+int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_IDX_USER;
+#else
+    if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
+        return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
+    }
+    return MMU_IDX_DA;
+#endif
+}
+
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
     "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1421e77c2c..604cdd5faf 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -24,6 +24,11 @@
 #include "migration/vmstate.h"
 #include "fpu/softfloat.h"
 
+int cpu_mmu_index(CPUM68KState *env, bool ifetch)
+{
+    return (env->sr & SR_S) == 0 ? 1 : 0;
+}
+
 static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 {
     M68kCPU *cpu = M68K_CPU(cs);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index bbb3335cad..f8891de41e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -32,6 +32,22 @@
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
+int cpu_mmu_index(CPUMBState *env, bool ifetch)
+{
+    MicroBlazeCPU *cpu = env_archcpu(env);
+
+    /* Are we in nommu mode?.  */
+    if (!(env->msr & MSR_VM) || !cpu->cfg.use_mmu) {
+        return MMU_NOMMU_IDX;
+    }
+
+    if (env->msr & MSR_UM) {
+        return MMU_USER_IDX;
+    }
+    return MMU_KERNEL_IDX;
+}
+
+
 static const struct {
     const char *name;
     uint8_t version_id;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index a0023edd43..34c0e40d32 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -35,6 +35,11 @@
 #include "semihosting/semihost.h"
 #include "fpu_helper.h"
 
+int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
+{
+    return hflags_mmu_index(env->hflags);
+}
+
 const char regnames[32][3] = {
     "r0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
     "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7",
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index a27732bf2b..976b8c50ad 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -26,6 +26,12 @@
 #include "gdbstub/helpers.h"
 #include "hw/qdev-properties.h"
 
+int cpu_mmu_index(CPUNios2State *env, bool ifetch)
+{
+    return (env->ctrl[CR_STATUS] & CR_STATUS_U) ? MMU_USER_IDX :
+                                                  MMU_SUPERVISOR_IDX;
+}
+
 static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 381ebe00d3..fedeba3a3f 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -25,6 +25,18 @@
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
+int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
+{
+    int ret = MMU_NOMMU_IDX;  /* mmu is disabled */
+
+    if (env->sr & (ifetch ? SR_IME : SR_DME)) {
+        /* The mmu is enabled; test supervisor state.  */
+        ret = env->sr & SR_SM ? MMU_SUPERVISOR_IDX : MMU_USER_IDX;
+    }
+
+    return ret;
+}
+
 static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index e3ad8e0c27..53f1d5c370 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -27,6 +27,15 @@
 #include "helper_regs.h"
 #include "sysemu/tcg.h"
 
+int cpu_mmu_index(CPUPPCState *env, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
+    return (env->hflags >> (ifetch ? HFLAGS_IMMU_IDX : HFLAGS_DMMU_IDX)) & 7;
+#endif
+}
+
 target_ulong cpu_read_xer(const CPUPPCState *env)
 {
     if (is_isa300(env)) {
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c7cc7eb423..ea54081130 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -33,7 +33,7 @@
 #include "debug.h"
 #include "tcg/oversized-guest.h"
 
-int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
+int cpu_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return 0;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index c5ffeffe32..b9f2bff9ce 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -26,6 +26,11 @@
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
 
+int cpu_mmu_index(CPURXState *env, bool ifetch)
+{
+    return 0;
+}
+
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
     RXCPU *cpu = RX_CPU(cs);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 6acfa1c91b..bbb0b65bee 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -43,6 +43,37 @@
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
 
+int cpu_mmu_index(CPUS390XState *env, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
+    if (!(env->psw.mask & PSW_MASK_DAT)) {
+        return MMU_REAL_IDX;
+    }
+
+    if (ifetch) {
+        if ((env->psw.mask & PSW_MASK_ASC) == PSW_ASC_HOME) {
+            return MMU_HOME_IDX;
+        }
+        return MMU_PRIMARY_IDX;
+    }
+
+    switch (env->psw.mask & PSW_MASK_ASC) {
+    case PSW_ASC_PRIMARY:
+        return MMU_PRIMARY_IDX;
+    case PSW_ASC_SECONDARY:
+        return MMU_SECONDARY_IDX;
+    case PSW_ASC_HOME:
+        return MMU_HOME_IDX;
+    case PSW_ASC_ACCREG:
+        /* Fallthrough: access register mode is not yet supported */
+    default:
+        abort();
+    }
+#endif
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool is_early_exception_psw(uint64_t mask, uint64_t addr)
 {
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 806a0ef875..e99fba7778 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -28,6 +28,19 @@
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
+int cpu_mmu_index(CPUSH4State *env, bool ifetch)
+{
+    /*
+     * The instruction in a RTE delay slot is fetched in privileged
+     * mode, but executed in user mode.
+     */
+    if (ifetch && (env->flags & TB_FLAG_DELAY_SLOT_RTE)) {
+        return 0;
+    } else {
+        return (env->sr & (1u << SR_MD)) == 0 ? 1 : 0;
+    }
+}
+
 static void superh_cpu_set_pc(CPUState *cs, vaddr value)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index befa7fc4eb..e2b1feac2f 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -29,6 +29,34 @@
 
 //#define DEBUG_FEATURES
 
+int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
+{
+#if defined(CONFIG_USER_ONLY)
+    return MMU_USER_IDX;
+#elif !defined(TARGET_SPARC64)
+    if ((env->mmuregs[0] & MMU_E) == 0) { /* MMU disabled */
+        return MMU_PHYS_IDX;
+    } else {
+        return env->psrs;
+    }
+#else
+    /* IMMU or DMMU disabled.  */
+    if (ifetch
+        ? (env->lsu & IMMU_E) == 0 || (env->pstate & PS_RED) != 0
+        : (env->lsu & DMMU_E) == 0) {
+        return MMU_PHYS_IDX;
+    } else if (cpu_hypervisor_mode(env)) {
+        return MMU_PHYS_IDX;
+    } else if (env->tl > 0) {
+        return MMU_NUCLEUS_IDX;
+    } else if (cpu_supervisor_mode(env)) {
+        return MMU_KERNEL_IDX;
+    } else {
+        return MMU_USER_IDX;
+    }
+#endif
+}
+
 static void sparc_cpu_reset_hold(Object *obj)
 {
     CPUState *s = CPU(obj);
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 8acacdf0c0..a2bb1038ff 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -24,6 +24,11 @@
 #include "qemu/error-report.h"
 #include "tcg/debug-assert.h"
 
+int cpu_mmu_index(CPUTriCoreState *env, bool ifetch)
+{
+    return 0;
+}
+
 static inline void set_feature(CPUTriCoreState *env, int feature)
 {
     env->features |= 1ULL << feature;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 99c0ca130f..7d69cef8cc 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -39,6 +39,10 @@
 #include "exec/memory.h"
 #endif
 
+int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
+{
+    return xtensa_get_cring(env);
+}
 
 static void xtensa_cpu_set_pc(CPUState *cs, vaddr value)
 {
-- 
2.34.1


