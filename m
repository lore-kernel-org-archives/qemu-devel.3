Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF8B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P9r4q/EB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrmb-0007Ih-KU; Fri, 30 Oct 2026 14:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlv-0006tC-8g
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:18 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlp-0004oo-Kq
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:13 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b10d24345dso10233567b3.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386568; x=1793991368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C7dxaNAfjYUQrUyCWYAr9IXCKFQL6v6JyafIchcWzKU=;
 b=P9r4q/EBwjApUSpSEgYKFr5sLk/ojHTn2WUU3uLoNrxWxGxQIRwzX7jRWwyZHe9T4Q
 iPB5jn43OEaQbYmmIaB8WEpQ11HCRCx1rW2pSq0NrV1JOL3O6gCEpSRlGnLjR0dZUYsl
 TVykgWDq31myRa3MC2pL1OTVLDgobARE4I8ZIC/BhoF/ZPvr/d9p6DJD5Jz94aKpol65
 yaFrPIn6Xm4qRbxjIpk8Q5dAw89NefraHv9WHDijRsXP/j9BkIaMMAO/nan2xZrt+BKi
 TY+X5pduOJ2gXNpaynbEfH6OBWo+YKTc89//wgo3H/Htb9wP4rDyOYmOFqGB1dIJx+q2
 ukaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386568; x=1793991368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C7dxaNAfjYUQrUyCWYAr9IXCKFQL6v6JyafIchcWzKU=;
 b=SUp9Z4EbXvqXEXGRRq32eUlRNEYVhEyvsEhX+B7n93APnFA/eKRQT+rZfoIW7jhN43
 W/nhV+tFIqBqBDzGy12DoHKDF4HRy22eKkCZJJstlxwYKEodJX2BYhMOeDFN1vHQPV5l
 FtPp4gPX+JrCWvzepj3mRHrq083zH0DfonbMqvtrCeU5fwhkrdbvU+0fOJOuHAHriYiF
 EUFyw4HCVc508SMNSEQhyDQhNu9B9KhNStCIc+e+TIa/PNhva+9W6Gs/YrMbwkAN24BW
 Wrcr9w6yKpotOOIE48IQrbuwBVAmB4wIms88HxZ34XxzZFOKVc1ym+j7t/A7ys8MUkme
 sEEA==
X-Gm-Message-State: AFq9FYIdWR7FoApCD/L5PcDZjK024vi6Pu13gm4Vdy6mOlYOiu++j6tY
 5pScl0FobGmP4XZiP+ZQ9ngrgIvUKU8e7herTk33uGZ5IGHD+i1I2CqR5xznuYYR3VYua7bUGM0
 A1XMc
X-Gm-Gg: AYBFou0WZPDo+XUf/kBbY/f5/e8gvB3ehakAqXQZDIWP9/em0HPG6DDrLgbeqWzWpmR
 SPfiM1RDCiCfKjdmu3ral/U87f/wV1L2NlI6pr+mEMOtBX2CuY6Wad3b+pJjATmazI8S1Pmvan/
 o1k3PKeaI4/Z6p9TBvCd0leo8dczh2bdmODqcEubsYZozT//heOkYfm90e3rmNmvWC5hvl8l7AW
 QUPbZO/L5XgYJljOF7NzljJV3DzcsmlOyzrjTQ4M03IGKXO/2KF0EacqIHQnZBM7pOhFWAY49i/
 95akU3+l+XA4gKl+VohaIzC0KBZQ0DQbI6J32CXKxzxiPaXI3yWp9S+oH42VNRYbFyELcEOy8LG
 nRJPLWSu3z9qgIv0V5d+UaO4ohdRuc4FtW2ib5sZ9CGiGtI8hYqpMjh0nooWVVbVSJeS5EOCU4X
 saEqbT4r0+UqClQKAmiGY7A7H4NNFACzQjvXsdI0+DWDD2zacj5HKnPXYRKoV56YkbYMU+bCv9C
 WAmlZOJixJf5G9oq3ReKS6LCA2c6KsPmq4dLGxrffkkTWKuKGih7w7bIns5GzWA6vjdjNb/DwO4
 eB6g0ITKIseoxoPbf7PRm3He/2pm+5eXVbE=
X-Received: by 2002:a05:690c:f05:b0:8b0:e238:271b with SMTP id
 00721157ae682-8b2b65d4897mr20749857b3.2.1793386568323; 
 Fri, 30 Oct 2026 11:56:08 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:56:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 09/14] tcg: Probe the TB jump cache inline instead of
 calling a helper
Date: Fri, 30 Oct 2026 13:55:46 -0500
Message-ID: <20261030185551.193092-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1133.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Matt Turner <mattst88@gmail.com>

Every indirect branch that cannot use goto_tb ends in a dispatch that calls
helper_lookup_tb_ptr(). For an emulated compiler that is 8.4 billion helper
calls in a single translation unit: 24.6% of all TB exits take this path,
because jsr/ret/jmp have a register destination and because goto_tb is
restricted to same-page targets.

The helper itself is already tight, but each call pays for a call frame,
the can_do_io store, the get_tb_cpu_state() indirect call through
TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to the
jump cache probe that almost always hits (95.8% for this workload).

Emit the probe inline instead, for the callers that have migrated to
tcg_gen_goto_jc_*(). Those supply what it needs: the destination PC is in a
TCG temp, and the flags, cflags and cs_base the destination must match are
constants at translation time. The fast path is therefore a hash, four
guarded loads and a goto_ptr. Only a miss calls the helper, which still owns
filling the cache.

Two details matter for the generated code. The flags and cflags guards are
folded into a single aligned 64-bit load and compare, since the fields are
adjacent. And each path emits its own goto_ptr rather than branching to a
shared one: a temp live across the label is spilled and reloaded on every
dispatch, which cost 6.3% on its own.

The flags and cflags constants are safe against the other things that can
change them. CF_PARALLEL is only ever set by begin_parallel_context(),
which flushes first, so no block predating it survives to dispatch. gdb
single-step is only turned on with the CPU stopped, and a block translated
without CF_SINGLE_STEP can only be re-entered through tb_lookup(), which
from then on demands the new cflags -- so a stale-cflags block is never the
one running. Breakpoints are handled by CF_NO_GOTO_JC, added by the previous
patch: while one is set, blocks are translated with a cflags that both keeps
them off the inline path and keeps them unreachable from blocks already on
it. What is left is one_insn_per_tb and -d nochain; see below.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO
build, on top of the preceding patches:

    before: 1,402,667,803,616 instructions
    after:    916,415,123,244 instructions   -34.67%

    before: 115.56s wall clock
    after:   85.59s wall clock               -25.94%

The gap between the two is the point at which this stops being a
straight-line win: the helper call was highly predictable work that the
host pipelined well, so removing it retires far fewer instructions than it
saves time. IPC falls from 2.48 to 2.17 across this patch for that reason.

Despite emitting more code, this also reduces instruction cache pressure,
because a dispatch no longer jumps into qemu's .text and evicts translated
code:

    before: 11,735,141,703 L1-icache-load-misses
    after:   7,154,863,292 L1-icache-load-misses   -39.0%

The mechanism is visible directly in a profile: helper_lookup_tb_ptr()
falls from 31.01% of samples to 0.35%, and qemu's own .text falls from
38.8% to 5.3%, with the balance moving into generated code.

Combined with the preceding patches, against an unmodified LTO build,
1,646,994,254,249 instructions fall to 916,415,123,244, or -44.36%. The
emulated compiler produces byte-identical output throughout.

A follow-up worth having: the probe is emitted entirely out of generic TCG
ops, and several backends can do much better than the result. x86_64 and
s390x have memory-operand comparisons; aarch64 can form env + off + h * 16
with a shift-add, load (tb, pc) and (cs_base, flags) with two ldp, and halve
the branches with ccmp. That wants a backend expansion of a dedicated
opcode, which is a separate series.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260901034808.3524945-7-mattst88@gmail.com>
---
 tcg/tcg-op.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 9 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4f3cd9f082..1b4ee6d3d9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -28,6 +28,8 @@
 #include "tcg/tcg-op-common.h"
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
+#include "hw/core/cpu.h"
+#include "../accel/tcg/tb-hash.h"
 #include "tcg-internal.h"
 #include "tcg-has.h"
 
@@ -1838,20 +1840,115 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
 }
 
+static void gen_goto_ptr(TCGTemp *ptr)
+{
+    tcg_gen_op1(INDEX_op_goto_ptr, TCG_TYPE_PTR, temp_arg(ptr));
+}
+
+static void gen_lookup_tb_ptr_and_goto(void)
+{
+    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
+
+    gen_helper_lookup_tb_ptr(ptr, tcg_env);
+    gen_goto_ptr(tcgv_ptr_temp(ptr));
+    tcg_temp_free_ptr(ptr);
+}
+
 void tcg_gen_lookup_and_goto_ptr(void)
 {
-    TCGv_ptr ptr;
-
     if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
         tcg_gen_exit_tb(NULL, 0);
-        return;
+    } else {
+        plugin_gen_disable_mem_helpers();
+        gen_lookup_tb_ptr_and_goto();
     }
+}
 
-    plugin_gen_disable_mem_helpers();
-    ptr = tcg_temp_ebb_new_ptr();
-    gen_helper_lookup_tb_ptr(ptr, tcg_env);
-    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
-    tcg_temp_free_ptr(ptr);
+static void gen_jc_hash(TCGTemp *h, TCGTemp *t, TCGTemp *pc)
+{
+#ifdef CONFIG_SOFTMMU
+    /*
+     * tb_jmp_cache_hash_func(), softmmu form.  TARGET_PAGE_BITS is a load
+     * from target_page in this translation unit, but it is decided long
+     * before any translation happens, so it is a constant here.
+     */
+    int shift = TARGET_PAGE_BITS - TB_JMP_PAGE_BITS;
+
+    tcg_gen_shri(TCG_TYPE_I64, t, pc, shift);
+    tcg_gen_xor(TCG_TYPE_I64, t, t, pc);
+    tcg_gen_shri(TCG_TYPE_I64, h, t, shift);
+    tcg_gen_andi(TCG_TYPE_I64, h, h, TB_JMP_PAGE_MASK);
+    tcg_gen_andi(TCG_TYPE_I64, t, t, TB_JMP_ADDR_MASK);
+    tcg_gen_or(TCG_TYPE_I64, h, h, t);
+#else
+    /* tb_jmp_cache_hash_func(), user-only form. */
+    tcg_gen_shri(TCG_TYPE_I64, h, pc, TB_JMP_CACHE_BITS);
+    tcg_gen_xor(TCG_TYPE_I64, h, h, pc);
+    tcg_gen_andi(TCG_TYPE_I64, h, h, TB_JMP_CACHE_SIZE - 1);
+#endif
+}
+
+static void gen_jc_probe(TCGTemp *pc, TCGTemp *cs_base, uint32_t flags)
+{
+    const TranslationBlock *tb = tcg_ctx->gen_tb;
+    g_autoptr(TCGTemp) t = tcg_temp_new_ebb(TCG_TYPE_I64);
+    g_autoptr(TCGTemp) h = tcg_temp_new_ebb(TCG_TYPE_I64);
+    g_autoptr(TCGTemp) p = tcg_temp_new_ebb(TCG_TYPE_PTR);
+    TCGLabel *slow = gen_new_label();
+    uint64_t fpair;
+
+    QEMU_BUILD_BUG_ON(sizeof_field(CPUJumpCache, array[0]) != 16);
+    QEMU_BUILD_BUG_ON(offsetof(CPUJumpCache, array[0].pc) % 8 != 0);
+    /* One 64-bit load has to cover both, so they must be adjacent... */
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, cflags) !=
+                      offsetof(TranslationBlock, flags) + 4);
+    /* ...and aligned, which nothing else currently relies on. */
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, flags) % 8 != 0);
+
+    /* p = &jc->array[tb_jmp_cache_hash_func(pc)] */
+    gen_jc_hash(h, t, pc);
+    tcg_gen_ld(TCG_TYPE_I64, t, tcgv_ptr_temp(tcg_env),
+               offsetof(CPUState, tb_jmp_cache) - sizeof(CPUState));
+    tcg_gen_lea(TCG_TYPE_I64, p, t, h, 4, 0);
+
+    /*
+     * The pc first: on a hash miss it is the field most likely to differ,
+     * and an entry whose tb is NULL has a zero pc that only pc 0 matches.
+     */
+    tcg_gen_ld(TCG_TYPE_I64, t, p, offsetof(CPUJumpCache, array[0].pc));
+    tcg_gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, pc, slow);
+
+    tcg_gen_ld(TCG_TYPE_PTR, p, p, offsetof(CPUJumpCache, array[0].tb));
+    tcg_gen_brcond(TCG_TYPE_PTR, TCG_COND_EQ,
+                   p, tcg_constant_internal(TCG_TYPE_PTR, 0), slow);
+
+    /*
+     * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
+     * and compare covers both.
+     */
+    fpair = (HOST_BIG_ENDIAN
+             ? deposit64(tb->cflags, 32, 32, flags)
+             : deposit64(flags, 32, 32, tb->cflags));
+    tcg_gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, flags));
+    tcg_gen_brcond(TCG_TYPE_I64, TCG_COND_NE,
+                   t, tcg_constant_internal(TCG_TYPE_I64, fpair), slow);
+
+    /*
+     * cs_base is a second word of target-specific flags despite the name,
+     * and the pc alone does not imply it on a target that uses it.
+     */
+    tcg_gen_ld(TCG_TYPE_I64, t, p, offsetof(TranslationBlock, cs_base));
+    tcg_gen_brcond(TCG_TYPE_I64, TCG_COND_NE, t, cs_base, slow);
+
+    tcg_gen_ld(TCG_TYPE_PTR, p, p, offsetof(TranslationBlock, tc.ptr));
+    gen_goto_ptr(p);
+
+    /*
+     * Emit a second goto_ptr rather than branching to a shared one: a temp
+     * live across the label would be spilled and reloaded on every dispatch.
+     */
+    gen_set_label(slow);
+    gen_lookup_tb_ptr_and_goto();
 }
 
 void tcg_gen_goto_jc3(TCGType type, TCGTemp *pc,
@@ -1878,7 +1975,17 @@ void tcg_gen_goto_jc3(TCGType type, TCGTemp *pc,
                              tcg_constant_i32(flags));
 #endif
 
-    tcg_gen_lookup_and_goto_ptr();
+    /*
+     * A breakpoint is the one thing the probe cannot check for itself, so
+     * while one is set the flag is set too and every dispatch takes the
+     * helper, which does check.  See tcg_update_cflags().
+     */
+    if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_JC) {
+        tcg_gen_lookup_and_goto_ptr();
+    } else {
+        plugin_gen_disable_mem_helpers();
+        gen_jc_probe(pc, cs_base, flags);
+    }
 }
 
 void tcg_gen_goto_jc(TCGType type, TCGTemp *pc)
-- 
2.53.0


