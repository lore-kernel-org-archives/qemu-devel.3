Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C88CC6B24
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGprZ-0007sP-6m; Tue, 13 Oct 2026 23:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprS-0007aX-1Q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:02 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprP-0001hj-OZ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:01 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so2730531a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949258; x=1792554058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ciuucHIAfC757XTtzVU4LFbwjQWgV0Rklb2taDxjY1Q=;
 b=fNpg5FoLxQbxE6U6gEof6JrcYqkf1fyGTHbwnoP6VCZDWsPRMsN391ioVQ24tfapk9
 Qs/+pp/8woiFJaHL3XKq5AInQJ8fgnqTfNyeE/JaPuMP3i/FwCuTVc9TCJslZzjXLvRc
 p+HaV3MrU1W74x0y6oSzxAUO+85f4Qo1pYsRHHVoREKpG7SdEqFMKLk9wytw9G1Y38A0
 CKHk3yC3TofoeNwkXlElyMY8i50eS+1tdnbhAxAM5usElBV7DGGlNmNOoYHbwdxYDdvr
 NKaOg44kS1RbKU3C9rY81MDfPmwYZuRb2r0knzp+mONMH51yG0hN9Em4YP3VydfaS2oc
 PSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949258; x=1792554058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ciuucHIAfC757XTtzVU4LFbwjQWgV0Rklb2taDxjY1Q=;
 b=hWM/eOWBmw0OWdO4GZ/j7Hom27iF16lsf8FItnkmp3BlSIcaaV3wgoqV59t3in2H7O
 kDurcHkOCLyQ7h61VNcRvX2PZIg1HIf2/bEPWX/rh0l+LW9nCqvHHmtP07UEH3rMg7qW
 4x5jk7NnNtPhDwk+WtDpGVFrOFHZo1aIF1Rw2uIE+SjINcu5060YUR/5qlEikFkdGrwf
 L5xvSBfnhOIxvb9PEMXX+j6/QfiUZAM+DdOGYEwR2YU5r4KYT3pW1sWw7UMnnM4QH+XY
 75jEWLFty4vwslYXkcG5mbbI9Ajhwa5welQkN4gQJT0Ylhg2QgacoCNNULdwbSOKQALm
 rf5A==
X-Gm-Message-State: AFq9FYJeJLcns+R7Zj1qoYeufTP3tgmhL0H/3h6+xVW15uXOPVOIqt8y
 0ea08OBBvi2UWJjtYS1XBLGiDg9avJQDQED1iNuFZv9nGO4YRpzDfpJk195FwQ==
X-Gm-Gg: AYBFou357OzXZuRPLEBoiQmtrY0nwSZMLi7T1pxkButq/QcAqk5R31TBasqZKSOjfNy
 XmDxrW7yyYQn/e4o0FNjEoKpfjPwF6f+9EfPkuL8c/vaLzDzyW4NjEJiDZ+jV5BuMkzKKACXqLp
 ONdWeu2iMy+irA3/nx0V/y+M3kV51iR+8AxXePY6O1Jdr+awFXiqoZpStxVHATh5olt3OxnupuU
 XMBKXTrFpXqmAbV1OpAivPq6rXa0ek4h1JjuAZAWSAmll+JhmePMfQoheIWBVmALO7Zlz24TvuN
 d3b0ajy3kYvF1S0B4Ltz4/4kMXubiGVRsYRbEfwvkF+y2qapnLjxBU/1okx5wIchiYLue3nUwBg
 7jr9FokVF5TCWlvKUaYuhHvxKPJY1Qrmr9bHO48l/uJEtRkEkHSoev26Z2K1TKHD3RMfQfBl7Un
 YABCwRrK2bCe8rRV1gvaQJzWj1QHS+AJfTXjdNuAxF3jGN3SK6CP7Cpz7luKa4KSIQHqwJad7UE
 mTdGnrXOZB8vTasHw==
X-Received: by 2002:a17:90b:4e8b:b0:3ab:be66:ddd3 with SMTP id
 98e67ed59e1d1-3abbe66dfa9mr5772481a91.32.1791949258124; 
 Tue, 13 Oct 2026 20:40:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 31/52] target/riscv: add sdext single-step support
Date: Wed, 14 Oct 2026 13:38:46 +1000
Message-ID: <20261014033907.3332383-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Use a TB flag when dcsr.step is set (and we are not in Debug Mode).
When the flag is on, build 1-insn TBs and do not chain to the next TB.
Add a TB-exit helper that enters Debug Mode with cause=step and sets
dpc to the next pc, then stops with EXCP_DEBUG.

If dcsr.stepie is 0, do not take interrupts while stepping. Treat WFI
as a nop so the hart does not sleep during a step.

PS: This patch references Max Chou's handling of ext_tb_flags.
https://lore.kernel.org/qemu-devel/20260108132631.9429-6-max.chou@sifive.com/

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260928195902.2045235-6-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/exec/translation-block.h |  4 ++--
 target/riscv/cpu.h               |  2 ++
 target/riscv/helper.h            |  1 +
 target/riscv/tcg/cpu_helper.c    |  6 ++++++
 target/riscv/tcg/op_helper.c     | 20 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c       |  5 +++++
 target/riscv/tcg/translate.c     | 15 +++++++++++++--
 7 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 7c42c57cca..5a7a638b08 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -64,8 +64,8 @@ struct TranslationBlock {
      * x86: the original user, the Code Segment virtual base,
      * arm: an extension of tb->flags,
      * s390x: instruction data for EXECUTE,
-     * sparc: the next pc of the instruction queue (for delay slots).
-     * riscv: an extension of tb->flags,
+     * sparc: the next pc of the instruction queue (for delay slots),
+     * riscv: an extension of tb->flags.
      */
     uint64_t cs_base;
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b0a0e5d51a..bbef354354 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -783,6 +783,8 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
 FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
 FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
+/* sdext single-step needs a TB flag to build 1-insn TBs */
+FIELD(EXT_TB_FLAGS, SDEXT_STEP, 34, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 14dd891f08..1670e7a1b2 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -142,6 +142,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
+DEF_HELPER_1(sdext_step, void, env)
 DEF_HELPER_2(sdext_ebreak, void, env, tl)
 #endif
 
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index c4d4fadf12..4e42883bd5 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -501,6 +501,12 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & mask) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
+
+        if (cpu->cfg.ext_sdext && !env->debug_mode &&
+            (env->dcsr & DCSR_STEP) && !(env->dcsr & DCSR_STEPIE)) {
+            return false;
+        }
+
         int interruptno = riscv_cpu_local_irq_pending(env);
         if (interruptno >= 0) {
             cs->exception_index = RISCV_EXCP_INT_FLAG | interruptno;
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 53e9eb445f..dc76055b80 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -526,6 +526,22 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
+void helper_sdext_step(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    CPUState *cs = env_cpu(env);
+
+    if (!riscv_cpu_cfg(env)->ext_sdext || env->debug_mode ||
+        !(env->dcsr & DCSR_STEP)) {
+        return;
+    }
+
+    riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_STEP);
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit_restore(cs, GETPC());
+#endif
+}
+
 void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
 {
     CPUState *cs = env_cpu(env);
@@ -658,6 +674,10 @@ void helper_wfi(CPURISCVState *env)
                (prv_u || (prv_s && get_field(env->hstatus, HSTATUS_VTW)))) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
     } else {
+        if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode &&
+            (env->dcsr & DCSR_STEP)) {
+            return;
+        }
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
         cpu_loop_exit(cs);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 67fbd1aac9..ae5166b13a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -196,6 +196,11 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
     ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN,
                            mo_endian_env(env) == MO_BE);
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
+        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
+    }
+#endif
 
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index cce3b6dc72..d6b1f9bfee 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -115,6 +115,8 @@ typedef struct DisasContext {
     bool ztso;
     /* Use icount trigger for native debug */
     bool itrigger;
+    /* Enter Debug Mode after next instruction (sdext single-step). */
+    bool sdext_step;
     /* FRM is known to contain a valid value. */
     bool frm_valid;
     bool insn_start_updated;
@@ -289,6 +291,9 @@ static void lookup_and_goto_ptr(DisasContext *ctx)
     if (ctx->itrigger) {
         gen_helper_itrigger_match(tcg_env);
     }
+    if (ctx->sdext_step) {
+        gen_helper_sdext_step(tcg_env);
+    }
 #endif
     tcg_gen_lookup_and_goto_ptr();
 }
@@ -299,6 +304,9 @@ static void exit_tb(DisasContext *ctx)
     if (ctx->itrigger) {
         gen_helper_itrigger_match(tcg_env);
     }
+    if (ctx->sdext_step) {
+        gen_helper_sdext_step(tcg_env);
+    }
 #endif
     tcg_gen_exit_tb(NULL, 0);
 }
@@ -312,7 +320,8 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
       * Under itrigger, instruction executes one by one like singlestep,
       * direct block chain benefits will be small.
       */
-    if (translator_use_goto_tb(&ctx->base, dest) && !ctx->itrigger) {
+    if (translator_use_goto_tb(&ctx->base, dest) &&
+        !ctx->itrigger && !ctx->sdext_step) {
         /*
          * For pcrel, the pc must always be up-to-date on entry to
          * the linked TB, so that it can use simple additions for all
@@ -1380,6 +1389,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
+    ctx->sdext_step = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, SDEXT_STEP);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
@@ -1432,7 +1442,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
     /* Only the first insn within a TB is allowed to cross a page boundary. */
     if (ctx->base.is_jmp == DISAS_NEXT) {
-        if (ctx->itrigger || !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
+        if (ctx->itrigger || ctx->sdext_step ||
+            !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
             ctx->base.is_jmp = DISAS_TOO_MANY;
         } else {
             unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;
-- 
2.55.0


