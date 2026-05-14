Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D468ECD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa27-00025T-6l; Thu, 14 May 2026 13:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0o-0000pM-Fp
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:18 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0Z-0003ok-UN
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:11 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dd73b7c757so4717428a34.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780276; x=1779385076; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y1A496IYbHhu4AhVtkPulY0r+igz3b9SIXrIkY/qQzs=;
 b=lQnTn12IbfGl28n+YHvVX+MFzCTyY4rzF5c8ieVemqc54nVd3bNBLLc4I2rYjoX1o4
 LgeIPKTeHlu3Srp4z78lYDWIiwe48m7kg048ZGw+ogxmgMZy4wTS3LMThHvCcUeXXSSP
 kn91JoPYzM5oyg+vDogFY4zfNAThoVyBFJg3k6vRpgsEbXiKjqHVsk7HfoHHKbHUNNEz
 K1FhZyo4S94p1PJB74ftZCxtBUXYAZ38+g8gSLijeabfHS27qfn/tqTi7IANvApWRcVl
 30Szz5Lfd5QJhndYe0bnzGtvgOZKkUEQO48XJSUtR4q3wzh/9AU13YdtvEdV4e3bOVQI
 2kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780276; x=1779385076;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y1A496IYbHhu4AhVtkPulY0r+igz3b9SIXrIkY/qQzs=;
 b=OqQC6YFEZPmLVdW/HUFKiFwNy0iHdkwhIjtJaUYESX+OI88lDay25cWoAhVG78iaIZ
 n0Q6GWj2untgLbwSfBynk3pgMd26T1zJ+UR66Hw+w0PnIa19vrL+lXTkiU7QxazHw3g2
 TUZZTjjmLdpATySJzw2ai4blDBgMCry42yqowEp5hQJS2eDfIzZHO4EUmtzGN5ZbX7Wr
 cewN6jMlIH4S11q0uWXoSFEbvLISf6nv2yJDseHCx3K28HvDVMDAO4nQIvJn1mYNMNC+
 s5NgJV44ChLT6CIPWwyr2BNesQdahLazDDaj9HAGFCsL7EEk3FNVXzDf2ht9KGSBV7zk
 3hJg==
X-Gm-Message-State: AOJu0Yyo8xLx6CS3tQCUcqwTzSIPAZNaUUSl6I4vacmd8PaI8vu8OG/V
 B/8SW10dCZpwCyf4BC2A2JpsuMWqZXNmE7ZSQ7K7Jv8s7FCZm1c+syzumu/4yw==
X-Gm-Gg: Acq92OGMvaanR8/ee3dKm/mCOFpeGjx0ZWlYxl8vrcKA/AXibWoDh/T246poAUhZCQ1
 pkHGTshtB/YrcyWGp/IBjFB0ZS/r8TcOk+hTgFbOXy5DudUGDbdY+AAtePG6c2JSVbCbghokc/M
 yZSDnt7SUiPCWELYPR7dzGX6jC6jTK4bzSplvpqU//ZxjsDc+0r59YDC7xi7Umn6Hljc4mbmz1s
 OMR+WiZuoWr1AVFaAYwah7S/FDofBfWSnqjqghLxVIlhhqkGLKmZftYxn3F0JWIJYAH/K6wc7xI
 ZXYdTSM4KAoW9wkph6+YDgHsQJHGre7bnYbdRtpaGOM7yYlurBfy80iYm3Zi71uXrAsFUgzKWbi
 AC/CAtvQoXrr/1dH7F0nIASz9txmajOAWzyW6QKUfT9wWPf25donMYjmRFHXfjaZ5Pv3bVW/rvc
 mL5Y+moPSDHCRGDOiLrJfzMHDlBwW9E3C+REm7y6AUXqNrhkTER0AwxmCw/w6A+5QEPMv2bvByh
 TPU9j+1vnIXMenMvNliBb2654jNetWf9yvtW4lLvOSRhqWU/Nj9f+vTcpq89tonyPFU
X-Received: by 2002:a05:6820:8183:b0:696:2cb1:a005 with SMTP id
 006d021491bc7-69c94317db1mr265055eaf.25.1778780275829; 
 Thu, 14 May 2026 10:37:55 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:37:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:36:52 -0600
Subject: [PATCH v7 03/35] linux-user/mips, target/mips: honor MIPS_FIXADE
 for unaligned accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-3-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x334.google.com
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


