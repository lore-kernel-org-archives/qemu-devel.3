Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCF8C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmJ-0007gO-P8; Sun, 05 May 2024 21:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmE-0007db-6Q
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:23 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm6-0002RF-DG
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:20 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2b43490e0e2so904084a91.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957453; x=1715562253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6D0SRchv3a1Prka3ln0rrLCEhuQFl+5IV3va21qAuQ=;
 b=jUsUAMeGAT5AY72zqXWiUf9j1HlRUdPF/5geEV2ZYXYUZSVHrc8LoJxBY0wqvFvbIm
 8mseKt40Dbm1+j+Fmwf5ae6NK9JH3LeL+nxQ0tqXbvbCWc2Tdqa5wqDGJdejl3yyYc0B
 8rjF0whaEkrCME/uFMDjWNQkNxUvq8u5o82Ly2rYhzfwOl8TCslxpFcWnKtZABNTcS1W
 5vIwRuZXFV6/yZsjZpHzMduioQQ0EVIUZCEFKP8M9WBaHbEQCaxBksZxZcrvK7hd9H/F
 YSY9rWh3Tkl4RTN/Qe1uubqrmVDRY0udG0W+CyU/q4zHOwtG+gWgAPcr9oMGwN+qqTHu
 55DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957453; x=1715562253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6D0SRchv3a1Prka3ln0rrLCEhuQFl+5IV3va21qAuQ=;
 b=o4uKG9+7f4ZBCm7JF/de3qA1Grp+J8ZBIEiPLxIsZ/8exPLPEnPGv8bifb1TB7cpe9
 lUoeTgoT+R5vV9zJ+8npfiH5Y20mUFMTwcI6OLm0dlJUbGV9DHuO/BoZMIizeahP490E
 QWiNI+Q1U4hV+lzFlZ5kD8g6YrFVU55gfhtLwjit3D20zsqKom6SIOm3jKa4EnPzfO6D
 XeefCOphOQ1yyoS9FZsC9T9C5D8lcKmXjrFuNjb8NwLANZkHJK5k+LRNnV0C7XntuioL
 G3xsijMElqO6TVQUjLKuPA09YolKaH9SdNWMud/1UceWPrVcuWyNW6woC14tYqhtybk4
 4l5g==
X-Gm-Message-State: AOJu0Yx3GBMjDmlb6UgEmk6LvZ94fDn3Sn5SJOFKL7f5q2bg4CP1GeHK
 4C6teYZ0uZoAddTXlq0Q5EPGdja2sh9gxSbZSHtdxEpjKIsHXwLu14cXOuwQk67uZQIV1anzRJ/
 d
X-Google-Smtp-Source: AGHT+IHHEcGvTlMp+hqc0U7HFbjbJUKQXHr330dVqqB10q1trQy/85QmwkZWrOhG6Agn3IGHZLhbLw==
X-Received: by 2002:a17:90a:1fc2:b0:2a2:1900:493 with SMTP id
 z2-20020a17090a1fc200b002a219000493mr6619892pjz.40.1714957452799; 
 Sun, 05 May 2024 18:04:12 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/57] target/arm: Convert Cryptographic 4-register to
 decodetree
Date: Sun,  5 May 2024 18:03:14 -0700
Message-Id: <20240506010403.6204-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/a64.decode      |   8 ++
 target/arm/tcg/translate-a64.c | 132 +++++++++++----------------------
 2 files changed, 51 insertions(+), 89 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5a46205751..ef6902e86a 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -27,11 +27,13 @@
 &i              imm
 &qrr_e          q rd rn esz
 &qrrr_e         q rd rn rm esz
+&qrrrr_e        q rd rn rm ra esz
 
 @rr_q1e0        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=0
 @r2r_q1e0       ........ ........ ...... rm:5 rd:5      &qrrr_e rn=%rd q=1 esz=0
 @rrr_q1e0       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=0
 @rrr_q1e3       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=3
+@rrrr_q1e3      ........ ... rm:5 . ra:5 rn:5 rd:5      &qrrrr_e q=1 esz=3
 
 ### Data Processing - Immediate
 
@@ -636,3 +638,9 @@ SM4EKEY         1100 1110 011 ..... 110010 ..... .....  @rrr_q1e0
 
 SHA512SU0       1100 1110 110 00000 100000 ..... .....  @rr_q1e0
 SM4E            1100 1110 110 00000 100001 ..... .....  @r2r_q1e0
+
+### Cryptographic four-register
+
+EOR3            1100 1110 000 ..... 0 ..... ..... ..... @rrrr_q1e3
+BCAX            1100 1110 001 ..... 0 ..... ..... ..... @rrrr_q1e3
+SM3SS1          1100 1110 010 ..... 0 ..... ..... ..... @rrrr_q1e3
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1bfee2583a..a20da75423 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1353,6 +1353,17 @@ static bool do_gvec_fn3(DisasContext *s, arg_qrrr_e *a, GVecGen3Fn *fn)
     return true;
 }
 
+static bool do_gvec_fn4(DisasContext *s, arg_qrrrr_e *a, GVecGen4Fn *fn)
+{
+    if (!a->q && a->esz == MO_64) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_fn4(s, a->q, a->rd, a->rn, a->rm, a->ra, fn, a->esz);
+    }
+    return true;
+}
+
 /*
  * This utility function is for doing register extension with an
  * optional shift. You will likely want to pass a temporary for the
@@ -4633,6 +4644,38 @@ TRANS_FEAT(SM4EKEY, aa64_sm4, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm4ekey)
 TRANS_FEAT(SHA512SU0, aa64_sha512, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha512su0)
 TRANS_FEAT(SM4E, aa64_sm4, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm4e)
 
+TRANS_FEAT(EOR3, aa64_sha3, do_gvec_fn4, a, gen_gvec_eor3)
+TRANS_FEAT(BCAX, aa64_sha3, do_gvec_fn4, a, gen_gvec_bcax)
+
+static bool trans_SM3SS1(DisasContext *s, arg_SM3SS1 *a)
+{
+    if (!dc_isar_feature(aa64_sm3, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        TCGv_i32 tcg_op1 = tcg_temp_new_i32();
+        TCGv_i32 tcg_op2 = tcg_temp_new_i32();
+        TCGv_i32 tcg_op3 = tcg_temp_new_i32();
+        TCGv_i32 tcg_res = tcg_temp_new_i32();
+        unsigned vsz, dofs;
+
+        read_vec_element_i32(s, tcg_op1, a->rn, 3, MO_32);
+        read_vec_element_i32(s, tcg_op2, a->rm, 3, MO_32);
+        read_vec_element_i32(s, tcg_op3, a->ra, 3, MO_32);
+
+        tcg_gen_rotri_i32(tcg_res, tcg_op1, 20);
+        tcg_gen_add_i32(tcg_res, tcg_res, tcg_op2);
+        tcg_gen_add_i32(tcg_res, tcg_res, tcg_op3);
+        tcg_gen_rotri_i32(tcg_res, tcg_res, 25);
+
+        /* Clear the whole register first, then store bits [127:96]. */
+        vsz = vec_full_reg_size(s);
+        dofs = vec_full_reg_offset(s, a->rd);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, vsz, vsz, 0);
+        write_vec_element_i32(s, tcg_res, a->rd, 3, MO_32);
+    }
+    return true;
+}
 
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
@@ -13527,94 +13570,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto four-register
- *  31               23 22 21 20  16 15  14  10 9    5 4    0
- * +-------------------+-----+------+---+------+------+------+
- * | 1 1 0 0 1 1 1 0 0 | Op0 |  Rm  | 0 |  Ra  |  Rn  |  Rd  |
- * +-------------------+-----+------+---+------+------+------+
- */
-static void disas_crypto_four_reg(DisasContext *s, uint32_t insn)
-{
-    int op0 = extract32(insn, 21, 2);
-    int rm = extract32(insn, 16, 5);
-    int ra = extract32(insn, 10, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    bool feature;
-
-    switch (op0) {
-    case 0: /* EOR3 */
-    case 1: /* BCAX */
-        feature = dc_isar_feature(aa64_sha3, s);
-        break;
-    case 2: /* SM3SS1 */
-        feature = dc_isar_feature(aa64_sm3, s);
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!feature) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (op0 < 2) {
-        TCGv_i64 tcg_op1, tcg_op2, tcg_op3, tcg_res[2];
-        int pass;
-
-        tcg_op1 = tcg_temp_new_i64();
-        tcg_op2 = tcg_temp_new_i64();
-        tcg_op3 = tcg_temp_new_i64();
-        tcg_res[0] = tcg_temp_new_i64();
-        tcg_res[1] = tcg_temp_new_i64();
-
-        for (pass = 0; pass < 2; pass++) {
-            read_vec_element(s, tcg_op1, rn, pass, MO_64);
-            read_vec_element(s, tcg_op2, rm, pass, MO_64);
-            read_vec_element(s, tcg_op3, ra, pass, MO_64);
-
-            if (op0 == 0) {
-                /* EOR3 */
-                tcg_gen_xor_i64(tcg_res[pass], tcg_op2, tcg_op3);
-            } else {
-                /* BCAX */
-                tcg_gen_andc_i64(tcg_res[pass], tcg_op2, tcg_op3);
-            }
-            tcg_gen_xor_i64(tcg_res[pass], tcg_res[pass], tcg_op1);
-        }
-        write_vec_element(s, tcg_res[0], rd, 0, MO_64);
-        write_vec_element(s, tcg_res[1], rd, 1, MO_64);
-    } else {
-        TCGv_i32 tcg_op1, tcg_op2, tcg_op3, tcg_res, tcg_zero;
-
-        tcg_op1 = tcg_temp_new_i32();
-        tcg_op2 = tcg_temp_new_i32();
-        tcg_op3 = tcg_temp_new_i32();
-        tcg_res = tcg_temp_new_i32();
-        tcg_zero = tcg_constant_i32(0);
-
-        read_vec_element_i32(s, tcg_op1, rn, 3, MO_32);
-        read_vec_element_i32(s, tcg_op2, rm, 3, MO_32);
-        read_vec_element_i32(s, tcg_op3, ra, 3, MO_32);
-
-        tcg_gen_rotri_i32(tcg_res, tcg_op1, 20);
-        tcg_gen_add_i32(tcg_res, tcg_res, tcg_op2);
-        tcg_gen_add_i32(tcg_res, tcg_res, tcg_op3);
-        tcg_gen_rotri_i32(tcg_res, tcg_res, 25);
-
-        write_vec_element_i32(s, tcg_zero, rd, 0, MO_32);
-        write_vec_element_i32(s, tcg_zero, rd, 1, MO_32);
-        write_vec_element_i32(s, tcg_zero, rd, 2, MO_32);
-        write_vec_element_i32(s, tcg_res, rd, 3, MO_32);
-    }
-}
-
 /* Crypto XAR
  *  31                   21 20  16 15    10 9    5 4    0
  * +-----------------------+------+--------+------+------+
@@ -13701,7 +13656,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0xce000000, 0xff808000, disas_crypto_four_reg },
     { 0xce800000, 0xffe00000, disas_crypto_xar },
     { 0xce408000, 0xffe0c000, disas_crypto_three_reg_imm2 },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
-- 
2.34.1


