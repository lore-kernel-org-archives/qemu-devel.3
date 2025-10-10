Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E020CCD18E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FPT-0004H1-Eo; Fri, 10 Oct 2025 11:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FPP-0004F5-1W
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:55 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FPH-0002hv-FL
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:53 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso1359708f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760111502; x=1760716302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nRDMITnOJutiilVWlAwBIw5yUEex1aWcchZayOCLRA=;
 b=gHlD0gDR/n/S/rUDJG4hnz/FcoeT/gYDI1virp++onIiYWY80ktcDsuSnSWFsHxGAj
 JNdFDzODAPnQG1cxfpP0M/fuT7iaNYbXWm6br2ZVaNoIKgCWAk3IWlHEgKeMrhmHzuoX
 LzMkptD+8Ev6zCNYIRwIiRusouIuKt/6UfRe2MEoJltACHCo0/QhNS4QVpyXQjL8cgJA
 DwsqIIjR0b3EcAWPbFKfwt0bT/FAB+UXw9MBpjb9wDb5SUZLDJM9zDPxwy3/To4LvkI4
 rAdOHoipmHD7V0aSn0X+GTkc3eqcZPFPsbyqDwqvzaKMfo5yTX0NzsMCGErRGJ/Oiawm
 Kvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111502; x=1760716302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nRDMITnOJutiilVWlAwBIw5yUEex1aWcchZayOCLRA=;
 b=tRLPZLV8/h5MmjmCpTWUSFSW0LZdQZIIBo7N4rei6FrxyDNDEBOURdVpq7a6+72fft
 ydz2lH1whZQKLFvg8X6zUQhsbQocvDjaduv2RjVjLDvLvPSh7P2K/AgceK9OPNPZwkFW
 /vQBznxgQeseC5eZ9xQrW4UtrsYW355Vw9h2YjI7Crus6/g37sunZXEwewhNOeJfUdor
 c70Imyob1tMSb+t+Yjjsmel8t6/a9NtKt8qREktFHntCeuBZLCqXrqj3AOJKKsDJSFPg
 kQTAubvIKx1fpPnzhUhJnqha/91T3li3zjMu0osiqYYae+vtzpIsr2q7vYovwbNRTQP0
 eRyQ==
X-Gm-Message-State: AOJu0YwIp78sntLovfRMtCcQ5vwd1VrfxCkVUQQbIPy9bb1n+Ln8cJS6
 dIOuuxIzUvE/3bW4I2xoR/yxMFgdljrYT8sC3ELsAY/7uE76wFaeXI88B0puhls2yJgG1KoO/Ks
 Xqw7CMOu3Sw==
X-Gm-Gg: ASbGncukEjbWiVq4To9epu29QTdGaMsapjUiLkPTb69/CueraWxLCgwKHfTgVg7lLTo
 6Nz3V76taO7fXZPZdy/b2hhWybw66C0dwjx5lRPOJCZ4qEH0q7q+Ob4pB9RrIlJGZy+qtww18pB
 URBTux/8exXO6szBy00GB+zQNUeVLKf4LCSgGZNg1GZ3skxiARS5Nohd6XTUpPkeEl5Zimg+TyY
 6Y9FQSCEz9p3wKcxJFZEpZ6HCHvg42PzaI3JCK6Ajzuogoqfx6fJa/R/t0iU8rflRb7Qee+Fa/I
 vsc/TI8y0QWIzzAMAOLOoz169Dvy/pvaT3Pls5yrvC3Nmw3uSlnbSwxBAjUGganinQQRMPGsZzt
 7uha2ZJ3IarrNyp0e/0Gb8pWzOaYGayyh8E9f6RxcdOK33xUVQUFj1c1o+OBf9oXTPAyQyZA6Mn
 8MZuwYmwarQKXuPm6D3xI=
X-Google-Smtp-Source: AGHT+IHNkk9S/8yR1aw85Iezcwx+u+KVdZOB01DALF3qKbXH68EC234hxJWWSRA/HzLYIi+x7Yq5yQ==
X-Received: by 2002:a05:6000:2c0c:b0:3f0:2ab8:710f with SMTP id
 ffacd0b85a97d-42666ac39afmr6518937f8f.8.1760111502313; 
 Fri, 10 Oct 2025 08:51:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489197dsm56759745e9.10.2025.10.10.08.51.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 08:51:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/13] target/riscv: Factor MemOp variable out when MO_TE is
 set
Date: Fri, 10 Oct 2025 17:50:42 +0200
Message-ID: <20251010155045.78220-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010155045.78220-1-philmd@linaro.org>
References: <20251010155045.78220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In preparation of automatically replacing the MO_TE flag
in the next commit, use an local @memop variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_rvd.c.inc       |  6 ++++--
 target/riscv/insn_trans/trans_rvf.c.inc       |  6 ++++--
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  5 +++--
 target/riscv/insn_trans/trans_rvzce.c.inc     |  6 ++++--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  8 ++++++--
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 10 ++++++----
 6 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 33858206788..62b75358158 100644
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
index 150e2b9a7d4..878417eae92 100644
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
index d850b142642..6458ac4f241 100644
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
index c8dc102c8e3..172c2c19c17 100644
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
index eec478afcb0..5355cd46c3d 100644
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
index c5555966175..89eed007587 100644
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


