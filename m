Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91763CD3447
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1ET-0004bh-Q7; Thu, 07 May 2026 12:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1ER-0004aK-QD
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:47 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EP-0006yh-RJ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:47 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcd89701acso972968a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169945; x=1778774745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xa8yuOjFBM/o+OAV5RQr1ox5V1qtU3XTjxW5aIymgbo=;
 b=OUz+M2+74poUILcbSWzpcB0ggKrrprv7L3icoqCyPK4hMe1RQ/oTjk8A0sFY4lqAUV
 4BkkwXzXKCAG86L1aedfLpBgczrRVc2fbHzv9zMZxQ4S1Pwbx5W3vibjvRWw6ALwlvIu
 8wMc+h4HImYyvLGL18TllP7sbWP77pQvzDPZ/jIx6OqyQdgazWiFOhne36iJBBb8R38v
 JhYM7YEPZPt6C8fhaRV8rHJ4BNabC1VD2uQ6s8M6VhPs22m8OyvbGrd0NnF1TvhESIKk
 WEBMatH8rDXhzaisfTK/VBLYgZeZ0hrPFcawPDtXzUC2HhaUE/WEIYiqWsyidGCPmayh
 gmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169945; x=1778774745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xa8yuOjFBM/o+OAV5RQr1ox5V1qtU3XTjxW5aIymgbo=;
 b=Q4xDCR0wHZxB6qW+l6KY6W+RAxCBsZXvY3M5e5Wg1d+YBL3NsWX12N9YKZfqyEJmr/
 KWpBlMz4+mbR+FRppy8d1sGKbm73laYMGW4jWkZWYeqNtnADmm7ncgT9ntlfjnsRr+Nm
 EybT7Qh7T6Je8LwzLrvb01BIMhUCIAlzQ3D2vQYYqdy+5h5NmWas5SHVkX4Gf7CmccW3
 hCGkoDdKg5z+xrGfrb50QEIueKPte5gZDHQOh5qftUoaNdDaR1qZBP2ogltS+nKNQbLy
 gskGR/Ak3X02RfI7/Q3jhWJkgH1VefpafHI6f3Eo3dbf8BGUZMJwGdQpPXOtA8AGvGAU
 RQYA==
X-Gm-Message-State: AOJu0Yyy/zRmXrZLi/Z25b6BGvh8mQGKdXPHxhBeoeXFQcciNf5wIW0B
 4cNXRDBniv4xPyP5XMP0g09VCTs6LVgqqwE1e61bQwO7UT0d8uyAecGPg+UhD/jB1YYvRc3/iD2
 chdSA
X-Gm-Gg: AeBDietm98Pyb2gATPQ5EiGbK0RfzQFw1deWx8jbSwd9RmB28GU38Sg6a4hl6Bky+kR
 Gvzf2c4krJ63idgzVVnu3ApSySWq9VB3AMGhLAfSqg/c2sVF/kEJXP33WbXKGj3059eIDZHlpik
 1MaemBtU1dbym6so3W8l+l8CX68aM6Ua5VgbeyaEw0vO67tGrEnU9J0P9NW5CiIo1JsXsWbAHD1
 Bum//LtAUyJks6GmlkIHbKdzFn0ap10WXDiB3SkbJpvew9pbZtVQHbILobEPJWNlouyro6NrRnv
 PYLjmF9FAlBXGPt9C5UNCUmhsFOnqtlpGGo22Dw+JDzF9NtfEMLV2Bz9J1t44Ch3JimJSfT5m09
 sF4dHmNNsUJGlzqTYqVvHVCoEnE3RnMzTrahIjEF0QoRbN0ILIa0eUtcB0PgpJ1APcRQDnmzHG8
 2riCqlSS/H/x7yJO4REB9gE8MEwJxwPzqNo1m2OI5TJHa/QA==
X-Received: by 2002:a05:6830:82b5:b0:7d7:f15b:bdcf with SMTP id
 46e09a7af769-7e1df1a93a3mr5052144a34.28.1778169944513; 
 Thu, 07 May 2026 09:05:44 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/29] fpu: Return struct from parts{64,128}_pick_nan_muladd
Date: Thu,  7 May 2026 11:05:09 -0500
Message-ID: <20260507160518.444797-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 7d4b40022b..211ecdf114 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -114,13 +114,15 @@ FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
     return *ret;
 }
 
-static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
-                                            FloatPartsN *c, float_status *s,
-                                            int ab_mask, int abc_mask)
+static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
+                                           const FloatPartsN *b,
+                                           const FloatPartsN *c,
+                                           float_status *s,
+                                           int ab_mask, int abc_mask)
 {
     bool infzero = (ab_mask == float_cmask_infzero);
     bool have_snan = (abc_mask & float_cmask_snan);
-    FloatPartsN *ret;
+    const FloatPartsN *ret;
 
     if (unlikely(have_snan)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
@@ -160,7 +162,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         }
         ret = c;
     } else {
-        FloatPartsN *val[R_3NAN_1ST_MASK + 1] = { a, b, c };
+        const FloatPartsN *val[R_3NAN_1ST_MASK + 1] = { a, b, c };
         Float3NaNPropRule rule = s->float_3nan_prop_rule;
 
         assert(rule != float_3nan_prop_none);
@@ -179,13 +181,12 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        *ret = partsN(silence_nan)(ret, s);
+        return partsN(silence_nan)(ret, s);
     }
-    return ret;
+    return *ret;
 
  default_nan:
-    *a = partsN(default_nan)(s);
-    return a;
+    return partsN(default_nan)(s);
 }
 
 /*
@@ -698,7 +699,8 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
      * off to the target-specific pick-a-NaN routine.
      */
     if (unlikely(abc_mask & float_cmask_anynan)) {
-        return partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
+        *a = partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
+        return a;
     }
 
     if (flags & float_muladd_negate_c) {
-- 
2.43.0


