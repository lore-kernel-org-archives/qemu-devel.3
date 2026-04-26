Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1988FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjG-0007As-4R; Sun, 26 Apr 2026 09:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzj9-00075F-JD
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:51 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzj7-0008QS-2C
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:51 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c79467f128cso3450969a12.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210848; x=1777815648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8b2W9gnYSMYefVuUFksO85W3oVzQ2QH9P08u6esF1Pc=;
 b=igbknsB2XASvMr8/uyiqr80p6lgkY66IFZEOF6ftr8Xxm+AJwPat6q8YL41p8SdzL/
 QHyaiISRrMfjfWXVcamZwQ4P6FGwpWjGwulW9lmA6zFRFIjNTLjg9sPcjIoC5EiWKOUL
 jvLKGR4ku/Hz7VcQTvhM/aKzoBnERB4XAMqQd6Nn6PNUzlXaqoTs3Iw5ysRz5+Ii1Mk5
 GYq7GmQVTCrk1UUZZdY5gvEQmJ24B5lm33Dqz0SeiaveeFpPHtti2PInh4rMa/HSm7hw
 5wa1Y0ReP2eDQ6HYEfF4wSWUjfNiurKIJ98VrJ2nvXXTIfupHl6PrnRLVdMiNePn5gQt
 XMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210848; x=1777815648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8b2W9gnYSMYefVuUFksO85W3oVzQ2QH9P08u6esF1Pc=;
 b=mpv1jfirnpsXCz72nm2HVk1tNWpQuNKoEG8smCJqlQP6/iOSo+zX2JOY30BTjCljB7
 fCBwq52rKn5TO+p05c/7ePruzFsbGNLD5BovMs8RTxVD7rBII7NSBbFiuByCHfdMa5Nq
 WEn/NBmfYJqk0LrdFS2SxoEacM/ma0AQjnPX5Mh9ZH/quGbk17MX+6UQhWmi3jm+a7s1
 Q+EawcjRUhPRtkH9g9ZaJjjBjNIEzQM/PrinqYPOjemSmj95G9QzW2TZq1sDRPjdflQP
 gnwK98kSqTyosBy66vkAvePfXJow4d3fVjL1DZAUoOSmZDm0IcfqG3X5kYt52wb2rMFZ
 hpoA==
X-Gm-Message-State: AOJu0YwSfo0jwNBIc9M4Uhn6ub0UV+7byZHhm9ozLk1PV+92mGowzSft
 uOeCWmnBb5q1K1gYEFKfkspTPd23SYTn/w+NiT/mV09hmCtSQGa6GypfnsxBBXv1tFHnFaeJmy3
 oc6ktxd0=
X-Gm-Gg: AeBDiesSdCYofSuhCU1ZMlLgmz52Iylyvri8eKOdKbP1BzDLsCJOCF7SdIbFpLwCsUH
 G+llVSsS1rXktjulnvAtP5pGC9RHH8wzPLaUXtaOl7H1DhvEEVaWOcxiT1s0/Bf6Wf7upNReNjH
 wmmunakdLjd2QyCDQxPsqbH6mXqhj84CwNatXj8c2wPJRr8cjJn34cIhPojUrBllfSkwh4BTHUX
 WD3XvfLPmI2Lv1tOoNbH+/Ryq75ghEHa/xL8jTS2ssUuP/APrr4i8EwTUcZ4aLowq7pJcDkPlMk
 Olh2Su8I7KTyisSgltZCSvrUPreRz6SBwxK9fw+wKxpXNlNH8zHAUXYEBrB4EgruAJLFTXbINyH
 wC4iSPnvkfg+DhUQRdNbtTF9s7A7Jt7iRp2OaldliUF857k3FMWH3tarX7BbHUKby5vGBvwnR45
 KH0ZHCESRIlPr9mk4hJj6GoWAVzEO1AMJD4u7Vi5WV
X-Received: by 2002:a17:903:17c3:b0:2b0:708f:4dc7 with SMTP id
 d9443c01a7336-2b5f9f3b367mr433182745ad.29.1777210847608; 
 Sun, 26 Apr 2026 06:40:47 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 15/84] fpu: Drop parts_modrem
Date: Sun, 26 Apr 2026 23:38:52 +1000
Message-ID: <20260426134002.865628-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Use parts{64,128}_modrem at each call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b885eae629..91d8e48ce4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_modrem(FloatParts64 *a, FloatParts64 *b,
-                                    uint64_t *mod_quot, float_status *s);
-static FloatParts128 *parts128_modrem(FloatParts128 *a, FloatParts128 *b,
-                                      uint64_t *mod_quot, float_status *s);
-
-#define parts_modrem(A, B, Q, S) \
-    PARTS_GENERIC_64_128(modrem, A)(A, B, Q, S)
-
 static void parts64_sqrt(FloatParts64 *a, float_status *s, const FloatFmt *f);
 static void parts128_sqrt(FloatParts128 *a, float_status *s, const FloatFmt *f);
 
@@ -2642,7 +2634,7 @@ float32 float32_rem(float32 a, float32 b, float_status *status)
 
     float32_unpack_canonical(&pa, a, status);
     float32_unpack_canonical(&pb, b, status);
-    pr = parts_modrem(&pa, &pb, NULL, status);
+    pr = parts64_modrem(&pa, &pb, NULL, status);
 
     return float32_round_pack_canonical(pr, status);
 }
@@ -2653,7 +2645,7 @@ float64 float64_rem(float64 a, float64 b, float_status *status)
 
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
-    pr = parts_modrem(&pa, &pb, NULL, status);
+    pr = parts64_modrem(&pa, &pb, NULL, status);
 
     return float64_round_pack_canonical(pr, status);
 }
@@ -2664,7 +2656,7 @@ float128 float128_rem(float128 a, float128 b, float_status *status)
 
     float128_unpack_canonical(&pa, a, status);
     float128_unpack_canonical(&pb, b, status);
-    pr = parts_modrem(&pa, &pb, NULL, status);
+    pr = parts128_modrem(&pa, &pb, NULL, status);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -2688,7 +2680,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
-    pr = parts_modrem(&pa, &pb, mod ? quotient : NULL, status);
+    pr = parts128_modrem(&pa, &pb, mod ? quotient : NULL, status);
 
     return floatx80_round_pack_canonical(pr, status);
 }
-- 
2.43.0


