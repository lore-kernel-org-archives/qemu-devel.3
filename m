Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD76FF8863
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjY-0007Xu-CB; Sun, 26 Apr 2026 09:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjW-0007XA-Eu
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjU-0000AF-Uh
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:14 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b24fede2acso61121015ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210872; x=1777815672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvvMXHNz6xEa3ixy+NaiuJcIjaQVFZoBWkjVagJ868o=;
 b=c2PfQxfaRWqvpLE0jW1ewfMm3YX26IqcSEk12FAoaYwVv4yvXg9ozXHVpXFPH3erFV
 Phntr+ThaMRK2IoeqImYk6+FQr3IAVLYARznReQ9JxaX4FhBnQ/ZhGrdDceAR9IDDikS
 0E/PwGeLHeJkrbi9PahfGsI+xBlJnE8XuhhMqDpwmR9fJthgZ+Ew95HsYtUYs7zU9XEV
 Sv3YJ9IsDfZ8YxM9FNR94wu4LlrSWOFXejWod6DXnhu+ZR53hzlQkqWDdptVJvq5MfJb
 0vF3DZdpgbHHoI/ITDaGZBMI9PRiFX7PXQEVJh+1gBlZN9v7B8PWpa0F4ZVUJ+KXs78n
 II6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210872; x=1777815672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZvvMXHNz6xEa3ixy+NaiuJcIjaQVFZoBWkjVagJ868o=;
 b=peVtI25ScLTe7r5X+TL9Ojewp0Ch2JDD7v6FJKIDbHz5LfgWFc6tx3OjC8363D7mjQ
 DWd38cjfzk3G4qCnhOgtHjpKdJapyjrO1nwjSnmkWv1wtjJVXC2Y4+r/uFP5xC00Jgyn
 W/PTz2DFQ5FZAo4rcEK8Kbtj+xfYsfGVhgY53+HUl1FLJnliF3WUXXpPY9YEu91RS4Pk
 YieUqx55J/X8x+wUjpSVR2oKxrFvhVnjSPejtPKscUJiTV7B1qN2AZryVqPltpifqrTT
 fFGaz/sc/qa2RIo5cErkQAXQ2dRyYbdzrdrsIA0bSenimt6RrrxWsV8EPanKyffAH/j5
 LdbQ==
X-Gm-Message-State: AOJu0Yzd5jYpt2VTMJ27/Xx0dar0/46ihY4ZXf6tNsvcHJUHXXHMfaDE
 F6OrgjWf4rD1ypEoMfFW+GOx4hAHJwiDphgbBTM1XnWWGKuxFK6+0oP/VnMLi24sGrkjRet9OqD
 7gIeAwy4=
X-Gm-Gg: AeBDievC5t3uIEKEwRAIn6h6vA45ycwG84rHWlMPFaX6ds6uf6hKQdQabJDYL3Pr0Rv
 N8hZ6rhxBfxkHE0C9JgELJjpB/MctttdX88Sjjq1VDkPUnS2xquPuquGkOeVhpbpoVl3bmN+6IG
 qRmhG859qiRy6qjXCHpTDbGeewYzez0GTZ/QUcRSMTIhiDHmjxC+XxVYSEm8LbuqaljUvoKSROl
 xd4NdGmPVwPOrAMOw5BKuGDNEkbPc/vkjbCuaPf6VZl9AI9myaiyFY3XnXV0HQC8B2kLRNbTXyJ
 3Wqr5L8QBfVoWCj5P1VVxZ9wlwp+JpZr43Giwlxl80EsHaD+p0ODU1AVoTwsUdsjOiERqyTUg3G
 lrurrulIFYOheccV/6uQuTn+CmGpMzTIopfj/tUinfQhBDQM4eSLU8W9TQikkTy3JW0MFGrB1Jp
 8pwlmL0leW3Ec9Ws5ffjyl7EghXJxw6pOZL27UWRF+
X-Received: by 2002:a17:903:3c24:b0:2b0:445a:8c7b with SMTP id
 d9443c01a7336-2b5f9edf973mr419368085ad.15.1777210871537; 
 Sun, 26 Apr 2026 06:41:11 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 24/84] fpu: Drop parts_minmax
Date: Sun, 26 Apr 2026 23:39:01 +1000
Message-ID: <20260426134002.865628-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Use parts{64,128}_minmax at each call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8d5f3c48e7..158d539376 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_minmax(FloatParts64 *a, FloatParts64 *b,
-                                    float_status *s, int flags);
-static FloatParts128 *parts128_minmax(FloatParts128 *a, FloatParts128 *b,
-                                      float_status *s, int flags);
-
-#define parts_minmax(A, B, S, F) \
-    PARTS_GENERIC_64_128(minmax, A)(A, B, S, F)
-
 static FloatRelation parts64_compare(FloatParts64 *a, FloatParts64 *b,
                                      float_status *s, bool q);
 static FloatRelation parts128_compare(FloatParts128 *a, FloatParts128 *b,
@@ -4417,7 +4409,7 @@ static float16 float16_minmax(float16 a, float16 b, float_status *s, int flags)
 
     float16_unpack_canonical(&pa, a, s);
     float16_unpack_canonical(&pb, b, s);
-    pr = parts_minmax(&pa, &pb, s, flags);
+    pr = parts64_minmax(&pa, &pb, s, flags);
 
     return float16_round_pack_canonical(pr, s);
 }
@@ -4429,7 +4421,7 @@ static bfloat16 bfloat16_minmax(bfloat16 a, bfloat16 b,
 
     bfloat16_unpack_canonical(&pa, a, s);
     bfloat16_unpack_canonical(&pb, b, s);
-    pr = parts_minmax(&pa, &pb, s, flags);
+    pr = parts64_minmax(&pa, &pb, s, flags);
 
     return bfloat16_round_pack_canonical(pr, s);
 }
@@ -4440,7 +4432,7 @@ static float32 float32_minmax(float32 a, float32 b, float_status *s, int flags)
 
     float32_unpack_canonical(&pa, a, s);
     float32_unpack_canonical(&pb, b, s);
-    pr = parts_minmax(&pa, &pb, s, flags);
+    pr = parts64_minmax(&pa, &pb, s, flags);
 
     return float32_round_pack_canonical(pr, s);
 }
@@ -4451,7 +4443,7 @@ static float64 float64_minmax(float64 a, float64 b, float_status *s, int flags)
 
     float64_unpack_canonical(&pa, a, s);
     float64_unpack_canonical(&pb, b, s);
-    pr = parts_minmax(&pa, &pb, s, flags);
+    pr = parts64_minmax(&pa, &pb, s, flags);
 
     return float64_round_pack_canonical(pr, s);
 }
@@ -4463,7 +4455,7 @@ static float128 float128_minmax(float128 a, float128 b,
 
     float128_unpack_canonical(&pa, a, s);
     float128_unpack_canonical(&pb, b, s);
-    pr = parts_minmax(&pa, &pb, s, flags);
+    pr = parts128_minmax(&pa, &pb, s, flags);
 
     return float128_round_pack_canonical(pr, s);
 }
-- 
2.43.0


