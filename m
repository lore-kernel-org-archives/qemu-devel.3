Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD47C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RCv-0000L3-Af; Fri, 25 Apr 2025 18:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAz-0003iO-Ea
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAw-0001sQ-Tc
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-73972a54919so2479379b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618737; x=1746223537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TGaHDVB5ASHZCDisW6uK4px/ZapuPyr/0frVDitaEI=;
 b=MUjxZL9qesSzbspTvbAbFovzTNNOezGgQM/ks22QpmBzAtx9Hz1n9RHD/SOwdw9Qeb
 7r6+D4KzRSwfG+AFOfniiAWI/blgaBs+peMevgqmBHYtnZ7qgFp2E6wfU/alIWcAT5VK
 NnSGTJD9G9wvwPFMi1Ja0rUd3/jYNAZ9XuLRUryF+QltQoRp7f9c1OpTWOsq2RGWo62I
 /Guj3pMX9U47occYEhX/ac7zoka9N6biLO0ls4u8dMCbwN+g5Ahna9Xqr0uQQOQfQjlh
 6nCrfY98GPms3M/JbSWyQy0wXKQuOcYvPmnlNJCRunF8fqHJcL6I0v4Zz912HhjlzIPR
 H5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618737; x=1746223537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TGaHDVB5ASHZCDisW6uK4px/ZapuPyr/0frVDitaEI=;
 b=Hn99ulYGKT/JNw2EXhtLPE8YVeVSExnWdfy3AQF1gO6lnMQW3nwcf3VQa9fqyqWnLt
 QvReW7pF087nRdz24HhzTWneiZXD/3wyg/IC5LGRQIV4iKeVivApEK7AvtyODkq2H6Ou
 3k0dRvrnFpD3JlnqRYDRWBJ9K7QQxw9+BF17RYSwP/yAyfc+ZcCQ9XtR/fdhw1JnZkHc
 gdaX3/EQcFCYOmLU6z8AjRFKSuRFiy8s6OYul5T/KNbNPHou8bgyCDdw2HyUmOIX13+A
 aUHY2AgrQAulvSLhcpBM7BOvn053kHnLmOeAnsQ0gUIqRWVMLjMLaDucTH/VCvvN/OMw
 dKiQ==
X-Gm-Message-State: AOJu0YxDMc2aVTxJo8LtIIRSO2aYMXYRU43KkbNYgNMD1WrSQx1iEEbW
 DA5VIGt6pegQ8Fa/W2Qfk91bYhh+7ZqNeP+SvpI2VrY4LNUfHzFmPEW7b8MEEn9k4/Nmzu3qg+T
 J
X-Gm-Gg: ASbGncv6b63oS5ptCB+n2GiX0Ky8DYXc1ZRTOaxv7Unixs+N19YFH7MpWLC69NyqIyr
 psyRWu+5KC9YBEYfcFlB+ds+7IFQR+ZITEU0a7XJJq81KGq8Jw9LKMYyoo3o018jW6YKPXHssS+
 WGzpO1T88ERzEp0z21Ylbz4Plu8z+viiZRTU30hJgOFOrNFXu45j/ZXlBDbaANu1d3j7sqztqlw
 p1T5ApMHUhKJlRS70OKfNB5tbx1hbg3LEfzH0tuXown27aLA5ViL+FZdznPI4ZkyUrs9pQ1yON2
 DunZ/qK7N2UcjmkSIQUXi6xs18fpvU7xJAVtwvM6einpcob9wsGdnQNyd+COBDLOST12QPDPXDY
 =
X-Google-Smtp-Source: AGHT+IE99rM+urkO+KZQKCLkUqeYi0ehYZ8p5yPtUBpEAJQB3WIVWeAg3Rjy7/ijCvT3IOURXT/LDQ==
X-Received: by 2002:a05:6a20:43a8:b0:1f5:a3e8:64c1 with SMTP id
 adf61e73a8af0-2045b42a884mr5349913637.0.1745618736944; 
 Fri, 25 Apr 2025 15:05:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 138/159] tcg/ppc: Implement add/sub carry opcodes
Date: Fri, 25 Apr 2025 14:54:32 -0700
Message-ID: <20250425215454.886111-139-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Tested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |   5 +-
 tcg/ppc/tcg-target-con-str.h |   1 +
 tcg/ppc/tcg-target-has.h     |  11 +-
 tcg/ppc/tcg-target.c.inc     | 227 ++++++++++++++++++++++-------------
 4 files changed, 154 insertions(+), 90 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index 14cd217287..da7a383bff 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -29,7 +29,10 @@ C_O1_I2(r, r, rC)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rT)
 C_O1_I2(r, r, rU)
+C_O1_I2(r, r, rZM)
 C_O1_I2(r, r, rZW)
+C_O1_I2(r, rI, rN)
+C_O1_I2(r, rZM, rZM)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
 C_O1_I4(v, v, v, vZM, v)
@@ -38,5 +41,3 @@ C_O1_I4(r, r, r, rU, rC)
 C_O2_I1(r, r, r)
 C_N1O1_I1(o, m, r)
 C_O2_I2(r, r, r, r)
-C_O2_I4(r, r, rI, rZM, r, r)
-C_O2_I4(r, r, r, r, rI, rZM)
diff --git a/tcg/ppc/tcg-target-con-str.h b/tcg/ppc/tcg-target-con-str.h
index 16b687216e..faf92da47f 100644
--- a/tcg/ppc/tcg-target-con-str.h
+++ b/tcg/ppc/tcg-target-con-str.h
@@ -19,6 +19,7 @@ REGS('v', ALL_VECTOR_REGS)
 CONST('C', TCG_CT_CONST_CMP)
 CONST('I', TCG_CT_CONST_S16)
 CONST('M', TCG_CT_CONST_MONE)
+CONST('N', TCG_CT_CONST_N16)
 CONST('T', TCG_CT_CONST_S32)
 CONST('U', TCG_CT_CONST_U32)
 CONST('W', TCG_CT_CONST_WSZ)
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 8d832ce99c..4dda668706 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -18,16 +18,13 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
+
+#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#else
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 5b04655f3b..91df9610ec 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -89,14 +89,15 @@
 /* Shorthand for size of a register.  */
 #define SZR  (TCG_TARGET_REG_BITS / 8)
 
-#define TCG_CT_CONST_S16  0x100
-#define TCG_CT_CONST_U16  0x200
-#define TCG_CT_CONST_S32  0x400
-#define TCG_CT_CONST_U32  0x800
-#define TCG_CT_CONST_ZERO 0x1000
-#define TCG_CT_CONST_MONE 0x2000
-#define TCG_CT_CONST_WSZ  0x4000
-#define TCG_CT_CONST_CMP  0x8000
+#define TCG_CT_CONST_S16     0x00100
+#define TCG_CT_CONST_U16     0x00200
+#define TCG_CT_CONST_N16     0x00400
+#define TCG_CT_CONST_S32     0x00800
+#define TCG_CT_CONST_U32     0x01000
+#define TCG_CT_CONST_ZERO    0x02000
+#define TCG_CT_CONST_MONE    0x04000
+#define TCG_CT_CONST_WSZ     0x08000
+#define TCG_CT_CONST_CMP     0x10000
 
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
@@ -342,6 +343,9 @@ static bool tcg_target_const_match(int64_t sval, int ct,
     if ((ct & TCG_CT_CONST_U16) && uval == (uint16_t)uval) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_N16) && -sval == (int16_t)-sval) {
+        return 1;
+    }
     if ((ct & TCG_CT_CONST_S32) && sval == (int32_t)sval) {
         return 1;
     }
@@ -2863,21 +2867,69 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, ADDC | TAB(a0, a1, a2));
+}
+
+static void tgen_addco_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out32(s, ADDIC | TAI(a0, a1, a2));
+}
+
+static TCGConstraintSetIndex cset_addco(TCGType type, unsigned flags)
+{
+    /*
+     * Note that the CA bit is defined based on the word size of the
+     * environment.  So in 64-bit mode it's always carry-out of bit 63.
+     * The fallback code using deposit works just as well for TCG_TYPE_I32.
+     */
+    return type == TCG_TYPE_REG ? C_O1_I2(r, r, rI) : C_NotImplemented;
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addco,
+    .out_rrr = tgen_addco_rrr,
+    .out_rri = tgen_addco_rri,
+};
+
+static void tgen_addcio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, ADDE | TAB(a0, a1, a2));
+}
+
+static void tgen_addcio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out32(s, (a2 ? ADDME : ADDZE) | RT(a0) | RA(a1));
+}
+
+static TCGConstraintSetIndex cset_addcio(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I2(r, r, rZM) : C_NotImplemented;
+}
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addcio,
+    .out_rrr = tgen_addcio_rrr,
+    .out_rri = tgen_addcio_rri,
 };
 
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
-};
-
-static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addcio,
+    .out_rrr = tgen_addcio_rrr,
+    .out_rri = tgen_addcio_rri,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out32(s, SUBFC | TAB(TCG_REG_R0, TCG_REG_R0, TCG_REG_R0));
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -3284,21 +3336,94 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rir = tgen_subfi,
 };
 
+static void tgen_subbo_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, SUBFC | TAB(a0, a2, a1));
+}
+
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 == 0) {
+        tcg_out_movi(s, type, TCG_REG_R0, 0);
+        tgen_subbo_rrr(s, type, a0, a1, TCG_REG_R0);
+    } else {
+        tgen_addco_rri(s, type, a0, a1, -a2);
+    }
+}
+
+/* The underlying insn for subfi is subfic. */
+#define tgen_subbo_rir  tgen_subfi
+
+static void tgen_subbo_rii(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tcg_out_movi(s, type, TCG_REG_R0, a2);
+    tgen_subbo_rir(s, type, a0, a1, TCG_REG_R0);
+}
+
+static TCGConstraintSetIndex cset_subbo(TCGType type, unsigned flags)
+{
+    /* Recall that the CA bit is defined based on the host word size. */
+    return type == TCG_TYPE_REG ? C_O1_I2(r, rI, rN) : C_NotImplemented;
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_subbo,
+    .out_rrr = tgen_subbo_rrr,
+    .out_rri = tgen_subbo_rri,
+    .out_rir = tgen_subbo_rir,
+    .out_rii = tgen_subbo_rii,
 };
 
-static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
-};
+static void tgen_subbio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, SUBFE | TAB(a0, a2, a1));
+}
+
+static void tgen_subbio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_addcio_rri(s, type, a0, a1, ~a2);
+}
+
+static void tgen_subbio_rir(TCGContext *s, TCGType type,
+                            TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tcg_debug_assert(a1 == 0 || a1 == -1);
+    tcg_out32(s, (a1 ? SUBFME : SUBFZE) | RT(a0) | RA(a2));
+}
+
+static void tgen_subbio_rii(TCGContext *s, TCGType type,
+                            TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tcg_out_movi(s, type, TCG_REG_R0, a2);
+    tgen_subbio_rir(s, type, a0, a1, TCG_REG_R0);
+}
+
+static TCGConstraintSetIndex cset_subbio(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I2(r, rZM, rZM) : C_NotImplemented;
+}
 
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_subbio,
+    .out_rrr = tgen_subbio_rrr,
+    .out_rri = tgen_subbio_rri,
+    .out_rir = tgen_subbio_rir,
+    .out_rii = tgen_subbio_rii,
 };
 
+#define outop_subbi  outop_subbio
+
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    /* borrow = !carry */
+    tcg_out32(s, ADDIC | TAI(TCG_REG_R0, TCG_REG_R0, 0));
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
@@ -3538,8 +3663,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0, a1;
-
     switch (opc) {
     case INDEX_op_goto_ptr:
         tcg_out32(s, MTSPR | RS(args[0]) | CTR);
@@ -3635,57 +3758,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-#if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_add2_i64:
-#else
-    case INDEX_op_add2_i32:
-#endif
-        /* Note that the CA bit is defined based on the word size of the
-           environment.  So in 64-bit mode it's always carry-out of bit 63.
-           The fallback code using deposit works just as well for 32-bit.  */
-        a0 = args[0], a1 = args[1];
-        if (a0 == args[3] || (!const_args[5] && a0 == args[5])) {
-            a0 = TCG_REG_R0;
-        }
-        if (const_args[4]) {
-            tcg_out32(s, ADDIC | TAI(a0, args[2], args[4]));
-        } else {
-            tcg_out32(s, ADDC | TAB(a0, args[2], args[4]));
-        }
-        if (const_args[5]) {
-            tcg_out32(s, (args[5] ? ADDME : ADDZE) | RT(a1) | RA(args[3]));
-        } else {
-            tcg_out32(s, ADDE | TAB(a1, args[3], args[5]));
-        }
-        if (a0 != args[0]) {
-            tcg_out_mov(s, TCG_TYPE_REG, args[0], a0);
-        }
-        break;
-
-#if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_sub2_i64:
-#else
-    case INDEX_op_sub2_i32:
-#endif
-        a0 = args[0], a1 = args[1];
-        if (a0 == args[5] || (!const_args[3] && a0 == args[3])) {
-            a0 = TCG_REG_R0;
-        }
-        if (const_args[2]) {
-            tcg_out32(s, SUBFIC | TAI(a0, args[4], args[2]));
-        } else {
-            tcg_out32(s, SUBFC | TAB(a0, args[4], args[2]));
-        }
-        if (const_args[3]) {
-            tcg_out32(s, (args[3] ? SUBFME : SUBFZE) | RT(a1) | RA(args[5]));
-        } else {
-            tcg_out32(s, SUBFE | TAB(a1, args[5], args[3]));
-        }
-        if (a0 != args[0]) {
-            tcg_out_mov(s, TCG_TYPE_REG, args[0], a0);
-        }
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, args[0]);
         break;
@@ -4331,13 +4403,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add2_i64:
-    case INDEX_op_add2_i32:
-        return C_O2_I4(r, r, r, r, rI, rZM);
-    case INDEX_op_sub2_i64:
-    case INDEX_op_sub2_i32:
-        return C_O2_I4(r, r, rI, rZM, r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_ld_i64:
-- 
2.43.0


