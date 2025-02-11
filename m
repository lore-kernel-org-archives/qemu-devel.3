Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BE7C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6X-0007lj-BJ; Tue, 11 Feb 2025 11:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht61-0006m1-GE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:55 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5z-0003T9-64
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:48 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43957634473so1666265e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291206; x=1739896006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ut2lQGo6oTmo9ELWp9goqtvtpII9XVRW9kdPNv1OMnw=;
 b=ReA9K8kRX/0CC0+vmiOqZzcf/40ev+lFsS9Z2IxjXLupWZoERcBN1e+qFk7W36hdJ9
 R9ikuY43blZLxr6Dzhaga2kd0tvRTvv6pG9pRFr5fYHjkHTE+RYw2dJtSGV16DPp85BQ
 uCsLj5TVyRHiaJ2dAucK9WfB80PfvZ99iJZhf2f0mVx9GU+kR/lGgnbQ2oEZPUdujq45
 CXy0ABgEK8aYfULAo4nc+Ep47dTkpTV0vSN8x9q+GOt79PZrLX7wFbchlRTbFrEIRb2G
 depF7+l5Iq7PT7RGnErBaJYbhUKsz5S5/E0NQBnUpGyyzJ4D72V0lvLy2U22ZKFvIV40
 XAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291206; x=1739896006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ut2lQGo6oTmo9ELWp9goqtvtpII9XVRW9kdPNv1OMnw=;
 b=YdOxnoRk1Ea/13iQrNygr3rr4lKwqFklCbZ6gg/i4WkRrRxF7BV0KGkGt3ef7Z3yMG
 rEh3KqPXinyVYwji89/J/BEfwAPtkv0wCsWXo2uzQ/wl0NWlxvoKBrY2dMJwvPEBeFHG
 iP3eFGXa2uOXxlGdo7TzpOobu5Awo/nGeKesxZOdYSKTK7Ypf/yzR7AqFfZNgwkdDcll
 y/kM1uzCcqF+6RSYvR+/JTC5cmZyILWEJqeQNthEZc9HdWPKVOZXIlVLF+0SBz42l3Wp
 ETUrPEXFYrPFHarRftNsoDWME0tPLTV5+SzsDSilDBEt2mnypqZGkWlOWZrCWcYdIXTS
 EjNw==
X-Gm-Message-State: AOJu0YxbkgSHy73lbsSRYKB+ZobLaCLRMd7YIb5dXYoHtSVd4H0jmn/3
 IvzqLLkUQgMR8LmexBMyCn0efSPVo+OtrMHlULlV8cQZ4lzW5tBdOQFgva3A8g7V/01SLIDbShN
 k
X-Gm-Gg: ASbGncuD9XAGI8h3Bauhz43FTIVHEcD95rzaIzWlxXLbjG5mUB9TINZH+rjKCs61QtH
 S/aUGHLadXVHKg5w2e1YyH0OCgdr3EgjNlAPgCIrkpDmiGtsFj2Gt4nNIks6lGbUSNlHiDeDybV
 fZPGxIuaPb32/ImyenxdiSOCr/+QOUUgBYfeI7hB7ZIcrhE96+KVhWW9G71gPEFiV7o/iM6kuWh
 qeJHVIt+Ic8vZTMjMhENl+BtXI28H6XY4eDnUezFhfyI6Xpd7NAh7SEWkPM4g+54gVxOK2/uo8x
 t3cNRpWmRpbGbVfF4sBX
X-Google-Smtp-Source: AGHT+IFVvYgHAoFAu9SnFtFwexWjY2t0o0OoBXMhk6yK8fOllT41fK5yH6mih/v7UjnV8fAek5AF0A==
X-Received: by 2002:a05:600c:190f:b0:439:57bb:2aa with SMTP id
 5b1f17b1804b1-43957bb02bdmr765725e9.11.1739291205717; 
 Tue, 11 Feb 2025 08:26:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/68] target/arm: Handle FPCR.AH in FCMLA by index
Date: Tue, 11 Feb 2025 16:25:32 +0000
Message-Id: <20250211162554.4135349-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The negation step in FCMLA by index mustn't negate a NaN when
FPCR.AH is set. Use the same approach as vector FCMLA of
passing in FPCR.AH and using it to select whether to negate
by XOR or by the muladd negate_product flag.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250129013857.135256-27-richard.henderson@linaro.org
[PMM: Expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/vec_helper.c    | 44 ++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ca06982d313..1846f81bf58 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6916,7 +6916,7 @@ static bool trans_FCMLA_vi(DisasContext *s, arg_FCMLA_vi *a)
     if (fp_access_check(s)) {
         gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
                           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64,
-                          (a->idx << 2) | a->rot, fn);
+                          (s->fpcr_ah << 4) | (a->idx << 2) | a->rot, fn);
     }
     return true;
 }
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 630513f00b2..c2f98a5c67e 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -995,29 +995,33 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm, void *va,
     uintptr_t opr_sz = simd_oprsz(desc);
     float16 *d = vd, *n = vn, *m = vm, *a = va;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
-    uint32_t neg_real = flip ^ neg_imag;
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 4, 1);
+    uint32_t negf_real = flip ^ negf_imag;
     intptr_t elements = opr_sz / sizeof(float16);
     intptr_t eltspersegment = MIN(16 / sizeof(float16), elements);
+    float16 negx_imag, negx_real;
     intptr_t i, j;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 15;
-    neg_imag <<= 15;
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (negf_real & ~fpcr_ah) << 15;
+    negx_imag = (negf_imag & ~fpcr_ah) << 15;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     for (i = 0; i < elements; i += eltspersegment) {
         float16 mr = m[H2(i + 2 * index + 0)];
         float16 mi = m[H2(i + 2 * index + 1)];
-        float16 e1 = neg_real ^ (flip ? mi : mr);
-        float16 e3 = neg_imag ^ (flip ? mr : mi);
+        float16 e1 = negx_real ^ (flip ? mi : mr);
+        float16 e3 = negx_imag ^ (flip ? mr : mi);
 
         for (j = i; j < i + eltspersegment; j += 2) {
             float16 e2 = n[H2(j + flip)];
             float16 e4 = e2;
 
-            d[H2(j)] = float16_muladd(e2, e1, a[H2(j)], 0, fpst);
-            d[H2(j + 1)] = float16_muladd(e4, e3, a[H2(j + 1)], 0, fpst);
+            d[H2(j)] = float16_muladd(e2, e1, a[H2(j)], negf_real, fpst);
+            d[H2(j + 1)] = float16_muladd(e4, e3, a[H2(j + 1)], negf_imag, fpst);
         }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
@@ -1059,29 +1063,33 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm, void *va,
     uintptr_t opr_sz = simd_oprsz(desc);
     float32 *d = vd, *n = vn, *m = vm, *a = va;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    uint32_t negf_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
-    uint32_t neg_real = flip ^ neg_imag;
+    uint32_t fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 4, 1);
+    uint32_t negf_real = flip ^ negf_imag;
     intptr_t elements = opr_sz / sizeof(float32);
     intptr_t eltspersegment = MIN(16 / sizeof(float32), elements);
+    float32 negx_imag, negx_real;
     intptr_t i, j;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 31;
-    neg_imag <<= 31;
+    /* With AH=0, use negx; with AH=1 use negf. */
+    negx_real = (negf_real & ~fpcr_ah) << 31;
+    negx_imag = (negf_imag & ~fpcr_ah) << 31;
+    negf_real = (negf_real & fpcr_ah ? float_muladd_negate_product : 0);
+    negf_imag = (negf_imag & fpcr_ah ? float_muladd_negate_product : 0);
 
     for (i = 0; i < elements; i += eltspersegment) {
         float32 mr = m[H4(i + 2 * index + 0)];
         float32 mi = m[H4(i + 2 * index + 1)];
-        float32 e1 = neg_real ^ (flip ? mi : mr);
-        float32 e3 = neg_imag ^ (flip ? mr : mi);
+        float32 e1 = negx_real ^ (flip ? mi : mr);
+        float32 e3 = negx_imag ^ (flip ? mr : mi);
 
         for (j = i; j < i + eltspersegment; j += 2) {
             float32 e2 = n[H4(j + flip)];
             float32 e4 = e2;
 
-            d[H4(j)] = float32_muladd(e2, e1, a[H4(j)], 0, fpst);
-            d[H4(j + 1)] = float32_muladd(e4, e3, a[H4(j + 1)], 0, fpst);
+            d[H4(j)] = float32_muladd(e2, e1, a[H4(j)], negf_real, fpst);
+            d[H4(j + 1)] = float32_muladd(e4, e3, a[H4(j + 1)], negf_imag, fpst);
         }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
-- 
2.34.1


