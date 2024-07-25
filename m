Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60B1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8AZ-0000j6-Gq; Thu, 25 Jul 2024 19:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AL-0008FM-M0
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:34 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AJ-0005KD-M6
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:33 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70cec4aa1e4so285465b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951190; x=1722555990;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/goruj9R/Ogq//f42WS9QY23H4aITjhBZuc+jiaohE=;
 b=X0/wSbEFAtreRllyxUrllTksFWkiVa1XCbr+hbBHKQtCRtO9QiDK6a63p/9VqbiTtS
 6ibD+Fz5gvzLhkgLDqMcPRo5HRPKWV/Cz0+Gx6eVnvnGyCzm93ocWKPI9P4Ud0T15ypu
 KTNs3EYdwkRzQFZG4SScfVVyTttmt5TcABa2sI5Tx/7ZXZz7jI53ayyDFjcSIWUWT7UZ
 WUgAGQtrpPthj4EuctO9K5+shk1yVCDgCW2nHtOGBm1TO1204x17HLmBGk5zCj+cuDhG
 BRVuDzMDFqfznjtXJtksHMvVAk55N5rJT2egmZ1eFzpjlD+qJKDPDtca+GJgk0l81L4n
 X89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951190; x=1722555990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/goruj9R/Ogq//f42WS9QY23H4aITjhBZuc+jiaohE=;
 b=pcLggUzaMeMmO2iBvcG/BAWCQiYyLrxu6GeoZHi80dBxEtE8NEv8+n2CjlF1MN1gdt
 wkzSXO7GIgxMd24PIWIarPDf7yRqrkaFA8r07PmpV/aaOCfuZERCEVXfvCszbqEcQzsk
 cmtDhECKCh0YcXyT9BlV3K33g+4iLFtm+FlkYwHXJWBjNRYHChuWlx3vK75RW3EJjv0v
 26dOjSx2ToR8KQCUevRrRuDMo2ETbQwF2PQ5+WPQro5ZNzo4VABoBKd/WsyruRHThV8C
 z/Gqs9O3c3NWMTRknfG2NQx4HC2k8dDq8Wf+bZi6LQYYwwORl4s2rVnm0BhEnrXjx2YV
 hNVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX82PpDnn8Yg+er/oRizdQECMCPLIbdz5LAMklfN/i52y8bs/4gFdRc0YtA7Ups4N2jMuXn38ch+oh3SiSb8H/AoH6cSG0=
X-Gm-Message-State: AOJu0YwZKT59UQNwG0nLVufuJYcHIrIlUSWLC7hgbKcsYBBWPM/yzWkt
 9SVbJe1VTH2rNykKjQ1LUg7lchTacsa7w7DSaYuoc7DQ90tc8gc22bWjTF0jXUs=
X-Google-Smtp-Source: AGHT+IGfQm+O8uaU0ELFfLH82LWTnWcfL3IiMxkkzETsQqT+W3hOgWu9PrFLOwdfzLUB+tvUEveKhg==
X-Received: by 2002:a05:6a00:2ea2:b0:706:5dab:83c5 with SMTP id
 d2e1a72fcca58-70eaa79d3e9mr5974158b3a.0.1721951190115; 
 Thu, 25 Jul 2024 16:46:30 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:29 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 05/24] target/riscv: tracking indirect branches (fcfi) for
 zicfilp
Date: Thu, 25 Jul 2024 16:45:54 -0700
Message-ID: <20240725234614.3850142-6-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x434.google.com
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

This patch also also adds flag for forward cfi in DisasContext.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  3 +++
 target/riscv/cpu_helper.c | 12 ++++++++++
 target/riscv/translate.c  | 48 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 12334f9540..7fed5d2750 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -606,6 +606,8 @@ FIELD(TB_FLAGS, ITRIGGER, 22, 1)
 FIELD(TB_FLAGS, VIRT_ENABLED, 23, 1)
 FIELD(TB_FLAGS, PRIV, 24, 2)
 FIELD(TB_FLAGS, AXL, 26, 2)
+/* zicfilp needs a TB flag to track indirect branches */
+FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 28, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 127f2179dc..477e24feaf 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -691,6 +691,9 @@ typedef enum RISCVException {
     RISCV_EXCP_SEMIHOST = 0x3f,
 } RISCVException;
 
+/* zicfilp defines lp violation results in sw check with tval = 2*/
+#define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
+
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 41bc73ad60..2cb1d45467 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -134,6 +134,18 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
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
+    }
+
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index acba90f170..c746d7df08 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -20,6 +20,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "tcg/tcg-op.h"
+#include "tcg/tcg-temp-internal.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -44,6 +45,7 @@ static TCGv load_val;
 /* globals for PM CSRs */
 static TCGv pm_mask;
 static TCGv pm_base;
+static TCGOp *cfi_lp_check;
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
@@ -116,6 +118,9 @@ typedef struct DisasContext {
     bool frm_valid;
     bool insn_start_updated;
     const GPtrArray *decoders;
+    /* zicfilp extension. cfi enabled or not. lp expected or not */
+    bool fcfi_enabled;
+    bool fcfi_lp_expected;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1238,6 +1243,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
+    ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
+    ctx->fcfi_enabled = cpu_get_fcfien(env) && ctx->fcfi_lp_expected;
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
@@ -1245,6 +1252,39 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
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
+        tcg_temp_free_i32(immediate);
+        tcg_gen_st_tl(
+            tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+            tcg_env, offsetof(CPURISCVState, sw_check_code));
+        generate_exception(ctx, RISCV_EXCP_SW_CHECK);
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
@@ -1303,6 +1343,14 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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


