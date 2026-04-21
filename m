Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6812F327D4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEtM-0003rb-J1; Tue, 21 Apr 2026 13:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEt5-0003mB-Er
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:54 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEsx-0006h2-Dz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:45 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so2633154fac.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792461; x=1777397261; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jBiKGLRVWD6R5ghsdYi6NUZaIFY15k0Kx1vkOFC8LEk=;
 b=CImT+m36QKg8bnOFcmgsAEH75Nu7/P+N0225sWk5o2K5rQAYO3iBc3eHxy7ECCIIZ6
 41ou3l6msjVevST+UTIx1Rjp6JF+e8CC4NTfD/LKP35+piFYWszWFRjYUrK7XyqjVg+c
 RmnCNsUZEKv+GCgZmzHF0QllZvp75boaZQi8NKwqSBhnDOa3nVQaj3+pZoOQ3HtAfFHH
 vwQRgVZCz9MJn4ZnAq5axYRrlGXoT2HYZQUJz87yeNvH2mAn/YwDIfGC1JzdN3UGkHFN
 /P8DW7LjzLxSFaVAZITHItkY+v1KycP7wpRmEAYMwP5hAXpGkyYhyZfmjgE5QFcR5ZNR
 F7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792461; x=1777397261;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jBiKGLRVWD6R5ghsdYi6NUZaIFY15k0Kx1vkOFC8LEk=;
 b=JM8qb1zI3ul1lMwYH38b1JGhCB6RoWxhf+gYI4Yzyue2N9vlV9HtsivCGDuaQkWyh4
 khBA4CBwbisIjUAUzCDbkse5ZRZG8QjJdV7YzmnRPJ79RGNeK0b2u+G6MY6qEiurh4vl
 wHluy384xSTS/1zf5lPMWpX3FrnLNQs6RC5YQ6skwxQ1JEDeRqjCQqQtCFOQXFbmVGOb
 B5ZOuPPfnGJ6913cqno/8aeVjoVDToUnSp/8Z/BAK+nrpzcLj1N+2Q73jf2lpkgySPDz
 x+l3/Iy621pSWMx4n2UOESoWvl/Gr0vCr7y0iDIvsjtkbOoVx+GCn6OeFnv8lr+rGMOJ
 iIBw==
X-Gm-Message-State: AOJu0Yx0KbM38TuyRCCEQ1f4Ao655de145cPX3+M0llY/8X1y+QTYqvC
 7EDffs/ymiWeNjT13mCU6qbJiWH5uL0N6sN0Cs6sSqY+jNiYlrCJf8px
X-Gm-Gg: AeBDiev4Dd2BufVOLoWNO8cjpR0ZqJy4m2ouuwLXrxvoL2WjQDFE2vYQwY+YuOJxigV
 MOayh5pWUA3qLM5eUpvDKBvYgv3/IlShtxRJsCDvzg3LHAV44Mo+o9l1Eexl2SPDJXhqED1aziB
 7PI85qNnQPNEXZzprAmHtO4rrbKdQUYuB4eXG2ATL4DizqLIff/DJ46jXgTkurlZhalNUKZ7Cp3
 /BH8GHApcrWdRcqOu1eu6WVIQHzJxvWXntWTtyjHNNyPfkE1jbb/LFTn6BGvgQ3MsMN5nXUVYKQ
 XODV1JngvumEZi2enexU8rZjuCkvUbrfPzV4YNBA+76ul1pW7usFqPbkEcNxWkL1kRwKoriVIKN
 KgLKw4h+YRhvgpaJTEI560DF2OwzaJ/+gGHtdIs9lemWvoYeDvqkz2qUxpvIOkxc0syf1cW7ltf
 mJyG4cksu+LoLL7N/fkqIliYVaw4RSoTjB0ASXFPSe1C4MwLclWVvfyXB/tqm1KDO1OARZ48kNH
 9AE5S27LUi9v+pAuGOoUGPiuABliOC02GR7ih5Znwvp2CX2u2PXKlrOn3EJcxP//er/EqqSbIqa
 NiV7tQ==
X-Received: by 2002:a05:6870:8108:b0:41b:f7f5:e8a7 with SMTP id
 586e51a60fabf-42abf2ec957mr11899246fac.15.1776792460278; 
 Tue, 21 Apr 2026 10:27:40 -0700 (PDT)
Received: from mac.localdomain (97-118-149-104.hlrn.qwest.net.
 [97.118.149.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm12209290fac.0.2026.04.21.10.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:27:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 21 Apr 2026 11:27:28 -0600
Subject: [PATCH v2 01/13] linux-user/mips, target/mips: honor MIPS_FIXADE
 for unaligned accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mips-octeon-missing-insns-v2-v2-1-a0791df188c9@gmail.com>
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Linux/MIPS enables software fixups for user-mode unaligned scalar
accesses by default through MIPS_FIXADE/TIF_FIXADE. QEMU linux-user did
not model that ABI, so MIPS guests took fatal AdEL/AdES exceptions
unless translation was forced to use unaligned host accesses.

Replace the target-specific workaround with a generic MIPS linux-user
implementation:

- key MIPS translation blocks on the linux-user unaligned policy,
- implement sysmips(MIPS_FIXADE) to toggle that policy,
- raise SIGBUS/BUS_ADRALN when fixups are disabled, and
- handle the existing sysmips(MIPS_ATOMIC_SET) and MIPS_FLUSH_CACHE
  commands in the new target-side sysmips dispatcher.

This makes the default behaviour match native Linux/MIPS more closely
and keeps the signal semantics consistent with the kernel ABI without
regressing other user-mode sysmips commands.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 linux-user/mips/cpu_loop.c         |  5 ++++
 linux-user/mips/target_syscall.h   |  3 ++
 linux-user/mips64/target_syscall.h |  3 ++
 linux-user/syscall.c               | 60 ++++++++++++++++++++++++++++++++++++++
 target/mips/cpu.c                  |  8 +++--
 target/mips/cpu.h                  |  4 +++
 target/mips/tcg/translate.c        |  6 +++-
 7 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index fa264b27ec..ff9d293c29 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -161,6 +161,11 @@ done_syscall:
         case EXCP_DSPDIS:
             force_sig(TARGET_SIGILL);
             break;
+        case EXCP_AdEL:
+        case EXCP_AdES:
+            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
+                            env->CP0_BadVAddr);
+            break;
         case EXCP_INTERRUPT:
             /* just indicate that signals should be handled asap */
             break;
diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index dfcdf320b7..be6942445a 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -10,6 +10,9 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_FIXADE          7
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 9135bf5e8b..c11d0a0888 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -10,6 +10,9 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_FIXADE          7
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f4b74ad350..8671526186 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6595,6 +6595,62 @@ static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
     }
 }
 
+#ifdef TARGET_NR_sysmips
+static abi_long do_sysmips_atomic_set(CPUArchState *env, abi_ulong addr,
+                                      abi_long value)
+{
+    uint32_t *ptr;
+    abi_long old;
+
+    if (addr & 3) {
+        return -TARGET_EINVAL;
+    }
+
+    ptr = lock_user(VERIFY_WRITE, addr, sizeof(*ptr), true);
+    if (!ptr) {
+        return -TARGET_EINVAL;
+    }
+
+    old = tswap32(qatomic_xchg(ptr, tswap32((uint32_t)value)));
+    unlock_user(ptr, addr, sizeof(*ptr));
+
+    /*
+     * MIPS uses a separate error flag, but the common linux-user syscall
+     * path infers that flag from the return value.  Successful atomic_set
+     * results can overlap the target errno range, so write the result
+     * registers here and ask the CPU loop to leave them alone.
+     */
+    if ((abi_ulong)old >= (abi_ulong)-TARGET_EDQUOT) {
+        env->active_tc.gpr[2] = old;
+        env->active_tc.gpr[7] = 0;
+        return -QEMU_ESIGRETURN;
+    }
+
+    return old;
+}
+
+static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1,
+                           abi_long arg2)
+{
+    CPUState *cs = env_cpu(env);
+
+    switch (cmd) {
+    case TARGET_SYSMIPS_ATOMIC_SET:
+        return do_sysmips_atomic_set(env, arg1, arg2);
+    case TARGET_SYSMIPS_FIXADE:
+        if (arg1 & ~3) {
+            return -TARGET_EINVAL;
+        }
+        cs->prctl_unalign_sigbus = !(arg1 & 1);
+        return 0;
+    case TARGET_SYSMIPS_FLUSH_CACHE:
+        return 0;
+    default:
+        return -TARGET_EINVAL;
+    }
+}
+#endif
+
 static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
                          abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -12067,6 +12123,10 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_prctl:
         return do_prctl(cpu_env, arg1, arg2, arg3, arg4, arg5);
         break;
+#ifdef TARGET_NR_sysmips
+    case TARGET_NR_sysmips:
+        return do_sysmips(cpu_env, arg1, arg2, arg3);
+#endif
 #ifdef TARGET_NR_arch_prctl
     case TARGET_NR_arch_prctl:
         return do_arch_prctl(cpu_env, arg1, arg2);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 5f88c077db..ec70c10985 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -555,11 +555,15 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
 static TCGTBCPUState mips_get_tb_cpu_state(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
+    uint32_t flags = env->hflags & MIPS_HFLAG_TB_MASK;
+
+#ifdef CONFIG_USER_ONLY
+    flags |= TB_FLAG_UNALIGN * !cs->prctl_unalign_sigbus;
+#endif
 
     return (TCGTBCPUState){
         .pc = env->active_tc.PC,
-        .flags = env->hflags & (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK |
-                                MIPS_HFLAG_HWRENA_ULR),
+        .flags = flags,
     };
 }
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ed662135cb..ac81470576 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1161,6 +1161,10 @@ typedef struct CPUArchState {
 #define MIPS_HFLAG_ELPA  0x4000000
 #define MIPS_HFLAG_ITC_CACHE  0x8000000 /* CACHE instr. operates on ITC tag */
 #define MIPS_HFLAG_ERL   0x10000000 /* error level flag */
+#define MIPS_HFLAG_TB_MASK (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK | \
+                            MIPS_HFLAG_HWRENA_ULR)
+
+#define TB_FLAG_UNALIGN  0x40000000
     target_ulong btarget;        /* Jump / branch target               */
     target_ulong bcond;          /* Branch condition (if needed)       */
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 54849e9ff1..2e3fe1fa16 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15067,6 +15067,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUMIPSState *env = cpu_env(cs);
+    uint32_t tb_flags = ctx->base.tb->flags;
 
     ctx->page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
     ctx->saved_pc = -1;
@@ -15089,7 +15090,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->CP0_LLAddr_shift = env->CP0_LLAddr_shift;
     ctx->cmgcr = (env->CP0_Config3 >> CP0C3_CMGCR) & 1;
     /* Restore delay slot state from the tb context.  */
-    ctx->hflags = (uint32_t)ctx->base.tb->flags; /* FIXME: maybe use 64 bits? */
+    ctx->hflags = tb_flags & MIPS_HFLAG_TB_MASK;
     ctx->ulri = (env->CP0_Config3 >> CP0C3_ULRI) & 1;
     ctx->ps = ((env->active_fpu.fcr0 >> FCR0_PS) & 1) ||
              (env->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F));
@@ -15109,6 +15110,9 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->default_tcg_memop_mask = (!(ctx->insn_flags & ISA_NANOMIPS32) &&
                                   (ctx->insn_flags & (ISA_MIPS_R6 |
                                   INSN_LOONGSON3A))) ? MO_UNALN : MO_ALIGN;
+    if (tb_flags & TB_FLAG_UNALIGN) {
+        ctx->default_tcg_memop_mask = MO_UNALN;
+    }
 
     /*
      * Execute a branch and its delay slot as a single instruction.

-- 
2.53.0


