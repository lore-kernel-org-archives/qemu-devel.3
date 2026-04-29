Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE0EFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDMX-0004PW-Aw; Wed, 29 Apr 2026 18:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMV-0004BT-78
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:31 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMT-0005Lk-4a
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:30 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35fc2b18363so262146a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501588; x=1778106388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojbOEJ4Rn7hHdYGTXtFboDzmC4fpMqkcvECa+YSsNfY=;
 b=GQlzE3cWGSe6N1jsYL1UQ2LhXmQVkoKN35PtWhw+bxGBiAq1YPCI5y0xKRCDG9YUP5
 aYlZP+CRqxL/zdeHqi24aBdx4RH6NkhGaNpdLfS6RHqzOnVrQ8+Y8y1G0MHigZqNYrbb
 DtFTLxNdygcOgFOWM4zBOu1u8mMsgCNBQqVuSaGqqR0pgdBIqT2Lg6fuOism/XCqH/2v
 lwYIvWGMVZabuW2/YUDvDuhrouXa6gK8qrokpW32BkfRavwV17tfS/vWvEcSTCCI1whi
 BI5mSVHfERICPJFF/Ow6UxIWuqQ9Ge229UYbySATVT2bnOza8Ttpo2nWg/SL6+Z988jG
 S/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501588; x=1778106388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ojbOEJ4Rn7hHdYGTXtFboDzmC4fpMqkcvECa+YSsNfY=;
 b=Bah6L5cE0DWrLKENcVzhstTSfEkmc6Oi11st1p+XXyu5cVLz/7viQY8XGlHeVjMJdp
 TOCu3ERHVCLj4jjAV9tolDWjAe43knw80IiJcEAaYvqepu4gWylwSGI5TcCDIDVpdaA7
 1o9dnR3aQWGdKF+x/l/cN0NyqBzleO2IuteZFneVjj8zFytdK3dVN/DK7vjiAtnQ4kjT
 mw6vWfGyCLbjS/K8UOgPZCwPrl/NGg+roBhHk8mFUwXS+nw42bysQV/1QmsH35lOgIXa
 0crlEfSEli3ukY84djuTJXTrDTFsnwkvT4g7dAD7qOWtsbkkJUMU+7L+e6wz6g5mXxvk
 FdFQ==
X-Gm-Message-State: AOJu0YyOuMV4tv6t4yr+Xa6Ijk1RB+RXNDFSSVZ/MxCnpnqur3vikE2c
 dyn/7//n4wJ6RMmbW06/jmQtbBD58Sls157Go3hiMSzSoX5tTdYPuPOwfLd0NUq6urRBlsHbjLp
 Oyf+qpMM=
X-Gm-Gg: AeBDietVFcap4t2BmgEis/O8A7WmLPEC2d+dVykTXzgtiUf6/s4/MrbqbAM80nEBPtz
 L6RwkJqCM5RJ0wPh3oGFaWhvR4rXYWgHVtP12OJwjCgIHSosEfrJRY281uIn4AjuB3+kLzu6NmU
 yhFduvuy3SAeSMFHMLPLaigWe273dUF9JmyTGrMjLjfJ+Op06sEAsA8LweuaLo8aEpWEBFsonTa
 YEYUoPrNSgDxpkq/CBC5efontICj7Oeub6kENd/8VJOW61rN5EOrWhxSAFPSDIu0Axu8/QYZVPU
 c2/UarqV+vOcxT8ZmRrdJrqPeq49fQRiLmeX+4lGyeTk3nKMZjG2ch1lC9FtAfQhCB8AgZiPRaf
 iHtyeyKQ1ZvTf2qD5K8rwgFo6DyoxgSlPyURA26wdC416TbIT8JPH+S7fylOyY/TWMzWBfc7kfz
 DsbbJZoWg3WlWMeBm+2XFCJHy45R3YWsrs+OwQKBFl
X-Received: by 2002:a17:90b:4ac7:b0:35f:b306:5d47 with SMTP id
 98e67ed59e1d1-364c2f14e9emr190855a91.1.1777501587745; 
 Wed, 29 Apr 2026 15:26:27 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/48] fpu: Return struct from float16_unpack_canonical
Date: Thu, 30 Apr 2026 08:24:35 +1000
Message-ID: <20260429222445.26301-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 fpu/softfloat.c | 94 +++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 62 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index dee5dcd0d2..3612d2fceb 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1482,10 +1482,9 @@ static FloatParts64 float16a_unpack_canonical(float16 f, float_status *s,
     return p;
 }
 
-static void float16_unpack_canonical(FloatParts64 *p, float16 f,
-                                     float_status *s)
+static FloatParts64 float16_unpack_canonical(float16 f, float_status *s)
 {
-    *p = float16a_unpack_canonical(f, s, &float16_params);
+    return float16a_unpack_canonical(f, s, &float16_params);
 }
 
 static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
@@ -1718,11 +1717,9 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
 static float16 QEMU_FLATTEN
 float16_addsub(float16 a, float16 b, float_status *status, bool subtract)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float16_unpack_canonical(&pa, a, status);
-    float16_unpack_canonical(&pb, b, status);
-    pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pa = float16_unpack_canonical(a, status);
+    FloatParts64 pb = float16_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
 
     return float16_round_pack_canonical(pr, status);
 }
@@ -1952,11 +1949,9 @@ floatx80 floatx80_sub(floatx80 a, floatx80 b, float_status *status)
 
 float16 QEMU_FLATTEN float16_mul(float16 a, float16 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float16_unpack_canonical(&pa, a, status);
-    float16_unpack_canonical(&pb, b, status);
-    pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pa = float16_unpack_canonical(a, status);
+    FloatParts64 pb = float16_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
 
     return float16_round_pack_canonical(pr, status);
 }
@@ -2066,12 +2061,11 @@ float16 QEMU_FLATTEN
 float16_muladd_scalbn(float16 a, float16 b, float16 c,
                       int scale, int flags, float_status *status)
 {
-    FloatParts64 pa, pb, pc, *pr;
-
-    float16_unpack_canonical(&pa, a, status);
-    float16_unpack_canonical(&pb, b, status);
-    float16_unpack_canonical(&pc, c, status);
-    pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    FloatParts64 pa = float16_unpack_canonical(a, status);
+    FloatParts64 pb = float16_unpack_canonical(b, status);
+    FloatParts64 pc = float16_unpack_canonical(c, status);
+    FloatParts64 *pr =
+        parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float16_params, false);
@@ -2326,11 +2320,9 @@ float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
 
 float16 float16_div(float16 a, float16 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float16_unpack_canonical(&pa, a, status);
-    float16_unpack_canonical(&pb, b, status);
-    pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pa = float16_unpack_canonical(a, status);
+    FloatParts64 pb = float16_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_div(&pa, &pb, status);
 
     return float16_round_pack_canonical(pr, status);
 }
@@ -2969,9 +2961,8 @@ floatx80 float128_to_floatx80(float128 a, float_status *s)
 
 float16 float16_round_to_int(float16 a, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float16_unpack_canonical(a, s);
 
-    float16_unpack_canonical(&p, a, s);
     parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float16_params);
     return float16_round_pack_canonical(&p, s);
 }
@@ -3032,36 +3023,28 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
 int8_t float16_to_int8_scalbn(float16 a, FloatRoundMode rmode, int scale,
                               float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT8_MIN, INT8_MAX, s);
 }
 
 int16_t float16_to_int16_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
 int32_t float16_to_int32_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 int64_t float16_to_int64_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
@@ -3530,36 +3513,28 @@ int64_t float64_to_int64_modulo(float64 a, FloatRoundMode rmode,
 uint8_t float16_to_uint8_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT8_MAX, s);
 }
 
 uint16_t float16_to_uint16_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
 }
 
 uint32_t float16_to_uint32_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 uint64_t float16_to_uint64_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float16_unpack_canonical(&p, a, s);
+    FloatParts64 p = float16_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
@@ -4316,11 +4291,9 @@ float128 uint128_to_float128(Int128 a, float_status *status)
 
 static float16 float16_minmax(float16 a, float16 b, float_status *s, int flags)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float16_unpack_canonical(&pa, a, s);
-    float16_unpack_canonical(&pb, b, s);
-    pr = parts64_minmax(&pa, &pb, s, flags);
+    FloatParts64 pa = float16_unpack_canonical(a, s);
+    FloatParts64 pb = float16_unpack_canonical(b, s);
+    FloatParts64 *pr = parts64_minmax(&pa, &pb, s, flags);
 
     return float16_round_pack_canonical(pr, s);
 }
@@ -4401,10 +4374,9 @@ MINMAX_2(float128)
 static FloatRelation QEMU_FLATTEN
 float16_do_compare(float16 a, float16 b, float_status *s, bool is_quiet)
 {
-    FloatParts64 pa, pb;
+    FloatParts64 pa = float16_unpack_canonical(a, s);
+    FloatParts64 pb = float16_unpack_canonical(b, s);
 
-    float16_unpack_canonical(&pa, a, s);
-    float16_unpack_canonical(&pb, b, s);
     return parts64_compare(&pa, &pb, s, is_quiet);
 }
 
@@ -4594,9 +4566,8 @@ FloatRelation floatx80_compare_quiet(floatx80 a, floatx80 b, float_status *s)
 
 float16 float16_scalbn(float16 a, int n, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = float16_unpack_canonical(a, status);
 
-    float16_unpack_canonical(&p, a, status);
     parts64_scalbn(&p, n, status);
     return float16_round_pack_canonical(&p, status);
 }
@@ -4654,9 +4625,8 @@ floatx80 floatx80_scalbn(floatx80 a, int n, float_status *status)
 
 float16 QEMU_FLATTEN float16_sqrt(float16 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = float16_unpack_canonical(a, status);
 
-    float16_unpack_canonical(&p, a, status);
     parts64_sqrt(&p, status, &float16_params);
     return float16_round_pack_canonical(&p, status);
 }
-- 
2.43.0


