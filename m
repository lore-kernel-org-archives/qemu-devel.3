Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69299C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZN-0005uO-Vh; Mon, 29 Jul 2024 13:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZE-0005K2-4t
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:57 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZB-0000Lc-Kr
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:51 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso18927355ab.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275627; x=1722880427;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJ6GKjHyFg/N/6Kqn8U3twMqQ3IQfPK9ONneJ3cAfiI=;
 b=pAO1OQ2eITjkOxhW8HcW2yI5fChepok5rWpIILOgaFXWpyYpgDZtpYVuh4rtCunZSN
 36ueT+IA15D6fj6CoFogPN78t3dVfHW8VUsDlIXBXsHXz32bIqtiz8XXrCPeAMQC9i5p
 1FfAnR9eDoGU8/crm/v2b2jgH3jrMSyftW1RehTS82bCTUHhJom2cdI86hDwsXQlEQwH
 81pO8vpGWe+aaj5oBNpiDslvspshaji+Hdqo4P7UNR4Pp91FIIX+pSINKOkMR5B8wcN7
 h31J7TbsB5ccGaIzBeTvlKihQo0ORtnCZoqpewTrBDcKV0tC5D/rSlleBhhVMpOEdVat
 WbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275627; x=1722880427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJ6GKjHyFg/N/6Kqn8U3twMqQ3IQfPK9ONneJ3cAfiI=;
 b=Ikd6kGUet95OSUPSZnLJwK/23jbyWEsjvSMuavJQNWedVag+MTssMD/jvUqlIazfiB
 qX8dBOjaiCSAOFZxQI7GNHQIBJ6tPQxZY/WSLSCChHZs4QohS2IkHV0J1FE2JUB1AK0f
 LRJRGLiLDMgM5lT+3u2jV0dawoH7PPVcjxy+E4ey6g2hfBcgPmUMndRnQx8qrRCOz8CE
 d9cm4UfaAgZvZdYitQ1E8XcndgI4DWTJIM1AKvGwa4a1vZH7vpy+k/TKll8a/e0Tk0VG
 kyRaadrNHmSzDsB8UscfWe/vJEztj6zVgJdWZ02PRx8JraC2uMgu373Q/w2xiBLiPRqz
 QImA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoYYYVLAIpZAQoMuUmL0+11S0Rua0HL6Pdosyz74whrMWYLbC7zojXltvKPbQZE5f6T5e+fr8KQuFvXJ4z2fUGjzLseeY=
X-Gm-Message-State: AOJu0YzUiGKSB81ajhnQqnosBBlNvDAIGF/F8lKTTX6TZbVz+zAOdi7g
 eat0slzawvVH6rGubyKSN1ww6UpH1me1nQz/5A1IVbEbY/wImJxpKGLVtZw64B4=
X-Google-Smtp-Source: AGHT+IFS/WLadWDu9qTdcxQ+RfJ9Cc85KApzqblTdOxSzXE86CLdPyc79G9R+4GasU2SjGGnhYvCWg==
X-Received: by 2002:a05:6e02:1a0b:b0:397:6dfc:993a with SMTP id
 e9e14a558f8ab-39aec40214amr100157855ab.21.1722275626750; 
 Mon, 29 Jul 2024 10:53:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:46 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 13/24] target/riscv: implement zicfiss instructions
Date: Mon, 29 Jul 2024 10:53:15 -0700
Message-ID: <20240729175327.73705-14-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=debug@rivosinc.com; helo=mail-il1-x130.google.com
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
 target/riscv/helper.h                         |   2 +
 target/riscv/insn32.decode                    |  17 +-
 target/riscv/insn_trans/trans_rva.c.inc       |  47 ++++++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 149 ++++++++++++++++++
 target/riscv/op_helper.c                      |   9 ++
 target/riscv/translate.c                      |   1 +
 7 files changed, 225 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 589326e516..8e179d6965 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -696,6 +696,8 @@ typedef enum RISCVException {
 
 /* zicfilp defines lp violation results in sw check with tval = 2*/
 #define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
+/* zicfiss defines ss violation results in sw check with tval = 3*/
+#define RISCV_EXCP_SW_CHECK_BCFI_TVAL      3
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index ab55bbbf73..4efb7ba4df 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -124,6 +124,8 @@ DEF_HELPER_2(cbo_zero, void, env, tl)
 /* Forward CFI label checking */
 DEF_HELPER_2(cfi_jalr, void, env, int)
 DEF_HELPER_2(cfi_check_landing_pad, void, env, int)
+/* helper for sschk mismatch (zicfiss) */
+DEF_HELPER_3(sschk_mismatch, void, env, tl, tl)
 
 /* Special functions */
 DEF_HELPER_2(csrr, tl, env, int)
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
index 0000000000..bac65d4166
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
+    uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
+    TCGv_i32 ssp_csr = tcg_constant_i32(CSR_SSP);
+    TCGv data = tcg_temp_new();
+    gen_helper_csrr(addr, tcg_env, ssp_csr);
+
+    tcg_gen_qemu_ld_tl(data, addr, ss_mmu_idx,
+                       mxl_memop(ctx) | MO_ALIGN);
+    TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
+    /*
+     * add XLEN/bitwidth to addr, align to XLEN . How do i do that? Is below
+     * the right way
+     */
+    tcg_gen_addi_tl(addr, addr, tmp);
+    gen_helper_sschk_mismatch(tcg_env, rs1, data);
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
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 2d152f0a00..54baa3a966 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -291,6 +291,15 @@ void helper_cfi_check_landing_pad(CPURISCVState *env, int lbl)
     }
 }
 
+void helper_sschk_mismatch(CPURISCVState *env, target_ulong rs1,
+                           target_ulong ssra)
+{
+    if (rs1 != ssra) {
+        env->sw_check_code = RISCV_EXCP_SW_CHECK_BCFI_TVAL;
+        riscv_raise_exception(env, RISCV_EXCP_SW_CHECK, GETPC());
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 34c9bf093d..9152a963ee 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1143,6 +1143,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
 #include "insn_trans/trans_rvzimop.c.inc"
+#include "insn_trans/trans_rvzicfiss.c.inc"
 #include "insn_trans/trans_rvzfa.c.inc"
 #include "insn_trans/trans_rvzfh.c.inc"
 #include "insn_trans/trans_rvk.c.inc"
-- 
2.44.0


