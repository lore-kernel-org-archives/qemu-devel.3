Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3605DFF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpb-0008Vc-TY; Sun, 26 Apr 2026 09:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoE-0005vr-Iw
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoC-0001Vw-C7
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:06 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso58280805ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211151; x=1777815951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NNGGFXJ7ObWl7bIfWdwNZWMHdVi1ldGDKtY92ZvWpw=;
 b=E80w3rIKvS/rOTtr3CxUGWcus2ziafgIM6bnJKJf9RYQxnvOemFO1OlvsvAlYTf08Q
 CPK0hmtsTZnEmuMTkqIT8DRd1nI9ETy0gpb14kPnnNR0DFkaoHokWYRdCCviB0Jr25/k
 VOnXlR4gKJPANE60G4vkqj9iV/TsPqIqEfnIgz7nwFcTvkYAwWZs3PslG1b66tWBbaiC
 sHBLYkiijVN/VWWvc9cg7IDTp6uzVideuKyCphCjY/m/A+AnkZQo8mBDHb4D1rmPmaVt
 FqDZatBp8Gi587Yfy6Wdg1fUWBfSuoWGkNkjLZ7wUO71B23EZ28+Oxk2tKgfTIcYGYUW
 BO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211151; x=1777815951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8NNGGFXJ7ObWl7bIfWdwNZWMHdVi1ldGDKtY92ZvWpw=;
 b=JvA2J0tzPngnW0VFaehSmsa73EMguoAgsfwY8LLnjXz0QI+cWIosLZXej+ZDM3O6JW
 3ho3ZziaFvKrOvPmmaZEdhjIoV7IxDxTD080U88AkXvtGC6OA5V/T0aOwOA7zb+/bEUe
 q1H05YkhKiD/zQoOXIT65BAiLpsQDmjGXSfNd3CnM8rEETUrgsmbnomMGZTpU3uw3Ac7
 mUUkFfeFsb+V9/asUqhMT6v2ggmQY93GtcFQf0rDQ7XRRRu1W6dz57YN/CHLZS1uGoeH
 Ymo0PyyztyCaicJ0g8lW44dOn01bMuv0YH8BnOKAML1oI4rzpBypovA/36y9APK4VXpE
 NlPw==
X-Gm-Message-State: AOJu0YxM6CIwHtYmEQHAAMBasXt7f5WJSinYFx2ubcwY2CbvVmeviGb6
 FbTSNvjbp1WoI1OB7swkz8/8MmjkOgf0ASd5RfZ3F+Pswno1N3i4LYUBu+r+OSUrZ54AJfm89kG
 mvXevHS0=
X-Gm-Gg: AeBDievWDZHtWDUCdv6MxVlX2SwGAelYnq86XFWW3/n6lY51DBpX85QVTL7eOBQ9X+t
 dxI1ClA7C2sHhmoZSFBqmZeAOoyBwl9nTLvFKfYMW09yUapV31vn02lF/dRuxcXre22CEuEWe/v
 0+DWz95w6Hw0hxhE3E08y2+FOpltImHgQcUWwq5CxbOXScb9jF242OdZmIuxApui2jTTrhj3GxH
 EsBgNsUCdzHW2h6LLAjNslKlYdSN3/xadj5Z4J09JYMceOSpTee+qc93/YQ+OXqNOl99vkI1R5g
 ItmTR1yED2wcicftJ16wL109yAGzXjtpjz/sKny7B6qGk/nM9tJJ6PFJKPwDyTzJmMPyTme2J/q
 ln9MAMIkLBPcFk3ek4cMFD1OWMPAuk9OaFpo6KWS7EYaGB6L+BCs4W3XIYd2PDHgo78RHsBkd+Z
 P4RYYYL/kcm5/mS39QM4AwZQu3mQDEV49Yny7xeWiWmXjEx6vACQk=
X-Received: by 2002:a17:903:b8f:b0:2b2:5857:583e with SMTP id
 d9443c01a7336-2b5f9fc0641mr399097725ad.31.1777211150695; 
 Sun, 26 Apr 2026 06:45:50 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 59/84] fpu: Export unpack_canonical and round_pack_canonical
 routines
Date: Sun, 26 Apr 2026 23:39:36 +1000
Message-ID: <20260426134002.865628-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


