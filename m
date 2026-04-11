Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865DFE99058
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 07:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBSQn-0001ZJ-QK; Sat, 11 Apr 2026 03:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBSQl-0001Yp-HC
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:06:59 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wBSQj-0000zV-Ol
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 03:06:59 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4710c186d15so1549210b6e.3
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 00:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775891216; x=1776496016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cnzfS68vOneBH4DK2P6PB1VdCGlePSS2edUClEmVDaA=;
 b=q28/4fpoSCZMssRNVzDrx2/vJX3VvIy5fWsqhznSHZLMT68HsBb5+Qw7lLzWpBUPG2
 ML+bHvfVP97c7UNFRD5JnZW2ztR75HkfBMSm3AcI/rwfcSPoFje18sq0iV6rEqQfoIna
 4xzgS+jkhxYRVbF/m9bUihvrlX0MaSU5b0NyART2YJ88mu+cjnVHGYtT3ch8iV5EN9Y3
 Bg24AA2l2LFHP14mXPtw+/ueeXhWNk9pzOMUiJDilNmqgyjkECQsgZUNvyrnGK6cNJ+T
 UUY7x8mGcAmvvStj5WG8EDJa6Y0yIB/EFHyqW35C43Q1R/UwPVDx0Mc3/gL6fZxUt4JF
 wX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775891216; x=1776496016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnzfS68vOneBH4DK2P6PB1VdCGlePSS2edUClEmVDaA=;
 b=Uz0/WvfevNkdRFrolp+tfhxerxLvtQ9xdnWynnendJ3b2xFfioGoFCelGA3QarNqhu
 oB6U+oqc2lbmQpIsZ1rdOLm6Q1ZW6pt6j3aJL3MLwe04CsYsrJuuXV20DsPvmLqTgUR/
 Uat6/xRPN3fr/Wwbr4+WP9Ti7NOMEBYIditAsURr4eSCrXbdsxRWRbap1ltn7zlPYf7a
 b4KUqPWfmOoLfWMs+uvDQNR1nClt95mf4MCeLeopgxBjIcMMLch7QOBwoAg7NxmEc/XA
 xTas04u6VqCqbsG+Xw2mNuW3F4qbgew8XAT82gSf/hZw+pq/tfV49+k2Du5BMPW1xlEx
 hOjA==
X-Gm-Message-State: AOJu0YxZDeTtQIMuqtiStfDyjoLD4tIGZ1DjZEnPLUsaIr6AOuzZ2CaU
 9CXtePezmQCVFnztaFcwCr27X7Z5hAUWk7xwi56JbU9kp072JD3I+41ftj4dfho6CRw=
X-Gm-Gg: AeBDieuwHsgJl17mjh5E1QymdjUl7RjrPHsYryTWbwwkk5KAUKHh05eoEifdVdHGxrM
 aLlSt0Vl/MI0aL/IDVYuLWFXPvlVIEALudcUo8wsxPRMImbBw81W23lMUhPgwkmTRY9MgkiCywF
 +kZ5/oTfQrskrNEo34LfDT7UH5pgKLsRAscvuCyg2ppXcrVtzHr1f2M2PcFWWrpkVaickMOiTjl
 vNSizc7jyzSP/f/Bojz+PlKTcsQFycmyWlR2NthUDxxTX7SdeUt20v3fau/yUfLUywiUCioump8
 D5eNwWKbGdeRxDfRQwjP4IjxvIk1qW4VVzfuEx4R03JgerJeeHseIRjaVuEPm0G5aHDD8wVXOnY
 kmuREmcwr942gxwGjd45SYufXxC3GviooN4qhA8IxDi5n6RpVh55buYf836Y95Dqxp06hzYHHGu
 gnbxB5YqfsYbQ89J/jQ97AcZln5muEODM66TkrHQtbSkP03jzV3Gc8NxdABo5b5H12oKavGjWyl
 qqnDXbwDDiocCCgo6SxpZRynYanKnbpXQQFatfHobgyVnMA56rM3FuK6ncGNsnS3hRQPFE=
X-Received: by 2002:a05:6808:198c:b0:46a:7c00:5cd6 with SMTP id
 5614622812f47-478a04fd7camr3348466b6e.29.1775891215803; 
 Sat, 11 Apr 2026 00:06:55 -0700 (PDT)
Received: from Mac.localdomain (71-218-253-186.hlrn.qwest.net.
 [71.218.253.186]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a0f1e841sm2651091b6e.5.2026.04.11.00.06.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 11 Apr 2026 00:06:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 1/9] linux-user/mips,
 target/mips: honor MIPS_FIXADE for unaligned accesses
Date: Sat, 11 Apr 2026 01:06:27 -0600
Message-ID: <20260411070637.72421-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x235.google.com
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
- implement sysmips(MIPS_FIXADE) to toggle that policy, and
- raise SIGBUS/BUS_ADRALN when fixups are disabled.

This makes the default behaviour match native Linux/MIPS more closely
and keeps the signal semantics consistent with the kernel ABI.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 linux-user/mips/cpu_loop.c         |  5 +++++
 linux-user/mips/target_syscall.h   |  4 ++++
 linux-user/mips64/target_syscall.h |  4 ++++
 linux-user/syscall.c               | 24 ++++++++++++++++++++++++
 target/mips/cpu.c                  |  8 ++++++--
 target/mips/cpu.h                  |  4 ++++
 target/mips/tcg/translate.c        |  6 +++++-
 7 files changed, 52 insertions(+), 3 deletions(-)

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
index dfcdf320b7..f8dc5c4e06 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -10,6 +10,10 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_SETNAME         1
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_FIXADE          7
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 9135bf5e8b..d786fba5a9 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -10,6 +10,10 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_SETNAME         1
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_FIXADE          7
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f4b74ad350..4f58eb4afe 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6595,6 +6595,26 @@ static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
     }
 }
 
+#ifdef TARGET_NR_sysmips
+static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1)
+{
+    CPUState *cs = env_cpu(env);
+
+    switch (cmd) {
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
@@ -12067,6 +12087,10 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_prctl:
         return do_prctl(cpu_env, arg1, arg2, arg3, arg4, arg5);
         break;
+#ifdef TARGET_NR_sysmips
+    case TARGET_NR_sysmips:
+        return do_sysmips(cpu_env, arg1, arg2);
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


