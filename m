Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAABC369D9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RDT-00014f-Ir; Fri, 25 Apr 2025 18:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAq-0003fg-Vg
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:39 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAn-0001pw-1T
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7376e311086so3758960b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618727; x=1746223527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cS4Nkz5AEWI4U+S2dtJRN6uMzA+/jnQBXC/7r1RvIs=;
 b=bIxdtLhe5lbutKv08+bLti0QoIGATU66Ii+kJC6rQiwt7RbfVVWehj37sjCNcBUXEo
 p5B43p9QjTKgSavIyHGsXTOyrZBTQ3+zRuyhP4qmKS9gtcmcpiwkzA4EYnxiaY2229P5
 GQ1mjPAjfM0uZRKdwO+s5XJWBdTg4A+E/OYAB85l7ppK6zklYIdDltF4iAnpBvjwPiH9
 4vGA0/DpHuMSoGk/tS2/KtqmA/f2Af+X106fxYOxLW/jiDJ+HBkhAgqFOJAwPkgCMZEr
 x9qu3f+o+xzTL2qvE+/VMhum8XW0g1oMXus0dh4Qw92B+atddIeKxgzeSvfSJk0qD20c
 Ffhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618727; x=1746223527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cS4Nkz5AEWI4U+S2dtJRN6uMzA+/jnQBXC/7r1RvIs=;
 b=Ftn4Mlsawiu3TEIBD3EUiUXjs4a3aeLndEHkWMnq3DjDPmOkno761AKOeF4T9azxDy
 wDEcL9/UN6h6BSsSCUFC0oMTxoMvka42y1EV7t54Y23CpWbrNqAhejBs4M+rSTbSqiJ/
 Qwq7pttYnbzDFQGrlV9RC+TDW1h2eDy3ZhNuTPwzhwEQMl8LlPw4UVda1xBROPNuS/iz
 4jfM5wIYKHCGI4zYwQoTit1xEYJOAI9Fe1vaQZ36xW17uWc5p3qzsNovhoxC1dRsA8BB
 We0NvKBVtO6tGoCmaffRbU9nP4VeVAahlEqitJNteVbTDVFbP/1N4FoV6gUlkH6Qu5IB
 A4aA==
X-Gm-Message-State: AOJu0YwdQ8M1TGml6gTb/WxkgM8FERejZZZpW57k7SJPlVUcHHlnTHGw
 hToU9SlUbA7i/T1HdEycvKF3irUkzMAC/cNRi0+O+Jhj2CSE1I8dkEkWA2y7gBBWRsmDEQbnn/i
 a
X-Gm-Gg: ASbGnctKW3k8pIzMvxqgGPssEDi0CVvmYzPHeGRmFkj76vdhU31yqzsFmHdzYAdWHVW
 3Cx+MtlXwrfF6Shy8F2x58+XPDoN/IQzsZYfdeILXOe8zllhPeDIUKOgLbBN3FTICgRqCKLo6bV
 gUbW3QF2n4R5RiQyeHh8DcdCo5WycTTY3g2B3CDsVQRxyGr5k2dlBsgz6+ovH/xvPuqSwE+Hi7b
 LJFwl/O5MPaB9XvHGBMelMt8qCW2ttd+YWKM1pYSs2Qu9Dn2JoCQcqIhNEMTo5Cv8khSEtveEuB
 GxKFQNbJUvkcvI/MEKAD0sRrI2gAhbzGoHIUrkD2eUQtonfib+gGgupMiUebygXW+XisE2npBJ6
 /HKG67c8hrw==
X-Google-Smtp-Source: AGHT+IEcfDy9IH6L4+JaXJFi8QBEvb9tBuQmpW1OVgC/tNrlSUwdxGFyGsc+tFOauKRSlT+pfh7lwA==
X-Received: by 2002:a05:6a21:1511:b0:1f5:9098:e448 with SMTP id
 adf61e73a8af0-2045b6ae029mr4747134637.5.1745618727313; 
 Fri, 25 Apr 2025 15:05:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 124/159] tcg/i386: Implement add/sub carry opcodes
Date: Fri, 25 Apr 2025 14:54:18 -0700
Message-ID: <20250425215454.886111-125-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |   1 -
 tcg/i386/tcg-target-has.h     |   8 +--
 tcg/i386/tcg-target.c.inc     | 117 +++++++++++++++++++++-------------
 3 files changed, 76 insertions(+), 50 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 0ae9775944..85c93836bb 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -57,4 +57,3 @@ C_O2_I1(r, r, L)
 C_O2_I2(a, d, a, r)
 C_O2_I2(r, r, L, L)
 C_O2_I3(a, d, 0, 1, r)
-C_N1_O1_I4(r, r, 0, 1, re, re)
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 0328102c2a..a984a6af2e 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,14 +26,14 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 8e0ccbc722..44f9afc0d6 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -424,6 +424,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_SHLX        (0xf7 | P_EXT38 | P_DATA16)
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
 #define OPC_SHRD_Ib     (0xac | P_EXT)
+#define OPC_STC         (0xf9)
 #define OPC_TESTB	(0x84)
 #define OPC_TESTL	(0x85)
 #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
@@ -2629,21 +2630,55 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_ADD + rexw, a0, a2);
+}
+
+static void tgen_addco_imm(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_ADD + rexw, a0, a2, true);
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_addco,
+    .out_rri = tgen_addco_imm,
+};
+
+static void tgen_addcio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_ADC + rexw, a0, a2);
+}
+
+static void tgen_addcio_imm(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_ADC + rexw, a0, a2, true);
+}
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_addcio,
+    .out_rri = tgen_addcio_imm,
 };
 
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
-};
-
-static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_addcio,
+    .out_rri = tgen_addcio_imm,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out8(s, OPC_STC);
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -3060,7 +3095,7 @@ static const TCGOutOpBinary outop_shr = {
 };
 
 static void tgen_sub(TCGContext *s, TCGType type,
-                      TCGReg a0, TCGReg a1, TCGReg a2)
+                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
     int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
     tgen_arithr(s, ARITH_SUB + rexw, a0, a2);
@@ -3071,21 +3106,44 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_SUB + rexw, a0, a2, 1);
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_sub,
+    .out_rri = tgen_subbo_rri,
 };
 
-static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
-};
+static void tgen_subbio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_SBB + rexw, a0, a2);
+}
+
+static void tgen_subbio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_SBB + rexw, a0, a2, 1);
+}
 
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_subbio_rrr,
+    .out_rri = tgen_subbio_rri,
 };
 
+#define outop_subbi  outop_subbio
+
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out8(s, OPC_STC);
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
@@ -3421,31 +3479,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I128);
         break;
 
-    OP_32_64(add2):
-        if (const_args[4]) {
-            tgen_arithi(s, ARITH_ADD + rexw, a0, args[4], 1);
-        } else {
-            tgen_arithr(s, ARITH_ADD + rexw, a0, args[4]);
-        }
-        if (const_args[5]) {
-            tgen_arithi(s, ARITH_ADC + rexw, a1, args[5], 1);
-        } else {
-            tgen_arithr(s, ARITH_ADC + rexw, a1, args[5]);
-        }
-        break;
-    OP_32_64(sub2):
-        if (const_args[4]) {
-            tgen_arithi(s, ARITH_SUB + rexw, a0, args[4], 1);
-        } else {
-            tgen_arithr(s, ARITH_SUB + rexw, a0, args[4]);
-        }
-        if (const_args[5]) {
-            tgen_arithi(s, ARITH_SBB + rexw, a1, args[5], 1);
-        } else {
-            tgen_arithr(s, ARITH_SBB + rexw, a1, args[5]);
-        }
-        break;
-
 #if TCG_TARGET_REG_BITS == 64
     case INDEX_op_ld32s_i64:
         tcg_out_modrm_offset(s, OPC_MOVSLQ, a0, a1, a2);
@@ -4051,12 +4084,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        return C_N1_O1_I4(r, r, 0, 1, re, re);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, L);
 
-- 
2.43.0


