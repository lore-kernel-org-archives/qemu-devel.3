Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA077E7719B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bb-0004k1-UT; Tue, 07 Jan 2025 03:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ab-0000Yk-Nu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:27 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aQ-0003Oc-A0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:21 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2166651f752so25350475ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237112; x=1736841912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOz/pWH9i2VFSk5K6K2ngHWWEmRH9ANsA8xVqZKCyxY=;
 b=MWybEtJVoevRIPdz4u4USH90e/lph0q/gaYt4RIuOzUO1Cb56RmdMRL57hIB56Y9oV
 OuGSo0MFY6EY8yuKY9RrZ2sVuZPlWolR7zPt5x/sxUEdD7LHhhS/28rS2yHXHlOH8FVF
 Fr/t+cZJVxjt0BYYMbOLx0hkabPyxtbrO8ROrQ+dmdYXuMdR/mWiU7l4ZCQ29hwDlILt
 B6vt4TzVzR2JryIYJP4FNhgrV4PLVfnGSaAWL0czBclxhF7S0fGxyrHB4Od4GeZy9+oq
 EwFC27oEBDMC8HFKD7wL4M/3U9evUhNDpFpdACt6XatuUQSZbArSPRkGJo0TvivuHmjy
 QNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237112; x=1736841912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOz/pWH9i2VFSk5K6K2ngHWWEmRH9ANsA8xVqZKCyxY=;
 b=ZCRUBw7gEmj0xPfIZx1skmsVnONJniNn1GqNqrNTq8ualJs9UbqiVRJUqcKEQLrttg
 7WXXhPjcIR1v/62+6IdI95MW22PeHpJbjmi6dM1Y1ClmNnG8BwxwKtaRKMBhnVdRQj1c
 iG8AQfwShmWb/ZGXrwPBewxGZvKhpLHwUbC0L8Encxk8Zzt6flZkgmawV8Jb90QkYAdk
 ymhELaJfyFN1sMjtHctlhdAwzNr5TNL2eo06CGzLAqrWCPU1hJuMEBMI84M+sPfdlJKe
 8x77E/SnaCFAdL5m+NWriwaL7m4nPPGmKZxnTvVbcoWpSmFkOSS6CH5U62ntGan5+maq
 HJ3g==
X-Gm-Message-State: AOJu0YwJ1e2tZ5XY/+gqQ7T6mgy1/K2KwNM4UHbhynS+nzvPgb1XOBe7
 Q9Gv93UGDC8Zm4EkkAtXmKO1PIFVD9XRYTSISuSELGLEBjgqxRC/3q66fEtQIOfO07oV9/lQrvh
 c
X-Gm-Gg: ASbGncvakxnB8+v8zdPDuwHSQYVfsEhVe7I93k+Fg0DTI3LHJkaHBAUhKQTGqUQUjL8
 L+8qs25lMthtOiYqtxlJNIHj7ltPyBWHDVH73M5AGNFfChW9Y/0JGk6x2Jx3rjjPrBmNhJqwhE+
 dtuNkCJM138DOB3qaEHiegK0DUpAhPcvmVBHEI35IOcYfjPO1hEwM881mWz4nxMIHTG7loLY5hW
 41D2GHv0jsfukMRBYmdNgqYjEItwqr5d7tWJQ8/EWyl2rWMofQmDbVsLaJgSglworh94yJHu7QQ
 xwa1z9VI02NEHWGyog==
X-Google-Smtp-Source: AGHT+IFhXz0IXXI0BB3U7V/JMpiWna+eDzng6yjZqikI9ibNf2kgCdGTgUMEoq9UdHEe7G2+ArziCQ==
X-Received: by 2002:a05:6a20:2d1f:b0:1e1:b1e4:e750 with SMTP id
 adf61e73a8af0-1e5e04717a2mr90309771637.18.1736237112433; 
 Tue, 07 Jan 2025 00:05:12 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 54/81] tcg: Convert and to TCGOutOpBinary
Date: Tue,  7 Jan 2025 00:00:45 -0800
Message-ID: <20250107080112.1175095-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 tcg/aarch64/tcg-target.c.inc     | 31 ++++++++++--------
 tcg/arm/tcg-target.c.inc         | 41 +++++++++++++++++-------
 tcg/i386/tcg-target.c.inc        | 27 ++++++++++++----
 tcg/loongarch64/tcg-target.c.inc | 29 ++++++++++-------
 tcg/mips/tcg-target.c.inc        | 55 +++++++++++++++++++-------------
 tcg/ppc/tcg-target.c.inc         | 40 ++++++++++++-----------
 tcg/riscv/tcg-target.c.inc       | 29 ++++++++++-------
 tcg/s390x/tcg-target.c.inc       | 48 +++++++++++++++-------------
 tcg/sparc64/tcg-target.c.inc     | 23 ++++++++++---
 tcg/tci/tcg-target.c.inc         | 14 ++++++--
 11 files changed, 216 insertions(+), 125 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 220ddfb066..2bdf958e61 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -992,6 +992,8 @@ static const TCGOutOp outop_notreached = {
 static const TCGOutOp * const all_outop[NB_OPS] = {
     [0 ... NB_OPS - 1] = &outop_notreached,
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
+    OUTOP(INDEX_op_and_i32, TCGOutOpBinary, outop_and),
+    OUTOP(INDEX_op_and_i64, TCGOutOpBinary, outop_and),
 };
 
 #undef OUTOP
@@ -5427,6 +5429,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_add:
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 34f45b2d7b..8da2703bb4 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2128,6 +2128,24 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3510, AND, type, a0, a1, a2);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_logicali(s, I3404_ANDI, type, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rL),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2213,17 +2231,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_and_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_and_i64:
-        if (c2) {
-            tcg_out_logicali(s, I3404_ANDI, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3510, AND, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_andc_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -3021,8 +3028,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index c7ed6f7b6e..87571f2621 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -880,17 +880,23 @@ static void tcg_out_dat_rI(TCGContext *s, ARMCond cond, ARMInsn opc,
  * Emit either the reg,imm or reg,reg form of a data-processing insn.
  * rhs must satisfy the "rIK" constraint.
  */
+static void tcg_out_dat_IK(TCGContext *s, ARMCond cond, ARMInsn opc,
+                            ARMInsn opinv, TCGReg dst, TCGReg lhs, TCGArg rhs)
+{
+    int imm12 = encode_imm(rhs);
+    if (imm12 < 0) {
+        imm12 = encode_imm_nofail(~rhs);
+        opc = opinv;
+    }
+    tcg_out_dat_imm(s, cond, opc, dst, lhs, imm12);
+}
+
 static void tcg_out_dat_rIK(TCGContext *s, ARMCond cond, ARMInsn opc,
                             ARMInsn opinv, TCGReg dst, TCGReg lhs, TCGArg rhs,
                             bool rhs_is_const)
 {
     if (rhs_is_const) {
-        int imm12 = encode_imm(rhs);
-        if (imm12 < 0) {
-            imm12 = encode_imm_nofail(~rhs);
-            opc = opinv;
-        }
-        tcg_out_dat_imm(s, cond, opc, dst, lhs, imm12);
+        tcg_out_dat_IK(s, cond, opc, opinv, dst, lhs, rhs);
     } else {
         tcg_out_dat_reg(s, cond, opc, dst, lhs, rhs, SHIFT_IMM_LSL(0));
     }
@@ -1872,6 +1878,24 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_AND, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_IK(s, COND_AL, ARITH_AND, ARITH_BIC, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rIK),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1934,10 +1958,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             args[0], args[1], args[2], const_args[2]);
         }
         break;
-    case INDEX_op_and_i32:
-        tcg_out_dat_rIK(s, COND_AL, ARITH_AND, ARITH_BIC,
-                        args[0], args[1], args[2], const_args[2]);
-        break;
     case INDEX_op_andc_i32:
         tcg_out_dat_rIK(s, COND_AL, ARITH_BIC, ARITH_AND,
                         args[0], args[1], args[2], const_args[2]);
@@ -2213,7 +2233,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
 
-    case INDEX_op_and_i32:
     case INDEX_op_andc_i32:
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 01699c0434..6d8c7a8d5c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2660,6 +2660,26 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_AND + rexw, a0, a2);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_AND + rexw, a0, a2, 0);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, 0, reZ),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2745,9 +2765,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(and):
-        c = ARITH_AND;
-        goto gen_arith;
     OP_32_64(or):
         c = ARITH_OR;
         goto gen_arith;
@@ -3720,10 +3737,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_xor_i64:
         return C_O1_I2(r, 0, re);
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-        return C_O1_I2(r, 0, reZ);
-
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
         return C_O1_I2(r, r, rI);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index ab6391b85a..a0c57dad40 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1295,6 +1295,24 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tcg_out_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_and(s, a0, a1, a2);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg rd, TCGReg rs, tcg_target_long imm)
+{
+    tcg_out_opc_andi(s, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rU),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1365,15 +1383,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-        if (c2) {
-            tcg_out_opc_andi(s, a0, a1, a2);
-        } else {
-            tcg_out_opc_and(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
         if (c2) {
@@ -2300,8 +2309,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
     case INDEX_op_or_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 6ee7e7ccc0..2fd88b4ab8 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1699,6 +1699,38 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_AND, a0, a1, a2);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int msb;
+
+    if (a2 == (uint16_t)a2) {
+        tcg_out_opc_imm(s, OPC_ANDI, a0, a1, a2);
+        return;
+    }
+
+    tcg_debug_assert(use_mips32r2_instructions);
+    tcg_debug_assert(is_p2m1(a2));
+    msb = ctz64(~a2) - 1;
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_bf(s, OPC_EXT, a0, a1, msb, 0);
+    } else {
+        tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU, a0, a1, msb, 0);
+    }
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rIK),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1804,26 +1836,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             break;
         }
         goto do_binaryv;
-    case INDEX_op_and_i32:
-        if (c2 && a2 != (uint16_t)a2) {
-            int msb = ctz32(~a2) - 1;
-            tcg_debug_assert(use_mips32r2_instructions);
-            tcg_debug_assert(is_p2m1(a2));
-            tcg_out_opc_bf(s, OPC_EXT, a0, a1, msb, 0);
-            break;
-        }
-        i1 = OPC_AND, i2 = OPC_ANDI;
-        goto do_binary;
-    case INDEX_op_and_i64:
-        if (c2 && a2 != (uint16_t)a2) {
-            int msb = ctz64(~a2) - 1;
-            tcg_debug_assert(use_mips32r2_instructions);
-            tcg_debug_assert(is_p2m1(a2));
-            tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU, a0, a1, msb, 0);
-            break;
-        }
-        i1 = OPC_AND, i2 = OPC_ANDI;
-        goto do_binary;
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
         i1 = OPC_NOR;
@@ -2256,9 +2268,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-        return C_O1_I2(r, r, rIK);
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
     case INDEX_op_or_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 985f36f847..7d282bc7aa 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2959,6 +2959,28 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, AND | SAB(a1, a0, a2));
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_andi32(s, a0, a1, a2);
+    } else {
+        tcg_out_andi64(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -3044,22 +3066,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_andi32(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, AND | SAB(a1, a0, a2));
-        }
-        break;
-    case INDEX_op_and_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_andi64(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, AND | SAB(a1, a0, a2));
-        }
-        break;
     case INDEX_op_or_i64:
     case INDEX_op_or_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
@@ -4203,7 +4209,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
     case INDEX_op_andc_i32:
@@ -4214,7 +4219,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_andc_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 3f8c3463c9..8f178a5eb7 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1981,6 +1981,24 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_AND, a0, a1, a2);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_opc_imm(s, OPC_ANDI, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rI),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2059,15 +2077,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_AND, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
         if (c2) {
@@ -2665,10 +2674,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
     case INDEX_op_setcond_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index dfd638a933..4a2661c7ff 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2196,6 +2196,31 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, NGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, NR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, NRK, a0, a1, a2);
+    }
+}
+
+static void tgen_andi_3(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    tgen_andi(s, type, a0, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rNKR),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi_3,
+};
+
 
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_,x),_i32): \
@@ -2264,17 +2289,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_andi(s, TCG_TYPE_I32, a0, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RR, NR, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, NRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_or_i32:
         a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
         if (const_args[2]) {
@@ -2541,15 +2555,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_andi(s, TCG_TYPE_I64, args[0], args[2]);
-        } else {
-            tcg_out_insn(s, RRFa, NGRK, a0, a1, a2);
-        }
-        break;
     case INDEX_op_or_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
@@ -3280,12 +3285,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_and_i64:
-        return C_O1_I2(r, r, rNKR);
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rK);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 40b56b0a74..7af1f9824d 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1307,6 +1307,24 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_AND);
+}
+
+static void tgen_andi(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_arithi(s, a0, a1, a2, ARITH_AND);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_and,
+    .out_rri = tgen_andi,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1364,9 +1382,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(and):
-        c = ARITH_AND;
-        goto gen_arith;
     OP_32_64(andc):
         c = ARITH_ANDN;
         goto gen_arith;
@@ -1600,8 +1615,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
     case INDEX_op_or_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 8b54ee2da7..fe0ad71b57 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -95,8 +95,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
     case INDEX_op_eqv_i32:
@@ -672,6 +670,17 @@ static const TCGOutOpBinary outop_add = {
     .out_rrr = tgen_add,
 };
 
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_and_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_and,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -716,7 +725,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     CASE_32_64(sub)
     CASE_32_64(mul)
-    CASE_32_64(and)
     CASE_32_64(or)
     CASE_32_64(xor)
     CASE_32_64(andc)     /* Optional (TCG_TARGET_HAS_andc_*). */
-- 
2.43.0


