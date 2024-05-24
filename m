Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35085C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEc-0006ol-78; Fri, 24 May 2024 19:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeET-0006dy-1H
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEN-0005pg-2P
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054bso1393290b3a.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592906; x=1717197706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVRp8SA5uhJhEt4SEBJKz9y1VKM1Vkbew4OmDfeOn1Y=;
 b=zSvsei9ACM1vc7Bkx5q76VxsoJETk5VuSpZg9UEJz2aY116NVCMT2Qkwdvd4PST4aD
 cRloJrVZIwcEjiEi97ysAxnZ3pwLhX+rZSRKPKy90MJ59nMoKYg+LASnggqb+hEsHlGL
 Fu3nwUyzDmWUTHXWg0iSefBnvclJOUXnKqbROXlaD8ghfoTuY2Zmqt1/lCu2f8oj372S
 VHKe0eltLyWMa2IPaHXBJQsEsGR/F1Gk9PqpgNq+vWRW4oWjWBDR9SVfVNvgyg9PgC9g
 m/8/PX/080Pm3IVzDloWg5RnbrPw6wA7kyFwjnnVtGf2MaFVER6oseB+5v5jZvhKnphl
 W3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592906; x=1717197706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SVRp8SA5uhJhEt4SEBJKz9y1VKM1Vkbew4OmDfeOn1Y=;
 b=pJjJJ098yl3G/JZK9G+S91ekRqBkx5O/cAbKvEcGlEg7kI6E+C6IAkB/q0Fl+1hTTY
 cr22kx9nTgpGoWlNKschMbPToHN/lNfOej7Kp+RUAOuyrRuceaYivXuyrIBz82j7h4lA
 v8Pv9TXxGPz6t8r3cRzPC92RPr1w31bK8n6213jU0ZK4xBjHlbaLmvwqtX7CqXr+YLl/
 IQMZ0j1ASiA9FefJt3OGs2eDdwQBqEOxZvTJdxkqTjVPoxfZnJ9a519LrUHwDnrpIJCd
 6DrUQHvnD01cVkKZ9jfSocT4ZbxlhX4ku2QzaN9t04Wh4Hnch4T9UoclslfLdjEoUGYw
 c6cw==
X-Gm-Message-State: AOJu0YybYKOwASBwWP4fw9Z2XPjnJaOKxd/31vI9/IS1paieOpp1+MUE
 aX5NOwq2IeDK0aIGcssHOiGbL5MfmlrR+Hj2s9wtfG/LJg/tIerzpIe6kSXMHS01o7eDIS6yZCk
 O
X-Google-Smtp-Source: AGHT+IGUPNVompDLxm1nK7x9AnFN5sbNzsaL8cBcALQchkLDX4sH7ZHsSBqq2KosmpvmthLIkYY9Gw==
X-Received: by 2002:a17:903:1248:b0:1f3:11ec:cbce with SMTP id
 d9443c01a7336-1f4498f0b7bmr44485315ad.58.1716592905764; 
 Fri, 24 May 2024 16:21:45 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 26/67] target/arm: Convert FABD to decodetree
Date: Fri, 24 May 2024 16:20:40 -0700
Message-Id: <20240524232121.284515-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  1 +
 target/arm/tcg/a64.decode      |  6 ++++
 target/arm/tcg/translate-a64.c | 60 ++++++++++++++++++++++------------
 target/arm/tcg/vec_helper.c    |  6 ++++
 4 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8d076011c1..ff6e3094f4 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -724,6 +724,7 @@ DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7fc3277be6..a852b5f06f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -728,6 +728,9 @@ FACGE_s         0111 1110 0.1 ..... 11101 1 ..... ..... @rrr_sd
 FACGT_s         0111 1110 110 ..... 00101 1 ..... ..... @rrr_h
 FACGT_s         0111 1110 1.1 ..... 11101 1 ..... ..... @rrr_sd
 
+FABD_s          0111 1110 110 ..... 00010 1 ..... ..... @rrr_h
+FABD_s          0111 1110 1.1 ..... 11010 1 ..... ..... @rrr_sd
+
 ### Advanced SIMD three same
 
 FADD_v          0.00 1110 010 ..... 00010 1 ..... ..... @qrrr_h
@@ -778,6 +781,9 @@ FACGE_v         0.10 1110 0.1 ..... 11101 1 ..... ..... @qrrr_sd
 FACGT_v         0.10 1110 110 ..... 00101 1 ..... ..... @qrrr_h
 FACGT_v         0.10 1110 1.1 ..... 11101 1 ..... ..... @qrrr_sd
 
+FABD_v          0.10 1110 110 ..... 00010 1 ..... ..... @qrrr_h
+FABD_v          0.10 1110 1.1 ..... 11010 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 75b0c1a005..633384d2a5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5010,6 +5010,31 @@ static const FPScalar f_scalar_facgt = {
 };
 TRANS(FACGT_s, do_fp3_scalar, a, &f_scalar_facgt)
 
+static void gen_fabd_h(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subh(d, n, m, s);
+    gen_vfp_absh(d, d);
+}
+
+static void gen_fabd_s(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subs(d, n, m, s);
+    gen_vfp_abss(d, d);
+}
+
+static void gen_fabd_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subd(d, n, m, s);
+    gen_vfp_absd(d, d);
+}
+
+static const FPScalar f_scalar_fabd = {
+    gen_fabd_h,
+    gen_fabd_s,
+    gen_fabd_d,
+};
+TRANS(FABD_s, do_fp3_scalar, a, &f_scalar_fabd)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5150,6 +5175,13 @@ static gen_helper_gvec_3_ptr * const f_vector_facgt[3] = {
 };
 TRANS(FACGT_v, do_fp3_vector, a, f_vector_facgt)
 
+static gen_helper_gvec_3_ptr * const f_vector_fabd[3] = {
+    gen_helper_gvec_fabd_h,
+    gen_helper_gvec_fabd_s,
+    gen_helper_gvec_fabd_d,
+};
+TRANS(FABD_v, do_fp3_vector, a, f_vector_fabd)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -9303,10 +9335,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x7a: /* FABD */
-                gen_helper_vfp_subd(tcg_res, tcg_op1, tcg_op2, fpst);
-                gen_vfp_absd(tcg_res, tcg_res);
-                break;
             default:
             case 0x18: /* FMAXNM */
             case 0x19: /* FMLA */
@@ -9322,6 +9350,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x5c: /* FCMGE */
             case 0x5d: /* FACGE */
             case 0x5f: /* FDIV */
+            case 0x7a: /* FABD */
             case 0x7c: /* FCMGT */
             case 0x7d: /* FACGT */
                 g_assert_not_reached();
@@ -9344,10 +9373,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x3f: /* FRSQRTS */
                 gen_helper_rsqrtsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x7a: /* FABD */
-                gen_helper_vfp_subs(tcg_res, tcg_op1, tcg_op2, fpst);
-                gen_vfp_abss(tcg_res, tcg_res);
-                break;
             default:
             case 0x18: /* FMAXNM */
             case 0x19: /* FMLA */
@@ -9363,6 +9388,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x5c: /* FCMGE */
             case 0x5d: /* FACGE */
             case 0x5f: /* FDIV */
+            case 0x7a: /* FABD */
             case 0x7c: /* FCMGT */
             case 0x7d: /* FACGT */
                 g_assert_not_reached();
@@ -9405,7 +9431,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         switch (fpopcode) {
         case 0x1f: /* FRECPS */
         case 0x3f: /* FRSQRTS */
-        case 0x7a: /* FABD */
             break;
         default:
         case 0x1b: /* FMULX */
@@ -9413,6 +9438,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         case 0x7d: /* FACGT */
         case 0x1c: /* FCMEQ */
         case 0x5c: /* FCMGE */
+        case 0x7a: /* FABD */
         case 0x7c: /* FCMGT */
             unallocated_encoding(s);
             return;
@@ -9568,13 +9594,13 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
     switch (fpopcode) {
     case 0x07: /* FRECPS */
     case 0x0f: /* FRSQRTS */
-    case 0x1a: /* FABD */
         break;
     default:
     case 0x03: /* FMULX */
     case 0x04: /* FCMEQ (reg) */
     case 0x14: /* FCMGE (reg) */
     case 0x15: /* FACGE */
+    case 0x1a: /* FABD */
     case 0x1c: /* FCMGT (reg) */
     case 0x1d: /* FACGT */
         unallocated_encoding(s);
@@ -9602,15 +9628,12 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
     case 0x0f: /* FRSQRTS */
         gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
-    case 0x1a: /* FABD */
-        gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
-        tcg_gen_andi_i32(tcg_res, tcg_res, 0x7fff);
-        break;
     default:
     case 0x03: /* FMULX */
     case 0x04: /* FCMEQ (reg) */
     case 0x14: /* FCMGE (reg) */
     case 0x15: /* FACGE */
+    case 0x1a: /* FABD */
     case 0x1c: /* FCMGT (reg) */
     case 0x1d: /* FACGT */
         g_assert_not_reached();
@@ -11272,7 +11295,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         return;
     case 0x1f: /* FRECPS */
     case 0x3f: /* FRSQRTS */
-    case 0x7a: /* FABD */
         if (!fp_access_check(s)) {
             return;
         }
@@ -11314,6 +11336,7 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x5c: /* FCMGE */
     case 0x5d: /* FACGE */
     case 0x5f: /* FDIV */
+    case 0x7a: /* FABD */
     case 0x7d: /* FACGT */
     case 0x7c: /* FCMGT */
         unallocated_encoding(s);
@@ -11659,7 +11682,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     switch (fpopcode) {
     case 0x7: /* FRECPS */
     case 0xf: /* FRSQRTS */
-    case 0x1a: /* FABD */
         pairwise = false;
         break;
     case 0x10: /* FMAXNMP */
@@ -11684,6 +11706,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     case 0x14: /* FCMGE */
     case 0x15: /* FACGE */
     case 0x17: /* FDIV */
+    case 0x1a: /* FABD */
     case 0x1c: /* FCMGT */
     case 0x1d: /* FACGT */
         unallocated_encoding(s);
@@ -11757,10 +11780,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             case 0xf: /* FRSQRTS */
                 gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x1a: /* FABD */
-                gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
-                tcg_gen_andi_i32(tcg_res, tcg_res, 0x7fff);
-                break;
             default:
             case 0x0: /* FMAXNM */
             case 0x1: /* FMLA */
@@ -11776,6 +11795,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             case 0x14: /* FCMGE */
             case 0x15: /* FACGE */
             case 0x17: /* FDIV */
+            case 0x1a: /* FABD */
             case 0x1c: /* FCMGT */
             case 0x1d: /* FACGT */
                 g_assert_not_reached();
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index dabefa3526..e9d7922f30 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1154,6 +1154,11 @@ static float32 float32_abd(float32 op1, float32 op2, float_status *stat)
     return float32_abs(float32_sub(op1, op2, stat));
 }
 
+static float64 float64_abd(float64 op1, float64 op2, float_status *stat)
+{
+    return float64_abs(float64_sub(op1, op2, stat));
+}
+
 /*
  * Reciprocal step. These are the AArch32 version which uses a
  * non-fused multiply-and-subtract.
@@ -1238,6 +1243,7 @@ DO_3OP(gvec_ftsmul_d, float64_ftsmul, float64)
 
 DO_3OP(gvec_fabd_h, float16_abd, float16)
 DO_3OP(gvec_fabd_s, float32_abd, float32)
+DO_3OP(gvec_fabd_d, float64_abd, float64)
 
 DO_3OP(gvec_fceq_h, float16_ceq, float16)
 DO_3OP(gvec_fceq_s, float32_ceq, float32)
-- 
2.34.1


