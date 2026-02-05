Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AFFEC1E9D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxMV-00051m-F5; Thu, 05 Feb 2026 06:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLv-0004n5-95
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:55 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLq-0003or-8d
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:48 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c0c24d0f4ceso300130a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770290205; x=1770895005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJXB35quTNKKccj4R3BAhYCyHwYQTOEExEEUQmzJvZE=;
 b=hhlRZpnuP8D26ai4TZLTdaw2W//D6QlTlELrDV+WoFmfmvdiLZxafiCh2I0gmGY54V
 Xa0XV5koLMs2bdrrbRHxAtr/oC9clhvUElQeUH4JcGLG5JEmRcX8rJ5e8PXSNy2JKatL
 eIopFDjf0zH00eFC9EtRXNLkzf3OtYX6IrcJMsZ2cd5IAzBZwiGEgPU9P6XMLcDrwW6/
 bFjBb52Y/6RwAxOMoIp9cuJO8BpegFUnmXbCvv+tAC8leViPFkr9xVYduvBhsrcWsqzf
 0ho7N194ZSq2z6TMpqVYvKyCepQ96hiKFTyC6JgLbkYQgGW4C6Ee//05huwROq/HIclp
 wknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770290205; x=1770895005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uJXB35quTNKKccj4R3BAhYCyHwYQTOEExEEUQmzJvZE=;
 b=Jx8vsdmMpDNE5JobOlUmFzpDUQNGejDvYaMkCcEg5mXfI4UsREU8E5saVe/fkbYuHA
 MNvBayHi+JOjMeEFYttD0wHY9shvrVwfPnr4dRqOSPo4pJUlbP1zTaMSvs+b8USir/qb
 atGaB9/JWl+rm0yzoYmRqnFudQERi2v3JGXYogxetrIDPzGgyHfCHSfh4yDBqcDgoSlh
 WKOjw99K95MndE0BlXwqY0uiM/uzRtxL+XeXdECsgbM6CfluP4KeywVbv+GtR1feS+Rl
 fvq89Rfa8LWKLrL6oXD+SJDhQ3LmEFobOyCGiMDtXTWMoLkCshtVqEg/6Sd83fYaZtfV
 fkEQ==
X-Gm-Message-State: AOJu0Yz7h56fLLdAZgbkMqQb/w4cbgMJNhrtVk4QzqRMBjIWf/vw6VQy
 +FbcEK4yJXDq8a7DbqMsTOBuUAyFbiHdreFhWBLMdza08hGL2VYgQ9nKTU76h6+bSAwN3Zf2nuO
 nBUXKeT7eEg==
X-Gm-Gg: AZuq6aKxI1T8c3FhseXbnf/DuFlJOlCBjyJt5SmtQwZXPh6LdebmAxEcXn8Lu6267GZ
 Y/pCcYrl6HfFhbSFNWG/uRXPH2cLCe2QuyqE/xBN5YQilxiyQQNnsMuNk/t14i0LXMBGgcEHH24
 4SSLl0dThxu5JKyEUZExwm6Y6TWwF0pg9UIsENpYWpoNRYhL4UZwZo7TO2r03M+s4Z+lFHlUMNB
 LC2fzrUa/P0N1Ax3S5qxnV8Doqp8uhYxs3lK5GVez86Q1nF1dKES4rQ7/gxXtkSeY7pyqVSJBBB
 ChyjIoS+DkzKIuwUWod41ORpdZMKGutblVcK3lEhPOSQIUkyN83I7KQvN+PdOeF7mAe6KzZpY7a
 tnSApmGltaYvy4K7vsM2NHBmziqL74eHgLikhI2hTnz5ngafYTqxOgGePs4ipNvJdLbl5FLRB1D
 bu3RERNR55ftis5x4oh/0q
X-Received: by 2002:a17:903:2352:b0:2a7:c340:4c48 with SMTP id
 d9443c01a7336-2a933fb0c72mr61859665ad.32.1770290204598; 
 Thu, 05 Feb 2026 03:16:44 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933851685sm51088435ad.13.2026.02.05.03.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 03:16:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com
Subject: [PATCH v4 7/9] fpu: Add conversion routines for OCP FP8 E5M2
Date: Thu,  5 Feb 2026 21:16:20 +1000
Message-ID: <20260205111622.461497-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205111622.461497-1-richard.henderson@linaro.org>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

From: Max Chou <max.chou@sifive.com>

Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Split out of a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h |  5 ++++
 include/fpu/softfloat.h       |  8 +++++
 fpu/softfloat.c               | 56 +++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 8f82fdfc97..be7e2de6e3 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -119,6 +119,11 @@ typedef struct {
  */
 typedef uint16_t bfloat16;
 
+/*
+ * Open Compute Project (OCP) Microscaling Formats
+ */
+typedef uint8_t float8_e5m2;
+
 /*
  * Software IEC/IEEE floating-point underflow tininess-detection mode.
  */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index ac6a392375..8f80726658 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -189,6 +189,14 @@ float128 int128_to_float128(Int128, float_status *status);
 float128 uint64_to_float128(uint64_t, float_status *status);
 float128 uint128_to_float128(Int128, float_status *status);
 
+/*----------------------------------------------------------------------------
+| OCP FP8 conversion routines.
+*----------------------------------------------------------------------------*/
+
+bfloat16 float8_e5m2_to_bfloat16(float8_e5m2, float_status *status);
+float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, bool sat, float_status *status);
+float8_e5m2 float32_to_float8_e5m2(float32, bool sat, float_status *status);
+
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index a637d28fd3..ed259657d8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -572,6 +572,10 @@ typedef struct {
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
+static const FloatFmt float8_e5m2_params = {
+    FLOAT_PARAMS(5, 2)
+};
+
 static const FloatFmt float16_params = {
     FLOAT_PARAMS(5, 10)
 };
@@ -627,6 +631,11 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
     };
 }
 
+static void QEMU_FLATTEN float8_e5m2_unpack_raw(FloatParts64 *p, float8_e5m2 f)
+{
+    unpack_raw64(p, &float8_e5m2_params, f);
+}
+
 static void QEMU_FLATTEN float16_unpack_raw(FloatParts64 *p, float16 f)
 {
     unpack_raw64(p, &float16_params, f);
@@ -684,6 +693,11 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
+static float8_e5m2 QEMU_FLATTEN float8_e5m2_pack_raw(const FloatParts64 *p)
+{
+    return pack_raw64(p, &float8_e5m2_params);
+}
+
 static float16 QEMU_FLATTEN float16_pack_raw(const FloatParts64 *p)
 {
     return make_float16(pack_raw64(p, &float16_params));
@@ -1675,6 +1689,13 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
+static void float8_e5m2_unpack_canonical(FloatParts64 *p, float8_e5m2 f,
+                                         float_status *s)
+{
+    float8_e5m2_unpack_raw(p, f);
+    parts_canonicalize(p, s, &float8_e5m2_params);
+}
+
 static void float16a_unpack_canonical(FloatParts64 *p, float16 f,
                                       float_status *s, const FloatFmt *params)
 {
@@ -1695,6 +1716,14 @@ static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
     parts_canonicalize(p, s, &bfloat16_params);
 }
 
+static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
+                                                    float_status *s,
+                                                    bool saturate)
+{
+    parts_uncanon(p, s, &float8_e5m2_params, saturate);
+    return float8_e5m2_pack_raw(p);
+}
+
 static float16 float16a_round_pack_canonical(FloatParts64 *p,
                                              float_status *s,
                                              const FloatFmt *params)
@@ -2836,6 +2865,15 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     }
 }
 
+bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float8_e5m2_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return bfloat16_round_pack_canonical(&p, s);
+}
+
 float32 float16_to_float32(float16 a, bool ieee, float_status *s)
 {
     const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
@@ -2856,6 +2894,15 @@ float64 float16_to_float64(float16 a, bool ieee, float_status *s)
     return float64_round_pack_canonical(&p, s);
 }
 
+float8_e5m2 float32_to_float8_e5m2(float32 a, bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    float32_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return float8_e5m2_round_pack_canonical(&p, s, saturate);
+}
+
 float16 float32_to_float16(float32 a, bool ieee, float_status *s)
 {
     FloatParts64 p;
@@ -2923,6 +2970,15 @@ float32 float64_to_float32(float64 a, float_status *s)
     return float32_round_pack_canonical(&p, s);
 }
 
+float8_e5m2 bfloat16_to_float8_e5m2(bfloat16 a, bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    bfloat16_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return float8_e5m2_round_pack_canonical(&p, s, saturate);
+}
+
 float32 bfloat16_to_float32(bfloat16 a, float_status *s)
 {
     FloatParts64 p;
-- 
2.43.0


