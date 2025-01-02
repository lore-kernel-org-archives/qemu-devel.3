Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51804E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPex-000057-BU; Thu, 02 Jan 2025 13:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeo-0007av-LM
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:54 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPek-0006Hm-Es
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:54 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2164b1f05caso156515255ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841449; x=1736446249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QkFrv0N8hFPzo9evHgqvZ8sDBU5hchTQ2vcvDoeTl7g=;
 b=DH9/41kJ09ZmdvSUhI3gXiJtXhMOEclZwAq2g72QvfjexB+9yCzcNxEqRemoJLQfke
 mdXMI3jeKcrSmUnT6BQpweuEHNx/DxUJo7GUtL1TJbsVg2nJyYB66Z8cMVjVbFn8J8nh
 jVGr/BKGHNFtkM4pJAy2kmeFXA5ZfDccstrKueHxq1RACF7evgXfSQvNUJsJKxRxS1K/
 zGm1//dTsIU3NImOWensodHE5SfjJjAfj0Gzxw4/xUZvP2332FUR8cjkWMUdS8qrAzWr
 +9guVswSTXjPtjSZUsWXcMtBz2A2CcqHsgvKY2WHThOPJMHjgcCODGB+yF2jxIeIkejE
 tKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841449; x=1736446249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QkFrv0N8hFPzo9evHgqvZ8sDBU5hchTQ2vcvDoeTl7g=;
 b=BhuaVuzJLKZD+lRupwAl383eK548jMbWA2QzwvQ8f+s/P9R4sLu0KnOHZTc7Xg/rMt
 M1pPDszGtKQgRORu3eeIB5LhMqCitYXQRne/IkveHJUvlqIejcHap+m8v8UFL9c8c3PP
 QKgcP/GH3SsJUPhqwtdviy+EzYdd2BXht2Hu6Wy7owgCTBKhksX39QffuNUGqDf6Ivhr
 o1+jSz/hYd8mGhXFTVbuhnKq0l+mbQ2oTm40QNDDuOo/F91xFFOlABfNPiMvT1+ZuonA
 AcU6rjWLUkeDV/nwc01JYx273e8ZIDW0e2KBE+C0R2EyOmA18zfiGyN50fUM5vZgwNV/
 ShNg==
X-Gm-Message-State: AOJu0YyuGcL4S68FFsBM+qwyNCZbyBWw2qBm7SuagSVr+YggftGoc/4I
 z5zztyjKOiULcw64c73sU2DVgHU1D+BhWIPK94+3qxoNbKUZxiYIuyIJaiVAtaZAUxoqv56atPm
 z
X-Gm-Gg: ASbGncvNRIPhAAaLNtES15hrceuAEhny12yXrmHDwI5PXhIefH385h8XSiXCwM6ylgk
 lZgB98PgC7YEfZAPX1dvHhvneKV/B5cVbN8Da4KxMWCwFxrerQzXyXdXcVPuiT2dVaQMKjdGebu
 6XOK4ElEl/bJse+HWe8dkyUpwifOcKLQnIC/s6HuGgnTKQAJ2sfz+0sq8WL8PlDwfptUmC3T7H4
 NzkPB2VgfYplhCAY/I9ssYqyzYFYQY8XyeEqdvxaEVzzjyYfItMy16P97WW0Q==
X-Google-Smtp-Source: AGHT+IFe02CrUSJlPWTAj6LYgJFqm/Prur6gRrO++HsJCrUKqy6MVh+b2OGd20lzDYdmsZaOKSpY3A==
X-Received: by 2002:a05:6a00:414a:b0:727:3fd5:b530 with SMTP id
 d2e1a72fcca58-72abde0f264mr59053081b3a.15.1735841448637; 
 Thu, 02 Jan 2025 10:10:48 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 68/73] tcg: Merge integer shift operations
Date: Thu,  2 Jan 2025 10:06:48 -0800
Message-ID: <20250102180654.1420056-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

For TCI, we're losing type information from the interpreter.  Limit the
opcodes to the host register size; on 64-bit host use an extra opcode to
emulate right shift and let tcg-op.c expand a 32-bit rotate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  15 ++--
 tcg/tci/tcg-target-has.h         |   2 +-
 tcg/optimize.c                   |  91 +++++++++-------------
 tcg/tcg-op.c                     |  20 ++---
 tcg/tcg.c                        |  18 ++---
 tcg/tci.c                        |  84 +++++++++-----------
 tcg/aarch64/tcg-target.c.inc     |  30 +++-----
 tcg/arm/tcg-target.c.inc         |  20 ++---
 tcg/i386/tcg-target.c.inc        |  25 +++---
 tcg/loongarch64/tcg-target.c.inc | 122 +++++++++++++++--------------
 tcg/mips/tcg-target.c.inc        | 124 ++++++++++++++----------------
 tcg/ppc/tcg-target.c.inc         | 114 +++++++++++++--------------
 tcg/riscv/tcg-target.c.inc       |  90 ++++++++++------------
 tcg/s390x/tcg-target.c.inc       | 127 ++++++++++++++-----------------
 tcg/sparc64/tcg-target.c.inc     |  56 +++++++-------
 tcg/tci/tcg-target.c.inc         |  40 ++++++----
 16 files changed, 439 insertions(+), 539 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 643ebe05cc..e39788bc14 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -64,6 +64,11 @@ DEF(remu, 1, 2, 0, TCG_OPF_INT)
 DEF(div2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 
+DEF(shl, 1, 2, 0, TCG_OPF_INT)
+DEF(shr, 1, 2, 0, TCG_OPF_INT)
+DEF(sar, 1, 2, 0, TCG_OPF_INT)
+DEF(rotl, 1, 2, 0, TCG_OPF_INT)
+DEF(rotr, 1, 2, 0, TCG_OPF_INT)
 DEF(extract, 1, 1, 2, TCG_OPF_INT)
 DEF(sextract, 1, 1, 2, TCG_OPF_INT)
 
@@ -76,11 +81,6 @@ DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(ld_i32, 1, 1, 2, 0)
 DEF(st_i32, 0, 2, 2, 0)
 /* shifts/rotates */
-DEF(shl_i32, 1, 2, 0, 0)
-DEF(shr_i32, 1, 2, 0, 0)
-DEF(sar_i32, 1, 2, 0, 0)
-DEF(rotl_i32, 1, 2, 0, 0)
-DEF(rotr_i32, 1, 2, 0, 0)
 DEF(deposit_i32, 1, 2, 2, 0)
 DEF(extract2_i32, 1, 2, 1, 0)
 
@@ -97,11 +97,6 @@ DEF(ctpop_i32, 1, 1, 0, 0)
 DEF(ld_i64, 1, 1, 2, 0)
 DEF(st_i64, 0, 2, 2, 0)
 /* shifts/rotates */
-DEF(shl_i64, 1, 2, 0, 0)
-DEF(shr_i64, 1, 2, 0, 0)
-DEF(sar_i64, 1, 2, 0, 0)
-DEF(rotl_i64, 1, 2, 0, 0)
-DEF(rotr_i64, 1, 2, 0, 0)
 DEF(deposit_i64, 1, 2, 2, 0)
 DEF(extract2_i64, 1, 2, 1, 0)
 
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 861fa42385..49ef7d62e9 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -20,7 +20,7 @@
 #define TCG_TARGET_HAS_muluh(T)         0
 #define TCG_TARGET_HAS_negsetcond(T)    0
 #define TCG_TARGET_HAS_rem(T)           1
-#define TCG_TARGET_HAS_rot(T)           1
+#define TCG_TARGET_HAS_rot(T)           (T == TCG_TYPE_REG)
 #define TCG_TARGET_HAS_sub2(T)          (T == TCG_TYPE_REG)
 #define TCG_TARGET_HAS_extract2(T)      0
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6077883bc4..0240831343 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -429,34 +429,34 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type, uint64_t x, ui
     case INDEX_op_xor_vec:
         return x ^ y;
 
-    case INDEX_op_shl_i32:
-        return (uint32_t)x << (y & 31);
-
-    case INDEX_op_shl_i64:
+    case INDEX_op_shl:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x << (y & 31);
+        }
         return (uint64_t)x << (y & 63);
 
-    case INDEX_op_shr_i32:
-        return (uint32_t)x >> (y & 31);
-
-    case INDEX_op_shr_i64:
+    case INDEX_op_shr:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x >> (y & 31);
+        }
         return (uint64_t)x >> (y & 63);
 
-    case INDEX_op_sar_i32:
-        return (int32_t)x >> (y & 31);
-
-    case INDEX_op_sar_i64:
+    case INDEX_op_sar:
+        if (type == TCG_TYPE_I32) {
+            return (int32_t)x >> (y & 31);
+        }
         return (int64_t)x >> (y & 63);
 
-    case INDEX_op_rotr_i32:
-        return ror32(x, y & 31);
-
-    case INDEX_op_rotr_i64:
+    case INDEX_op_rotr:
+        if (type == TCG_TYPE_I32) {
+            return ror32(x, y & 31);
+        }
         return ror64(x, y & 63);
 
-    case INDEX_op_rotl_i32:
-        return rol32(x, y & 31);
-
-    case INDEX_op_rotl_i64:
+    case INDEX_op_rotl:
+        if (type == TCG_TYPE_I32) {
+            return rol32(x, y & 31);
+        }
         return rol64(x, y & 63);
 
     case INDEX_op_not:
@@ -2255,8 +2255,6 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode shr_opc;
-    TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
     TCGOp *op2;
@@ -2275,47 +2273,26 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
     sh = ctz64(val);
 
-    switch (op->type) {
-    case TCG_TYPE_I32:
-        shr_opc = INDEX_op_shr_i32;
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
-            uext_opc = INDEX_op_extract;
-        }
-        if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, sh, 1)) {
-            sext_opc = INDEX_op_sextract;
-        }
-        break;
-    case TCG_TYPE_I64:
-        shr_opc = INDEX_op_shr_i64;
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
-            uext_opc = INDEX_op_extract;
-        }
-        if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, sh, 1)) {
-            sext_opc = INDEX_op_sextract;
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
     ret = op->args[0];
     src1 = op->args[1];
     inv = cond == TCG_COND_TSTEQ;
 
-    if (sh && sext_opc && neg && !inv) {
-        op->opc = sext_opc;
+    if (sh && neg && !inv &&
+        TCG_TARGET_sextract_valid(op->type, sh, 1)) {
+        op->opc = INDEX_op_sextract;
         op->args[1] = src1;
         op->args[2] = sh;
         op->args[3] = 1;
         return;
-    } else if (sh && uext_opc) {
-        op->opc = uext_opc;
+    } else if (sh && TCG_TARGET_extract_valid(op->type, sh, 1)) {
+        op->opc = INDEX_op_extract;
         op->args[1] = src1;
         op->args[2] = sh;
         op->args[3] = 1;
     } else {
         if (sh) {
-            op2 = tcg_op_insert_before(ctx->tcg, op, shr_opc, op->type, 3);
+            op2 = tcg_op_insert_before(ctx->tcg, op,
+                                       INDEX_op_shr, op->type, 3);
             op2->args[0] = ret;
             op2->args[1] = src1;
             op2->args[2] = arg_new_constant(ctx, op->type, sh);
@@ -2516,13 +2493,13 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
     }
 
     switch (op->opc) {
-    CASE_OP_32_64(sar):
+    case INDEX_op_sar:
         /*
          * Arithmetic right shift will not reduce the number of
          * input sign repetitions.
          */
         return fold_masks_s(ctx, op, s_mask);
-    CASE_OP_32_64(shr):
+    case INDEX_op_shr:
         /*
          * If the sign bit is known zero, then logical right shift
          * will not reduce the number of input sign repetitions.
@@ -2881,11 +2858,11 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_remu:
             done = fold_remainder(&ctx, op);
             break;
-        CASE_OP_32_64(rotl):
-        CASE_OP_32_64(rotr):
-        CASE_OP_32_64(sar):
-        CASE_OP_32_64(shl):
-        CASE_OP_32_64(shr):
+        case INDEX_op_rotl:
+        case INDEX_op_rotr:
+        case INDEX_op_sar:
+        case INDEX_op_shl:
+        case INDEX_op_shr:
             done = fold_shift(&ctx, op);
             break;
         case INDEX_op_setcond:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4d36da33c5..c9c806b543 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -474,7 +474,7 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_shl_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_shl, ret, arg1, arg2);
 }
 
 void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -489,7 +489,7 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_shr_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_shr, ret, arg1, arg2);
 }
 
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -504,7 +504,7 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_sar_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_sar, ret, arg1, arg2);
 }
 
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -827,7 +827,7 @@ void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rot(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, arg2);
     } else {
         TCGv_i32 t0, t1;
 
@@ -865,7 +865,7 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rot(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, arg2);
     } else {
         TCGv_i32 t0, t1;
 
@@ -1603,7 +1603,7 @@ void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_shl_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
     } else {
         gen_helper_shl_i64(ret, arg1, arg2);
     }
@@ -1612,7 +1612,7 @@ void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_shr_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
     } else {
         gen_helper_shr_i64(ret, arg1, arg2);
     }
@@ -1621,7 +1621,7 @@ void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_sar_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
     } else {
         gen_helper_sar_i64(ret, arg1, arg2);
     }
@@ -2471,7 +2471,7 @@ void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64 &&
         TCG_TARGET_HAS_rot(TCG_TYPE_I64)) {
-        tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, arg2);
     } else {
         TCGv_i64 t0, t1;
         t0 = tcg_temp_ebb_new_i64();
@@ -2510,7 +2510,7 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64 &&
         TCG_TARGET_HAS_rot(TCG_TYPE_I64)) {
-        tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, arg2);
     } else {
         TCGv_i64 t0, t1;
         t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 71171bb7dc..72b062e76d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2198,17 +2198,17 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_mul:
     case INDEX_op_neg:
     case INDEX_op_or:
+    case INDEX_op_sar:
     case INDEX_op_setcond:
     case INDEX_op_sextract:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
         return has_type;
 
     case INDEX_op_ld_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_shl_i32:
-    case INDEX_op_shr_i32:
-    case INDEX_op_sar_i32:
     case INDEX_op_deposit_i32:
         return true;
 
@@ -2245,12 +2245,12 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_rem:
     case INDEX_op_remu:
         return has_type && TCG_TARGET_HAS_rem(type);
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
+        return has_type && TCG_TARGET_HAS_rot(type);
     case INDEX_op_sub2:
         return has_type && TCG_TARGET_HAS_sub2(type);
 
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotr_i32:
-        return TCG_TARGET_HAS_rot(TCG_TYPE_I32);
     case INDEX_op_extract2_i32:
         return TCG_TARGET_HAS_extract2(TCG_TYPE_I32);
     case INDEX_op_bswap16_i32:
@@ -2265,9 +2265,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
 
     case INDEX_op_ld_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
@@ -2275,9 +2272,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_rot(TCG_TYPE_I64);
     case INDEX_op_extract2_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_extract2(TCG_TYPE_I64);
     case INDEX_op_bswap16_i64:
diff --git a/tcg/tci.c b/tcg/tci.c
index 6b0f3ba3fd..063d39adfa 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -597,6 +597,35 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] % regs[r2];
             break;
+        case INDEX_op_shl:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] << (regs[r2] % TCG_TARGET_REG_BITS);
+            break;
+        case INDEX_op_shr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] >> (regs[r2] % TCG_TARGET_REG_BITS);
+            break;
+        case INDEX_op_sar:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (tcg_target_long)regs[r1] >>
+                       (regs[r2] % TCG_TARGET_REG_BITS);
+            break;
+        case INDEX_op_rotl:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            if (TCG_TARGET_REG_BITS == 32) {
+                regs[r0] = rol32(regs[r1], regs[r2] & 31);
+            } else {
+                regs[r0] = rol64(regs[r1], regs[r2] & 63);
+            }
+            break;
+        case INDEX_op_rotr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            if (TCG_TARGET_REG_BITS == 32) {
+                regs[r0] = ror32(regs[r1], regs[r2] & 31);
+            } else {
+                regs[r0] = ror64(regs[r1], regs[r2] & 63);
+            }
+            break;
 
             /* Arithmetic operations (32 bit). */
 
@@ -617,26 +646,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (32 bit). */
 
-        case INDEX_op_shl_i32:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (uint32_t)regs[r1] << (regs[r2] & 31);
-            break;
-        case INDEX_op_shr_i32:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (uint32_t)regs[r1] >> (regs[r2] & 31);
-            break;
-        case INDEX_op_sar_i32:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int32_t)regs[r1] >> (regs[r2] & 31);
-            break;
-        case INDEX_op_rotl_i32:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = rol32(regs[r1], regs[r2] & 31);
-            break;
-        case INDEX_op_rotr_i32:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = ror32(regs[r1], regs[r2] & 31);
-            break;
         case INDEX_op_deposit_i32:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit32(regs[r1], pos, len, regs[r2]);
@@ -751,26 +760,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (64 bit). */
 
-        case INDEX_op_shl_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = regs[r1] << (regs[r2] & 63);
-            break;
-        case INDEX_op_shr_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = regs[r1] >> (regs[r2] & 63);
-            break;
-        case INDEX_op_sar_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int64_t)regs[r1] >> (regs[r2] & 63);
-            break;
-        case INDEX_op_rotl_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = rol64(regs[r1], regs[r2] & 63);
-            break;
-        case INDEX_op_rotr_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = ror64(regs[r1], regs[r2] & 63);
-            break;
         case INDEX_op_deposit_i64:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
@@ -1066,16 +1055,11 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_rem:
     case INDEX_op_divu:
     case INDEX_op_remu:
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i32:
-    case INDEX_op_sar_i64:
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotr_i64:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sar:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 2050a0a6db..bc695aa760 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2287,8 +2287,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3509, MSUB, ext, a0, TCG_REG_TMP0, a2, a1);
         break;
 
-    case INDEX_op_shl_i64:
-    case INDEX_op_shl_i32:
+    case INDEX_op_shl:
         if (c2) {
             tcg_out_shl(s, ext, a0, a1, a2);
         } else {
@@ -2296,8 +2295,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_shr_i64:
-    case INDEX_op_shr_i32:
+    case INDEX_op_shr:
         if (c2) {
             tcg_out_shr(s, ext, a0, a1, a2);
         } else {
@@ -2305,8 +2303,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_sar_i64:
-    case INDEX_op_sar_i32:
+    case INDEX_op_sar:
         if (c2) {
             tcg_out_sar(s, ext, a0, a1, a2);
         } else {
@@ -2314,8 +2311,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_rotr_i64:
-    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr:
         if (c2) {
             tcg_out_rotr(s, ext, a0, a1, a2);
         } else {
@@ -2323,8 +2319,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl:
         if (c2) {
             tcg_out_rotl(s, ext, a0, a1, a2);
         } else {
@@ -2965,16 +2960,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_eqv:
         return C_O1_I2(r, r, rL);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shr_i32:
-    case INDEX_op_sar_i32:
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i64:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i64:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sar:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
         return C_O1_I2(r, r, ri);
 
     case INDEX_op_clz_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 09ab9d4051..3b89a6c60e 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1999,19 +1999,19 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_smull32(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
     /* XXX: Perhaps args[2] & 0x1f is wrong */
-    case INDEX_op_shl_i32:
+    case INDEX_op_shl:
         c = const_args[2] ?
                 SHIFT_IMM_LSL(args[2] & 0x1f) : SHIFT_REG_LSL(args[2]);
         goto gen_shift32;
-    case INDEX_op_shr_i32:
+    case INDEX_op_shr:
         c = const_args[2] ? (args[2] & 0x1f) ? SHIFT_IMM_LSR(args[2] & 0x1f) :
                 SHIFT_IMM_LSL(0) : SHIFT_REG_LSR(args[2]);
         goto gen_shift32;
-    case INDEX_op_sar_i32:
+    case INDEX_op_sar:
         c = const_args[2] ? (args[2] & 0x1f) ? SHIFT_IMM_ASR(args[2] & 0x1f) :
                 SHIFT_IMM_LSL(0) : SHIFT_REG_ASR(args[2]);
         goto gen_shift32;
-    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr:
         c = const_args[2] ? (args[2] & 0x1f) ? SHIFT_IMM_ROR(args[2] & 0x1f) :
                 SHIFT_IMM_LSL(0) : SHIFT_REG_ROR(args[2]);
         /* Fall through.  */
@@ -2019,7 +2019,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0, args[1], c);
         break;
 
-    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl:
         if (const_args[2]) {
             tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0, args[1],
                             ((0x20 - args[2]) & 0x1f) ?
@@ -2218,11 +2218,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_xor:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shr_i32:
-    case INDEX_op_sar_i32:
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotr_i32:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sar:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
         return C_O1_I2(r, r, ri);
 
     case INDEX_op_brcond:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 30bb5502f6..75a3b4641a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2803,7 +2803,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_DIV, args[4]);
         break;
 
-    OP_32_64(shl):
+    case INDEX_op_shl:
         /* For small constant 3-operand shift, use LEA.  */
         if (const_a2 && a0 != a1 && (a2 - 1) < 3) {
             if (a2 - 1 == 0) {
@@ -2818,18 +2818,18 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         c = SHIFT_SHL;
         vexop = OPC_SHLX;
         goto gen_shift_maybe_vex;
-    OP_32_64(shr):
+    case INDEX_op_shr:
         c = SHIFT_SHR;
         vexop = OPC_SHRX;
         goto gen_shift_maybe_vex;
-    OP_32_64(sar):
+    case INDEX_op_sar:
         c = SHIFT_SAR;
         vexop = OPC_SARX;
         goto gen_shift_maybe_vex;
-    OP_32_64(rotl):
+    case INDEX_op_rotl:
         c = SHIFT_ROL;
         goto gen_shift;
-    OP_32_64(rotr):
+    case INDEX_op_rotr:
         c = SHIFT_ROR;
         goto gen_shift;
     gen_shift_maybe_vex:
@@ -3695,18 +3695,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_andc:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i32:
-    case INDEX_op_sar_i64:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sar:
         return have_bmi2 ? C_O1_I2(r, r, ri) : C_O1_I2(r, 0, ci);
 
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotr_i64:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
         return C_O1_I2(r, 0, ci);
 
     case INDEX_op_brcond:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index d91524e984..d22223bb45 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1440,82 +1440,85 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_clzctz(s, OPC_CTZ_D, a0, a1, a2, c2, false);
         break;
 
-    case INDEX_op_shl_i32:
+    case INDEX_op_shl:
         if (c2) {
-            tcg_out_opc_slli_w(s, a0, a1, a2 & 0x1f);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_slli_w(s, a0, a1, a2 & 0x1f);
+            } else {
+                tcg_out_opc_slli_d(s, a0, a1, a2 & 0x3f);
+            }
         } else {
-            tcg_out_opc_sll_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_shl_i64:
-        if (c2) {
-            tcg_out_opc_slli_d(s, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_sll_d(s, a0, a1, a2);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_sll_w(s, a0, a1, a2);
+            } else {
+                tcg_out_opc_sll_d(s, a0, a1, a2);
+            }
         }
         break;
 
-    case INDEX_op_shr_i32:
+    case INDEX_op_shr:
         if (c2) {
-            tcg_out_opc_srli_w(s, a0, a1, a2 & 0x1f);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_srli_w(s, a0, a1, a2 & 0x1f);
+            } else {
+                tcg_out_opc_srli_d(s, a0, a1, a2 & 0x3f);
+            }
         } else {
-            tcg_out_opc_srl_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_shr_i64:
-        if (c2) {
-            tcg_out_opc_srli_d(s, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_srl_d(s, a0, a1, a2);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_srl_w(s, a0, a1, a2);
+            } else {
+                tcg_out_opc_srl_d(s, a0, a1, a2);
+            }
         }
         break;
 
-    case INDEX_op_sar_i32:
+    case INDEX_op_sar:
         if (c2) {
-            tcg_out_opc_srai_w(s, a0, a1, a2 & 0x1f);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_srai_w(s, a0, a1, a2 & 0x1f);
+            } else {
+                tcg_out_opc_srai_d(s, a0, a1, a2 & 0x3f);
+            }
         } else {
-            tcg_out_opc_sra_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_sar_i64:
-        if (c2) {
-            tcg_out_opc_srai_d(s, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_sra_d(s, a0, a1, a2);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_sra_w(s, a0, a1, a2);
+            } else {
+                tcg_out_opc_sra_d(s, a0, a1, a2);
+            }
         }
         break;
 
-    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl:
         /* transform into equivalent rotr/rotri */
         if (c2) {
-            tcg_out_opc_rotri_w(s, a0, a1, (32 - a2) & 0x1f);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_rotri_w(s, a0, a1, (32 - a2) & 0x1f);
+            } else {
+                tcg_out_opc_rotri_d(s, a0, a1, (64 - a2) & 0x3f);
+            }
         } else {
             tcg_out_opc_sub_w(s, TCG_REG_TMP0, TCG_REG_ZERO, a2);
-            tcg_out_opc_rotr_w(s, a0, a1, TCG_REG_TMP0);
-        }
-        break;
-    case INDEX_op_rotl_i64:
-        /* transform into equivalent rotr/rotri */
-        if (c2) {
-            tcg_out_opc_rotri_d(s, a0, a1, (64 - a2) & 0x3f);
-        } else {
-            tcg_out_opc_sub_w(s, TCG_REG_TMP0, TCG_REG_ZERO, a2);
-            tcg_out_opc_rotr_d(s, a0, a1, TCG_REG_TMP0);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_rotr_w(s, a0, a1, TCG_REG_TMP0);
+            } else {
+                tcg_out_opc_rotr_d(s, a0, a1, TCG_REG_TMP0);
+            }
         }
         break;
 
-    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr:
         if (c2) {
-            tcg_out_opc_rotri_w(s, a0, a1, a2 & 0x1f);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_rotri_w(s, a0, a1, a2 & 0x1f);
+            } else {
+                tcg_out_opc_rotri_d(s, a0, a1, a2 & 0x3f);
+            }
         } else {
-            tcg_out_opc_rotr_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_rotr_i64:
-        if (c2) {
-            tcg_out_opc_rotri_d(s, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_rotr_d(s, a0, a1, a2);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_rotr_w(s, a0, a1, a2);
+            } else {
+                tcg_out_opc_rotr_d(s, a0, a1, a2);
+            }
         }
         break;
 
@@ -2251,16 +2254,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
          */
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i32:
-    case INDEX_op_sar_i64:
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotr_i64:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sar:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
         return C_O1_I2(r, r, ri);
 
     case INDEX_op_add:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 7e8f5e1379..143348ab2e 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -455,7 +455,6 @@ static void tcg_out_opc_sa(TCGContext *s, MIPSInsn opc,
     inst |= (rd & 0x1F) << 11;
     inst |= (sa & 0x1F) <<  6;
     tcg_out32(s, inst);
-
 }
 
 static void tcg_out_opc_sa64(TCGContext *s, MIPSInsn opc1, MIPSInsn opc2,
@@ -1946,67 +1945,65 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_dsra(s, a0, a1, 32);
         break;
 
-    case INDEX_op_sar_i32:
-        i1 = OPC_SRAV, i2 = OPC_SRA;
-        goto do_shift;
-    case INDEX_op_shl_i32:
-        i1 = OPC_SLLV, i2 = OPC_SLL;
-        goto do_shift;
-    case INDEX_op_shr_i32:
-        i1 = OPC_SRLV, i2 = OPC_SRL;
-        goto do_shift;
-    case INDEX_op_rotr_i32:
-        i1 = OPC_ROTRV, i2 = OPC_ROTR;
-    do_shift:
+    case INDEX_op_sar:
         if (c2) {
-            tcg_out_opc_sa(s, i2, a0, a1, a2);
-            break;
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_sa(s, OPC_SRA, a0, a1, a2);
+            } else {
+                tcg_out_dsra(s, a0, a1, a2);
+            }
+        } else {
+            tcg_out_opc_reg(s, type == TCG_TYPE_I32 ? OPC_SRAV : OPC_DSRAV,
+                            a0, a1, a2);
         }
-    do_shiftv:
-        tcg_out_opc_reg(s, i1, a0, a2, a1);
         break;
-    case INDEX_op_rotl_i32:
+    case INDEX_op_shl:
         if (c2) {
-            tcg_out_opc_sa(s, OPC_ROTR, a0, a1, 32 - a2);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_sa(s, OPC_SLL, a0, a1, a2);
+            } else {
+                tcg_out_dsll(s, a0, a1, a2);
+            }
+        } else {
+            tcg_out_opc_reg(s, type == TCG_TYPE_I32 ? OPC_SLLV : OPC_DSLLV,
+                            a0, a1, a2);
+        }
+        break;
+    case INDEX_op_shr:
+        if (c2) {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_sa(s, OPC_SRL, a0, a1, a2);
+            } else {
+                tcg_out_dsrl(s, a0, a1, a2);
+            }
+        } else {
+            tcg_out_opc_reg(s, type == TCG_TYPE_I32 ? OPC_SRLV : OPC_DSRLV,
+                            a0, a1, a2);
+        }
+        break;
+    case INDEX_op_rotr:
+        if (c2) {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_sa(s, OPC_ROTR, a0, a1, a2);
+            } else {
+                tcg_out_opc_sa64(s, OPC_DROTR, OPC_DROTR32, a0, a1, a2);
+            }
+        } else {
+            tcg_out_opc_reg(s, type == TCG_TYPE_I32 ? OPC_ROTRV : OPC_DROTRV,
+                            a0, a1, a2);
+        }
+        break;
+    case INDEX_op_rotl:
+        if (c2) {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_sa(s, OPC_ROTR, a0, a1, 32 - a2);
+            } else {
+                tcg_out_opc_sa64(s, OPC_DROTR, OPC_DROTR32, a0, a1, 64 - a2);
+            }
         } else {
             tcg_out_opc_reg(s, OPC_SUBU, TCG_TMP0, TCG_REG_ZERO, a2);
-            tcg_out_opc_reg(s, OPC_ROTRV, a0, TCG_TMP0, a1);
-        }
-        break;
-    case INDEX_op_sar_i64:
-        if (c2) {
-            tcg_out_dsra(s, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DSRAV;
-        goto do_shiftv;
-    case INDEX_op_shl_i64:
-        if (c2) {
-            tcg_out_dsll(s, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DSLLV;
-        goto do_shiftv;
-    case INDEX_op_shr_i64:
-        if (c2) {
-            tcg_out_dsrl(s, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DSRLV;
-        goto do_shiftv;
-    case INDEX_op_rotr_i64:
-        if (c2) {
-            tcg_out_opc_sa64(s, OPC_DROTR, OPC_DROTR32, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DROTRV;
-        goto do_shiftv;
-    case INDEX_op_rotl_i64:
-        if (c2) {
-            tcg_out_opc_sa64(s, OPC_DROTR, OPC_DROTR32, a0, a1, 64 - a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_DSUBU, TCG_TMP0, TCG_REG_ZERO, a2);
-            tcg_out_opc_reg(s, OPC_DROTRV, a0, TCG_TMP0, a1);
+            tcg_out_opc_reg(s, type == TCG_TYPE_I32 ? OPC_ROTRV : OPC_DROTRV,
+                            a0, TCG_TMP0, a1);
         }
         break;
 
@@ -2189,16 +2186,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_or:
     case INDEX_op_xor:
         return C_O1_I2(r, r, rI);
-    case INDEX_op_shl_i32:
-    case INDEX_op_shr_i32:
-    case INDEX_op_sar_i32:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotl_i32:
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i64:
-    case INDEX_op_rotr_i64:
-    case INDEX_op_rotl_i64:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sar:
+    case INDEX_op_rotr:
+    case INDEX_op_rotl:
         return C_O1_I2(r, r, ri);
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index a2618e8573..c2b53c79f7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3167,44 +3167,75 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_shl_i32:
+    case INDEX_op_shl:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
-            tcg_out_shli32(s, args[0], args[1], args[2] & 31);
-        } else {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_shli32(s, args[0], args[1], args[2] & 31);
+            } else {
+                tcg_out_shli64(s, args[0], args[1], args[2] & 63);
+            }
+        } else if (type == TCG_TYPE_I32) {
             tcg_out32(s, SLW | SAB(args[1], args[0], args[2]));
+        } else {
+            tcg_out32(s, SLD | SAB(args[1], args[0], args[2]));
         }
         break;
-    case INDEX_op_shr_i32:
+    case INDEX_op_shr:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
-            tcg_out_shri32(s, args[0], args[1], args[2] & 31);
-        } else {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_shri32(s, args[0], args[1], args[2] & 31);
+            } else {
+                tcg_out_shri64(s, args[0], args[1], args[2] & 63);
+            }
+        } else if (type == TCG_TYPE_I32) {
             tcg_out32(s, SRW | SAB(args[1], args[0], args[2]));
+        } else {
+            tcg_out32(s, SRD | SAB(args[1], args[0], args[2]));
         }
         break;
-    case INDEX_op_sar_i32:
+    case INDEX_op_sar:
         if (const_args[2]) {
-            tcg_out_sari32(s, args[0], args[1], args[2]);
-        } else {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_sari32(s, args[0], args[1], args[2]);
+            } else {
+                tcg_out_sari64(s, args[0], args[1], args[2]);
+            }
+        } else if (type == TCG_TYPE_I32) {
             tcg_out32(s, SRAW | SAB(args[1], args[0], args[2]));
+        } else {
+            tcg_out32(s, SRAD | SAB(args[1], args[0], args[2]));
         }
         break;
-    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl:
         if (const_args[2]) {
-            tcg_out_rlw(s, RLWINM, args[0], args[1], args[2], 0, 31);
-        } else {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_rlw(s, RLWINM, args[0], args[1], args[2], 0, 31);
+            } else {
+                tcg_out_rld(s, RLDICL, args[0], args[1], args[2], 0);
+            }
+        } else if (type == TCG_TYPE_I32) {
             tcg_out32(s, RLWNM | SAB(args[1], args[0], args[2])
                          | MB(0) | ME(31));
+        } else {
+            tcg_out32(s, RLDCL | SAB(args[1], args[0], args[2]) | MB64(0));
         }
         break;
-    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr:
         if (const_args[2]) {
-            tcg_out_rlw(s, RLWINM, args[0], args[1], 32 - args[2], 0, 31);
-        } else {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_rlw(s, RLWINM, args[0], args[1], 32 - args[2], 0, 31);
+            } else {
+                tcg_out_rld(s, RLDICL, args[0], args[1], 64 - args[2], 0);
+            }
+        } else if (type == TCG_TYPE_I32) {
             tcg_out32(s, SUBFIC | TAI(TCG_REG_R0, args[2], 32));
             tcg_out32(s, RLWNM | SAB(args[1], args[0], TCG_REG_R0)
                          | MB(0) | ME(31));
+        } else {
+            tcg_out32(s, SUBFIC | TAI(TCG_REG_R0, args[2], 64));
+            tcg_out32(s, RLDCL | SAB(args[1], args[0], TCG_REG_R0) | MB64(0));
         }
         break;
 
@@ -3224,44 +3255,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, NOR | SAB(args[1], args[0], args[1]));
         break;
 
-    case INDEX_op_shl_i64:
-        if (const_args[2]) {
-            /* Limit immediate shift count lest we create an illegal insn.  */
-            tcg_out_shli64(s, args[0], args[1], args[2] & 63);
-        } else {
-            tcg_out32(s, SLD | SAB(args[1], args[0], args[2]));
-        }
-        break;
-    case INDEX_op_shr_i64:
-        if (const_args[2]) {
-            /* Limit immediate shift count lest we create an illegal insn.  */
-            tcg_out_shri64(s, args[0], args[1], args[2] & 63);
-        } else {
-            tcg_out32(s, SRD | SAB(args[1], args[0], args[2]));
-        }
-        break;
-    case INDEX_op_sar_i64:
-        if (const_args[2]) {
-            tcg_out_sari64(s, args[0], args[1], args[2]);
-        } else {
-            tcg_out32(s, SRAD | SAB(args[1], args[0], args[2]));
-        }
-        break;
-    case INDEX_op_rotl_i64:
-        if (const_args[2]) {
-            tcg_out_rld(s, RLDICL, args[0], args[1], args[2], 0);
-        } else {
-            tcg_out32(s, RLDCL | SAB(args[1], args[0], args[2]) | MB64(0));
-        }
-        break;
-    case INDEX_op_rotr_i64:
-        if (const_args[2]) {
-            tcg_out_rld(s, RLDICL, args[0], args[1], 64 - args[2], 0);
-        } else {
-            tcg_out32(s, SUBFIC | TAI(TCG_REG_R0, args[2], 64));
-            tcg_out32(s, RLDCL | SAB(args[1], args[0], TCG_REG_R0) | MB64(0));
-        }
-        break;
     case INDEX_op_extrh_i64_i32:
         tcg_out_sari64(s, args[0], args[1], 32);
         break;
@@ -4139,16 +4132,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_and:
     case INDEX_op_andc:
-    case INDEX_op_shl_i32:
-    case INDEX_op_shr_i32:
-    case INDEX_op_sar_i32:
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i64:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i64:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sar:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
         return C_O1_I2(r, r, ri);
 
     case INDEX_op_mul:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 966cffb525..0606dc204e 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2147,76 +2147,71 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_shl_i32:
+    case INDEX_op_shl:
         if (c2) {
-            tcg_out_opc_imm(s, OPC_SLLIW, a0, a1, a2 & 0x1f);
-        } else {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_imm(s, OPC_SLLIW, a0, a1, a2 & 0x1f);
+            } else {
+                tcg_out_opc_imm(s, OPC_SLLI, a0, a1, a2 & 0x3f);
+            }
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_opc_reg(s, OPC_SLLW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_shl_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_SLLI, a0, a1, a2 & 0x3f);
         } else {
             tcg_out_opc_reg(s, OPC_SLL, a0, a1, a2);
         }
         break;
 
-    case INDEX_op_shr_i32:
+    case INDEX_op_shr:
         if (c2) {
-            tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2 & 0x1f);
-        } else {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2 & 0x1f);
+            } else {
+                tcg_out_opc_imm(s, OPC_SRLI, a0, a1, a2 & 0x3f);
+            }
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_opc_reg(s, OPC_SRLW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_shr_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_SRLI, a0, a1, a2 & 0x3f);
         } else {
             tcg_out_opc_reg(s, OPC_SRL, a0, a1, a2);
         }
         break;
 
-    case INDEX_op_sar_i32:
+    case INDEX_op_sar:
         if (c2) {
-            tcg_out_opc_imm(s, OPC_SRAIW, a0, a1, a2 & 0x1f);
-        } else {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_imm(s, OPC_SRAIW, a0, a1, a2 & 0x1f);
+            } else {
+                tcg_out_opc_imm(s, OPC_SRAI, a0, a1, a2 & 0x3f);
+            }
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_opc_reg(s, OPC_SRAW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_sar_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_SRAI, a0, a1, a2 & 0x3f);
         } else {
             tcg_out_opc_reg(s, OPC_SRA, a0, a1, a2);
         }
         break;
 
-    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl:
         if (c2) {
-            tcg_out_opc_imm(s, OPC_RORIW, a0, a1, -a2 & 0x1f);
-        } else {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_imm(s, OPC_RORIW, a0, a1, -a2 & 0x1f);
+            } else {
+                tcg_out_opc_imm(s, OPC_RORI, a0, a1, -a2 & 0x3f);
+            }
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_opc_reg(s, OPC_ROLW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_rotl_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_RORI, a0, a1, -a2 & 0x3f);
         } else {
             tcg_out_opc_reg(s, OPC_ROL, a0, a1, a2);
         }
         break;
 
-    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr:
         if (c2) {
-            tcg_out_opc_imm(s, OPC_RORIW, a0, a1, a2 & 0x1f);
-        } else {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_imm(s, OPC_RORIW, a0, a1, a2 & 0x1f);
+            } else {
+                tcg_out_opc_imm(s, OPC_RORI, a0, a1, a2 & 0x3f);
+            }
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_opc_reg(s, OPC_RORW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_rotr_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_RORI, a0, a1, a2 & 0x3f);
         } else {
             tcg_out_opc_reg(s, OPC_ROR, a0, a1, a2);
         }
@@ -2640,16 +2635,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_remu:
         return C_O1_I2(r, rZ, rZ);
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shr_i32:
-    case INDEX_op_sar_i32:
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i64:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i64:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sar:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
         return C_O1_I2(r, r, ri);
 
     case INDEX_op_clz_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 1c83e5d648..ac7af3f854 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2441,9 +2441,20 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_shl_i32:
-        op = RS_SLL;
-        op2 = RSY_SLLK;
+    case INDEX_op_shl:
+        if (type == TCG_TYPE_I32) {
+            op = RS_SLL;
+            op2 = RSY_SLLK;
+            goto do_shift32;
+        }
+        op = RSY_SLLG;
+    do_shift64:
+        if (const_args[2]) {
+            tcg_out_sh64(s, op, args[0], args[1], TCG_REG_NONE, args[2]);
+        } else {
+            tcg_out_sh64(s, op, args[0], args[1], args[2], 0);
+        }
+        break;
     do_shift32:
         a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
         if (a0 == a1) {
@@ -2461,30 +2472,45 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             }
         }
         break;
-    case INDEX_op_shr_i32:
-        op = RS_SRL;
-        op2 = RSY_SRLK;
-        goto do_shift32;
-    case INDEX_op_sar_i32:
-        op = RS_SRA;
-        op2 = RSY_SRAK;
-        goto do_shift32;
+    case INDEX_op_shr:
+        if (type == TCG_TYPE_I32) {
+            op = RS_SRL;
+            op2 = RSY_SRLK;
+            goto do_shift32;
+        }
+        op = RSY_SRLG;
+        goto do_shift64;
+    case INDEX_op_sar:
+        if (type == TCG_TYPE_I32) {
+            op = RS_SRA;
+            op2 = RSY_SRAK;
+            goto do_shift32;
+        }
+        op = RSY_SRAG;
+        goto do_shift64;
 
-    case INDEX_op_rotl_i32:
-        /* ??? Using tcg_out_sh64 here for the format; it is a 32-bit rol.  */
-        if (const_args[2]) {
-            tcg_out_sh64(s, RSY_RLL, args[0], args[1], TCG_REG_NONE, args[2]);
-        } else {
-            tcg_out_sh64(s, RSY_RLL, args[0], args[1], args[2], 0);
+    case INDEX_op_rotl:
+        /* Using tcg_out_sh64 here for the format; RLL is a 32-bit rol. */
+        {
+            S390Opcode insn = type == TCG_TYPE_I32 ? RSY_RLL : RSY_RLLG;
+            if (const_args[2]) {
+                tcg_out_sh64(s, insn, args[0], args[1], TCG_REG_NONE, args[2]);
+            } else {
+                tcg_out_sh64(s, insn, args[0], args[1], args[2], 0);
+            }
         }
         break;
-    case INDEX_op_rotr_i32:
-        if (const_args[2]) {
-            tcg_out_sh64(s, RSY_RLL, args[0], args[1],
-                         TCG_REG_NONE, (32 - args[2]) & 31);
-        } else {
-            tcg_out_insn(s, RR, LCR, TCG_TMP0, args[2]);
-            tcg_out_sh64(s, RSY_RLL, args[0], args[1], TCG_TMP0, 0);
+    case INDEX_op_rotr:
+        {
+            S390Opcode insn = type == TCG_TYPE_I32 ? RSY_RLL : RSY_RLLG;
+            int mask = TCG_TYPE_I32 ? 31 : 63;
+            if (const_args[2]) {
+                tcg_out_sh64(s, insn, args[0], args[1],
+                             TCG_REG_NONE, -args[2] & mask);
+            } else {
+                tcg_out_insn(s, RR, LCR, TCG_TMP0, args[2]);
+                tcg_out_sh64(s, insn, args[0], args[1], TCG_TMP0, 0);
+            }
         }
         break;
 
@@ -2625,45 +2651,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RRFa, MGRK, args[1], args[2], args[3]);
         break;
 
-    case INDEX_op_shl_i64:
-        op = RSY_SLLG;
-    do_shift64:
-        if (const_args[2]) {
-            tcg_out_sh64(s, op, args[0], args[1], TCG_REG_NONE, args[2]);
-        } else {
-            tcg_out_sh64(s, op, args[0], args[1], args[2], 0);
-        }
-        break;
-    case INDEX_op_shr_i64:
-        op = RSY_SRLG;
-        goto do_shift64;
-    case INDEX_op_sar_i64:
-        op = RSY_SRAG;
-        goto do_shift64;
     case INDEX_op_extrh_i64_i32:
         tcg_out_sh64(s, RSY_SRLG, args[0], args[1], TCG_REG_NONE, 32);
         break;
 
-    case INDEX_op_rotl_i64:
-        if (const_args[2]) {
-            tcg_out_sh64(s, RSY_RLLG, args[0], args[1],
-                         TCG_REG_NONE, args[2]);
-        } else {
-            tcg_out_sh64(s, RSY_RLLG, args[0], args[1], args[2], 0);
-        }
-        break;
-    case INDEX_op_rotr_i64:
-        if (const_args[2]) {
-            tcg_out_sh64(s, RSY_RLLG, args[0], args[1],
-                         TCG_REG_NONE, (64 - args[2]) & 63);
-        } else {
-            /* We can use the smaller 32-bit negate because only the
-               low 6 bits are examined for the rotate.  */
-            tcg_out_insn(s, RR, LCR, TCG_TMP0, args[2]);
-            tcg_out_sh64(s, RSY_RLLG, args[0], args[1], TCG_TMP0, 0);
-        }
-        break;
-
     OP_32_64(deposit):
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[1]) {
@@ -3173,14 +3164,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_add:
     case INDEX_op_sub:
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i64:
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotr_i64:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sar:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
         return C_O1_I2(r, r, ri);
+
     case INDEX_op_setcond:
     case INDEX_op_negsetcond:
         return C_O1_I2(r, r, rC);
@@ -3219,11 +3209,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
                    ? C_O1_I2(r, r, rJ)
                    : C_O1_I2(r, 0, rJ)));
 
-    case INDEX_op_shl_i32:
-    case INDEX_op_shr_i32:
-    case INDEX_op_sar_i32:
-        return C_O1_I2(r, r, ri);
-
     case INDEX_op_brcond:
         return (op->type == TCG_TYPE_I32
                 ? C_O0_I2(r, ri)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 449433c6b3..20911e46be 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1383,18 +1383,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_xor:
         c = ARITH_XOR;
         goto gen_arith;
-    case INDEX_op_shl_i32:
-        c = SHIFT_SLL;
+
+    case INDEX_op_shl:
+        if (type == TCG_TYPE_I32) {
+            c = SHIFT_SLL;
+            goto do_shift32;
+        }
+        c = SHIFT_SLLX;
+    do_shift64:
+        /* Limit immediate shift count lest we create an illegal insn.  */
+        tcg_out_arithc(s, a0, a1, a2 & 63, c2, c);
+        break;
     do_shift32:
         /* Limit immediate shift count lest we create an illegal insn.  */
         tcg_out_arithc(s, a0, a1, a2 & 31, c2, c);
         break;
-    case INDEX_op_shr_i32:
-        c = SHIFT_SRL;
-        goto do_shift32;
-    case INDEX_op_sar_i32:
-        c = SHIFT_SRA;
-        goto do_shift32;
+    case INDEX_op_shr:
+        if (type == TCG_TYPE_I32) {
+            c = SHIFT_SRL;
+            goto do_shift32;
+        }
+        c = SHIFT_SRLX;
+        goto do_shift64;
+    case INDEX_op_sar:
+        if (type == TCG_TYPE_I32) {
+            c = SHIFT_SRA;
+            goto do_shift32;
+        }
+        c = SHIFT_SRAX;
+        goto do_shift64;
+
     case INDEX_op_mul:
         c = type == TCG_TYPE_I32 ? ARITH_UMUL : ARITH_MULX;
         goto gen_arith;
@@ -1503,19 +1521,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
 
-    case INDEX_op_shl_i64:
-        c = SHIFT_SLLX;
-    do_shift64:
-        /* Limit immediate shift count lest we create an illegal insn.  */
-        tcg_out_arithc(s, a0, a1, a2 & 63, c2, c);
-        break;
-    case INDEX_op_shr_i64:
-        c = SHIFT_SRLX;
-        goto do_shift64;
-    case INDEX_op_sar_i64:
-        c = SHIFT_SRAX;
-        goto do_shift64;
-
     case INDEX_op_muluh:
         tcg_out_arith(s, args[0], args[1], args[2], ARITH_UMULXHI);
         break;
@@ -1598,12 +1603,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i32:
-    case INDEX_op_sar_i64:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sar:
     case INDEX_op_setcond:
     case INDEX_op_negsetcond:
         return C_O1_I2(r, rZ, rJ);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 55008e3815..e4f227fb4b 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -80,16 +80,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_or:
     case INDEX_op_orc:
     case INDEX_op_xor:
-    case INDEX_op_shl_i32:
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i32:
-    case INDEX_op_sar_i64:
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotr_i64:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sar:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
     case INDEX_op_setcond:
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
@@ -725,20 +720,35 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_eqv:
     case INDEX_op_nand:
     case INDEX_op_nor:
-    CASE_32_64(shl)
-    CASE_32_64(shr)
-    CASE_32_64(sar)
-    CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
-    CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
     case INDEX_op_div:
     case INDEX_op_divu:
     case INDEX_op_rem:
     case INDEX_op_remu:
+    case INDEX_op_shl:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
     CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
     CASE_32_64(ctz)      /* Optional (TCG_TARGET_HAS_ctz_*). */
         tcg_out_op_rrr(s, opc, args[0], args[1], args[2]);
         break;
 
+    case INDEX_op_shr:
+        if (type < TCG_TYPE_REG) {
+            tcg_out_ext32u(s, TCG_REG_TMP, args[1]);
+            tcg_out_op_rrr(s, opc, args[0], TCG_REG_TMP, args[2]);
+        } else {
+            tcg_out_op_rrr(s, opc, args[0], args[1], args[2]);
+        }
+        break;
+    case INDEX_op_sar:
+        if (type < TCG_TYPE_REG) {
+            tcg_out_ext32s(s, TCG_REG_TMP, args[1]);
+            tcg_out_op_rrr(s, opc, args[0], TCG_REG_TMP, args[2]);
+        } else {
+            tcg_out_op_rrr(s, opc, args[0], args[1], args[2]);
+        }
+        break;
+
     CASE_32_64(deposit)  /* Optional (TCG_TARGET_HAS_deposit_*). */
         tcg_out_op_rrrbb(s, opc, args[0], args[1], args[2], args[3], args[4]);
         break;
-- 
2.43.0


