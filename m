Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B749C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Aj-0001OB-1J; Thu, 25 Jul 2024 19:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Ag-0001CJ-9O
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:54 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Ae-0005Q5-9V
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:54 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-399020cfbb7so4159615ab.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951211; x=1722556011;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2gOjemeIxuisakJLMtv9C9tfaLcK041ldza0nSyRho=;
 b=WA3b8VuOxvl0/FQq+ALlmcBHaylTAwwDPzFFT1MDTJhBjMfowtTWRClBmzE1MWRY4e
 vFdmQGAs1Z6TlKccHN8ntpUuH4xYesUglXWf766RB5mo8QbKhjZ+F2tXF2ruxLgyW8dN
 n/ALwGbnNR5ZK2EdQkJ2as/mqzoy7blTWjLwqY9TSUlnz3BpDCBET2RovUkmPx1TNRuJ
 GBEoAa5QI9JX4ueBQ6UIBZgLlDYTgRQN8YPuNEBNexj9UA55+VYmrNdeCTEEPrSZr3q7
 vYNZpk8PhZeILAETXpD0jXl2IOv6ZKkT1Pw9cof3iUc5I4kPxaUvthEvWqhdpgw8qVal
 t8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951211; x=1722556011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2gOjemeIxuisakJLMtv9C9tfaLcK041ldza0nSyRho=;
 b=DlrP7sUSWpA6NfcKnsuovbZPQ7DuEZkQfujJc11Tpubup7Nva+evVmaDrcKljmgsxF
 rx2u0n+7EsCSy0wZVQfM4uWHkMKfOuuxJ5FxV0gK3QCvn8WU5oVHTGurwl+PyP4YWPph
 sNU+uekQA1M5punB8B7FYVi75i8kFV3C/sEkpjboV3R2nMJBoxSEbrGEOqbYGneylC6k
 hPq9J3n6kMazhtykvB9oUEjnH0EJsGW7mx14n9kIVprg3rMsgk+rjxRR/v3K2SYtZhOy
 KJdfLxX7h/riaAuAr7AaqF4mA03gpzNbjJNgsmOEELY3DC8EevY5t0rWqZCCCFRhILAO
 dzUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK5N8T75CjCOjt+tn+TDhvBmVl6HLdm0yMzetq74Ui0tYldll1ASivjCOYhWQQbWRA1nUgCe3tu1QZXZnR6LF+LbNNlxU=
X-Gm-Message-State: AOJu0YxZRvcFT1cI3NtP0xFh2Bq77jPbnFoSxVPNAoUvgjrQyF6yBFUy
 oRtp5sPFux89XhmIKKIZH8neHz0V0H5TmbKlF5HituPBwiG0K0PxU9W88O+QiGY=
X-Google-Smtp-Source: AGHT+IFKMl9CngMXdlR/nZp8wDlvayNR5hml0yjYP6oF8/3MRSV5I7OwMWF9VQrnkKLJlB3PY35psw==
X-Received: by 2002:a05:6e02:1d82:b0:380:fd76:3d9e with SMTP id
 e9e14a558f8ab-39a23ff33b4mr40732715ab.22.1721951211066; 
 Thu, 25 Jul 2024 16:46:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:50 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 21/24] target/riscv: add trace-hooks for each case of sw-check
 exception
Date: Thu, 25 Jul 2024 16:46:10 -0700
Message-ID: <20240725234614.3850142-22-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=debug@rivosinc.com; helo=mail-il1-x12c.google.com
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

Violations to control flow rules setup by zicfilp and zicfiss lead to
software check exceptions. To debug and fix such sw check issues in guest
, add trace-hooks for each case.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 1 +
 target/riscv/op_helper.c                | 4 ++++
 target/riscv/trace-events               | 6 ++++++
 target/riscv/translate.c                | 2 ++
 4 files changed, 13 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index ee868c5fcb..66b26cbe8b 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -65,6 +65,7 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
                     tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
                     tcg_env, offsetof(CPURISCVState, sw_check_code));
             generate_exception(ctx, RISCV_EXCP_SW_CHECK);
+            trace_zicfilp_unaligned_lpad_instr((uint64_t) ctx->base.pc_next);
             return true;
         }
     }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 54baa3a966..6a54c6c24d 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
+#include "trace.h"
 
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
@@ -283,6 +284,8 @@ void helper_cfi_check_landing_pad(CPURISCVState *env, int lbl)
          * greater than 31 and then shift 12 right
          */
         if (lbl && (lbl != ((env->gpr[xT2] & 0xFFFFFFFF) >> 12))) {
+            trace_zicfilp_lpad_reg_mismatch(lbl,
+                                           (env->gpr[xT2] & 0xFFFFFFFF) >> 12);
             env->sw_check_code = RISCV_EXCP_SW_CHECK_FCFI_TVAL;
             riscv_raise_exception(env, RISCV_EXCP_SW_CHECK, GETPC());
         }
@@ -295,6 +298,7 @@ void helper_sschk_mismatch(CPURISCVState *env, target_ulong rs1,
                            target_ulong ssra)
 {
     if (rs1 != ssra) {
+        trace_zicfiss_sspopchk_reg_mismatch((uint64_t)ssra, (uint64_t) rs1);
         env->sw_check_code = RISCV_EXCP_SW_CHECK_BCFI_TVAL;
         riscv_raise_exception(env, RISCV_EXCP_SW_CHECK, GETPC());
     }
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 49ec4d3b7d..842349ecb9 100644
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
+zicfilp_lpad_reg_mismatch(int lpad_label, int t2_label) "lpad_label: 0x%x, t2_label: 0x%x"
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ad0f841807..958a1578d4 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -30,6 +30,7 @@
 #include "semihosting/semihost.h"
 
 #include "internals.h"
+#include "trace.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -1380,6 +1381,7 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
          * illegal instruction exception.
          */
         tcg_set_insn_param(cfi_lp_check, 1, tcgv_i32_arg(tcg_constant_i32(1)));
+        trace_zicfilp_missing_lpad_instr((uint64_t) ctx->base.pc_first);
     }
 }
 
-- 
2.44.0


