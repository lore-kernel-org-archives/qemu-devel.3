Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870BFC5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 19:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxr5B-0004BR-4H; Sat, 22 Aug 2026 15:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr59-0004Af-L3
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:43 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr57-0005mM-2c
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:43 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66c7127a73dso2388227d50.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 12:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787425720; x=1788030520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SeRu4vnI69HRB4IvNiphxPhFUxC0jRHtQT+PelOqh98=;
 b=ogkpBPFgfIFBfLy1ad3UDNJNmluJJV986Vt7X2pdKxTUEkqgQcdUMErWfcs0KtJKPU
 r1GjLPg8Rw2x8pVmmYghXp6+ZGPuS8ynbp0quZbH7g/RQO6aKRBryyN68h2AnthYdrXF
 hQlrubKA7aySrW0xW1zBCtV7bJEKaWalyKZGpXhf1lw/bVWBsGZQvCdacpLOoxssMQ6Y
 clmtudodDExSwR7BxUbcASYF31H5+PO7EljvxluIFz6I1APMULuzpRPocFvSfLFBo3fK
 8viVOITkNVVoVaWTPEW6VKR0enVTzqDcE+iwVD042L5xaAqMsGxlssg0//gQlJpEz2dL
 WMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787425720; x=1788030520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SeRu4vnI69HRB4IvNiphxPhFUxC0jRHtQT+PelOqh98=;
 b=bqXmQN17+EmKRm4HQwQWQza7m3SrfAP3hZwRdT+OkGnhxo7guVTeoAS9VcDh1TZGRJ
 MKKpMN5bP7nDRasr13+9iVRskFB9+AzhzH0RDn/f0vTh/Yp5Iw6G3PnWA3VkEoSGX1ad
 Un7MuXqRDLJDqOjsWsuXBLBDJAYfMabZ0sG7N4F3y7mCa1ynjGozPcLY/+wGpHI4VNbp
 8KU7fIoq2hbtFyjPfqb7Y0wrqj3KdF9HWs2bTep4+7fgrkCQ79AHAENH5yLKXVIaceN5
 y3qVDLAjEi8l87xywMhkoisgx70jqPDLY+RVrPbJzkYo8pBKaqJBmya4+HxHrEmNzmOh
 UIpQ==
X-Gm-Message-State: AFuF++nd0uJzpg/kgQagGxYbIvAopmefakRmM0brMlh72M8ofPvGAPUA
 UuHDAPAS0iUt74cxJywsqnZw2oKDil5RqQDL7kIdD0GS/5rAhpevwJOANaPXS3YXF6A=
X-Gm-Gg: AR+sD11BpoyDrL7rmPbY3crXL/K5PC516XgXtJd/oaSzTLw50Kcxcims72QFb1SSmvV
 TYOizJvH6jY1QDeCsD1/5bkK6Dt9qmc/uMDOeH5OzJ9a/DdTiDtSGTqrGvO28F2/6xWz9CFnhpj
 8HdsikREaqHsmgRsCZxuLBTIU2JPe+WV0vofzMBI288h+N1Dz7+2JkFMww25vDMeJ1nTTzkn13M
 IavLSHZ5+xpMhw/2hgrsVmQE1xH0p/lPganouIfu7rjnB4rjZZOIh3VICZ8g880FFObizuJY1gk
 yVssCdeJW85RYIseh0EKzHFG2FXJY0mfvhIpuDvmFilefEXMv/6uVpBc9sWqo7dhNyQZtQRZrUD
 1wM4nHAz9GyymP48pAjLHs/D9s5GOa9tdtCkJRkj86Uf70yhoQroPl3Puf5MmnhrbPNyYtCy7tC
 4bfZMv9fBvqPikH7lp5JCKEGBfB7dJvWrcbTQO/l43xMEnU8oaDK0j1YJiAOrp5XGdjKHDJEpBC
 kVnQQW5bW7s93qhZulgSoCUPhTFqO1mwi5HwjGX
X-Received: by 2002:a53:b3c3:0:b0:66c:486c:aa07 with SMTP id
 956f58d0204a3-66cf21bd42amr1757095d50.35.1787425719582; 
 Sat, 22 Aug 2026 12:08:39 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-84ca527e9basm13558207b3.5.2026.08.22.12.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:08:38 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 6/7] RFC: accel/tcg: poison the jump cache instead of
 polling for indirect exits
Date: Sat, 22 Aug 2026 15:08:17 -0400
Message-ID: <20260822190818.1829249-7-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb135.google.com
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

Every translation block begins by loading cpu->neg.icount_decr.u32, testing
it and branching to the exit path. That is three host instructions at the top
of every TB, and blocks are short: an emulated alpha gcc 16.2.0 compiling a
255k line translation unit executes 34.2 billion of them at 6.04 guest
instructions each.

A block does not need to poll if every way out of it already reaches a check.
A goto_tb does not: it chains straight into its destination, with nothing in
between that looks at icount_decr, so the destination has to poll on entry.
An indirect exit does. The out-of-line path calls helper_lookup_tb_ptr()
every time, so it only needs the helper to return the epilogue while an exit
is pending. The inline probe is already covered by the machinery the
breakpoint patch added: it reads its base pointer from
cpu->tb_jmp_cache_probe and takes the slow path when the entry it finds has a
NULL tb, so pointing that base at a page of zeroes turns every indirect
dispatch into a miss, and a miss lands in the same helper.

So a pending exit becomes one more reason for tcg_cpu_may_dispatch() to say
no. The two places that set icount_decr.u16.high poison the probe; the main
loop puts it back once the flag is clear, on the same pass that already
re-evaluates the breakpoint state. The real tb_jmp_cache is untouched
throughout, so no cache contents are lost, and the fast path pays nothing:
the base was a load from CPUState either way.

The poll is therefore emitted only in blocks that emit a goto_tb. Whether a
block does is not known until its last exit has been generated, so the
decision is deferred and the load and branch are emitted retroactively at the
head of the block in gen_tb_end(), using the same emit_before_op mechanism
the can_do_io stores use. icount opts out and keeps the counter
unconditionally.

Interrupt latency is bounded at one block, as before. It does not depend on
the shape of the guest's control flow graph: a block either polls on entry or
is checked on the way out, and no run of blocks can avoid both. What changes
is where the check sits, not how often one happens.

tests/tcg/alpha/test-indirect-irq.c is added for this: a loop whose only back
edge is an indirect branch, under alarm(1). That loop's block emits no
goto_tb, so it no longer polls, and the test passes only because the dispatch
notices instead -- it hangs if the poison is removed, which is what makes it a
test of the new mechanism rather than of the old poll. The other alpha tests
still pass and the emulated compiler still produces byte-identical output.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling the
SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO build, on
top of the preceding patches:

    before: 891,254,240,071 instructions
    after:  868,811,832,620 instructions   -2.52%

    before: 81.45s wall clock
    after:  79.85s wall clock              -1.96%

The emulated compiler produces byte-identical output.

RFC because:

- The un-poison in the main loop races a concurrent poison from another
  thread. The existing barrier around icount_decr.u16.high covers it -- a
  poison that lands after the sync also re-set the flag, and exit_request was
  stored before it -- but this deserves more eyes than the single-threaded
  user-mode testing I have given it.
- Only the inline probe needs the poison, and only alpha uses the inline
  probe today. Targets on the out-of-line path are covered by the helper
  check alone, but that has not been measured.
- The shared zero-filled CPUJumpCache is a 1MB allocation that is never
  written. A read-only mapping would express that better.

v3: Rebased onto the removal of "only poll for interrupts in blocks that can
    close a cycle", which v2 sat on top of and which is dropped: it let a
    straight-line run of arbitrary length go unchecked, since a block with no
    backward edge polled nowhere (Richard).

    The rule is now that a block polls iff it emits a goto_tb, rather than
    iff it can close a control flow cycle. That keeps the bound at one block
    without any analysis of the guest's control flow graph, so the objection
    to the dropped patch does not carry over. The deferred-emission machinery
    it needs moves here from that patch; DisasContextBase::needs_exit_check
    and the hook in translator_use_goto_tb() are gone with it, and the flag
    is now set by tcg_gen_goto_tb() rather than by goto_ptr emission.

    All of v2's measurements were dropped: they were taken with the
    cycle-analysis patch underneath, which changes both the baseline and
    what is left to remove, so none of them described this patch. The
    numbers above are a fresh measurement of the series as it now stands.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/cpu-exec.c                | 23 ++++++++++--
 accel/tcg/tcg-accel-ops.c           |  1 +
 accel/tcg/translator.c              | 51 ++++++++++++++++++++++++--
 include/hw/core/cpu.h               |  8 +++--
 include/tcg/tcg.h                   |  2 ++
 tcg/tcg-op.c                        | 13 +++++--
 tests/tcg/alpha/Makefile.target     |  3 +-
 tests/tcg/alpha/test-indirect-irq.c | 55 +++++++++++++++++++++++++++++
 8 files changed, 144 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/alpha/test-indirect-irq.c

diff --git ./accel/tcg/cpu-exec.c ./accel/tcg/cpu-exec.c
index e546f717e8..62f6984f7a 100644
--- ./accel/tcg/cpu-exec.c
+++ ./accel/tcg/cpu-exec.c
@@ -388,6 +388,16 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
      */
     cpu->neg.can_do_io = true;
 
+    /*
+     * A block that dispatches indirectly does not emit the icount_decr poll,
+     * so this is where a pending exit is noticed for that path: either the
+     * probe was poisoned and every dispatch arrives here, or the target uses
+     * the out-of-line lookup and always did.
+     */
+    if (unlikely(cpu_loop_exit_requested(cpu))) {
+        return tcg_code_gen_epilogue;
+    }
+
     TCGTBCPUState s = cpu->cc->tcg_ops->get_tb_cpu_state(cpu);
     s.cflags = curr_cflags(cpu);
 
@@ -757,8 +767,9 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
  * slow path when the entry it finds has a NULL tb.  Pointing the probe at a
  * region that is all zeroes therefore forces every indirect dispatch into
  * helper_lookup_tb_ptr(), which does the full lookup the inline probe only
- * approximates.  The real jump cache is untouched, so no contents are lost
- * and recovery is a single store.
+ * approximates and returns to the main loop while an exit is pending.  The
+ * real jump cache is untouched, so no contents are lost and recovery is a
+ * single store.
  *
  * Only ever read from, and only the tb field of one entry per dispatch, so
  * one shared zero-filled cache is enough for every CPU.
@@ -785,10 +796,13 @@ static const CPUJumpCache *tb_jmp_cache_poison(void)
  * the rest of the page.  A block translated before the breakpoint was set is
  * therefore still in the jump cache, and dispatching to it inline would step
  * straight over the breakpoint.
+ *
+ * A block that dispatches indirectly also does not emit the icount_decr
+ * poll, so the dispatch is where a pending exit has to be noticed.
  */
 static bool tcg_cpu_may_dispatch(CPUState *cpu)
 {
-    return QTAILQ_EMPTY(&cpu->breakpoints);
+    return QTAILQ_EMPTY(&cpu->breakpoints) && !cpu_loop_exit_requested(cpu);
 }
 
 /*
@@ -857,6 +871,9 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
 
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
+
+    /* Blocks that only dispatch indirectly do not poll; stop them chaining. */
+    tcg_cpu_poison_jmp_cache(cpu);
 }
 
 static inline bool icount_exit_request(CPUState *cpu)
diff --git ./accel/tcg/tcg-accel-ops.c ./accel/tcg/tcg-accel-ops.c
index 560fe2554b..9eb9e861ac 100644
--- ./accel/tcg/tcg-accel-ops.c
+++ ./accel/tcg/tcg-accel-ops.c
@@ -106,6 +106,7 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
         qemu_cpu_kick(cpu);
     } else {
         qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+        tcg_cpu_poison_jmp_cache(cpu);
     }
 }
 
diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
index 8879cd626f..89d255bd04 100644
--- ./accel/tcg/translator.c
+++ ./accel/tcg/translator.c
@@ -45,12 +45,35 @@ bool translator_io_start(DisasContextBase *db)
     return true;
 }
 
+/*
+ * A block that ends in a goto_tb chains straight to its destination: nothing
+ * between the two looks at icount_decr, so the destination has to poll on
+ * entry.  A block whose exits are all indirect does not, because the dispatch
+ * itself notices -- a pending exit poisons tb_jmp_cache_probe, so the probe
+ * misses into helper_lookup_tb_ptr(), which returns the epilogue.  Every block
+ * therefore either polls on entry or is checked as it leaves, which bounds
+ * interrupt latency at one block without looking at the shape of the guest's
+ * control flow graph.
+ *
+ * Which kind a block is is not known until its last exit has been emitted, so
+ * defer the decision to gen_tb_end() and emit the poll retroactively.
+ *
+ * icount needs the counter unconditionally, so it opts out.
+ */
+static bool defer_exit_check(uint32_t cflags)
+{
+    return !(cflags & CF_USE_ICOUNT);
+}
+
 static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
 {
     TCGv_i32 count = NULL;
     TCGOp *icount_start_insn = NULL;
 
-    if ((cflags & CF_USE_ICOUNT) || !(cflags & CF_NOIRQ)) {
+    tcg_ctx->exit_check_needed = false;
+
+    if ((cflags & CF_USE_ICOUNT) ||
+        (!(cflags & CF_NOIRQ) && !defer_exit_check(cflags))) {
         count = tcg_temp_new_i32();
         tcg_gen_ld_i32(count, tcg_env,
                        offsetof(CPUState, neg.icount_decr.u32) -
@@ -76,6 +99,9 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
      */
     if (cflags & CF_NOIRQ) {
         tcg_ctx->exitreq_label = NULL;
+    } else if (defer_exit_check(cflags)) {
+        /* Emitted retroactively by gen_tb_end(), if this TB emits a goto_tb. */
+        tcg_ctx->exitreq_label = gen_new_label();
     } else {
         tcg_ctx->exitreq_label = gen_new_label();
         tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
@@ -91,7 +117,8 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
 }
 
 static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
-                       TCGOp *icount_start_insn, int num_insns)
+                       TCGOp *icount_start_insn, int num_insns,
+                       TCGOp *first_insn_start)
 {
     if (cflags & CF_USE_ICOUNT) {
         /*
@@ -102,6 +129,23 @@ static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
                            tcgv_i32_arg(tcg_constant_i32(num_insns)));
     }
 
+    if (tcg_ctx->exitreq_label && defer_exit_check(cflags) &&
+        !(cflags & CF_NOIRQ)) {
+        if (tcg_ctx->exit_check_needed) {
+            TCGv_i32 count = tcg_temp_new_i32();
+            TCGOp *save = tcg_ctx->emit_before_op;
+
+            tcg_ctx->emit_before_op = first_insn_start;
+            tcg_gen_ld_i32(count, tcg_env,
+                           offsetof(CPUState, neg.icount_decr.u32) -
+                           sizeof(CPUState));
+            tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
+            tcg_ctx->emit_before_op = save;
+        } else {
+            tcg_ctx->exitreq_label = NULL;
+        }
+    }
+
     if (tcg_ctx->exitreq_label) {
         gen_set_label(tcg_ctx->exitreq_label);
         tcg_gen_exit_tb(tb, TB_EXIT_REQUESTED);
@@ -238,7 +282,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
     /* Emit code to exit the TB, as indicated by db->is_jmp.  */
     ops->tb_stop(db, cpu);
-    gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
+    gen_tb_end(tb, cflags, icount_start_insn, db->num_insns,
+               first_insn_start);
 
     /*
      * Manage can_do_io for the translation block: set to false before
diff --git ./include/hw/core/cpu.h ./include/hw/core/cpu.h
index bd2cdd2a0b..4272740303 100644
--- ./include/hw/core/cpu.h
+++ ./include/hw/core/cpu.h
@@ -523,9 +523,11 @@ struct CPUState {
      * @tb_jmp_cache_probe: base the inline jump cache probe reads.
      *
      * Normally @tb_jmp_cache.  Pointed at a shared page of zeroes to force
-     * every inline dispatch to miss and fall back to helper_lookup_tb_ptr();
-     * see tcg_cpu_sync_jmp_cache().  NULL before tcg_exec_realizefn() and
-     * after tcg_exec_unrealizefn().
+     * every inline dispatch to miss and fall back to helper_lookup_tb_ptr(),
+     * either because a breakpoint is set or because an exit is pending; see
+     * tcg_cpu_sync_jmp_cache().  Only generated code and the accessors in
+     * cpu-exec.c may touch it.  NULL before tcg_exec_realizefn() and after
+     * tcg_exec_unrealizefn().
      */
     struct CPUJumpCache *tb_jmp_cache_probe;
 
diff --git ./include/tcg/tcg.h ./include/tcg/tcg.h
index 7669dc1c2d..df08c10544 100644
--- ./include/tcg/tcg.h
+++ ./include/tcg/tcg.h
@@ -389,6 +389,8 @@ struct TCGContext {
     struct TCGLabelPoolData *pool_labels;
 
     TCGLabel *exitreq_label;
+    /* Set by goto_tb emission: this TB chains without reaching a check. */
+    bool exit_check_needed;
 
 #ifdef CONFIG_PLUGIN
     /*
diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
index ce77541eab..9ed04d50f3 100644
--- ./tcg/tcg-op.c
+++ ./tcg/tcg-op.c
@@ -2713,6 +2713,13 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0);
     tcg_ctx->goto_tb_issue_mask |= 1 << idx;
 #endif
+    /*
+     * A goto_tb chains straight into the destination, with nothing in between
+     * that looks at icount_decr, so this TB has to poll on entry.  See
+     * defer_exit_check().
+     */
+    tcg_ctx->exit_check_needed = true;
+
     plugin_gen_disable_mem_helpers();
     tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
 }
@@ -2801,8 +2808,10 @@ void tcg_gen_lookup_and_goto_ptr_tmp(TCGTemp *pc, const TranslationBlock *tb)
     }
 
     /*
-     * No icount_decr poll is needed for this exit: the helper is called on
-     * every dispatch and returns to the main loop while an exit is pending.
+     * No icount_decr poll is needed for this exit.  The helper returns to the
+     * main loop while an exit is pending, and a pending exit poisons
+     * tb_jmp_cache_probe, so the inline path below finds a NULL tb and falls
+     * into that same helper.
      */
     plugin_gen_disable_mem_helpers();
 
diff --git ./tests/tcg/alpha/Makefile.target ./tests/tcg/alpha/Makefile.target
index 1a3f541bec..334a088848 100644
--- ./tests/tcg/alpha/Makefile.target
+++ ./tests/tcg/alpha/Makefile.target
@@ -5,7 +5,8 @@
 ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
 VPATH+=$(ALPHA_SRC)
 
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq test-xpage-chain
+ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq test-xpage-chain \
+	test-indirect-irq
 TESTS+=$(ALPHA_TESTS)
 
 test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
diff --git ./tests/tcg/alpha/test-indirect-irq.c ./tests/tcg/alpha/test-indirect-irq.c
new file mode 100644
index 0000000000..df8eaed6e3
--- /dev/null
+++ ./tests/tcg/alpha/test-indirect-irq.c
@@ -0,0 +1,55 @@
+/*
+ * A loop whose only back edge is an indirect branch must still be
+ * interruptible.
+ *
+ * Blocks that dispatch indirectly do not emit the icount_decr poll; a pending
+ * exit instead poisons the inline jump cache probe so that the dispatch falls
+ * into helper_lookup_tb_ptr(), which returns to the main loop. If that
+ * mechanism breaks, this program never leaves the loop and the test times
+ * out rather than failing an assertion.
+ *
+ * A computed goto is used deliberately: a plain while(1) would end the block
+ * with a direct backward branch, that is a goto_tb, and a block that emits a
+ * goto_tb still polls -- so it would not exercise the path under test.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+static volatile sig_atomic_t fired;
+static volatile unsigned long iterations;
+
+static void handler(int sig)
+{
+    fired = 1;
+}
+
+int main(void)
+{
+    /*
+     * Indexing a table with a volatile index, rather than jumping through a
+     * volatile pointer: gcc happily proves a single-valued pointer constant
+     * and emits a direct branch, which is the case this test is not about.
+     */
+    void *target[2];
+    volatile int idx = 0;
+
+    assert(signal(SIGALRM, handler) != SIG_ERR);
+    alarm(1);
+
+    target[0] = &&spin;
+    target[1] = &&out;
+spin:
+    iterations++;
+    if (!fired) {
+        goto *target[idx];
+    }
+out:
+
+    printf("interrupted after %lu iterations\n", iterations);
+    return 0;
+}
-- 
2.54.0


