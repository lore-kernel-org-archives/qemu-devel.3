Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11187CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72M-0000sy-W9; Thu, 07 May 2026 18:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72K-0000sX-TO
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:41 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72I-0003FI-Fz
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:40 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-42fbf95cca8so1028182fac.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192256; x=1778797056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qpHmtar2AeEUNpLjC+puJZ8I/ID4F4UwiaLMpyjXJYg=;
 b=qA3UGcvt1pxH08QAO4YSe7Ea+8RfVDVVfBEfj8AIOQqBtVSIlPFuVeotHfVi0AZv6T
 cv6eVoIutaujMkHX81wMmOWs8Jrj4SOZ00eMxL9mX7+/Mh1WmzWp183JYGggA07ljICu
 bK2H2cbS6Obyc7rfsn/LgBtCEDfCU3QdtMDD2gx7ODckXEjqL7iRdgHGeds05ZwzReyO
 0np6Ps/mXYsH/XrRYELnGsNpYCGtUo4uv/bIB8qH0c8px35sEweIpQPNUj/hWZMuWH9P
 AjA0gBMFibM62cCJSeJgjOnH20l0iv6e1TNnnOL/V47PNzM4mXZ7kxx2nSIoB9UqPptn
 OvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192256; x=1778797056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qpHmtar2AeEUNpLjC+puJZ8I/ID4F4UwiaLMpyjXJYg=;
 b=NCxvtBO8PsOPzQo0yzxgjaNoF0oPzWXKS6ale4pvRcEpDsuyciAEjIKM/o1dNv2WqF
 UbHwjmlWir+6C1PLZB23sLEsRZAsH0RMwucCTBsqvZn5thxBF1Vpt1KPMZv2YS/+Sfem
 MXCWRJlpbJLROkeLnNBV3nNT/qnKg1QV8X2+55EDCJSNzaJi3zoz0roBLa3iGhZR/EWt
 Aj52FVWf03W3useWbbk2kiD4/ztwm/7Mgvg9PiJaonSh4ORyYz2fpLVTIWhG8L9aJDIY
 FO4excSIdzaWI4Bhncm8Ho+k5V0p5fPsaVUnMSX/SHjZZDYlwBES49rCWH3bUhWTYYfu
 9hKA==
X-Gm-Message-State: AOJu0Yzf1hq+JKZzDLEUXfDc48z+gnhfCURAKIUFF/i9rMpvYqdap1Eu
 K5+MIFbKcnSENnBs3Soe+a8RcbvT21M9CpzwNwr5IUBH0a00EkkJl26+7mqkbAQAXUcbvM+gkc0
 FoGxb
X-Gm-Gg: AeBDiesKdMopC5rVttGDaNGiTI/TTLDXAANMm/r+SgS2cSD9Bn6XVMU4S59TVPFDoxR
 1/dTEh9ugOvYarudCHEqQ9bcW8mFssSDTYi82pTefAbbLPm4jvt5bzxysLIlmSleT5qquRkGePt
 S4HQnsZ7tZv7OO7QuiBLviWQYVehmTmR4DyY2B6xO7Om85W1jKcWx27keTxPNucp2pD+4TPAZPN
 C2dBPh2Gj7TQ3hsK5r3CgV0LelKcg6cX8+chYdR8C014+JDDTGPXiXvCd9Ri/SfJuk9Tv/7igTi
 /LH/E90ihzV36GjewsnRMiPK+ETnctxhsVqMeYLG1TRsOnbf0K4W7mWMZjWhEsXOeOpF7JaVkRU
 jf42n/cMcpqGnr+hNEkCH416Qqe9+QDBpgJMVgtYa2x7sKTHQ6Pv1hEZ/znHyEDWMZhn7y6lJec
 cjC2fMDKjGrUC7tSIkoP0ABU0JOfnMme0KBYLPKtae6y7bUoLs3r1yLsyb
X-Received: by 2002:a05:6870:889d:b0:42d:a405:efe1 with SMTP id
 586e51a60fabf-43556ebb4camr109454fac.22.1778192256224; 
 Thu, 07 May 2026 15:17:36 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/18] fpu: Use accessors for ftz_before_rounding
Date: Thu,  7 May 2026 17:17:12 -0500
Message-ID: <20260507221717.486023-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

Drop FloatFTZDetection and use #defines, like we do for
tininess_before_rounding.  Rename get_float_ftz_detection
to get_ftz_before_rounding and move to softfloat.c, as
there are no external users.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 10 ++--------
 include/fpu/softfloat-types.h   |  8 +++-----
 fpu/softfloat-parts.c.inc       |  5 ++---
 fpu/softfloat-specialize.c.inc  |  5 +++++
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 395ce67abf..d36e3a24b1 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -116,10 +116,9 @@ static inline void set_flush_inputs_to_zero(bool val, float_status *status)
     status->flush_inputs_to_zero = val;
 }
 
-static inline void set_float_ftz_detection(FloatFTZDetection d,
-                                           float_status *status)
+static inline void set_float_ftz_detection(bool val, float_status *status)
 {
-    status->ftz_detection = d;
+    status->ftz_before_rounding = val;
 }
 
 static inline void set_default_nan_mode(bool val, float_status *status)
@@ -198,9 +197,4 @@ static inline FloatSNaNRule get_snan_rule(float_status *status)
     return status->float_snan_rule;
 }
 
-static inline FloatFTZDetection get_float_ftz_detection(const float_status *status)
-{
-    return status->ftz_detection;
-}
-
 #endif /* SOFTFLOAT_HELPERS_H */
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index b8ce8ff78e..b83f67defc 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -341,10 +341,8 @@ typedef enum __attribute__((__packed__)) {
  * configure it matches the default for tininess_before_rounding
  * (i.e. "after rounding").
  */
-typedef enum __attribute__((__packed__)) {
-    float_ftz_after_rounding = 0,
-    float_ftz_before_rounding = 1,
-} FloatFTZDetection;
+#define float_ftz_after_rounding   false
+#define float_ftz_before_rounding  true
 
 /*
  * floatx80 is primarily used by x86 and m68k, and there are
@@ -416,7 +414,7 @@ typedef struct float_status {
     /* should denormalised results go to zero and set output_denormal_flushed? */
     bool flush_to_zero;
     /* do we detect and flush denormal results before or after rounding? */
-    FloatFTZDetection ftz_detection;
+    bool ftz_before_rounding;
     /* should denormalised inputs go to zero and set input_denormal_flushed? */
     bool flush_inputs_to_zero;
     bool default_nan_mode;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index ddef8cc089..22c11171f3 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -421,8 +421,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             p->frac_lo &= ~round_mask;
         }
         fracN(shr)(p, frac_shift);
-    } else if (get_flush_to_zero(s) &&
-               s->ftz_detection == float_ftz_before_rounding) {
+    } else if (get_flush_to_zero(s) && get_ftz_before_rounding(s)) {
         flags |= float_flag_output_denormal_flushed;
         p->cls = float_class_zero;
         exp = 0;
@@ -473,7 +472,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
 
         if (is_tiny) {
             if (get_flush_to_zero(s)) {
-                assert(s->ftz_detection == float_ftz_after_rounding);
+                assert(!get_ftz_before_rounding(s));
                 flags |= float_flag_output_denormal_flushed;
                 p->cls = float_class_zero;
                 exp = 0;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ac3fc85138..bde68aa0ec 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -84,6 +84,11 @@ static inline bool get_tininess_before_rounding(const float_status *status)
     return status->tininess_before_rounding;
 }
 
+static inline bool get_ftz_before_rounding(const float_status *status)
+{
+    return status->ftz_before_rounding;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
-- 
2.43.0


