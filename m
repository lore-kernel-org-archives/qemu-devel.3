Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636FBC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSGj-0005s3-5A; Thu, 27 Aug 2026 01:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGd-0005rI-H6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:03:12 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGb-0002Ju-6A
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:03:11 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-85a50f6a7f7so15272317b3.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787806988; x=1788411788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QYGTe5Dtc8jpyUVbafTGVnqH+rZmDr8bZimPftm6jiM=;
 b=Wgi3CDrLKN+MYNEmWQCQj9Zkiaz9WVweKdfwUu7qWZviuUu4WwZdCifGHt7/wABedW
 Gji42kborOuKDjjzFORmCWqnhs5Qen8/0IoHb1KYl2qmOk0UcBABm76dVrSIeV1w59Lj
 Z5AeD7Cc+VdfjNFkzFB7hJroaoJhmHp+prWFPZsJPXwd3PTi3qWc40VXm/33vsfoesfC
 awnHVtLNbQ1eA1MwdQNBwYEeoviaD18yORuiZjzqo5xGidibih41OwRIt3JKERn37Ub1
 KvDFLIZKABOtgHrLkzL3JT5HIBOBrhkR8GWwAwYbPOFLifzCP8w4eN61cTOyJcwp4ZJd
 7pCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806988; x=1788411788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QYGTe5Dtc8jpyUVbafTGVnqH+rZmDr8bZimPftm6jiM=;
 b=hUbdSQbapAbYwdNih6q5TgTuBQ2eNY84FWM1tMHk2BWR1vUqMmuSA34Sp3shEJ/Cq3
 YIYdqTHX2E8+hgfr30Z3R/uY6TTuhS2p/we2dmv9EPW51jU0D92ZeV4qHp8ANS1YpP+T
 zZ1ve0JOOLv8Qpo5qOQ9OUzSqkSzyXa0c+OX0NzoMysGzH4Jou5VU6H81IgAKOaoxnuF
 QYrWnO1hcb/piBQ0xCxHSJWnHHDc96f4pOg4RE1dmZahlyd4eBORsRSc9K5+XWUWyYst
 Ce7Ftw7oKRjlmIsSAJQxyWLFEBecZF181lhwspvOO4cW4KS+B860QbFnCUzAMkyo/G0y
 UG2A==
X-Gm-Message-State: AFuF++nlf3TFdyIOZovgSGP2hwsGPEEEcOF6Q8PNFJZ7hTGG5uAYdV1Z
 yBAMFxN7DCkcJ77lr4QdAmG+b/2CwbgrbGvEryycYkM870vvYKOfEquVhrN5Oxbc
X-Gm-Gg: AR+sD10134yIECcza7FHzo+SKpFBaXII3Lqw6d5W/vUqoWGbPruhMjsdJmsc4GDPiZ+
 4a1hU8ybTHk0Y2v2S/FBahlJUugo/2Z6UDZ8+4f8YVYWuajE/RQ0REWHzfb0s4nCCyLBi3aDU3J
 cncRLFoqsKCW/f+vzXIvE2aw/3/hLquLv84gj5CDTXrPGUgQ2sD6jpZ0zfptwQxe9gt9udj5FEz
 jjFavYBV6TpN9K5xq/eEer1qjq46bE1DQZ6Dm0kQfXTXkefUTGeCQ7nvrFaPjx4UxfLt8tC5ACZ
 krT5FOnL14CWj7Us5vuMKsgccGRNtw0rkKpn/ieCDG1zd4x31M5IvwdqiX49sn8l12zqmPWuiGG
 Gnlbme18Y+ukk89WQmPkWeaXMaa+ZWWNTovDvXZ9vksp5xGxwUoZalKG9KcT0/rvnKh6+1/pFpS
 hgwYJ6ZUUsnTNWbDif9/v95rqD5Hmdn2Atrr2MXMyNvmfk37e3AAmpkvLSD0apF/5ENh7u94hxy
 DAOEnqP3vsYQ5yW6yYVf8fjvozsbgOg7bKizzG8
X-Received: by 2002:a05:690c:4b11:b0:81e:cc9f:3dfe with SMTP id
 00721157ae682-8573c008d0bmr54581107b3.1.1787806987967; 
 Wed, 26 Aug 2026 22:03:07 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85b6143ff05sm4120317b3.32.2026.08.26.22.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:03:06 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v4 6/9] RFC: tcg: probe the TB jump cache inline instead of
 calling a helper
Date: Thu, 27 Aug 2026 01:02:38 -0400
Message-ID: <20260827050241.3713332-7-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1129.google.com
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

Every indirect branch that cannot use goto_tb ends in
tcg_gen_lookup_and_goto_ptr(), which calls helper_lookup_tb_ptr(). For an
emulated compiler that is 8.4 billion helper calls in a single translation
unit: 24.6% of all TB exits take this path, because jsr/ret/jmp have a
register destination and because goto_tb is restricted to same-page
targets.

The helper itself is already tight, but each call pays for a call frame,
the can_do_io store, the get_tb_cpu_state() indirect call through
TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to the
jump cache probe that almost always hits (95.8% for this workload).

Emit the probe inline instead. The two preceding patches supply what it
needs: the destination PC is in a TCG temp, the flags, cflags and cs_base
the destination must match are constants at translation time, and
tb_jmp_cache_probe is a base pointer the main loop can poison. The fast
path is therefore a hash, four guarded loads and a goto_ptr. Only a miss
calls the helper, which still owns filling the cache.

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
one running. What is left is one_insn_per_tb and -d nochain, which the
monitor can toggle under a running vCPU without a flush; see below.

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

Open issues, hence RFC:

- one_insn_per_tb and CPU_LOG_TB_NOCHAIN can be toggled from the monitor
  while a vCPU is inside a block that was translated without them. The
  block keeps dispatching inline with the old cflags until it exits for
  some other reason. Poisoning the probe from tcg_update_all_cflags()
  would close it.
- The jump cache entry is read without qatomic_read(); entries are
  invalidated concurrently by setting tb to NULL.
- Only alpha has been measured. The other four targets that pass a PC are
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

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 include/tcg/tcg-op-common.h |  14 ++--
 tcg/tcg-op.c                | 126 ++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 7 deletions(-)

diff --git ./include/tcg/tcg-op-common.h ./include/tcg/tcg-op-common.h
index 34102b3b7a..b8399229c9 100644
--- ./include/tcg/tcg-op-common.h
+++ ./include/tcg/tcg-op-common.h
@@ -81,13 +81,13 @@ void tcg_gen_goto_tb(unsigned idx);
  *
  * If the TB is not valid, jump to the epilogue.
  *
- * The lookup is a call to helper_lookup_tb_ptr().  @pc and @tb describe the
- * destination for a faster lookup that a later patch adds, and neither is
- * used yet.  When @pc is non-NULL it must hold exactly the value
- * get_tb_cpu_state() reports as the pc for the destination, and the
- * destination must match @tb's flags, cflags and cs_base.  A target whose
- * pc is derived rather than being that key -- avr's word address, i386's
- * eip before segmentation -- must pass NULL.
+ * The lookup is normally a call to helper_lookup_tb_ptr().  If @pc is
+ * non-NULL the jump cache is probed inline instead, and only a miss reaches
+ * the helper.  @pc must then hold exactly the value get_tb_cpu_state()
+ * reports as the pc for the destination; a target whose pc is derived
+ * (avr's word address, i386's eip before segmentation) must pass NULL.  The
+ * destination is required to match @tb's flags, cflags and cs_base, which
+ * is what makes them constants in the probe.
  *
  * This operation is optional. If the TCG backend does not implement goto_ptr,
  * this op is equivalent to calling tcg_gen_exit_tb() with 0 as the argument.
diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
index 2fda6e5c07..cf7b6882d8 100644
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
 
@@ -2715,6 +2717,112 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
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
+    /*
+     * Not cpu->tb_jmp_cache: the probe reads its own base so that the main
+     * loop can poison it, which is how conditions the probe cannot test for
+     * itself force every dispatch back into the helper.  See
+     * tcg_cpu_sync_jmp_cache().
+     */
+    tcg_gen_ld_ptr(jc, tcg_env,
+                   offsetof(CPUState, tb_jmp_cache_probe) - sizeof(CPUState));
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
+#if HOST_BIG_ENDIAN
+    fpair = ((uint64_t)tb->flags << 32) | tb->cflags;
+#else
+    fpair = ((uint64_t)tb->cflags << 32) | tb->flags;
+#endif
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
+    ptr = tcg_temp_ebb_new_ptr();
+    gen_helper_lookup_tb_ptr(ptr, tcg_env);
+    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
+}
+
 void tcg_gen_lookup_and_goto_ptr_tmp(TCGTemp *pc, const TranslationBlock *tb)
 {
     TCGv_ptr ptr;
@@ -2726,6 +2834,24 @@ void tcg_gen_lookup_and_goto_ptr_tmp(TCGTemp *pc, const TranslationBlock *tb)
 
     plugin_gen_disable_mem_helpers();
 
+    if (pc) {
+        TCGv_i64 pc64;
+
+        /*
+         * The jump cache is keyed on a vaddr, so a 32-bit guest PC is
+         * compared as its zero-extension.  The high half then folds to a
+         * constant compare against zero.
+         */
+        if (pc->type == TCG_TYPE_I32) {
+            pc64 = tcg_temp_ebb_new_i64();
+            tcg_gen_extu_i32_i64(pc64, temp_tcgv_i32(pc));
+        } else {
+            pc64 = temp_tcgv_i64(pc);
+        }
+        gen_jmp_cache_probe(pc64, tb);
+        return;
+    }
+
     ptr = tcg_temp_ebb_new_ptr();
     gen_helper_lookup_tb_ptr(ptr, tcg_env);
     tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
-- 
2.54.0


