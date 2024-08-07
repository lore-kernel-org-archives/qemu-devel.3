Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A585C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUDF-0003ci-RN; Tue, 06 Aug 2024 20:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCr-0002d6-FK
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCp-00018n-01
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fd69e44596so2816725ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989224; x=1723594024;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDtCL9tVQImt/zx5S+6XoLO3l79YnLS0xiTRQ/sdwI0=;
 b=nuGA1zYhjm1FUATiOUiBDPCMy0wvdj1btM1a2E1Bdx9KCbk0NW1a5O8JtReFMaYjhU
 lrVzE7nvuHYBYuc6Hoxp3bMo7zG92na3Ih3KYhJ81jm+dKWL+rQa34tYsna1Vt6T9FaM
 N/CqpE6h3lgis4fp0m8UcbAwOQGv/wogTWe2PT3UqpbfHL3xMl0JLFA65CmvEKzvHtfO
 oR+V/rceH9p5S84AxCFAk24HZ3rhXbekUwzXzk3VlfcWWpVbgqp7KAfL3LO0iAsNJq/O
 kd8vPggJoNFsxYtIp+2Crcf99VF+XNRFfs0IX8llpVPidtcDnTgVHE6JcO9/BTQacGjK
 WZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989224; x=1723594024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDtCL9tVQImt/zx5S+6XoLO3l79YnLS0xiTRQ/sdwI0=;
 b=E0Gkx5b93mLzcRhsMc26IOvzOKE1gULlSPBf+ki9Yl0mG83mQJPYjbm/MKzDCKVKDe
 6Cjwiry6LD1iVaBg3Sh+ZVMA7r5B1fO++lVFaSRuxy0nHik7pvugsi9mkB2W/2dCOFui
 U+3hd/cfJnbYWMoXn8VqBx9kbwmOmBPoWSZNv3Vk8wGP0XFvs2Fuq0xZmhGEkxcRWo3Y
 nMlUqlB6NnVcL6jSMU/+WVUamWvkComK7swT6sPlB3BTx7TUoxkQ9szwc8xypKLl0Zq4
 DtN9gYf3TVTn2BnMLTjSndu6Mycdswiq79hoTXCo3RxUsdeGlLTe4Rl+qD+Pt5/cnQd2
 S/GQ==
X-Gm-Message-State: AOJu0YzKRRhskv1ovdgUVJCCRtVSBBncG9Wzo3FIx6xZk185RrazMFbZ
 JWnSS8GzqSP5RrStoRwvEj73/GYJgLYvDRGs+sOaRH78lTyisKlXp9IDXz2mOe68qA8ybg0L3Fr
 F
X-Google-Smtp-Source: AGHT+IGgewC76ZOS2WEyUpXDXx3UVzSFym5BcUtkc6FEvkDmvk8A7HpNvVfZe80+r2ojTwnt9OInMg==
X-Received: by 2002:a17:902:c403:b0:1fd:6033:f94e with SMTP id
 d9443c01a7336-200855683a3mr6812565ad.27.1722989223650; 
 Tue, 06 Aug 2024 17:07:03 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:07:03 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v3 06/20] target/riscv: tracking indirect branches (fcfi) for
 zicfilp
Date: Tue,  6 Aug 2024 17:06:37 -0700
Message-ID: <20240807000652.1417776-7-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/riscv/cpu.h        |  3 +++
 target/riscv/cpu_bits.h   |  7 ++++++
 target/riscv/cpu_helper.c | 13 +++++++++++
 target/riscv/helper.h     |  3 +++
 target/riscv/op_helper.c  |  7 ++++++
 target/riscv/translate.c  | 45 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 78 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 12334f9540..b77481428f 100644
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
index 127f2179dc..1709564b32 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -590,6 +590,10 @@ typedef enum {
     LP_EXPECTED = 1,
 } cfi_elp;
 
+typedef enum {
+    MISSING_LPAD = 0,
+} cfi_violation_cause;
+
 /* hstatus CSR bits */
 #define HSTATUS_VSBE         0x00000020
 #define HSTATUS_GVA          0x00000040
@@ -691,6 +695,9 @@ typedef enum RISCVException {
     RISCV_EXCP_SEMIHOST = 0x3f,
 } RISCVException;
 
+/* zicfilp defines lp violation results in sw check with tval = 2*/
+#define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
+
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 364f3ee212..c7af430f38 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -134,6 +134,19 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
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
+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED,
+                           env->elp != NO_LP_EXPECTED);
+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
+    }
+
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 451261ce5a..fc4c41db5e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -121,6 +121,9 @@ DEF_HELPER_2(cbo_clean_flush, void, env, tl)
 DEF_HELPER_2(cbo_inval, void, env, tl)
 DEF_HELPER_2(cbo_zero, void, env, tl)
 
+/* helper for raising sw check exception */
+DEF_HELPER_4(raise_sw_check_excep, void, env, tl, tl, tl)
+
 /* Special functions */
 DEF_HELPER_2(csrr, tl, env, int)
 DEF_HELPER_3(csrw, void, env, int, tl)
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 488116cc2e..3b47fb34ea 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -259,6 +259,13 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
     /* We don't emulate the cache-hierarchy, so we're done. */
 }
 
+void helper_raise_sw_check_excep(CPURISCVState *env, target_ulong swcheck_code,
+                                 target_ulong arg1, target_ulong arg2)
+{
+    env->sw_check_code = swcheck_code;
+    riscv_raise_exception(env, RISCV_EXCP_SW_CHECK, GETPC());
+}
+
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index acba90f170..fbca3b8a06 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -44,6 +44,7 @@ static TCGv load_val;
 /* globals for PM CSRs */
 static TCGv pm_mask;
 static TCGv pm_base;
+static TCGOp *cfi_lp_check;
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
@@ -116,6 +117,9 @@ typedef struct DisasContext {
     bool frm_valid;
     bool insn_start_updated;
     const GPtrArray *decoders;
+    /* zicfilp extension. fcfi_enabled, lp expected or not */
+    bool fcfi_enabled;
+    bool fcfi_lp_expected;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1238,6 +1242,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
+    ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
+    ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
@@ -1245,6 +1251,37 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 {
+    DisasContext *ctx = container_of(db, DisasContext, base);
+
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
+        cfi_lp_check = tcg_last_op();
+        tcg_gen_brcondi_i32(TCG_COND_EQ, immediate, 0, l);
+        gen_helper_raise_sw_check_excep(tcg_env,
+            tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+            tcg_constant_tl(MISSING_LPAD), tcg_constant_tl(0));
+        gen_set_label(l);
+        /*
+         * Despite the use of gen_exception_illegal(), the rest of
+         * the TB needs to be generated. The TCG optimizer will
+         * clean things up depending on which path ends up being
+         * active.
+         */
+        ctx->base.is_jmp = DISAS_NEXT;
+    }
 }
 
 static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
@@ -1303,6 +1340,14 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     default:
         g_assert_not_reached();
     }
+
+    if (ctx->fcfi_lp_expected) {
+        /*
+         * If the "lp expected" flag is still up, the block needs to take an
+         * illegal instruction exception.
+         */
+        tcg_set_insn_param(cfi_lp_check, 1, tcgv_i32_arg(tcg_constant_i32(1)));
+    }
 }
 
 static const TranslatorOps riscv_tr_ops = {
-- 
2.44.0


