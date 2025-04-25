Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F50DC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RCA-00088v-6b; Fri, 25 Apr 2025 18:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAx-0003hn-M7
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAv-0001rz-1B
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:39 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2759604b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618735; x=1746223535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7Ub8XgwLrk6Uangfqf13kgwwwRvw0JsFULSnF5SjbM=;
 b=QmuW6IqzZo9JftK1ci75Bobl11D/0okUrZqYd9pbo9nqhyHorsHUVjuPl2BbJP+kmU
 b8wnzLaEN8WYmKG+NriCPUjqlhDEf8vZx/KINcynYdgh28zmt8jBJ/Gcoi6BD4fou43i
 JUrGJ7RQyOlrGJkPhLmX+w+3b9I9r5WEWymqSRiATd1KHDNc8tG5Zx972qZaeBZ7FLDL
 fDsPIGnNH8qcheJTtY1nASRrdw96p0nf07nKMygkuMGYKzEcrqe7iBbeHklcu/ZFsM3S
 yzoQ3Qa+YTqA3dp7QJ9jeBq5HVztfhoWdIfOf0lLG7TWsPnYjUIu12QMj0xYYsQ/plPp
 Npww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618735; x=1746223535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7Ub8XgwLrk6Uangfqf13kgwwwRvw0JsFULSnF5SjbM=;
 b=VMIkBQg9kruFc3p3HYu3v/u5n6OLaOGPGzdNOh6xemcIclUgkTPt2XJT3UTe/QCGZ2
 O+ZIkIxafEVNR3uimueD80rNLwC7nFjx/p8Hpxv37xExRKP4sHwlzHnf/dovG+Npf7Dd
 Y8tBpWfwBZExHbYJkpIsa2MuHnPn7VfWkscH8xWxz/yxRo81+9RfXHofTxGwWnN+PYDi
 jKjbL2BhtYOliOaNFL1nH7GBYvyAYEwxtB25jJNWMPBOSy8tLEyg/VlPbZTJOLptxE52
 TIhe/XbqmXcHHzB06kTciSdAyRQa77XObRI7/7KHOne4p0YcFIGNUMPAqU2ehRSOmeTX
 BPAA==
X-Gm-Message-State: AOJu0Yx1ZlSd0UsR1ggDWETO1mN9Mf3qybtV/7th7qvtI+u9aXJoqp3x
 lloW0oEwWjeCIE3IgTy3brxA/jCf4ASiPRKmKTKx9hWl4Mv+1s52D/bbLtBObXslz7fzfyBG7vF
 j
X-Gm-Gg: ASbGncvFJP7q/j5TK8f6wL/110Az8o2c4vUpB2mM2pgwtMYw5q7ce5xZva2NSe+gPco
 9dF5r2mt+UUazdI9eX8dvwdCHBPBEjflAHKb6z5sB/r6mgDcpaVblhGardAE7PSo1OGsxoODNuF
 qYIkwtqWQb3+Hg4Xs3TxqWOjrfqqqQ/brcBL/vpD7d8K5Jd/Nw6mc3t4lVT+WmoYaIMt/RYpGmn
 llm8R31p3mLbTXSByA4v9FEWpCoo5m1Nout3Frp7qoi9SuBalHNsXJQ6ALm4bCNIXPsMKHakZkd
 I1MukMugq4jy3Z6M0uvaI0Y+oKg9BVztD+qO0bGqfA/+EpVAclhFGF858DvhBK8cs72g9cjK4bA
 =
X-Google-Smtp-Source: AGHT+IHxpb2tmJDSjzNzPsYxCTepfEvUIEBChC0+8+OfPk5+jWGe98wXUrMwbQliZqIsKKUnmLh2Lg==
X-Received: by 2002:a05:6a00:4fcc:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-73fd71cfbc9mr6359694b3a.8.1745618735551; 
 Fri, 25 Apr 2025 15:05:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 136/159] tcg/aarch64: Implement add/sub carry opcodes
Date: Fri, 25 Apr 2025 14:54:30 -0700
Message-ID: <20250425215454.886111-137-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |   3 +-
 tcg/aarch64/tcg-target-has.h     |   8 +-
 tcg/aarch64/tcg-target.c.inc     | 227 ++++++++++++++++++++-----------
 3 files changed, 150 insertions(+), 88 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index 2eda499cd3..d0622e65fb 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -24,6 +24,8 @@ C_O1_I2(r, r, rAL)
 C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rL)
+C_O1_I2(r, rZ, rA)
+C_O1_I2(r, rz, rMZ)
 C_O1_I2(r, rz, rz)
 C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, 0, w)
@@ -34,4 +36,3 @@ C_O1_I2(w, w, wZ)
 C_O1_I3(w, w, w, w)
 C_O1_I4(r, r, rC, rz, rz)
 C_O2_I1(r, r, r)
-C_O2_I4(r, r, rz, rz, rA, rMZ)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 011a91c263..695effd77c 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -13,13 +13,13 @@
 #define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 87f8c98ed7..75cf490fd2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -508,7 +508,9 @@ typedef enum {
 
     /* Add/subtract with carry instructions.  */
     I3503_ADC       = 0x1a000000,
+    I3503_ADCS      = 0x3a000000,
     I3503_SBC       = 0x5a000000,
+    I3503_SBCS      = 0x7a000000,
 
     /* Conditional select instructions.  */
     I3506_CSEL      = 0x1a800000,
@@ -1573,56 +1575,6 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rn)
     tcg_out_mov(s, TCG_TYPE_I32, rd, rn);
 }
 
-static void tcg_out_addsub2(TCGContext *s, TCGType ext, TCGReg rl,
-                            TCGReg rh, TCGReg al, TCGReg ah,
-                            tcg_target_long bl, tcg_target_long bh,
-                            bool const_bl, bool const_bh, bool sub)
-{
-    TCGReg orig_rl = rl;
-    AArch64Insn insn;
-
-    if (rl == ah || (!const_bh && rl == bh)) {
-        rl = TCG_REG_TMP0;
-    }
-
-    if (const_bl) {
-        if (bl < 0) {
-            bl = -bl;
-            insn = sub ? I3401_ADDSI : I3401_SUBSI;
-        } else {
-            insn = sub ? I3401_SUBSI : I3401_ADDSI;
-        }
-
-        if (unlikely(al == TCG_REG_XZR)) {
-            /* ??? We want to allow al to be zero for the benefit of
-               negation via subtraction.  However, that leaves open the
-               possibility of adding 0+const in the low part, and the
-               immediate add instructions encode XSP not XZR.  Don't try
-               anything more elaborate here than loading another zero.  */
-            al = TCG_REG_TMP0;
-            tcg_out_movi(s, ext, al, 0);
-        }
-        tcg_out_insn_3401(s, insn, ext, rl, al, bl);
-    } else {
-        tcg_out_insn_3502(s, sub ? I3502_SUBS : I3502_ADDS, ext, rl, al, bl);
-    }
-
-    insn = I3503_ADC;
-    if (const_bh) {
-        /* Note that the only two constants we support are 0 and -1, and
-           that SBC = rn + ~rm + c, so adc -1 is sbc 0, and vice-versa.  */
-        if ((bh != 0) ^ sub) {
-            insn = I3503_SBC;
-        }
-        bh = TCG_REG_XZR;
-    } else if (sub) {
-        insn = I3503_SBC;
-    }
-    tcg_out_insn_3503(s, insn, ext, rh, ah, bh);
-
-    tcg_out_mov(s, ext, orig_rl, rl);
-}
-
 static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
 {
     static const uint32_t sync[] = {
@@ -2078,21 +2030,81 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3502, ADDS, type, a0, a1, a2);
+}
+
+static void tgen_addco_imm(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 >= 0) {
+        tcg_out_insn(s, 3401, ADDSI, type, a0, a1, a2);
+    } else {
+        tcg_out_insn(s, 3401, SUBSI, type, a0, a1, -a2);
+    }
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rA),
+    .out_rrr = tgen_addco,
+    .out_rri = tgen_addco_imm,
 };
 
+static void tgen_addci_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3503, ADC, type, a0, a1, a2);
+}
+
+static void tgen_addci_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    /*
+     * Note that the only two constants we support are 0 and -1, and
+     * that SBC = rn + ~rm + c, so adc -1 is sbc 0, and vice-versa.
+     */
+    if (a2) {
+        tcg_out_insn(s, 3503, SBC, type, a0, a1, TCG_REG_XZR);
+    } else {
+        tcg_out_insn(s, 3503, ADC, type, a0, a1, TCG_REG_XZR);
+    }
+}
+
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rz, rMZ),
+    .out_rrr = tgen_addci_rrr,
+    .out_rri = tgen_addci_rri,
 };
 
+static void tgen_addcio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3503, ADCS, type, a0, a1, a2);
+}
+
+static void tgen_addcio_imm(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    /* Use SBCS w/0 for ADCS w/-1 -- see above. */
+    if (a2) {
+        tcg_out_insn(s, 3503, SBCS, type, a0, a1, TCG_REG_XZR);
+    } else {
+        tcg_out_insn(s, 3503, ADCS, type, a0, a1, TCG_REG_XZR);
+    }
+}
+
 static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rz, rMZ),
+    .out_rrr = tgen_addcio,
+    .out_rri = tgen_addcio_imm,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_insn(s, 3502, SUBS, TCG_TYPE_I32,
+                 TCG_REG_XZR, TCG_REG_XZR, TCG_REG_XZR);
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -2438,21 +2450,95 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tgen_subbo_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3502, SUBS, type, a0, a1, a2);
+}
+
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 >= 0) {
+        tcg_out_insn(s, 3401, SUBSI, type, a0, a1, a2);
+    } else {
+        tcg_out_insn(s, 3401, ADDSI, type, a0, a1, -a2);
+    }
+}
+
+static void tgen_subbo_rir(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tgen_subbo_rrr(s, type, a0, TCG_REG_XZR, a2);
+}
+
+static void tgen_subbo_rii(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    if (a2 == 0) {
+        tgen_subbo_rrr(s, type, a0, TCG_REG_XZR, TCG_REG_XZR);
+        return;
+    }
+
+    /*
+     * We want to allow a1 to be zero for the benefit of negation via
+     * subtraction.  However, that leaves open the possibility of
+     * adding 0 +/- const, and the immediate add/sub instructions
+     * encode XSP not XZR.  Since we have 0 - non-zero, borrow is
+     * always set.
+     */
+    tcg_out_movi(s, type, a0, -a2);
+    tcg_out_set_borrow(s);
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rZ, rA),
+    .out_rrr = tgen_subbo_rrr,
+    .out_rri = tgen_subbo_rri,
+    .out_rir = tgen_subbo_rir,
+    .out_rii = tgen_subbo_rii,
 };
 
+static void tgen_subbi_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3503, SBC, type, a0, a1, a2);
+}
+
+static void tgen_subbi_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_addci_rri(s, type, a0, a1, ~a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rz, rMZ),
+    .out_rrr = tgen_subbi_rrr,
+    .out_rri = tgen_subbi_rri,
 };
 
+static void tgen_subbio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3503, SBCS, type, a0, a1, a2);
+}
+
+static void tgen_subbio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_addcio_imm(s, type, a0, a1, ~a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rz, rMZ),
+    .out_rrr = tgen_subbio_rrr,
+    .out_rri = tgen_subbio_rri,
 };
 
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_insn(s, 3502, ADDS, TCG_TYPE_I32,
+                 TCG_REG_XZR, TCG_REG_XZR, TCG_REG_XZR);
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
@@ -2759,25 +2845,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
         break;
 
-    case INDEX_op_add2_i32:
-        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, a2, args[3],
-                        (int32_t)args[4], args[5], const_args[4],
-                        const_args[5], false);
-        break;
-    case INDEX_op_add2_i64:
-        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, a2, args[3], args[4],
-                        args[5], const_args[4], const_args[5], false);
-        break;
-    case INDEX_op_sub2_i32:
-        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, a2, args[3],
-                        (int32_t)args[4], args[5], const_args[4],
-                        const_args[5], true);
-        break;
-    case INDEX_op_sub2_i64:
-        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, a2, args[3], args[4],
-                        args[5], const_args[4], const_args[5], true);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -3271,12 +3338,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(rz, rz, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, rz, rz, rA, rMZ);
-
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_mul_vec:
-- 
2.43.0


