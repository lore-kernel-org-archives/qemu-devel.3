Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D983FFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpP-0007ML-Ac; Sun, 26 Apr 2026 09:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzno-0005iW-Co
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznk-0001P9-He
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so39837375ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211135; x=1777815935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Mxa4m32oeXlXCbYEih/Wgv7PsGE1aRsWYB+Y9zn5Ik=;
 b=Loc8+b9VCzYzhT1T4NdsnUfNmALvNn+2s/xfEsAiH58WNWA3k9Z7EyoQl3QA0twF78
 gL6WqBMfYHKqJEH9T3HXqAwMohpGUGLyRiGEwOiTl3KmhlE0Ir6aJwAUyfFh+VXV7lSF
 aFY79KWuMA9Yt9Hu/L6oeEZ3aYY50/VkfkUe3wB9ZQHH/cC7eTMH11l3+GJhZs/meR49
 AdZ3uMaK0bypo2us/PoUEC8JHjPWf2h9/94vBmCzZQZxWcU2WddY2AKg9LGd+Rx9dcmX
 50800QE++Wd5ckA634H/SUSBMOndS8B/BA4W/7C0UjmKWHk7p9IjtA6zpKfO+j9H73nF
 Tg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211135; x=1777815935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Mxa4m32oeXlXCbYEih/Wgv7PsGE1aRsWYB+Y9zn5Ik=;
 b=W10Ur34T0TEj0Il0VkdBAxBurdaa5LhtE7uwmUrKQJnYh+R9vSnAKzSKH5RXeX1Pzf
 v880X20jUmoNylOfgIE89MBLezoqyWcgAY3/JD+yrfPGWv7t/1O1sLoq2FAfr6y7KRfc
 YcDDGOluwiwPRyyZK187DS82Aussx525A6iv2aVdv7OtW8K5D47Dhcr8PYsNTFox0sRK
 PskPe4LsKRzsWNfW6zyMAYMxSPXQEdPhdRtXY/8UoY4HMCFzmpafJDnlJpGVgWWKPaVB
 D/sMKXz0p0AD7mAq20ODt7DlWwugZi43zzNHbows4jEcrYaJALjYzKOy9Lv5fop6ipZF
 aV5g==
X-Gm-Message-State: AOJu0Yx0/fsd6r+lQLqFArhvev64nhM/iZK7xd6GXMFYz0yHZZv7nYeA
 ltqThBGysgy4Z5pwRIzlO+zKluahMLjECDt19pxMagrgGoUR8azqinBf4tqv0iWJlxjifSvOZwG
 SpHTqiMg=
X-Gm-Gg: AeBDiev08RhIbBA28JVsTnTMnpMIZSgVBVciLgDZ5i25ywmkm7TmkfLjGgYRkqwBwEF
 sodSlMPg2+uioyrSyftTcDntyhpTHoQhhkWbSLU51DttxnxTPWxbwsEmXInPLt6tPAbfVe0c6aQ
 xX8YIYmun6jOMUSov6GDV4ml11bawRwW90jLnEAxjpAby/TsttyIocsx14sOtl+ZB1Lj8l2HgeF
 WEQCje7CRpNTLGsBDN7u5MhAliipcIJ7YT83Xj1CKj6VCKJNl2vzoY2kbXT+AwQyvlFQpW2YPkx
 s6jYaspOXIA3pWd6oiF/8bsTCZkTdfEmvn8rzTolmhN4Kgh4xwPJAiySxc7hgsXGxhtLSJPAP9O
 qS3ELN6pTW8UX/m85RtcdxKSzJshxzMAod6xPEgHGm5Do4cltil19wCm19YrrmvczYXgOgLGj9J
 WKHB+PtgMk9VE09vmEk+01ZaTI1DAbRTv2sdZPc6sK
X-Received: by 2002:a17:902:6ac4:b0:2b2:49a7:a5d0 with SMTP id
 d9443c01a7336-2b5f9ea2e11mr308008635ad.11.1777211134649; 
 Sun, 26 Apr 2026 06:45:34 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 53/84] fpu: Inline float32_pack_raw into callers
Date: Sun, 26 Apr 2026 23:39:30 +1000
Message-ID: <20260426134002.865628-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 fpu/softfloat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6d5125eb1b..d1acf383e9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static float32 QEMU_FLATTEN float32_pack_raw(const FloatParts64 *p)
-{
-    return make_float32(pack_raw64(p, &float32_params));
-}
-
 static float64 QEMU_FLATTEN float64_pack_raw(const FloatParts64 *p)
 {
     return make_float64(pack_raw64(p, &float64_params));
@@ -1497,7 +1492,7 @@ static float32 float32_round_pack_canonical(FloatParts64 *p,
                                             float_status *s)
 {
     parts64_uncanon(p, s, &float32_params, false);
-    return float32_pack_raw(p);
+    return pack_raw64(p, &float32_params);
 }
 
 static FloatParts64 float64_unpack_canonical(float64 f, float_status *s)
@@ -2035,7 +2030,7 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
-    return float32_pack_raw(pr);
+    return pack_raw64(pr, &float32_params);
 }
 
 float64 QEMU_SOFTFLOAT_ATTR
@@ -4721,7 +4716,7 @@ float32 float32_default_nan(float_status *status)
 
     parts64_default_nan(&p, status);
     p.frac >>= float32_params.frac_shift;
-    return float32_pack_raw(&p);
+    return pack_raw64(&p, &float32_params);
 }
 
 float64 float64_default_nan(float_status *status)
@@ -4772,7 +4767,7 @@ float32 float32_silence_nan(float32 a, float_status *status)
     p.frac <<= float32_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= float32_params.frac_shift;
-    return float32_pack_raw(&p);
+    return pack_raw64(&p, &float32_params);
 }
 
 float64 float64_silence_nan(float64 a, float_status *status)
-- 
2.43.0


