Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA8DFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzit-0006xZ-4f; Sun, 26 Apr 2026 09:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzil-0006tQ-99
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzih-0008JP-72
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b2ea1b3962so53559515ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210822; x=1777815622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KAbrnKtdB2obY97v0/ml9qt9upYXt9w/FfYgYu/A0Y=;
 b=UdJJGtWA2UHep/T01rHJHUfx602TN0eQvhNyv6uKYiAMMveN3E+I7XHSlY2nktnPvY
 T/zw0B8R1EHmz5ehZhigBfQYtTKdwB6HRaDt3wi2hf5lHXxWUDQTldKYj9f6eti/wCqg
 CnziWP6Yr8maO+aFbTCt258eYZiOuGjn+JMczUPQS6/8o1jYu5sPIc8BDJp/gW1M8mEd
 r/umj8dU4G5p6z2Nb2zXzN3EDdbnd2YkqZH+lhfq6IBMviyQ1XVVR2S2BVMCke76jE1+
 HQF3QKN2jilok/Qb6dsKpMjOPyJYy5H+1YJlasbGvVQWl8L/sbKLwQR/1JXY4vTeU84f
 71gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210822; x=1777815622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9KAbrnKtdB2obY97v0/ml9qt9upYXt9w/FfYgYu/A0Y=;
 b=qu3ZIdAElSE2Gjc26HL8wd3vCKfxQW/H8kHBDikF+cy3eNM3Sx5jEwqwLRTNWXS0B4
 qhG0PbWoyeZLQR4jcR0L44efD7qObWJ4hswlFv3zakVJgYJTmumoKnuCdVbuHF/mX/TI
 nlS8/DQhiCLn4RDkXtL0UfQV+SiHDMKUCZJCqh3poYAtKykP2EJGzX4ywZuuKF2DftrA
 rDksTExFP0jkPLlxvpK9z9ewbvOgYGtLc/Nhjm5g2CRnFnWJPI765/ZhzGMS8ycnTBrz
 ZN0ye3DIoE6hUdyekZwuqOUqO8dyNx2gt+TDgOU/xVeFyI79y66n/oBVMUEaaKoblCe5
 Xv3g==
X-Gm-Message-State: AOJu0Yzvx1txXB1jpjBSzqtZae3nKz27pOvyWDokDCOnWHSFzPqXxSmy
 AhOB0N4iJRaFLPlyawfeslGjjSxmOxU5GBIw1IKQ1kgiW/7/wr3Fem0/MYg68gFpmUf1YvsS3yZ
 y+fbA80o=
X-Gm-Gg: AeBDies3o6kMWN53w7ZN4JBFNFCLkmeJtcMLDu/bGIdxjk6jywIZQBe27SCYklMpuv7
 l/CPf//bJ185Mj+gsttnzayVil3W64ICqLinRg+56HJtt1tWNfK56pTVR/7vJGZRmFAmRURxNuc
 8m+xVJvIDytTUu+MCb17riRMpTghUvlTsiwgaTCyfFT4dWTlLXUDCFV/Jvs52jIBo+dGyl9NBq7
 OnoRe+/+8wAmF3RIbe/4SjPYYv99JlALaDjOHiF/5M2QEzhjDPbYyA7m6yY4kGGqTOeg2qh2g1C
 WBXtfRJjn8IIgF9Bo4ut2p/gRmyRxD/iMT7kS2fDW65iyR5XkqxMLKspMTv7uP0kmBA5WlSqnSQ
 aQ+OVyjwKi3UVHwfsm+x6oXK/XmsbHFtmCeKiMzYx/XlToYIvsc8JqWpzrdA7g/EkDTcjvmW4N3
 rhhQ59H/PCKTBdSjbrgndIGp94IWOD3WnUuAkb5VSu
X-Received: by 2002:a17:903:328b:b0:2b2:4bf9:1766 with SMTP id
 d9443c01a7336-2b5f9fe5d26mr312490405ad.33.1777210821683; 
 Sun, 26 Apr 2026 06:40:21 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 05/84] fpu: Drop parts_silence_nan
Date: Sun, 26 Apr 2026 23:38:42 +1000
Message-ID: <20260426134002.865628-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Use parts{64,128}_silence_nan at each call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 12 +++++-------
 fpu/softfloat-parts.c.inc |  6 +++---
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 76c1d4e38a..571b5f09f3 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,8 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-#define parts_silence_nan(P, S)    PARTS_GENERIC_64_128(silence_nan, P)(P, S)
-
 static void parts64_return_nan(FloatParts64 *a, float_status *s);
 static void parts128_return_nan(FloatParts128 *a, float_status *s);
 
@@ -5034,7 +5032,7 @@ float16 float16_silence_nan(float16 a, float_status *status)
 
     float16_unpack_raw(&p, a);
     p.frac <<= float16_params.frac_shift;
-    parts_silence_nan(&p, status);
+    parts64_silence_nan(&p, status);
     p.frac >>= float16_params.frac_shift;
     return float16_pack_raw(&p);
 }
@@ -5045,7 +5043,7 @@ float32 float32_silence_nan(float32 a, float_status *status)
 
     float32_unpack_raw(&p, a);
     p.frac <<= float32_params.frac_shift;
-    parts_silence_nan(&p, status);
+    parts64_silence_nan(&p, status);
     p.frac >>= float32_params.frac_shift;
     return float32_pack_raw(&p);
 }
@@ -5056,7 +5054,7 @@ float64 float64_silence_nan(float64 a, float_status *status)
 
     float64_unpack_raw(&p, a);
     p.frac <<= float64_params.frac_shift;
-    parts_silence_nan(&p, status);
+    parts64_silence_nan(&p, status);
     p.frac >>= float64_params.frac_shift;
     return float64_pack_raw(&p);
 }
@@ -5067,7 +5065,7 @@ bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
 
     bfloat16_unpack_raw(&p, a);
     p.frac <<= bfloat16_params.frac_shift;
-    parts_silence_nan(&p, status);
+    parts64_silence_nan(&p, status);
     p.frac >>= bfloat16_params.frac_shift;
     return bfloat16_pack_raw(&p);
 }
@@ -5078,7 +5076,7 @@ float128 float128_silence_nan(float128 a, float_status *status)
 
     float128_unpack_raw(&p, a);
     frac_shl(&p, float128_params.frac_shift);
-    parts_silence_nan(&p, status);
+    parts128_silence_nan(&p, status);
     frac_shr(&p, float128_params.frac_shift);
     return float128_pack_raw(&p);
 }
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 37ce731101..0d4a63fbff 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -23,7 +23,7 @@ static void partsN(return_nan)(FloatPartsN *a, float_status *s)
         if (s->default_nan_mode) {
             partsN(default_nan)(a, s);
         } else {
-            parts_silence_nan(a, s);
+            partsN(silence_nan)(a, s);
         }
         break;
     case float_class_qnan:
@@ -109,7 +109,7 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        parts_silence_nan(ret, s);
+        partsN(silence_nan)(ret, s);
     }
     return ret;
 }
@@ -179,7 +179,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        parts_silence_nan(ret, s);
+        partsN(silence_nan)(ret, s);
     }
     return ret;
 
-- 
2.43.0


