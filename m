Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D97CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUb1-0004pC-PD; Fri, 22 May 2026 14:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb0-0004mE-0t
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:42 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUay-0005Py-6L
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:41 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b458ca2296so56004995ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474458; x=1780079258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yj7ZvwjIiBB1Rcal6z5w1HZi23h74lNdQA/PCnqvLXY=;
 b=SU/MGwSkzI6kgm1eL8DItIQTSB8tQxKxe8vFUHKp6ZPYikhmQ7qy7LwWofoLHlnlqy
 Bgf8ouJZoNvRTGeFAQ5+u6uowuLduRvl7zhZbRjo5j0advWyQkhSoQ8QZLMJCx9rwCbU
 ktCesw+rHvvW8lvwyeEGQ0mGvrprso2dOK8ZJvn7iy/R+b9jaYuqxmIxBgtXlgQgwojD
 JEL9oytnRnofe2s3qR1snuWlqKRE35CIOKERG5wU02Vn3k3zy6/DdGsLYkKb6lZipvw/
 1YoINZdPt9njEUzq41EnM4yIWE7SdzsII4INhjbiMb39tdGaYTN0EKH2AoPrBdbIhYeD
 5bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474458; x=1780079258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yj7ZvwjIiBB1Rcal6z5w1HZi23h74lNdQA/PCnqvLXY=;
 b=l6lTbM1NSFyDQMtpmq30P7h0ggALQqo7YroLK1BTvDnKYglsV5Ze84HchTQZmY/CFd
 W8WyfDSSwoPbpRgttIrMKnuB776KaSh1hq6tP1qnU5K1nQA10Fzj4ilrbD2tGRTzk7O7
 RoZH1HjKLgxZFyFDwbBMR3PQfHZgEXuVNieuu62lPtbQB5U72y/vSdLV7tse9jnyz33j
 6dLy1Q5qRM7v2KawWEV5JqJRPLKDt0MP6qzsbt1wnSsBFmHxRHZ63eNjf6pWd61CxOPp
 04t6l9KYxwTMEuEzo94VJS8dkCObTtifgUMQ/5A+Q1zz0yaMTdJCJ79V/ugkQkrfSN/F
 VlBA==
X-Gm-Message-State: AOJu0YzvYiHCnMMkqWlubwoU4P5kPbjkfMWeQ0f70hIKDTczwBpxlw6S
 70+Wyfxath0ua9jYe4iW2JHoHRZ2dra/ykWbHN09vBi+LocNfj68sWNUKwmNIHgRE2VcPx+WvAA
 +lTdf
X-Gm-Gg: Acq92OFINsIqCtgQrKvmuYGET7vtcM1y0b440y755XrrzwUIitbzQFtWRoPD1XneqDr
 I8OPazLpJUS9b31KHNUdFnLrS7BbX11ozcKk6zlfBCAX/xP0JfzC1mh373/37pjd0+kQ7Jz9GJP
 VFxYRLhiVaQzXAu+FbPgfHleVylSyHbCdJn71dLds8QTwToA1kNs1BRMG8BDC4JTLCR9CqduOsn
 8bdMqeyoG67mSerqmBsz5bnlPxOK57qCviscFHJ8KaIv44JZKFeb0zWlVPrAP+3wt5AvB4Uj2Fj
 dV2vaxqYs35GrEU5BUYWq07aremJHpYF1LXodmaGke8OpwhqyEKtSzjrKk9mqIwpvaQNRlQJGwk
 SK48FehiJp3xqfsKExGbTAIyOQeHnPA5t+fOPw5V+YTpOZIiqA99IbMZy95rjb9bnhOXq3qdsqv
 Qtn5PdKfJiPDzq4rfb+CT+K00dMejx
X-Received: by 2002:a17:903:2ece:b0:2bd:93b0:2c1c with SMTP id
 d9443c01a7336-2beb0347067mr57338955ad.3.1779474458446; 
 Fri, 22 May 2026 11:27:38 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/30] fpu: Introduce frac_msb_is_snan
Date: Fri, 22 May 2026 11:26:40 -0700
Message-ID: <20260522182658.184604-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Unify handling of the two snan parameters, letting the
caller simply extract the msb.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.c.inc | 45 ++++++++++------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 485f082cf8..e2e3ec0e81 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -104,16 +104,21 @@ static inline bool snan_bit_is_one(float_status *status)
 | if the fraction represents a signalling NaN; otherwise false.
 *----------------------------------------------------------------------------*/
 
-static bool parts_is_snan_frac(uint64_t frac, float_status *status)
+static bool frac_msb_is_snan(bool msb, float_status *status)
 {
     if (no_signaling_nans(status)) {
         return false;
     } else {
-        bool msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
         return msb == snan_bit_is_one(status);
     }
 }
 
+static bool parts_is_snan_frac(uint64_t frac, float_status *status)
+{
+    bool msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
+    return frac_msb_is_snan(msb, status);
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated deconstructed floating-point NaN.
 *----------------------------------------------------------------------------*/
@@ -238,11 +243,7 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
 
 static bool float16_nan_is_snan(float16 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 9) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 9) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -271,11 +272,7 @@ bool float16_is_signaling_nan(float16 a_, float_status *status)
 
 static bool bfloat16_nan_is_snan(bfloat16 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 6) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 6) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -302,11 +299,7 @@ bool bfloat16_is_signaling_nan(bfloat16 a_, float_status *status)
 
 static bool float32_nan_is_snan(float32 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 22) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 22) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -335,11 +328,7 @@ bool float32_is_signaling_nan(float32 a_, float_status *status)
 
 static bool float64_nan_is_snan(float64 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a >> 51) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a >> 51) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -370,11 +359,7 @@ bool float64_is_signaling_nan(float64 a_, float_status *status)
 
 static bool floatx80_nan_is_snan(floatx80 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a.low >> 62) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a.low >> 62) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -416,11 +401,7 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 
 static bool float128_nan_is_snan(float128 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return false;
-    }
-    bool frac_msb_is_one = (a.high >> 47) & 1;
-    return frac_msb_is_one == snan_bit_is_one(status);
+    return frac_msb_is_snan((a.high >> 47) & 1, status);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.43.0


