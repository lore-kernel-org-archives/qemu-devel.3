Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF70CC021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzKG-0000lp-0i; Tue, 25 Feb 2025 13:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJI-0008OJ-En
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:38 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJE-0002EO-7R
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:36 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-439846bc7eeso37887645e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506729; x=1741111529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UyVluIUiXC9e1nybV7JnEyde0uqtuYfTQXqF3CZ1WlA=;
 b=Pe2Eqr8eMRce4slhWm0iFHSsjzvRgQJCYblBJMh1ORfrCh0S7+qP0fgD+7EWKuri6K
 Tyy1niaqR1FpvfhyCRT/Hv3U8U3wJyy2foMmTEtCYyf+WG4Nn3VQ0/AkHuxKWIyxtxWe
 +7GgHOEC3ki6T8r7QhQYYndCSBRM9hJc7bLnrwlJUyWqvageZdelJJyj5583IrFY0hRf
 798syTsSpHtkEuRD0vMNV/r0WtGEG6AjqNtMF0JgH/B4vdt1MC3h6qD4nQdnntroNPX+
 qVxtd0Nmbtr+11+YXhqDkghM+hlHOWEkKrMEqY5DZ5pXyXrAXbSX2QnhRll0gndxlqiz
 XdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506729; x=1741111529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyVluIUiXC9e1nybV7JnEyde0uqtuYfTQXqF3CZ1WlA=;
 b=VzJbMJMdBcZkYWKj7jB7orbuJ8uz+AhwpyjANf4qPVTLSk3ppbGdPYHF1dxI1FUMc8
 3iqUNNGGqEIN/i6+YqIHw/ffxfwk7v7DF5AwXlpB97ZyV2lXbYZPzX4CWL6Cs/6Tsfsr
 ZmTUBqnJvbePLpSIgRcK/aZi3UyoZasgiIcFXUuQg+h7vw1MCHs1EyFDOsNxUodfmAZe
 wn/6JmLVryzFPmKGcwKm3KJ9S5f0IlZ5lrNmcEE2e6OSUmjF/qOWq7kO3mzvN4YoEX6a
 DL31Bw41HsPh1w2mJvPsQVBXHtFhmGh6rAoRjWDhmEUcxh7hlHtgNGSdmKlXN/jT1PNI
 yWCg==
X-Gm-Message-State: AOJu0YyMyCbsf8jJrLU1zs5L+uRUJx8gg9WZMFcQ3nESstvlKeC9+8ZY
 aW/kYvEuTWbEkoxoI2gdd1xevvCt+Xe72ZQSEZf7qyyYDiw55h2B0+IhWI4Ae7NS0idrmQ7P7k0
 7
X-Gm-Gg: ASbGncs5tx/yP+YBOGqxuQ2kjV5WjAM4p19fbLBYkSqm4I2JvhMtFMCjEsipZ1FZqhJ
 CaTg6VSB1EbCUChDwH5lZi4L+a6q+2xje1wpk3eN/iv3BW/eNjIAXqufeog5Bo7XbmrR2KX0NbX
 4TkRgGfKuq/kdc8GfOseVuTkytJyMQ3xjC6mSveenCNfwi/A5ePGet5efZFO/HYjeu1q8vBRhEp
 m2/SZCgjuNYDGdOTTAkHE1d3i+q5U4+Jq3pSBqbewvFK9IbQlaHFaWmToESBuJF5ook5hAe8MXY
 WjvQwc874eJ/L3kwuY2bamKGTmwq/9g6
X-Google-Smtp-Source: AGHT+IHW4pVTwkJTaPLxojq0VYINPbzkFIMR9xhfkdcoHzS8xaLJ0w0V9MY8t1Swf6iOD9l4p9t7sQ==
X-Received: by 2002:a05:600c:524f:b0:439:96b2:e8f with SMTP id
 5b1f17b1804b1-43ab902b47cmr4198805e9.28.1740506729529; 
 Tue, 25 Feb 2025 10:05:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/43] fpu: Pass float_status to floatx80_invalid_encoding()
Date: Tue, 25 Feb 2025 18:04:40 +0000
Message-ID: <20250225180510.1318207-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The definition of which floatx80 encodings are invalid is
target-specific.  Currently we handle this with an ifdef, but we
would like to defer this decision to runtime.  In preparation, pass a
float_status argument to floatx80_invalid_encoding().

We will change the implementation from ifdef to looking at
the status argument in the following commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250224111524.1101196-7-peter.maydell@linaro.org
---
 include/fpu/softfloat.h      |  2 +-
 fpu/softfloat.c              |  2 +-
 target/i386/tcg/fpu_helper.c | 24 +++++++++++++-----------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 07259c59303..1c8f3cbb78d 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -1081,7 +1081,7 @@ static inline bool floatx80_unordered_quiet(floatx80 a, floatx80 b,
 | pseudo-denormals, which must still be correctly handled as inputs even
 | if they are never generated as outputs.
 *----------------------------------------------------------------------------*/
-static inline bool floatx80_invalid_encoding(floatx80 a)
+static inline bool floatx80_invalid_encoding(floatx80 a, float_status *s)
 {
 #if defined(TARGET_M68K)
     /*-------------------------------------------------------------------------
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b12ad2b42a9..2a20ae871eb 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1810,7 +1810,7 @@ static bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f,
         g_assert_not_reached();
     }
 
-    if (unlikely(floatx80_invalid_encoding(f))) {
+    if (unlikely(floatx80_invalid_encoding(f, s))) {
         float_raise(float_flag_invalid, s);
         return false;
     }
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 3b79bc049d1..4858ae9a5fb 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1141,7 +1141,7 @@ void helper_f2xm1(CPUX86State *env)
     int32_t exp = extractFloatx80Exp(ST0);
     bool sign = extractFloatx80Sign(ST0);
 
-    if (floatx80_invalid_encoding(ST0)) {
+    if (floatx80_invalid_encoding(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST0 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
@@ -1383,8 +1383,8 @@ void helper_fpatan(CPUX86State *env)
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0) ||
-               floatx80_invalid_encoding(ST1)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+               floatx80_invalid_encoding(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
@@ -1819,7 +1819,7 @@ void helper_fxtract(CPUX86State *env)
                            &env->fp_status);
         fpush(env);
         ST0 = temp.d;
-    } else if (floatx80_invalid_encoding(ST0)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST0 = floatx80_default_nan(&env->fp_status);
         fpush(env);
@@ -1870,7 +1870,8 @@ static void helper_fprem_common(CPUX86State *env, bool mod)
     env->fpus &= ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
     if (floatx80_is_zero(ST0) || floatx80_is_zero(ST1) ||
         exp0 == 0x7fff || exp1 == 0x7fff ||
-        floatx80_invalid_encoding(ST0) || floatx80_invalid_encoding(ST1)) {
+        floatx80_invalid_encoding(ST0, &env->fp_status) ||
+        floatx80_invalid_encoding(ST1, &env->fp_status)) {
         ST0 = floatx80_modrem(ST0, ST1, mod, &quotient, &env->fp_status);
     } else {
         if (exp0 == 0) {
@@ -2066,8 +2067,8 @@ void helper_fyl2xp1(CPUX86State *env)
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0) ||
-               floatx80_invalid_encoding(ST1)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+               floatx80_invalid_encoding(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
@@ -2164,8 +2165,8 @@ void helper_fyl2x(CPUX86State *env)
     } else if (floatx80_is_signaling_nan(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_silence_nan(ST1, &env->fp_status);
-    } else if (floatx80_invalid_encoding(ST0) ||
-               floatx80_invalid_encoding(ST1)) {
+    } else if (floatx80_invalid_encoding(ST0, &env->fp_status) ||
+               floatx80_invalid_encoding(ST1, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST1 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST0)) {
@@ -2331,7 +2332,8 @@ void helper_frndint(CPUX86State *env)
 void helper_fscale(CPUX86State *env)
 {
     uint8_t old_flags = save_exception_flags(env);
-    if (floatx80_invalid_encoding(ST1) || floatx80_invalid_encoding(ST0)) {
+    if (floatx80_invalid_encoding(ST1, &env->fp_status) ||
+        floatx80_invalid_encoding(ST0, &env->fp_status)) {
         float_raise(float_flag_invalid, &env->fp_status);
         ST0 = floatx80_default_nan(&env->fp_status);
     } else if (floatx80_is_any_nan(ST1)) {
@@ -2344,7 +2346,7 @@ void helper_fscale(CPUX86State *env)
             ST0 = floatx80_silence_nan(ST0, &env->fp_status);
         }
     } else if (floatx80_is_infinity(ST1, &env->fp_status) &&
-               !floatx80_invalid_encoding(ST0) &&
+               !floatx80_invalid_encoding(ST0, &env->fp_status) &&
                !floatx80_is_any_nan(ST0)) {
         if (floatx80_is_neg(ST1)) {
             if (floatx80_is_infinity(ST0, &env->fp_status)) {
-- 
2.43.0


