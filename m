Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF42C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7u-0003yZ-8u; Tue, 11 Feb 2025 11:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht63-0006me-PK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht60-0003TQ-Kj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:51 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dc6d55ebaso2898408f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291206; x=1739896006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oWHlihOIdQ6CYG5rSBr2TwbytpUFZOd7E5qydFIL3W0=;
 b=Jm5yw5ADVZaBQm+tezWhc+oWb7tQXeAHgXS7GkpPZUT/wa2SAau9RDkhBzqCWUFu4+
 ykIAtxkASP5qp/47Mt2XxHd+6o1aUTzg0kppyyE4LWFloZh0VT1DVahnWl/EMdF6rUM8
 YpjqT3sIwQ1+HEYadXx20R5jqdBmMJizwqB2QN2jzndd+7ViD6Xa7C7Wgr3vaNrDSNWO
 L7C+fX9hME3Aa59lykWd1d/wKavpQS6SGF3QEnAzpm+34vz4mG7hG4EfntQ4t2BtEmea
 IGeEzcUWBddE9J0aTFVwO7zjI6qWvnsE0w5DdvOkXxM7rusWJ3OVRA0QiMNtcTY83e7g
 serg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291206; x=1739896006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWHlihOIdQ6CYG5rSBr2TwbytpUFZOd7E5qydFIL3W0=;
 b=wWDGJtKaUWt+QZrSCOsgPc4xYUFHP1nQpRa9Bepe7ymM83FCe+fe15f1VFhB1mtvTx
 73W5gJ+c+wocuBd9RcGAMNr/rHZin5onyCPDtSC8gaVVJmLxq94d+LzhJ7fgZo+o5v6b
 /V2ibSCjQK7QlJ2+ylYK24DGYNduiqMXbeH3SeFe3Trw/qqGbz2R0QHWdMqWSS7UdJSy
 VDsTCjHsc9+jJDgxm5cjodBgnqhzMuBP/DicvDhW98CBFXmDk6YoHrXfXe9GsnIDeyEY
 WSuS/0y8OouadUU9LJxMqLTj9S6ub41hMG/3OApsvg5oDBPjtXBxzJySBqC36hLtvNKu
 TJWw==
X-Gm-Message-State: AOJu0Ywq6tQJqE+hiEMV6+YyYJbZ5qxTK3SKvWIo79IFeAcFhQ63LKyV
 VNN5kCKZFs3CIZxKNO7FfLNMt7tL4zQg+7ju+7mqfQyavjqbLCFZvyrKQZvro98n+r7LK7dqWEp
 g
X-Gm-Gg: ASbGncv4hvYTRH9w4gV6Md3WPwH6h2xCZd+8V7M+hOc/6Ngt0qGkutXWdFAzGEIWLpA
 lE9lc7UE1MRHrV5LwxWhWBJb83nNy7QGsmdnOhNrp9NQMvKRwVkgfn+oeDMyUqp6l+4iVFk8Lmq
 NbBiIN9FGoMtQ78KKrp9rMWG8/0txG5bKzYqjEOeS0qT7HBJ2we/iBQYn/MB5n+NUZVErYjA8J3
 OsMYgoEiXpNXeRVNsrFCFgRJEuDvXVdGiabF08umqUZz0kiwNqFeO2eROc3ylvshF1lTu0KEnOU
 ia3ryuPRMOxEw6QDmlNi
X-Google-Smtp-Source: AGHT+IGRlzcdUftBnHK3r1PEMVu20z5uwNu1GtnfdzgdE73TTbg2RnltGwj2HaxukXlVXgVGkWXvVw==
X-Received: by 2002:a5d:598d:0:b0:38a:8b34:76b0 with SMTP id
 ffacd0b85a97d-38de43ec4b6mr3833068f8f.27.1739291206575; 
 Tue, 11 Feb 2025 08:26:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/68] target/arm: Handle FPCR.AH in SVE FCMLA
Date: Tue, 11 Feb 2025 16:25:33 +0000
Message-Id: <20250211162554.4135349-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

The negation step in SVE FCMLA mustn't negate a NaN when FPCR.AH is
set.  Use the same approach as we did for A64 FCMLA of passing in
FPCR.AH and using it to select whether to negate by XOR or by the
muladd negate_product flag.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-28-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c    | 69 +++++++++++++++++++++-------------
 target/arm/tcg/translate-sve.c |  2 +-
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c12b2600bd7..c206ca65ceb 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5347,13 +5347,18 @@ void HELPER(sve_fcmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
-    unsigned rot = simd_data(desc);
-    bool flip = rot & 1;
-    float16 neg_imag, neg_real;
+    bool flip = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_real = flip ^ negf_imag;
+    float16 negx_imag, negx_real;
     uint64_t *g = vg;
 
-    neg_imag = float16_set_sign(0, (rot & 2) != 0);
-    neg_real = float16_set_sign(0, rot == 1 || rot == 2);
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (negf_real & ~fpcr_ah) << 15;
+    negx_imag = (negf_imag & ~fpcr_ah) << 15;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5370,18 +5375,18 @@ void HELPER(sve_fcmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
             mi = *(float16 *)(vm + H1_2(j));
 
             e2 = (flip ? ni : nr);
-            e1 = (flip ? mi : mr) ^ neg_real;
+            e1 = (flip ? mi : mr) ^ negx_real;
             e4 = e2;
-            e3 = (flip ? mr : mi) ^ neg_imag;
+            e3 = (flip ? mr : mi) ^ negx_imag;
 
             if (likely((pg >> (i & 63)) & 1)) {
                 d = *(float16 *)(va + H1_2(i));
-                d = float16_muladd(e2, e1, d, 0, status);
+                d = float16_muladd(e2, e1, d, negf_real, status);
                 *(float16 *)(vd + H1_2(i)) = d;
             }
             if (likely((pg >> (j & 63)) & 1)) {
                 d = *(float16 *)(va + H1_2(j));
-                d = float16_muladd(e4, e3, d, 0, status);
+                d = float16_muladd(e4, e3, d, negf_imag, status);
                 *(float16 *)(vd + H1_2(j)) = d;
             }
         } while (i & 63);
@@ -5392,13 +5397,18 @@ void HELPER(sve_fcmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
-    unsigned rot = simd_data(desc);
-    bool flip = rot & 1;
-    float32 neg_imag, neg_real;
+    bool flip = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_real = flip ^ negf_imag;
+    float32 negx_imag, negx_real;
     uint64_t *g = vg;
 
-    neg_imag = float32_set_sign(0, (rot & 2) != 0);
-    neg_real = float32_set_sign(0, rot == 1 || rot == 2);
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (negf_real & ~fpcr_ah) << 31;
+    negx_imag = (negf_imag & ~fpcr_ah) << 31;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5415,18 +5425,18 @@ void HELPER(sve_fcmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
             mi = *(float32 *)(vm + H1_2(j));
 
             e2 = (flip ? ni : nr);
-            e1 = (flip ? mi : mr) ^ neg_real;
+            e1 = (flip ? mi : mr) ^ negx_real;
             e4 = e2;
-            e3 = (flip ? mr : mi) ^ neg_imag;
+            e3 = (flip ? mr : mi) ^ negx_imag;
 
             if (likely((pg >> (i & 63)) & 1)) {
                 d = *(float32 *)(va + H1_2(i));
-                d = float32_muladd(e2, e1, d, 0, status);
+                d = float32_muladd(e2, e1, d, negf_real, status);
                 *(float32 *)(vd + H1_2(i)) = d;
             }
             if (likely((pg >> (j & 63)) & 1)) {
                 d = *(float32 *)(va + H1_2(j));
-                d = float32_muladd(e4, e3, d, 0, status);
+                d = float32_muladd(e4, e3, d, negf_imag, status);
                 *(float32 *)(vd + H1_2(j)) = d;
             }
         } while (i & 63);
@@ -5437,13 +5447,18 @@ void HELPER(sve_fcmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
     intptr_t j, i = simd_oprsz(desc);
-    unsigned rot = simd_data(desc);
-    bool flip = rot & 1;
-    float64 neg_imag, neg_real;
+    bool flip = extract32(desc, SIMD_DATA_SHIFT, 1);
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_real = flip ^ negf_imag;
+    float64 negx_imag, negx_real;
     uint64_t *g = vg;
 
-    neg_imag = float64_set_sign(0, (rot & 2) != 0);
-    neg_real = float64_set_sign(0, rot == 1 || rot == 2);
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (uint64_t)(negf_real & ~fpcr_ah) << 63;
+    negx_imag = (uint64_t)(negf_imag & ~fpcr_ah) << 63;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     do {
         uint64_t pg = g[(i - 1) >> 6];
@@ -5460,18 +5475,18 @@ void HELPER(sve_fcmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
             mi = *(float64 *)(vm + H1_2(j));
 
             e2 = (flip ? ni : nr);
-            e1 = (flip ? mi : mr) ^ neg_real;
+            e1 = (flip ? mi : mr) ^ negx_real;
             e4 = e2;
-            e3 = (flip ? mr : mi) ^ neg_imag;
+            e3 = (flip ? mr : mi) ^ negx_imag;
 
             if (likely((pg >> (i & 63)) & 1)) {
                 d = *(float64 *)(va + H1_2(i));
-                d = float64_muladd(e2, e1, d, 0, status);
+                d = float64_muladd(e2, e1, d, negf_real, status);
                 *(float64 *)(vd + H1_2(i)) = d;
             }
             if (likely((pg >> (j & 63)) & 1)) {
                 d = *(float64 *)(va + H1_2(j));
-                d = float64_muladd(e4, e3, d, 0, status);
+                d = float64_muladd(e4, e3, d, negf_imag, status);
                 *(float64 *)(vd + H1_2(j)) = d;
             }
         } while (i & 63);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 410087c3fbd..6af94fedd0a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3955,7 +3955,7 @@ static gen_helper_gvec_5_ptr * const fcmla_fns[4] = {
     gen_helper_sve_fcmla_zpzzz_s, gen_helper_sve_fcmla_zpzzz_d,
 };
 TRANS_FEAT(FCMLA_zpzzz, aa64_sve, gen_gvec_fpst_zzzzp, fcmla_fns[a->esz],
-           a->rd, a->rn, a->rm, a->ra, a->pg, a->rot,
+           a->rd, a->rn, a->rm, a->ra, a->pg, a->rot | (s->fpcr_ah << 2),
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_4_ptr * const fcmla_idx_fns[4] = {
-- 
2.34.1


