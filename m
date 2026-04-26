Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0063FFF8863
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjD-00076t-F1; Sun, 26 Apr 2026 09:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzj6-00073q-Ko
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzj2-0008PU-4G
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so89109985ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210843; x=1777815643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cln1IvUYfPUAHI9KvfM8VpMshxIOEoB0M8M5C1mmxEg=;
 b=PMFLGC1FcSbVgRfS6gy5Lxb7+M83OSGKXwncyC1sHJVt97s8i7UpRuq6pbSGzBjnvz
 ByWpJAO2o99ZwLrpUisKIbp0nqfAWlmlOjECGw6nAudFClsjNy6rXzAOpYwKc1pLjgPM
 GUxMV8uJ7WPVp56czt9UCorOmGevqQGoJ/TUc9I2b6K4DxFvs2sNqIyhKgWtwow5b6Ko
 ICbxALOrlok/i9g3fSFjH7gA9ViDPEjy7Jv0dO7ZXId1ApEFAwg3aTh+PeWP0raiQuY3
 7C363MHj2DEw3yDGzQdsi40QLgt8MOTW0gQnJVBQcJt6VWicmzMR0UCyTOBQ9vQToGEy
 Mr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210843; x=1777815643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cln1IvUYfPUAHI9KvfM8VpMshxIOEoB0M8M5C1mmxEg=;
 b=BCblIxS8Tpbm7n6sEgvJ5OwK2dFNE0SWRTMLizkTeH3rRrZ8f1rMqGuuNCvYf4G5D7
 GvstRS8xCoe3fLjMJiQACqrLD7NSFlbzKNyuMHTaiznqlDalrG+/LzKS9tb7oqv6mx4A
 GI31IIjn2crw2VFExyhHe21aUAlS5DbqjbvS3bBLN6b4FKnprIqDiE5IaF9sofEnUt4g
 DgtBUOg7P8tDSSQTBC/DmVcsFYzBMLW4cG7w0/EU55SizXJtGuO0mP9IwpOk+7g+Uhnq
 0mcPkjPrsVK9B1Mr87PzBFfFDC1ABhiHwdq/vZeIN5yjPnqJa4oXxfydLHXeCu6E/Y50
 HS9Q==
X-Gm-Message-State: AOJu0Yznf5kj2e82+6DZOuwlZ9adDkQmEmcEc8WOX+Qhgkt6+KXfxWPh
 6jsFLXRa+iZTtq00brNDUDI2MExric6jr+6p9QdfXz21wioSI57jy5MMn8RkSKKTH89lT+6YrCb
 bnaV0q4A=
X-Gm-Gg: AeBDiesDrZByyTV6LiAVM1xWGjcUmpf2Mh+VyfGfeoKUdi0ZheB63WvZ+3jbkYeqMl0
 9QdX9TyMIGvfglWY9viGVXROqgYElaJwyxKwJ7BinXmCm1JQCT9n47XE9QaMwcvJnMR51oS6RnQ
 xipVEJHRLZ7Muo01kkM6iZAWnu9ql01vw1+FOVvotktIfWFSSufQdzGE/rYciQg5cfiNG/1VJJs
 m0ypdyDhlpgte4SNzef+dPzmv6Q36XSuEBbuoMjeUflp0wVs9JYpUbpjDqFS8WnH5Li3PdFGm6x
 2IpjyR0INCmzgXg1kadZYgRJto+o8IIbxDrlp2lgMbZ0EHe12Dfr9wr6L1NYqJljBjG9+Un7KjY
 Z9Btt6XR5/4T5Fl7TzzyaLtFl4MBoxeha7L5cyZTy2UCq9l8OM4axwI2J3JjXXDQpkQMcziIjZO
 NgjCapeQHsuO5p32qLmDRxy/CFZ3rHPb7BuyWaB3Nr
X-Received: by 2002:a17:903:28e:b0:2b0:7531:b61e with SMTP id
 d9443c01a7336-2b5f9f9f125mr400489305ad.41.1777210842787; 
 Sun, 26 Apr 2026 06:40:42 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 13/84] fpu: Drop parts_muladd_scalbn
Date: Sun, 26 Apr 2026 23:38:50 +1000
Message-ID: <20260426134002.865628-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Use parts{64,128}_muladd_scalbn at each call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8adc73c863..aa62fea47d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,16 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_muladd_scalbn(FloatParts64 *a, FloatParts64 *b,
-                                           FloatParts64 *c, int scale,
-                                           int flags, float_status *s);
-static FloatParts128 *parts128_muladd_scalbn(FloatParts128 *a, FloatParts128 *b,
-                                             FloatParts128 *c, int scale,
-                                             int flags, float_status *s);
-
-#define parts_muladd_scalbn(A, B, C, Z, Y, S) \
-    PARTS_GENERIC_64_128(muladd_scalbn, A)(A, B, C, Z, Y, S)
-
 static FloatParts64 *parts64_div(FloatParts64 *a, FloatParts64 *b,
                                  float_status *s);
 static FloatParts128 *parts128_div(FloatParts128 *a, FloatParts128 *b,
@@ -2256,7 +2246,7 @@ float16_muladd_scalbn(float16 a, float16 b, float16 c,
     float16_unpack_canonical(&pa, a, status);
     float16_unpack_canonical(&pb, b, status);
     float16_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float16_params, false);
@@ -2281,7 +2271,7 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
     float32_unpack_canonical(&pa, a, status);
     float32_unpack_canonical(&pb, b, status);
     float32_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float32_params, false);
@@ -2300,7 +2290,7 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
     float64_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float64_params, false);
@@ -2459,7 +2449,7 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
     float64_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float32_params, false);
@@ -2477,7 +2467,7 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     bfloat16_unpack_canonical(&pa, a, status);
     bfloat16_unpack_canonical(&pb, b, status);
     bfloat16_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &bfloat16_params, false);
@@ -2495,7 +2485,7 @@ float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
     float128_unpack_canonical(&pa, a, status);
     float128_unpack_canonical(&pb, b, status);
     float128_unpack_canonical(&pc, c, status);
-    pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    pr = parts128_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
     parts128_uncanon(pr, status, &float128_params, false);
@@ -5442,7 +5432,7 @@ float32 float32_exp2(float32 a, float_status *status)
     for (i = 0 ; i < 15 ; i++) {
 
         float64_unpack_canonical(&tp, float32_exp2_coefficients[i], status);
-        rp = *parts_muladd_scalbn(&tp, &xnp, &rp, 0, 0, status);
+        rp = *parts64_muladd_scalbn(&tp, &xnp, &rp, 0, 0, status);
         xnp = *parts64_mul(&xnp, &xp, status);
     }
 
@@ -5522,8 +5512,8 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
 
         /* Compute precise remainder */
         r_precise_buf = *b;
-        r_precise = parts_muladd_scalbn(&r_precise_buf, n, a, 0,
-                                        float_muladd_negate_product, status);
+        r_precise = parts64_muladd_scalbn(&r_precise_buf, n, a, 0,
+                                          float_muladd_negate_product, status);
 
         /* Round remainder to the target format */
         *r = *r_precise;
-- 
2.43.0


