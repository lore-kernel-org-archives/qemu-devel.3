Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B80CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfD5-00016f-DC; Mon, 08 Jun 2026 15:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfD0-00014O-Nz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:27 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCy-0006t0-RV
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:26 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4864ebb6268so2891983b6e.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945223; x=1781550023; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F5VL79dCQYDC43sOTluEe9IY1Prd1AvSVeQ9o4BIfdo=;
 b=jJbgNnbbyOsdlIWTIuPMnkz4ui9WYN7rHXJgWZ1f2fOlKJEelhV9+6LuYlxwG4YPvs
 5Mqhdx6muH+CDjqO/5LkNC7RRTnD8d1Vhma4u93nKFixvJHMqR+M2ouAQT+4jrs3t2v7
 m3xKYPbgtv09I8NtWKDsWQEn+t01sLXm/wQoedOTqUXy3HANg4uDs0eDrMPCFdPA48O1
 4sWubYqJJyNAGBCB0G36PAE2twRQiJxlSVxS5gFM13MRMGLMNbRkqppevmgiOMN4wUcV
 Kwf2QjsI/4GIatFh3oXrS8Caw9uuye3Dp/WvRR4OgfMt4wmx1Mw5eP0Kk1OSC7WLbWFA
 vANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945223; x=1781550023;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F5VL79dCQYDC43sOTluEe9IY1Prd1AvSVeQ9o4BIfdo=;
 b=Qrv3KXvsNuMgf3DrbhpNQi0U9vn92MWbzl0ImH1uMS586ivCsXtHNeTtgV4vyAU3ls
 TBHW9BDLoJlENsbZfJm1+hvy8vY/pFQdZO5YJiBPW8SfFGT+m8xTsZcRo1WX40eekZ8j
 NKL1CFhPqSew/bXf9rsZeXm3Z+a0k+RIZ+nHEailzP3ygjPFyOSJWdRDvxmw4OovhOE5
 N57R5H9zL1S8XZ0eMYGbjz70A11ZRxQJyN6/vflWEi0fWXjuvRIGc6JDv1JKkl91aDnN
 ZYjhP7fjBQ0WrBEd+jJ7d8acpLUfnHh2aQHpY7WkqllM5Q9vTdIyP9hobe+ZDwtKqVyA
 JVEA==
X-Gm-Message-State: AOJu0YyG+y7RYcuQbPc+q6mgiSt0BXEWzHTjsVQJSd1/seCK0d/I9ZFv
 3rJXRy2ksrH+1J3mHkR926ZTAFrxJktA1XrTXDz5iAuPHBDx5vZYyCwqF/agt0Tg9a8=
X-Gm-Gg: Acq92OFEW5adwOpJ4FEUc2M2HVdtD6a5bfGYyH9tIgA613vkQIIk7Tj/mPl1jTriazd
 2bA6uh+owXFwASlSvDseLFas3DFcRYXwqmhbc7trnaa3+TG4lz5AwYrVLeqJP8AxQ4Wk1r9DW5n
 uIwsGmBexgesH5xv+5JLPiglD/yFJnEhVuj8anGN4x0HXKwoHJyF3T3C4zRkFz5lzxPFy9lBK6x
 +X6rSmgjJlbdaT0oJJml8RKEtZ5loF+FzjYhJYookKL0d64vgWJYkFxiwCnkygInfzrC/qyOM2d
 eNxZZhEsdyb6v7NO743lrpyJbHg/pMHBSQQ//bl01hOeZJdAABF0kHHFruRe6SMlJUu4A0IFrKP
 8NUGvfcL9RblnA1SgnrEedBpB6hrrUqPwPwaWJl/bzykThaPi84+j4rEPdPpdsSujtA3Pg27gre
 cs2yDzWoOeLD2+4EG2hKnrKkZBCWsqGcgRs8tFKVJW6rt6vGEi5WWebRA+G98D1c0782uxJJhTM
 dy153TrQkU4lNwKwTL/TjoPZFNtz709OjOE4CGt9wKjbTSEMIhHRjH9WLk14eWimhkww/1pBYq2
 pLFSL9O7dFtl9Hz/L4pMRohfHoFJMchi
X-Received: by 2002:a05:6808:13c5:b0:479:eb19:6e66 with SMTP id
 5614622812f47-4868e0e1a48mr11264176b6e.38.1780945223280; 
 Mon, 08 Jun 2026 12:00:23 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:45 -0600
Subject: [PATCH v16 20/21] target/mips: add Octeon CvmCount RDHWR support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-20-daef7a0d8b04@gmail.com>
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
In-Reply-To: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22e.google.com
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

Octeon exposes CvmCount through RDHWR register 31. Add the Octeon-only
decode path, enable the corresponding HWREna bit for linux-user, and use
an unsigned mask when checking HWREna so bit 31 is handled safely.

For user-mode emulation, return host ticks as a monotonic counter source
suitable for existing Octeon userspace code. In system mode, fall back to
the existing CP0 Count value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v5 -> v6:
  - New patch.
---
 target/mips/cpu.c                             |  1 +
 target/mips/helper.h                          |  1 +
 target/mips/tcg/op_helper.c                   | 13 ++++++++++++-
 target/mips/tcg/translate.c                   | 11 +++++++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 17 +++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b223b767c9..d72044aef6 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -320,6 +320,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     env->CP0_HWREna |= 0x0000000F;
     if (env->insn_flags & INSN_OCTEON) {
         env->CP0_HWREna |= 0x40000000u;
+        env->CP0_HWREna |= 0x80000000u;
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP)) {
         env->CP0_Status |= (1 << CP0St_CU1);
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 141350e80a..786117813a 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -255,6 +255,7 @@ DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
 DEF_HELPER_1(rdhwr_chord, tl, env)
+DEF_HELPER_1(rdhwr_cvmcount, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 3e586e3049..df1b5c3734 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -25,6 +25,7 @@
 #include "exec/memop.h"
 #include "fpu_helper.h"
 #include "qemu/crc32c.h"
+#include "qemu/timer.h"
 #include <zlib.h>
 
 static inline target_ulong bitswap(target_ulong v)
@@ -209,7 +210,7 @@ target_ulong helper_yield(CPUMIPSState *env, target_ulong arg)
 
 static inline void check_hwrena(CPUMIPSState *env, int reg, uintptr_t pc)
 {
-    if ((env->hflags & MIPS_HFLAG_CP0) || (env->CP0_HWREna & (1 << reg))) {
+    if ((env->hflags & MIPS_HFLAG_CP0) || (env->CP0_HWREna & (1u << reg))) {
         return;
     }
     do_raise_exception(env, EXCP_RI, pc);
@@ -261,6 +262,16 @@ target_ulong helper_rdhwr_chord(CPUMIPSState *env)
     return env->octeon_crypto.chord;
 }
 
+target_ulong helper_rdhwr_cvmcount(CPUMIPSState *env)
+{
+    check_hwrena(env, 31, GETPC());
+#ifdef CONFIG_USER_ONLY
+    return cpu_get_host_ticks();
+#else
+    return (uint32_t)cpu_mips_get_count(env);
+#endif
+}
+
 void helper_pmon(CPUMIPSState *env, int function)
 {
     function /= 2;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 1f44932882..e3467d1525 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -10933,6 +10933,17 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         gen_helper_rdhwr_chord(t0, tcg_env);
         gen_store_gpr(t0, rt);
         break;
+    case 31:
+        if (!(ctx->insn_flags & INSN_OCTEON)) {
+            gen_reserved_instruction(ctx);
+            break;
+        }
+        translator_io_start(&ctx->base);
+        gen_helper_rdhwr_cvmcount(t0, tcg_env);
+        gen_store_gpr(t0, rt);
+        gen_save_pc(ctx->base.pc_next + 4);
+        ctx->base.is_jmp = DISAS_EXIT;
+        break;
     default:            /* Invalid */
         MIPS_INVAL("rdhwr");
         gen_reserved_instruction(ctx);
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index f3c52d7829..6480c8532a 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -330,6 +330,22 @@ static uint64_t octeon_cop2_gfm_mul_reflect_readback(uint64_t value)
     return rd;
 }
 
+static uint64_t octeon_rdhwr31_non_decreasing(void)
+{
+    uint64_t first, second;
+
+    asm volatile(
+        ".word 0x7c08f83b\n\t" /* rdhwr $8, $31 */
+        ".word 0x7c09f83b\n\t" /* rdhwr $9, $31 */
+        "move %[first], $8\n\t"
+        "move %[second], $9\n\t"
+        : [first] "=r" (first), [second] "=r" (second)
+        :
+        : "$8", "$9");
+
+    return second >= first;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -358,6 +374,7 @@ int main(void)
                0x0123456789abcdefULL) == 0xf7b3d591e6a2c480ULL);
     assert(octeon_cop2_gfm_mul_reflect_readback(
                0xfedcba9876543210ULL) == 0x084c2a6e195d3b7fULL);
+    assert(octeon_rdhwr31_non_decreasing());
 
     return 0;
 }

-- 
2.54.0


