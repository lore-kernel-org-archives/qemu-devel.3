Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D8FC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuy-0006bI-UQ; Sun, 16 Feb 2025 18:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntT-00036F-Af
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:47 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntR-00066U-1h
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:46 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-221050f3f00so23673385ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747863; x=1740352663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eDymodH705VRogHr7TocuN2Q0xAtx3kY8pVYWMShWME=;
 b=nKP4Yg5DxPDqV2cRA5cB4aFVryUE2Y0+IRYc+BhGpoKna7vtKa0gI9jYu4bpT1bGua
 2cQByqLYdE64PVccyOrLw6ln8w3VT5PMCwNFG8ccm/IZXG3ozOfsZ8DV48zHhtlIqis9
 l23yoEKtK9ESkaboexOOUwumOrkm97if6l5z/aZZbLDi5qzWXaFd1p+ZqtsLQjtOwFCu
 NqijKz1bfToV8nGQawPD+22boPBhUHyqLrNmYGsG72tbBIlfYgZJ0o1nJFbrIy58oAH1
 Tzz3kQkZaN747qQXuwQIp+zZzCzGVNbRrSwbbBJvcd81huyA9Z8EZUMe+pq4/FALmYEe
 y5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747863; x=1740352663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDymodH705VRogHr7TocuN2Q0xAtx3kY8pVYWMShWME=;
 b=QzX376daNqLNGU8hGbVNhhuLSDWXl9h6mtnzTfA8V8c5ph9exbK8W88rpAZiayvTFQ
 f+neDkz6oDtA/Ba6NbJVmBlt9I+HJ5QulUCyEXTzwnIT0TPMrsgGyjAucaHUlGIOkWXV
 1kitYNJP71hsUrPD23WGjmPCZ/CrsUBt4Vlbun9yOujXiALiP1INZ04Hp6fIRhJ2W9km
 8CgUxTwIUJNhfkzXc3/JWZqLmochBFVCQm/PXwBeoVzPJvY7cwVOovu8RvOzCArzJ9Aa
 RddfM28VJDMY4g1qNzllv4MzmpQrequC3vp4lYTyAdHRnXGL2sOFnMquQaPfL015xPA3
 AeaA==
X-Gm-Message-State: AOJu0Yy+mWVIDY0OJjqa/iroYpNkf4AqjViGKJ77Oo2Fni7FXp/MJ+fV
 FD6so7j1hOJSwVtsfsNNAbTZSs5L//kRA+PvzuEd4Ljw44xbNR4Kk68V9AoTg0ZUp+8FFdtvkek
 L
X-Gm-Gg: ASbGnctBhG1Hyg31r5ld+wFznP0e9/iQxaH+lO2kALk5nB/pr/iMce6/GKNSYtGL/+k
 1iH3HLzn3EI+oZsLb2xW5CQxoRv10wVruo84qiC7xyiIjuYWibnS2WhmpyapeqmlahC2zEOT+KV
 zD75/TK8Rf/A1LPgBcIMOyDSPk/6cttLlWXLnK31ByzoZV5KcXK7xgky5snAe2r5a3279/0etwD
 RDP4B6vq2Kc/mGwhJXtrv9u/WOcoVILGCzkw/DkNNx0+fgNrof98P7Hp4ozrKd6KPNI4AO5bKwz
 GqhocIqVG8X9Eb/6WNm3JVTZH0switwFfCZoDnYZgjCxBK4=
X-Google-Smtp-Source: AGHT+IG8uLJigv9gpAzkzXRGauVGJcGHm/3NbtFQY2emcd/5t79bbeJCHkANYWWxh9YnKttuc5zccg==
X-Received: by 2002:a17:902:cccc:b0:220:e04e:7213 with SMTP id
 d9443c01a7336-22104042474mr123055665ad.25.1739747863463; 
 Sun, 16 Feb 2025 15:17:43 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 119/162] tcg/i386: Implement add/sub carry opcodes
Date: Sun, 16 Feb 2025 15:09:28 -0800
Message-ID: <20250216231012.2808572-120-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
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
 tcg/i386/tcg-target.c.inc | 86 ++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 14 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index cbe67102aa..524e288f26 100644
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
-- 
2.43.0


