Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D842CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1JO-0002lJ-2j; Thu, 07 May 2026 12:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ie-0001gR-7Q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:11 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ib-00085e-K4
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:07 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so530858a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778170204; x=1778775004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2PfrqBtIf7vrbh2G9kIH/7coVyeCHu2A8Sgg5/INWz4=;
 b=Q/zcIfj4gVp9No/9ryuJ7+UsPqxaEvV0cY8esTO4lSAmKN7Nl9CH/014WcHVCy536+
 avyWuImv5Cz/kLe5muwleQ2l/xnAecopEyMtLq9Sfta5JZmVWD8Jx1omwn2rMmIiGCwc
 g+xJcK21PO/U8g8lYvCQ9G5x237GMYjc2O54/+x4RxDGOCcgrREc8bhBriLkUcKAgG6u
 mj25xDDWslrBj8UPMPPhHW/7jLOr5eRnpyBkYMpRfi6uShzebER2OV+P5GwD3vF5yuyo
 6goyR2w5KTCcc6TpokdS93dG8Bq6egSpTPoSXWyekse0h/IMMFmhP8ji6kOXiPyd0DsT
 bw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778170204; x=1778775004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2PfrqBtIf7vrbh2G9kIH/7coVyeCHu2A8Sgg5/INWz4=;
 b=MXkEEveGY5Zj2WuKfVFdB+/OHBsr6xQwe/sB5DxuNYXTp5/BbevZ33lFKc354KekuQ
 6mvuM/80RjsetGmWR7OmbXtDilW55LEmYnArVPM3L4Nm14pCqzoYg/BVb60v+Bb7cu9c
 kTSmyylB6ioKALs6DKS16rshCK9/X0qRj4a/wESh3rh//GVC396qMy3Ld4xwrreOnZs7
 ywsGESQXf4TQTgWMp99EcmBSpHMybDVi6Puo2oWic2nnMWzESAhvrpyiGVIRfEaVF3Gt
 NdXZ35Ca1NPo1+liMcyWW6T0+pHv1loj8pOmKQPHoOmXQVWxmCQfnnATcvEMI1wGTRmM
 9kbQ==
X-Gm-Message-State: AOJu0Yxp5g+MM54XOhqRYMp0QRhpDLH2jG+E8TvF1EDmskxnXKCdv2l9
 tLXyGconlQmjzpH88465pS5rnJABY6mRtdsI5X6h6w8XqiRVsJ52bAeMNn3OSr9tpKgO7VAab9p
 ruCB2
X-Gm-Gg: AeBDieu1zI5sUTXP3CDvsGfhSBbKkw3nurafYPpzl++w0pLcUCrVoFa9UjPY4FiYXmh
 5RkVaw0ONqlCXdiBPLjuljwqRZheSQi6SxzJUlXhg2pHZ5UZtfQwyxWVzeS9UYEgTYQ3eV2z8NX
 rz6qKd6p60gDtIXUJPmdmtJK0O/SXFtVboFeexHDMLNGrTm96PuQsoUKMRdqXpmdtASRR9EoTlA
 ra02VgBckFTLR1PWusPkxxBsNnWtK9yUQXDTdqqxAr7+pyWGxIhNY63ZXy9fdPWtqDlSiL/rGIk
 7Bf7+Hzodd3d250jvtt5O2NfLZaO6VxJdj17bPzRFEI0whVgHBahDnipkZMP5c6l7fUl0Srq3JN
 DYGXr6Nk/WnUdp1YdsGP1mfOqvXcWTDwrHdHVrH9pWhj2/yE+ER3chm2L1zEtcLDuii+PlgE8mZ
 Ja0pVc8BNJN8JYm1vzBP+cOtlM9Ico6FOjCjmv6Q3hmjJigg==
X-Received: by 2002:a05:6830:83b1:b0:7d7:f623:680a with SMTP id
 46e09a7af769-7e1ded2af14mr4988566a34.2.1778170204330; 
 Thu, 07 May 2026 09:10:04 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e302462fb1sm16415a34.11.2026.05.07.09.10.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:10:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/11] fpu: Hoist nan check in partsN_addsub
Date: Thu,  7 May 2026 11:09:51 -0500
Message-ID: <20260507160959.449170-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160959.449170-1-richard.henderson@linaro.org>
References: <20260507160959.449170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

The nan test had been down below because it was unlikely.
But if we have to have one anyway because of denormals,
we might as well take care of them right away.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 87525fb4b6..20cb739c75 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -530,13 +530,15 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
 {
     int ab_mask = float_cmask(a_orig->cls) | float_cmask(b_orig->cls);
 
+    if (unlikely(ab_mask & float_cmask_anynan)) {
+        return partsN(pick_nan)(a_orig, b_orig, s);
+    }
+
     /*
      * For addition and subtraction, we will consume an
      * input denormal unless the other input is a NaN.
      */
-    if (!(ab_mask & float_cmask_anynan)) {
-        record_denormals_used(ab_mask, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     FloatPartsN a = *a_orig;
     FloatPartsN b = *b_orig;
@@ -558,10 +560,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
             return a;
         }
 
-        if (unlikely(ab_mask & float_cmask_anynan)) {
-            goto p_nan;
-        }
-
         if (ab_mask & float_cmask_inf) {
             if (a.cls != float_class_inf) {
                 /* N - Inf */
@@ -586,10 +584,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
             return a;
         }
 
-        if (unlikely(ab_mask & float_cmask_anynan)) {
-            goto p_nan;
-        }
-
         if (ab_mask & float_cmask_inf) {
             a.cls = float_class_inf;
             return a;
@@ -604,9 +598,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
     g_assert(a.cls == float_class_zero);
     g_assert(is_anynorm(b.cls));
     return b;
-
- p_nan:
-    return partsN(pick_nan)(a_orig, b_orig, s);
 }
 
 /*
-- 
2.43.0


