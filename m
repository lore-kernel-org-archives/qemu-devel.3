Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901FFC02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYS-0006lz-3c; Sat, 01 Feb 2025 11:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYO-0006g2-Ld
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:08 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYM-0001Ec-MO
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:08 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso22431825e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428065; x=1739032865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4SIxijMH1bd/VjPyy4//6A0KHczC2X1t6r/A1ob+iQQ=;
 b=cYgq2kdgQy36IDXP6zScDS7IBUZVWJmmwMdJ6q/7NdeQC45U5+ovK3xj7hrzlHw2VZ
 +nFNsZDKkkns2q4Dpq9XL++8dHechDjPBPcH2HSnc0ZuDkg/ho4u12Al241L49N3Ad48
 x8meRBKlCXiHbEWhE4H/yKiHvNYcfwaBSkT2q2ER8mC0dUw4og0xem4/c/Tnc3SFCuWV
 ZcVZpYqQkwgtrGSxLnAlH+aGdrOk+MZ3s/m1pgQ3mT/pBvRvsOCKJZxRO5zwL2Vxn/CI
 UBv++QCQnjlWXYYRVTG7kZ5TEs8/ZELXt9KVWx3UnpjSWNXuJF2iVmLZcBUcTvtrSR50
 R6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428065; x=1739032865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4SIxijMH1bd/VjPyy4//6A0KHczC2X1t6r/A1ob+iQQ=;
 b=wodQ1ASrptocDWf7cKqwkWvDz3cklB34r3bO8rdSI4XpizKTQxJssLOR8Ma9fXF2HK
 BcuZ94ACjVOwsbt1lWCVA7H0aMU89QNtidt2EwK/XdG284sysSH8Xqc8cKRK0/iJQmd3
 NHnfZAwbDvKV/u92MqYomCX/7S49Trtj5f0UIjHFBgaHWka2dObXh+niWVswUplF/Pzm
 RKXS48On4FFP65pyYYjT69FPE9jS4/A18W8gBANWCoPSja3HwgvXeTQbBNYNmL65vGC5
 MhVU10UtegQxQCQMo5H3JzP+BSdeN/B7drhe6gR0lihn/v5NeA02t1lM/9cWDTs81zEV
 cAQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXykdx5P7IF6KKBBAGZDSh1ct/jvbXlh3t/y0uMHaA/SiAjs9I8ZMsNQqc3U71tpjWgcFtn2yppCu1d@nongnu.org
X-Gm-Message-State: AOJu0YywoLd/jRnoMrZeibT2GTFcQ8gHrukCtxISuPt3jCAwYZaDe3nJ
 dxBQsBOddv3cf+4ZaQ5bFaDEdfRSCKpUnED8rniKVsJJRI/lDc5p3Ao4G8Z9DC6DdiEGo2Kl/Yp
 K
X-Gm-Gg: ASbGnctd+CNCBCWtWX4+JiqGKpjoV/hxQW1lf2her8ie85qv4J1RJpO/QX6wtq+PpNg
 DBaItUDqEsBnvk3svK1WsW853X43Dvw3lydsx57bpJtz67TpV/QDcwc0JQQnIgbe1AlljqoLDfP
 JxivBxPqVqagrl84aRjd6POffdFEk4S7lJ1Z2jLij4Ec0yVjc7zTpaDsD5ATIYd/8HtvvRsJhuS
 R3QgR545GRwbVejuyqfFhxzuSzJj60WsL2deZjrtezB3OPZauAKYjYGW1kZqdyD65qmsiHU9nKr
 l7YOUFDDi3zQ1Cp4BaRn
X-Google-Smtp-Source: AGHT+IFtfrNKgTVcH1eLwO3nRlFlhcQYyejp5mVfCps8ycP+y93itPFR/Za0fnAep3AJtqktyBnMgg==
X-Received: by 2002:a5d:4e86:0:b0:386:2a3b:8aa with SMTP id
 ffacd0b85a97d-38c5209000bmr10305001f8f.37.1738428065219; 
 Sat, 01 Feb 2025 08:41:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 38/69] target/arm: Handle FPCR.AH in negation steps in FCADD
Date: Sat,  1 Feb 2025 16:39:41 +0000
Message-Id: <20250201164012.1660228-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The negation steps in FCADD must honour FPCR.AH's "don't change the
sign of a NaN" semantics.  Implement this by encoding FPCR.AH into
the SIMD data field passed to the helper and using that to decide
whether to negate the values.

The construction of neg_imag and neg_real were done to make it easy
to apply both in parallel with two simple logical operations.  This
changed with FPCR.AH, which is more complex than that. Switch to
an approach closer to the pseudocode, where we extract the rot
parameter from the SIMD data word and negate the appropriate
input value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 10 +++++--
 target/arm/tcg/vec_helper.c    | 54 +++++++++++++++++++---------------
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0c1e97e6c40..52f93cb905b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6117,8 +6117,14 @@ static gen_helper_gvec_3_ptr * const f_vector_fcadd[3] = {
     gen_helper_gvec_fcadds,
     gen_helper_gvec_fcaddd,
 };
-TRANS_FEAT(FCADD_90, aa64_fcma, do_fp3_vector, a, 0, f_vector_fcadd)
-TRANS_FEAT(FCADD_270, aa64_fcma, do_fp3_vector, a, 1, f_vector_fcadd)
+/*
+ * Encode FPCR.AH into the data so the helper knows whether the
+ * negations it does should avoid flipping the sign bit on a NaN
+ */
+TRANS_FEAT(FCADD_90, aa64_fcma, do_fp3_vector, a, 0 | (s->fpcr_ah << 1),
+           f_vector_fcadd)
+TRANS_FEAT(FCADD_270, aa64_fcma, do_fp3_vector, a, 1 | (s->fpcr_ah << 1),
+           f_vector_fcadd)
 
 static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
 {
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 0b84a562c03..b181b9734d4 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -879,19 +879,21 @@ void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
     float16 *d = vd;
     float16 *n = vn;
     float16 *m = vm;
-    uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = neg_real ^ 1;
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 15;
-    neg_imag <<= 15;
-
     for (i = 0; i < opr_sz / 2; i += 2) {
         float16 e0 = n[H2(i)];
-        float16 e1 = m[H2(i + 1)] ^ neg_imag;
+        float16 e1 = m[H2(i + 1)];
         float16 e2 = n[H2(i + 1)];
-        float16 e3 = m[H2(i)] ^ neg_real;
+        float16 e3 = m[H2(i)];
+
+        if (rot) {
+            e3 = float16_maybe_ah_chs(e3, fpcr_ah);
+        } else {
+            e1 = float16_maybe_ah_chs(e1, fpcr_ah);
+        }
 
         d[H2(i)] = float16_add(e0, e1, fpst);
         d[H2(i + 1)] = float16_add(e2, e3, fpst);
@@ -906,19 +908,21 @@ void HELPER(gvec_fcadds)(void *vd, void *vn, void *vm,
     float32 *d = vd;
     float32 *n = vn;
     float32 *m = vm;
-    uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = neg_real ^ 1;
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 31;
-    neg_imag <<= 31;
-
     for (i = 0; i < opr_sz / 4; i += 2) {
         float32 e0 = n[H4(i)];
-        float32 e1 = m[H4(i + 1)] ^ neg_imag;
+        float32 e1 = m[H4(i + 1)];
         float32 e2 = n[H4(i + 1)];
-        float32 e3 = m[H4(i)] ^ neg_real;
+        float32 e3 = m[H4(i)];
+
+        if (rot) {
+            e3 = float32_maybe_ah_chs(e3, fpcr_ah);
+        } else {
+            e1 = float32_maybe_ah_chs(e1, fpcr_ah);
+        }
 
         d[H4(i)] = float32_add(e0, e1, fpst);
         d[H4(i + 1)] = float32_add(e2, e3, fpst);
@@ -933,19 +937,21 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
     float64 *d = vd;
     float64 *n = vn;
     float64 *m = vm;
-    uint64_t neg_real = extract64(desc, SIMD_DATA_SHIFT, 1);
-    uint64_t neg_imag = neg_real ^ 1;
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
+    bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 63;
-    neg_imag <<= 63;
-
     for (i = 0; i < opr_sz / 8; i += 2) {
         float64 e0 = n[i];
-        float64 e1 = m[i + 1] ^ neg_imag;
+        float64 e1 = m[i + 1];
         float64 e2 = n[i + 1];
-        float64 e3 = m[i] ^ neg_real;
+        float64 e3 = m[i];
+
+        if (rot) {
+            e3 = float64_maybe_ah_chs(e3, fpcr_ah);
+        } else {
+            e1 = float64_maybe_ah_chs(e1, fpcr_ah);
+        }
 
         d[i] = float64_add(e0, e1, fpst);
         d[i + 1] = float64_add(e2, e3, fpst);
-- 
2.34.1


