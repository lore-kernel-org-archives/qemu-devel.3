Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1774EFF8863
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjk-0008KY-7v; Sun, 26 Apr 2026 09:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjh-0008CL-I5
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:25 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjf-0000DC-Le
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b24fdac394so90561855ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210882; x=1777815682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyU4A+u0K627SpCWSf5AVXl3t/Ptjy14KhSD0YCWd3c=;
 b=IWZzAs3c9o8RDhmFXsGeSaw5NQ6ankOjEPC7USN6OyFr3xe2iDXkME0+hOJbeX7ZM2
 DEcs7dSkLHQPPYurt4TcWMPMXY8hZlD3BYhZL3AfiySwtEoThK3AyWotYru1MPh2yXxq
 YHKHyhQCDM7CfSwJlxylxAOI3hUbr1Itzg4Zh0Br8y1Q5168kwsRil+48mYt3t253deB
 w5XKth8R9abocOesZAhvoP9OUQHQJSfWSFSJnA9UELLOgnHUHK3v9KM8DsVYA3U49rzC
 OjFJV8NFBhvOUEDkkalhQMNMQOo+G41xVHIld5K7PWP+ibI3mhwowInajNzpG8cbVRe/
 0IAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210882; x=1777815682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NyU4A+u0K627SpCWSf5AVXl3t/Ptjy14KhSD0YCWd3c=;
 b=lrAEY598mAgqQPwRpQ6bMSIAbIsH3DBOe2hOTScgYWsqQSrTYqkC05ST2qY5OkbFXo
 l1ifATawKD25BLeP3sax8XOiyZ14mYRu7M5ZWEpK5TVyvUJY6iC0FQzKyql61SuEzkZr
 rManDohkT992fwFYRYtmSL0KYFWM/XAsuWZPdkSeAr+GYY2qFHY7IROlXPvFOj5xoPWd
 ET72lVoDcM8zapdpKlEoYjWBYP4lFeeNFKBliPSvUJZwVVPTBurPOaRLvXeC/mD0CSw7
 268F2XjfDVSaza4rYytDPZse8vZsTXkfGqMWov7YaEFud7nlH7FACtjJq+IAHb4qqghj
 5pdg==
X-Gm-Message-State: AOJu0YyQhFLPoOTrwyN9gKUsv8r4ouWv7pX+GJ+kr3PS3TEfcCnRCt8j
 53IvzaV0YcIOBH0M6ZBoULWzbvNzmOwCFrw/TcePUZ3c0bSZ/yNS1xuKHGJUBbp2SHsZizmp3BH
 XFa2NKKk=
X-Gm-Gg: AeBDievSjYArS1dIMjofAA1s1A59ubylEsD2S3mhtI/eogV75q59YIqsQXAzN3DGsj9
 a9w2QdpsSIe+GBPBCWfQ0H2DG5Q4vhaso8v8rY+01jHMh6lCO75Qu3/GZsmAdW1IR5oH5GPDhdk
 xy3V8zspN/f5xDIPM7/tT2z0Ot8X3gxXiLQbdD5XoLbpWuz3H4D9b585klXqL8HGViVEFMZ/TFi
 nMIlCbk07WGJSiFGwek+72ezAurJ18Ax+RI7M8O1fAp0mf8tIqT6ZoJkVz/0NPeMGwIKJWJQqTl
 gvApOXsZ5tmKkF7UMjGWzjjJS/VIxGxm5AQ4uDt3O4urdIM7DdGbRTbiusf1VWjJA8GaObxrs4x
 Ly2HTxaOttDuayHOJLfsZ/mElldHTc7XLt5gdamgkDML97hc4ncDVAJZpmkQJ97/tBqA659Ieh8
 rwPQAGbJ8poYQDiib1OQlhqd4l0j7+0g3a0c27GSYm1veGqe5pT5g=
X-Received: by 2002:a17:903:1cb:b0:2b4:5dad:2523 with SMTP id
 d9443c01a7336-2b5fa003d32mr418467575ad.35.1777210881931; 
 Sun, 26 Apr 2026 06:41:21 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 28/84] fpu: Drop parts_float_to_float
Date: Sun, 26 Apr 2026 23:39:05 +1000
Message-ID: <20260426134002.865628-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Use parts{64,128}_float_to_float at each call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6a38d161f7..b1c2f884fc 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2695,9 +2695,6 @@ static void parts128_float_to_float(FloatParts128 *a, float_status *s)
     }
 }
 
-#define parts_float_to_float(P, S) \
-    PARTS_GENERIC_64_128(float_to_float, P)(P, S)
-
 static void parts_float_to_float_narrow(FloatParts64 *a, FloatParts128 *b,
                                         float_status *s)
 {
@@ -2744,7 +2741,7 @@ float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
     FloatParts64 p;
 
     float4_e2m1_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float8_e4m3_round_pack_canonical(&p, s, false);
 }
 
@@ -2753,7 +2750,7 @@ bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
     FloatParts64 p;
 
     float8_e4m3_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -2762,7 +2759,7 @@ bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, float_status *s)
     FloatParts64 p;
 
     float8_e5m2_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -2772,7 +2769,7 @@ float32 float16_to_float32(float16 a, bool ieee, float_status *s)
     FloatParts64 p;
 
     float16a_unpack_canonical(&p, a, s, fmt16);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float32_round_pack_canonical(&p, s);
 }
 
@@ -2782,7 +2779,7 @@ float64 float16_to_float64(float16 a, bool ieee, float_status *s)
     FloatParts64 p;
 
     float16a_unpack_canonical(&p, a, s, fmt16);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float64_round_pack_canonical(&p, s);
 }
 
@@ -2791,7 +2788,7 @@ float8_e4m3 float32_to_float8_e4m3(float32 a, bool saturate, float_status *s)
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float8_e4m3_round_pack_canonical(&p, s, saturate);
 }
 
@@ -2811,7 +2808,7 @@ float16 float32_to_float16(float32 a, bool ieee, float_status *s)
 
     float32_unpack_canonical(&p, a, s);
     if (ieee) {
-        parts_float_to_float(&p, s);
+        parts64_float_to_float(&p, s);
         fmt = &float16_params;
     } else {
         parts_float_to_ahp(&p, s);
@@ -2826,7 +2823,7 @@ soft_float32_to_float64(float32 a, float_status *s)
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float64_round_pack_canonical(&p, s);
 }
 
@@ -2853,7 +2850,7 @@ float16 float64_to_float16(float64 a, bool ieee, float_status *s)
 
     float64_unpack_canonical(&p, a, s);
     if (ieee) {
-        parts_float_to_float(&p, s);
+        parts64_float_to_float(&p, s);
         fmt = &float16_params;
     } else {
         parts_float_to_ahp(&p, s);
@@ -2867,7 +2864,7 @@ float32 float64_to_float32(float64 a, float_status *s)
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float32_round_pack_canonical(&p, s);
 }
 
@@ -2876,7 +2873,7 @@ float8_e4m3 bfloat16_to_float8_e4m3(bfloat16 a, bool saturate, float_status *s)
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float8_e4m3_round_pack_canonical(&p, s, saturate);
 }
 
@@ -2894,7 +2891,7 @@ float32 bfloat16_to_float32(bfloat16 a, float_status *s)
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float32_round_pack_canonical(&p, s);
 }
 
@@ -2903,7 +2900,7 @@ float64 bfloat16_to_float64(bfloat16 a, float_status *s)
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return float64_round_pack_canonical(&p, s);
 }
 
@@ -2912,7 +2909,7 @@ bfloat16 float32_to_bfloat16(float32 a, float_status *s)
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -2921,7 +2918,7 @@ bfloat16 float64_to_bfloat16(float64 a, float_status *s)
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -2996,7 +2993,7 @@ float128 floatx80_to_float128(floatx80 a, float_status *s)
     FloatParts128 p;
 
     if (floatx80_unpack_canonical(&p, a, s)) {
-        parts_float_to_float(&p, s);
+        parts128_float_to_float(&p, s);
     } else {
         parts128_default_nan(&p, s);
     }
@@ -3028,7 +3025,7 @@ floatx80 float128_to_floatx80(float128 a, float_status *s)
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, s);
-    parts_float_to_float(&p, s);
+    parts128_float_to_float(&p, s);
     return floatx80_round_pack_canonical(&p, s);
 }
 
-- 
2.43.0


