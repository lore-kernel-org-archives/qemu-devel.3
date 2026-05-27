Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B48CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBYD-0003Cr-Im; Wed, 27 May 2026 06:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYA-00038j-F0
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBY6-0000nx-WD
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49068493267so22161205e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877901; x=1780482701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cCU7iyJB4xSEL6mENr2z5sz2xBo7bB8P5f9pioDXOHY=;
 b=A6tewBu16YO2rr9EYgN6rlVSiPk/YQ1/tZvYbBELLGrDqb6anA1Jfikl9rqvx9ncXE
 7Z8FJpoFN70BofLQaLIZlqBewOlsR4JTWU7cHFNirK7UOzvG7Ik3NlFKn5D+V7z+lQp2
 VxVlhAm66uE2s+wniW+o7/8C0xzNx8BKqSROyO+quoJimWC3Krx7Tf1XfwmKF/o7ti2I
 awnWHbobKty/NIsM3tBM1Bv3HBuJlIqxkHeVlhp+yEvXmZje6Idi1k+obx6l7y3IFx88
 mYbqeLREbyGqZLCOGvVhDUFGobDbjF0HtoqlBPzdO7eLbL8L3PIhFLH0vfOijJodUr3y
 ZUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877901; x=1780482701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cCU7iyJB4xSEL6mENr2z5sz2xBo7bB8P5f9pioDXOHY=;
 b=qDoZItK8RzVu+FgpoQpiCeLn143JiZeJ0miPREdQHY7CXG1oorEHLrb8Mo1/D7esfp
 +xhqzV6kFy6q+vW68MNO3PPjE54YzqdkS0VY0R3WbGjUGkprxz1FgKmg1qOCy3tXZA8X
 kF4gno9zJx7B/fPjocfGeynlngDs6prB/x1VMY9YXO0pkWCcqMSRmuA2md8KCUqzIw+q
 javcSRlEsclIf1nTek6kPk8jKMndeCmR1+BDq9SDXtlya69KBWNPdFcpvJwzCSURU5YO
 6prDcukMq3nCyCmu9cRlBZGkQ5pThiWhR+P1E5QPtaqwvJyJTt/aoPNQb18zwi9gybqJ
 sWRQ==
X-Gm-Message-State: AOJu0YyMN12DTH8wJVTJGtS2UNPyLfg67T9cbYXAPM0iTtPaFzoPXAY0
 CUkJuFm6YHbGKjr/GPuMuByYlAbemHRhq1zv0+KG1iGtmr1wFUlEK24SsQJbvUqafRj/ZY7Yl7/
 +biB9/JbU9Q==
X-Gm-Gg: Acq92OFx9bb8bRKpHrQHBwYWHJMXkYBfGJprkQDa5PSlj0k2xcIEamrtoRY5oC+ffAu
 fbNXilYKUS6C6DZLLhnhuWZz7k6XjbANuqMLiRfgHpTb9NkTJrCarfd9W7hhGtgKN5nxT4kxeSn
 +RqGSrfwdKZLuohe7gR8NXH99tCQ9HE5PWAMefPB8ha1T00zPyo5zRTpzJaEPEkoj0L9lx+wj1U
 IawtIK0xHCsNwSO4CN3O9sZ+IBcn0n0PMQnewocB0BdvM4P4TM4lc1GrwWYnUDJH+y2eWRNudTu
 bhFM4oPfiY7C/FWrmXNr9naM2Q6ibGd2jp9csN7Sa0Q9bz614vRwDkDcG5G7pcvEp6oiBZHf+Bl
 o8enDIMF5qnOhxpsx7WRUOFLdYZiteTJt7S5GROLsZYxYtm3aMCltTYTszx2td5DPiKYw/a1tGq
 gWkYr435P1jNFgMopA690RSdfpsdN2uLTLrMe3iqL8PMEZnTCPJIPX3/A=
X-Received: by 2002:a05:600c:8681:b0:490:b07:5f27 with SMTP id
 5b1f17b1804b1-490428cc2d7mr265048835e9.24.1779877900961; 
 Wed, 27 May 2026 03:31:40 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a2a73sm5045366f8f.22.2026.05.27.03.31.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:31:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/32] target/riscv: Use float_raise
Date: Wed, 27 May 2026 12:30:13 +0200
Message-ID: <20260527103037.4461-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Anton Blanchard <antonb@tenstorrent.com>

Use float_raise instead of open coding it.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260521110824.1091323-1-antonb@tenstorrent.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/vector_helper.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 12788b4b74e..954a85c03a1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4084,7 +4084,7 @@ static bfloat16 frsqrt7_h_bf16(bfloat16 f, float_status *s)
         (bfloat16_is_infinity(f) && sign) ||
         (bfloat16_is_normal(f) && sign) ||
         (bfloat16_is_zero_or_denormal(f) && !bfloat16_is_zero(f) && sign)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return bfloat16_default_nan(s);
     }
 
@@ -4095,7 +4095,7 @@ static bfloat16 frsqrt7_h_bf16(bfloat16 f, float_status *s)
 
     /* frsqrt7(+-0) = +-inf */
     if (bfloat16_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return bfloat16_set_sign(bfloat16_infinity, sign);
     }
 
@@ -4124,7 +4124,7 @@ static float16 frsqrt7_h(float16 f, float_status *s)
         (float16_is_infinity(f) && sign) ||
         (float16_is_normal(f) && sign) ||
         (float16_is_zero_or_denormal(f) && !float16_is_zero(f) && sign)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float16_default_nan(s);
     }
 
@@ -4135,7 +4135,7 @@ static float16 frsqrt7_h(float16 f, float_status *s)
 
     /* frsqrt7(+-0) = +-inf */
     if (float16_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float16_set_sign(float16_infinity, sign);
     }
 
@@ -4164,7 +4164,7 @@ static float32 frsqrt7_s(float32 f, float_status *s)
         (float32_is_infinity(f) && sign) ||
         (float32_is_normal(f) && sign) ||
         (float32_is_zero_or_denormal(f) && !float32_is_zero(f) && sign)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float32_default_nan(s);
     }
 
@@ -4175,7 +4175,7 @@ static float32 frsqrt7_s(float32 f, float_status *s)
 
     /* frsqrt7(+-0) = +-inf */
     if (float32_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float32_set_sign(float32_infinity, sign);
     }
 
@@ -4204,7 +4204,7 @@ static float64 frsqrt7_d(float64 f, float_status *s)
         (float64_is_infinity(f) && sign) ||
         (float64_is_normal(f) && sign) ||
         (float64_is_zero_or_denormal(f) && !float64_is_zero(f) && sign)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float64_default_nan(s);
     }
 
@@ -4215,7 +4215,7 @@ static float64 frsqrt7_d(float64 f, float_status *s)
 
     /* frsqrt7(+-0) = +-inf */
     if (float64_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float64_set_sign(float64_infinity, sign);
     }
 
@@ -4285,8 +4285,7 @@ static uint64_t frec7(uint64_t f, int exp_size, int frac_size,
              * Overflow to inf or max value of same sign,
              * depending on sign and rounding mode.
              */
-            s->float_exception_flags |= (float_flag_inexact |
-                                         float_flag_overflow);
+            float_raise(float_flag_inexact | float_flag_overflow, s);
 
             if ((get_float_rounding_mode(s) == float_round_to_zero) ||
                 ((get_float_rounding_mode(s) == float_round_down) && !sign) ||
@@ -4338,13 +4337,13 @@ static bfloat16 frec7_h_bf16(bfloat16 f, float_status *s)
 
     /* frec7(+-0) = +-inf */
     if (bfloat16_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return bfloat16_set_sign(bfloat16_infinity, sign);
     }
 
     /* frec7(sNaN) = canonical NaN */
     if (bfloat16_is_signaling_nan(f, s)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return bfloat16_default_nan(s);
     }
 
@@ -4370,13 +4369,13 @@ static float16 frec7_h(float16 f, float_status *s)
 
     /* frec7(+-0) = +-inf */
     if (float16_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float16_set_sign(float16_infinity, sign);
     }
 
     /* frec7(sNaN) = canonical NaN */
     if (float16_is_signaling_nan(f, s)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float16_default_nan(s);
     }
 
@@ -4402,13 +4401,13 @@ static float32 frec7_s(float32 f, float_status *s)
 
     /* frec7(+-0) = +-inf */
     if (float32_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float32_set_sign(float32_infinity, sign);
     }
 
     /* frec7(sNaN) = canonical NaN */
     if (float32_is_signaling_nan(f, s)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float32_default_nan(s);
     }
 
@@ -4434,13 +4433,13 @@ static float64 frec7_d(float64 f, float_status *s)
 
     /* frec7(+-0) = +-inf */
     if (float64_is_zero(f)) {
-        s->float_exception_flags |= float_flag_divbyzero;
+        float_raise(float_flag_divbyzero, s);
         return float64_set_sign(float64_infinity, sign);
     }
 
     /* frec7(sNaN) = canonical NaN */
     if (float64_is_signaling_nan(f, s)) {
-        s->float_exception_flags |= float_flag_invalid;
+        float_raise(float_flag_invalid, s);
         return float64_default_nan(s);
     }
 
-- 
2.53.0


