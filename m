Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82291CA0EC8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjofN-0004GC-DE; Thu, 29 Aug 2024 19:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjofK-00046u-KR
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:58 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjofE-0003C9-6x
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:58 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2020e83eca1so12958715ad.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724974491; x=1725579291;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfMI0HVMe/9WD3eJ9OSyAXv9CNL2x4woRUtuakjh8IU=;
 b=ncI1Icd4+mpS6btahnFjQmi3KjKAdwdAwxxCbr62giozEkIRf5d0ai/8VX/auRTCnH
 TXXTKhdVtm0vjaa0PbiKU4AfzTZ92uhF4HiJEAdGZI+YLSe9lZ3GqXbUkmwoCG8cv8zU
 Dw6UY0JwlRympQfsaWePVIbBRTSnR3Yk30ZCK363BGJ+cxdwKh/mYvAMF+be5ydlpD3b
 XLiX0IgIRP3xDJKEoF2U35oV9pLsQp7tDLoI8chrDFLqGCamc1FYo8OkaUpJeOlMX2h5
 X5ADinsPHvUHBC2x6q7k223sKVPj0t0o4R4N1CGzFHzkygfve3a3mDti+r8xUAF2LgxE
 eGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724974491; x=1725579291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfMI0HVMe/9WD3eJ9OSyAXv9CNL2x4woRUtuakjh8IU=;
 b=O//OdGCy/tjn4d8DfSJ3JUuXfD6WpoDXY0ua6rt5VRJD8oom9KTjwVgSmPC4OzTnjP
 NoiG4MyUl9kIVI8kzLfOOvRBsehylmBbwMKYmFw8MrKRfz1ZvBtDgUOFPiGDkAVK4cMS
 Y9sqfd2CisCuGtY//3hypDDpzY8KeAQUNGnKcShvhD0wJQAKkY50n9dB21+WKcEoCsFp
 Dr6rpUeB6GGhap4DobziLjXelsQvCPk+jSdP2HK+S2bgkDxZMwTp7gxgvVDcK89fFSc2
 +aOp8OuKhDeJXGYnn/GMWend8mZtM+b+2Hc9T7h05owSzGQHhDCl2ySzLXQQmS6yY4yo
 5wZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtc6ZSnbdxebQ79leHZYRTi5MR+S/Ix/GdrrAupzQUbJk1+OB5embmAKU4fWXIraKIP8A679ckKBJV@nongnu.org
X-Gm-Message-State: AOJu0YxRRDtpGoFRhgLAp0eTEH128Lla6kX07RlNrVBZnXbGJFoYuai0
 Pp95lMowLhVW1rwE8oph1KrSCNpT+GbVhKNeXQ+lbkqo75z9xY/nunbPl1k5LEg=
X-Google-Smtp-Source: AGHT+IEFTggwYq72fCNFUl1E9dMHnJkGz8Y8ZVrqwte0tv8fUdsZR8n+0/bQGFLGL1Fmuhl+T8ss4Q==
X-Received: by 2002:a17:90a:65c2:b0:2d3:ca3f:7f2a with SMTP id
 98e67ed59e1d1-2d8561c87aamr5040760a91.22.1724974490415; 
 Thu, 29 Aug 2024 16:34:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85b13df55sm2331074a91.27.2024.08.29.16.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 16:34:50 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v12 16/20] target/riscv: implement zicfiss instructions
Date: Thu, 29 Aug 2024 16:34:20 -0700
Message-ID: <20240829233425.1005029-17-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240829233425.1005029-1-debug@rivosinc.com>
References: <20240829233425.1005029-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62c.google.com
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

zicfiss has following instructions
 - sspopchk: pops a value from shadow stack and compares with x1/x5.
   If they dont match, reports a sw check exception with tval = 3.
 - sspush: pushes value in x1/x5 on shadow stack
 - ssrdp: reads current shadow stack
 - ssamoswap: swaps contents of shadow stack atomically

sspopchk/sspush/ssrdp default to zimop if zimop implemented and SSE=0

If SSE=0, ssamoswap is illegal instruction exception.

This patch implements shadow stack operations for qemu-user and shadow
stack is not protected.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h                       |   2 +
 target/riscv/insn32.decode                    |  21 +++-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 114 ++++++++++++++++++
 target/riscv/translate.c                      |   5 +
 4 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 48ce24dc32..bb62fbe9ec 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -690,6 +690,8 @@ typedef enum RISCVException {
 
 /* zicfilp defines lp violation results in sw check with tval = 2*/
 #define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
+/* zicfiss defines ss violation results in sw check with tval = 3*/
+#define RISCV_EXCP_SW_CHECK_BCFI_TVAL      3
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 27108b992b..e9139ec1b9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -246,6 +246,7 @@ remud    0000001 .....  ..... 111 ..... 1111011 @r
 lr_w       00010 . . 00000 ..... 010 ..... 0101111 @atom_ld
 sc_w       00011 . . ..... ..... 010 ..... 0101111 @atom_st
 amoswap_w  00001 . . ..... ..... 010 ..... 0101111 @atom_st
+ssamoswap_w 01001 . . ..... ..... 010 ..... 0101111 @atom_st
 amoadd_w   00000 . . ..... ..... 010 ..... 0101111 @atom_st
 amoxor_w   00100 . . ..... ..... 010 ..... 0101111 @atom_st
 amoand_w   01100 . . ..... ..... 010 ..... 0101111 @atom_st
@@ -259,6 +260,7 @@ amomaxu_w  11100 . . ..... ..... 010 ..... 0101111 @atom_st
 lr_d       00010 . . 00000 ..... 011 ..... 0101111 @atom_ld
 sc_d       00011 . . ..... ..... 011 ..... 0101111 @atom_st
 amoswap_d  00001 . . ..... ..... 011 ..... 0101111 @atom_st
+ssamoswap_d 01001 . . ..... ..... 011 ..... 0101111 @atom_st
 amoadd_d   00000 . . ..... ..... 011 ..... 0101111 @atom_st
 amoxor_d   00100 . . ..... ..... 011 ..... 0101111 @atom_st
 amoand_d   01100 . . ..... ..... 011 ..... 0101111 @atom_st
@@ -1022,8 +1024,23 @@ amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
 amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
 
 # *** Zimop may-be-operation extension ***
-mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
-mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
+{
+  # zicfiss instructions carved out of mop.r
+  [
+    ssrdp     1100110 11100 00000 100 rd:5  1110011
+    sspopchk  1100110 11100 00001 100 00000 1110011 &r2 rs1=1 rd=0
+    sspopchk  1100110 11100 00101 100 00000 1110011 &r2 rs1=5 rd=0
+  ]
+  mop_r_n    1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
+}
+{
+  # zicfiss instruction carved out of mop.rr
+  [
+    sspush    1100111 00001  00000 100 00000 1110011 &r2_s rs2=1 rs1=0
+    sspush    1100111 00101  00000 100 00000 1110011 &r2_s rs2=5 rs1=0
+  ]
+  mop_rr_n   1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
+}
 
 # *** Zabhb Standard Extension ***
 amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
new file mode 100644
index 0000000000..e3ebc4977c
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -0,0 +1,114 @@
+/*
+ * RISC-V translation routines for the Control-Flow Integrity Extension
+ *
+ * Copyright (c) 2024 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
+{
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv addr = tcg_temp_new();
+    TCGLabel *skip = gen_new_label();
+    uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
+    TCGv data = tcg_temp_new();
+    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
+    tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
+                       mxl_memop(ctx) | MO_ALIGN);
+    TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
+    tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
+    tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
+                  tcg_env, offsetof(CPURISCVState, sw_check_code));
+    gen_helper_raise_exception(tcg_env,
+                  tcg_constant_i32(RISCV_EXCP_SW_CHECK));
+    gen_set_label(skip);
+    tcg_gen_addi_tl(addr, addr, tmp);
+    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+
+    return true;
+}
+
+static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
+{
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv addr = tcg_temp_new();
+    int tmp = (get_xl(ctx) == MXL_RV64) ? -8 : -4;
+    TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
+    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_addi_tl(addr, addr, tmp);
+    tcg_gen_qemu_st_tl(data, addr, SS_MMU_INDEX(ctx),
+                       mxl_memop(ctx) | MO_ALIGN);
+    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+
+    return true;
+}
+
+static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
+{
+    if (!ctx->bcfi_enabled || a->rd == 0) {
+        return false;
+    }
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    tcg_gen_ld_tl(dest, tcg_env, offsetof(CPURISCVState, ssp));
+    gen_set_gpr(ctx, a->rd, dest);
+
+    return true;
+}
+
+static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
+{
+    REQUIRE_A_OR_ZAAMO(ctx);
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
+    src1 = get_address(ctx, a->rs1, 0);
+
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
+                           (MO_ALIGN | MO_TESL));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
+static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_A_OR_ZAAMO(ctx);
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
+    src1 = get_address(ctx, a->rs1, 0);
+
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
+                           (MO_ALIGN | MO_TESQ));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0ca10818f3..bccaf8e89a 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -144,6 +144,8 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
 #define get_address_xl(ctx)    ((ctx)->address_xl)
 #endif
 
+#define mxl_memop(ctx) ((get_xl(ctx) + 1) | MO_TE)
+
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
 {
@@ -1127,6 +1129,8 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     return translator_ldl(env, &ctx->base, pc);
 }
 
+#define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
+
 /* Include insn module translation function */
 #include "insn_trans/trans_rvi.c.inc"
 #include "insn_trans/trans_rvm.c.inc"
@@ -1157,6 +1161,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "decode-insn16.c.inc"
 #include "insn_trans/trans_rvzce.c.inc"
 #include "insn_trans/trans_rvzcmop.c.inc"
+#include "insn_trans/trans_rvzicfiss.c.inc"
 
 /* Include decoders for factored-out extensions */
 #include "decode-XVentanaCondOps.c.inc"
-- 
2.44.0


