Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0A6CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72K-0000s7-3a; Thu, 07 May 2026 18:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72I-0000ru-Qw
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:38 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72G-0003Ex-BF
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:38 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6949f3eeaf6so1216157eaf.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192254; x=1778797054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m63KohySy09FkFyyCZ8fbqOzqD49GaHFi9mPn3TK+k4=;
 b=W2W0yGCl6FQ8aNgjA9zd63DmAWbjllVLHP2kgd+jbNEpyCMPjUp7SdPyu/ANoHh+lg
 wp9NGXkTX5/CaTN3oVVyKfOyBOxY7tasBYRFAeDDrvd3D+b2x3CgEeZMBYuVHfpLFZTn
 2eUYDOrGDyEBn+D76hAn1z+x+iITfMJZMwblPq0kKmTR8z9EE28ka6Fr5biZ42jrNvkC
 qkvcMC+pV41AMsqGPuh3EKA4h9BBMdrSfkzg+uzHvH5e7SAPBKiDhb2UlwPya7P7LfFO
 26oSfshq+O8rJYzdnD9Gfjb92SNlEUDhJkwZsG+DEoqzvEUUXoj1SCOIx3Umzo3Q/Fin
 ZxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192254; x=1778797054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m63KohySy09FkFyyCZ8fbqOzqD49GaHFi9mPn3TK+k4=;
 b=V3x6P8HDuJ4o6SwPsNmX3SNFiR1j05cg9730TM4TnHwRySUiXMrM/TShxK8q9zuE3G
 bSUowZIv2KVKDaemBXxvQ6FBynkYOyplCtslV4IglhuzYw3xJTb8rJ+kOOJF29LPoxel
 8bs0torto5aqGLPHHTLwAdOvbwxtMg8Gs2KCrdn6cs9hrxjC6i+ezJsIRMF1EJlPSqsZ
 XYN0E6m2TszAKBcSFIJ3mP6dr5dVU65hYuVasbrb8E4VyDL1asAqw0YdQF1qwHDdYNdC
 3Ckokssl1vpeSeMsSL4sXhW1HT0LvcD/676l/XjTGw36r/7WDNGh1Ib6FDhMlaG0it09
 22tQ==
X-Gm-Message-State: AOJu0YyebAFYpYE2PSp63W0Q2q5zDbfl2ZaO9LpY92XELT4ze0/RSvb4
 C8ro9A5gXdUQfs89152YeqV2IYVHfXxCgATPDZ6nbDlFBpMJR7lq9nx0ZMZ2JTgCU5HNeyHGAed
 y+o8b
X-Gm-Gg: AeBDiesgeBcCboFp5K5I1wMcDxUaiDibaws+Jt4dLp4XG7zjP8YfaA1XerZg1EvUSxc
 Jvdt49i8N1L0hfGeac3h2R3VVGallRSd0cNyvarGK5FP9v/edGQU+qwGpPQ+Ved8pS5Bqx3CJor
 ah0+Wjma46GxWibUCZx9UrGzVdU3FV+PNYQzpsEE3jLfGrDCNfc6N0/L5cJucw/fMaobxR/IrsI
 FFOxw9IPPjNCHJBlvW7iodPny+YrToPr6r1dCpivE3CNpqO9H+2a4npZ5lH83lxJFZzg+1bYTDz
 xGF3t555yxTcst9HYd6em/cBUt3h1eWuAnKdl7PYtPb+Knn7fKqnRp9R5RC+1tzpFjZZ/7ruL3+
 KHydSCz8yKSigz07Yr8x0yYqgFQgnA/ewKkzbi1Ge7NXeVCRhZWOt4tqBQhSkjX6zy9Ofm/Z63e
 alp48iviar84NOdxY/SxMGtyNMmtY5I5/i340GNi60wSkyIw==
X-Received: by 2002:a05:6820:c8f:b0:67d:e6fa:4488 with SMTP id
 006d021491bc7-699ab64e49dmr2547814eaf.22.1778192254263; 
 Thu, 07 May 2026 15:17:34 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/18] fpu: Use accessors for tininess_before_rounding
Date: Thu,  7 May 2026 17:17:10 -0500
Message-ID: <20260507221717.486023-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rename get_float_detect_tininess to get_tininess_before_rounding
and move to softfloat.c, as there are no external users.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 5 -----
 fpu/softfloat.c                 | 4 ++--
 tests/fp/fp-test.c              | 2 +-
 fpu/softfloat-parts.c.inc       | 2 +-
 fpu/softfloat-specialize.c.inc  | 5 +++++
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 95edd22842..395ce67abf 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -132,11 +132,6 @@ static inline void set_snan_rule(FloatSNaNRule val, float_status *status)
     status->float_snan_rule = val;
 }
 
-static inline bool get_float_detect_tininess(const float_status *status)
-{
-    return status->tininess_before_rounding;
-}
-
 static inline FloatRoundMode get_float_rounding_mode(const float_status *status)
 {
     return status->float_rounding_mode;
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 1be90c9c7c..b1c2b0e6e1 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4911,7 +4911,7 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec roundingPrecision, bool zSign,
                 float_raise(float_flag_output_denormal_flushed, status);
                 return packFloatx80(zSign, 0, 0);
             }
-            isTiny = status->tininess_before_rounding
+            isTiny = get_tininess_before_rounding(status)
                   || (zExp < 0 )
                   || (zSig0 <= zSig0 + roundIncrement);
             shift64RightJamming( zSig0, 1 - zExp, &zSig0 );
@@ -4985,7 +4985,7 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec roundingPrecision, bool zSign,
             return floatx80_default_inf(zSign, status);
         }
         if ( zExp <= 0 ) {
-            isTiny = status->tininess_before_rounding
+            isTiny = get_tininess_before_rounding(status)
                   || (zExp < 0)
                   || !increment
                   || (zSig0 < UINT64_C(0xFFFFFFFFFFFFFFFF));
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 326a1201f3..16ffd36e6f 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -1011,7 +1011,7 @@ void run_test(void)
 
                     verCases_tininessCode = 0;
                     slowfloat_detectTininess = tmode;
-                    qsf.tininess_before_rounding = sf_tininess_to_qemu(tmode);
+                    set_float_detect_tininess(sf_tininess_to_qemu(tmode), &qsf);
 
                     if (attrs & FUNC_EFF_TININESSMODE ||
                         ((attrs & FUNC_EFF_TININESSMODE_REDUCEDPREC) &&
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 38b317c1a7..72bbafcb13 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -428,7 +428,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         exp = 0;
         fracN(clear)(p);
     } else {
-        bool is_tiny = s->tininess_before_rounding || exp < 0;
+        bool is_tiny = get_tininess_before_rounding(s) || exp < 0;
         bool has_pseudo_denormals = fmt->has_explicit_bit &&
             (get_floatx80_behaviour(s) & floatx80_pseudo_denormal_valid);
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 91250bc5a1..ac3fc85138 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -79,6 +79,11 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
+static inline bool get_tininess_before_rounding(const float_status *status)
+{
+    return status->tininess_before_rounding;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
-- 
2.43.0


