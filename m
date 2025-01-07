Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0D3E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4aw-0001bI-A7; Tue, 07 Jan 2025 03:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aV-0000Qz-RP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:23 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aP-0003O9-TW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:18 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso225435955ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237111; x=1736841911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7w+4/TBhRoUezCvweHVcxuQ9h7ZcX7w2za+jjgQgHQ=;
 b=m1f1mc8nPLqWsjVS0tE2odkKgtR6s4V2AffHwMeaI6f1Wwkfp+uYoioGTZTPmhiPQq
 Y8Twk5O5RlyYCKy6ngabbG+1pet+t3a9fa1PE8rv/WcdUUY0UxDKWpQapAaTx7JZ3fNw
 sgLMmVOk+D2VLnyxQvQNfz3gbrG3JlpX06bqoi3GCkzwwwo+C9jRFJxE9QVoXppuS4JL
 OGBYvzYDAC2tX0pzW2OntXWTeN4mjGR6Q9I3Xuq0BhXFiVCx9FbtCUozbmS1mFzuoUZZ
 x5cIKW0t+o/KD3bIcsLx8xcoXc8+c9QBmiJ2+CpewEDph/L11ZSVfcwTnakwo/6vTv7z
 UPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237111; x=1736841911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7w+4/TBhRoUezCvweHVcxuQ9h7ZcX7w2za+jjgQgHQ=;
 b=laeKg9WKfvUanrvHxLw8RvqsiJhdRcomnA4wAS/SebmLlhhuOmgHX6gIEN2BD799zn
 rQLzsS52bplywfVnavDFVF5an0CZeHVtibzhtN/6ZkJ6ZYRfNwCp/ZM55bfwQbYOkrG5
 19/XXSl4x3LOPvbyNp5rz/bBzZSaX1WnefcyjG+h2RSnYtxQigT6IEJr50NYc/AhZGn6
 YGcOfHq6dGFxtDbMQdLtj9uAh2R/Xk3+Nn6SXkesUWDPbKfIzhYbmphMPZsAe7SocL0y
 T4o0XMrXbZNP2XFc8O4EbEYdsHDzmLQX6mXL8SxuJxFXBO0x8foYjwUeYbuEQ4ya5TkJ
 y7OQ==
X-Gm-Message-State: AOJu0Yx4Mm85ivttQ2Vyw9sA8cxGUydPAAkThQD7h7mq3dnUPZjVHVDp
 723SLA9g9o4qTT9bWOXZdUJ7QKE7T8BUaGc4Hfb48hydnTZX5pGygvn7YwKi1wHLthWfSOWh9hJ
 4
X-Gm-Gg: ASbGnct5WLe9CrrTS0mHmjwG2Nk9RiumN7Rax5Cf+fxsJPdGqxmi4uDiAGeGxfPQIUv
 9YpSiWli+TLPjwFHxAWoPozfhKuZJHFbGbeWtZTMxP8GR5RbzOaz1nVIewwpK/Tut/3F3InU7qL
 9LqYM6Y0nmomz3bQKqerXiwl+f7VimscWCidby2/mg/OxagcZhG0LlG5s07CQT9D8KhfIyXAK2N
 Xx82RlK6D2k305FjjJMVM7fQG/hhFSmB7i0424qyStZx46pndN/sshLOZrsByN5jLTuHIcGMERr
 M41EDKx68oFYqGdBCA==
X-Google-Smtp-Source: AGHT+IGwHa00xihP2ipFrK3qB7o0vo1nfSlnoy6Iv3U9biIgYHhf1oDsrVWzFIpYxJWAQTN2hqU8wA==
X-Received: by 2002:a05:6a21:33a6:b0:1e5:c43f:f36d with SMTP id
 adf61e73a8af0-1e5e046189cmr83402456637.18.1736237110530; 
 Tue, 07 Jan 2025 00:05:10 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 52/81] tcg: Convert add to TCGOutOpBinary
Date: Tue,  7 Jan 2025 00:00:43 -0800
Message-ID: <20250107080112.1175095-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target-con-set.h |   1 +
 tcg/tcg.c                        |  39 ++++++++++-
 tcg/aarch64/tcg-target.c.inc     |  51 +++++++-------
 tcg/arm/tcg-target.c.inc         |  43 ++++++++----
 tcg/i386/tcg-target.c.inc        |  56 +++++++++-------
 tcg/loongarch64/tcg-target.c.inc |  38 +++++------
 tcg/mips/tcg-target.c.inc        |  31 ++++++---
 tcg/ppc/tcg-target.c.inc         |  47 +++++++------
 tcg/riscv/tcg-target.c.inc       |  39 ++++++-----
 tcg/s390x/tcg-target.c.inc       | 110 +++++++++++++++----------------
 tcg/sparc64/tcg-target.c.inc     |  25 +++++--
 tcg/tci/tcg-target.c.inc         |  15 ++++-
 12 files changed, 300 insertions(+), 195 deletions(-)

diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index 434bf25072..17eaff81c8 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -14,6 +14,7 @@ C_O0_I2(rZ, r)
 C_O0_I2(rZ, rJ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
+C_O1_I2(r, r, rJ)
 C_O1_I2(r, rZ, rJ)
 C_O1_I4(r, rZ, rJ, rI, 0)
 C_O2_I2(r, r, rZ, rJ)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f3c8a407d2..e8d1bcec20 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -962,6 +962,14 @@ typedef struct TCGOutOp {
     TCGConstraintSetIndex (*dynamic_constraint)(TCGType type, unsigned flags);
 } TCGOutOp;
 
+typedef struct TCGOutOpBinary {
+    TCGOutOp base;
+    void (*out_rrr)(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2);
+    void (*out_rri)(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, tcg_target_long a2);
+} TCGOutOpBinary;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -975,10 +983,20 @@ static const TCGOutOp outop_notreached = {
     .static_constraint = C_NotReached,
 };
 
+/*
+ * Register V as the TCGOutOp for O.
+ * Validate that V has subclass T.
+ */
+#define OUTOP(O, T, V)  [O] = _Generic(V, T: &V.base)
+
 static const TCGOutOp * const all_outop[NB_OPS] = {
     [0 ... NB_OPS - 1] = &outop_notreached,
+    OUTOP(INDEX_op_add_i32, TCGOutOpBinary, outop_add),
+    OUTOP(INDEX_op_add_i64, TCGOutOpBinary, outop_add),
 };
 
+#undef OUTOP
+
 /*
  * All TCG threads except the parent (i.e. the one that called tcg_context_init
  * and registered the target's TCG globals) must register with this function
@@ -5400,6 +5418,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     }
 
     /* emit instruction */
+    TCGType type = TCGOP_TYPE(op);
     switch (op->opc) {
     case INDEX_op_ext_i32_i64:
         tcg_out_exts_i32_i64(s, new_args[0], new_args[1]);
@@ -5410,12 +5429,28 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_extrl_i64_i32:
         tcg_out_extrl_i64_i32(s, new_args[0], new_args[1]);
         break;
+
+    case INDEX_op_add_i32:
+    case INDEX_op_add_i64:
+        {
+            const TCGOutOpBinary *out =
+                container_of(all_outop[op->opc], TCGOutOpBinary, base);
+
+            tcg_debug_assert(!const_args[1]);
+            if (const_args[2]) {
+                out->out_rri(s, type, new_args[0], new_args[1], new_args[2]);
+            } else {
+                out->out_rrr(s, type, new_args[0], new_args[1], new_args[2]);
+            }
+        }
+        break;
+
     default:
         if (def->flags & TCG_OPF_VECTOR) {
-            tcg_out_vec_op(s, op->opc, TCGOP_TYPE(op) - TCG_TYPE_V64,
+            tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
                            TCGOP_VECE(op), new_args, const_args);
         } else {
-            tcg_out_op(s, op->opc, TCGOP_TYPE(op), new_args, const_args);
+            tcg_out_op(s, op->opc, type, new_args, const_args);
         }
         break;
     }
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 13b6e2afb7..34f45b2d7b 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1592,16 +1592,6 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rn)
     tcg_out_mov(s, TCG_TYPE_I32, rd, rn);
 }
 
-static void tcg_out_addsubi(TCGContext *s, int ext, TCGReg rd,
-                            TCGReg rn, int64_t aimm)
-{
-    if (aimm >= 0) {
-        tcg_out_insn(s, 3401, ADDI, ext, rd, rn, aimm);
-    } else {
-        tcg_out_insn(s, 3401, SUBI, ext, rd, rn, -aimm);
-    }
-}
-
 static void tcg_out_addsub2(TCGContext *s, TCGType ext, TCGReg rl,
                             TCGReg rh, TCGReg al, TCGReg ah,
                             tcg_target_long bl, tcg_target_long bh,
@@ -2115,6 +2105,30 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3502, ADD, type, a0, a1, a2);
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 >= 0) {
+        tcg_out_insn(s, 3401, ADDI, type, a0, a1, a2);
+    } else {
+        tcg_out_insn(s, 3401, SUBI, type, a0, a1, -a2);
+    }
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rA),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2185,23 +2199,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, REG0(0), a1, a2, 3);
         break;
 
-    case INDEX_op_add_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_add_i64:
-        if (c2) {
-            tcg_out_addsubi(s, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3502, ADD, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_sub_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
     case INDEX_op_sub_i64:
         if (c2) {
-            tcg_out_addsubi(s, ext, a0, a1, -a2);
+            tgen_addi(s, ext, a0, a1, -a2);
         } else {
             tcg_out_insn(s, 3502, SUB, ext, a0, a1, a2);
         }
@@ -2996,8 +2997,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
         return C_O1_I2(r, r, rA);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 241f27e7e1..c7ed6f7b6e 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -896,6 +896,17 @@ static void tcg_out_dat_rIK(TCGContext *s, ARMCond cond, ARMInsn opc,
     }
 }
 
+static void tcg_out_dat_IN(TCGContext *s, ARMCond cond, ARMInsn opc,
+                           ARMInsn opneg, TCGReg dst, TCGReg lhs, TCGArg rhs)
+{
+    int imm12 = encode_imm(rhs);
+    if (imm12 < 0) {
+        imm12 = encode_imm_nofail(-rhs);
+        opc = opneg;
+    }
+    tcg_out_dat_imm(s, cond, opc, dst, lhs, imm12);
+}
+
 static void tcg_out_dat_rIN(TCGContext *s, ARMCond cond, ARMInsn opc,
                             ARMInsn opneg, TCGReg dst, TCGReg lhs, TCGArg rhs,
                             bool rhs_is_const)
@@ -904,12 +915,7 @@ static void tcg_out_dat_rIN(TCGContext *s, ARMCond cond, ARMInsn opc,
      * rhs must satisfy the "rIN" constraint.
      */
     if (rhs_is_const) {
-        int imm12 = encode_imm(rhs);
-        if (imm12 < 0) {
-            imm12 = encode_imm_nofail(-rhs);
-            opc = opneg;
-        }
-        tcg_out_dat_imm(s, cond, opc, dst, lhs, imm12);
+        tcg_out_dat_IN(s, cond, opc, opneg, dst, lhs, rhs);
     } else {
         tcg_out_dat_reg(s, cond, opc, dst, lhs, rhs, SHIFT_IMM_LSL(0));
     }
@@ -1847,6 +1853,26 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_ADD, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_IN(s, COND_AL, ARITH_ADD, ARITH_SUB, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rIN),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1895,10 +1921,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_dat_rIK(s, tcg_cond_to_arm_cond[c], ARITH_MOV,
                         ARITH_MVN, args[0], 0, args[3], const_args[3]);
         break;
-    case INDEX_op_add_i32:
-        tcg_out_dat_rIN(s, COND_AL, ARITH_ADD, ARITH_SUB,
-                        args[0], args[1], args[2], const_args[2]);
-        break;
     case INDEX_op_sub_i32:
         if (const_args[1]) {
             if (const_args[2]) {
@@ -2186,7 +2208,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add_i32:
     case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d9fa588c68..01699c0434 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2627,6 +2627,40 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* no need to flush icache explicitly */
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+
+    if (a0 == a1) {
+        tgen_arithr(s, ARITH_ADD + rexw, a0, a2);
+    } else if (a0 == a2) {
+        tgen_arithr(s, ARITH_ADD + rexw, a0, a1);
+    } else {
+        tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a2, 0, 0);
+    }
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+
+    if (a0 == a1) {
+        tgen_arithi(s, ARITH_ADD + rexw, a0, a2, false);
+    } else {
+        tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, -1, 0, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, re),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2708,24 +2742,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(add):
-        /* For 3-operand addition, use LEA.  */
-        if (a0 != a1) {
-            TCGArg c3 = 0;
-            if (const_a2) {
-                c3 = a2, a2 = -1;
-            } else if (a0 == a2) {
-                /* Watch out for dest = src + dest, since we've removed
-                   the matching constraint on the add.  */
-                tgen_arithr(s, ARITH_ADD + rexw, a0, a1);
-                break;
-            }
-
-            tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a2, 0, c3);
-            break;
-        }
-        c = ARITH_ADD;
-        goto gen_arith;
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
@@ -3694,10 +3710,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
-        return C_O1_I2(r, r, re);
-
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 7d0ccf90ec..ab6391b85a 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1278,6 +1278,24 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_add_w(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_add_d(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_add,
+    .out_rri = tcg_out_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1536,21 +1554,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_add_i32:
-        if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I32, a0, a1, a2);
-        } else {
-            tcg_out_opc_add_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_add_i64:
-        if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I64, a0, a1, a2);
-        } else {
-            tcg_out_opc_add_d(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_sub_i32:
         if (c2) {
             tcg_out_addi(s, TCG_TYPE_I32, a0, a1, -a2);
@@ -2297,11 +2300,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_add_i32:
-        return C_O1_I2(r, r, ri);
-    case INDEX_op_add_i64:
-        return C_O1_I2(r, r, rJ);
-
     case INDEX_op_and_i32:
     case INDEX_op_and_i64:
     case INDEX_op_nor_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 27069f1477..6ee7e7ccc0 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1678,6 +1678,28 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* Always indirect, nothing to do */
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_ADDU : OPC_DADDU;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_ADDIU : OPC_DADDIU;
+    tcg_out_opc_imm(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1755,12 +1777,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_add_i32:
-        i1 = OPC_ADDU, i2 = OPC_ADDIU;
-        goto do_binary;
-    case INDEX_op_add_i64:
-        i1 = OPC_DADDU, i2 = OPC_DADDIU;
-        goto do_binary;
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
         i1 = OPC_OR, i2 = OPC_ORI;
@@ -2213,9 +2229,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
-        return C_O1_I2(r, r, rJ);
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
         return C_O1_I2(r, rZ, rN);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index c0a2737a87..985f36f847 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2940,6 +2940,26 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, ADD | TAB(a0, a1, a2));
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mem_long(s, ADDI, ADD, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rT),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -3009,15 +3029,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-        do_addi_32:
-            tcg_out_mem_long(s, ADDI, ADD, a0, a1, (int32_t)a2);
-        } else {
-            tcg_out32(s, ADD | TAB(a0, a1, a2));
-        }
-        break;
     case INDEX_op_sub_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[1]) {
@@ -3027,8 +3038,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                 tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
             }
         } else if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_32;
+            tgen_addi(s, type, a0, a1, (int32_t)-a2);
         } else {
             tcg_out32(s, SUBF | TAB(a0, a2, a1));
         }
@@ -3223,15 +3233,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, NOR | SAB(args[1], args[0], args[1]));
         break;
 
-    case INDEX_op_add_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-        do_addi_64:
-            tcg_out_mem_long(s, ADDI, ADD, a0, a1, a2);
-        } else {
-            tcg_out32(s, ADD | TAB(a0, a1, a2));
-        }
-        break;
     case INDEX_op_sub_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[1]) {
@@ -3241,8 +3242,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                 tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
             }
         } else if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_64;
+            tgen_addi(s, type, a0, a1, -a2);
         } else {
             tcg_out32(s, SUBF | TAB(a0, a2, a1));
         }
@@ -4203,7 +4203,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add_i32:
     case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
@@ -4250,8 +4249,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
         return C_O1_I2(r, rI, ri);
-    case INDEX_op_add_i64:
-        return C_O1_I2(r, r, rT);
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rU);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 2d8b664dd7..3f8c3463c9 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1960,6 +1960,28 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_ADDW : OPC_ADD;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_ADDIW : OPC_ADDI;
+    tcg_out_opc_imm(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2022,21 +2044,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_add_i32:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_ADDW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_add_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDI, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_ADD, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_sub_i32:
         if (c2) {
             tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, -a2);
@@ -2658,11 +2665,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_add_i32:
     case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_add_i64:
     case INDEX_op_and_i64:
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 2dad61a971..dfd638a933 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2145,6 +2145,58 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* no need to flush icache explicitly */
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (a0 != a1) {
+        tcg_out_insn(s, RX, LA, a0, a1, a2, 0);
+    } else if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RR, AR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRE, AGR, a0, a2);
+    }
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a0 == a1) {
+        if (type == TCG_TYPE_I32) {
+            if (a2 == (int16_t)a2) {
+                tcg_out_insn(s, RI, AHI, a0, a2);
+            } else {
+                tcg_out_insn(s, RIL, AFI, a0, a2);
+            }
+            return;
+        }
+        if (a2 == (int16_t)a2) {
+            tcg_out_insn(s, RI, AGHI, a0, a2);
+            return;
+        }
+        if (a2 == (int32_t)a2) {
+            tcg_out_insn(s, RIL, AGFI, a0, a2);
+            return;
+        }
+        if (a2 == (uint32_t)a2) {
+            tcg_out_insn(s, RIL, ALGFI, a0, a2);
+            return;
+        }
+        if (-a2 == (uint32_t)-a2) {
+            tcg_out_insn(s, RIL, SLGFI, a0, -a2);
+            return;
+        }
+    }
+    tcg_out_mem(s, RX_LA, RXY_LAY, a0, a1, TCG_REG_NONE, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
         case glue(glue(INDEX_op_,x),_i64)
@@ -2201,30 +2253,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add_i32:
-        a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
-        if (const_args[2]) {
-        do_addi_32:
-            if (a0 == a1) {
-                if (a2 == (int16_t)a2) {
-                    tcg_out_insn(s, RI, AHI, a0, a2);
-                    break;
-                }
-                tcg_out_insn(s, RIL, AFI, a0, a2);
-                break;
-            }
-            tcg_out_mem(s, RX_LA, RXY_LAY, a0, a1, TCG_REG_NONE, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RR, AR, a0, a2);
-        } else {
-            tcg_out_insn(s, RX, LA, a0, a1, a2, 0);
-        }
-        break;
     case INDEX_op_sub_i32:
-        a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_32;
+            tgen_addi(s, type, a0, a1, (int32_t)-a2);
         } else if (a0 == a1) {
             tcg_out_insn(s, RR, SR, a0, a2);
         } else {
@@ -2500,40 +2532,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-        do_addi_64:
-            if (a0 == a1) {
-                if (a2 == (int16_t)a2) {
-                    tcg_out_insn(s, RI, AGHI, a0, a2);
-                    break;
-                }
-                if (a2 == (int32_t)a2) {
-                    tcg_out_insn(s, RIL, AGFI, a0, a2);
-                    break;
-                }
-                if (a2 == (uint32_t)a2) {
-                    tcg_out_insn(s, RIL, ALGFI, a0, a2);
-                    break;
-                }
-                if (-a2 == (uint32_t)-a2) {
-                    tcg_out_insn(s, RIL, SLGFI, a0, -a2);
-                    break;
-                }
-            }
-            tcg_out_mem(s, RX_LA, RXY_LAY, a0, a1, TCG_REG_NONE, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RRE, AGR, a0, a2);
-        } else {
-            tcg_out_insn(s, RX, LA, a0, a1, a2, 0);
-        }
-        break;
     case INDEX_op_sub_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_64;
+            tgen_addi(s, type, a0, a1, -a2);
         } else {
             tcg_out_insn(s, RRFa, SGRK, a0, a1, a2);
         }
@@ -3259,8 +3261,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index eb5c839933..40b56b0a74 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1288,6 +1288,26 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 {
 }
 
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_ADD);
+}
+
+static void tgen_addi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_ADD);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_add,
+    .out_rri = tgen_addi,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1341,9 +1361,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_st32_i64:
         tcg_out_ldst(s, a0, a1, a2, STW);
         break;
-    OP_32_64(add):
-        c = ARITH_ADD;
-        goto gen_arith;
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
@@ -1575,8 +1592,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_a64_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_div_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 3a5beded2f..fbf0f7a073 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -91,8 +91,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
@@ -665,6 +663,18 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* Always indirect, nothing to do */
 }
 
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_add_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_add,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -706,7 +716,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(add)
     CASE_32_64(sub)
     CASE_32_64(mul)
     CASE_32_64(and)
-- 
2.43.0


