Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB858FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLK-000073-7H; Wed, 29 Apr 2026 18:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLE-00005b-9O
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:13 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLC-0004mD-Ks
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:12 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35fc0d7c310so125435a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501509; x=1778106309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWM87T66PJDj61eh/+kk68S5TIssJMc4SE+XJlzZd4M=;
 b=B44MVBO/bMUsgfc1S6QWobYZoghh53GopC2RlEPBgF5GM4Cw+6h+kJ3eg4K9GwhuLM
 pH+nw1fC8fz5UzMw/XTBJ8/UqyNVTC8Yjnh04o7xWfJ1snCXcci2TiKldcWtTJC6IWoQ
 V8eev8QwWZ7CDTDFR4HX7wWs8lPHdZGKAoa04jiG6DO69EY/ZcJaQeviNpKbhi1lkzIR
 WhxGCK6BVBL0lK1/RWZpxMzbTSmosMsXZnbIEm3FJGNf+tpoa3Pe4nWLPT3yatwhTEZO
 n8JN1e0wZC5MsKQPUgnaqO9KDTB2FEhueVWI661cN675KE33ieoisvPeWwSRx/z9o1Hw
 lkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501509; x=1778106309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zWM87T66PJDj61eh/+kk68S5TIssJMc4SE+XJlzZd4M=;
 b=EI0Jvpq1jB6bcfOisfvx1EZ2BJWQol7CAc1kIiTw5vOBX9NpkWQkzn4Qd/hKlrb+4L
 h4lHW2nlAfaqGJ2hVR3CDFuhoLBjoFVCkbyN05IpXRWJet/Nl5fi+72R+eBfmAbMB4DC
 VE8xX5r3KjasUANzuEPzM3tHNlue4qtLpaYXxzteB2WVFqJ921EtMxbO8rUaZ7RwprLN
 9k4Pn0Cxrf/loxXL4L4PEP+9JL9VLE8WhRtk1TPA6UYsgyTNCpeXRzvwUpQA8prr7yx2
 DLNN7pOr9N8U/YDrDe7p8pwOzBGaun+zFstIkcOvF64l1Mhdlp3dBoFdoUDofPswGSdt
 Lz+w==
X-Gm-Message-State: AOJu0Yw7yhhE3LUURhBB0ghpWkfvgK0XbCV/X3UKsQRslbmiVKQ8XwDb
 ZUHYJuEpHsyMO4TCsMn1Qytt9xlJTPwSbzz2Vaf9idTYJp2loCCOaPHeh1rsiykvWdVF7lIFWt+
 l1kJIu6U=
X-Gm-Gg: AeBDietixOgd//OlWy0b4xhttY9sSkFtsjME6dXIULVgWFiSIge0A98z5E1ZjyWQzx2
 rKsCs/Pf1CoJ0Bykm/h5Y9MvEySz/WMnSbuM9tD7WLD/0iIinUKIkbuuRj4XJnnK5ke8FzZ+tPH
 yrdFsHKx3AnK+th/vKwrm+rfnTMZRB5EJZccvWmP7AembcEpqrziAeFvmme1hyBfFv49ce+mNs3
 DM984EKHOeV/eQHnUCk418pLYc5GxD1M9EeFeLbko1XplDuJKgb0kMne0QfNBiEamIF0cQt0ded
 nWDK8Hltf3W8qnnj1380iTayrFrOvvCQ9yUHU1mDPldeBiikSzN7l67E5YH+beHd8t0zcJJ09vN
 24i6egzZiRasTxGImNM6HDdUblR1ViqwuQSnxSmt5pz91eKY2Kh2urfkhzXXqoH4UKVKU1Pw6Gw
 7y4mnvwdul3FKr+yNSkLxNFXSv4wpBP6u3kBaJeWku
X-Received: by 2002:a17:90b:2f0f:b0:361:45df:102 with SMTP id
 98e67ed59e1d1-364c308d224mr157511a91.17.1777501509043; 
 Wed, 29 Apr 2026 15:25:09 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/48] fpu: Drop parts_pick_nan
Date: Thu, 30 Apr 2026 08:24:04 +1000
Message-ID: <20260429222445.26301-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Use parts{64,128}_pick_nan at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 11 ++---------
 fpu/softfloat-parts.c.inc | 10 +++++-----
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 50a625fd0a..98ddc00936 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,13 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_pick_nan(FloatParts64 *a, FloatParts64 *b,
-                                      float_status *s);
-static FloatParts128 *parts128_pick_nan(FloatParts128 *a, FloatParts128 *b,
-                                        float_status *s);
-
-#define parts_pick_nan(A, B, S)    PARTS_GENERIC_64_128(pick_nan, A)(A, B, S)
-
 static FloatParts64 *parts64_pick_nan_muladd(FloatParts64 *a, FloatParts64 *b,
                                              FloatParts64 *c, float_status *s,
                                              int ab_mask, int abc_mask);
@@ -5175,7 +5168,7 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    pr = parts_pick_nan(&pa, &pb, status);
+    pr = parts128_pick_nan(&pa, &pb, status);
     return floatx80_round_pack_canonical(pr, status);
 }
 
@@ -5525,7 +5518,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
 {
     /* POp table "Results: DIVIDE TO INTEGER (Part 1 of 2)" */
     if ((float_cmask(a->cls) | float_cmask(b->cls)) & float_cmask_anynan) {
-        *r = *parts_pick_nan(a, b, status);
+        *r = *parts64_pick_nan(a, b, status);
         *n = *r;
         *cc = 1;
     } else if (a->cls == float_class_inf || b->cls == float_class_zero) {
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3bde254bfe..1a2eb7852d 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -604,7 +604,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     return b;
 
  p_nan:
-    return parts_pick_nan(a, b, s);
+    return partsN(pick_nan)(a, b, s);
 }
 
 /*
@@ -646,7 +646,7 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return parts_pick_nan(a, b, s);
+        return partsN(pick_nan)(a, b, s);
     }
 
     /* Multiply by 0 or Inf */
@@ -832,7 +832,7 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return parts_pick_nan(a, b, s);
+        return partsN(pick_nan)(a, b, s);
     }
 
     if ((ab_mask & float_cmask_denormal) && b->cls != float_class_zero) {
@@ -890,7 +890,7 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return parts_pick_nan(a, b, s);
+        return partsN(pick_nan)(a, b, s);
     }
 
     /* Inf % N; N % 0 */
@@ -1592,7 +1592,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
             return is_nan(a->cls) ? b : a;
         }
 
-        return parts_pick_nan(a, b, s);
+        return partsN(pick_nan)(a, b, s);
     }
 
     if (ab_mask & float_cmask_denormal) {
-- 
2.43.0


