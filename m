Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E809C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 19:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shZXt-0003Wa-K9; Fri, 23 Aug 2024 15:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXm-00032k-22
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:01:54 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXk-0004Ie-4D
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:01:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-201ed196debso21634965ad.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724439711; x=1725044511;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50q5Siv/hibhU5AFD1C36qpbeF2JrxEIUbKXBjqk5Tw=;
 b=QFDKH3X4yevJPVkIy+pHF/F60ZPFwekLl76jwWQq4f6m+0xQxYghhVO6+V4tPqtYF5
 iglissKocvnlCye6xAMZOWDjvonWPLIgzImoiunkhaSXhqLTAEP7NA0bOMMdpC62Ucmt
 LSOSiWUjxmMpMCS2nZlcbJmN3hEVVcPuzJCorK7VEiUCGbicM0b/GnfMg53PwF2Lfqep
 F5ZHob/IipAvQMOSzjlUkgnoVtRffx4lUyDwP4SLoFVroOtCr3djTjNLYqW3HukUiHg6
 rs/h8wbFrlL5doJdGjf4PUTPEX6LA+g0qCwSRBcMXq1l2a4eQTN5MBPTiwuo7x4pj+W+
 xRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724439711; x=1725044511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50q5Siv/hibhU5AFD1C36qpbeF2JrxEIUbKXBjqk5Tw=;
 b=e3ywF81Y4ZUElp5iJ38nhAnaypVNbYRvCgcrOye36b+rRN2bJssYtbEIc1214H4uSn
 PWxQBFhNaGuTWDhiU32F6g0TUBIu6aUQBR4g9TGzRRVOy1x1g7RhhPYQOGPchloCFset
 C7yfIqfwFyPBWmOpT+1+tbkmuPeBVrfMS3Dint/p+OsRKhrpErHsdqzNi89or6oBDf7g
 QuufZtyq7XXaJ7jyAO+W8c55s7fJClg6VwZTi0W9d61O8Lp5DZkCN+UlDR2U4etsd65a
 brM23XpEVK5/CKoEGAtE6lZdplh5luoVn0IcFqtZlfCP9k0Gpxtesc0N7puuRNt824BQ
 SuVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYtzoFR84quHzIeGgA7p8wK2s7+ZQD0LnkoNd16zVfbD32CMFAE1ThXo+c63lV21j7qXPrnZ9Atkjr@nongnu.org
X-Gm-Message-State: AOJu0YxgOszHtQRqKDSuDeCJU5UsG98+3F357hRW9zWmtFBzFYAk5XTc
 XtspTgJU+WOv9PNIHJz0uMLa5kLZqhW0hiH+6iUsXX0fFHqdnxySZc0KRl7uPOg=
X-Google-Smtp-Source: AGHT+IHmEbAbFmupMalwvNAGAOQ4BHKUi57TIgO1XIWAHdIYHy2RhJwkifFUtr8O6zCbx0OWPQIrnw==
X-Received: by 2002:a17:902:dace:b0:202:4666:f023 with SMTP id
 d9443c01a7336-2039e66ae45mr39517435ad.57.1724439710423; 
 Fri, 23 Aug 2024 12:01:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0c37768sm1749885ad.230.2024.08.23.12.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 12:01:50 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 richard.henderson@linaro.org, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v8 05/17] target/riscv: tracking indirect branches (fcfi) for
 zicfilp
Date: Fri, 23 Aug 2024 12:01:27 -0700
Message-ID: <20240823190140.4156920-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240823190140.4156920-1-debug@rivosinc.com>
References: <20240823190140.4156920-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x635.google.com
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
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        |  3 +++
 target/riscv/cpu_bits.h   |  3 +++
 target/riscv/cpu_helper.c | 10 ++++++++++
 target/riscv/translate.c  | 23 +++++++++++++++++++++++
 4 files changed, 39 insertions(+)

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
index 9f08a67a9e..6271b86942 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -133,6 +133,16 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
     }
 
+    if (cpu_get_fcfien(env)) {
+        /*
+         * For Forward CFI, only the expectation of a lpad at
+         * the start of the block is tracked via env->elp. env->elp
+         * is turned on during jalr translation.
+         */
+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp);
+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
+    }
+
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index acba90f170..b5c0511b4b 100644
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
@@ -1270,6 +1275,24 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     decode_opc(env, ctx, opcode16);
     ctx->base.pc_next += ctx->cur_insn_len;
 
+    /*
+     * If 'fcfi_lp_expected' is still true after processing the instruction,
+     * then we did not see an 'lpad' instruction, and must raise an exception.
+     * Insert code to raise the exception at the start of the insn; any other
+     * code the insn may have emitted will be deleted as dead code following
+     * the noreturn exception
+     */
+    if (ctx->fcfi_lp_expected) {
+        /* Emit after insn_start, i.e. before the op following insn_start. */
+        tcg_ctx->emit_before_op = QTAILQ_NEXT(ctx->base.insn_start, link);
+        tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                      tcg_env, offsetof(CPURISCVState, sw_check_code));
+        gen_helper_raise_exception(tcg_env,
+                      tcg_constant_i32(RISCV_EXCP_SW_CHECK));
+        tcg_ctx->emit_before_op = NULL;
+        ctx->base.is_jmp = DISAS_NORETURN;
+    }
+
     /* Only the first insn within a TB is allowed to cross a page boundary. */
     if (ctx->base.is_jmp == DISAS_NEXT) {
         if (ctx->itrigger || !is_same_page(&ctx->base, ctx->base.pc_next)) {
-- 
2.44.0


