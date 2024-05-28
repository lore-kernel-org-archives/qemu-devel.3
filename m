Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72443C27C44
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxV1-0001iF-Ql; Tue, 28 May 2024 10:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUy-0001hE-DX
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUv-00076h-Q4
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42120fc8cbfso3301025e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905296; x=1717510096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZkmlHFSwMemNc/pbjcOY9sbB9XVxOQ2MJdXbYI8TzRA=;
 b=TohsECFa4CITS19Irf5Q1wvDLeXktKnrk11uzNvARI84oyMCNbabMmLh6Y/7U252H7
 UCDKAdJFrh3y2xyicUu1aT/Ujpa4/2ZfHKAME77kqzSMPGlTQ33AO5Kb37uWUiJMMiLr
 KliWHuZpgdltwF2yC9Ub21q2Lif3lvx5kUcaJxBBDZgeDBxgZ0R/hnG9oLDSvd2tdPWY
 YQ7nqTevRr1fMESUaYkcrNzTz0JeYLU2GzPtIKXlIvvJOYwXESEgDo1lUn5jqKCgtWOu
 Nmd8IvQWs0moqg87UJxLPBkV7l+9gWLEVZ/6FPxHXxdwp4Q5EH1qkUnCkkdFziLKNOwI
 BlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905296; x=1717510096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZkmlHFSwMemNc/pbjcOY9sbB9XVxOQ2MJdXbYI8TzRA=;
 b=hmiGQBif5QnToc3aEgmndHhpNpK6tYNHPm9r5k9M9lCtxfwf1pNvKRyEWYjc6SgoR8
 5p9CaDRDdyXUwj9AkImL+ow3OCYdlY8TAWwRHKTAdBQ1iwQ1S+Yo3J8oGhXMw4jOna5Y
 BjyZDIcIwNO7RUrPX8xFWCCM0jyMSVsY+lWcj0Nbk8A8vr2wujY9GMyMEV3XnNG6PjUH
 xy7kLY4D+YoerXPc0FRa9u17vjnU9gpQLbL7WjEbZ8wlxRR/uf+9zSy07sf8Uu3Ql8Yu
 T+8U3LrPXc+P2d4xXu3INdkKpF9b2IPaEiebMdRu2IfwQ9Fd5PXyPIZl9KztBqIqLVgh
 QNTQ==
X-Gm-Message-State: AOJu0YxwOIxm2zlBYU9RGwmvnOdyMXxkTpsLk1zN+mP5HSPGI6K17FAk
 PO63ZNqMkkmkc4KkIrloIj2hOZOIJQWhAc+Ko4EaWC9Ym1d5ll75zhLTHCb7kcDSunb9eYEx8C/
 g
X-Google-Smtp-Source: AGHT+IE9bKBPcYO7JTKbCnHWbH92ELv2o1YPSj8E8tNhqd7kQKN/z/YkSCdunCBfQp5jB5k8UbSU9g==
X-Received: by 2002:adf:ce06:0:b0:34d:96ca:8c24 with SMTP id
 ffacd0b85a97d-35526c6d60emr8442316f8f.37.1716905296093; 
 Tue, 28 May 2024 07:08:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/42] target/arm: Convert FRECPS, FRSQRTS to decodetree
Date: Tue, 28 May 2024 15:07:44 +0100
Message-Id: <20240528140753.3620597-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These are the last instructions within handle_3same_float
and disas_simd_scalar_three_reg_same_fp16 so remove them.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240524232121.284515-28-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  12 ++
 target/arm/tcg/translate-a64.c | 293 ++++-----------------------------
 2 files changed, 46 insertions(+), 259 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a852b5f06f0..84cb38f1dd0 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -731,6 +731,12 @@ FACGT_s         0111 1110 1.1 ..... 11101 1 ..... ..... @rrr_sd
 FABD_s          0111 1110 110 ..... 00010 1 ..... ..... @rrr_h
 FABD_s          0111 1110 1.1 ..... 11010 1 ..... ..... @rrr_sd
 
+FRECPS_s        0101 1110 010 ..... 00111 1 ..... ..... @rrr_h
+FRECPS_s        0101 1110 0.1 ..... 11111 1 ..... ..... @rrr_sd
+
+FRSQRTS_s       0101 1110 110 ..... 00111 1 ..... ..... @rrr_h
+FRSQRTS_s       0101 1110 1.1 ..... 11111 1 ..... ..... @rrr_sd
+
 ### Advanced SIMD three same
 
 FADD_v          0.00 1110 010 ..... 00010 1 ..... ..... @qrrr_h
@@ -784,6 +790,12 @@ FACGT_v         0.10 1110 1.1 ..... 11101 1 ..... ..... @qrrr_sd
 FABD_v          0.10 1110 110 ..... 00010 1 ..... ..... @qrrr_h
 FABD_v          0.10 1110 1.1 ..... 11010 1 ..... ..... @qrrr_sd
 
+FRECPS_v        0.00 1110 010 ..... 00111 1 ..... ..... @qrrr_h
+FRECPS_v        0.00 1110 0.1 ..... 11111 1 ..... ..... @qrrr_sd
+
+FRSQRTS_v       0.00 1110 110 ..... 00111 1 ..... ..... @qrrr_h
+FRSQRTS_v       0.00 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 633384d2a56..a7537a5104f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5035,6 +5035,20 @@ static const FPScalar f_scalar_fabd = {
 };
 TRANS(FABD_s, do_fp3_scalar, a, &f_scalar_fabd)
 
+static const FPScalar f_scalar_frecps = {
+    gen_helper_recpsf_f16,
+    gen_helper_recpsf_f32,
+    gen_helper_recpsf_f64,
+};
+TRANS(FRECPS_s, do_fp3_scalar, a, &f_scalar_frecps)
+
+static const FPScalar f_scalar_frsqrts = {
+    gen_helper_rsqrtsf_f16,
+    gen_helper_rsqrtsf_f32,
+    gen_helper_rsqrtsf_f64,
+};
+TRANS(FRSQRTS_s, do_fp3_scalar, a, &f_scalar_frsqrts)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5182,6 +5196,20 @@ static gen_helper_gvec_3_ptr * const f_vector_fabd[3] = {
 };
 TRANS(FABD_v, do_fp3_vector, a, f_vector_fabd)
 
+static gen_helper_gvec_3_ptr * const f_vector_frecps[3] = {
+    gen_helper_gvec_recps_h,
+    gen_helper_gvec_recps_s,
+    gen_helper_gvec_recps_d,
+};
+TRANS(FRECPS_v, do_fp3_vector, a, f_vector_frecps)
+
+static gen_helper_gvec_3_ptr * const f_vector_frsqrts[3] = {
+    gen_helper_gvec_rsqrts_h,
+    gen_helper_gvec_rsqrts_s,
+    gen_helper_gvec_rsqrts_d,
+};
+TRANS(FRSQRTS_v, do_fp3_vector, a, f_vector_frsqrts)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -9308,107 +9336,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     }
 }
 
-/* Handle the 3-same-operands float operations; shared by the scalar
- * and vector encodings. The caller must filter out any encodings
- * not allocated for the encoding it is dealing with.
- */
-static void handle_3same_float(DisasContext *s, int size, int elements,
-                               int fpopcode, int rd, int rn, int rm)
-{
-    int pass;
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-
-    for (pass = 0; pass < elements; pass++) {
-        if (size) {
-            /* Double */
-            TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-            TCGv_i64 tcg_op2 = tcg_temp_new_i64();
-            TCGv_i64 tcg_res = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_op1, rn, pass, MO_64);
-            read_vec_element(s, tcg_op2, rm, pass, MO_64);
-
-            switch (fpopcode) {
-            case 0x1f: /* FRECPS */
-                gen_helper_recpsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x3f: /* FRSQRTS */
-                gen_helper_rsqrtsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            default:
-            case 0x18: /* FMAXNM */
-            case 0x19: /* FMLA */
-            case 0x1a: /* FADD */
-            case 0x1b: /* FMULX */
-            case 0x1c: /* FCMEQ */
-            case 0x1e: /* FMAX */
-            case 0x38: /* FMINNM */
-            case 0x39: /* FMLS */
-            case 0x3a: /* FSUB */
-            case 0x3e: /* FMIN */
-            case 0x5b: /* FMUL */
-            case 0x5c: /* FCMGE */
-            case 0x5d: /* FACGE */
-            case 0x5f: /* FDIV */
-            case 0x7a: /* FABD */
-            case 0x7c: /* FCMGT */
-            case 0x7d: /* FACGT */
-                g_assert_not_reached();
-            }
-
-            write_vec_element(s, tcg_res, rd, pass, MO_64);
-        } else {
-            /* Single */
-            TCGv_i32 tcg_op1 = tcg_temp_new_i32();
-            TCGv_i32 tcg_op2 = tcg_temp_new_i32();
-            TCGv_i32 tcg_res = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_op1, rn, pass, MO_32);
-            read_vec_element_i32(s, tcg_op2, rm, pass, MO_32);
-
-            switch (fpopcode) {
-            case 0x1f: /* FRECPS */
-                gen_helper_recpsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x3f: /* FRSQRTS */
-                gen_helper_rsqrtsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            default:
-            case 0x18: /* FMAXNM */
-            case 0x19: /* FMLA */
-            case 0x1a: /* FADD */
-            case 0x1b: /* FMULX */
-            case 0x1c: /* FCMEQ */
-            case 0x1e: /* FMAX */
-            case 0x38: /* FMINNM */
-            case 0x39: /* FMLS */
-            case 0x3a: /* FSUB */
-            case 0x3e: /* FMIN */
-            case 0x5b: /* FMUL */
-            case 0x5c: /* FCMGE */
-            case 0x5d: /* FACGE */
-            case 0x5f: /* FDIV */
-            case 0x7a: /* FABD */
-            case 0x7c: /* FCMGT */
-            case 0x7d: /* FACGT */
-                g_assert_not_reached();
-            }
-
-            if (elements == 1) {
-                /* scalar single so clear high part */
-                TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-
-                tcg_gen_extu_i32_i64(tcg_tmp, tcg_res);
-                write_vec_element(s, tcg_tmp, rd, pass, MO_64);
-            } else {
-                write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-            }
-        }
-    }
-
-    clear_vec_high(s, elements * (size ? 8 : 4) > 8, rd);
-}
-
 /* AdvSIMD scalar three same
  *  31 30  29 28       24 23  22  21 20  16 15    11  10 9    5 4    0
  * +-----+---+-----------+------+---+------+--------+---+------+------+
@@ -9425,33 +9352,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     bool u = extract32(insn, 29, 1);
     TCGv_i64 tcg_rd;
 
-    if (opcode >= 0x18) {
-        /* Floating point: U, size[1] and opcode indicate operation */
-        int fpopcode = opcode | (extract32(size, 1, 1) << 5) | (u << 6);
-        switch (fpopcode) {
-        case 0x1f: /* FRECPS */
-        case 0x3f: /* FRSQRTS */
-            break;
-        default:
-        case 0x1b: /* FMULX */
-        case 0x5d: /* FACGE */
-        case 0x7d: /* FACGT */
-        case 0x1c: /* FCMEQ */
-        case 0x5c: /* FCMGE */
-        case 0x7a: /* FABD */
-        case 0x7c: /* FCMGT */
-            unallocated_encoding(s);
-            return;
-        }
-
-        if (!fp_access_check(s)) {
-            return;
-        }
-
-        handle_3same_float(s, extract32(size, 0, 1), 1, fpopcode, rd, rn, rm);
-        return;
-    }
-
     switch (opcode) {
     case 0x1: /* SQADD, UQADD */
     case 0x5: /* SQSUB, UQSUB */
@@ -9568,80 +9468,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     write_fp_dreg(s, rd, tcg_rd);
 }
 
-/* AdvSIMD scalar three same FP16
- *  31 30  29 28       24 23  22 21 20  16 15 14 13    11 10  9  5 4  0
- * +-----+---+-----------+---+-----+------+-----+--------+---+----+----+
- * | 0 1 | U | 1 1 1 1 0 | a | 1 0 |  Rm  | 0 0 | opcode | 1 | Rn | Rd |
- * +-----+---+-----------+---+-----+------+-----+--------+---+----+----+
- * v: 0101 1110 0100 0000 0000 0100 0000 0000 => 5e400400
- * m: 1101 1111 0110 0000 1100 0100 0000 0000 => df60c400
- */
-static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
-                                                  uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int opcode = extract32(insn, 11, 3);
-    int rm = extract32(insn, 16, 5);
-    bool u = extract32(insn, 29, 1);
-    bool a = extract32(insn, 23, 1);
-    int fpopcode = opcode | (a << 3) |  (u << 4);
-    TCGv_ptr fpst;
-    TCGv_i32 tcg_op1;
-    TCGv_i32 tcg_op2;
-    TCGv_i32 tcg_res;
-
-    switch (fpopcode) {
-    case 0x07: /* FRECPS */
-    case 0x0f: /* FRSQRTS */
-        break;
-    default:
-    case 0x03: /* FMULX */
-    case 0x04: /* FCMEQ (reg) */
-    case 0x14: /* FCMGE (reg) */
-    case 0x15: /* FACGE */
-    case 0x1a: /* FABD */
-    case 0x1c: /* FCMGT (reg) */
-    case 0x1d: /* FACGT */
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!dc_isar_feature(aa64_fp16, s)) {
-        unallocated_encoding(s);
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
-
-    tcg_op1 = read_fp_hreg(s, rn);
-    tcg_op2 = read_fp_hreg(s, rm);
-    tcg_res = tcg_temp_new_i32();
-
-    switch (fpopcode) {
-    case 0x07: /* FRECPS */
-        gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x0f: /* FRSQRTS */
-        gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    default:
-    case 0x03: /* FMULX */
-    case 0x04: /* FCMEQ (reg) */
-    case 0x14: /* FCMGE (reg) */
-    case 0x15: /* FACGE */
-    case 0x1a: /* FABD */
-    case 0x1c: /* FCMGT (reg) */
-    case 0x1d: /* FACGT */
-        g_assert_not_reached();
-    }
-
-    write_fp_sreg(s, rd, tcg_res);
-}
-
 /* AdvSIMD scalar three same extra
  *  31 30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
  * +-----+---+-----------+------+---+------+---+--------+---+----+----+
@@ -11114,7 +10940,7 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
 
 /* Pairwise op subgroup of C3.6.16.
  *
- * This is called directly or via the handle_3same_float for float pairwise
+ * This is called directly for float pairwise
  * operations where the opcode and size are calculated differently.
  */
 static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
@@ -11271,10 +11097,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
 
-    int datasize = is_q ? 128 : 64;
-    int esize = 32 << size;
-    int elements = datasize / esize;
-
     if (size == 1 && !is_q) {
         unallocated_encoding(s);
         return;
@@ -11293,13 +11115,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         handle_simd_3same_pair(s, is_q, 0, fpopcode, size ? MO_64 : MO_32,
                                rn, rm, rd);
         return;
-    case 0x1f: /* FRECPS */
-    case 0x3f: /* FRSQRTS */
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_3same_float(s, size, elements, fpopcode, rd, rn, rm);
-        return;
 
     case 0x1d: /* FMLAL  */
     case 0x3d: /* FMLSL  */
@@ -11328,10 +11143,12 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x1b: /* FMULX */
     case 0x1c: /* FCMEQ */
     case 0x1e: /* FMAX */
+    case 0x1f: /* FRECPS */
     case 0x38: /* FMINNM */
     case 0x39: /* FMLS */
     case 0x3a: /* FSUB */
     case 0x3e: /* FMIN */
+    case 0x3f: /* FRSQRTS */
     case 0x5b: /* FMUL */
     case 0x5c: /* FCMGE */
     case 0x5d: /* FACGE */
@@ -11673,17 +11490,11 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
      * together indicate the operation.
      */
     int fpopcode = opcode | (a << 3) | (u << 4);
-    int datasize = is_q ? 128 : 64;
-    int elements = datasize / 16;
     bool pairwise;
     TCGv_ptr fpst;
     int pass;
 
     switch (fpopcode) {
-    case 0x7: /* FRECPS */
-    case 0xf: /* FRSQRTS */
-        pairwise = false;
-        break;
     case 0x10: /* FMAXNMP */
     case 0x12: /* FADDP */
     case 0x16: /* FMAXP */
@@ -11698,10 +11509,12 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     case 0x3: /* FMULX */
     case 0x4: /* FCMEQ */
     case 0x6: /* FMAX */
+    case 0x7: /* FRECPS */
     case 0x8: /* FMINNM */
     case 0x9: /* FMLS */
     case 0xa: /* FSUB */
     case 0xe: /* FMIN */
+    case 0xf: /* FRSQRTS */
     case 0x13: /* FMUL */
     case 0x14: /* FCMGE */
     case 0x15: /* FACGE */
@@ -11765,44 +11578,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_16);
         }
     } else {
-        for (pass = 0; pass < elements; pass++) {
-            TCGv_i32 tcg_op1 = tcg_temp_new_i32();
-            TCGv_i32 tcg_op2 = tcg_temp_new_i32();
-            TCGv_i32 tcg_res = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_op1, rn, pass, MO_16);
-            read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
-
-            switch (fpopcode) {
-            case 0x7: /* FRECPS */
-                gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0xf: /* FRSQRTS */
-                gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            default:
-            case 0x0: /* FMAXNM */
-            case 0x1: /* FMLA */
-            case 0x2: /* FADD */
-            case 0x3: /* FMULX */
-            case 0x4: /* FCMEQ */
-            case 0x6: /* FMAX */
-            case 0x8: /* FMINNM */
-            case 0x9: /* FMLS */
-            case 0xa: /* FSUB */
-            case 0xe: /* FMIN */
-            case 0x13: /* FMUL */
-            case 0x14: /* FCMGE */
-            case 0x15: /* FACGE */
-            case 0x17: /* FDIV */
-            case 0x1a: /* FABD */
-            case 0x1c: /* FCMGT */
-            case 0x1d: /* FACGT */
-                g_assert_not_reached();
-            }
-
-            write_vec_element_i32(s, tcg_res, rd, pass, MO_16);
-        }
+        g_assert_not_reached();
     }
 
     clear_vec_high(s, is_q, rd);
@@ -13572,7 +13348,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
-    { 0x5e400400, 0xdf60c400, disas_simd_scalar_three_reg_same_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.34.1


