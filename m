Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC51C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3UG-0004Ka-7A; Tue, 28 May 2024 16:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Tm-0003Dc-T0
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:32 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TX-0003lf-HK
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso159744b3a.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928274; x=1717533074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rI0vNRx6g0aRdaDEGB4A56H1Rai6KzwvnYHUVbhgrUQ=;
 b=Jl5gfWIZFO8HedBUX7HElHEIUgZiyD2zmiELfFypaV3kIJeW8i0bMeQNVnit36rO4b
 czU+aAEb2Tk1k7Ygx/AQtOxMX1vqTaPVFJ0rDh2tXb/MGSUSmUn09X5r6kCuu1Jp66a9
 LRuwyufnFu/OjxmJ3zON9mhqbKRzVXK2gjkvuCHZ1eZ4kBE/9opkuU6j+6CLv1DLPCEp
 knNBDumpsnsaxU+7BlNxxr/Gmz9nXV1bD96h6oHDHG9F4Sb71UNDhwx+lgUMC5xTYHRs
 RAYbHo4O5iHAzYiCxa+x2Vr/I9szqHe5SLEeXOGPczkbXRVFFCbmG2iEqiGFwGeH3y9S
 nrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928274; x=1717533074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rI0vNRx6g0aRdaDEGB4A56H1Rai6KzwvnYHUVbhgrUQ=;
 b=TFT1XAwigwRHqCjlSXbUKqJrG6X578kJTg94Mawt+BP2Uzx66qdw7TtCTDy3/yUCk2
 OAlv1i0sMdFIbXCPhoe5Adg9Okl21F4cpE75w5G7gJDgK+U+LWQRrx21kGtLug6UxqaK
 LaWN2VjRVZlKZ/C8Q6MU95mdjInHAuuF/Clz2oeAuNKZPnmdV50fedHA5VVvMIjyqDtn
 7ZgdpKJ0lOBcyWECfuRqPduiWgNzEah6In4DlS7BaK/0CRSbjSUtOR+/ZULIpM9mpNFa
 ef6e7R+xNQLwBwbOtw857nZhXeDUhqsVSb2NNHRK+LyNWtpwcaPxCpIMoqyotDNFldaG
 16hw==
X-Gm-Message-State: AOJu0YxEM7zbqIP5UCNcnu2wn++VR+Vi7/f48yAuz6wdkBVZL6ujJfMj
 Fd43c7V8tjYj1M7N2fP55Yjxy3e7BQuYJJtQr9xGS/dj423E1yo1FykedPnQrJ1H61W7A4wMZEw
 i
X-Google-Smtp-Source: AGHT+IFa6RR9qhGgsXmMqcktVHA7QLyDd5ATHsNiXdK0qvAM08KEJ2tSyFrcQ7iyrKOBUE1zvjPkLQ==
X-Received: by 2002:a05:6a00:618e:b0:6fd:5e20:7db1 with SMTP id
 d2e1a72fcca58-70202f68b52mr179869b3a.17.1716928274097; 
 Tue, 28 May 2024 13:31:14 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 32/33] target/arm: Convert FMADD, FMSUB, FNMADD,
 FNMSUB to decodetree
Date: Tue, 28 May 2024 13:30:43 -0700
Message-Id: <20240528203044.612851-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

These are the only instructions in the 3 source scalar class.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  10 ++
 target/arm/tcg/translate-a64.c | 231 ++++++++++++---------------------
 2 files changed, 93 insertions(+), 148 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f7f897f9fc..6f6cd805b7 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -32,6 +32,7 @@
 &rr_e           rd rn esz
 &rrr_e          rd rn rm esz
 &rrx_e          rd rn rm idx esz
+&rrrr_e         rd rn rm ra esz
 &qrr_e          q rd rn esz
 &qrrr_e         q rd rn rm esz
 &qrrx_e         q rd rn rm idx esz
@@ -998,3 +999,12 @@ SQDMULH_vi      0.00 1111 10 . ..... 1100 . 0 ..... .....   @qrrx_s
 
 SQRDMULH_vi     0.00 1111 01 .. .... 1101 . 0 ..... .....   @qrrx_h
 SQRDMULH_vi     0.00 1111 10 . ..... 1101 . 0 ..... .....   @qrrx_s
+
+# Floating-point data-processing (3 source)
+
+@rrrr_hsd       .... .... .. . rm:5  . ra:5  rn:5  rd:5     &rrrr_e esz=%esz_hsd
+
+FMADD           0001 1111 .. 0 ..... 0 ..... ..... .....    @rrrr_hsd
+FMSUB           0001 1111 .. 0 ..... 1 ..... ..... .....    @rrrr_hsd
+FNMADD          0001 1111 .. 1 ..... 0 ..... ..... .....    @rrrr_hsd
+FNMSUB          0001 1111 .. 1 ..... 1 ..... ..... .....    @rrrr_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 14226c56cf..78a2e6d692 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5866,6 +5866,88 @@ static bool trans_ADDP_s(DisasContext *s, arg_rr_e *a)
     return true;
 }
 
+/*
+ * Floating-point data-processing (3 source)
+ */
+
+static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
+{
+    TCGv_ptr fpst;
+
+    /*
+     * These are fused multiply-add.  Note that doing the negations here
+     * as separate steps is correct: an input NaN should come out with
+     * its sign bit flipped if it is a negated-input.
+     */
+    switch (a->esz) {
+    case MO_64:
+        if (fp_access_check(s)) {
+            TCGv_i64 tn = read_fp_dreg(s, a->rn);
+            TCGv_i64 tm = read_fp_dreg(s, a->rm);
+            TCGv_i64 ta = read_fp_dreg(s, a->ra);
+
+            if (neg_a) {
+                gen_vfp_negd(ta, ta);
+            }
+            if (neg_n) {
+                gen_vfp_negd(tn, tn);
+            }
+            fpst = fpstatus_ptr(FPST_FPCR);
+            gen_helper_vfp_muladdd(ta, tn, tm, ta, fpst);
+            write_fp_dreg(s, a->rd, ta);
+        }
+        break;
+
+    case MO_32:
+        if (fp_access_check(s)) {
+            TCGv_i32 tn = read_fp_sreg(s, a->rn);
+            TCGv_i32 tm = read_fp_sreg(s, a->rm);
+            TCGv_i32 ta = read_fp_sreg(s, a->ra);
+
+            if (neg_a) {
+                gen_vfp_negs(ta, ta);
+            }
+            if (neg_n) {
+                gen_vfp_negs(tn, tn);
+            }
+            fpst = fpstatus_ptr(FPST_FPCR);
+            gen_helper_vfp_muladds(ta, tn, tm, ta, fpst);
+            write_fp_sreg(s, a->rd, ta);
+        }
+        break;
+
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        if (fp_access_check(s)) {
+            TCGv_i32 tn = read_fp_hreg(s, a->rn);
+            TCGv_i32 tm = read_fp_hreg(s, a->rm);
+            TCGv_i32 ta = read_fp_hreg(s, a->ra);
+
+            if (neg_a) {
+                gen_vfp_negh(ta, ta);
+            }
+            if (neg_n) {
+                gen_vfp_negh(tn, tn);
+            }
+            fpst = fpstatus_ptr(FPST_FPCR_F16);
+            gen_helper_advsimd_muladdh(ta, tn, tm, ta, fpst);
+            write_fp_sreg(s, a->rd, ta);
+        }
+        break;
+
+    default:
+        return false;
+    }
+    return true;
+}
+
+TRANS(FMADD, do_fmadd, a, false, false)
+TRANS(FNMADD, do_fmadd, a, true, true)
+TRANS(FMSUB, do_fmadd, a, false, true)
+TRANS(FNMSUB, do_fmadd, a, true, false)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -7665,152 +7747,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Floating-point data-processing (3 source) - single precision */
-static void handle_fp_3src_single(DisasContext *s, bool o0, bool o1,
-                                  int rd, int rn, int rm, int ra)
-{
-    TCGv_i32 tcg_op1, tcg_op2, tcg_op3;
-    TCGv_i32 tcg_res = tcg_temp_new_i32();
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-
-    tcg_op1 = read_fp_sreg(s, rn);
-    tcg_op2 = read_fp_sreg(s, rm);
-    tcg_op3 = read_fp_sreg(s, ra);
-
-    /* These are fused multiply-add, and must be done as one
-     * floating point operation with no rounding between the
-     * multiplication and addition steps.
-     * NB that doing the negations here as separate steps is
-     * correct : an input NaN should come out with its sign bit
-     * flipped if it is a negated-input.
-     */
-    if (o1 == true) {
-        gen_vfp_negs(tcg_op3, tcg_op3);
-    }
-
-    if (o0 != o1) {
-        gen_vfp_negs(tcg_op1, tcg_op1);
-    }
-
-    gen_helper_vfp_muladds(tcg_res, tcg_op1, tcg_op2, tcg_op3, fpst);
-
-    write_fp_sreg(s, rd, tcg_res);
-}
-
-/* Floating-point data-processing (3 source) - double precision */
-static void handle_fp_3src_double(DisasContext *s, bool o0, bool o1,
-                                  int rd, int rn, int rm, int ra)
-{
-    TCGv_i64 tcg_op1, tcg_op2, tcg_op3;
-    TCGv_i64 tcg_res = tcg_temp_new_i64();
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-
-    tcg_op1 = read_fp_dreg(s, rn);
-    tcg_op2 = read_fp_dreg(s, rm);
-    tcg_op3 = read_fp_dreg(s, ra);
-
-    /* These are fused multiply-add, and must be done as one
-     * floating point operation with no rounding between the
-     * multiplication and addition steps.
-     * NB that doing the negations here as separate steps is
-     * correct : an input NaN should come out with its sign bit
-     * flipped if it is a negated-input.
-     */
-    if (o1 == true) {
-        gen_vfp_negd(tcg_op3, tcg_op3);
-    }
-
-    if (o0 != o1) {
-        gen_vfp_negd(tcg_op1, tcg_op1);
-    }
-
-    gen_helper_vfp_muladdd(tcg_res, tcg_op1, tcg_op2, tcg_op3, fpst);
-
-    write_fp_dreg(s, rd, tcg_res);
-}
-
-/* Floating-point data-processing (3 source) - half precision */
-static void handle_fp_3src_half(DisasContext *s, bool o0, bool o1,
-                                int rd, int rn, int rm, int ra)
-{
-    TCGv_i32 tcg_op1, tcg_op2, tcg_op3;
-    TCGv_i32 tcg_res = tcg_temp_new_i32();
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_F16);
-
-    tcg_op1 = read_fp_hreg(s, rn);
-    tcg_op2 = read_fp_hreg(s, rm);
-    tcg_op3 = read_fp_hreg(s, ra);
-
-    /* These are fused multiply-add, and must be done as one
-     * floating point operation with no rounding between the
-     * multiplication and addition steps.
-     * NB that doing the negations here as separate steps is
-     * correct : an input NaN should come out with its sign bit
-     * flipped if it is a negated-input.
-     */
-    if (o1 == true) {
-        tcg_gen_xori_i32(tcg_op3, tcg_op3, 0x8000);
-    }
-
-    if (o0 != o1) {
-        tcg_gen_xori_i32(tcg_op1, tcg_op1, 0x8000);
-    }
-
-    gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_op3, fpst);
-
-    write_fp_sreg(s, rd, tcg_res);
-}
-
-/* Floating point data-processing (3 source)
- *   31  30  29 28       24 23  22  21  20  16  15  14  10 9    5 4    0
- * +---+---+---+-----------+------+----+------+----+------+------+------+
- * | M | 0 | S | 1 1 1 1 1 | type | o1 |  Rm  | o0 |  Ra  |  Rn  |  Rd  |
- * +---+---+---+-----------+------+----+------+----+------+------+------+
- */
-static void disas_fp_3src(DisasContext *s, uint32_t insn)
-{
-    int mos = extract32(insn, 29, 3);
-    int type = extract32(insn, 22, 2);
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int ra = extract32(insn, 10, 5);
-    int rm = extract32(insn, 16, 5);
-    bool o0 = extract32(insn, 15, 1);
-    bool o1 = extract32(insn, 21, 1);
-
-    if (mos) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (type) {
-    case 0:
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_3src_single(s, o0, o1, rd, rn, rm, ra);
-        break;
-    case 1:
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_3src_double(s, o0, o1, rd, rn, rm, ra);
-        break;
-    case 3:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_3src_half(s, o0, o1, rd, rn, rm, ra);
-        break;
-    default:
-        unallocated_encoding(s);
-    }
-}
-
 /* Floating point immediate
  *   31  30  29 28       24 23  22  21 20        13 12   10 9    5 4    0
  * +---+---+---+-----------+------+---+------------+-------+------+------+
@@ -8255,8 +8191,7 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
 static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
 {
     if (extract32(insn, 24, 1)) {
-        /* Floating point data-processing (3 source) */
-        disas_fp_3src(s, insn);
+        unallocated_encoding(s); /* in decodetree */
     } else if (extract32(insn, 21, 1) == 0) {
         /* Floating point to fixed point conversions */
         disas_fp_fixed_conv(s, insn);
-- 
2.34.1


