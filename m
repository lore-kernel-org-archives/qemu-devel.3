Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7196EC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthH-0001j9-41; Thu, 11 Jul 2024 09:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthA-0001Lp-Cr
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-00064A-32
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4267300145eso6635315e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703914; x=1721308714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KFWK1AlLkOyejopjdXOzwSTKdMbuEo/cg/jpEWotNd4=;
 b=S7fe58hnOwMhvpaVKuZVd52Yle7Kcr9qiiXazBPcFttSWeEYlxK62183abCs7LfStD
 0OHvJ1HwSnqpraZv81HSYfYfvDOEonJIE5QUJ6ZUhy/IFy+JDuFpPhnlz8mbd0P8mhnr
 g4DW/yZYuMAgksvwdUXvpmoTv3X8yFMjeuRtanKDdUugQhko8S2IkuzQYS2jIRU/qDFW
 3lxAGuN1jhGwGeW11FcFVRsRqu2G6Cpc0U/5M3pyx/q5yLsFFfE4zGwQoKYoX1DCdtKq
 BhXKObmPP6+mk4mq+ISaGUNj32mvYvSuzWr4qW9McF2AwxIfp7DmGuiYjcczFqP31FeA
 lRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703914; x=1721308714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KFWK1AlLkOyejopjdXOzwSTKdMbuEo/cg/jpEWotNd4=;
 b=SP3CZCRAYZDeVrTuKKdtKechOXoba8hhpCE/sGmFYfqfgblkVwxn3KQToGWAX2kPKU
 4T8kw6fcI9ZPvUZjfwu5ygeWLRLHG2qSoyuJ5+hSogVMSN1/ypFK+dhMTbFDTBBkgHWw
 1kX8IsDt3rBsCMxlAmjq8+nGiYxuZd2BIPlTdMjK/gz7DalYCEPv/tgrXZbA2pKpPKDV
 aNrk8/DcCXZOeSd2hnAdNztZvaxYTpQody/eSWCKQQysjRhgk2kiVqbfHnkdpgaoFK9x
 UOQPKuVwTVKFkgZsHCnZJVHwq428I36TCRZ6QULRKAmwGyEn5MeenY1OypdLUtexHpsc
 3QdQ==
X-Gm-Message-State: AOJu0Yw2Q2VhCbqUetHX4cRSAL67QBzJ8SQDGtXLWr85lL3zYezkFazI
 rQFCvAjZ2Mc4vi0EdwmC8GPWrp9TGko27pa/2YojVqMb7m89LvVsn6xItzWlgvf47h+/h4ouz41
 NV8o=
X-Google-Smtp-Source: AGHT+IH4ZdSyq7/cUlgo19rDUDBA3IAfT3wGUkj83T5TZeupUZM2jCmc6VO71qiNd+Y/i7weYeaGIQ==
X-Received: by 2002:a05:600c:6a12:b0:426:6bf9:608d with SMTP id
 5b1f17b1804b1-426707cf81cmr65512885e9.12.1720703914065; 
 Thu, 11 Jul 2024 06:18:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/24] target/arm: Convert SMULL, UMULL, SMLAL, UMLAL, SMLSL,
 UMLSL to decodetree
Date: Thu, 11 Jul 2024 14:18:17 +0100
Message-Id: <20240711131822.3909903-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240709000610.382391-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  22 ++++
 target/arm/tcg/translate-a64.c | 184 ++++++++++++++++++++++++---------
 2 files changed, 156 insertions(+), 50 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 223eac3cac2..513d112787b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -962,6 +962,13 @@ FCADD_270       0.10 1110 ..0 ..... 11110 1 ..... ..... @qrrr_e
 
 FCMLA_v         0 q:1 10 1110 esz:2 0 rm:5 110 rot:2 1 rn:5 rd:5
 
+SMULL_v         0.00 1110 ..1 ..... 11000 0 ..... ..... @qrrr_e
+UMULL_v         0.10 1110 ..1 ..... 11000 0 ..... ..... @qrrr_e
+SMLAL_v         0.00 1110 ..1 ..... 10000 0 ..... ..... @qrrr_e
+UMLAL_v         0.10 1110 ..1 ..... 10000 0 ..... ..... @qrrr_e
+SMLSL_v         0.00 1110 ..1 ..... 10100 0 ..... ..... @qrrr_e
+UMLSL_v         0.10 1110 ..1 ..... 10100 0 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1047,6 +1054,21 @@ FCMLA_vi        0 0 10 1111 01 idx:1 rm:5 0 rot:2 1 0 0 rn:5 rd:5 esz=1 q=0
 FCMLA_vi        0 1 10 1111 01 . rm:5 0 rot:2 1 . 0 rn:5 rd:5 esz=1 idx=%hl q=1
 FCMLA_vi        0 1 10 1111 10 0 rm:5 0 rot:2 1 idx:1 0 rn:5 rd:5 esz=2 q=1
 
+SMULL_vi        0.00 1111 01 .. .... 1010 . 0 ..... .....   @qrrx_h
+SMULL_vi        0.00 1111 10 . ..... 1010 . 0 ..... .....   @qrrx_s
+UMULL_vi        0.10 1111 01 .. .... 1010 . 0 ..... .....   @qrrx_h
+UMULL_vi        0.10 1111 10 . ..... 1010 . 0 ..... .....   @qrrx_s
+
+SMLAL_vi        0.00 1111 01 .. .... 0010 . 0 ..... .....   @qrrx_h
+SMLAL_vi        0.00 1111 10 . ..... 0010 . 0 ..... .....   @qrrx_s
+UMLAL_vi        0.10 1111 01 .. .... 0010 . 0 ..... .....   @qrrx_h
+UMLAL_vi        0.10 1111 10 . ..... 0010 . 0 ..... .....   @qrrx_s
+
+SMLSL_vi        0.00 1111 01 .. .... 0110 . 0 ..... .....   @qrrx_h
+SMLSL_vi        0.00 1111 10 . ..... 0110 . 0 ..... .....   @qrrx_s
+UMLSL_vi        0.10 1111 01 .. .... 0110 . 0 ..... .....   @qrrx_h
+UMLSL_vi        0.10 1111 10 . ..... 0110 . 0 ..... .....   @qrrx_s
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6c07aeaf3bd..8f0781e1f7e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5664,6 +5664,121 @@ static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
     return true;
 }
 
+/*
+ * Widening vector x vector/indexed.
+ *
+ * These read from the top or bottom half of a 128-bit vector.
+ * After widening, optionally accumulate with a 128-bit vector.
+ * Implement these inline, as the number of elements are limited
+ * and the related SVE and SME operations on larger vectors use
+ * even/odd elements instead of top/bottom half.
+ *
+ * If idx >= 0, operand 2 is indexed, otherwise vector.
+ * If acc, operand 0 is loaded with rd.
+ */
+
+/* For low half, iterating up. */
+static bool do_3op_widening(DisasContext *s, MemOp memop, int top,
+                            int rd, int rn, int rm, int idx,
+                            NeonGenTwo64OpFn *fn, bool acc)
+{
+    TCGv_i64 tcg_op0 = tcg_temp_new_i64();
+    TCGv_i64 tcg_op1 = tcg_temp_new_i64();
+    TCGv_i64 tcg_op2 = tcg_temp_new_i64();
+    MemOp esz = memop & MO_SIZE;
+    int half = 8 >> esz;
+    int top_swap, top_half;
+
+    /* There are no 64x64->128 bit operations. */
+    if (esz >= MO_64) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    if (idx >= 0) {
+        read_vec_element(s, tcg_op2, rm, idx, memop);
+    }
+
+    /*
+     * For top half inputs, iterate forward; backward for bottom half.
+     * This means the store to the destination will not occur until
+     * overlapping input inputs are consumed.
+     * Use top_swap to conditionally invert the forward iteration index.
+     */
+    top_swap = top ? 0 : half - 1;
+    top_half = top ? half : 0;
+
+    for (int elt_fwd = 0; elt_fwd < half; ++elt_fwd) {
+        int elt = elt_fwd ^ top_swap;
+
+        read_vec_element(s, tcg_op1, rn, elt + top_half, memop);
+        if (idx < 0) {
+            read_vec_element(s, tcg_op2, rm, elt + top_half, memop);
+        }
+        if (acc) {
+            read_vec_element(s, tcg_op0, rd, elt, memop + 1);
+        }
+        fn(tcg_op0, tcg_op1, tcg_op2);
+        write_vec_element(s, tcg_op0, rd, elt, esz + 1);
+    }
+    clear_vec_high(s, 1, rd);
+    return true;
+}
+
+static void gen_muladd_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    tcg_gen_mul_i64(t, n, m);
+    tcg_gen_add_i64(d, d, t);
+}
+
+static void gen_mulsub_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    tcg_gen_mul_i64(t, n, m);
+    tcg_gen_sub_i64(d, d, t);
+}
+
+TRANS(SMULL_v, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, -1,
+      tcg_gen_mul_i64, false)
+TRANS(UMULL_v, do_3op_widening,
+      a->esz, a->q, a->rd, a->rn, a->rm, -1,
+      tcg_gen_mul_i64, false)
+TRANS(SMLAL_v, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, -1,
+      gen_muladd_i64, true)
+TRANS(UMLAL_v, do_3op_widening,
+      a->esz, a->q, a->rd, a->rn, a->rm, -1,
+      gen_muladd_i64, true)
+TRANS(SMLSL_v, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, -1,
+      gen_mulsub_i64, true)
+TRANS(UMLSL_v, do_3op_widening,
+      a->esz, a->q, a->rd, a->rn, a->rm, -1,
+      gen_mulsub_i64, true)
+
+TRANS(SMULL_vi, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, a->idx,
+      tcg_gen_mul_i64, false)
+TRANS(UMULL_vi, do_3op_widening,
+      a->esz, a->q, a->rd, a->rn, a->rm, a->idx,
+      tcg_gen_mul_i64, false)
+TRANS(SMLAL_vi, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, a->idx,
+      gen_muladd_i64, true)
+TRANS(UMLAL_vi, do_3op_widening,
+      a->esz, a->q, a->rd, a->rn, a->rm, a->idx,
+      gen_muladd_i64, true)
+TRANS(SMLSL_vi, do_3op_widening,
+      a->esz | MO_SIGN, a->q, a->rd, a->rn, a->rm, a->idx,
+      gen_mulsub_i64, true)
+TRANS(UMLSL_vi, do_3op_widening,
+      a->esz, a->q, a->rd, a->rn, a->rm, a->idx,
+      gen_mulsub_i64, true)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -10684,11 +10799,6 @@ static void handle_3rd_widening(DisasContext *s, int is_q, int is_u, int size,
                                     tcg_op1, tcg_op2, tcg_tmp1, tcg_tmp2);
                 break;
             }
-            case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-            case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-            case 12: /* UMULL, UMULL2, SMULL, SMULL2 */
-                tcg_gen_mul_i64(tcg_passres, tcg_op1, tcg_op2);
-                break;
             case 9: /* SQDMLAL, SQDMLAL2 */
             case 11: /* SQDMLSL, SQDMLSL2 */
             case 13: /* SQDMULL, SQDMULL2 */
@@ -10697,6 +10807,9 @@ static void handle_3rd_widening(DisasContext *s, int is_q, int is_u, int size,
                                                   tcg_passres, tcg_passres);
                 break;
             default:
+            case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
+            case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
+            case 12: /* UMULL, UMULL2, SMULL, SMULL2 */
                 g_assert_not_reached();
             }
 
@@ -10763,23 +10876,6 @@ static void handle_3rd_widening(DisasContext *s, int is_q, int is_u, int size,
                     }
                 }
                 break;
-            case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-            case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-            case 12: /* UMULL, UMULL2, SMULL, SMULL2 */
-                if (size == 0) {
-                    if (is_u) {
-                        gen_helper_neon_mull_u8(tcg_passres, tcg_op1, tcg_op2);
-                    } else {
-                        gen_helper_neon_mull_s8(tcg_passres, tcg_op1, tcg_op2);
-                    }
-                } else {
-                    if (is_u) {
-                        gen_helper_neon_mull_u16(tcg_passres, tcg_op1, tcg_op2);
-                    } else {
-                        gen_helper_neon_mull_s16(tcg_passres, tcg_op1, tcg_op2);
-                    }
-                }
-                break;
             case 9: /* SQDMLAL, SQDMLAL2 */
             case 11: /* SQDMLSL, SQDMLSL2 */
             case 13: /* SQDMULL, SQDMULL2 */
@@ -10789,6 +10885,9 @@ static void handle_3rd_widening(DisasContext *s, int is_q, int is_u, int size,
                                                   tcg_passres, tcg_passres);
                 break;
             default:
+            case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
+            case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
+            case 12: /* UMULL, UMULL2, SMULL, SMULL2 */
                 g_assert_not_reached();
             }
 
@@ -10981,9 +11080,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
     case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
     case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
-    case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-    case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-    case 12: /* SMULL, SMULL2, UMULL, UMULL2 */
         /* 64 x 64 -> 128 */
         if (size == 3) {
             unallocated_encoding(s);
@@ -10996,6 +11092,9 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
         handle_3rd_widening(s, is_q, is_u, size, opcode, rd, rn, rm);
         break;
     default:
+    case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
+    case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
+    case 12: /* SMULL, SMULL2, UMULL, UMULL2 */
         /* opcode 15 not allocated */
         unallocated_encoding(s);
         break;
@@ -11979,17 +12078,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     int index;
 
     switch (16 * u + opcode) {
-    case 0x02: /* SMLAL, SMLAL2 */
-    case 0x12: /* UMLAL, UMLAL2 */
-    case 0x06: /* SMLSL, SMLSL2 */
-    case 0x16: /* UMLSL, UMLSL2 */
-    case 0x0a: /* SMULL, SMULL2 */
-    case 0x1a: /* UMULL, UMULL2 */
-        if (is_scalar) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x03: /* SQDMLAL, SQDMLAL2 */
     case 0x07: /* SQDMLSL, SQDMLSL2 */
     case 0x0b: /* SQDMULL, SQDMULL2 */
@@ -11997,22 +12085,28 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     default:
     case 0x00: /* FMLAL */
     case 0x01: /* FMLA */
+    case 0x02: /* SMLAL, SMLAL2 */
     case 0x04: /* FMLSL */
     case 0x05: /* FMLS */
+    case 0x06: /* SMLSL, SMLSL2 */
     case 0x08: /* MUL */
     case 0x09: /* FMUL */
+    case 0x0a: /* SMULL, SMULL2 */
     case 0x0c: /* SQDMULH */
     case 0x0d: /* SQRDMULH */
     case 0x0e: /* SDOT */
     case 0x0f: /* SUDOT / BFDOT / USDOT / BFMLAL */
     case 0x10: /* MLA */
     case 0x11: /* FCMLA #0 */
+    case 0x12: /* UMLAL, UMLAL2 */
     case 0x13: /* FCMLA #90 */
     case 0x14: /* MLS */
     case 0x15: /* FCMLA #180 */
+    case 0x16: /* UMLSL, UMLSL2 */
     case 0x17: /* FCMLA #270 */
     case 0x18: /* FMLAL2 */
     case 0x19: /* FMULX */
+    case 0x1a: /* UMULL, UMULL2 */
     case 0x1c: /* FMLSL2 */
     case 0x1d: /* SQRDMLAH */
     case 0x1e: /* UDOT */
@@ -12098,12 +12192,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 read_vec_element(s, tcg_res[pass], rd, pass, MO_64);
 
                 switch (opcode) {
-                case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-                    tcg_gen_add_i64(tcg_res[pass], tcg_res[pass], tcg_passres);
-                    break;
-                case 0x6: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-                    tcg_gen_sub_i64(tcg_res[pass], tcg_res[pass], tcg_passres);
-                    break;
                 case 0x7: /* SQDMLSL, SQDMLSL2 */
                     tcg_gen_neg_i64(tcg_passres, tcg_passres);
                     /* fall through */
@@ -12113,6 +12201,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                                                       tcg_passres);
                     break;
                 default:
+                case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
+                case 0x6: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
                     g_assert_not_reached();
                 }
             }
@@ -12170,14 +12260,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 read_vec_element(s, tcg_res[pass], rd, pass, MO_64);
 
                 switch (opcode) {
-                case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-                    gen_helper_neon_addl_u32(tcg_res[pass], tcg_res[pass],
-                                             tcg_passres);
-                    break;
-                case 0x6: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-                    gen_helper_neon_subl_u32(tcg_res[pass], tcg_res[pass],
-                                             tcg_passres);
-                    break;
                 case 0x7: /* SQDMLSL, SQDMLSL2 */
                     gen_helper_neon_negl_u32(tcg_passres, tcg_passres);
                     /* fall through */
@@ -12187,6 +12269,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                                                       tcg_passres);
                     break;
                 default:
+                case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
+                case 0x6: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
                     g_assert_not_reached();
                 }
             }
-- 
2.34.1


