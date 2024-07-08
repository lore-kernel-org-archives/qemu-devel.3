Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E934DC3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 00:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQyGs-0004xq-Mn; Mon, 08 Jul 2024 19:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyGo-0004ke-LF
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 19:59:47 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyGl-0000dA-OQ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 19:59:46 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f65a3abd01so32025125ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 16:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720483182; x=1721087982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QZjEZqiZahqztsYL9buht7HyZWHWFh4XOBO2Yk44EQ=;
 b=GeiKzjq65dvEhiKM6HaPvjFqrgKcN/r/SJhgvURlUc93SlTCccgEjx6ufrpPz5x7g9
 ZVnywnlZSNY/tFo0zwyzDDTV3T9YdlMmjxic5S9oo1pyBW1HUbwmc1JAVQ3g8poyLMwr
 6hyCvk4m1qlxw+L3YbxbmBnjtfL3ov1z5yM+0dQMzSRKHz0Z1nsQMHuZ8c9Ko7ux6H9P
 6esNa3rESnFrFiGTPlPQNBl1Is5/eQQ6HPlVw4PMRqPwKqA6fg93bWG4wzlEXzdpZx+k
 qktpZHuUut2kDfexUL1r+efN9dR1UtlMON3bHi2CrQ4Brv5QyRNdzzg4aIo8NZvS6E/7
 w1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720483182; x=1721087982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6QZjEZqiZahqztsYL9buht7HyZWHWFh4XOBO2Yk44EQ=;
 b=GBaOkK51C33SXJcOFZJTsMWzd0UwL2I7Ljzln+iB6Kp3N4Oz7lsCW+YHoIHaQ2xDkj
 tDgkymxxkYqJdR4OXcSxO+xSVcOVCHVudLvMA2GVmbx+Z7PsKdLODGwvpLtZp2Jrbl0V
 M38KEZ8X0I5qwYcxhbZ91bA5utVWVWCrTkSGomidJgLBQrwK0MPrbKUJs9VuJLb8YtUd
 gqg79fIz//m9jbfRalvtvkAIDxAZTQKmFgFnSySTcCNbmFnJwo56z7L3Xn98PQoBOcfe
 I46H0ZaUn8USOhmdpxulYptdeuT+JXXSxqoixf516sHX7UyDKUWaCrsMMTmvVnHtyOsK
 OeNQ==
X-Gm-Message-State: AOJu0YxUz/kIXIfUP2rfMseRN3KLFvB6vSePEkgv7IxpCoET+FcSjoH5
 BtRc/QiF00Ip/wsyjjRDvwrwntDqLnQrBjuxws9jWJdBrdLZ4T9XRYz+L+jn3vSek2ei39yv+CS
 Xp0A=
X-Google-Smtp-Source: AGHT+IEorx+lGhD+sKzIJoeDOx4lV0o85U/1UmaSiHyRoJvRT1umfOdxL/XoJYDky/3IQB7n4+gFSw==
X-Received: by 2002:a17:902:ea07:b0:1fb:75b6:a43d with SMTP id
 d9443c01a7336-1fbb6d4c958mr10008575ad.32.1720483182165; 
 Mon, 08 Jul 2024 16:59:42 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ac0841sm4156325ad.211.2024.07.08.16.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 16:59:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.prg
Subject: [PATCH 5/6] target/arm: Convert ADDHN, SUBHN, RADDHN,
 RSUBHN to decodetree
Date: Mon,  8 Jul 2024 16:59:35 -0700
Message-ID: <20240708235936.382058-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708235936.382058-1-richard.henderson@linaro.org>
References: <20240708235936.382058-1-richard.henderson@linaro.org>
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
 target/arm/tcg/translate-a64.c | 127 +++++++++++++++------------------
 target/arm/tcg/a64.decode      |   5 ++
 2 files changed, 61 insertions(+), 71 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 264d2eeb27..3e0dacdd63 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5949,6 +5949,60 @@ TRANS(UADDW, do_addsub_wide, a, 0, false)
 TRANS(SSUBW, do_addsub_wide, a, MO_SIGN, true)
 TRANS(USUBW, do_addsub_wide, a, 0, true)
 
+static bool do_addsub_highnarrow(DisasContext *s, arg_qrrr_e *a,
+                                 bool sub, bool round)
+{
+    TCGv_i64 tcg_op0, tcg_op1;
+    MemOp esz = a->esz;
+    int half = 8 >> esz;
+    bool top = a->q;
+    int ebits = 8 << esz;
+    uint64_t rbit = 1ull << (ebits - 1);
+    int top_swap, top_half;
+
+    /* There are no 128x128->64 bit operations. */
+    if (esz >= MO_64) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+    tcg_op0 = tcg_temp_new_i64();
+    tcg_op1 = tcg_temp_new_i64();
+
+    /*
+     * For top half inputs, iterate backward; forward for bottom half.
+     * This means the store to the destination will not occur until
+     * overlapping input inputs are consumed.
+     */
+    top_swap = top ? half - 1 : 0;
+    top_half = top ? half : 0;
+
+    for (int elt_fwd = 0; elt_fwd < half; ++elt_fwd) {
+        int elt = elt_fwd ^ top_swap;
+
+        read_vec_element(s, tcg_op1, a->rm, elt, esz + 1);
+        read_vec_element(s, tcg_op0, a->rn, elt, esz + 1);
+        if (sub) {
+            tcg_gen_sub_i64(tcg_op0, tcg_op0, tcg_op1);
+        } else {
+            tcg_gen_add_i64(tcg_op0, tcg_op0, tcg_op1);
+        }
+        if (round) {
+            tcg_gen_addi_i64(tcg_op0, tcg_op0, rbit);
+        }
+        tcg_gen_shri_i64(tcg_op0, tcg_op0, ebits);
+        write_vec_element(s, tcg_op0, a->rd, elt + top_half, esz);
+    }
+    clear_vec_high(s, top, a->rd);
+    return true;
+}
+
+TRANS(ADDHN, do_addsub_highnarrow, a, false, false)
+TRANS(SUBHN, do_addsub_highnarrow, a, true, false)
+TRANS(RADDHN, do_addsub_highnarrow, a, false, true)
+TRANS(RSUBHN, do_addsub_highnarrow, a, true, true)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -10813,65 +10867,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Generate code to do a "long" addition or subtraction, ie one done in
- * TCGv_i64 on vector lanes twice the width specified by size.
- */
-static void gen_neon_addl(int size, bool is_sub, TCGv_i64 tcg_res,
-                          TCGv_i64 tcg_op1, TCGv_i64 tcg_op2)
-{
-    static NeonGenTwo64OpFn * const fns[3][2] = {
-        { gen_helper_neon_addl_u16, gen_helper_neon_subl_u16 },
-        { gen_helper_neon_addl_u32, gen_helper_neon_subl_u32 },
-        { tcg_gen_add_i64, tcg_gen_sub_i64 },
-    };
-    NeonGenTwo64OpFn *genfn;
-    assert(size < 3);
-
-    genfn = fns[size][is_sub];
-    genfn(tcg_res, tcg_op1, tcg_op2);
-}
-
-static void do_narrow_round_high_u32(TCGv_i32 res, TCGv_i64 in)
-{
-    tcg_gen_addi_i64(in, in, 1U << 31);
-    tcg_gen_extrh_i64_i32(res, in);
-}
-
-static void handle_3rd_narrowing(DisasContext *s, int is_q, int is_u, int size,
-                                 int opcode, int rd, int rn, int rm)
-{
-    TCGv_i32 tcg_res[2];
-    int part = is_q ? 2 : 0;
-    int pass;
-
-    for (pass = 0; pass < 2; pass++) {
-        TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-        TCGv_i64 tcg_op2 = tcg_temp_new_i64();
-        TCGv_i64 tcg_wideres = tcg_temp_new_i64();
-        static NeonGenNarrowFn * const narrowfns[3][2] = {
-            { gen_helper_neon_narrow_high_u8,
-              gen_helper_neon_narrow_round_high_u8 },
-            { gen_helper_neon_narrow_high_u16,
-              gen_helper_neon_narrow_round_high_u16 },
-            { tcg_gen_extrh_i64_i32, do_narrow_round_high_u32 },
-        };
-        NeonGenNarrowFn *gennarrow = narrowfns[size][is_u];
-
-        read_vec_element(s, tcg_op1, rn, pass, MO_64);
-        read_vec_element(s, tcg_op2, rm, pass, MO_64);
-
-        gen_neon_addl(size, (opcode == 6), tcg_wideres, tcg_op1, tcg_op2);
-
-        tcg_res[pass] = tcg_temp_new_i32();
-        gennarrow(tcg_res[pass], tcg_wideres);
-    }
-
-    for (pass = 0; pass < 2; pass++) {
-        write_vec_element_i32(s, tcg_res[pass], rd, pass + part, MO_32);
-    }
-    clear_vec_high(s, is_q, rd);
-}
-
 /* AdvSIMD three different
  *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+---+------+--------+-----+------+------+
@@ -10899,18 +10894,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     int rd = extract32(insn, 0, 5);
 
     switch (opcode) {
-    case 4: /* ADDHN, ADDHN2, RADDHN, RADDHN2 */
-    case 6: /* SUBHN, SUBHN2, RSUBHN, RSUBHN2 */
-        /* 128 x 128 -> 64 */
-        if (size == 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_3rd_narrowing(s, is_q, is_u, size, opcode, rd, rn, rm);
-        break;
     case 14: /* PMULL, PMULL2 */
         if (is_u) {
             unallocated_encoding(s);
@@ -10949,7 +10932,9 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     case 1: /* SADDW, SADDW2, UADDW, UADDW2 */
     case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
     case 3: /* SSUBW, SSUBW2, USUBW, USUBW2 */
+    case 4: /* ADDHN, ADDHN2, RADDHN, RADDHN2 */
     case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
+    case 6: /* SUBHN, SUBHN2, RSUBHN, RSUBHN2 */
     case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
     case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
     case 9: /* SQDMLAL, SQDMLAL2 */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 32e2f3a0d5..afb34a8fd4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -998,6 +998,11 @@ UADDW           0.10 1110 ..1 ..... 00010 0 ..... ..... @qrrr_e
 SSUBW           0.00 1110 ..1 ..... 00110 0 ..... ..... @qrrr_e
 USUBW           0.10 1110 ..1 ..... 00110 0 ..... ..... @qrrr_e
 
+ADDHN           0.00 1110 ..1 ..... 01000 0 ..... ..... @qrrr_e
+RADDHN          0.10 1110 ..1 ..... 01000 0 ..... ..... @qrrr_e
+SUBHN           0.00 1110 ..1 ..... 01100 0 ..... ..... @qrrr_e
+RSUBHN          0.10 1110 ..1 ..... 01100 0 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


