Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99CDCD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EO-0004YK-QW; Thu, 07 May 2026 12:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EM-0004WM-Al
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:42 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EH-0006no-QN
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:41 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d55b97f358so731800a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169936; x=1778774736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9NIBqC31A4OjSJin8CmB0abmvY9abicKktilbl2T5w=;
 b=BXwxfak5cMctoaW56VQ1lqovqckuk2WpgoyTFvCFa8C5Hp+/F2QhzdXD0BROHz5qvz
 rU0HNRzDDHcpNviY4ZHjhJjoBvMB3SoVHA0SXZHB6C3d1Sg96uj6CJAgKfWfdSsGsCu9
 WQ5E7/Qd5B9DZyDa4nuL/gvT1mw7C+tqaAtlTCBSX4yt1rZSBekOHMeE6jhBdNawtaM5
 EgxvG/WgFvqYHMmy0W8LUHr7aa0RjRuHwQQY8V+4eL4i+vkxw1QA/WoynfD/kcfT8Zl2
 voWG6kLxKYNonW0JxKPAe7T3Rnu7fuxqbAlsuXyNsr1OOWptHtRPuyhlZ+rXvZLH0CYC
 4Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169936; x=1778774736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a9NIBqC31A4OjSJin8CmB0abmvY9abicKktilbl2T5w=;
 b=fnvwqLgeTvT4wqmAAlKhbEVW0BPbycuWKnEQbLawFYcZIuPsh2C7eCLiewM1nsVh4i
 SlDbVIu6AJmdItH54C5ef+oTnt1jV2xbYqJZlrysUcWn2pXA8alLHrLuM0LuUa8C5gK4
 zzLjLGmlfoFs0iqn4KJfdH8bbqA/1X4TaORcJekt4lZW34Am2pPI13BXzhWeaj7pbm0A
 DUFlqQaqXoFkFO5A8ENv/YUwL2kNkqxmx5pjVpNHkXIagAth5sGxMMr/0koTua/eaBQy
 WFl6/JzT3FQjDuGZ4881olVuK5eL8eLOGS2hilTpXpTe1G7KKFXxZAbuZ4ELaKHiE7ZV
 rCfA==
X-Gm-Message-State: AOJu0YzuwrOo0k2NlZGNnyOMOTr9Zgqpx+EZ241Jb1SPCemeM7RxYD7T
 2k0+IRDnRRowkodbuX9wWevrst09tcIv80HOJvVp8Rl5JlocbwJgtLz1QoohDjfwYIgxgkkMJx8
 HPC3W
X-Gm-Gg: AeBDietX79bYIX0gYVcmTf83+E3r0+ww+QxKMzW/ib9deOC1vaGEBgGH86Z+4gi4+5v
 wn2s5mk44CD7JE4uZcBx2uow2qN+DN7/pvA2Phu5lRZQYiixVGGiSr4BrMX1HC5Tn5Wgake2fIH
 aaerBQl1n1Y3p5Gs6HSOfD7/Gs6TwSXYZAvem0Uj6ZHEzO221bXccPVjUKRm2EGWRucCNtIhbiH
 1blzNahy7St8fDaSkAwids9ueXON8KTo6VsBTxEZgo6O+hVOmPSLeGVbSjgY/rUi68RvVOT1dvB
 iiLFZSPQ5IE2VbhlR1n0GLfzOLpeATrnItNVwzRKCbWmjMH9PO23vksAFPexLZhPZ1ObvcsNBnp
 veMLASWAjxguM2dWvLr3TVPRbtQgKtafFE7jw/ic211SsAVtt1tawQxSm6Zb03mW56QzPbTSYeK
 Nn7TS1YbTHM2msB13bn4APmflhYcrHQRhteVDoljw/oiCqnx3v03PZ1pZ7
X-Received: by 2002:a05:6830:2117:b0:7dc:cb67:cb57 with SMTP id
 46e09a7af769-7e1df071227mr5421195a34.16.1778169935341; 
 Thu, 07 May 2026 09:05:35 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/29] fpu: Return struct from parts{64,128}_default_nan
Date: Thu,  7 May 2026 11:05:00 -0500
Message-ID: <20260507160518.444797-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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
 fpu/softfloat.c                | 29 ++++++++++++-----------------
 fpu/softfloat-parts.c.inc      | 22 +++++++++++-----------
 fpu/softfloat-specialize.c.inc | 22 ++++++++++------------
 3 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b857c13d91..fa8913a288 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2678,7 +2678,7 @@ float32 floatx80_to_float32(floatx80 a, float_status *s)
     if (floatx80_unpack_canonical(&p128, a, s)) {
         p64 = parts128_to_parts64(&p128, s);
     } else {
-        parts64_default_nan(&p64, s);
+        p64 = parts64_default_nan(s);
     }
     return float32_round_pack_canonical(&p64, s);
 }
@@ -2691,7 +2691,7 @@ float64 floatx80_to_float64(floatx80 a, float_status *s)
     if (floatx80_unpack_canonical(&p128, a, s)) {
         p64 = parts128_to_parts64(&p128, s);
     } else {
-        parts64_default_nan(&p64, s);
+        p64 = parts64_default_nan(s);
     }
     return float64_round_pack_canonical(&p64, s);
 }
@@ -2703,7 +2703,7 @@ float128 floatx80_to_float128(floatx80 a, float_status *s)
     if (floatx80_unpack_canonical(&p, a, s)) {
         parts128_float_to_float(&p, s);
     } else {
-        parts128_default_nan(&p, s);
+        p = parts128_default_nan(s);
     }
     return float128_round_pack_canonical(&p, s);
 }
@@ -2964,7 +2964,7 @@ static int32_t floatx80_to_int32_scalbn(floatx80 a, FloatRoundMode rmode,
     FloatParts128 p;
 
     if (!floatx80_unpack_canonical(&p, a, s)) {
-        parts128_default_nan(&p, s);
+        p = parts128_default_nan(s);
     }
     return parts128_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
@@ -2975,7 +2975,7 @@ static int64_t floatx80_to_int64_scalbn(floatx80 a, FloatRoundMode rmode,
     FloatParts128 p;
 
     if (!floatx80_unpack_canonical(&p, a, s)) {
-        parts128_default_nan(&p, s);
+        p = parts128_default_nan(s);
     }
     return parts128_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
@@ -4562,7 +4562,7 @@ static void parts64_log2(FloatParts64 *a, float_status *s, const FloatFmt *fmt)
 
  d_nan:
     float_raise(float_flag_invalid, s);
-    parts64_default_nan(a, s);
+    *a = parts64_default_nan(s);
 }
 
 float32 float32_log2(float32 a, float_status *status)
@@ -4587,45 +4587,40 @@ float64 float64_log2(float64 a, float_status *status)
 
 float16 float16_default_nan(float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = parts64_default_nan(status);
 
-    parts64_default_nan(&p, status);
     p.frac >>= float16_params.frac_shift;
     return pack_raw64(&p, &float16_params);
 }
 
 float32 float32_default_nan(float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = parts64_default_nan(status);
 
-    parts64_default_nan(&p, status);
     p.frac >>= float32_params.frac_shift;
     return pack_raw64(&p, &float32_params);
 }
 
 float64 float64_default_nan(float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = parts64_default_nan(status);
 
-    parts64_default_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
     return pack_raw64(&p, &float64_params);
 }
 
 float128 float128_default_nan(float_status *status)
 {
-    FloatParts128 p;
+    FloatParts128 p = parts128_default_nan(status);
 
-    parts128_default_nan(&p, status);
     frac128_shr(&p, float128_params.frac_shift);
     return float128_pack_raw(&p);
 }
 
 bfloat16 bfloat16_default_nan(float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = parts64_default_nan(status);
 
-    parts64_default_nan(&p, status);
     p.frac >>= bfloat16_params.frac_shift;
     return pack_raw64(&p, &bfloat16_params);
 }
@@ -5131,7 +5126,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         *n = *r;
         *cc = 1;
     } else if (a->cls == float_class_inf || b->cls == float_class_zero) {
-        parts64_default_nan(r, status);
+        *r = parts64_default_nan(status);
         *n = *r;
         *cc = 1;
         status->float_exception_flags |= float_flag_invalid;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5d344f9afe..ed7080d886 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -21,14 +21,14 @@ static void partsN(return_nan)(FloatPartsN *a, float_status *s)
     case float_class_snan:
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
         if (s->default_nan_mode) {
-            partsN(default_nan)(a, s);
+            *a = partsN(default_nan)(s);
         } else {
             partsN(silence_nan)(a, s);
         }
         break;
     case float_class_qnan:
         if (s->default_nan_mode) {
-            partsN(default_nan)(a, s);
+            *a = partsN(default_nan)(s);
         }
         break;
     default:
@@ -49,7 +49,7 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (s->default_nan_mode) {
-        partsN(default_nan)(a, s);
+        *a = partsN(default_nan)(s);
         return a;
     }
 
@@ -184,7 +184,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     return ret;
 
  default_nan:
-    partsN(default_nan)(a, s);
+    *a = partsN(default_nan)(s);
     return a;
 }
 
@@ -281,7 +281,7 @@ static void partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
         p->exp = fmt->exp_max;
         p->frac_hi = E4M3_NORMAL_FRAC_MAX;
     } else {
-        partsN(default_nan)(p, s);
+        *p = partsN(default_nan)(s);
     }
 }
 
@@ -568,7 +568,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
             }
             /* Inf - Inf */
             float_raise(float_flag_invalid | float_flag_invalid_isi, s);
-            partsN(default_nan)(a, s);
+            *a = partsN(default_nan)(s);
             return a;
         }
     } else {
@@ -641,7 +641,7 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     /* Inf * Zero == NaN */
     if (unlikely(ab_mask == float_cmask_infzero)) {
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
-        partsN(default_nan)(a, s);
+        *a = partsN(default_nan)(s);
         return a;
     }
 
@@ -796,7 +796,7 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
     goto finish_sign;
 
  d_nan:
-    partsN(default_nan)(a, s);
+    *a = partsN(default_nan)(s);
     return a;
 }
 
@@ -864,7 +864,7 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
     return a;
 
  d_nan:
-    partsN(default_nan)(a, s);
+    *a = partsN(default_nan)(s);
     return a;
 }
 
@@ -896,7 +896,7 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
     /* Inf % N; N % 0 */
     if (a->cls == float_class_inf || b->cls == float_class_zero) {
         float_raise(float_flag_invalid, s);
-        partsN(default_nan)(a, s);
+        *a = partsN(default_nan)(s);
         return a;
     }
 
@@ -1118,7 +1118,7 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
 
  d_nan:
     float_raise(float_flag_invalid | float_flag_invalid_sqrt, status);
-    partsN(default_nan)(a, status);
+    *a = partsN(default_nan)(status);
 }
 
 /*
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 9ed968c79b..dd65432813 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -118,7 +118,7 @@ static bool parts_is_snan_frac(uint64_t frac, float_status *status)
 | The pattern for a default generated deconstructed floating-point NaN.
 *----------------------------------------------------------------------------*/
 
-static void parts64_default_nan(FloatParts64 *p, float_status *status)
+static FloatParts64 parts64_default_nan(float_status *status)
 {
     bool sign = 0;
     uint64_t frac;
@@ -134,7 +134,7 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     frac = deposit64(0, DECOMPOSED_BINARY_POINT - 7, 7, dnan_pattern);
     frac = deposit64(frac, 0, DECOMPOSED_BINARY_POINT - 7, -(dnan_pattern & 1));
 
-    *p = (FloatParts64) {
+    return (FloatParts64) {
         .cls = float_class_qnan,
         .sign = sign,
         .exp = INT_MAX,
@@ -142,17 +142,16 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     };
 }
 
-static void parts128_default_nan(FloatParts128 *p, float_status *status)
+static FloatParts128 parts128_default_nan(float_status *status)
 {
     /*
      * Extrapolate from the choices made by parts64_default_nan to fill
      * in the quad-floating format.  If the low bit is set, assume we
      * want to set all non-snan bits.
      */
-    FloatParts64 p64;
-    parts64_default_nan(&p64, status);
+    FloatParts64 p64 = parts64_default_nan(status);
 
-    *p = (FloatParts128) {
+    return (FloatParts128) {
         .cls = float_class_qnan,
         .sign = p64.sign,
         .exp = INT_MAX,
@@ -197,19 +196,18 @@ static void parts128_silence_nan(FloatParts128 *p, float_status *status)
 *----------------------------------------------------------------------------*/
 floatx80 floatx80_default_nan(float_status *status)
 {
-    floatx80 r;
     /*
      * Extrapolate from the choices made by parts64_default_nan to fill
      * in the floatx80 format. We assume that floatx80's explicit
      * integer bit is always set (this is true for i386 and m68k,
      * which are the only real users of this format).
      */
-    FloatParts64 p64;
-    parts64_default_nan(&p64, status);
+    FloatParts64 p64 = parts64_default_nan(status);
 
-    r.high = 0x7FFF | (p64.sign << 15);
-    r.low = (1ULL << DECOMPOSED_BINARY_POINT) | p64.frac;
-    return r;
+    return (floatx80) {
+        .high = 0x7FFF | (p64.sign << 15),
+        .low = (1ULL << DECOMPOSED_BINARY_POINT) | p64.frac,
+    };
 }
 
 /*----------------------------------------------------------------------------
-- 
2.43.0


