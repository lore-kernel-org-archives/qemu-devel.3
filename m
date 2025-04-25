Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB61C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R1A-0007cN-P1; Fri, 25 Apr 2025 17:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R14-0007ZU-AW
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:26 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R10-0000a5-GO
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:25 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso2803930b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618121; x=1746222921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yu8o8UgGA5ETnx7OOGJVjhqoFtPY94XL3a6gSMvjQmc=;
 b=M0ctqu4D2q3eAY4kgtFGzLa2dezqgIIYe6a7MEDnmr3Su8TNt+oseWP01Xeq0+V26T
 V0laaEN2JrNOMPphzn15Fjzs30F2xmP4A5ZGdtTZpq8LRGQjkB4XjZ5vQarxoME1XfWx
 D9/qiwDoSkyQMT1JqorEzewNF1WijS+rrRg6jaK+kptPKDG4GRuoaYXrBllhXhfUge4K
 TY2L1AeOYUUcpUEI+a53mosye8xc55EEgRA8l2D9Fsd8Pgx3dJPtkU7M9fp5FVfOd17T
 pDYtSTjnOvBm1Tbr1jV/BZrzPQ59pIIYXNu3zMNU5vdi57X92JzVgnGvDNMVZK3tykDr
 OPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618121; x=1746222921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yu8o8UgGA5ETnx7OOGJVjhqoFtPY94XL3a6gSMvjQmc=;
 b=kNOJP+mTUfYV2VoJ1vpwzgM1FlZK+sqNWuTjK59JwOXSsKgFUUk+HY4BcSibYXEo69
 4lwGXHheN+5/BOf34iKg1hCqkx7TL2IRagcpJprtlBKA+lhHcbdFsIJpv7Zf4UAEspxb
 8rlTVUJDiZvNBGMQ1HKohm/cN+viOoDjhjDrcU8N0igHCPPiBrnljGW4SQQzGTpwclCw
 Jh7LF8wzwvYVZL+FRoeBX5YEshuqpLApqDPiKAgkR69qR4G6bQZ4PfKm3NKcAoxdl+ba
 FrqgxljfkwuomtBxVLM58/sZ2QSoajsHNaS0w5AotOM7lqn9mKxFzCVRUM/iT7e/Ic7Z
 5i5w==
X-Gm-Message-State: AOJu0YylgJqljCsMuKZ9uFSCmblR0z8j7Y2vo3dn5W4NnD/DxggS4SvF
 J8IHzPtXO2jE0f4SCpxAoGspQQP2oyOQLT6cafRK5N+k9K8ugF6cG8smN3kRAp3TAo5d5OUz5ln
 o
X-Gm-Gg: ASbGncvm1E3maXU6vMOJOzQfYRZC/k+uNlQIkPNMA3xqLYxi6fnNS1ZLcjLVzLh4ggd
 OqhFzLFUaqQFWB7BWVsWW2gNCGHoVMhPeCSy2mScG95Dfq/bsyCKYC7k7oNXKjTfMpyGc+vH47P
 QtYNB1kEXTCYsrWStMiVCPy8meL+LFdLyyPNMIISZIQfiJI00ky1GPALxZh2PdIrpcxymGMFZA2
 zoTagb4Bhr5BUX15isOVFn1Cmx9ec+rlyZS1sD7EHskDBIvshXshJzgezf7fq1cxxdD35RnuNYQ
 T5iAApKTQqObINPLKJtb32W3wWCcfcRVQhz74iMEZwXZ1Bnh66jOo3Bzh6b35DmqScJU7p7uyQk
 =
X-Google-Smtp-Source: AGHT+IG5h7AiUPYczFd6+IIxwH6GpjZDALiGDy32rsJX/0xazbVtATeygIM4sQkPe0UwBJY4AI7BsA==
X-Received: by 2002:a05:6a00:3d46:b0:736:a7ec:a366 with SMTP id
 d2e1a72fcca58-73fd70d880amr4360022b3a.9.1745618121092; 
 Fri, 25 Apr 2025 14:55:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 035/159] tcg: Convert neg to TCGOutOpUnary
Date: Fri, 25 Apr 2025 14:52:49 -0700
Message-ID: <20250425215454.886111-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 21 +++++++++++++++++++--
 tcg/aarch64/tcg-target.c.inc     | 18 +++++++++++-------
 tcg/arm/tcg-target.c.inc         | 14 ++++++++++----
 tcg/i386/tcg-target.c.inc        | 16 +++++++++++-----
 tcg/loongarch64/tcg-target.c.inc | 19 ++++++++++---------
 tcg/mips/tcg-target.c.inc        | 18 ++++++++++--------
 tcg/ppc/tcg-target.c.inc         | 17 ++++++++++-------
 tcg/riscv/tcg-target.c.inc       | 19 ++++++++++---------
 tcg/s390x/tcg-target.c.inc       | 22 ++++++++++++++--------
 tcg/sparc64/tcg-target.c.inc     | 15 ++++++++++-----
 tcg/tci/tcg-target.c.inc         | 13 ++++++++++---
 11 files changed, 125 insertions(+), 67 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index b31e9798c5..b5de69e4a9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -986,6 +986,11 @@ typedef struct TCGOutOpBinary {
                     TCGReg a0, TCGReg a1, tcg_target_long a2);
 } TCGOutOpBinary;
 
+typedef struct TCGOutOpUnary {
+    TCGOutOp base;
+    void (*out_rr)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1);
+} TCGOutOpUnary;
+
 typedef struct TCGOutOpSubtract {
     TCGOutOp base;
     void (*out_rrr)(TCGContext *s, TCGType type,
@@ -1017,6 +1022,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
+    OUTOP(INDEX_op_neg_i32, TCGOutOpUnary, outop_neg),
+    OUTOP(INDEX_op_neg_i64, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
@@ -2240,7 +2247,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -2309,7 +2315,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
@@ -5471,6 +5476,18 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_neg_i32:
+    case INDEX_op_neg_i64:
+        {
+            const TCGOutOpUnary *out =
+                container_of(all_outop[op->opc], TCGOutOpUnary, base);
+
+            /* Constants should have been folded. */
+            tcg_debug_assert(!const_args[1]);
+            out->out_rr(s, type, new_args[0], new_args[1]);
+        }
+        break;
+
     default:
         if (def->flags & TCG_OPF_VECTOR) {
             tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index dfe67c1261..cf7a3f2632 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2235,6 +2235,17 @@ static const TCGOutOpBinary outop_xor = {
 };
 
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_sub(s, type, a0, TCG_REG_XZR, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -2301,11 +2312,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_neg_i64:
-    case INDEX_op_neg_i32:
-        tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
-        break;
-
     case INDEX_op_not_i64:
     case INDEX_op_not_i32:
         tcg_out_insn(s, 3510, ORN, ext, a0, TCG_REG_XZR, a1);
@@ -2990,8 +2996,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_bswap16_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 13b78f0ada..5ea4488606 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1951,6 +1951,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_subfi(s, type, a0, 0, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2040,9 +2050,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
-    case INDEX_op_neg_i32:
-        tcg_out_dat_imm(s, COND_AL, ARITH_RSB, args[0], args[1], 0);
-        break;
     case INDEX_op_not_i32:
         tcg_out_dat_reg(s, COND_AL,
                         ARITH_MVN, args[0], 0, args[1], SHIFT_IMM_LSL(0));
@@ -2226,7 +2233,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 104f1b010a..082aa982fb 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2701,6 +2701,17 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, a0);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, 0),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2900,9 +2911,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(neg):
-        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, a0);
-        break;
     OP_32_64(not):
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, a0);
         break;
@@ -3719,8 +3727,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index f01b19463b..31ec7262e0 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1409,6 +1409,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1611,13 +1621,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_neg_i32:
-        tcg_out_opc_sub_w(s, a0, TCG_REG_ZERO, a1);
-        break;
-    case INDEX_op_neg_i64:
-        tcg_out_opc_sub_d(s, a0, TCG_REG_ZERO, a1);
-        break;
-
     case INDEX_op_mul_i32:
         tcg_out_opc_mul_w(s, a0, a1, a2);
         break;
@@ -2272,8 +2275,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_extract_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 15c5661fb8..0fda255a7b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1783,6 +1783,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1975,12 +1985,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_reg(s, OPC_MFHI, a1, 0, 0);
         break;
 
-    case INDEX_op_neg_i32:
-        i1 = OPC_SUBU;
-        goto do_unary;
-    case INDEX_op_neg_i64:
-        i1 = OPC_DSUBU;
-        goto do_unary;
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
         i1 = OPC_NOR;
@@ -2195,7 +2199,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
@@ -2208,7 +2211,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index bfbfdc2dfa..da45436a5a 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3052,6 +3052,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out32(s, NEG | RT(a0) | RA(a1));
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3224,11 +3234,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond2(s, args, const_args);
         break;
 
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
-        tcg_out32(s, NEG | RT(args[0]) | RA(args[1]));
-        break;
-
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
         tcg_out32(s, NOR | SAB(args[1], args[0], args[1]));
@@ -4119,7 +4124,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_ctpop_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
@@ -4133,7 +4137,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_ctpop_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 54da432ab1..4e16c44aa5 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2077,6 +2077,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tgen_sub(s, type, a0, TCG_REG_ZERO, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2145,13 +2155,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
         break;
 
-    case INDEX_op_neg_i32:
-        tcg_out_opc_reg(s, OPC_SUBW, a0, TCG_REG_ZERO, a1);
-        break;
-    case INDEX_op_neg_i64:
-        tcg_out_opc_reg(s, OPC_SUB, a0, TCG_REG_ZERO, a1);
-        break;
-
     case INDEX_op_mul_i32:
         tcg_out_opc_reg(s, OPC_MULW, a0, a1, a2);
         break;
@@ -2660,7 +2663,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_not_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -2669,7 +2671,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_not_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 662984f733..08e65834d7 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2373,6 +2373,20 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori_3,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RR, LCR, a0, a1);
+    } else {
+        tcg_out_insn(s, RRE, LCGR, a0, a1);
+    }
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2430,9 +2444,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_neg_i32:
-        tcg_out_insn(s, RR, LCR, args[0], args[1]);
-        break;
     case INDEX_op_not_i32:
         tcg_out_insn(s, RRFa, NORK, args[0], args[1], args[1]);
         break;
@@ -2624,9 +2635,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_neg_i64:
-        tcg_out_insn(s, RRE, LCGR, args[0], args[1]);
-        break;
     case INDEX_op_not_i64:
         tcg_out_insn(s, RRFa, NOGRK, args[0], args[1], args[1]);
         break;
@@ -3323,8 +3331,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 04b2b3b195..a3926ea1c3 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1403,6 +1403,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rri = tgen_xori,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+     tgen_sub(s, type, a0, TCG_REG_G0, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1473,9 +1483,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         c = ARITH_UMUL;
         goto gen_arith;
 
-    OP_32_64(neg):
-	c = ARITH_SUB;
-	goto gen_arith1;
     OP_32_64(not):
 	c = ARITH_ORN;
 	goto gen_arith1;
@@ -1639,8 +1646,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 67a46c6321..200b256e73 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -57,8 +57,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
@@ -731,6 +729,16 @@ static const TCGOutOpBinary outop_xor = {
     .out_rrr = tgen_xor,
 };
 
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, glue(INDEX_op_neg_i,TCG_TARGET_REG_BITS), a0, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -804,7 +812,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rl(s, opc, TCG_REG_TMP, arg_label(args[3]));
         break;
 
-    CASE_32_64(neg)      /* Optional (TCG_TARGET_HAS_neg_*). */
     CASE_32_64(not)      /* Optional (TCG_TARGET_HAS_not_*). */
     CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
     case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap32_i32). */
-- 
2.43.0


