Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099D8C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUDF-0003dP-Rg; Tue, 06 Aug 2024 20:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCt-0002fT-My
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:14 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCp-000198-CL
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:10 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ff67158052so9032105ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989225; x=1723594025;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFB9WinoCRZ6nhrQ1JROEIxU3zea/uMM0pqUvxVaHvQ=;
 b=qinONRGvT1dRotJkfcdSnsoum4WK39WVTCc5pnVFyUvs6dAuYQiEyOOoo7iUixx5Oe
 vou3G72CnxRj6zUQ9VthvXK4Pv4UxXhLhAxuV2C/pxkxiAZ76QVrYs4tkcyLexeAsn7d
 t/eBQZ4F9AdrF8vLdXjiWSt0sAZ9YYfNAd56m1AxyEfVnIlEIgkV+G9HAQvfmNmI5th4
 /7n5eBy8/VK0/A6WM3KtTI1r/NgqQY09+Ay4MiDzakQBENJ03P25ZV0G+qY5apTeghYs
 Yv8+bpgtjstDXQjoHwvMqhvC8jxW3oGVLtq6IFIxHGHAU5ZuOt9jwKX2tYBdMYyivllN
 1MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989225; x=1723594025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KFB9WinoCRZ6nhrQ1JROEIxU3zea/uMM0pqUvxVaHvQ=;
 b=D0YWh9fXb8LcXMrREIduE1oQODifvxywFj4Cd/G/1WYIXAGatPdOWxKJHjWUd/5RHa
 BIQFZyWrjDVGhYpFmnbiato2H7yGwFNhUbJV3LbBXj/1OEdpPOmMP9cRnxtSr16orjWZ
 HzvLA2c2rp0KNMAeNbNUanfwIw2UNO+nxR0z7TcGkedwkX+69uHvegGHm2FRnseOmYLx
 aYjW8cBpV13tmTDhjokB0leFFLCVkNwnyAJAqhlVzlggZf3tB11JU3+N1HPFitQ3GC+I
 SHkPOphJL/FIn6eqYsvnStUPg9dOYUGovRVSZ/0qAZ0YpZpHyhCtlPSI/J/0mwimkFhv
 aQow==
X-Gm-Message-State: AOJu0Yy06j9wAqum66D11n/0nv+WkK+yVww+kQq6xDnSc6dWU/PZySox
 TKMoAZa9A9C2xecgemPrzQb+CRwknRxdAyxFPdlEOlM0SsfR6g/zMF2OO4uEO9OX2bnnIlAcUec
 5
X-Google-Smtp-Source: AGHT+IFCbRVXwu7v58symlz4+s9lbSMN+QBB1mRvsmIp5TRa9N1QzgV1RexfKHJ/BHjQmDAdmD9mXQ==
X-Received: by 2002:a17:903:2786:b0:1fb:dedd:aa65 with SMTP id
 d9443c01a7336-1ff573bb7bbmr127327385ad.42.1722989224870; 
 Tue, 06 Aug 2024 17:07:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:07:04 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v3 07/20] target/riscv: zicfilp `lpad` impl and branch tracking
Date: Tue,  6 Aug 2024 17:06:38 -0700
Message-ID: <20240807000652.1417776-8-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x635.google.com
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

Implements setting lp expected when `jalr` is encountered and implements
`lpad` instruction of zicfilp. `lpad` instruction is taken out of
auipc x0, <imm_20>. This is an existing HINTNOP space. If `lpad` is
target of an indirect branch, cpu checks for 20 bit value in x7 upper
with 20 bit value embedded in `lpad`. If they don't match, cpu raises a
sw check exception with tval = 2.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu_bits.h                 |  2 +
 target/riscv/cpu_user.h                 |  1 +
 target/riscv/insn32.decode              |  6 ++-
 target/riscv/insn_trans/trans_rvi.c.inc | 66 +++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 1709564b32..2c585a63c2 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -592,6 +592,8 @@ typedef enum {
 
 typedef enum {
     MISSING_LPAD = 0,
+    MISALIGNED_LPAD = 1,
+    LABEL_MISMATCH_LPAD = 2,
 } cfi_violation_cause;
 
 /* hstatus CSR bits */
diff --git a/target/riscv/cpu_user.h b/target/riscv/cpu_user.h
index 02afad608b..e6927ff847 100644
--- a/target/riscv/cpu_user.h
+++ b/target/riscv/cpu_user.h
@@ -15,5 +15,6 @@
 #define xA6 16
 #define xA7 17  /* syscall number for RVI ABI */
 #define xT0 5   /* syscall number for RVE ABI */
+#define xT2 7
 
 #endif
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c45b8fa1d8..c963c59c8e 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -40,6 +40,7 @@
 %imm_z6   26:1 15:5
 %imm_mop5 30:1 26:2 20:2
 %imm_mop3 30:1 26:2
+%imm_cfi20 12:20
 
 # Argument sets:
 &empty
@@ -123,7 +124,10 @@ sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
-auipc    ....................       ..... 0010111 @u
+{
+  lpad     ....................       00000 0010111 %imm_cfi20
+  auipc    ....................       ..... 0010111 @u
+}
 jal      ....................       ..... 1101111 @j
 jalr     ............     ..... 000 ..... 1100111 @i
 beq      ....... .....    ..... 000 ..... 1100011 @b
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 98e3806d5e..cbd7d5c395 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -36,6 +36,58 @@ static bool trans_lui(DisasContext *ctx, arg_lui *a)
     return true;
 }
 
+static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
+{
+    bool lp_expected;
+    /* zicfilp only supported on 32bit and 64bit */
+    if (get_xl(ctx) != MXL_RV32 && get_xl(ctx) != MXL_RV64) {
+        return false;
+    }
+
+    lp_expected = ctx->fcfi_lp_expected;
+    /* forward cfi not enabled or lp not expected, return false */
+    if (!ctx->fcfi_enabled) {
+        return false;
+    }
+
+    /*
+     * If this is the first instruction of the TB, let the translator
+     * know the landing pad requirement was satisfied. No need to bother
+     * checking for CFI feature or enablement.
+     */
+
+    if (ctx->base.pc_next == ctx->base.pc_first) {
+        ctx->fcfi_lp_expected = false;
+        /* If landing pad was expected, PC must be 4 byte aligned */
+        if (lp_expected && ((ctx->base.pc_next) & 0x3)) {
+            /*
+             * misaligned, according to spec we should raise sw check exception
+             */
+            gen_helper_raise_sw_check_excep(tcg_env,
+                tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+                tcg_constant_tl(MISALIGNED_LPAD), tcg_constant_tl(0));
+            return true;
+        }
+    }
+
+    /* if lp was expected, do label check */
+    if (lp_expected) {
+        TCGLabel *skip = gen_new_label();
+        TCGv tmp = tcg_temp_new();
+        tcg_gen_st_tl(tcg_constant_tl(NO_LP_EXPECTED),
+                      tcg_env, offsetof(CPURISCVState, elp));
+        tcg_gen_extract_tl(tmp, get_gpr(ctx, xT2, EXT_NONE), 12, 20);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, tcg_constant_tl(a->imm_cfi20), 0, skip);
+        tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->imm_cfi20, skip);
+        gen_helper_raise_sw_check_excep(tcg_env,
+            tcg_constant_tl(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
+            tcg_constant_tl(LABEL_MISMATCH_LPAD), tcg_constant_tl(0));
+        gen_set_label(skip);
+    }
+
+    return true;
+}
+
 static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
 {
     TCGv target_pc = dest_gpr(ctx, a->rd);
@@ -75,6 +127,20 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     gen_set_gpr(ctx, a->rd, succ_pc);
 
     tcg_gen_mov_tl(cpu_pc, target_pc);
+    if (ctx->cfg_ptr->ext_zicfilp && ctx->fcfi_enabled) {
+        /*
+         * Rely on a helper to check the forward CFI enable for the
+         * current process mode. The alternatives would be (1) include
+         * "fcfi enabled" in the cflags or (2) maintain a "fcfi
+         * currently enabled" in tcg_env and emit TCG code to access
+         * and test it.
+         */
+        if (a->rs1 != xRA && a->rs1 != xT0 && a->rs1 != xT2) {
+            tcg_gen_st_tl(tcg_constant_tl(LP_EXPECTED),
+                          tcg_env, offsetof(CPURISCVState, elp));
+        }
+    }
+
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
-- 
2.44.0


