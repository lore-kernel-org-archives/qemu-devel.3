Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DFAFF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEuV-00068T-6K; Wed, 29 Apr 2026 20:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuT-000684-Cu
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:41 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuR-0001iv-Sk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:41 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c797d5ad36bso100664a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507538; x=1778112338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6PeVyr8q3AKOmBPv+t3uSdl0yB4glMGXowE42GNDyE=;
 b=FjDt0TFhvTvKMjjqD9a9/fmmTtBR/ZE3jkE+brD6dryLiCDqQJ+mHHxM82U4jwODhV
 cfcvu/uso6lFm+Dm/vuHxj1Q5w2yJ63zX9O0uiJuoJQbDyKrvkr6ofhT5B+FYNJOqE2p
 eXgKIgKJH3QqgLX1P6WgdsqL4nFzgviw7i6UAwiTN1NTXswQw09oxQvmKFLCtA1o1EhO
 0rxcCmRWoudGem+s7juLrqemZpnO094BmNkw8PLx/L2Pisg9BayhhpEU7GOWYQmIUB7e
 7rx4HEHWwIHjpyoPlWwQCyAc6xNcAH8w1Abo9ERlD+xPZwUM662m3t5L1DmjJ8kgEgBz
 ScgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507538; x=1778112338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S6PeVyr8q3AKOmBPv+t3uSdl0yB4glMGXowE42GNDyE=;
 b=SSJ+HeWTwtKTHLe0iMCatrr/oesC0JlM+mDF171ioY+cLur1wofk8ch+Tdvjr/S8yc
 cHFAxp10oA0b/wuTqWD4FPy482vLfCm44VxYuidTdHfoNXSieGh80b8/QqLoPX6l2B3N
 1VsGzhq4WO+hJiDKoojbR2CQaXm9HmNRk1/DEOzpKxtxoia0iehAxqsFhVtfBGTSFVmG
 A63A3frd2KvuYHrJXObemyM9PBwngK4biT3vXbRATxOevBCUg45ixKQcArpQzig+cakB
 kHZ6p5T+szDFxUVaviLGf7JmcbCpeJKReMtgEA44PNzou2PH71bzVc+LfzuGftn/9P8W
 smJA==
X-Gm-Message-State: AOJu0YyTo53Fe06VyOP12jYPhvK0HiEeHfsGdjn1NQYQMMyZrsmUEKZ0
 tjp01fcrtu6Uk2XN2YjE1PLtAW1xJgBzx+I3OurQEI3lqaatp8+tNNkK9m0wrbR5PBndWIRSs6h
 3bYDMCMY=
X-Gm-Gg: AeBDieu+Wt9BbJWBWzkS5i89enitr1zIIiQ3A0MhoSdQmwEjb3OLaR7M1R8+G0DPVwM
 MUkyuYZvriSqVVnVrKL2Mvgu8/k9wMr5YqUa3w40TtdBukCEBoIuwLkNpUIR5gPbHNu96Zor3Fz
 WWDp9MKAamqOm4Nl9WqFHlP+XbeONQFh7hiD2YTrsFFR3PtXtCK9O5KwUVxYqvVpvcUUFEG8M+P
 yw4WqFu++LBcJaG+ORJJFyDDsexIw22J6HYAV2fQRqeAHI2tVJfuBdREgaXf/0E1PMKJsfKKUDT
 0ssmI1/BcJolNXqTl63CEyaxIMaS797/C0MFJXPAtGbaEX5Gtbc24LQabhNJes77hEcq6J1Qvxc
 LtHUTwx5ArkuBeYPEjq/Bqu41ldKXv2ap1jqVVbAxNODno280ccc6u0/WPxo3GKmyTVUobwsZHS
 /X+cGpIADOFwDE7jze89dMJwj3ziPYbVEjCP11oR1/
X-Received: by 2002:a05:6a20:6a0b:b0:3a2:c683:fa84 with SMTP id
 adf61e73a8af0-3a3cf77ba41mr532145637.27.1777507538122; 
 Wed, 29 Apr 2026 17:05:38 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 04/40] fpu: Inline bfloat16_pack_raw into callers
Date: Thu, 30 Apr 2026 10:04:47 +1000
Message-ID: <20260430000524.56046-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
 fpu/softfloat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8cfe7f8f4b..6d5125eb1b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static bfloat16 QEMU_FLATTEN bfloat16_pack_raw(const FloatParts64 *p)
-{
-    return pack_raw64(p, &bfloat16_params);
-}
-
 static float32 QEMU_FLATTEN float32_pack_raw(const FloatParts64 *p)
 {
     return make_float32(pack_raw64(p, &float32_params));
@@ -1488,7 +1483,7 @@ static bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p,
                                               float_status *s)
 {
     parts64_uncanon(p, s, &bfloat16_params, false);
-    return bfloat16_pack_raw(p);
+    return pack_raw64(p, &bfloat16_params);
 }
 
 static FloatParts64 float32_unpack_canonical(float32 f, float_status *s)
@@ -2230,7 +2225,7 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
-    return bfloat16_pack_raw(pr);
+    return pack_raw64(pr, &bfloat16_params);
 }
 
 float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
@@ -4753,7 +4748,7 @@ bfloat16 bfloat16_default_nan(float_status *status)
 
     parts64_default_nan(&p, status);
     p.frac >>= bfloat16_params.frac_shift;
-    return bfloat16_pack_raw(&p);
+    return pack_raw64(&p, &bfloat16_params);
 }
 
 /*----------------------------------------------------------------------------
@@ -4797,7 +4792,7 @@ bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
     p.frac <<= bfloat16_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= bfloat16_params.frac_shift;
-    return bfloat16_pack_raw(&p);
+    return pack_raw64(&p, &bfloat16_params);
 }
 
 float128 float128_silence_nan(float128 a, float_status *status)
-- 
2.43.0


