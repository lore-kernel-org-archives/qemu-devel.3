Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE57FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLR-000093-Q4; Wed, 29 Apr 2026 18:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLP-00008K-U7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLO-0004ox-4M
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so1706595ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501520; x=1778106320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fk4LVgA4H/YvbA+lA5J1oGuNn1ZmeLVjbkEn+60TJ6g=;
 b=zuIAW2XW1fAgoD533Nxz/F68EBS5lSjEIHDmUYo3IbOo0U29w/qWsKLt3c0hF7Jl6z
 lVxR++WJCp36rfZgnTtiugaMMK7doOT1pAzpeF0IhgnsVV63HLKfKKtyAEYV9R9KmIGd
 ioDSjeJU2n8SsQPQB6PgOylUawmVVx5p6i1L/lXk9I86qJdYz3z9mzD4Pl6gXeQnOrgz
 1MxEavD1GA4Ou3WV37dwcCDYGo1TjRZNbzpA2jKDroKZ3YuUMRvRtPg2tUrH3+82XY9/
 iHNJ1N2183rlNPCWjacfbEade0aGOXh8FCluFm4d+AarEMCx4LQwtyBPw9++tQ+2FT9a
 ntZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501520; x=1778106320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fk4LVgA4H/YvbA+lA5J1oGuNn1ZmeLVjbkEn+60TJ6g=;
 b=VGjR8GhkZRKgBrl1vVa3Eaq44f49uDnFO/YrQeHmem4IHQfQY9CAwUELMTevKWGc44
 qqiVfaBQcby3Y6IV0Zq5aC3g3AJ2yq8QtXe0C162orbtaoejMjWIuMotB1CAux3r6JLi
 vPhVloXDnbPYeZSg/gKROjfa6ERQYh/Eaj2d9MiuLmCVDcGW8P4S4f/LGwO7a5BA4b0+
 bV+yEBnV96g7V248ndW/npuH/wtU5KKmg3cEDyPBjLW5j3DtbZmYFs41YyLxyr+5GT3N
 FS5rtl0yMJq9vFAExbLmFGes3T8sEzTa9w1vbTUsH+Y7sABq+GcViI2Dua6IgvMORUvD
 MLzw==
X-Gm-Message-State: AOJu0YxyZuC8lF6bgdHGBEtwK5A+abCsqLYBodxs4Lilqtr9UgUBAUZH
 mUtP8wCDDR8VeSZtfcK3tiebrgEG024Ebm6DNwhrmHmyS15mcx3OAUaN/G31GvwnSzHxXFXUeFN
 cNY0F4W0=
X-Gm-Gg: AeBDieuIUZwsUh2AMo5CjttqbrHNMlldQVACs+BusPHtGMc+D/70uJipvlTiKv+FaJX
 PW9vlSKfp7BNozWhLsKbUW91wWaQml/RmfPi1THlnypexVW8d7P4Ydm5Cg26tv4PxbgTITM/oYi
 Qig2GClvZnSv2MzQubSQRiGlXhelwJBIiXMP3TBm9OMy/oJr5yHmphOT4hUoYIEX+3AKijZu33Y
 yFaFtl+1nthArvDsRuDNr3Pz9XdRaqnklYnJvxaz1vsqwHN//oP+FLblYjR37sOoP49YNQ7+kdX
 8hJM1DMAThoDZhwEbemFPwMkl+Amr0pvUsRq7A7U2eNVj42wohIAMjK+u9s+Aw6Ozp9sSNMlsBp
 c2AWLpiaoc82Zmd4+OeABWPvxK6Yl0L64gLzMFMknlrhpfpbmejHQztE8B5ZDQ3p8y0ST6ZZlVs
 jmDIcM/E5hEB80gLasQr78BLBY0zck68oDCtxJR0RG
X-Received: by 2002:a17:90b:2fc8:b0:364:87dd:b2c4 with SMTP id
 98e67ed59e1d1-364c32aa4bdmr144060a91.25.1777501520004; 
 Wed, 29 Apr 2026 15:25:20 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/48] fpu: Drop parts_addsub
Date: Thu, 30 Apr 2026 08:24:08 +1000
Message-ID: <20260429222445.26301-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Use parts{64,128}_addsub at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 117c335d66..dc5ce53105 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_addsub(FloatParts64 *a, FloatParts64 *b,
-                                    float_status *s, bool subtract);
-static FloatParts128 *parts128_addsub(FloatParts128 *a, FloatParts128 *b,
-                                      float_status *s, bool subtract);
-
-#define parts_addsub(A, B, S, Z) \
-    PARTS_GENERIC_64_128(addsub, A)(A, B, S, Z)
-
 static FloatParts64 *parts64_mul(FloatParts64 *a, FloatParts64 *b,
                                  float_status *s);
 static FloatParts128 *parts128_mul(FloatParts128 *a, FloatParts128 *b,
@@ -1923,7 +1915,7 @@ float16_addsub(float16 a, float16 b, float_status *status, bool subtract)
 
     float16_unpack_canonical(&pa, a, status);
     float16_unpack_canonical(&pb, b, status);
-    pr = parts_addsub(&pa, &pb, status, subtract);
+    pr = parts64_addsub(&pa, &pb, status, subtract);
 
     return float16_round_pack_canonical(pr, status);
 }
@@ -1945,7 +1937,7 @@ soft_f32_addsub(float32 a, float32 b, float_status *status, bool subtract)
 
     float32_unpack_canonical(&pa, a, status);
     float32_unpack_canonical(&pb, b, status);
-    pr = parts_addsub(&pa, &pb, status, subtract);
+    pr = parts64_addsub(&pa, &pb, status, subtract);
 
     return float32_round_pack_canonical(pr, status);
 }
@@ -1967,7 +1959,7 @@ soft_f64_addsub(float64 a, float64 b, float_status *status, bool subtract)
 
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
-    pr = parts_addsub(&pa, &pb, status, subtract);
+    pr = parts64_addsub(&pa, &pb, status, subtract);
 
     return float64_round_pack_canonical(pr, status);
 }
@@ -2064,7 +2056,7 @@ static float64 float64r32_addsub(float64 a, float64 b, float_status *status,
 
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
-    pr = parts_addsub(&pa, &pb, status, subtract);
+    pr = parts64_addsub(&pa, &pb, status, subtract);
 
     return float64r32_round_pack_canonical(pr, status);
 }
@@ -2086,7 +2078,7 @@ bfloat16_addsub(bfloat16 a, bfloat16 b, float_status *status, bool subtract)
 
     bfloat16_unpack_canonical(&pa, a, status);
     bfloat16_unpack_canonical(&pb, b, status);
-    pr = parts_addsub(&pa, &pb, status, subtract);
+    pr = parts64_addsub(&pa, &pb, status, subtract);
 
     return bfloat16_round_pack_canonical(pr, status);
 }
@@ -2108,7 +2100,7 @@ float128_addsub(float128 a, float128 b, float_status *status, bool subtract)
 
     float128_unpack_canonical(&pa, a, status);
     float128_unpack_canonical(&pb, b, status);
-    pr = parts_addsub(&pa, &pb, status, subtract);
+    pr = parts128_addsub(&pa, &pb, status, subtract);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -2133,7 +2125,7 @@ floatx80_addsub(floatx80 a, floatx80 b, float_status *status, bool subtract)
         return floatx80_default_nan(status);
     }
 
-    pr = parts_addsub(&pa, &pb, status, subtract);
+    pr = parts128_addsub(&pa, &pb, status, subtract);
     return floatx80_round_pack_canonical(pr, status);
 }
 
-- 
2.43.0


