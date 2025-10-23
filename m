Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC3DCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjd-0000lX-8P; Thu, 23 Oct 2025 00:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmja-0000lF-S1
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:30 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjY-0007LN-As
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7a2754a7f6aso434129b3a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192925; x=1761797725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtZNpnlw4+L5jAKmRWNcn/XGLeOEOfDtLm9V40+Oe64=;
 b=HTq9StdoXE8q8iPPQFVH3zld7wLWPU1kolBAylVNrHpWr1kkp6XSNuJSOI5gexza/8
 ZX16pScdCx4D0xSBKevA54TQauoLo5cRHmQPnKyHYdQM1Oe3pXyYT5x1CIdQxkSlf9dM
 flr4oIkgYoHzIWAXyR7UxzDsHTsXn7ww+o7z4QYgcyEYiZgmrLQ2UgT+++2HNkjTghmj
 1BYZcFI44hXwbvq+hwAWbfeBaFoLP7jZlUxR6gl5KsEVyPqn5Q/9hPOO/iWtu5iBH0dR
 7Z959x0gPBFAiOWFMtOLxryoka1kB0izehlJYJ3sqIRMoE8lTZSpv5xx3/6CUxT+2/yj
 fZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192925; x=1761797725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtZNpnlw4+L5jAKmRWNcn/XGLeOEOfDtLm9V40+Oe64=;
 b=IGPtQWSdeCTzuv0d66eIzu5+cC2vpUX2KpV4fGG5j6WF0e3CKmCwJa9mC0i21KYuTT
 HqMPmjc70+4tUxVlJtCZVH20IQXA9fQrJoBSPstFOlv7TFZlOmzqVeVV+OzPvTi98e/D
 191Jm2xGFbN3mKItcnbqNUVNATAeM7sSrRs2jdEWmthx+0HWuqkfbh9CMhRzOYAiiH/h
 PFEpLX9q9HjVR7dY9V8IjmgxICSrpiX6i02X5Kmx5fIeZdMwgSIJX6lchn/fzKkzoCjQ
 U0wqN1RlzTLJamNqt6aA08AHnpOJoRHT6KJ1k2SPiAx1Go3Z89fD7VL41RZetYMDPACS
 vawg==
X-Gm-Message-State: AOJu0YywyU5ZlbdfZuxyqgZnWQvFpv1hglt1rH2zakpRDIB5YIctzrwa
 0UbYNEgcJ4EQM2jQft2COYcjXzGYZB0K+N8AquFKjLG0cZVyeN+bse+GGh3tHA==
X-Gm-Gg: ASbGnctdPEOOO0iAfdOaMZ5UKlGDfkniUXR2rVWnSeECW8hSP/OApaX+qpwC6SVZ1Yp
 BZSkMrmHaHiVz3QMcy652AiByNu84l/Y1P20oPAo3Jc2wF3DWLA8lIEyGhITlurgzR+38lINDgN
 pBlhi9JhR1x9jNOgyIVjs6qA/r2Jgfn1mPbQdqR+A42cbCUmUWK6u5+XItr4oC4HDJrSUaVPWJN
 DID5goIVNyUA+UmosqEpeZgVXSErrv55tdUmyvSIKmthxwOIrjJIcf1ZxNWwaM2uWqkiL0gjHlb
 LQVOhda94ihUNI4KMx4K5xvrQGz1Hqlv+DRsveLbJJ0ysdqgJbE8Y0YX1xhtw4RrQBKPu4le2Cz
 Q+2uguHGeWRCUANQmwLE3YIpDZDsoWDloddfAjlPPzNnJQDQItqOoZYXwB9D2E2v/WbLxQgl59f
 87xNt2/Bgk2/cL2VAt1PLrLrGQBXN2wMRYe9pTyJ3yS222mnrla1W9w3Ozi3Wh3bi0GRnGI/ery
 bzBh7K6IQ==
X-Google-Smtp-Source: AGHT+IHLbjHOfHNLc1CwqDvs/Ty8++l36kGDgk9okMKTTMJqfnOobaufP3gx95tX7JTHjn1V/BzbFA==
X-Received: by 2002:a05:6a00:84a:b0:78c:985b:8d3b with SMTP id
 d2e1a72fcca58-7a220b29d75mr23653802b3a.23.1761192925111; 
 Wed, 22 Oct 2025 21:15:25 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/37] target/riscv: Factor MemOp variable out when MO_TE is set
Date: Thu, 23 Oct 2025 14:14:09 +1000
Message-ID: <20251023041435.1775208-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In preparation of automatically replacing the MO_TE flag
in the next commit, use an local @memop variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-12-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvd.c.inc       |  6 ++++--
 target/riscv/insn_trans/trans_rvf.c.inc       |  6 ++++--
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  5 +++--
 target/riscv/insn_trans/trans_rvzce.c.inc     |  6 ++++--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  8 ++++++--
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 10 ++++++----
 6 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 3385820678..62b7535815 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -42,7 +42,7 @@
 static bool trans_fld(DisasContext *ctx, arg_fld *a)
 {
     TCGv addr;
-    MemOp memop = MO_TE | MO_UQ;
+    MemOp memop = MO_UQ;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
@@ -60,6 +60,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     } else {
         memop |= MO_ATOM_IFALIGN;
     }
+    memop |= MO_TE;
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
@@ -72,7 +73,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
 static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
 {
     TCGv addr;
-    MemOp memop = MO_TE | MO_UQ;
+    MemOp memop = MO_UQ;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
@@ -84,6 +85,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     } else {
         memop |= MO_ATOM_IFALIGN;
     }
+    memop |= MO_TE;
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index 150e2b9a7d..878417eae9 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -43,11 +43,12 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
 {
     TCGv_i64 dest;
     TCGv addr;
-    MemOp memop = MO_TE | MO_UL;
+    MemOp memop = MO_UL;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
+    memop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -65,11 +66,12 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
 static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
 {
     TCGv addr;
-    MemOp memop = MO_TE | MO_UL;
+    MemOp memop = MO_UL;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
+    memop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
index d850b14264..6458ac4f24 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -119,12 +119,13 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
     TCGv_i64 src2h = get_gpr(ctx, a->rs2 == 0 ? 0 : a->rs2 + 1, EXT_NONE);
     TCGv_i64 destl = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv_i64 desth = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
+    MemOp memop = MO_ALIGN | MO_UO;
 
+    memop |= MO_TE;
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
     tcg_gen_concat_i64_i128(dest, destl, desth);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx,
-                                (MO_ALIGN | MO_TE | MO_UO));
+    tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx, memop);
 
     tcg_gen_extr_i128_i64(destl, desth, dest);
 
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index c8dc102c8e..172c2c19c1 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -175,7 +175,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
         return false;
     }
 
-    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_TE | MO_UL : MO_TE | MO_UQ;
+    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_UL : MO_UQ;
     int reg_size = memop_size(memop);
     target_ulong stack_adj = ROUND_UP(ctpop32(reg_bitmap) * reg_size, 16) +
                              a->spimm;
@@ -185,6 +185,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
 
     tcg_gen_addi_tl(addr, sp, stack_adj - reg_size);
 
+    memop |= MO_TE;
     for (i = X_Sn + 11; i >= 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv dest = dest_gpr(ctx, i);
@@ -228,7 +229,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_push *a)
         return false;
     }
 
-    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_TE | MO_UL : MO_TE | MO_UQ;
+    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_UL : MO_UQ;
     int reg_size = memop_size(memop);
     target_ulong stack_adj = ROUND_UP(ctpop32(reg_bitmap) * reg_size, 16) +
                              a->spimm;
@@ -238,6 +239,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_push *a)
 
     tcg_gen_subi_tl(addr, sp, reg_size);
 
+    memop |= MO_TE;
     for (i = X_Sn + 11; i >= 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv val = get_gpr(ctx, i, EXT_NONE);
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
index eec478afcb..5355cd46c3 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -42,12 +42,14 @@
 
 static bool trans_flh(DisasContext *ctx, arg_flh *a)
 {
+    MemOp memop = MO_UW;
     TCGv_i64 dest;
     TCGv t0;
 
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
+    memop |= MO_TE;
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
@@ -57,7 +59,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     }
 
     dest = cpu_fpr[a->rd];
-    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, MO_TE | MO_UW);
+    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, memop);
     gen_nanbox_h(dest, dest);
 
     mark_fs_dirty(ctx);
@@ -66,11 +68,13 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
 
 static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
 {
+    MemOp memop = MO_UW;
     TCGv t0;
 
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
+    memop |= MO_TE;
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
@@ -79,7 +83,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
         t0 = temp;
     }
 
-    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TE | MO_UW);
+    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, memop);
 
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index c555596617..89eed00758 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -100,12 +100,13 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    MemOp memop = MO_ALIGN | MO_SL;
 
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
 
-    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
-                           (MO_ALIGN | MO_TE | MO_SL));
+    memop |= MO_TE;
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
@@ -129,12 +130,13 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
 
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    MemOp memop = MO_ALIGN | MO_SQ;
 
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
 
-    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
-                           (MO_ALIGN | MO_TE | MO_SQ));
+    memop |= MO_TE;
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
-- 
2.51.0


