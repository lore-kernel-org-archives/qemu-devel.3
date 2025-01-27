Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F289C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYUw-0006Uh-Iv; Mon, 27 Jan 2025 18:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUn-0006PI-Su
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:23 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUl-0005cB-MV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:21 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee397a82f6so8822029a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020378; x=1738625178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7xWXB+eng8DnKFn3D01/tYMXRHmURU0wtcrE+/Ypck=;
 b=jpUWg1Cau8kzRH6zebyOnYMWMTWMdrE3syO9Bc5xidBvpUatoAt1QHndAHRZ5lMeji
 sJoR5aAYrm+bcl0/Ug19F2RDOcdv0A+kt6cMoJtLPy9KB8qrGsqgsJqUfrE4q1qk5SgC
 MzNmjMJTVDpCm3AeRRYnI6u8O77vorxqt+6YPFSxuyyyXypGxlDJKoFwpeAQP5/nETd8
 5tMYa8rv4XYze60k/qhF/jsfKdCjUulqD5yCOfIhLaYMyYyMjdPIJ5Jv4Wg5XskYQ1qQ
 cN5k0gdeG4GMR0+gMlvJoYrMb1VabuOHYBy5dSxfissPJw6mhUdLN9lNZVtvLAPCTgWj
 mMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020378; x=1738625178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7xWXB+eng8DnKFn3D01/tYMXRHmURU0wtcrE+/Ypck=;
 b=BkQRXKQBjgogLLS+gan2M733HpFvWrTTXCEMqRFRHbAwx868UHpw3b+W6qMcoNgnHt
 TrmZ2YXiLcXqw+rDkoJvqrOGrU1b7OunXb2EOIXCszEwr+Cw7iUxRmW181xqhuR/FGay
 dWjQK0CkJ9lu5Q/2py7cYMKMF7EmDJfV86pOj1ysRg50zJ0JaWnD8PYQXBrwam2FV73U
 Fx8edJDB+10WmPLtKJ3ioi5YsfNK7sdTY7a+VRosDQTtIVMOVzYfXzbeOiNxH8D8hsPy
 W8k5b43fdr3cRTEX630rEyK7rVEUYpM2YwpLiZfgHVu9W65GjvqojgmD5n0t5363LHSZ
 LZdg==
X-Gm-Message-State: AOJu0Yzy5qlDEphllVvrN7uTkDac6ueMYaWJ/2QGJB4E4aZZDDc/9nn3
 yvuGbHNZFvwq+yngL9jEeuotP/m8KyIkF7cXfbhsGbfxKdkWH3livrvAwd7j9BB8h8JVYkqo/hf
 w
X-Gm-Gg: ASbGncvK+k1pPjIYJ7Pja6yMP7wG8TtpLs5xV2P9ZG/fFo4wEQKphqLEUpg1+xMBFK4
 3ADYOkCGBTjPbdh73smJVSfQRqDyEAF4AsoiA9/+Dda0FTuhCQMzHLUBHhbeIQlxDzAn0jOAAAV
 GSimSNW4W03Nhj6tCwb4MFy/hlMyu9TLaItAGgfsIhDxZrrFeJVj6+z5II1iNNuMRvzLZsInnHG
 lEsGqk537wHzMDQIXKbGCUpGnfhHGP5LUQ6tXKhphC8pO0nF1UdfVF8p9K5t4SwWE0Pn5jdVJBo
 Z9voXN2ZBFyTAgnYfnaqXxuMxidNwwRqPzbQ3rg=
X-Google-Smtp-Source: AGHT+IHVcgXtDZKvsOp17tt6PDKjbS18UGJuC8BDPJ7M+Mv+KbskCquBdoNQevGYUMQFvVJJ9wHzUQ==
X-Received: by 2002:a17:90a:c88c:b0:2ee:c059:7de3 with SMTP id
 98e67ed59e1d1-2f782cc01f5mr70851429a91.18.1738020378131; 
 Mon, 27 Jan 2025 15:26:18 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 15/22] target/arm: Simplify fp_status indexing in mve_helper.c
Date: Mon, 27 Jan 2025 15:25:57 -0800
Message-ID: <20250127232604.20386-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Select on index instead of pointer.
No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mve_helper.c | 40 +++++++++++++------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 3763d71e20..274003e2e5 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -2814,8 +2814,7 @@ DO_VMAXMINA(vminaw, 4, int32_t, uint32_t, DO_MIN)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2888,8 +2887,7 @@ DO_2OP_FP_ALL(vminnma, minnuma)
                 r[e] = 0;                                               \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(tm & 1)) {                                            \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2926,8 +2924,7 @@ DO_VCADD_FP(vfcadd270s, 4, float32, float32_add, float32_sub)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2964,8 +2961,7 @@ DO_VFMA(vfmss, 4, float32, true)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE * 2)) == 0) {          \
                 continue;                                               \
             }                                                           \
-            fpst0 = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :  \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst0 = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             fpst1 = fpst0;                                              \
             if (!(mask & 1)) {                                          \
                 scratch_fpst = *fpst0;                                  \
@@ -3049,8 +3045,7 @@ DO_VCMLA(vcmla270s, 4, float32, 3, DO_VCMLAS)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3084,8 +3079,7 @@ DO_2OP_FP_SCALAR_ALL(vfmul_scalar, mul)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3116,9 +3110,8 @@ DO_2OP_FP_ACC_SCALAR(vfmas_scalars, 4, float32, DO_VFMAS_SCALARS)
         unsigned e;                                             \
         TYPE *m = vm;                                           \
         TYPE ra = (TYPE)ra_in;                                  \
-        float_status *fpst = (ESIZE == 2) ?                     \
-            &env->vfp.fp_status[FPST_STD_F16] :                 \
-            &env->vfp.fp_status[FPST_STD];                       \
+        float_status *fpst =                                    \
+            &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {      \
             if (mask & 1) {                                     \
                 TYPE v = m[H##ESIZE(e)];                        \
@@ -3168,8 +3161,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
             if ((mask & emask) == 0) {                                  \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3202,8 +3194,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
             if ((mask & emask) == 0) {                                  \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3267,8 +3258,7 @@ DO_VCMP_FP_BOTH(vfcmples, vfcmple_scalars, 4, float32, !DO_GT32)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3300,9 +3290,8 @@ DO_VCVT_FIXED(vcvt_fu, 4, uint32_t, helper_vfp_touls_round_to_zero)
         unsigned e;                                                     \
         float_status *fpst;                                             \
         float_status scratch_fpst;                                      \
-        float_status *base_fpst = (ESIZE == 2) ?                        \
-            &env->vfp.fp_status[FPST_STD_F16] :                         \
-            &env->vfp.fp_status[FPST_STD];                               \
+        float_status *base_fpst =                                       \
+            &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD];  \
         uint32_t prev_rmode = get_float_rounding_mode(base_fpst);       \
         set_float_rounding_mode(rmode, base_fpst);                      \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
@@ -3427,8 +3416,7 @@ void HELPER(mve_vcvtt_hs)(CPUARMState *env, void *vd, void *vm)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
-- 
2.43.0


