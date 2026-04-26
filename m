Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4D2FF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzod-0006B6-DO; Sun, 26 Apr 2026 09:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznd-0005df-Jf
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznc-0001Me-40
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so89127375ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211126; x=1777815926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGWxvB5DOoCsVkn5ow4oJonJhUS77zZ22UYKKqluXkw=;
 b=lvaTl+rLp3jlNARzx/cMl2dUovAXsyYxMx0M0zBLxHTH4hdUKzP34Z72Vu0AzwTt1q
 nJ+pAyrA3YtDZ4Pl3otL1E/yuXnDO2elzgG3OjTLAXbnr7jxNPHA7NrYjph8XsWtrEoc
 DD3rLwFxqcWtAPunolVD6pIHBUnzDSxJQ3aLe3ED1yLDt5xNGOjP5y640fllWFn8PIhe
 /59BH0QZzQiJb24BI/uAjWE9fT4sxl1P1boAWzjj/BIIWmyInSV1xHn7LCyv8WJjXxx8
 mYHMgcV/BiVd4x3cG2MBZdJ/PIVeeoHyQhwsHUsJsYxgPxym6l3svZbLM6kdB7uevk5h
 vJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211126; x=1777815926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aGWxvB5DOoCsVkn5ow4oJonJhUS77zZ22UYKKqluXkw=;
 b=S8VQ+A4HltChh1Ws2HrUOJgEe9wOQPCSd6N0PYbGImc++mj7bBwwBZ9s76prpzKj2w
 KEOlIY878YLUHz+sPSm4HuosLU+m7tPljQcYVYwzP0HPHB1e+0ddO748rgs1VXzGAcRh
 HgGAZ9jbYMxeadZwPWlDKAsq5jBD9tyR74dtPuvFY71UT7XmFU808hsXWD/QqtWET0sP
 Aen/V0F31txWpDqDC6NRDP3jiMUDdYB6mK2KsDSiAeImEEhYt5r1xkjzkXZJvZMQR5Q1
 kts8yjZIaQD9heUThpkVRnEpYMX88XlWrrUBhxDbz7+hDwse5AOcZwJWqvfCVlB2POg0
 2aLA==
X-Gm-Message-State: AOJu0YzzuNF+nNIvZTrwiyEAVnopjRF++JxgtF/Kdb7biUrI9SXwRL95
 3PBzHK4pnD1v9ETP5yhUH0tskrLssbi7gxvmLXhPLZDAIOFahdRnINAcNqQVmHI5XshF1iXQz63
 B6gKipPI=
X-Gm-Gg: AeBDiesFJ2evf+d1tJlw3NllNwh1YVZWqszUjH5fxD60hlMBoZ2teEOr6mR073mq36E
 qLp0ckMqKZaj29e5E3jWHTr9O5aFh/vadWKHrCxHjbTSHnZJ8v0kKxzDEkeOGg5Yak0YeVSeFJB
 XsaHhIrBflVWC+nqbeIm7JIQEb1R+pr6uhOGhXbNn9jzIVvYcnIq3fOg1G057kYMLJdRIZgGsDa
 V0KK2+Y5o6GJH/GyAAjlILUQDf40uFif03LWnkoAMp0pZv9SEAAAZ7rbxuOF638AbTu4kzqepJr
 gwyzggQ+ElIovPbEJvb57+T2VvI4pqhK3A+RlMNqlpBMxVJwKO9MISDX6vv1goiSfxbcnzoFMuH
 HZN7Eb9NdK5SgcY32e8TtbPsfu6wxill4U0xQmtQmaNdsIY0ryJTzmCAFWuMUrYPw4xJL5neP2X
 ZCtFZft4kW5EQnmMFcWjWly+Jcvz8/HiQ8l+9nZgMI
X-Received: by 2002:a17:902:f08d:b0:2b2:4ded:954e with SMTP id
 d9443c01a7336-2b5f9f2f6ebmr270942755ad.24.1777211126497; 
 Sun, 26 Apr 2026 06:45:26 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 50/84] fpu: Inline float8_e5m2_pack_raw into single caller
Date: Sun, 26 Apr 2026 23:39:27 +1000
Message-ID: <20260426134002.865628-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 fpu/softfloat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 18f2ca900f..5269e5f977 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static float8_e5m2 QEMU_FLATTEN float8_e5m2_pack_raw(const FloatParts64 *p)
-{
-    return pack_raw64(p, &float8_e5m2_params);
-}
-
 static float16 QEMU_FLATTEN float16_pack_raw(const FloatParts64 *p)
 {
     return make_float16(pack_raw64(p, &float16_params));
@@ -1477,7 +1472,7 @@ static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
                                                     bool saturate)
 {
     parts64_uncanon(p, s, &float8_e5m2_params, saturate);
-    return float8_e5m2_pack_raw(p);
+    return pack_raw64(p, &float8_e5m2_params);
 }
 
 static float16 float16a_round_pack_canonical(FloatParts64 *p,
-- 
2.43.0


