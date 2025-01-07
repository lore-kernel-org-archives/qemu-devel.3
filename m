Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE673E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4be-00058F-8Y; Tue, 07 Jan 2025 03:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aj-0000kv-MM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:36 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ab-0003c0-Cr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:33 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21631789fcdso162843435ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237124; x=1736841924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6aOh1Z1nmOJUKiYfQL4t8LhyVkzhmmYsSMjX54U464=;
 b=q0g1ZIeFcAOy0CqR8ga1pd8HNXWNUho7AAwzVCZHFXbH33j86/PbFgaJgDTBhak2oS
 wxzr4k1zPDdXV4UEHvVa9obtOE940r98dsBT9LUI4X6Th3FlvX62dNjh8Z5VPz+hHEc4
 objSaFNh0ckyrdZPC+Sqvg9XCxGpb3xJcXolli8xANorKufaGMhv8siJt7T+WPsXvwff
 qOpnLDSNHRET1EV0yMM0UudhfMq+Ta2nj5GvAmO0P6zYhEeU+Z+0BZQ/sVajRZgA3tBi
 +y3rTpWsV/fUZ3d8xI08leWpqebJKrkEXV0Cgbgdt+VIVUuYQ/uLVPCzUsw5lb36zUhV
 7L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237124; x=1736841924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6aOh1Z1nmOJUKiYfQL4t8LhyVkzhmmYsSMjX54U464=;
 b=iBfImcCK9JQSPsK6gzYTyMjx79p4r7FUYpaLhz4tgLmtokYwmMpsKlmUxMpsYSlUZ7
 +EqF5ILyyCyr4yaAdh6oNqvYFUhwAXvUbeTwW0j/xqXFtzCBC/LWLbGcclXTo1X5WSxg
 Yfh+iNuoLiXFD23KKqnGEVlDC3hcrz9LnuITrA3AbSgDr5UoGz2EriPrWFJ7ESnjwNJz
 JyR2zXooUFQBjzvqUJ/bGTETU23RykJPjvnTJVFjRZk5siqMsen4ssZwrKmaTxg47fdv
 85Af9MKnhVcL1lbi7pk2J7LUoHHLE6BowOQBqK+dn7o5L+/4WeYIMMCxZTTmIkxI8R21
 7AUA==
X-Gm-Message-State: AOJu0YznmhFNpI+5b7Lmj8Re4wXHu/p7MbvpwRpA7qrH7O9gP2n5KeSP
 rEr6X3g8aSKeBc1JoovPxWg18OlEE3lcPAfZgBmPUdNYvfrHOhfXGBUALle9/celWRIFM2boCyq
 2
X-Gm-Gg: ASbGnctuFELFXXe2ByZet/RnUFSWRQg1b9pdsE6JQSRXwZvjdvXUKRs8Tk4hiMKiZ5L
 8TmWMNisLTo4qXY6N48tDO1EsEd5tWusoxbjm0vtlY9bpeipkukMWY5qeTO2IRKUs30gPAhZnKS
 8DhPVuFt4WNyIxkT4Qe874QC5imtpSnHrc2+OXhUo12ObGLlATgWsm3QJhaQqnqF0zzYTToAHam
 WDczCIx641zIGW9UM0alVuEvBlalkmsMlHK9Vj42MvNdpyOxPxNt1kaDdKIgWM0JJRY6szTXahk
 453SnIf3nVKHFOaUwA==
X-Google-Smtp-Source: AGHT+IEbp7AvikveavJNosNfjXpxrfmGr8OBFBzmGSW9cjzW0djC9RYOAHiGCIvsCEAKVuDg94NM4A==
X-Received: by 2002:aa7:8205:0:b0:72a:78a3:7f57 with SMTP id
 d2e1a72fcca58-72d103c9c66mr2584300b3a.9.1736237123721; 
 Tue, 07 Jan 2025 00:05:23 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 65/81] tcg: Convert xor to TCGOutOpBinary
Date: Tue,  7 Jan 2025 00:00:56 -0800
Message-ID: <20250107080112.1175095-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 tcg/tcg.c                        |  4 +++
 tcg/aarch64/tcg-target.c.inc     | 31 +++++++++++---------
 tcg/arm/tcg-target.c.inc         | 25 +++++++++++-----
 tcg/i386/tcg-target.c.inc        | 27 ++++++++++++-----
 tcg/loongarch64/tcg-target.c.inc | 29 +++++++++++-------
 tcg/mips/tcg-target.c.inc        | 28 +++++++++++-------
 tcg/ppc/tcg-target.c.inc         | 30 +++++++++++--------
 tcg/riscv/tcg-target.c.inc       | 29 +++++++++++-------
 tcg/s390x/tcg-target.c.inc       | 50 ++++++++++++++++----------------
 tcg/sparc64/tcg-target.c.inc     | 23 +++++++++++----
 tcg/tci/tcg-target.c.inc         | 14 +++++++--
 11 files changed, 186 insertions(+), 104 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1d043254dd..2e068299ff 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -996,6 +996,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
+    OUTOP(INDEX_op_xor_i32, TCGOutOpBinary, outop_xor),
+    OUTOP(INDEX_op_xor_i64, TCGOutOpBinary, outop_xor),
 };
 
 #undef OUTOP
@@ -5425,6 +5427,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_or:
     case INDEX_op_orc:
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index e6960366bc..52aba83936 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2186,6 +2186,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3510, EOR, type, a0, a1, a2);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_logicali(s, I3404_EORI, type, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rL),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2271,17 +2289,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_xor_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_xor_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_EORI, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3510, EOR, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_eqv_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -3035,8 +3042,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
         return C_O1_I2(r, r, rL);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 9e66a3be92..b7deca60f1 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1929,6 +1929,24 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_EOR, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_imm(s, COND_AL, ARITH_EOR, a0, a1, encode_imm_nofail(a2));
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1991,10 +2009,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             args[0], args[1], args[2], const_args[2]);
         }
         break;
-    case INDEX_op_xor_i32:
-        c = ARITH_EOR;
-        tcg_out_dat_rI(s, COND_AL, c, args[0], args[1], args[2], const_args[2]);
-        break;
     case INDEX_op_add2_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
         a3 = args[3], a4 = args[4], a5 = args[5];
@@ -2270,9 +2284,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
 
-    case INDEX_op_xor_i32:
-        return C_O1_I2(r, r, rI);
-
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index c312950477..20bf02fb3c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2722,6 +2722,26 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_XOR + rexw, a0, a2);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_XOR + rexw, a0, a2, 0);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2806,11 +2826,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     OP_32_64(sub):
         c = ARITH_SUB;
-        goto gen_arith;
-    OP_32_64(xor):
-        c = ARITH_XOR;
-        goto gen_arith;
-    gen_arith:
         if (const_a2) {
             tgen_arithi(s, c + rexw, a0, a2, 0);
         } else {
@@ -3761,8 +3776,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
         return C_O1_I2(r, 0, re);
 
     case INDEX_op_shl_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 0b91380e52..5afc825396 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1352,6 +1352,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_xor(s, a0, a1, a2);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg rd, TCGReg rs, tcg_target_long imm)
+{
+    tcg_out_opc_xori(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1402,15 +1420,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
-        if (c2) {
-            tcg_out_opc_xori(s, a0, a1, a2);
-        } else {
-            tcg_out_opc_xor(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_extract_i32:
         if (a2 == 0 && args[3] <= 12) {
             tcg_out_opc_andi(s, a0, a1, (1 << args[3]) - 1);
@@ -2310,8 +2319,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
         /* LoongArch reg-imm bitops have their imms ZERO-extended */
         return C_O1_I2(r, r, rU);
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 6ace0c501d..2a5546d710 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1757,6 +1757,24 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_XOR, a0, a1, a2);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_XORI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1835,13 +1853,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
-        i1 = OPC_XOR, i2 = OPC_XORI;
-        if (c2) {
-            tcg_out_opc_imm(s, i2, a0, a1, a2);
-            break;
-        }
     do_binaryv:
         tcg_out_opc_reg(s, i1, a0, a1, a2);
         break;
@@ -2289,9 +2300,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
-        return C_O1_I2(r, r, rI);
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b8e80ca8a9..044f41748f 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3021,6 +3021,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, XOR | SAB(a1, a0, a2));
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_xori32(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3106,15 +3124,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i64:
-    case INDEX_op_xor_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_xori32(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, XOR | SAB(a1, a0, a2));
-        }
-        break;
     case INDEX_op_eqv_i32:
         if (const_args[2]) {
             tcg_out_xori32(s, args[0], args[1], ~args[2]);
@@ -4215,7 +4224,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_xor_i32:
     case INDEX_op_eqv_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -4254,8 +4262,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
         return C_O1_I2(r, rI, ri);
-    case INDEX_op_xor_i64:
-        return C_O1_I2(r, r, rU);
     case INDEX_op_sub_i64:
         return C_O1_I2(r, rI, rT);
     case INDEX_op_clz_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 0712a24d1c..4d034712f7 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2046,6 +2046,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_XOR, a0, a1, a2);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_XORI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2124,15 +2142,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_XORI, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_XOR, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
         if (c2) {
@@ -2696,8 +2705,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 159fe925b6..585d0a73f8 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2283,6 +2283,31 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, XGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, XR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, XRK, a0, a1, a2);
+    }
+}
+
+static void tgen_xori_3(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    tgen_xori(s, a0, type == TCG_TYPE_I32 ? (uint32_t)a2 : a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rK),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori_3,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2351,18 +2376,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tcg_out_insn(s, RIL, XILF, a0, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RR, XR, args[0], args[2]);
-        } else {
-            tcg_out_insn(s, RRFa, XRK, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_eqv_i32:
         a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
@@ -2588,16 +2601,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_xori(s, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, XGRK, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_eqv_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
@@ -3291,10 +3294,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_xor_i32:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_xor_i64:
-        return C_O1_I2(r, r, rK);
 
     case INDEX_op_eqv_i32:
         return C_O1_I2(r, r, ri);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 343faf099f..28150cd5b0 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1365,6 +1365,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_XOR);
+}
+
+static void tgen_xori(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_XOR);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_xor,
+    .out_rri = tgen_xori,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1422,9 +1440,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(xor):
-        c = ARITH_XOR;
-        goto gen_arith;
     case INDEX_op_shl_i32:
         c = SHIFT_SLL;
     do_shift32:
@@ -1646,8 +1661,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index c1d975cb0b..ba93a56409 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -101,8 +101,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_nand_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
@@ -708,6 +706,17 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_xor_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_xor,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -752,7 +761,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     CASE_32_64(sub)
     CASE_32_64(mul)
-    CASE_32_64(xor)
     CASE_32_64(eqv)      /* Optional (TCG_TARGET_HAS_eqv_*). */
     CASE_32_64(nand)     /* Optional (TCG_TARGET_HAS_nand_*). */
     CASE_32_64(nor)      /* Optional (TCG_TARGET_HAS_nor_*). */
-- 
2.43.0


