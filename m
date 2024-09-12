Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE51EE57FD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZmn-0006q5-Uf; Wed, 11 Sep 2024 22:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm6-0003Tc-LO
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:38 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm4-0004EO-S7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:38 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2057c6c57b5so2197325ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108895; x=1726713695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEdXGjZiuvLSMMB79GQjRx+E1UF3hWAu/88yWPAgnX4=;
 b=IU5HnVY8gz8O07fFiUUZNr2st0Vd2M4g3dxHUScCrMNyGN4I8pBDzBLdhAGZ7E7OWi
 nobRWetGpfVY+waC8J/4L5TnYuMw/bTHJdRz9mXiIzH7nmRjqQR8/7X2gqmWzQekdaEf
 kz0yQA/tBDX3EDjEssNVWxcgDNjj3oPE+0JDVXGlXhA5TcRsxB3TdweofjGYvR2mSFzE
 e8Igc7u5fJ4jZcdzGLFP3XPW+qoO6Nm/E8J2mKGd5qqSdfmrRjtclmSSMQM6fD3cDNEI
 oWmejr0sh1ot71DsQyKkj2u2Gm/xaCupblsfvNzHCtnQUaniZdZ/gnf3rjUNxATbUG4S
 Ky8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108895; x=1726713695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HEdXGjZiuvLSMMB79GQjRx+E1UF3hWAu/88yWPAgnX4=;
 b=lctswCjcHDuOpVbl8EtbQG8zS5g+ps4v6jl5RyzOkWWLN/AWEhgrnbuz0XzzLhvP81
 iozz50uf++4qBog0CHz8AsvLX8/j9K6TnhLFHLp2MkcUN6aicfgFQaenj70wyWlBBlHT
 SmgBXdBq2pqHz/Opya+NobLLVn8Ru3jb4t1BJG6gIuuvMGHuWPNYvbDlmU5NVEsMa3uO
 qH54NBOde2CNcXzPxbpMdfp/z5DkdtjDZTMVHk4TChGi/1IanXZvS+67mz6f6+rIcHUW
 w0AuAF1FMnWOW3xkjeFkZn+ssVi5OWZJn2MUmAl/b3KL2VmAAnJDOl5GC57ebOGlsu2w
 GDDA==
X-Gm-Message-State: AOJu0Ywmr8ORdplTrXirw3EIyfdaI90W38Ocnret1o/nTAd748kS5mjW
 hXGaw+svvO1XnJfUsoxWvQZ84SSoM6i5voZ/FCjVTEtlHDvgHORnhFkOuVfHROAz23B9TBMLmDG
 3
X-Google-Smtp-Source: AGHT+IFWlrqqFddOr+RL4QumS1C1E0vbTPZtHum1AV1JEMHXGYGtEsZcWxHmLTqKTKsFx2myi7SmoQ==
X-Received: by 2002:a17:902:f542:b0:206:9dfb:3e9e with SMTP id
 d9443c01a7336-2074c5eebbdmr88266375ad.10.1726108895355; 
 Wed, 11 Sep 2024 19:41:35 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 21/29] target/arm: Split out subroutines of
 handle_shri_with_rndacc
Date: Wed, 11 Sep 2024 19:41:06 -0700
Message-ID: <20240912024114.1097832-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

There isn't a lot of commonality along the different paths of
handle_shri_with_rndacc.  Split them out to separate functions,
which will be usable during the decodetree conversion.

Simplify 64-bit rounding operations to not require double-word arithmetic.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 138 ++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 56 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e59236330a..f4deacd554 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7019,6 +7019,78 @@ static bool do_vec_shift_imm_wide(DisasContext *s, arg_qrri_e *a, bool is_u)
 TRANS(SSHLL_v, do_vec_shift_imm_wide, a, false)
 TRANS(USHLL_v, do_vec_shift_imm_wide, a, true)
 
+static void gen_sshr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 64);
+    tcg_gen_sari_i64(dst, src, MIN(shift, 63));
+}
+
+static void gen_ushr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 64);
+    if (shift == 64) {
+        tcg_gen_movi_i64(dst, 0);
+    } else {
+        tcg_gen_shri_i64(dst, src, shift);
+    }
+}
+
+static void gen_srshr_bhs(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 32);
+    if (shift) {
+        TCGv_i64 rnd = tcg_constant_i64(1ull << (shift - 1));
+        tcg_gen_add_i64(dst, src, rnd);
+        tcg_gen_sari_i64(dst, dst, shift);
+    } else {
+        tcg_gen_mov_i64(dst, src);
+    }
+}
+
+static void gen_urshr_bhs(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 32);
+    if (shift) {
+        TCGv_i64 rnd = tcg_constant_i64(1ull << (shift - 1));
+        tcg_gen_add_i64(dst, src, rnd);
+        tcg_gen_shri_i64(dst, dst, shift);
+    } else {
+        tcg_gen_mov_i64(dst, src);
+    }
+}
+
+static void gen_srshr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 64);
+    if (shift == 0) {
+        tcg_gen_mov_i64(dst, src);
+    } else if (shift == 64) {
+        /* Extension of sign bit (0,-1) plus sign bit (0,1) is zero. */
+        tcg_gen_movi_i64(dst, 0);
+    } else {
+        TCGv_i64 rnd = tcg_temp_new_i64();
+        tcg_gen_extract_i64(rnd, src, shift - 1, 1);
+        tcg_gen_sari_i64(dst, src, shift);
+        tcg_gen_add_i64(dst, dst, rnd);
+    }
+}
+
+static void gen_urshr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    assert(shift >= 0 && shift <= 64);
+    if (shift == 0) {
+        tcg_gen_mov_i64(dst, src);
+    } else if (shift == 64) {
+        /* Rounding will propagate bit 63 into bit 64. */
+        tcg_gen_shri_i64(dst, src, 63);
+    } else {
+        TCGv_i64 rnd = tcg_temp_new_i64();
+        tcg_gen_extract_i64(rnd, src, shift - 1, 1);
+        tcg_gen_shri_i64(dst, src, shift);
+        tcg_gen_add_i64(dst, dst, rnd);
+    }
+}
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9208,69 +9280,23 @@ static void handle_shri_with_rndacc(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
                                     bool round, bool accumulate,
                                     bool is_u, int size, int shift)
 {
-    bool extended_result = false;
-    int ext_lshift = 0;
-    TCGv_i64 tcg_src_hi;
-
-    if (round && size == 3) {
-        extended_result = true;
-        ext_lshift = 64 - shift;
-        tcg_src_hi = tcg_temp_new_i64();
-    } else if (shift == 64) {
-        if (!accumulate && is_u) {
-            /* result is zero */
-            tcg_gen_movi_i64(tcg_res, 0);
-            return;
-        }
-    }
-
-    /* Deal with the rounding step */
-    if (round) {
-        TCGv_i64 tcg_rnd = tcg_constant_i64(1ull << (shift - 1));
-        if (extended_result) {
-            TCGv_i64 tcg_zero = tcg_constant_i64(0);
-            if (!is_u) {
-                /* take care of sign extending tcg_res */
-                tcg_gen_sari_i64(tcg_src_hi, tcg_src, 63);
-                tcg_gen_add2_i64(tcg_src, tcg_src_hi,
-                                 tcg_src, tcg_src_hi,
-                                 tcg_rnd, tcg_zero);
-            } else {
-                tcg_gen_add2_i64(tcg_src, tcg_src_hi,
-                                 tcg_src, tcg_zero,
-                                 tcg_rnd, tcg_zero);
-            }
+    if (!round) {
+        if (is_u) {
+            gen_ushr_d(tcg_src, tcg_src, shift);
         } else {
-            tcg_gen_add_i64(tcg_src, tcg_src, tcg_rnd);
+            gen_sshr_d(tcg_src, tcg_src, shift);
         }
-    }
-
-    /* Now do the shift right */
-    if (round && extended_result) {
-        /* extended case, >64 bit precision required */
-        if (ext_lshift == 0) {
-            /* special case, only high bits matter */
-            tcg_gen_mov_i64(tcg_src, tcg_src_hi);
+    } else if (size == MO_64) {
+        if (is_u) {
+            gen_urshr_d(tcg_src, tcg_src, shift);
         } else {
-            tcg_gen_shri_i64(tcg_src, tcg_src, shift);
-            tcg_gen_shli_i64(tcg_src_hi, tcg_src_hi, ext_lshift);
-            tcg_gen_or_i64(tcg_src, tcg_src, tcg_src_hi);
+            gen_srshr_d(tcg_src, tcg_src, shift);
         }
     } else {
         if (is_u) {
-            if (shift == 64) {
-                /* essentially shifting in 64 zeros */
-                tcg_gen_movi_i64(tcg_src, 0);
-            } else {
-                tcg_gen_shri_i64(tcg_src, tcg_src, shift);
-            }
+            gen_urshr_bhs(tcg_src, tcg_src, shift);
         } else {
-            if (shift == 64) {
-                /* effectively extending the sign-bit */
-                tcg_gen_sari_i64(tcg_src, tcg_src, 63);
-            } else {
-                tcg_gen_sari_i64(tcg_src, tcg_src, shift);
-            }
+            gen_srshr_bhs(tcg_src, tcg_src, shift);
         }
     }
 
-- 
2.43.0


