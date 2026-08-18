Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2E3C5DF87
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNqS-0002x1-1m; Tue, 18 Aug 2026 13:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNqI-0002vP-H7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:18 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwNqE-0007zg-Nv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:43:18 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-836c4474028so2360547b3.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074988; x=1787679788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yl8NWho8R38WPE5uL/Y10j/MjLRNAzzDEp+FlNiwof8=;
 b=EiAVlgFrwpBLiQv8isBoRs7Yft0bGILmn0Lg4Dvzm6wOKaqZ64SMo0ErYLXAmRGxeV
 UYbgX9EqzaETjp0HytbHwSA13DX8NvxtHm47v80D9zFwOzsS53yBuGVf5Xxrxsx3AG5+
 yADm/DMRTCnmSBKqKLxi/SP4FgK6bY6uYnbL196gRlCe5TzM0s+JDwRAHD40kujRTHA0
 dKPWGU7pH0M+IF4rzckBH50AI7nJ6X1r39tIQSBojIm9mujOMExy7AU6fw1824Rh0+St
 v4Jkq2CjK7HuEYtjHInSPMmD+BoBbjIV+KoNhKi0RPaDf6xP7p4QZt/UyjvXZ2WS4hcV
 AI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074988; x=1787679788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yl8NWho8R38WPE5uL/Y10j/MjLRNAzzDEp+FlNiwof8=;
 b=ojLDBIc+tW1Rny8guaEsIdLHCbyaa72oKDnjCV2ZiAcey+O48u81O6A9tlQZkHw+Pk
 mjrM4MD4WBxjpgx2fgCmLGFiD+TuMgcQWbuds3cbK4lBko0YcRW80yXkotYoMpXOu9lX
 9o3lljGE1qys3KkoO9yjD6E7vBQV2S6FqSSBW1UVtZr9KX5ErqB0jqZbYVWDpSIXQsqR
 Sr0kWNS1S2t+jbI66ICChgzMZPovOlix1D5rqaILj8xapmOiGVZaVB+c+6k28AOtYvmH
 KOVW0D2y7DY9N/EwBfy8TfGZmLdY6ViEP3xfRXIhCNVUGJDL9ZNQJ9s3UirGDjM2j5yT
 eCTw==
X-Gm-Message-State: AOJu0YyvODLPcJKfKbddwMQvWtOD0kuP2VzXvHE8IZg5qVUeWU/uuxhX
 39bZTupKpkl8gJYBN7Gn9fmLASSDR7Jp+kuT9mgZbRQfkA8DH842/rsYeBCMtB3AFsg=
X-Gm-Gg: AR+sD13k9bE7htIpaifduaFIiL3eAvPQd2x246S8dfCLv617FPahuuQ8Yx8AAqY4eZ8
 GDnmWFxEnY2kYJEmBh9QpT9yLI0NRT0WE1j8Ntp1R61A6FMCqzbPlX0QIgI1L2mHk5KwhiFWvcc
 KBjjb6JQ1mT41LGJ7KkMGE/t4q2tPYztkj+PDCxyPqm4DdEGiUjeAnTimwlPU8C+h7Y78Ctbps2
 9btWMevGMVQSGa1EQWO00jznE1YGEIbHA1pE6D4RO5L3SQKejsOOMm8Mo39g0qLk7SfwA1VyVxh
 uJ4FxLIdo7uBrPbXstNjsPTXzfcKhgl5HZvTdxdkyaXyAqgewhOJ717yWgmnwgbJZbMkt9HQ4hj
 HAwq1ckw/ugfzBivoc3gWrmFcjLhnyHjZTKXSQlg7kVowZpOeKbrBk50Lf/I8VZwYZShxjmTbjR
 IDDc+Zl7U3QbmQO9bXjjq+d2Wo4HLB5Whyd6bO9P5ox9C1IYX8ofmK/JvnaSkU
X-Received: by 2002:a05:690c:b0b:b0:80d:f9bb:3d3c with SMTP id
 00721157ae682-837149e3da4mr116585987b3.36.1787074988059; 
 Tue, 18 Aug 2026 10:43:08 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-84068c23cb2sm25251817b3.13.2026.08.18.10.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:43:07 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 6/8] RFC: accel/tcg: only poll for interrupts in blocks that
 can close a cycle
Date: Tue, 18 Aug 2026 13:42:45 -0400
Message-ID: <20260818174247.649526-7-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818174247.649526-1-mattst88@gmail.com>
References: <20260818174247.649526-1-mattst88@gmail.com>
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

Every translation block begins by loading cpu->neg.icount_decr.u32,
testing it and branching to the exit path. That is three host instructions
at the top of every TB. Blocks are short, so this is expensive: an emulated
alpha gcc 16.2.0 compiling a 255k line translation unit executes 34.2
billion TBs at 6.04 guest instructions each. Forcing CF_NOIRQ on for the
whole run, which is not correct but bounds the prize, is worth 12.0% of all
instructions retired.

The check does not have to be in every block. Interrupt latency is bounded
as long as every cycle in the guest control flow graph passes through at
least one block that polls. Any such cycle must contain either an edge
whose destination is at or below the start of the block it leaves from, or
an edge whose destination is not known at translation time: take the block
with the lowest start address in the cycle, and the edge entering it comes
from a block at or above it.

So record, during translation, whether this TB has such an edge.
translator_use_goto_tb() already sees every statically known destination,
and every target that emits goto_tb reaches it, so a backward edge sets
DisasContextBase::needs_exit_check there. Indirect destinations are flagged
by tcg_gen_lookup_and_goto_ptr(). Blocks with neither cannot close a cycle
on their own and can skip the poll.

The check is therefore emitted retroactively in gen_tb_end(), using the
same emit_before_op mechanism the can_do_io stores use, and only when one
of the two flags is set. icount opts out and keeps the unconditional
counter.

Measured on an x86-64 host, LTO build, on top of the preceding patches:

    before: 869,178,598,378 instructions
    after:  809,988,851,304 instructions   -6.81%

    before: 80.49s wall clock
    after:  78.00s wall clock              -3.10%

That is 57% of the 12.0% ceiling, which is about right: roughly a quarter of
TB exits are indirect and are still polled, plus every loop back edge.

For the series as a whole, against an unmodified LTO build, instructions
retired fall from 1,647,901,588,726 to 809,988,851,304 (-50.85%) and wall
clock from 133.57s to 78.00s (-41.61%). The two do not match because what
the series removes is mostly cheap, well-predicted dispatch overhead: IPC
falls from 2.53 to 2.12 as the remaining work gets less regular.

tests/tcg/alpha/test-xpage-chain.c still passes, the emulated compiler still
produces byte-identical output, and a tight loop under alarm(1) is still
interrupted, after 897 million iterations.

RFC because:

- The soundness argument depends on every goto_tb destination passing
  through translator_use_goto_tb(). No target in the tree bypasses it
  today, but nothing enforces that.
- System mode interrupt latency now depends on guest control flow rather
  than on block count. The bound is one straight-line run between cycles,
  which should be fine, but timer-driven guests deserve a closer look than
  I can give them.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/translator.c    | 57 ++++++++++++++++++++++++++++++++++++---
 include/exec/translator.h |  2 ++
 include/tcg/tcg.h         |  2 ++
 tcg/tcg-op.c              |  2 ++
 4 files changed, 60 insertions(+), 3 deletions(-)

diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
index 3eab9f570d..048ad8bad2 100644
--- ./accel/tcg/translator.c
+++ ./accel/tcg/translator.c
@@ -43,12 +43,29 @@ bool translator_io_start(DisasContextBase *db)
     return true;
 }
 
+/*
+ * Any cycle in the guest control flow graph must contain an edge whose
+ * destination is at or below the start of the block it leaves from, or an
+ * edge whose destination is not known at translation time. Only blocks with
+ * such an edge need the interrupt check, so defer the decision until the end
+ * of translation, when we know which edges this TB has.
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
@@ -74,6 +91,12 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
      */
     if (cflags & CF_NOIRQ) {
         tcg_ctx->exitreq_label = NULL;
+    } else if (defer_exit_check(cflags)) {
+        /*
+         * Emitted retroactively by gen_tb_end(), but only if this TB can be
+         * part of a control flow cycle.
+         */
+        tcg_ctx->exitreq_label = gen_new_label();
     } else {
         tcg_ctx->exitreq_label = gen_new_label();
         tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
@@ -89,7 +112,8 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
 }
 
 static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
-                       TCGOp *icount_start_insn, int num_insns)
+                       TCGOp *icount_start_insn, int num_insns,
+                       DisasContextBase *db, TCGOp *first_insn_start)
 {
     if (cflags & CF_USE_ICOUNT) {
         /*
@@ -100,6 +124,23 @@ static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
                            tcgv_i32_arg(tcg_constant_i32(num_insns)));
     }
 
+    if (tcg_ctx->exitreq_label && defer_exit_check(cflags) &&
+        !(cflags & CF_NOIRQ)) {
+        if (db->needs_exit_check || tcg_ctx->exit_check_needed) {
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
@@ -129,6 +170,14 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
         return false;
     }
 
+    /*
+     * A destination at or below the start of this TB can close a cycle, so
+     * this TB must poll for interrupts.  See defer_exit_check().
+     */
+    if (dest <= db->pc_first) {
+        db->needs_exit_check = true;
+    }
+
     return translator_is_same_page(db, dest);
 }
 
@@ -152,6 +201,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->max_insns = *max_insns;
     db->insn_start = NULL;
     db->fake_insn = false;
+    db->needs_exit_check = false;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
     db->record_start = 0;
@@ -218,7 +268,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
     /* Emit code to exit the TB, as indicated by db->is_jmp.  */
     ops->tb_stop(db, cpu);
-    gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
+    gen_tb_end(tb, cflags, icount_start_insn, db->num_insns, db,
+               first_insn_start);
 
     /*
      * Manage can_do_io for the translation block: set to false before
diff --git ./include/exec/translator.h ./include/exec/translator.h
index 978dee25ad..003926c7f0 100644
--- ./include/exec/translator.h
+++ ./include/exec/translator.h
@@ -74,6 +74,8 @@ struct DisasContextBase {
     int max_insns;
     bool plugin_enabled;
     bool fake_insn;
+    /* Set when this TB can be part of a control flow cycle. */
+    bool needs_exit_check;
     uint8_t code_mmuidx;
     struct TCGOp *insn_start;
     void *host_addr[2];
diff --git ./include/tcg/tcg.h ./include/tcg/tcg.h
index 7669dc1c2d..be9ce7a0e2 100644
--- ./include/tcg/tcg.h
+++ ./include/tcg/tcg.h
@@ -389,6 +389,8 @@ struct TCGContext {
     struct TCGLabelPoolData *pool_labels;
 
     TCGLabel *exitreq_label;
+    /* Set by goto_ptr emission: destination is not known statically. */
+    bool exit_check_needed;
 
 #ifdef CONFIG_PLUGIN
     /*
diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
index ab8d101871..8282afa61a 100644
--- ./tcg/tcg-op.c
+++ ./tcg/tcg-op.c
@@ -2616,6 +2616,7 @@ void tcg_gen_lookup_and_goto_ptr(void)
         return;
     }
 
+    tcg_ctx->exit_check_needed = true;
     plugin_gen_disable_mem_helpers();
     ptr = tcg_temp_ebb_new_ptr();
     gen_helper_lookup_tb_ptr(ptr, tcg_env);
@@ -2644,6 +2645,7 @@ void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc,
         return;
     }
 
+    tcg_ctx->exit_check_needed = true;
     plugin_gen_disable_mem_helpers();
 
     QEMU_BUILD_BUG_ON(sizeof(((CPUJumpCache *)0)->array[0]) != 16);
-- 
2.54.0


