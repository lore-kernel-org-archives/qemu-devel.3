Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A55CCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgV-00014S-Nt; Wed, 20 May 2026 00:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgO-00012w-R4
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:26 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgK-0003lN-7j
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:22 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dca00c1591so1190220a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251838; x=1779856638; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y1A496IYbHhu4AhVtkPulY0r+igz3b9SIXrIkY/qQzs=;
 b=YXkbawWGLWSwG41/pOeJywj3mlWYSV/nD/KzMomFmBI16BLq24xbAuTd+AJYM9yA11
 TZbcycUwq4a/Lk2v2DTDHgYrkEt0ixaBTtzs1T3O84nRiVUm1JaUxMVmQi83EqMwTDtY
 /VlTfRTSFH9cv64r7mTkD9c1cPLmzYmdviMp8oL+mlP0vgR6LsuXy61AGXLx/ZJx4TKu
 lxfd8GTtDCuww7+y6V8NpE9xcMEGp/wa0KwJriXPSHYbHtnzCCz+GFcg5gfeKbxKCIvg
 YOhjMLvE9W9oRi3jxNRr68vbkM7WQn6rstxxZ3VRloVwE3J4HXoUoKp6y3EwfljZ/aQy
 /KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251838; x=1779856638;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y1A496IYbHhu4AhVtkPulY0r+igz3b9SIXrIkY/qQzs=;
 b=VJQSTHcp4q1FksIqKEuE6Hfj2dj5PCWbJUOph4wSqY+dYMR8aE7VdDOH3vwAJVmn/5
 Xh7b54Ha8XGFp9LxWbxf/rZeDjrC5B4TTa25mIlJ59oNkYZeIKE6fq2ojCk6WFCnsTq3
 z5kj0wAXalVvkzCd6So4Py9PtSgr2rPro4T+podIqQ8wmuM00HyvFYlX2tY0ruKKGg1p
 Nasru5K8OG5vhx1MVe5yTZvFY90S8asUBPbXuwFMC3i3VTD+dT2y1Ipgh9b9uk7R156U
 aJ4FfqAX7hOP71LB6iFKIFotMyrNQJiMmZfkRrQRk1w73ZSGiVVOGzN46LcRu6TjPmW7
 wVrg==
X-Gm-Message-State: AOJu0YxMlSMvhK5ebPm6P2w8PLWvvQiLTk6/8+J4JdhPTRI/H5ULHcY3
 Bu113zCvFHjKt0MnxvSdeRYXD5Z8OQrJ4gSHkXsviBvwxsrSftmeV3Fz
X-Gm-Gg: Acq92OFZOHzmuSXB5UdeZzUW7Gj79/DPRilfUigk/8+i7GRFrTr+WAjABiIPirCJXpW
 8Tvl5eeD9buuy9yb0m6GxYstbgchsXzbZPS7X1Mk6m042O1p7p3H+OoBlraZCWK7zW7tPn4pQtB
 vH0heYnGMVgSVRC1xM5VdcbAEJ4a/k32x0e6/X8eB6y2hBrHSdwVeNIaH4BLoK5b1vYty7CyM7x
 RP1eH845rs59EVQBKFiJjaE/gatpsWBuEvB8TtUfoELF18Oresuq4GqlYtmgob3ft10AcHyf5Sv
 5VZml3+9BOLbmfUp2OT9V1bP/rRPK/2U+bYTc9fK+q8AlAIM4oz4/6y9Drascm2MIEiIxadW4QF
 sbR01JQdJVHPlDw8VaCjZv2jQG7cFIexBpQr+iui//P5edGWTE5i85fDzLkTNVtWxh2ii/iFKES
 zRgodimJy0739e1NQctd7HCKNDQ6gijcTBpnJ6UQi4/Y/GC9/c1ia3k1eknl1v53rUWdM/e13tx
 RKGc3MF/liCFVObQ4Am3uKiYSUzyrhz0IHx+fadaW7xNpjsjcfzpEZM/E3JyBu09MAUfsxXC+Gl
 eCY=
X-Received: by 2002:a05:6830:610d:b0:7e3:d7d6:a4b7 with SMTP id
 46e09a7af769-7e4ea0319a0mr15687012a34.3.1779251837851; 
 Tue, 19 May 2026 21:37:17 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:17 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:36:57 -0600
Subject: [PATCH v10 03/45] linux-user/mips, target/mips: honor MIPS_FIXADE
 for unaligned accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-3-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32b.google.com
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
accesses by default through MIPS_FIXADE/TIF_FIXADE.  QEMU linux-user did
not model that ABI, so MIPS guests took fatal AdEL/AdES exceptions unless
translation was forced to use unaligned host accesses.

Key MIPS translation blocks on the linux-user unaligned policy, implement
sysmips(MIPS_FIXADE) to toggle that policy, and raise SIGBUS/BUS_ADRALN
when fixups are disabled.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - Replace the compact TB_FLAG_MIPS_FIXADE multiplication with an explicit
    conditional branch for readability.  (suggested by Philippe Mathieu-Daudé)

Changes v5 -> v6:
  - Rename the TB flag from TB_FLAG_UNALIGN to TB_FLAG_MIPS_FIXADE
    to match the MIPS_FIXADE ABI policy.

Changes v2 -> v3:
  - Split MIPS_FLUSH_CACHE and MIPS_ATOMIC_SET into preparatory sysmips
    patches.  (suggested by Richard Henderson)
---
 linux-user/mips/cpu_loop.c         |  5 +++++
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               |  8 ++++++++
 target/mips/cpu.c                  | 10 ++++++++--
 target/mips/cpu.h                  |  4 ++++
 target/mips/tcg/translate.c        |  6 +++++-
 7 files changed, 32 insertions(+), 3 deletions(-)

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
index 9206694f4f..be6942445a 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_FIXADE          7
 #define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index e07687f8ac..c11d0a0888 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_FIXADE          7
 #define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3786a34041..551caa8e7c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6663,9 +6663,17 @@ static abi_long do_sysmips_atomic_set(CPUArchState *env, abi_ulong addr,
 static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1,
                            abi_long arg2)
 {
+    CPUState *cs = env_cpu(env);
+
     switch (cmd) {
     case TARGET_SYSMIPS_ATOMIC_SET:
         return do_sysmips_atomic_set(env, arg1, arg2);
+    case TARGET_SYSMIPS_FIXADE:
+        if (arg1 & ~3) {
+            return -TARGET_EINVAL;
+        }
+        cs->prctl_unalign_sigbus = !(arg1 & 1);
+        return 0;
     case TARGET_SYSMIPS_FLUSH_CACHE:
         return 0;
     default:
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 88bb59d506..57935adea4 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -565,11 +565,17 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
 static TCGTBCPUState mips_get_tb_cpu_state(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
+    uint32_t flags = env->hflags & MIPS_HFLAG_TB_MASK;
+
+#ifdef CONFIG_USER_ONLY
+    if (!cs->prctl_unalign_sigbus) {
+        flags |= TB_FLAG_MIPS_FIXADE;
+    }
+#endif
 
     return (TCGTBCPUState){
         .pc = env->active_tc.PC,
-        .flags = env->hflags & (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK |
-                                MIPS_HFLAG_HWRENA_ULR),
+        .flags = flags,
     };
 }
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index cbb9b3e1b1..b478f834c1 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1161,6 +1161,10 @@ typedef struct CPUArchState {
 #define MIPS_HFLAG_ELPA  0x4000000
 #define MIPS_HFLAG_ITC_CACHE  0x8000000 /* CACHE instr. operates on ITC tag */
 #define MIPS_HFLAG_ERL   0x10000000 /* error level flag */
+#define MIPS_HFLAG_TB_MASK (MIPS_HFLAG_TMASK | MIPS_HFLAG_BMASK | \
+                            MIPS_HFLAG_HWRENA_ULR)
+
+#define TB_FLAG_MIPS_FIXADE  0x40000000
     target_ulong btarget;        /* Jump / branch target               */
     target_ulong bcond;          /* Branch condition (if needed)       */
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 54ed253a7d..dac30aff8d 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15070,6 +15070,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUMIPSState *env = cpu_env(cs);
+    uint32_t tb_flags = ctx->base.tb->flags;
 
     ctx->page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
     ctx->saved_pc = -1;
@@ -15092,7 +15093,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->CP0_LLAddr_shift = env->CP0_LLAddr_shift;
     ctx->cmgcr = (env->CP0_Config3 >> CP0C3_CMGCR) & 1;
     /* Restore delay slot state from the tb context.  */
-    ctx->hflags = (uint32_t)ctx->base.tb->flags; /* FIXME: maybe use 64 bits? */
+    ctx->hflags = tb_flags & MIPS_HFLAG_TB_MASK;
     ctx->ulri = (env->CP0_Config3 >> CP0C3_ULRI) & 1;
     ctx->ps = ((env->active_fpu.fcr0 >> FCR0_PS) & 1) ||
              (env->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F));
@@ -15112,6 +15113,9 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->default_tcg_memop_mask = (!(ctx->insn_flags & ISA_NANOMIPS32) &&
                                   (ctx->insn_flags & (ISA_MIPS_R6 |
                                   INSN_LOONGSON3A))) ? MO_UNALN : MO_ALIGN;
+    if (tb_flags & TB_FLAG_MIPS_FIXADE) {
+        ctx->default_tcg_memop_mask = MO_UNALN;
+    }
 
     /*
      * Execute a branch and its delay slot as a single instruction.

-- 
2.54.0


