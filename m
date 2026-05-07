Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30531CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EP-0004Yn-UZ; Thu, 07 May 2026 12:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EN-0004XN-R4
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:43 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EH-0006mi-Vm
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:43 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so880103a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169934; x=1778774734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSirLqg+eoCEVy2NLoXGDlcn1OQG2DK2SCPMSNz0HxE=;
 b=jHVc5O+osJ7doKJbp421/U6o+xTBtu4XhpgRCe76ANTpMYo9NVa7gtkrVYtH7gT0LQ
 +hXlGdOObHvnixHrnW8WtziLAkXXjceDB2yBjqK4UtNzf4k1mVBsqcX4G9MUTbzA09bz
 U+CTHwqU0qqOb4ic/ZhKNMdYokq/v0ElvAoo6UbrD+yjC0dk2Eys1Cqg7iFIl1zbIXAj
 N37+RMSHlOJGRIfDuYNIAwWoIrqdrX6Zvp1qGAoDFDvrEchc6t8OtUEtlwxWtStLU0b8
 B/t5okZqo+WlpRWZNDyLv6eeelx83Pz9VWIAVAHjuA62Tiu/cGDcQtmfeeCTTBWTRE79
 nfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169934; x=1778774734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CSirLqg+eoCEVy2NLoXGDlcn1OQG2DK2SCPMSNz0HxE=;
 b=GZdROOWJn756tAKldbUpITdF+d/ltikkbfZDpG5rV+LxJqx+yFzwadRsCFmOtGD/jm
 uNngGC/V0zwU2hxvHgiY7j9/emDXTbAL+/+YTH9ZUPUN7V82jkewnY1ckyPyhNCXEhcE
 R//la63yyx/51o6Ucec5Ndb5Ix2FNbNu9Pb3+PhBpi7QbPow9e2IvrS38ZAOYxhKPEi0
 CfSQu2hQCDEJ72kNl+Ncw/hg8/OM44B9E5xEWUmqynKzDrtWbEbRgpd7Kc88Ncdagl03
 Vr+yilX++H3keuk6FIkvMBhGzlKGuMxMnnyV1JFkU7yQ/AqbSmdxmOC0fiFyV8NKH9DF
 GqEg==
X-Gm-Message-State: AOJu0YxwgoSmr8YFiO1TjrOjHCWOQExmzZnutg89JsuQQK99LmXTsAyH
 Eimf0lbMdzfqWbgnQR/UAKs2h45E0IMRocuVjPzz+YxqJfk7JyFcSPKx3rBE4XaPPuJXZ7iBBww
 +bM39
X-Gm-Gg: AeBDietR51yBLDd4kyyQeFW3brHk5kIPn/TADwHkn8QhA9k7w4MQkdUzhAqZm6KfWWG
 uV/ySSYYOm92iqwS8zSIP73sIznAGPD5IMNjyQh2OJ0MIGdGRetUQ7Dq8dvINmhW5YjhXJ7abXG
 Cfgq/tmFEBx2Uw+/xzIZw6YbTBI8l58enG5z4II6Zfq5jDvAhBpxfbKy4h0n5YhT56oKfTA7sBq
 Ra81iJ4A5C2WWD2Ds5XBQlErH5ZkNfvGyjLj5P5j53cntGV2RPB1XHYAJ8y4+Hla+VoExGtv6vU
 lrkSUkSPLViuT8KmiNS50fZR+tiH5LAFw5bZ4bVRddlRhdXeio311E1utrh5rl4XodGDdMps14N
 cUwlDMpO1n2rJgQ9Gzal0NoAUTiNsWRKg2SHq1VTBLV5wQJW1VV3+6pff6KaMth3wtSIup9XtEy
 qfVEgcvXD8UUTtbRXiFXV9VfJ6r/qIyLJx9yBjmA3cX2dvjA==
X-Received: by 2002:a05:6830:2b1f:b0:7dc:cd0b:58bc with SMTP id
 46e09a7af769-7e1def2b2bfmr5291623a34.7.1778169934068; 
 Thu, 07 May 2026 09:05:34 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/29] fpu: Export unpack_canonical and round_pack_canonical
 routines
Date: Thu,  7 May 2026 11:04:59 -0500
Message-ID: <20260507160518.444797-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

Export the unpacking and repacking into the various formats.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h | 30 ++++++++++++++++++++++
 fpu/softfloat.c               | 47 ++++++++++++++---------------------
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index a3ae12bb45..f631c38c79 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -133,4 +133,34 @@ typedef struct {
     uint64_t frac_lo;
 } FloatParts128;
 
+/*
+ * Unpack routines from a specific floating-point format.
+ */
+
+FloatParts64 float4_e2m1_unpack_canonical(float4_e2m1 f, float_status *s);
+FloatParts64 float8_e4m3_unpack_canonical(float8_e4m3 f, float_status *s);
+FloatParts64 float8_e5m2_unpack_canonical(float8_e5m2 f, float_status *s);
+FloatParts64 float16_unpack_canonical(float16 f, float_status *s);
+FloatParts64 bfloat16_unpack_canonical(bfloat16 f, float_status *s);
+FloatParts64 float32_unpack_canonical(float32 f, float_status *s);
+FloatParts64 float64_unpack_canonical(float64 f, float_status *s);
+FloatParts128 float128_unpack_canonical(float128 f, float_status *s);
+/* Returns false if the encoding is invalid. */
+bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f, float_status *s);
+
+/*
+ * Pack routines to a specific floating-point format.
+ */
+
+float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p, float_status *s,
+                                             bool saturate);
+float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p, float_status *s,
+                                             bool saturate);
+float16 float16_round_pack_canonical(FloatParts64 *p, float_status *s);
+bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p, float_status *s);
+float32 float32_round_pack_canonical(FloatParts64 *p, float_status *s);
+float64 float64_round_pack_canonical(FloatParts64 *p, float_status *s);
+float128 float128_round_pack_canonical(FloatParts128 *p, float_status *s);
+floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s);
+
 #endif
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d3277e3f60..b857c13d91 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1296,21 +1296,21 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
-static FloatParts64 float4_e2m1_unpack_canonical(float4_e2m1 f, float_status *s)
+FloatParts64 float4_e2m1_unpack_canonical(float4_e2m1 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&float4_e2m1_params, f);
     parts64_canonicalize(&p, s, &float4_e2m1_params);
     return p;
 }
 
-static FloatParts64 float8_e4m3_unpack_canonical(float8_e4m3 f, float_status *s)
+FloatParts64 float8_e4m3_unpack_canonical(float8_e4m3 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&float8_e4m3_params, f);
     parts64_canonicalize(&p, s, &float8_e4m3_params);
     return p;
 }
 
-static FloatParts64 float8_e5m2_unpack_canonical(float8_e5m2 f, float_status *s)
+FloatParts64 float8_e5m2_unpack_canonical(float8_e5m2 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&float8_e5m2_params, f);
     parts64_canonicalize(&p, s, &float8_e5m2_params);
@@ -1325,29 +1325,27 @@ static FloatParts64 float16a_unpack_canonical(float16 f, float_status *s,
     return p;
 }
 
-static FloatParts64 float16_unpack_canonical(float16 f, float_status *s)
+FloatParts64 float16_unpack_canonical(float16 f, float_status *s)
 {
     return float16a_unpack_canonical(f, s, &float16_params);
 }
 
-static FloatParts64 bfloat16_unpack_canonical(bfloat16 f, float_status *s)
+FloatParts64 bfloat16_unpack_canonical(bfloat16 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&bfloat16_params, f);
     parts64_canonicalize(&p, s, &bfloat16_params);
     return p;
 }
 
-static float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p,
-                                                    float_status *s,
-                                                    bool saturate)
+float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p, float_status *s,
+                                             bool saturate)
 {
     parts64_uncanon(p, s, &float8_e4m3_params, saturate);
     return pack_raw64(p, &float8_e4m3_params);
 }
 
-static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
-                                                    float_status *s,
-                                                    bool saturate)
+float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p, float_status *s,
+                                             bool saturate)
 {
     parts64_uncanon(p, s, &float8_e5m2_params, saturate);
     return pack_raw64(p, &float8_e5m2_params);
@@ -1361,42 +1359,38 @@ static float16 float16a_round_pack_canonical(FloatParts64 *p,
     return pack_raw64(p, &float16_params);
 }
 
-static float16 float16_round_pack_canonical(FloatParts64 *p,
-                                            float_status *s)
+float16 float16_round_pack_canonical(FloatParts64 *p, float_status *s)
 {
     return float16a_round_pack_canonical(p, s, &float16_params);
 }
 
-static bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p,
-                                              float_status *s)
+bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p, float_status *s)
 {
     parts64_uncanon(p, s, &bfloat16_params, false);
     return pack_raw64(p, &bfloat16_params);
 }
 
-static FloatParts64 float32_unpack_canonical(float32 f, float_status *s)
+FloatParts64 float32_unpack_canonical(float32 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&float32_params, f);
     parts64_canonicalize(&p, s, &float32_params);
     return p;
 }
 
-static float32 float32_round_pack_canonical(FloatParts64 *p,
-                                            float_status *s)
+float32 float32_round_pack_canonical(FloatParts64 *p, float_status *s)
 {
     parts64_uncanon(p, s, &float32_params, false);
     return pack_raw64(p, &float32_params);
 }
 
-static FloatParts64 float64_unpack_canonical(float64 f, float_status *s)
+FloatParts64 float64_unpack_canonical(float64 f, float_status *s)
 {
     FloatParts64 p = unpack_raw64(&float64_params, f);
     parts64_canonicalize(&p, s, &float64_params);
     return p;
 }
 
-static float64 float64_round_pack_canonical(FloatParts64 *p,
-                                            float_status *s)
+float64 float64_round_pack_canonical(FloatParts64 *p, float_status *s)
 {
     parts64_uncanon(p, s, &float64_params, false);
     return pack_raw64(p, &float64_params);
@@ -1451,23 +1445,21 @@ static float64 float64r32_round_pack_canonical(FloatParts64 *p,
     return float64r32_pack_raw(p);
 }
 
-static FloatParts128 float128_unpack_canonical(float128 f, float_status *s)
+FloatParts128 float128_unpack_canonical(float128 f, float_status *s)
 {
     FloatParts128 p = float128_unpack_raw(f);
     parts128_canonicalize(&p, s, &float128_params);
     return p;
 }
 
-static float128 float128_round_pack_canonical(FloatParts128 *p,
-                                              float_status *s)
+float128 float128_round_pack_canonical(FloatParts128 *p, float_status *s)
 {
     parts128_uncanon(p, s, &float128_params, false);
     return float128_pack_raw(p);
 }
 
 /* Returns false if the encoding is invalid. */
-static bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f,
-                                      float_status *s)
+bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f, float_status *s)
 {
     /* Ensure rounding precision is set before beginning. */
     switch (s->floatx80_rounding_precision) {
@@ -1503,8 +1495,7 @@ static bool floatx80_unpack_canonical(FloatParts128 *p, floatx80 f,
     return true;
 }
 
-static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
-                                              float_status *s)
+floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s)
 {
     const FloatFmt *fmt = &floatx80_params[s->floatx80_rounding_precision];
     uint64_t frac;
-- 
2.43.0


