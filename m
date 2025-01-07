Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46412E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4be-00057z-9x; Tue, 07 Jan 2025 03:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ab-0000Yl-OV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:27 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aQ-0003OU-9c
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:20 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ef8c012913so17034612a91.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237112; x=1736841912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Eipdzm2JjOIIjHW4vHmCDNbKGY0WVVYUSOwwoNhUWo=;
 b=gFgIOMTC90Nz4KetmfhVoUoI5aqwO2Jvxg6IR3UMKkicbBolDN558GqoeOb+3LRUap
 DLlli/wZI7mOXZqs17oGu04fVuWGiBAgI6YygQxIRWrslm/Eup7e09oeiI0U6YMI5KDL
 OGOlyDJOgHgpHQceaTcTIQDvyc6sN+9y6+oXaEkb2iJUMw1Gf6or3XtUWaNUM3eqUKxp
 e0rykBKr7UewdFd9zIso83Otp08Lz8MfQCGYhCZcS5XinCXXVioOS2f4xPO/O8uyDxXs
 VzE5Ri8SbQeJ25gcWIgubkVJFPk1eab/TDsD4mLN9LPfcMJtsbhYjg4zpWHwCcE3R3yv
 0MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237112; x=1736841912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Eipdzm2JjOIIjHW4vHmCDNbKGY0WVVYUSOwwoNhUWo=;
 b=KpMt9HQ7CO8xDp6XG4p9fTQBMPDt2sUwcIq1aEjKavaFBBQyx44REpYBEQbhDil92C
 WMj2BiTcBOgpS33wbqac+MF6cQD2cMNDs/c346i0XhPcTV3ManHPs4YAsDQJKzpHTEpS
 LElXF4eVvJrp0p5QZk9aPqCsrBdiZRf7uhM32D+0m11vjmNcwg6aYD9cer3HMBwzU2qk
 YYGHKTWPoXVL4gApgSjeN3nIrTxy3A3H/1Yjw2ffs3o+Ocx3l2Rd4dNDtO9PnSDgWi8a
 99E6f2uk6tUnBJInDusiYEF8yFOKyl/WxaIhDx1vI+TO2bs7+qmmFu05Mm0FiR9T0Qgz
 nP5A==
X-Gm-Message-State: AOJu0YwdabfkbQQOkTNsLajalHMCmAASPF3tgzszY2vlRvo+g1cNMNHt
 SwARtF9fj4K+dLLkhnCauj28SGg7GGFw9Ezt0fOIb9HFszt/UIhPB9oq6ugB4eRbv5G6Cl4ksZ8
 0
X-Gm-Gg: ASbGncvS+UXlfZW5v+WtpXaALU7sdcTjK8u9CBZ3B6c5jy0v4DEmvq6U83LUSYaA2zz
 5L2lBWxX9t5+lyGWeD4LM16z/stJRM7nM/iYOshSzVF5IamfSDaXPr9M86TJ4H/8nqjfYRQuv8l
 KjIgqLA6N1jxAXp45r0C/YxUsgfe9wo2bCnCm1Vy7BRr85lvv2i0M4lr49OLVPghZbfDw7c2KRR
 wqYPQ7RfkgiHvKB90aDyeXg50jAGD6dHApnxadvTzp/pMgj69MO9GggKmBxB46iBwDyWRv5WMG+
 NdnlJAtQAcqZmUvskw==
X-Google-Smtp-Source: AGHT+IF1N2C0BJPhE9qyDDYQJWupFA0oiX4J2fdxRLTj8gh4CXNk49hjixf/PaV3widtgtzbczjg2A==
X-Received: by 2002:a05:6a00:92a4:b0:728:e1f9:b680 with SMTP id
 d2e1a72fcca58-72abdd7ac89mr85581795b3a.6.1736237111511; 
 Tue, 07 Jan 2025 00:05:11 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 53/81] tcg: Merge INDEX_op_add_{i32,i64}
Date: Tue,  7 Jan 2025 00:00:44 -0800
Message-ID: <20250107080112.1175095-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Rely on TCGOP_TYPE instead of opcodes specific to each type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  4 ++--
 target/sh4/translate.c   |  6 +++---
 tcg/optimize.c           | 13 +++++--------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                | 15 +++++----------
 tcg/tci.c                |  5 ++---
 tcg/tci/tcg-target.c.inc |  6 ++----
 7 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 6b764a4a14..c6977f1030 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -39,6 +39,8 @@ DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 
 DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 
+DEF(add, 1, 2, 0, TCG_OPF_INT)
+
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
 DEF(movcond_i32, 1, 4, 1, 0)
@@ -52,7 +54,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(add_i32, 1, 2, 0, 0)
 DEF(sub_i32, 1, 2, 0, 0)
 DEF(mul_i32, 1, 2, 0, 0)
 DEF(div_i32, 1, 2, 0, 0)
@@ -115,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(add_i64, 1, 2, 0, 0)
 DEF(sub_i64, 1, 2, 0, 0)
 DEF(mul_i64, 1, 2, 0, 0)
 DEF(div_i64, 1, 2, 0, 0)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bcdd558818..aa7e0a6690 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1940,7 +1940,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
     NEXT_INSN;
     switch (ctx->opcode & 0xf00f) {
     case 0x300c: /* add Rm,Rn */
-        op_opc = INDEX_op_add_i32;
+        op_opc = INDEX_op_add;
         goto do_reg_op;
     case 0x2009: /* and Rm,Rn */
         op_opc = INDEX_op_and_i32;
@@ -1984,7 +1984,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         if (op_dst != B11_8 || mv_src >= 0) {
             goto fail;
         }
-        op_opc = INDEX_op_add_i32;
+        op_opc = INDEX_op_add;
         op_arg = tcg_constant_i32(B7_0s);
         break;
 
@@ -2087,7 +2087,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
                                 ctx->memidx, ld_mop);
         break;
 
-    case INDEX_op_add_i32:
+    case INDEX_op_add:
         if (op_dst != st_src) {
             goto fail;
         }
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 4acf89d915..6b7cf2ca49 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -412,7 +412,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     uint64_t l64, h64;
 
     switch (op) {
-    CASE_OP_32_64(add):
+    case INDEX_op_add:
         return x + y;
 
     CASE_OP_32_64(sub):
@@ -2246,7 +2246,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             break;
         }
         if (convert) {
-            TCGOpcode add_opc, xor_opc, neg_opc;
+            TCGOpcode xor_opc, neg_opc;
 
             if (!inv && !neg) {
                 return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
@@ -2254,12 +2254,10 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
             switch (ctx->type) {
             case TCG_TYPE_I32:
-                add_opc = INDEX_op_add_i32;
                 neg_opc = INDEX_op_neg_i32;
                 xor_opc = INDEX_op_xor_i32;
                 break;
             case TCG_TYPE_I64:
-                add_opc = INDEX_op_add_i64;
                 neg_opc = INDEX_op_neg_i64;
                 xor_opc = INDEX_op_xor_i64;
                 break;
@@ -2270,7 +2268,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             if (!inv) {
                 op->opc = neg_opc;
             } else if (neg) {
-                op->opc = add_opc;
+                op->opc = INDEX_op_add;
                 op->args[2] = arg_new_constant(ctx, -1);
             } else {
                 op->opc = xor_opc;
@@ -2635,8 +2633,7 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
     if (arg_is_const(op->args[2])) {
         uint64_t val = arg_info(op->args[2])->val;
 
-        op->opc = (ctx->type == TCG_TYPE_I32
-                   ? INDEX_op_add_i32 : INDEX_op_add_i64);
+        op->opc = INDEX_op_add;
         op->args[2] = arg_new_constant(ctx, -val);
     }
     return finish_folding(ctx, op);
@@ -2827,7 +2824,7 @@ void tcg_optimize(TCGContext *s)
          * Sorted alphabetically by opcode as much as possible.
          */
         switch (opc) {
-        CASE_OP_32_64(add):
+        case INDEX_op_add:
             done = fold_add(&ctx, op);
             break;
         case INDEX_op_add_vec:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 108dc61e9a..344d490966 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -362,7 +362,7 @@ void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
 
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_add_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
 }
 
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1555,7 +1555,7 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_add_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_add, ret, arg1, arg2);
     } else {
         tcg_gen_add2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
                          TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e8d1bcec20..220ddfb066 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -991,8 +991,7 @@ static const TCGOutOp outop_notreached = {
 
 static const TCGOutOp * const all_outop[NB_OPS] = {
     [0 ... NB_OPS - 1] = &outop_notreached,
-    OUTOP(INDEX_op_add_i32, TCGOutOpBinary, outop_add),
-    OUTOP(INDEX_op_add_i64, TCGOutOpBinary, outop_add),
+    OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
 };
 
 #undef OUTOP
@@ -2206,6 +2205,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_a64_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
+    case INDEX_op_add:
     case INDEX_op_mov:
         return has_type;
 
@@ -2220,7 +2220,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_add_i32:
     case INDEX_op_sub_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
@@ -2304,7 +2303,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_add_i64:
     case INDEX_op_sub_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
@@ -4016,14 +4014,12 @@ liveness_pass_1(TCGContext *s)
             break;
 
         case INDEX_op_add2_i32:
-            opc_new = INDEX_op_add_i32;
+        case INDEX_op_add2_i64:
+            opc_new = INDEX_op_add;
             goto do_addsub2;
         case INDEX_op_sub2_i32:
             opc_new = INDEX_op_sub_i32;
             goto do_addsub2;
-        case INDEX_op_add2_i64:
-            opc_new = INDEX_op_add_i64;
-            goto do_addsub2;
         case INDEX_op_sub2_i64:
             opc_new = INDEX_op_sub_i64;
         do_addsub2:
@@ -5430,8 +5426,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         tcg_out_extrl_i64_i32(s, new_args[0], new_args[1]);
         break;
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
+    case INDEX_op_add:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index d016dc7dc0..662770ef9d 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -533,7 +533,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Arithmetic operations (mixed 32/64 bit). */
 
-        CASE_32_64(add)
+        case INDEX_op_add:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] + regs[r2];
             break;
@@ -1138,8 +1138,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1));
         break;
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
+    case INDEX_op_add:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index fbf0f7a073..8b54ee2da7 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -475,9 +475,7 @@ static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
     stack_bounds_check(base, offset);
     if (offset != sextract32(offset, 0, 16)) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, offset);
-        tcg_out_op_rrr(s, (TCG_TARGET_REG_BITS == 32
-                           ? INDEX_op_add_i32 : INDEX_op_add_i64),
-                       TCG_REG_TMP, TCG_REG_TMP, base);
+        tcg_out_op_rrr(s, INDEX_op_add, TCG_REG_TMP, TCG_REG_TMP, base);
         base = TCG_REG_TMP;
         offset = 0;
     }
@@ -666,7 +664,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 static void tgen_add(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_add_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_add, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_add = {
-- 
2.43.0


