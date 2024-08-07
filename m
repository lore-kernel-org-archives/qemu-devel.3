Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7E2C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUDx-0006XY-Ki; Tue, 06 Aug 2024 20:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUD4-000319-3o
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:23 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCx-0001CK-AD
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:21 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fd90c2fc68so11857405ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989231; x=1723594031;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFHEY1HL0A7dkX+2//5U6cJ4axaqUQXdv3Ozs813Dsg=;
 b=NNZwgj1gCtLbVs7PJNJgENv05eJpuaD8J/pwUuSdwYM/R9POB6g9R/STT5rhyXfD3t
 hAf1zgtHzCefH/ghFmi3W4R/VbtBVUmANUkFy1W1iwnYMXpwlNgPKO6/Z8P332URWZ5A
 e/OQKPPtzC7q2Z1q9POpyaPUNC9sWoDG1MV9dYEZFQ9gql4GAoXNujzOpCYpxXGjGuQ0
 b2El8QJwecNuoCZ73QL1YNXKT/fP9iqDo4D4J1NKnAOGUJ5TUQ7g/Iwst7rWxJchCUI0
 tu8c3hVy4QvSd5aYlaOByDFetuGtUw+XA4FXlRiPGBv4lFryR7KcfOh4hxqa4ufVumbo
 eA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989231; x=1723594031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFHEY1HL0A7dkX+2//5U6cJ4axaqUQXdv3Ozs813Dsg=;
 b=eKu6cjlNK1WUtLKyKqZjH1f2TjUkp0kjhS5+7WgGmfge9BGRzAUXEWJNNGqjcRAM89
 E/6X48fC6dcVVuHL2m0lg5Mt+HdAi5HA1qDCb36UxvWf/FW96Pjl1lg3RDZ//ugRZ7Ts
 pXa8eQsp410FSW2qaVxilh6DMhMferK+VMoxdWj4rYcloC1iVkFb90D1fh3fTLVL9/d5
 VbY42Lm+K0m6l5ud8iJmxw0pkLWBh7c3TFuCwwrsBnzppCeKhi7llpBhuUnEyXm1LU9c
 JC4/bQbZThSnakK+ukZaicpHnEF2U4gByojMz6GGtwktculQ4mvGBf+G8dS2igy6GvrX
 cD1A==
X-Gm-Message-State: AOJu0YxiCVm5k0tVBpmRhZZt7C/XLOR9ghnEqkEFgDrDzb2PONeTM3dY
 31AE8lsW5O3wuJ9NCE6h5etShlurDAH2b7Fe7izUZW9E/3JzIzNhqWDZiSBs7XFUCz2fwptv6CL
 n
X-Google-Smtp-Source: AGHT+IFclzCNb3eEB5r/7Rn4jNMrRkaMIr0LSGeSyQabYhqeORwYv5ccS3f3he2rlWU+uexyDiww4Q==
X-Received: by 2002:a17:903:41cf:b0:1fc:6a13:a394 with SMTP id
 d9443c01a7336-1ff57292c0dmr193128665ad.23.1722989230983; 
 Tue, 06 Aug 2024 17:07:10 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:07:10 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v3 12/20] target/riscv: implement zicfiss instructions
Date: Tue,  6 Aug 2024 17:06:43 -0700
Message-ID: <20240807000652.1417776-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/cpu_bits.h                       |   2 +
 target/riscv/insn32.decode                    |  17 +-
 target/riscv/insn_trans/trans_rva.c.inc       |  47 ++++++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 149 ++++++++++++++++++
 target/riscv/translate.c                      |   1 +
 5 files changed, 214 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 226157896d..5ebc4dd5b3 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -702,6 +702,8 @@ typedef enum RISCVException {
 
 /* zicfilp defines lp violation results in sw check with tval = 2*/
 #define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
+/* zicfiss defines ss violation results in sw check with tval = 3*/
+#define RISCV_EXCP_SW_CHECK_BCFI_TVAL      3
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c963c59c8e..c59c992ce2 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -65,8 +65,10 @@
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
 @i       ............    ..... ... ..... ....... &i      imm=%imm_i     %rs1 %rd
+@ss_pop  ............    ..... ... ..... ....... &i      imm=0 %rs1 rd=0
 @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
 @s       .......   ..... ..... ... ..... ....... &s      imm=%imm_s %rs2 %rs1
+@ss_push .......   ..... ..... ... ..... ....... &s      imm=0 %rs2 rs1=0
 @u       ....................      ..... ....... &u      imm=%imm_u          %rd
 @j       ....................      ..... ....... &j      imm=%imm_j          %rd
 
@@ -247,6 +249,7 @@ remud    0000001 .....  ..... 111 ..... 1111011 @r
 lr_w       00010 . . 00000 ..... 010 ..... 0101111 @atom_ld
 sc_w       00011 . . ..... ..... 010 ..... 0101111 @atom_st
 amoswap_w  00001 . . ..... ..... 010 ..... 0101111 @atom_st
+ssamoswap_w 01001 . . ..... ..... 010 ..... 0101111 @atom_st
 amoadd_w   00000 . . ..... ..... 010 ..... 0101111 @atom_st
 amoxor_w   00100 . . ..... ..... 010 ..... 0101111 @atom_st
 amoand_w   01100 . . ..... ..... 010 ..... 0101111 @atom_st
@@ -260,6 +263,7 @@ amomaxu_w  11100 . . ..... ..... 010 ..... 0101111 @atom_st
 lr_d       00010 . . 00000 ..... 011 ..... 0101111 @atom_ld
 sc_d       00011 . . ..... ..... 011 ..... 0101111 @atom_st
 amoswap_d  00001 . . ..... ..... 011 ..... 0101111 @atom_st
+ssamoswap_d 01001 . . ..... ..... 011 ..... 0101111 @atom_st
 amoadd_d   00000 . . ..... ..... 011 ..... 0101111 @atom_st
 amoxor_d   00100 . . ..... ..... 011 ..... 0101111 @atom_st
 amoand_d   01100 . . ..... ..... 011 ..... 0101111 @atom_st
@@ -1023,8 +1027,17 @@ amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
 amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
 
 # *** Zimop may-be-operation extension ***
-mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
-mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
+{
+  # zicfiss instructions carved out of mop.r
+  ssrdp      1100110 11100     00000 100 ..... 1110011 %rd
+  sspopchk   1100110 11100     ..... 100 00000 1110011 @ss_pop
+  mop_r_n    1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
+}
+{
+  # zicfiss instruction carved out of mop.rr
+  sspush     1100111 .....     00000 100 00000 1110011 @ss_push
+  mop_rr_n   1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
+}
 
 # *** Zabhb Standard Extension ***
 amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 39bbf60f3c..db6c03f6a8 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -18,6 +18,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "exec/memop.h"
+
 #define REQUIRE_A_OR_ZAAMO(ctx) do {                      \
     if (!ctx->cfg_ptr->ext_zaamo && !has_ext(ctx, RVA)) { \
         return false;                                     \
@@ -114,6 +116,28 @@ static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
 }
 
+static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
+{
+    REQUIRE_A_OR_ZAAMO(ctx);
+    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
+    int ss_mmu_idx = 0;
+
+    /* back cfi was not enabled, return false */
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    decode_save_opc(ctx);
+    src1 = get_address(ctx, a->rs1, 0);
+
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESL));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
@@ -183,6 +207,29 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
 }
 
+static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_A_OR_ZAAMO(ctx);
+    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
+    int ss_mmu_idx = 0;
+
+    /* back cfi was not enabled, return false */
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    decode_save_opc(ctx);
+    src1 = get_address(ctx, a->rs1, 0);
+
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESQ));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
new file mode 100644
index 0000000000..c538b7ad99
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -0,0 +1,149 @@
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
+
+static MemOp mxl_memop(DisasContext *ctx)
+{
+    switch (get_xl(ctx)) {
+    case MXL_RV32:
+        return MO_TEUL;
+
+    case MXL_RV64:
+        return MO_TEUQ;
+
+    case MXL_RV128:
+        return MO_TEUO;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
+{
+    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
+    int ss_mmu_idx = 0;
+
+    /* sspopchk only supported on 32bit and 64bit */
+    if (get_xl(ctx) != MXL_RV32 && get_xl(ctx) != MXL_RV64) {
+        return false;
+    }
+
+    /* back cfi was not enabled, return false */
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    /*
+     * sspopchk can only compare with x1 or x5. Everything else defaults to
+     * zimops
+     */
+
+    if (a->rs1 != 1 && a->rs1 != 5) {
+        return false;
+    }
+
+    /*
+     * get data in TCGv using get_gpr
+     * get addr in TCGv using gen_helper_csrr on CSR_SSP
+     * use some tcg subtract arithmetic (subtract by XLEN) on addr
+     * perform ss store on computed address
+     */
+
+    TCGv addr = tcg_temp_new();
+    TCGLabel *skip = gen_new_label();
+    uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
+    TCGv_i32 ssp_csr = tcg_constant_i32(CSR_SSP);
+    TCGv data = tcg_temp_new();
+    gen_helper_csrr(addr, tcg_env, ssp_csr);
+
+    tcg_gen_qemu_ld_tl(data, addr, ss_mmu_idx,
+                       mxl_memop(ctx) | MO_ALIGN);
+    TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
+    tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
+    gen_helper_raise_sw_check_excep(tcg_env,
+        tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL), data, rs1);
+    gen_set_label(skip);
+    tcg_gen_addi_tl(addr, addr, tmp);
+    gen_helper_csrw(tcg_env, ssp_csr, addr);
+
+    return true;
+}
+
+static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
+{
+    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
+    int ss_mmu_idx = 0;
+
+    /* sspush only supported on 32bit and 64bit */
+    if (get_xl(ctx) != MXL_RV32 && get_xl(ctx) != MXL_RV64) {
+        return false;
+    }
+
+    /* back cfi was not enabled, return false */
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    /*
+     * sspush can only push from x1 or x5. Everything else defaults to zimop
+     */
+    if (a->rs2 != 1 && a->rs2 != 5) {
+        return false;
+    }
+
+    /*
+     * get data in TCGv using get_gpr
+     * get addr in TCGv using gen_helper_csrr on CSR_SSP
+     * use some tcg subtract arithmetic (subtract by XLEN) on addr
+     * perform ss store on computed address
+     */
+
+    TCGv addr = tcg_temp_new();
+    int tmp = (get_xl(ctx) == MXL_RV64) ? -8 : -4;
+    TCGv_i32 ssp_csr = tcg_constant_i32(CSR_SSP);
+    TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
+    gen_helper_csrr(addr, tcg_env, ssp_csr);
+
+    tcg_gen_addi_tl(addr, addr, tmp);
+
+    tcg_gen_qemu_st_tl(data, addr, ss_mmu_idx,
+                       mxl_memop(ctx) | MO_ALIGN);
+    gen_helper_csrw(tcg_env, ssp_csr, addr);
+
+    return true;
+}
+
+static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
+{
+    /* ssrdp only supported on 32bit and 64bit */
+    if (get_xl(ctx) != MXL_RV32 && get_xl(ctx) != MXL_RV64) {
+        return false;
+    }
+
+    /* back cfi was not enabled, return false */
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGv_i32 ssp_csr = tcg_constant_i32(CSR_SSP);
+    gen_helper_csrr(dest, tcg_env, ssp_csr);
+    gen_set_gpr(ctx, a->rd, dest);
+
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b0526f5d79..de375c32a1 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1142,6 +1142,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
 #include "insn_trans/trans_rvzimop.c.inc"
+#include "insn_trans/trans_rvzicfiss.c.inc"
 #include "insn_trans/trans_rvzfa.c.inc"
 #include "insn_trans/trans_rvzfh.c.inc"
 #include "insn_trans/trans_rvk.c.inc"
-- 
2.44.0


