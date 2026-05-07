Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D812DCD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EQ-0004Z7-Am; Thu, 07 May 2026 12:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EM-0004WO-Ao
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:42 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EH-0006lp-Rz
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:41 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso920177a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169928; x=1778774728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLEYbhCCCbPbEDaftNdlR375O0h5UDScim3t09wb/r8=;
 b=gz28LLA9qsVAig1ayokOSRNz4WFJKZxTOgOgC3Kc2C+UNdm0dyDbI+WdYbkdW8A61A
 4KBsTFhHl72P0Ul2SSOyt3HRPo8j4mA1+M8jg3p9bxAwgWKVto2ursF4yJ3HYJtiHzOM
 zkShJLVAs7zMxM3F5PwMcYhbLM801weawvYAJr1Wt9TSxbL8onFZGs+pippEqXvbXfhk
 f05Nr+tsZjh1DF3MeqH/5VwFYs7HOMLhLS2XmIQGrbeYxovTJ2+LxAKT9Sx5/MfsDtS7
 vPRXnIOjcGRs6YOhlQeytKvOfKkaJv7NqY9K+Pueol2RAt6kXG+WWCeueeLsPvzvOUfD
 QZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169928; x=1778774728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jLEYbhCCCbPbEDaftNdlR375O0h5UDScim3t09wb/r8=;
 b=q4PgWBHhh+dIDBZrcrw8H6UM4DzMxCaiE5w2vH1cYAyJvHUwKwsLrKe93oY2duvSws
 Poh+VwJtY5TAEEObCnoyhfylOgbnpfy5Sr5Zx4kETnJk7sYppSLIpQnqIhrg2ue8ovBZ
 Mcg1K+bxw99E2QqTOt/PZ8qKzFIL0nWqBsTnuIWs8vKrGW3GJD1aSl4Hj1Ox+2GMgnAm
 RiuoUNRnPz6j+JfzzWQ4xlecLKGnI4DID7l9MpRr79El2Yn2f4bjdhxJmi5XIFrilOKa
 oUZ54KregQ49rrWyqv0QO2dSYWBcROeEbga9Jt9KoiqaeShhX8PzBJHABnIiCiJsSj+Q
 d0uA==
X-Gm-Message-State: AOJu0YzMMD87s6HQBc+j0XQgrRboi+Q2AdE5S5k/f854JddE/Q5/+c+y
 sIqCqZTsGRGWimjraJF9dqWIyLSN5nJ7F26xCG8LKPYp39pnu5ISfzvr96LLLHg5tN0SVLxVt5t
 89q2Q
X-Gm-Gg: AeBDieswJeDcEm2L4Yp3ekhH8w/ZJdKG94friVevSOcXggay/3W/t8srANseE12a8kS
 H4WFEFRYAKPZfOy/LOb+1e1kmXkBhSCwdreDRYQ/d5iQbxEVJ2hpy4ZDeIgDHC6FlFtZgVOAY/d
 02O9WQsTKCX2NsGMeHS6xDIanhf7/8a8ScThf97D+OS1lr/WY757+9frRgVgNalrO7tfElFpktk
 /SMLmt/rN4lJB5Gy+Vc/8l8NZGYdD4dG8L58zO8LWPIuNaIk3e6toKdCglWjWTq1kqNSOX8OITA
 fUgsoc+lcFX4/7Ll9QQEuOGzAv0vbvEeBwmac8d/Z/6lOjeUlFERJv5znpBkyCnte2Pkagikd3c
 GwzoVg/E5ZaNv/I8aacjsNn9bOw5WIIHo6q83L+AFCOeq/+UU/lKEK6bxy/iaO0FpeVi9VAgN3V
 5cXXnFSnow/LyG32K+o+wfqsxVbZ8Ln26PYLL2xWgtDIvn/zyLBQGQUiEH
X-Received: by 2002:a05:6830:64c9:b0:7d7:eab6:fb23 with SMTP id
 46e09a7af769-7e1df1abd5amr5062212a34.22.1778169927844; 
 Thu, 07 May 2026 09:05:27 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/29] fpu: Inline float64_pack_raw into callers
Date: Thu,  7 May 2026 11:04:54 -0500
Message-ID: <20260507160518.444797-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
 fpu/softfloat.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d1acf383e9..302612fe42 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static float64 QEMU_FLATTEN float64_pack_raw(const FloatParts64 *p)
-{
-    return make_float64(pack_raw64(p, &float64_params));
-}
-
 static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
 {
     const int f_size = float128_params.frac_size - 64;
@@ -1506,7 +1501,7 @@ static float64 float64_round_pack_canonical(FloatParts64 *p,
                                             float_status *s)
 {
     parts64_uncanon(p, s, &float64_params, false);
-    return float64_pack_raw(p);
+    return pack_raw64(p, &float64_params);
 }
 
 static float64 float64r32_pack_raw(FloatParts64 *p)
@@ -1548,7 +1543,7 @@ static float64 float64r32_pack_raw(FloatParts64 *p)
         g_assert_not_reached();
     }
 
-    return float64_pack_raw(p);
+    return pack_raw64(p, &float64_params);
 }
 
 static float64 float64r32_round_pack_canonical(FloatParts64 *p,
@@ -2047,7 +2042,7 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
-    return float64_pack_raw(pr);
+    return pack_raw64(pr, &float64_params);
 }
 
 static bool force_soft_fma;
@@ -4725,7 +4720,7 @@ float64 float64_default_nan(float_status *status)
 
     parts64_default_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
-    return float64_pack_raw(&p);
+    return pack_raw64(&p, &float64_params);
 }
 
 float128 float128_default_nan(float_status *status)
@@ -4777,7 +4772,7 @@ float64 float64_silence_nan(float64 a, float_status *status)
     p.frac <<= float64_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
-    return float64_pack_raw(&p);
+    return pack_raw64(&p, &float64_params);
 }
 
 bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
-- 
2.43.0


