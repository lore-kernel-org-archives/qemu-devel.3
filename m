Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A2ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkdy-0003oV-NL; Wed, 20 May 2026 13:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkdw-0003mZ-6n
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:40 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkdu-0003SD-8R
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:39 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so3201099f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297816; x=1779902616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwbeX9Gjy/xYaojYr56HIgP75nu+77FS6S64lDOm+r8=;
 b=EpbSssXGph2eBPXio6EACL14WaZV4csP2OTgPp/L2kpMk0rALXyp81M3xKjjKocjjW
 rxr1wH/i7i0v5cZpGjxCOLleIW+6TZVlg0TEc3Uo2CaytfxF5uo7rX9kChHJnRweS3rS
 bn6Q9MnENEGjDc459GbQvMpUcUj+Xc6zzoUzMIXuLUveJ88mx4IwwXvqaKT4LrPaMFQT
 /BYGnp5+3U7st2DrT4F8A3GBm4pAJPDlf8mV7PYzkewP27tuWdPEYq7Z6+wzjNViBFEr
 23vOJpvrS/c+NqPGtJdXAnJ4Oullu1ga5QNe0MgZyguq6PQ3M4jk2mvNax9AWeaP84Nq
 RRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297816; x=1779902616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xwbeX9Gjy/xYaojYr56HIgP75nu+77FS6S64lDOm+r8=;
 b=Jh/J0jTIrZcBOWr81SMKrEeneeTcelPA/ouGoNuO0NCb/bJrui7rZVa59fBzUgzijS
 OR4h57MCXyiopcUCvOq6CUnwuI3kkUNFUIdZNNboU+zg0y0U+NW5OQ1mMJj7vnsPkyfC
 hN/6XIEo03mpN6ZQ80O2NQcOA1YJvAVhuqTCE5WIlFDFQs/99efAZJD1TpXRcCKXOzBG
 T6v9Tql5m3+dF4dx/z/UeNZclRkwjyM5qvingvBVdvTTk8Ty9/9kr6KjUXGUtH1n49pa
 kaLnwYzxXbONgVt5wWEZ+tk5+27jufvA7RIWgvIeGB4RWSnCi8PQrFrIxWNGp+dCZ3O1
 Ct0g==
X-Gm-Message-State: AOJu0YzUBJbH44j/e70PFJ9O9viI0/7WiDszQrgd1l2H/YX66DKr0vy1
 hmkweaMJmHa2pTpr8Yy0In6n0ouFCqHjqW2iI60wVrFp5IHKrSekclrSLZ2buHBJ1HGdHKSCwJl
 N3i+I+bI=
X-Gm-Gg: Acq92OG5/yNVVH3CLpF/Ssjyv1/eljaCivtEXqfh3B+FKO4rdTMz4ss4gxE3q2k4MFM
 HQq5H0FFnD3E6Z6gKHUHg1/KtwhixWB6wpilO9dp3+9YPAQg8p8w5CD4UXFkQ2UDcl7XGh3vilz
 FZGa07M0ROLQAaGh2ibVM6B5z4uH59sr9iTdjyp4O+aO1uJPwiz0si00KUePjoypcDAvJ03JRD8
 iCMRcK46Rm6t2764dqxtZdYPVQxY1hTBkTtXQhS4x9eWe3yPnysVe5DR0xKIO66wMbMq78j+4PW
 uPn6oskq6nuTt/pz+8/4b9TqDb9LzrLG1cSH6ywwTG+mqB8KHoBK7feDaPkwckWK00mmKxDTM+w
 SfS+IfXZ3fqQejc3lAt6cvdeMA06nMVT1XENA/ZqlpRiItFqPnAG2TBiIEJ17K9/L/ZGaD1ZvZ9
 G3H3oQp4uLMlvaa7FqVbwvNcQnMv+GjiCEtIwnAhe6XLXHXhDkh8F0PO1CVIVhpEcBRscPkGky
X-Received: by 2002:a05:6000:26c4:b0:45c:3f0b:be08 with SMTP id
 ffacd0b85a97d-45e5c5e2db1mr42208713f8f.23.1779297816264; 
 Wed, 20 May 2026 10:23:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19b1dsm55047977f8f.17.2026.05.20.10.23.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:23:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 03/24] linux-user/mips,
 target/mips: honor MIPS_FIXADE for unaligned accesses
Date: Wed, 20 May 2026 19:22:51 +0200
Message-ID: <20260520172313.23777-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: James Hilliard <james.hilliard1@gmail.com>

Linux/MIPS enables software fixups for user-mode unaligned scalar
accesses by default through MIPS_FIXADE/TIF_FIXADE.  QEMU linux-user did
not model that ABI, so MIPS guests took fatal AdEL/AdES exceptions unless
translation was forced to use unaligned host accesses.

Key MIPS translation blocks on the linux-user unaligned policy, implement
sysmips(MIPS_FIXADE) to toggle that policy, and raise SIGBUS/BUS_ADRALN
when fixups are disabled.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 target/mips/cpu.h                  |  4 ++++
 linux-user/mips/cpu_loop.c         |  5 +++++
 linux-user/syscall.c               |  8 ++++++++
 target/mips/cpu.c                  | 10 ++++++++--
 target/mips/tcg/translate.c        |  6 +++++-
 7 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 9206694f4fb..be6942445a2 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_FIXADE          7
 #define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index e07687f8ac9..c11d0a08888 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_FIXADE          7
 #define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index cbb9b3e1b1c..b478f834c13 100644
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
 
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index fa264b27ec5..ff9d293c296 100644
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
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3df42aa159d..7d7a7b489cf 100644
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
index 88bb59d506b..57935adea4b 100644
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
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 54ed253a7d0..dac30aff8d3 100644
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
2.53.0


