Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2CCC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2ap-0000wJ-Q5; Mon, 17 Aug 2026 15:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1ww2a0-0006mT-6c
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:01:11 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1ww2Zx-0006ll-Ok
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:01:03 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-836ce6cbe1eso48592197b3.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786993260; x=1787598060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N2baksM9JrMxPQxDR9n0GKs5u4RQLJmCtvwi2YKEvp4=;
 b=PFDP45iUJigqdByHCWL661AvMw/OmI5ffKRVHAkaPZBExLHpo6e/pLI7QsaU5FZyR0
 ubX0URrsOmh2cqME+57iF+BJcAiuS7QXP0C82Lk09sQQkVZ4qrQ5VmVof+o5YgfyMR78
 lAefp3svBZTIIF0o7MeFpsgJ+zBDlq6c6eQcO0XZOQ5OXSEpiG1FzjjEIKbR2WW+PHT/
 mqHXEyJJ1ndkdZvQdfGi7zyuhDwDKm8YJVROaOC0YPJ3xebhNoa9/MA7TbedulwqN/cX
 mtTm+k/x67fTeNEtrj7Vqa/VjTVpKUU/lPF44PPWK4POGFf5Tg7MS7CQyFdmn7nTzTBP
 Q4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993260; x=1787598060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N2baksM9JrMxPQxDR9n0GKs5u4RQLJmCtvwi2YKEvp4=;
 b=BKtE83vDVKtewyzV5BQJzF2pmAZ/Bk1Ofkesa0uOuoVRGQgjTPWJUr0jIA1Vakc7R2
 AY7Sl8k/+92Z713OSbKYoUWetjhsC9ECa4KL0jqEzlwoEmXk1CjsPAbmjuphBmzJTKbD
 Euwp/WxfTPSb7m1wiWkeRUZY58aysccp75uQvsrVXK1iGEZlUWW5YPbrRgn36dCRvJIU
 oeIn++rlxxZOAQuzV4gAyA/ni1onhNIAO6TNqG1+7vKXrt4j7kVYBLU/3umeF1h5eWJG
 vrGbxD7/h90HDthPh75obBoiZZcuLdQGPBa8DMD9DA92iC2B3d0BTwz1aU1gDrOlPxL5
 na1Q==
X-Gm-Message-State: AOJu0YyQ2ZIOCD5sA4uZjmc/KaCrPR36L+OQ2gwEMB3cYuWBcFdiV3HD
 tjWFt0H5TnX+IBHw1ukpvdznXoRg4eTF7vC8jXCJnwYv8E5mU19Win81bi7oMZMHJSI=
X-Gm-Gg: AR+sD12QwvzdxYxyn58KIC5oIqg5cQevLDWLaaqClOX0+X6VPBleImYI/mDds8GEb0v
 +SAOPiaLxngdTqNf1sI50Fe3XMJNeXQNvCuOjRdMNS1Iif+JCFAN2FQZ5yJEdGk8/inCzbEaJWf
 QCbOcqFIP4ky3zGfNx2SiSg/5UkEpjzjimndVf9QRssTDww006rhBh2FB4nHXRai87luUbykT39
 tsfw3zx4jMhykIJIPThh3rTHOAAS8FpinCP+S1sQnRlPUTROVVPWbqjiW21u0rtr9dR86bVVrvh
 6Q4lhnOmHmh503Z1777sSg/Dqh0sADFcTURfE9V/iR6qqM9g5wcY4MUzvRYsrkLNaNbgkL6s/FM
 3hbWxGTVZn358bEMVcsRoxrkfLRc+scOnOVyYfz0rKZj4KRvI7LyLHYmgurP2zCIXUabq8eCYlQ
 z2XsSaZwknLSbGk7LIBN1xMoHdD+tq+uiD0YudQqHZ00l1PkicPce3u2N0gfud
X-Received: by 2002:a05:690c:4b10:b0:81c:8005:9104 with SMTP id
 00721157ae682-841325f8c28mr13314137b3.30.1786993260222; 
 Mon, 17 Aug 2026 12:01:00 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-840f3f092c4sm8661397b3.47.2026.08.17.12.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:57 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [RFC PATCH 6/8] RFC: accel/tcg: only poll for interrupts in blocks
 that can close a cycle
Date: Mon, 17 Aug 2026 15:00:36 -0400
Message-ID: <20260817190038.580257-7-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817190038.580257-1-mattst88@gmail.com>
References: <20260817190038.580257-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1135.google.com
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
index 4921bf978c..ee61dec1c6 100644
--- ./accel/tcg/translator.c
+++ ./accel/tcg/translator.c
@@ -42,12 +42,29 @@ bool translator_io_start(DisasContextBase *db)
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
@@ -73,6 +90,12 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
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
@@ -88,7 +111,8 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
 }
 
 static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
-                       TCGOp *icount_start_insn, int num_insns)
+                       TCGOp *icount_start_insn, int num_insns,
+                       DisasContextBase *db, TCGOp *first_insn_start)
 {
     if (cflags & CF_USE_ICOUNT) {
         /*
@@ -99,6 +123,23 @@ static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
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
@@ -117,6 +158,14 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
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
 #ifdef CONFIG_USER_ONLY
     /*
      * There are no page tables in user-only mode.  Every mmap, mprotect and
@@ -153,6 +202,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->max_insns = *max_insns;
     db->insn_start = NULL;
     db->fake_insn = false;
+    db->needs_exit_check = false;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
     db->record_start = 0;
@@ -219,7 +269,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
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
index a3efc56a9a..367e96627c 100644
--- ./tcg/tcg-op.c
+++ ./tcg/tcg-op.c
@@ -2616,6 +2616,7 @@ void tcg_gen_lookup_and_goto_ptr(void)
         return;
     }
 
+    tcg_ctx->exit_check_needed = true;
     plugin_gen_disable_mem_helpers();
     ptr = tcg_temp_ebb_new_ptr();
     gen_helper_lookup_tb_ptr(ptr, tcg_env);
@@ -2642,6 +2643,7 @@ void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc, uint32_t flags,
         return;
     }
 
+    tcg_ctx->exit_check_needed = true;
     plugin_gen_disable_mem_helpers();
 
     QEMU_BUILD_BUG_ON(sizeof(((CPUJumpCache *)0)->array[0]) != 16);
-- 
2.54.0


