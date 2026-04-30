Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D37FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEuQ-00064c-R9; Wed, 29 Apr 2026 20:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuO-000647-Oc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:36 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuN-0001i7-8t
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:36 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-834da62e52dso158921b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507534; x=1778112334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KddSzfu6h2SYxUnVyJmdaPI//25dV/tGyPD+hJSdvk=;
 b=JQEAneSZziATNDhR0HcslGc5i8ENokGUNRicaTlA6niGjCY6lQ/7LoCCQzNiwccZXF
 mQATQTm8OvR1/iJfo0gybLKtYx+hitMHfA6A3n6cSGzelMIOe8Wd4NQGetVULb//DpCU
 waKP6LzFiLPfg2GInKAWAiH5dhTDUNhG9ovMvMPOj4mDmdd80rf9PSg1CLHEmFWfQ1sE
 hSfIG4nBIdXVZrTbFXI3CoKgEDsCcpavQwjB9xrUjbpMRwtZuOtlH/C0kbok5Gsnz3Op
 51yeSczND3B7YX6FoGrropp079tA2JxeTOxDs8pjHpnFuODyDXLccsAFUEs8phlIMgHX
 qbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507534; x=1778112334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8KddSzfu6h2SYxUnVyJmdaPI//25dV/tGyPD+hJSdvk=;
 b=VbV8Iyvy8wFAgU7Z/7rJq/1Ba4eSvCiYkuxrm/MLkQXqXr4PjFrYXb0lnpd8btz0yV
 IIzI6lMli8AExi26LCkK4DX4X9Pv/ZQwujRpJ4GF3Ft/sB8F18hLcsAWFSGRmAsDdWei
 UG8rOivP1kMgb1JJphHlKiAkMKKrBeUW1DKMpVmh6CdbJpMenplsOnIISqv64u3qdZ4Z
 FNzaVWvgrPpDOZ/3GWxKJUH40jMUuqBE6KG4PIz+Hw7a41GAE5zUgafxB2tdWZC0ryNF
 yT8lH2Qrqd6ISxZkkGHY/ZcShAesNAUtqbnE/vpBvEqxdJ6Yw7zexjwFFptWs/gl2d/0
 7rMw==
X-Gm-Message-State: AOJu0Yz+kmLy3qhPGIXta1YOAychqDwVLDoNgo7qe2uBJAvcdzVHr3+h
 KwBv73h37jQU1yvuXAB3sOM4r0rgOj+lZh3QFpP0qDBhx9cLrRwanHA2I2Pwi91BHoPuA986kdn
 xjXG0XSM=
X-Gm-Gg: AeBDieulTF3zar3e13dX4Ta1FF+oaX1+VVy8R4UTKx9tHpC31gI/Ns/CEKp6V8vcWMp
 a809Bb3ccxZeAsKTx90zwIh3/NSF+ikLFgd+K7Tikn2Ohzdio7nCYkbcYfFqqJYLM9MPgN4kZ0v
 Yy2n5sX7CpYaHggR1sW1IcgfWwOQIYImo6/+q5wU9PALX/EQUo1USsBb8yRBx0QFT7QyBSlLQVf
 mIujTnzZ4t69NXj26MRLhg4p3HhgUSEF3z+XW9H4kTZXcpbDEocRbe+nMjbyqD9qhfgVA6I3cg5
 EAcOpX9kr8vkwrwtWY1TwslZbSbF2+ZB8DqGZUGezJ3iGwImMJh6hzjXUhiE5GlWT6XR5doXjLY
 o7xEOnMYSfx0JnninHPu0AUl11Km6ssYkWYtkTT7O+kkC4LSQDRHOzJrl3v690au8d/vcH4X2tQ
 +ay/6zMNGmtx55cuKuce8OlazUA1G2nX2u5VIqnzC1
X-Received: by 2002:a05:6a00:8e01:b0:81f:3bcb:af2a with SMTP id
 d2e1a72fcca58-834fdbd238emr708570b3a.26.1777507533761; 
 Wed, 29 Apr 2026 17:05:33 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 02/40] fpu: Inline float8_e5m2_pack_raw into single caller
Date: Thu, 30 Apr 2026 10:04:45 +1000
Message-ID: <20260430000524.56046-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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


