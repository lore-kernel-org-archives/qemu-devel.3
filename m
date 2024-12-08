Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD4FE77180
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5K-0007CE-2f; Sun, 08 Dec 2024 17:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5I-0007Bf-6c
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:04 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5G-0006FP-CL
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:03 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71de02b24cfso556544a34.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698141; x=1734302941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGOhDzFLCzjFgB27D8KK9B/lmY6KkRy+JNT0PTFURDw=;
 b=UkVUnHfVVWKXJjd1bfo3bnUhj5vW9bfVtalLF+RyqVCq2jQJcK9ZQSeNI3IGUixfQn
 lhxEw6SJtH08GrKvODrXxS+v1i7B2+RSQKfZgOJZ//0qxneRB8hH0bjFfPVAStokd8uc
 0oT6A4GEHpOiIYjUpgUmgBXM+JZu4O7wiauAO4VE1HfgWR1nlYvHv0Z8tUVoGE9UZRWB
 D8A0hHhdTgCTlowELHDi7fSlzSTmDeEo39B7jE6zpkvttqUeTNrvjBTRIccxKdvdZTzb
 i5eKsVWMwsdfAQDphIzGjG+itJ87jsbu4LD32D6jlllIcgO2A5Mtv6dNgxQrgcd/CeGs
 Boww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698141; x=1734302941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGOhDzFLCzjFgB27D8KK9B/lmY6KkRy+JNT0PTFURDw=;
 b=uGRtNQtordz4XwJh0+SvqU9phZNrNnnX6g4M3Qz/SNORZaK5mIy+LC6LQ3TNjdaZxP
 MZ50eq3zd/qAcNzNYHoH8jh7sXH7Rjb1c/z/NPVnZqoVplf4i3AH3ts1QMP1B5zj5kUI
 buACKI/k3a1LvrdI5pbuWoT8hKw9D2U2vu0ytmRcfVTvQkCK2vg7T9NKpGc9qj4saEBS
 /rMLerhxKwOB0TJcAjmb4/PmKI7BHIsiMLzg7wkgXkz68A/WLMsB08Y7GfQNtUCaTCqF
 qczBGmPAyxsCRF9KjO12jS/d30l39BEu+AKibu9OFemoyh/6oJBoshw/6A1pNAoWTrM3
 0HOg==
X-Gm-Message-State: AOJu0YwUddmEIl+/HLD/DHEj+jEpck8lQ2Pm8rkOG5UCNQqT/LXTorKH
 xwjZP6p5Xyix1osZ1JLPdngORH53/DbkrDX5EJ+ilj7Appb7yblzSsWwQgbE6tVmIyMPTo813jF
 mcMJqdg==
X-Gm-Gg: ASbGncvdopNxZ9aK4zfT/X8iFrN7/jr0HY3xRGcSyfLYJ3Um4SQjh+adIH8exu76vUH
 zfJvj48jKnhJQS68toFTyio5TEmnaMqF5fDm9BOCwRmBTAppxRIjK4RH8FVPZvTBqTqwB/amHYq
 nlFSaTAK+D9H3YJeAwH4RvOFsJBumwfAT8pQBVSVRZ4pzcSAY/QRRswLtsKwnKOmcugXvYb9F9k
 4bsPZtkpICKvlfq5D3XfWBW0eIjX4HySdKzfNT58HM4BdsB7FsIhhJua76lYDDQ7yLd2fxBenk6
 AixHiwhdSnj1I4AkRkru9+Fi7LQrNZ2ZDAwi
X-Google-Smtp-Source: AGHT+IHbtZX0xdlHrO9vlqC+pSpM0h0T6M1Um34cc5JhRw4X4+g8oBS2AdwiAVbp1jshvTuq+sCZBQ==
X-Received: by 2002:a05:6830:16ce:b0:71d:eaa8:9971 with SMTP id
 46e09a7af769-71deaa89f03mr1678504a34.8.1733698141365; 
 Sun, 08 Dec 2024 14:49:01 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:49:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 12/17] target/hexagon: Remove internal_fmafx
Date: Sun,  8 Dec 2024 16:48:39 -0600
Message-ID: <20241208224844.570491-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

The function is now unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.h |   2 -
 target/hexagon/fma_emu.c | 171 ---------------------------------------
 2 files changed, 173 deletions(-)

diff --git a/target/hexagon/fma_emu.h b/target/hexagon/fma_emu.h
index ad5df5d038..fed054b609 100644
--- a/target/hexagon/fma_emu.h
+++ b/target/hexagon/fma_emu.h
@@ -30,8 +30,6 @@ static inline uint32_t float32_getexp_raw(float32 f32)
 }
 int32_t float32_getexp(float32 f32);
 float32 infinite_float32(uint8_t sign);
-float32 internal_fmafx(float32 a, float32 b, float32 c,
-                       int scale, float_status *fp_status);
 float64 internal_mpyhh(float64 a, float64 b,
                        unsigned long long int accumulated,
                        float_status *fp_status);
diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index 35971b8b99..0c7c7f636c 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -90,21 +90,6 @@ int32_t float64_getexp(float64 f64)
     return -1;
 }
 
-static uint64_t float32_getmant(float32 f32)
-{
-    Float a = { .i = f32 };
-    if (float32_is_normal(f32)) {
-        return a.mant | 1ULL << 23;
-    }
-    if (float32_is_zero(f32)) {
-        return 0;
-    }
-    if (float32_is_denormal(f32)) {
-        return a.mant;
-    }
-    return ~0ULL;
-}
-
 int32_t float32_getexp(float32 f32)
 {
     Float a = { .i = f32 };
@@ -369,25 +354,6 @@ float32 infinite_float32(uint8_t sign)
 }
 
 /* Return a maximum finite value with the requested sign */
-static float32 maxfinite_float32(uint8_t sign)
-{
-    if (sign) {
-        return make_float32(SF_MINUS_MAXF);
-    } else {
-        return make_float32(SF_MAXF);
-    }
-}
-
-/* Return a zero value with requested sign */
-static float32 zero_float32(uint8_t sign)
-{
-    if (sign) {
-        return make_float32(0x80000000);
-    } else {
-        return float32_zero;
-    }
-}
-
 #define GEN_XF_ROUND(SUFFIX, MANTBITS, INF_EXP, INTERNAL_TYPE) \
 static SUFFIX accum_round_##SUFFIX(Accum a, float_status * fp_status) \
 { \
@@ -517,143 +483,6 @@ static SUFFIX accum_round_##SUFFIX(Accum a, float_status * fp_status) \
 }
 
 GEN_XF_ROUND(float64, DF_MANTBITS, DF_INF_EXP, Double)
-GEN_XF_ROUND(float32, SF_MANTBITS, SF_INF_EXP, Float)
-
-static bool is_inf_prod(float64 a, float64 b)
-{
-    return ((float64_is_infinity(a) && float64_is_infinity(b)) ||
-            (float64_is_infinity(a) && is_finite(b) && (!float64_is_zero(b))) ||
-            (float64_is_infinity(b) && is_finite(a) && (!float64_is_zero(a))));
-}
-
-static float64 special_fma(float64 a, float64 b, float64 c,
-                           float_status *fp_status)
-{
-    float64 ret = make_float64(0);
-
-    /*
-     * If A multiplied by B is an exact infinity and C is also an infinity
-     * but with the opposite sign, FMA returns NaN and raises invalid.
-     */
-    uint8_t a_sign = float64_is_neg(a);
-    uint8_t b_sign = float64_is_neg(b);
-    uint8_t c_sign = float64_is_neg(c);
-    if (is_inf_prod(a, b) && float64_is_infinity(c)) {
-        if ((a_sign ^ b_sign) != c_sign) {
-            ret = make_float64(DF_NAN);
-            float_raise(float_flag_invalid, fp_status);
-            return ret;
-        }
-    }
-    if ((float64_is_infinity(a) && float64_is_zero(b)) ||
-        (float64_is_zero(a) && float64_is_infinity(b))) {
-        ret = make_float64(DF_NAN);
-        float_raise(float_flag_invalid, fp_status);
-        return ret;
-    }
-    /*
-     * If none of the above checks are true and C is a NaN,
-     * a NaN shall be returned
-     * If A or B are NaN, a NAN shall be returned.
-     */
-    if (float64_is_any_nan(a) ||
-        float64_is_any_nan(b) ||
-        float64_is_any_nan(c)) {
-        if (float64_is_any_nan(a) && (fGETBIT(51, a) == 0)) {
-            float_raise(float_flag_invalid, fp_status);
-        }
-        if (float64_is_any_nan(b) && (fGETBIT(51, b) == 0)) {
-            float_raise(float_flag_invalid, fp_status);
-        }
-        if (float64_is_any_nan(c) && (fGETBIT(51, c) == 0)) {
-            float_raise(float_flag_invalid, fp_status);
-        }
-        ret = make_float64(DF_NAN);
-        return ret;
-    }
-    /*
-     * We have checked for adding opposite-signed infinities.
-     * Other infinities return infinity with the correct sign
-     */
-    if (float64_is_infinity(c)) {
-        ret = infinite_float64(c_sign);
-        return ret;
-    }
-    if (float64_is_infinity(a) || float64_is_infinity(b)) {
-        ret = infinite_float64(a_sign ^ b_sign);
-        return ret;
-    }
-    g_assert_not_reached();
-}
-
-static float32 special_fmaf(float32 a, float32 b, float32 c,
-                            float_status *fp_status)
-{
-    float64 aa, bb, cc;
-    aa = float32_to_float64(a, fp_status);
-    bb = float32_to_float64(b, fp_status);
-    cc = float32_to_float64(c, fp_status);
-    return float64_to_float32(special_fma(aa, bb, cc, fp_status), fp_status);
-}
-
-float32 internal_fmafx(float32 a, float32 b, float32 c, int scale,
-                       float_status *fp_status)
-{
-    Accum prod;
-    Accum acc;
-    Accum result;
-    accum_init(&prod);
-    accum_init(&acc);
-    accum_init(&result);
-
-    uint8_t a_sign = float32_is_neg(a);
-    uint8_t b_sign = float32_is_neg(b);
-    uint8_t c_sign = float32_is_neg(c);
-    if (float32_is_infinity(a) ||
-        float32_is_infinity(b) ||
-        float32_is_infinity(c)) {
-        return special_fmaf(a, b, c, fp_status);
-    }
-    if (float32_is_any_nan(a) ||
-        float32_is_any_nan(b) ||
-        float32_is_any_nan(c)) {
-        return special_fmaf(a, b, c, fp_status);
-    }
-    if ((scale == 0) && (float32_is_zero(a) || float32_is_zero(b))) {
-        float32 tmp = float32_mul(a, b, fp_status);
-        tmp = float32_add(tmp, c, fp_status);
-        return tmp;
-    }
-
-    /* (a * 2**b) * (c * 2**d) == a*c * 2**(b+d) */
-    prod.mant = int128_mul_6464(float32_getmant(a), float32_getmant(b));
-
-    /*
-     * Note: extracting the mantissa into an int is multiplying by
-     * 2**23, so adjust here
-     */
-    prod.exp = float32_getexp(a) + float32_getexp(b) - SF_BIAS - 23;
-    prod.sign = a_sign ^ b_sign;
-    if (float32_is_zero(a) || float32_is_zero(b)) {
-        prod.exp = -2 * WAY_BIG_EXP;
-    }
-    if ((scale > 0) && float32_is_denormal(c)) {
-        acc.mant = int128_mul_6464(0, 0);
-        acc.exp = -WAY_BIG_EXP;
-        acc.sign = c_sign;
-        acc.sticky = 1;
-        result = accum_add(prod, acc);
-    } else if (!float32_is_zero(c)) {
-        acc.mant = int128_mul_6464(float32_getmant(c), 1);
-        acc.exp = float32_getexp(c);
-        acc.sign = c_sign;
-        result = accum_add(prod, acc);
-    } else {
-        result = prod;
-    }
-    result.exp += scale;
-    return accum_round_float32(result, fp_status);
-}
 
 float64 internal_mpyhh(float64 a, float64 b,
                       unsigned long long int accumulated,
-- 
2.43.0


