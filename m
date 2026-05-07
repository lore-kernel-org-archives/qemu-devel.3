Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5CFCD3447
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1ES-0004aY-H6; Thu, 07 May 2026 12:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EM-0004Wl-Vw
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:43 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EH-0006lV-Ss
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:41 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dea20cf21aso970510a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169926; x=1778774726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6PeVyr8q3AKOmBPv+t3uSdl0yB4glMGXowE42GNDyE=;
 b=vR8S9bAAIU8Y1k+30Egc9gGYIFrkGxITVD14Lm0JehKVc1pwgCNcLv8akMWP7bKwW1
 xKLAQ9fn0E5HXopyiB8UlQhjbu10EBa/ZQLoVaoVkXPIobg90b0aW8gb6nPRvlazQThU
 wNpVFxUE7QR6UiB+vl7/hJS1glkzS4Wy2dDqdtILTDH7uKmbZlLr1nQWqeGbQOUjP8r7
 T7hwB1DIS3Cjjlcaal4HN1WJtITNAJ5ap5ZZOXWMX3+egTbt1qSfofy2X+RgLKECdh72
 4H8uRKQjUGyhg7QxWcX98APrnpcIHxBMJ5OymSJgGZFksxAALs45X8Mcd8znYs0bNwpr
 EnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169926; x=1778774726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S6PeVyr8q3AKOmBPv+t3uSdl0yB4glMGXowE42GNDyE=;
 b=csFLbqfemnPMSWsDuFX1+d1PALy8BDCricezfOwqJ48OUTckRNjBX2Q3JVBr1ei8xO
 ljv/TfPnJa33wNIXm6mJKY3va0TfJ5N1l0fcpiE1cQBeTsE7cxgO+csoCAE1I8gAtVx1
 bxEq/NS+8hGDzSXl/2mOl4hR/9mve5Za0aNqwNt/5tJN1skhWmFXQOe7pUIf2WqriIKr
 z04bp2qyDodEJubTYT7AHqioFAfJa3GKXjZfNB2GPja+UAe0cXODloJGqmE4Rd326Zea
 32Sv5MjW5izUD8Zk0g6I7027ybrQ0BISKYsaSvO1B5hR6vgzAOZQBZkJblD7zS1VqNIA
 h7+A==
X-Gm-Message-State: AOJu0YzugnI6xNqcOlQpfX/bqrb26l3+7g0TgI4D4CzcvB83HQNqg/9V
 c6HyPaShzg70lDOXiB5F2leEofaRkGJnY7MdN5AD1aZCEbyGBtikRDIJBHp9xZCDWYkFUvuNnil
 Sof0z
X-Gm-Gg: AeBDieuV67YDqDcgTWpmP9jEm8jZrPsR4IQnEh1hNux7Q83Fh/6FFG1CtXAkGdA49vt
 CF1eOj2h3nwkp+48yg9hk6UldfJFXr7d4zKroop7lUpG7dXBvlPsRA1QgapPwXYoHO446ZAxFvK
 ILjfCEVq7HnxM8k2akMhu9y4pxxGh83grvApAgdACv4CkgHEruyzvF4A5Hpji8BgEbD1CupCICx
 VchB3iPyC551zCS39oZhuBfLiGIiT84x3JkmZ3hzNa8h0E0UEItES1tw5wCoB+CMG68zF2V2ElE
 POryXHRXedSTHlsbGpkWv/uFvVgYC4GwDTWFHghhG8lDy+fvKfaFT4o6SUjV+UanwmC+uG1hV5J
 6nOzOLFlki+ioXo8rDx54Bepdk15L9ypLGnqyh+yFZCTBPmOe/gxpqvl4jB1LL4xunDSIop+hun
 gEpqU8BgAm8dl9/nNugSFZdIVpBaNrEEJ7HcNLenHAIlT4OQ==
X-Received: by 2002:a05:6830:3894:b0:7de:4f6b:9e10 with SMTP id
 46e09a7af769-7e1dea53c38mr5461459a34.0.1778169925416; 
 Thu, 07 May 2026 09:05:25 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/29] fpu: Inline bfloat16_pack_raw into callers
Date: Thu,  7 May 2026 11:04:52 -0500
Message-ID: <20260507160518.444797-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


