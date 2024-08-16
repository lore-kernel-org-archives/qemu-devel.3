Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26520C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selRR-0001fJ-9u; Thu, 15 Aug 2024 21:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRM-0001Lg-TS
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:40 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1selRK-0002Nu-SP
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 21:07:40 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7a1c7857a49so1110645a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 18:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723770457; x=1724375257;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wB6e2A/CQG22NVfxbNPvHs+WpR1ymge8PxcVI9UwAM=;
 b=2mbsygRjlEyoTU/0j7D6PX1LGSfv+x8Dt0wTWcmx3YktGp+yy1dbjM2fX9pFSX1/5z
 EIwNJE0sVAzJB2Wmi2ez5dXQQ+6IdQoEBW/xO633VIxwrAsclewfshfxgiaT6/7gpfUO
 77KJEaIWRjTNLl3yTZh3PL6RFF8hwI8fx4oPKv6Bz3FMDSIkvwcl5ZCfr05n3fxCci9b
 FhcWm3RwKZPB8oNlpWprZGPBmkdgggBHBYQbmDr/GwB2ULmiSAkqC8zxshVPrfmqM4rV
 4YyvKQ7GwNhFHMo9DTAUQV/r7p5t7oVM7KlWjcUSGS9PxYpMnDzaO/Z0eEwrs+KA/z1B
 ArnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723770457; x=1724375257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wB6e2A/CQG22NVfxbNPvHs+WpR1ymge8PxcVI9UwAM=;
 b=fhFDIeLjPaKhtIg9EQMYymxcWdbzHn5sos9bNOM7eG4ehARxgvYT5gUxi2UmdosyhH
 eoP6d6egLPN3SeUq9FalmhCgcSgOBuMq6jOSrCOGI4gT1z5NDT2esklJ3/8Dk+CgsmTm
 cqdk+EAXe67a8kgAUqH0Kw577bNqIxFDra+EW9+FDN5nPCIKYnSPeW5aX1o7vFwbIVMk
 Uo0XFGlzHVMEN7sqAoN18CA60hhfWWYCwzqlzP2GHvxAQN5ceU/3V4ndijYZYoHv0dOp
 2veq9m4jE0OMyT2McDENk+jMXTQXwHjUH0qYlflP0kL656ay+AlQC5WNu50TKzCsid1K
 EELg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeicijk6XJfkYhuJzO1oWKep0G64e25PJc0G+VGpKsBt5Wvwyvi5w8EkBcx88j8jB5LSTz8BZsGmOhwN8S+j3+TwP7PZA=
X-Gm-Message-State: AOJu0YzwAbZmQg7yRkqgYTMLPIYTRWLy2PukpG4/goA26Ma1KtH0VtaS
 ZtRLG6V7JjnM1Hij85S3DRALXzpzbq+HQOm0A1JgHHU31ryvhvlpbx/eNMc1C6Q=
X-Google-Smtp-Source: AGHT+IFvjhSL8gQ99R1qRwo4/pnOvlcZB/0bGJsS4D3Drb0G+fiawPUdivroJK6/UCojjqhiRAey8w==
X-Received: by 2002:a05:6a20:d50c:b0:1c6:91e1:f0fc with SMTP id
 adf61e73a8af0-1c905053553mr1563260637.48.1723770457319; 
 Thu, 15 Aug 2024 18:07:37 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae120cdsm1604806b3a.77.2024.08.15.18.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 18:07:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, richard.henderson@linaro.org,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 16/16] target/riscv: add trace-hooks for each case of
 sw-check exception
Date: Thu, 15 Aug 2024 18:07:10 -0700
Message-ID: <20240816010711.3055425-17-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816010711.3055425-1-debug@rivosinc.com>
References: <20240816010711.3055425-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x52a.google.com
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

Violations to control flow rules setup by zicfilp and zicfiss lead to
software check exceptions. To debug and fix such sw check issues in guest
, add trace-hooks for each case.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/helper.h                         |  3 +++
 target/riscv/insn_trans/trans_rvi.c.inc       |  3 +++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  1 +
 target/riscv/op_helper.c                      | 13 +++++++++++++
 target/riscv/trace-events                     |  6 ++++++
 target/riscv/translate.c                      |  2 ++
 6 files changed, 28 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e946ba61fd..6e90fbd225 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -123,6 +123,9 @@ DEF_HELPER_2(cbo_zero, void, env, tl)
 
 /* helper to raise sw check exception */
 DEF_HELPER_2(raise_sw_check_excep, void, env, tl)
+/* helper functions to trace riscv cfi violations */
+DEF_HELPER_3(zicfilp_label_mismatch, void, env, tl, tl)
+DEF_HELPER_3(zicfiss_ra_mismatch, void, env, tl, tl)
 
 /* Special functions */
 DEF_HELPER_2(csrr, tl, env, int)
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 936b430282..7021f8d3da 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -54,6 +54,7 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
             /*
              * misaligned, according to spec we should raise sw check exception
              */
+            trace_zicfilp_unaligned_lpad_instr(ctx->base.pc_first);
             gen_helper_raise_sw_check_excep(tcg_env,
                 tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL));
             return true;
@@ -66,6 +67,8 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
         TCGv tmp = tcg_temp_new();
         tcg_gen_extract_tl(tmp, get_gpr(ctx, xT2, EXT_NONE), 12, 20);
         tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->label, skip);
+        gen_helper_zicfilp_label_mismatch(tcg_env, tcg_constant_tl(a->label),
+            tmp);
         gen_helper_raise_sw_check_excep(tcg_env,
             tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL));
         gen_set_label(skip);
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 67f5c7804a..f1cf7ca438 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -45,6 +45,7 @@ static bool gen_sspopchk(DisasContext *ctx, int rs1_reg)
                        mxl_memop(ctx) | MO_ALIGN);
     TCGv rs1 = get_gpr(ctx, rs1_reg, EXT_NONE);
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
+    gen_helper_zicfiss_ra_mismatch(tcg_env, data, rs1);
     gen_helper_raise_sw_check_excep(tcg_env,
         tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL));
     gen_set_label(skip);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 9ec19c4afa..b681f0f1aa 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
+#include "trace.h"
 
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
@@ -265,6 +266,18 @@ void helper_raise_sw_check_excep(CPURISCVState *env, target_ulong swcheck_code)
     riscv_raise_exception(env, RISCV_EXCP_SW_CHECK, GETPC());
 }
 
+void helper_zicfilp_label_mismatch(CPURISCVState *env, target_ulong lpad_label,
+                                   target_ulong t2_label)
+{
+    trace_zicfilp_lpad_reg_mismatch(lpad_label, t2_label);
+}
+
+void helper_zicfiss_ra_mismatch(CPURISCVState *env, target_ulong ssra,
+                                target_ulong rs1)
+{
+    trace_zicfiss_sspopchk_reg_mismatch(ssra, rs1);
+}
+
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 49ec4d3b7d..9d5b61a2da 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -9,3 +9,9 @@ pmpaddr_csr_write(uint64_t mhartid, uint32_t addr_index, uint64_t val) "hart %"
 
 mseccfg_csr_read(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": read mseccfg, val: 0x%" PRIx64
 mseccfg_csr_write(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": write mseccfg, val: 0x%" PRIx64
+
+# zicfiss/lp
+zicfiss_sspopchk_reg_mismatch(uint64_t ssra, uint64_t rs1) "shadow_stack_ra: 0x%" PRIx64 ", rs1: 0x%" PRIx64
+zicfilp_missing_lpad_instr(uint64_t pc_first) "pc_first: 0x%" PRIx64
+zicfilp_unaligned_lpad_instr(uint64_t pc_next) "pc_next: 0x%" PRIx64
+zicfilp_lpad_reg_mismatch(uint64_t lpad_label, uint64_t t2_label) "lpad_label: 0x%" PRIx64 ", t2_label: 0x%" PRIx64
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 6fa98e88d9..fbef430848 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -35,6 +35,7 @@
 #undef  HELPER_H
 
 #include "tcg/tcg-cpu.h"
+#include "trace.h"
 
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
@@ -1348,6 +1349,7 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
          */
         tcg_set_insn_param(tcg_ctx->cfi_lp_check, 1,
                            tcgv_i32_arg(tcg_constant_i32(1)));
+        trace_zicfilp_missing_lpad_instr(ctx->base.pc_first);
     }
 }
 
-- 
2.44.0


