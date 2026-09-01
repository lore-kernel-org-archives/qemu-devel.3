Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B23C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FUa-0000cX-3g; Mon, 31 Aug 2026 23:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUY-0000bw-FD
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:58 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUW-0004Lr-85
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:58 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66dee7a0c09so3083649d50.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 20:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788234535; x=1788839335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hU417OCLlkLOavVulyBQtQTYsid7DrkibHmsCfBSBuo=;
 b=QfQ/gVTwJlYcrQrkbZ9r805kweEjnTCsUtZfnNBvtxAGLFlStP6h4y1SgThhHWLm6K
 0x+l6qspvSNd3BjFp2Jfy826AokF2ks2jIqWNxFHWhL5PIlGzSxEeL72YZZUOBTKRMB7
 bD5uau8ZV985RmSmRZyzn/TX92ADlmVjwhtl+J1cLkVBGMUgE4i3srYfj9e9CX4UfNIZ
 xoH16AOZ5F0U2e099IHfgqxcO2JTzsE/arZDubxw08tsn900RWR9J0AOWp2WVRr65f+N
 WGQrNtD46//WAepOVx48QCODSTvjbI/IqpTJmQj5bLcQw8eAyjy99WabhiZPGbAVnSPt
 gyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788234535; x=1788839335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hU417OCLlkLOavVulyBQtQTYsid7DrkibHmsCfBSBuo=;
 b=DYimtegxmxqqN2FI5CKhW6zXrKxzqP5eCEBTit8ywopFeYArma43jkUNcTLwOvqiTl
 xyexGPqMVXgP104J6yxwcOiPAZrq/fFuD364CuAbsVBpkX0Ks1hW3LXy+8nUZHnPXWnP
 D9V8nkM2T0KCFtqoVOc72eSY3dNjTHqoQsrnacCYZp6FupSM3sg7g3CqWT2pnqwzYcWm
 yMhqtd0zCOwHpsJHa4dAEA2RnICIj2G4b2EC0uLVg4Ci/g8dVdoX+WK69b/S/L5csZNS
 s2T/HtBNm2x/G+QcwzJmBsNax8BS4ZwVcd9zvjty9P/AZWDO06ZkwtY39ooUkYXf/iqP
 A6AA==
X-Gm-Message-State: AFuF++mySejQDEIfMH3Du6wUXfNgD4QB42V8E2eOL9wocp1GpmVVJh4Y
 AraAj+2xH4E4LAU8O+N+Fjg96r9rghclQX36bFGnxXZtTFBaZobUQCWNLA5h9A==
X-Gm-Gg: AYBFou28rhRHv444XNOuMWryA30S5P8hbfvTQ3pBsAeAi2LsiRJl1+lxZZ9k0S2WkfA
 PZtOiZUl49n5YdPOdKSbERLw3uH2NFALvEXWhjbOQOtrTMxghxJyvjrdZtxN1g7hXFxvEK8oZiy
 XB9loH0kDoG4SKD6Hp4MJV7L61pdtpbl6z6YuMbTrycyl/4b9KVAIoVRmCJhyz9y+3ryyjfS7Rw
 GVyWHFrr9ZuCcuNot/W6SkOaIH0AQJOsrGDCrOw87m9tp+KOedInBHGWiS4TkmxsEic/H2BTzKB
 z9VyFVd7Ipp6fOZ77zPMzn5u8EzMPl+IYfG4p2emnDkYtYe1SqMDc4tHtqa7SpgtiNb5TXhhq2t
 3AOSOoNW+nu45pOUNpNDCrGgbWne2ouRxh1ZTeyxL9GOJRY7MjzXWHbcLV/kixGrir9L6ofQIUj
 lopbN/kpNujIxKgE2nFrUdpAuLPo0VSOU0MHhh/C+kTY5E+WyffJhksxAILaYz2mUDmBm+O/0as
 RpCQOIFcyLJuScoOTsVtHd4sBzWwqbiggPMjnAR
X-Received: by 2002:a05:690e:1589:10b0:66c:bd06:e89b with SMTP id
 956f58d0204a3-66e4c746d23mr7671577d50.32.1788234534859; 
 Mon, 31 Aug 2026 20:48:54 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66e4ed2a78bsm7444135d50.20.2026.08.31.20.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 20:48:54 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 6/9] RFC: tcg: probe the TB jump cache inline instead of
 calling a helper
Date: Mon, 31 Aug 2026 23:48:05 -0400
Message-ID: <20260901034808.3524945-7-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901034808.3524945-1-mattst88@gmail.com>
References: <20260827050241.3713332-1-mattst88@gmail.com>
 <20260901034808.3524945-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb130.google.com
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

Open issues, hence RFC:

- one_insn_per_tb and CPU_LOG_TB_NOCHAIN can be toggled from the monitor
  while a vCPU is inside a block that was translated without them. The
  block keeps dispatching inline on the old cflags until it exits for some
  other reason. This is the same window goto_tb chaining already has, since
  a chained direct jump consults nothing either, but it is worth saying out
  loud.
- The jump cache entry is read without qatomic_read(); entries are
  invalidated concurrently by setting tb to NULL.
- Only alpha has been measured. The other four targets that use goto_jc are
  built and boot-tested only.

v4: Split out of the patch that also changed the
    tcg_gen_lookup_and_goto_ptr() API and introduced tb_jmp_cache_probe,
    which are now the two preceding patches. Requested by Richard
    Henderson.

v4: Emit the softmmu form of tb_jmp_cache_hash_func() under
    CONFIG_SOFTMMU rather than the user-only form everywhere. v3 emitted
    the user-only hash unconditionally, which was wrong for system mode
    and was only not a correctness bug because a wrong index simply
    misses. Caught by Richard Henderson. tcg-op.c is compiled once per
    build rather than once per target, but CONFIG_SOFTMMU is set for it,
    and TARGET_PAGE_BITS -- a load from target_page here -- is fixed long
    before any translation happens.

v4: Compare the pc before testing tb for NULL. On a hash miss the pc is
    the field most likely to differ, and an unused entry has a zero pc
    that only pc 0 can match, so the tb test buys nothing ahead of it.
    Suggested by Richard Henderson.

v4: Assert that offsetof(TranslationBlock, flags) is 8-byte aligned, since
    folding the flags and cflags guards into one 64-bit load relies on it
    and nothing else does. Requested by Richard Henderson.

v4: Zero-extend a 32-bit guest PC instead of falling back to the helper.
    Suggested by Richard Henderson. The high half then folds to a compare
    against zero.

v4: Describe cs_base in the probe as a second word of target-specific
    flags rather than by name. Suggested by Richard Henderson.

v5: Build the folded flags/cflags constant with deposit64() rather than
    under #if HOST_BIG_ENDIAN, so both arms compile on every host.
    Requested by Richard Henderson.

v5: Read cpu->tb_jmp_cache directly, and honor CF_NO_GOTO_JC rather than a
    poisoned base pointer, which is no longer how breakpoints are handled.
    A separate base pointer comes back later in the series for pending
    exits.

v5: Note the backend expansion this wants as a follow-up. Suggested by
    Richard Henderson, whose list it is.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 include/tcg/tcg-op-common.h |   3 +-
 tcg/tcg-op.c                | 110 +++++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 2 deletions(-)

diff --git ./include/tcg/tcg-op-common.h ./include/tcg/tcg-op-common.h
index 4f334faaaa..f41f3ee58f 100644
--- ./include/tcg/tcg-op-common.h
+++ ./include/tcg/tcg-op-common.h
@@ -91,7 +91,8 @@ void tcg_gen_lookup_and_goto_ptr(void);
  * @pc: temp holding the destination guest PC
  *
  * As tcg_gen_lookup_and_goto_ptr(), but the caller states where the
- * dispatch is going, which allows the lookup to be done inline.
+ * dispatch is going, so the TB jump cache is probed inline and only a miss
+ * reaches helper_lookup_tb_ptr().
  *
  * The contract is that when this runs, the CPU state must already be
  * exactly the destination's: @pc must hold what get_tb_cpu_state() would
diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
index a2f35359fe..b10b2d66d5 100644
--- ./tcg/tcg-op.c
+++ ./tcg/tcg-op.c
@@ -28,6 +28,8 @@
 #include "tcg/tcg-op-common.h"
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
+#include "hw/core/cpu.h"
+#include "../accel/tcg/tb-hash.h"
 #include "tcg-internal.h"
 #include "tcg-has.h"
 
@@ -2735,6 +2737,102 @@ void tcg_gen_lookup_and_goto_ptr(void)
     gen_lookup_tb_ptr_and_goto();
 }
 
+static void gen_jmp_cache_hash(TCGv_i64 h, TCGv_i64 pc)
+{
+#ifdef CONFIG_SOFTMMU
+    /*
+     * tb_jmp_cache_hash_func(), softmmu form.  TARGET_PAGE_BITS is a load
+     * from target_page in this translation unit, but it is decided long
+     * before any translation happens, so it is a constant here.
+     */
+    int shift = TARGET_PAGE_BITS - TB_JMP_PAGE_BITS;
+    TCGv_i64 tmp = tcg_temp_ebb_new_i64();
+
+    tcg_gen_shri_i64(tmp, pc, shift);
+    tcg_gen_xor_i64(tmp, tmp, pc);
+    tcg_gen_shri_i64(h, tmp, shift);
+    tcg_gen_andi_i64(h, h, TB_JMP_PAGE_MASK);
+    tcg_gen_andi_i64(tmp, tmp, TB_JMP_ADDR_MASK);
+    tcg_gen_or_i64(h, h, tmp);
+    tcg_temp_free_i64(tmp);
+#else
+    /* tb_jmp_cache_hash_func(), user-only form. */
+    tcg_gen_shri_i64(h, pc, TB_JMP_CACHE_BITS);
+    tcg_gen_xor_i64(h, h, pc);
+    tcg_gen_andi_i64(h, h, TB_JMP_CACHE_SIZE - 1);
+#endif
+}
+
+static void gen_jmp_cache_probe(TCGv_i64 pc, const TranslationBlock *tb)
+{
+    TCGv_ptr jc, ent, tbp, ptr;
+    TCGv_i64 h, tmp;
+    TCGLabel *slow;
+    uint64_t fpair;
+
+    QEMU_BUILD_BUG_ON(sizeof(((CPUJumpCache *)0)->array[0]) != 16);
+    QEMU_BUILD_BUG_ON(offsetof(CPUJumpCache, array[0].pc) % 8 != 0);
+    /* One 64-bit load has to cover both, so they must be adjacent... */
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, cflags) !=
+                      offsetof(TranslationBlock, flags) + 4);
+    /* ...and aligned, which nothing else currently relies on. */
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, flags) % 8 != 0);
+
+    jc = tcg_temp_ebb_new_ptr();
+    ent = tcg_temp_ebb_new_ptr();
+    tbp = tcg_temp_ebb_new_ptr();
+    ptr = tcg_temp_ebb_new_ptr();
+    h = tcg_temp_ebb_new_i64();
+    tmp = tcg_temp_ebb_new_i64();
+    slow = gen_new_label();
+
+    /* ent = &jc->array[tb_jmp_cache_hash_func(pc)] */
+    gen_jmp_cache_hash(h, pc);
+    tcg_gen_shli_i64(h, h, 4);
+
+    tcg_gen_ld_ptr(jc, tcg_env,
+                   offsetof(CPUState, tb_jmp_cache) - sizeof(CPUState));
+    tcg_gen_trunc_i64_ptr(ent, h);
+    tcg_gen_add_ptr(ent, jc, ent);
+
+    /*
+     * The pc first: on a hash miss it is the field most likely to differ,
+     * and an entry whose tb is NULL has a zero pc that only pc 0 matches.
+     */
+    tcg_gen_ld_i64(tmp, ent, offsetof(CPUJumpCache, array[0].pc));
+    tcg_gen_brcond_i64(TCG_COND_NE, tmp, pc, slow);
+
+    tcg_gen_ld_ptr(tbp, ent, offsetof(CPUJumpCache, array[0].tb));
+    tcg_gen_brcondi_ptr(TCG_COND_EQ, tbp, 0, slow);
+
+    /*
+     * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
+     * and compare covers both.
+     */
+    fpair = (HOST_BIG_ENDIAN
+             ? deposit64(tb->cflags, 32, 32, tb->flags)
+             : deposit64(tb->flags, 32, 32, tb->cflags));
+    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, flags));
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, fpair, slow);
+
+    /*
+     * cs_base is a second word of target-specific flags despite the name,
+     * and the pc alone does not imply it on a target that uses it.
+     */
+    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, cs_base));
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, tb->cs_base, slow);
+
+    tcg_gen_ld_ptr(ptr, tbp, offsetof(TranslationBlock, tc.ptr));
+    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
+
+    /*
+     * Emit a second goto_ptr rather than branching to a shared one: a temp
+     * live across the label would be spilled and reloaded on every dispatch.
+     */
+    gen_set_label(slow);
+    gen_lookup_tb_ptr_and_goto();
+}
+
 /*
  * The common half of tcg_gen_goto_jc_i32() and tcg_gen_goto_jc_i64().  @pc
  * is widened to i64 because the jump cache is keyed on a vaddr; for a
@@ -2761,7 +2859,17 @@ static void gen_goto_jc(TCGv_i64 pc)
                              tcg_constant_i64(tb->cs_base));
 #endif
 
-    gen_lookup_tb_ptr_and_goto();
+    /*
+     * A breakpoint is the one thing the probe cannot check for itself, so
+     * while one is set the flag is set too and every dispatch takes the
+     * helper, which does check.  See tcg_update_cflags().
+     */
+    if (tb->cflags & CF_NO_GOTO_JC) {
+        gen_lookup_tb_ptr_and_goto();
+        return;
+    }
+
+    gen_jmp_cache_probe(pc, tb);
 }
 
 void tcg_gen_goto_jc_i64(TCGv_i64 pc)
-- 
2.54.0


