Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18439CDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwh-0005zN-A6; Thu, 19 Sep 2024 09:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwJ-0004dx-Ei
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwF-000119-Ri
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so10421455e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751474; x=1727356274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w2rs0shGHQnEBTFtKlv36VpzEDM06oVh8Dyeq3l3z3U=;
 b=Xr9BXzQCNE4qm4aI5YJCqXqEj4siGx6ei0OJD3ia6aKJTRDgQl9QYyqqcBCKTOUCXD
 Uf8bwJSU3TLs3iZrHbJG92sCZ+u8zMjAa21lX3HeSYzoQrEyPUZnyILVAgo4exVga22y
 451zExmd2dzyKgaw4mOddxy8wmF8wBmhd22HzA8yiJ5CIp1dMXnFMM4Tmi5HNXtFxCAl
 q5Miq82nngzIZItErgvcNFB7huIkjgu6ay39hDuXECuJW8LfvAca07wk70brheceOTcr
 drP0Ud7YpCBd3qn/jfDygpj0fL6pKW33mv4XuEGgHvWE9kcDF28fDgBDdc9VK543tx2s
 Jfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751474; x=1727356274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2rs0shGHQnEBTFtKlv36VpzEDM06oVh8Dyeq3l3z3U=;
 b=cU+w/STLtdLz40dWk4uKNs+I68O8cDQmrNHfv4Jw7W2/rd9uGyOJGmx0oD+SIqN+tD
 weNGQBDrhXzxQqIF1ASWhdIyaQRVIdCU9V7JuY/AFBr68ULfCnXjxlEVEd3f6qPfIVIA
 7czjkTCDFswgX0Aybu+JsWQ7ecxJm+Q+MLvZQO2b/Uqi+9EEWx1P520OPAP4xb/ByL6Y
 6ebb8fyccAh+HYYXwCnd1pzXpKeCZh7pKmejBvowHXtmCMHWPe58jdCSXfPsZh9qpVbF
 5amtai5SIPN7AFaGIuW/JgAB64igf79T5dQ3S/ymXGUx0xVXKVaNw61HcTl/ZO9qAj2N
 moCA==
X-Gm-Message-State: AOJu0YxxZURlX2yQ/e0DqxSdP9LmyGfsdbKyal/Bks6q0vLB/ttjZXRD
 96egxwAqZ0Qhg+o9bZrC4g1Rn/aL9JpIFrl+GNQbN7X5th29sDSGnOqwEqkDKosZlVBdhy6RwsE
 p
X-Google-Smtp-Source: AGHT+IGy+ol9COd3+laFE7P0XNrpDHP0ToB2ZQ1qewCrFhygPX7MSKtd5DqJrU+Ta3/mnSZg0hTfmg==
X-Received: by 2002:a05:600c:354a:b0:42c:c8be:4215 with SMTP id
 5b1f17b1804b1-42d9070b2eamr191049925e9.4.1726751474015; 
 Thu, 19 Sep 2024 06:11:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/38] target/arm: Convert FMAXNMV, FMINNMV, FMAXV,
 FMINV to decodetree
Date: Thu, 19 Sep 2024 14:10:39 +0100
Message-Id: <20240919131106.3362543-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  14 +++
 target/arm/tcg/translate-a64.c | 176 ++++++++++-----------------------
 2 files changed, 67 insertions(+), 123 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5ab4b117810..c77f9fc9870 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -54,11 +54,13 @@
 @rrx_d          ........ .. . rm:5  .... idx:1 . rn:5 rd:5  &rrx_e esz=3
 
 @rr_q1e0        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=0
+@rr_q1e2        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=2
 @r2r_q1e0       ........ ........ ...... rm:5 rd:5      &qrrr_e rn=%rd q=1 esz=0
 @rrr_q1e0       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=0
 @rrr_q1e3       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=3
 @rrrr_q1e3      ........ ... rm:5 . ra:5 rn:5 rd:5      &qrrrr_e q=1 esz=3
 
+@qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1166,3 +1168,15 @@ SMAXV           0.00 1110 .. 11000 01010 10 ..... .....     @qrr_e
 UMAXV           0.10 1110 .. 11000 01010 10 ..... .....     @qrr_e
 SMINV           0.00 1110 .. 11000 11010 10 ..... .....     @qrr_e
 UMINV           0.10 1110 .. 11000 11010 10 ..... .....     @qrr_e
+
+FMAXNMV_h       0.00 1110 00 11000 01100 10 ..... .....     @qrr_h
+FMAXNMV_s       0110 1110 00 11000 01100 10 ..... .....     @rr_q1e2
+
+FMINNMV_h       0.00 1110 10 11000 01100 10 ..... .....     @qrr_h
+FMINNMV_s       0110 1110 10 11000 01100 10 ..... .....     @rr_q1e2
+
+FMAXV_h         0.00 1110 00 11000 01111 10 ..... .....     @qrr_h
+FMAXV_s         0110 1110 00 11000 01111 10 ..... .....     @rr_q1e2
+
+FMINV_h         0.00 1110 10 11000 01111 10 ..... .....     @qrr_h
+FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 593a1774d88..aec2f6a542a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6835,6 +6835,59 @@ TRANS(UMAXV, do_int_reduction, a, false, 0, tcg_gen_umax_i64)
 TRANS(SMINV, do_int_reduction, a, false, MO_SIGN, tcg_gen_smin_i64)
 TRANS(UMINV, do_int_reduction, a, false, 0, tcg_gen_umin_i64)
 
+/*
+ * do_fp_reduction helper
+ *
+ * This mirrors the Reduce() pseudocode in the ARM ARM. It is
+ * important for correct NaN propagation that we do these
+ * operations in exactly the order specified by the pseudocode.
+ *
+ * This is a recursive function.
+ */
+static TCGv_i32 do_reduction_op(DisasContext *s, int rn, MemOp esz,
+                                int ebase, int ecount, TCGv_ptr fpst,
+                                NeonGenTwoSingleOpFn *fn)
+{
+    if (ecount == 1) {
+        TCGv_i32 tcg_elem = tcg_temp_new_i32();
+        read_vec_element_i32(s, tcg_elem, rn, ebase, esz);
+        return tcg_elem;
+    } else {
+        int half = ecount >> 1;
+        TCGv_i32 tcg_hi, tcg_lo, tcg_res;
+
+        tcg_hi = do_reduction_op(s, rn, esz, ebase + half, half, fpst, fn);
+        tcg_lo = do_reduction_op(s, rn, esz, ebase, half, fpst, fn);
+        tcg_res = tcg_temp_new_i32();
+
+        fn(tcg_res, tcg_lo, tcg_hi, fpst);
+        return tcg_res;
+    }
+}
+
+static bool do_fp_reduction(DisasContext *s, arg_qrr_e *a,
+                              NeonGenTwoSingleOpFn *fn)
+{
+    if (fp_access_check(s)) {
+        MemOp esz = a->esz;
+        int elts = (a->q ? 16 : 8) >> esz;
+        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+        TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst, fn);
+        write_fp_sreg(s, a->rd, res);
+    }
+    return true;
+}
+
+TRANS_FEAT(FMAXNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_maxnumh)
+TRANS_FEAT(FMINNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_minnumh)
+TRANS_FEAT(FMAXV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_maxh)
+TRANS_FEAT(FMINV_h, aa64_fp16, do_fp_reduction, a, gen_helper_advsimd_minh)
+
+TRANS(FMAXNMV_s, do_fp_reduction, a, gen_helper_vfp_maxnums)
+TRANS(FMINNMV_s, do_fp_reduction, a, gen_helper_vfp_minnums)
+TRANS(FMAXV_s, do_fp_reduction, a, gen_helper_vfp_maxs)
+TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9061,128 +9114,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
     }
 }
 
-/*
- * do_reduction_op helper
- *
- * This mirrors the Reduce() pseudocode in the ARM ARM. It is
- * important for correct NaN propagation that we do these
- * operations in exactly the order specified by the pseudocode.
- *
- * This is a recursive function.
- */
-static TCGv_i32 do_reduction_op(DisasContext *s, int fpopcode, int rn,
-                                MemOp esz, int ebase, int ecount, TCGv_ptr fpst)
-{
-    if (ecount == 1) {
-        TCGv_i32 tcg_elem = tcg_temp_new_i32();
-        read_vec_element_i32(s, tcg_elem, rn, ebase, esz);
-        return tcg_elem;
-    } else {
-        int half = ecount >> 1;
-        TCGv_i32 tcg_hi, tcg_lo, tcg_res;
-
-        tcg_hi = do_reduction_op(s, fpopcode, rn, esz,
-                                 ebase + half, half, fpst);
-        tcg_lo = do_reduction_op(s, fpopcode, rn, esz,
-                                 ebase, half, fpst);
-        tcg_res = tcg_temp_new_i32();
-
-        switch (fpopcode) {
-        case 0x0c: /* fmaxnmv half-precision */
-            gen_helper_advsimd_maxnumh(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x0f: /* fmaxv half-precision */
-            gen_helper_advsimd_maxh(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x1c: /* fminnmv half-precision */
-            gen_helper_advsimd_minnumh(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x1f: /* fminv half-precision */
-            gen_helper_advsimd_minh(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x2c: /* fmaxnmv */
-            gen_helper_vfp_maxnums(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x2f: /* fmaxv */
-            gen_helper_vfp_maxs(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x3c: /* fminnmv */
-            gen_helper_vfp_minnums(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        case 0x3f: /* fminv */
-            gen_helper_vfp_mins(tcg_res, tcg_lo, tcg_hi, fpst);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        return tcg_res;
-    }
-}
-
-/* AdvSIMD across lanes
- *   31  30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
- * +---+---+---+-----------+------+-----------+--------+-----+------+------+
- * | 0 | Q | U | 0 1 1 1 0 | size | 1 1 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+-----------+--------+-----+------+------+
- */
-static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 5);
-    bool is_q = extract32(insn, 30, 1);
-    bool is_u = extract32(insn, 29, 1);
-    bool is_min = false;
-    int elements;
-
-    switch (opcode) {
-    case 0xc: /* FMAXNMV, FMINNMV */
-    case 0xf: /* FMAXV, FMINV */
-        /* Bit 1 of size field encodes min vs max and the actual size
-         * depends on the encoding of the U bit. If not set (and FP16
-         * enabled) then we do half-precision float instead of single
-         * precision.
-         */
-        is_min = extract32(size, 1, 1);
-        if (!is_u && dc_isar_feature(aa64_fp16, s)) {
-            size = 1;
-        } else if (!is_u || !is_q || extract32(size, 0, 1)) {
-            unallocated_encoding(s);
-            return;
-        } else {
-            size = 2;
-        }
-        break;
-    default:
-    case 0x3: /* SADDLV, UADDLV */
-    case 0xa: /* SMAXV, UMAXV */
-    case 0x1a: /* SMINV, UMINV */
-    case 0x1b: /* ADDV */
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    elements = (is_q ? 16 : 8) >> size;
-
-    {
-        /* Floating point vector reduction ops which work across 32
-         * bit (single) or 16 bit (half-precision) intermediates.
-         * Note that correct NaN propagation requires that we do these
-         * operations in exactly the order specified by the pseudocode.
-         */
-        TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
-        int fpopcode = opcode | is_min << 4 | is_u << 5;
-        TCGv_i32 tcg_res = do_reduction_op(s, fpopcode, rn, size,
-                                           0, elements, fpst);
-        write_fp_sreg(s, rd, tcg_res);
-    }
-}
-
 /* AdvSIMD modified immediate
  *  31  30   29  28                 19 18 16 15   12  11  10  9     5 4    0
  * +---+---+----+---------------------+-----+-------+----+---+-------+------+
@@ -11735,7 +11666,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
-    { 0x0e300800, 0x9f3e0c00, disas_simd_across_lanes },
     /* simd_mod_imm decode is a subset of simd_shift_imm, so must precede it */
     { 0x0f000400, 0x9ff80400, disas_simd_mod_imm },
     { 0x0f000400, 0x9f800400, disas_simd_shift_imm },
-- 
2.34.1


