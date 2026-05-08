Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E29ECD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtA-0002fX-TH; Fri, 08 May 2026 11:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMsz-0002bt-IP
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:08 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMsw-0001by-Jl
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:04 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4042905015cso1611163fac.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253181; x=1778857981; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LG3xb3bJPuwpo/t13YICuUERFJUEl2UkU1tw9cyZ50c=;
 b=FscgSS2/o9T4y8y6Z8fkocqCPKAMqZveE00QJhwBO0L/dS4bxwP4EfDAVfmbSa6mzc
 w9XafP+UfcU2WzoIjHmUcul67fzDSWVuRujAHtDjW/qdoLuniS7SZ5yLOkPHOqIjUpLL
 Dar4xyH/guryVf5X9hUK0oT7lhyxjJ/Rm6qAL5aI0+LVzeRDlsyAHTmErgxhAGMttM13
 Po/D6VqsUv4Th2YByvkut2OZLZ/DzBArehscUp7vON4SCNRoJso2VgNeHjNbPo12A3cu
 VzwFmP2cDNE1GwNbwwmWQw296LGm3yIPH1jzsH/RzNxw/MYACHVd8Ie/KUeZkyjv0dtK
 YgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253181; x=1778857981;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LG3xb3bJPuwpo/t13YICuUERFJUEl2UkU1tw9cyZ50c=;
 b=oW7jbDNZu5YFUTy1ZrguLo1kKPzkB0iQVoeolFrhsWahtd6ulBJS+0JEl23keRHAqa
 s9O7m65dVS/f31QOdLzhE6j7Y0b9ryAcPsMH+vsqvHZ7Hp4OJAjZViUu6MXd1UhcFfkj
 w3/0zuZpgSlP1IBsMLUlbSv9CIOGTrYWUtuVE0mSchNXC/D2KVk5jzRbz/cinE5Yx+7T
 jhIFno2pzRzsEAxBFuwwsHhIdaZCZ565GbPdNIjFrFJ8MdkELe5E4jEPiIeImonw/Bo1
 bLdEz8H0laGwnUdWYxn5adpgZyg4UyuENE6mNBj59hq4NbF8ELBsR/5FZOyv1R3+BKFC
 Ighg==
X-Gm-Message-State: AOJu0Yx9q49NpkwIUn2kR6FZLvnkrJ+3awuakzN7ONLL6C3TerVYcgQX
 bwto12G3DoqYhZP6MwPFf6BdWXmHk7Ay0ElSvAX6Of13lHVmwqOBgFoHJ7TRXQ==
X-Gm-Gg: Acq92OGe781TiQNLEd0c8uOJE76bQX4pS7f7OUffISRW1MyG8DhiKdFsvjUjW4vjdKK
 PTcYPP+cegPdJReGF/xhEWWSKRK3lPR3S6ZVaykvbxCPQg0S91WbUWexcIgXwFJIVwxmkoQi3E4
 1fANZscYGFaer1H13UyEYMNE1eW0MsWw0HpvrYAcWbW8ctum8e/VbAU/RV7hFDu89OoNi63r0gN
 TkJFJetbfuZ7nYqIu7NCyUF+Igtsg7XvEYRDPtHBF1oRiepGv61W70KGUBv5OIxDqEFI9KLnmae
 fcwjdFBg2W5lNO4F96dhJtaYm5Fd6W3Kiu3IyIHp2Ns/z/XZeVNDPTcze4ecdOutO+6wab0j4iV
 hWqaxiRGcY4ruC/zV8QhOT7uxtdNJ0z0bqFfWUJmGatG82L3NyvGZHVTLn7XRV939SzZIAPr8a2
 IKu4fxIXSVObnGrXquAGgn1Xjiif3E5oxUlRPycnErd8p3BxWxgEczKdDfNlSC39Oc38m5ltpsK
 pUsM1ULnblLIlmo1qxvY+K1en1Io7juYJTqor5PoRNxsTMgzFIBcPjTa/L9GR8WtiRzAOpeWz65
 bhLwFTGXGeEjaKugbZJhMD84cfObb89a6uH/ObGfyJxHOnqodCTDA8aH0KVPeL4vt2xSSoLSMcK
 Egl0dJA==
X-Received: by 2002:a05:6870:c2a2:b0:42c:61b:28e5 with SMTP id
 586e51a60fabf-434f64e942fmr8551273fac.19.1778253181074; 
 Fri, 08 May 2026 08:13:01 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:03 -0600
Subject: [PATCH v3 03/32] linux-user/mips, target/mips: honor MIPS_FIXADE
 for unaligned accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-3-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x36.google.com
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

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MIPS_FLUSH_CACHE and MIPS_ATOMIC_SET into preparatory sysmips
    patches.  (suggested by Richard Henderson)
---
 linux-user/mips/cpu_loop.c         | 5 +++++
 linux-user/mips/target_syscall.h   | 1 +
 linux-user/mips64/target_syscall.h | 1 +
 linux-user/syscall.c               | 8 ++++++++
 target/mips/cpu.c                  | 8 ++++++--
 target/mips/cpu.h                  | 4 ++++
 target/mips/tcg/translate.c        | 6 +++++-
 7 files changed, 30 insertions(+), 3 deletions(-)

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
index f803d47763..19001d829c 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -565,11 +565,15 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
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
index cbb9b3e1b1..84d12b77f9 100644
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
index 54ed253a7d..cd6dc34176 100644
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
+    if (tb_flags & TB_FLAG_UNALIGN) {
+        ctx->default_tcg_memop_mask = MO_UNALN;
+    }
 
     /*
      * Execute a branch and its delay slot as a single instruction.

-- 
2.54.0


