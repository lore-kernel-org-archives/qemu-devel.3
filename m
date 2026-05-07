Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340BDCD37AA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72G-0000rB-LV; Thu, 07 May 2026 18:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72E-0000pn-85
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:34 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72B-0003D1-Lf
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:33 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40ede943bf0so1070383fac.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192249; x=1778797049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g3dJawXa8mZF25lb4548tyk5sXY0Sa8giHPPus3KxDI=;
 b=aMNBDDE+9dJ6V6ZMyUM1ZwVSLdDXmjZFRGRPzHhcgNGx9Sd/+Bcv10vXnRbACCL2lv
 M7U0M0vbI7HMIETgli1JibjNxAPgfEzDnF5TVp17Wb9q81of8f9F+1TTJRhtqiZ2CwTP
 nCvJqT5yL++nQ3k1weopZoOQgWduXW0NAcCPWoKp4sqi315saO8rCcR2I6L34xjkb649
 br1twcm69p6S89JN9QFWrzSdTq1yo4s8kND8wu+y8gkcPvHdPAh/ZSG6W9i2OUwepTEb
 beP04P8zKHEkljj9ALHdsz6+39XAZJ/uN/2c0MsBOKwlShbaDsQjUb9g63e4eEDI6LgJ
 5t1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192249; x=1778797049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g3dJawXa8mZF25lb4548tyk5sXY0Sa8giHPPus3KxDI=;
 b=T74yCgyeSrkz9C8/LIksgH3V2ykvsM7FqpM2yAPQ1rUdTCoXl2TYG1CfdXUImPFaqp
 WMfX3GIMXyEhF/YxhT4r79f7S/gCDuekSjmzs4xsiUurzy2xBkFTfQhUzqBGvCM5rsu6
 zAzqhpo3/WBXX3VESgQoMDJRhguRclJLRIQ7VxpmrBq7V00D1+ikS5chpCgmimrPRjGE
 NVQeJcZIcHWTR+rsHtdHAJ9D5k+qVma5GTVm9JMqGl6mxLsvVS6PPj9Xo2+5CyKV/UpX
 j/I/OP0+fIYzyYPPO9vv07QnL2cc17i4eCjMbUe130+9Da/zTOAyWQLAGs6liIEya5yj
 wrLQ==
X-Gm-Message-State: AOJu0YwscHQ3JDr2tEg3sWEQm8Bk1wW/pAi8/1hGc3ihw3G2cSD0tLJI
 fexL5i0NPjkJeLTaVXbQPq8VnJvTZIN+aP8uCiTcC8kT5CmA+/QsJXue6D7QVolRk7QlkSRqqK0
 p4Q/E
X-Gm-Gg: AeBDies78HtDA8enIj3x8lkrdBti9ZtTwRGyoRG07F7uRmC3O4OXALz577nn54n3SfA
 rEKFNsqFSA3CjhNuSi748ex+uF54pO2WOQtbfmMmrwGPVnXjaf890vmrPQh1HCv2Nf4yvCPNj4S
 X/vmDIBrw+EY4Zgk3Uj+oRBGGvFz2DGLHv97JlG15BNgrcOkyK7SqNRZMImLLfKHpp/bmtGBrVY
 PDuMnDuVIIEy/TLRbr1m/gE0D12I6cLxu39fr2soR3EFCqUYNAIgi5W1S8G9ZsWxppgk4Z/T/1k
 42raf9RFiHYOm1NGXO4FRTCA//7MmRj17rFoU3SdOHSRw9cLrVYg3USjIPocRj8un2AQUIxNBSj
 SBTue2fa99QuKB9dPyWxDPSTGRQRvH80V6LD+tW4At6gHXo2dMXllfG907+jfw7s8fb1r0a7q9E
 25bc8Ixit9jOM6WjxI82ChD8nqkcPmnP+jUn61ZGYkoN/J4Q==
X-Received: by 2002:a05:6871:28a0:b0:417:5a8c:feba with SMTP id
 586e51a60fabf-434f5866e4bmr6679257fac.12.1778192249256; 
 Thu, 07 May 2026 15:17:29 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/18] fpu: Use get_floatx80_behaviour everywhere
Date: Thu,  7 May 2026 17:17:06 -0500
Message-ID: <20260507221717.486023-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h        | 10 ++++++----
 fpu/softfloat.c                |  2 +-
 fpu/softfloat-parts.c.inc      |  4 ++--
 fpu/softfloat-specialize.c.inc |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 4ae4ddc799..e08d1c374d 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -1018,7 +1018,7 @@ static inline bool floatx80_is_infinity(floatx80 a, float_status *status)
     bool intbit = a.low >> 63;
 
     if (!intbit &&
-        !(status->floatx80_behaviour & floatx80_pseudo_inf_valid)) {
+        !(get_floatx80_behaviour(status) & floatx80_pseudo_inf_valid)) {
         return false;
     }
     return (a.high & 0x7fff) == 0x7fff && !(a.low << 1);
@@ -1112,6 +1112,8 @@ static inline bool floatx80_unordered_quiet(floatx80 a, floatx80 b,
 *----------------------------------------------------------------------------*/
 static inline bool floatx80_invalid_encoding(floatx80 a, float_status *s)
 {
+    FloatX80Behaviour rule = get_floatx80_behaviour(s);
+
     if ((a.low >> 63) || (a.high & 0x7fff) == 0) {
         /* Anything with the Integer bit set or the exponent 0 is valid */
         return false;
@@ -1119,12 +1121,12 @@ static inline bool floatx80_invalid_encoding(floatx80 a, float_status *s)
 
     if ((a.high & 0x7fff) == 0x7fff) {
         if (a.low) {
-            return !(s->floatx80_behaviour & floatx80_pseudo_nan_valid);
+            return !(rule & floatx80_pseudo_nan_valid);
         } else {
-            return !(s->floatx80_behaviour & floatx80_pseudo_inf_valid);
+            return !(rule & floatx80_pseudo_inf_valid);
         }
     } else {
-        return !(s->floatx80_behaviour & floatx80_unnormal_valid);
+        return !(rule & floatx80_unnormal_valid);
     }
 }
 
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 11ab26c7f6..1be90c9c7c 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1566,7 +1566,7 @@ floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s)
 
     case float_class_inf:
         /* x86 and m68k differ in the setting of the integer bit. */
-        frac = s->floatx80_behaviour & floatx80_default_inf_int_bit_is_zero ?
+        frac = get_floatx80_behaviour(s) & floatx80_default_inf_int_bit_is_zero ?
             0 : (1ULL << 63);
         exp = fmt->exp_max;
         break;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index ab9445ade8..0406a38206 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -213,7 +213,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
      * how we uncanonicalize results.
      */
     bool has_pseudo_denormals = fmt->has_explicit_bit &&
-        (status->floatx80_behaviour & floatx80_pseudo_denormal_valid);
+        (get_floatx80_behaviour(status) & floatx80_pseudo_denormal_valid);
 
     if (unlikely(p->exp == 0)) {
         if (likely(fracN(eqz)(p))) {
@@ -430,7 +430,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
     } else {
         bool is_tiny = s->tininess_before_rounding || exp < 0;
         bool has_pseudo_denormals = fmt->has_explicit_bit &&
-            (s->floatx80_behaviour & floatx80_pseudo_denormal_valid);
+            (get_floatx80_behaviour(s) & floatx80_pseudo_denormal_valid);
 
         if (!is_tiny) {
             FloatPartsN discard;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 29a2fdeb9b..91250bc5a1 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -223,7 +223,7 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
      * Whether the Integer bit is set in the default Infinity is
      * target dependent.
      */
-    bool z = status->floatx80_behaviour & floatx80_default_inf_int_bit_is_zero;
+    bool z = get_floatx80_behaviour(status) & floatx80_default_inf_int_bit_is_zero;
     return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
 }
 
-- 
2.43.0


