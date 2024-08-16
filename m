Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8FDC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRI-00014M-PK; Thu, 15 Aug 2024 21:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRA-0000ns-Bn
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:28 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selR8-0002Jc-D2
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:28 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70eaf5874ddso1281541b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770444; x=1724375244;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8cL/mDhYOffyoWzMJbqTKz+zmiU7KTw5NuRBo6of+FA=;
 b=i+1H+CqtC9J0bV1GNc+WjcBx7F/F6RyKDawNEXUCj50HjRjcfEDtEYvM113ZaysIO0
 Csr1AfQJZzzBfHgG6EYc36yk4ZiuizKV6QOkTQJFFChlg3/Upp65l+z6NpioPlEsf1Yw
 jXl+cTnnL3ivYo1Dnf2mlWKIozE6ggOQOydkZC5j0MwSJNED45+iq2ZlqA13uG3k+xgI
 ucxNAna12StrJhvNEOWtjIa8usecNp6g7e10v9PLMLJYBWZee66Z2H5RCN0nR6v3kVSv
 C9DqBb1r37bChGdPWMi5nJMiVYPMLHWepXY82TgEeMfvOTMb7syfPE1+EqDiD9k0a7Lw
 gKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770444; x=1724375244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8cL/mDhYOffyoWzMJbqTKz+zmiU7KTw5NuRBo6of+FA=;
 b=Hy1EFbCpQqUMdyKl43gasHf6SJem6t+UaA3lU0mtj3BC3pdO2aehpPuqgc82OtSbhP
 nTdJgZC+JGnZYOTkUCobQqkGuDXyOvG/3rK+stjxn+Yikjt4mH4wd9YIRPFjrLlMebcS
 gIr5Qmh1N61rswQUuGLTqZASqYTCmU4Nc2oWGL6qqCYZf0Zo8P6BjPX9+cHnh40+a/Yx
 TK6xBEqVh2Y0zPvQO+wyU13diGyYVxw/CBZkuWFDlqRAVOZ7F2+qVEwFOU0+xn50euR5
 CvM0Wdmokgdl7TD8TcaOc0vknQPkYYiLVANIjmwWniCKt++RtoCIaldro+TfeEw2UxCD
 VWQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdXSIUVi7bsfSjn++QqAQjl1lb4yOyzioenW6aMRJX2fxmYfzFTZBiGh3ONyszEIg9Ie8p4FBmlaYPYghwrxxcP7153rA=
X-Gm-Message-State: AOJu0YznY2mtFTToUV6D9H1LLnctCc3Inog7ClOiObqJhv2XqiI677bb
 6LiwUR519oun6iwApnGU3bDNuD+sIx8wEuFGBQskKfn3kiwuGAJpD9dWvRo7ZQrQwWLWbIO0WCu
 7
X-Google-Smtp-Source: AGHT+IFhwXOELtiv4JR2JumLBM+t5TNQ5W2hGyjdNSxQWgYqfDZ1dZPIimcvPowgIji9p4/xBL7zQw==
X-Received: by 2002:a05:6a00:66d9:b0:70d:37f4:2c73 with SMTP id
 d2e1a72fcca58-713c4ddc3abmr1898239b3a.10.1723770443989; 
 Thu, 15 Aug 2024 18:07:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 05/16] target/riscv: tracking indirect branches (fcfi) for
 zicfilp
Date: Thu, 15 Aug 2024 18:06:59 -0700
Message-ID: <20240816010711.3055425-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

zicfilp protects forward control flow (if enabled) by enforcing all
indirect call and jmp must land on a landing pad instruction `lpad`. If
target of an indirect call or jmp is not `lpad` then cpu/hart must raise
a sw check exception with tval = 2.

This patch implements the mechanism using TCG. Target architecture branch
instruction must define the end of a TB. Using this property, during
translation of branch instruction, TB flag = FCFI_LP_EXPECTED can be set.
Translation of target TB can check if FCFI_LP_EXPECTED flag is set and a
flag (fcfi_lp_expected) can be set in DisasContext. If `lpad` gets
translated, fcfi_lp_expected flag in DisasContext can be cleared. Else
it'll fault.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 include/tcg/tcg.h         |  1 +
 target/riscv/cpu.h        |  3 +++
 target/riscv/cpu_bits.h   |  3 +++
 target/riscv/cpu_helper.c | 12 ++++++++++++
 target/riscv/helper.h     |  3 +++
 target/riscv/op_helper.c  |  6 ++++++
 target/riscv/translate.c  | 37 +++++++++++++++++++++++++++++++++++++
 7 files changed, 65 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 21d5884741..561abc3878 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -528,6 +528,7 @@ struct TCGContext {
 #endif
 
     TCGLabel *exitreq_label;
+    TCGOp *cfi_lp_check;
 
 #ifdef CONFIG_PLUGIN
     /*
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 11c6513a90..edf540339a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -606,6 +606,9 @@ FIELD(TB_FLAGS, ITRIGGER, 22, 1)
 FIELD(TB_FLAGS, VIRT_ENABLED, 23, 1)
 FIELD(TB_FLAGS, PRIV, 24, 2)
 FIELD(TB_FLAGS, AXL, 26, 2)
+/* zicfilp needs a TB flag to track indirect branches */
+FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
+FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b05ebe6f29..900769ce60 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -685,6 +685,9 @@ typedef enum RISCVException {
     RISCV_EXCP_SEMIHOST = 0x3f,
 } RISCVException;
 
+/* zicfilp defines lp violation results in sw check with tval = 2*/
+#define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
+
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9f08a67a9e..3a56bea8b9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -133,6 +133,18 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
     }
 
+    if (cpu_get_fcfien(env)) {
+        /*
+         * For Forward CFI, only the expectation of a lpcll at
+         * the start of the block is tracked (which can only happen
+         * when FCFI is enabled for the current processor mode). A jump
+         * or call at the end of the previous TB will have updated
+         * env->elp to indicate the expectation.
+         */
+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp);
+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
+    }
+
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 451261ce5a..e946ba61fd 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -121,6 +121,9 @@ DEF_HELPER_2(cbo_clean_flush, void, env, tl)
 DEF_HELPER_2(cbo_inval, void, env, tl)
 DEF_HELPER_2(cbo_zero, void, env, tl)
 
+/* helper to raise sw check exception */
+DEF_HELPER_2(raise_sw_check_excep, void, env, tl)
+
 /* Special functions */
 DEF_HELPER_2(csrr, tl, env, int)
 DEF_HELPER_3(csrw, void, env, int, tl)
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 5848aaf437..9ec19c4afa 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -259,6 +259,12 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
     /* We don't emulate the cache-hierarchy, so we're done. */
 }
 
+void helper_raise_sw_check_excep(CPURISCVState *env, target_ulong swcheck_code)
+{
+    env->sw_check_code = swcheck_code;
+    riscv_raise_exception(env, RISCV_EXCP_SW_CHECK, GETPC());
+}
+
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index acba90f170..f1522e8b96 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -116,6 +116,9 @@ typedef struct DisasContext {
     bool frm_valid;
     bool insn_start_updated;
     const GPtrArray *decoders;
+    /* zicfilp extension. fcfi_enabled, lp expected or not */
+    bool fcfi_enabled;
+    bool fcfi_lp_expected;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1238,6 +1241,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
+    ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
+    ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
@@ -1245,6 +1250,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 {
+
 }
 
 static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
@@ -1266,6 +1272,28 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     CPURISCVState *env = cpu_env(cpu);
     uint16_t opcode16 = translator_lduw(env, &ctx->base, ctx->base.pc_next);
 
+    if (ctx->fcfi_lp_expected) {
+        /*
+         * Since we can't look ahead to confirm that the first
+         * instruction is a legal landing pad instruction, emit
+         * compare-and-branch sequence that will be fixed-up in
+         * riscv_tr_tb_stop() to either statically hit or skip an
+         * illegal instruction exception depending on whether the
+         * flag was lowered by translation of a CJLP or JLP as
+         * the first instruction in the block.
+         */
+        TCGv_i32 immediate;
+        TCGLabel *l;
+        l = gen_new_label();
+        immediate = tcg_temp_new_i32();
+        tcg_gen_movi_i32(immediate, 0);
+        tcg_ctx->cfi_lp_check = tcg_last_op();
+        tcg_gen_brcondi_i32(TCG_COND_EQ, immediate, 0, l);
+        gen_helper_raise_sw_check_excep(tcg_env,
+                tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL));
+        gen_set_label(l);
+    }
+
     ctx->ol = ctx->xl;
     decode_opc(env, ctx, opcode16);
     ctx->base.pc_next += ctx->cur_insn_len;
@@ -1303,6 +1331,15 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     default:
         g_assert_not_reached();
     }
+
+    if (ctx->fcfi_lp_expected) {
+        /*
+         * If the "lp expected" flag is still up, the block needs to take an
+         * illegal instruction exception.
+         */
+        tcg_set_insn_param(tcg_ctx->cfi_lp_check, 1,
+                           tcgv_i32_arg(tcg_constant_i32(1)));
+    }
 }
 
 static const TranslatorOps riscv_tr_ops = {
-- 
2.44.0


