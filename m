Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AF2CD37A7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1ET-0004b3-9T; Thu, 07 May 2026 12:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EQ-0004ZU-JO
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:46 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EN-0006wB-4d
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:46 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so657860a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169942; x=1778774742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6D7Re3RFomXaiJ9AO7bJXSdtzyhn88IIHMuf5Pj0e38=;
 b=xqf4Qmky/N446SUfJL6fG59p4prPSS8xPBnwj9K2wnh7bjSxBJiBG1+z6FPqD1fBsz
 3U9p7cM0xhC/YlO/9LOamL6I3hns7+oEaXZTdiMYM0+kTKTPT4nyMMYExDoylAx8kfHx
 EJKuoX/EN6kRgWV+xG4Ilmfasx3XF/w9+439ENrj2E+msDxpBso5OkqzN6OVDmdKybb7
 FN/XHH4348V3blmj4ARx2DQqN0zlOPlWt0uvrkudF3+1NljCfdfLfVw6JWAlde+At69z
 ZuXB4C7SQVTELT4lvRfLDFiz1h8g+F13RyiCLRxrvtW8Rrdjg1+7ObUEm2uUJ1I8Vd9w
 ipGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169942; x=1778774742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6D7Re3RFomXaiJ9AO7bJXSdtzyhn88IIHMuf5Pj0e38=;
 b=eFf/YB+YPQCePI3m81Y/nwNX/6g3PvnG5tDi8s6VMyTkujk9HbJ8d2KQuxjtUiEMMC
 WiP6I53KP4cQ2HVVbhHHu7NfDRFQxxiznS1mfJ9oeiys1x0nZBC+UY6zkTQaJLD/bksj
 gH2kw2wLUOkuPJDXyJUAqNx8u2/AZD3Fb5FDuCrOphFhotLYN3zsV8VZEoEAewMXJzvg
 SxAhbwaUg704bf9nfOQjlNl9IxYFFYXbqsbYUvNKoRmRvkO1RS/C6n6NJ38OcHaTuexg
 lz+oRl4U+QcmKK+dR1/dhV2oAonNu3UwCgfn6uj1J+U0A8oN//H8HhiAlu3P0S4E0RLD
 NqBA==
X-Gm-Message-State: AOJu0YztGuRZHaCsj2+L8U1v6l6gvE21om1Y5bRQp5rz/3YTnKctSJOH
 kKzjfJAdqUoNu0iNlJGAhSpGEtYhqrHNdwpSDcYWEPEh9tpyaudEzQabSgDC/CqdY9I/h/NxLQX
 Tn4X9
X-Gm-Gg: AeBDietPEon8hr6qbSCDV63vlhIqVmnnWwy43vyGskLHBvQoaWWdbFIFRU6lLmEGRh/
 dVtmMQ8dqC4PmbMrvn27bdNeY3GdvtT93XyxbuNmQGW3lv47Tr2u0xxr1s/nS5GZickH89T+rq/
 e6ICNvBF0NWEIpgVRrRRJ0Pt8Jeoxy6QFFfGOwGO5DtDzvf1OKP9H3HJTBJe1yXNv4jaSvNyOev
 os0M+Um9ATNYEee2Ilh3Xtg8yW2ehqoFnZqTut2dh2/844EXbTOSs8EOlpZfvy3X0l4F2xrqyma
 VRG194qFX4gU2i6yOeQRmzE/3AaIzIdArlyDPbHCLHxs4uNNZDYFxReXOG3sCRAHhRtFYM7553k
 LNZ1v9njtnXmhGi4+FBZtsvqzJ0muhrIqgA2CFY6q6GYPtsJsBNKEZxFr4tiCqpBeH6b6KOvqF4
 hIXUsznIKUc/hSmDHpq+gq6weYAdrrkk+FDca1HkKcWYQKBQ==
X-Received: by 2002:a05:6830:3983:b0:7dd:e032:3cdf with SMTP id
 46e09a7af769-7e1df1912bemr5182650a34.19.1778169941691; 
 Thu, 07 May 2026 09:05:41 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/29] fpu: Return struct from parts{64,128}_round_to_int
Date: Thu,  7 May 2026 11:05:06 -0500
Message-ID: <20260507160518.444797-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

At the same time, export.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  9 +++++++++
 fpu/softfloat.c               | 19 ++++++++++++-------
 fpu/softfloat-parts.c.inc     | 17 ++++++++++-------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 44e0cb7d05..1329bc4d2f 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -172,4 +172,13 @@ FloatParts64 parts64_div(const FloatParts64 *a, const FloatParts64 *b,
 FloatParts128 parts128_div(const FloatParts128 *a, const FloatParts128 *b,
                            float_status *s);
 
+FloatParts64 parts64_round_to_int(const FloatParts64 *a,
+                                  FloatRoundMode rmode,
+                                  int scale, float_status *s,
+                                  const FloatFmt *fmt);
+FloatParts128 parts128_round_to_int(const FloatParts128 *a,
+                                    FloatRoundMode rmode,
+                                    int scale, float_status *s,
+                                    const FloatFmt *fmt);
+
 #endif
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6d69b61c7f..b71bd49483 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2738,7 +2738,8 @@ float16 float16_round_to_int(float16 a, float_status *s)
 {
     FloatParts64 p = float16_unpack_canonical(a, s);
 
-    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float16_params);
+    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+                             &float16_params);
     return float16_round_pack_canonical(&p, s);
 }
 
@@ -2746,7 +2747,8 @@ float32 float32_round_to_int(float32 a, float_status *s)
 {
     FloatParts64 p = float32_unpack_canonical(a, s);
 
-    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float32_params);
+    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+                             &float32_params);
     return float32_round_pack_canonical(&p, s);
 }
 
@@ -2754,7 +2756,8 @@ float64 float64_round_to_int(float64 a, float_status *s)
 {
     FloatParts64 p = float64_unpack_canonical(a, s);
 
-    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float64_params);
+    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+                             &float64_params);
     return float64_round_pack_canonical(&p, s);
 }
 
@@ -2762,7 +2765,8 @@ bfloat16 bfloat16_round_to_int(bfloat16 a, float_status *s)
 {
     FloatParts64 p = bfloat16_unpack_canonical(a, s);
 
-    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &bfloat16_params);
+    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+                             &bfloat16_params);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -2770,7 +2774,8 @@ float128 float128_round_to_int(float128 a, float_status *s)
 {
     FloatParts128 p = float128_unpack_canonical(a, s);
 
-    parts128_round_to_int(&p, s->float_rounding_mode, 0, s, &float128_params);
+    p = parts128_round_to_int(&p, s->float_rounding_mode, 0, s,
+                              &float128_params);
     return float128_round_pack_canonical(&p, s);
 }
 
@@ -2782,8 +2787,8 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    parts128_round_to_int(&p, status->float_rounding_mode, 0, status,
-                       &floatx80_params[status->floatx80_rounding_precision]);
+    p = parts128_round_to_int(&p, status->float_rounding_mode, 0, status,
+                              &floatx80_params[status->floatx80_rounding_precision]);
     return floatx80_round_pack_canonical(&p, status);
 }
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 1634160728..1cd0df4159 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1255,24 +1255,27 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
     return true;
 }
 
-static void partsN(round_to_int)(FloatPartsN *a, FloatRoundMode rmode,
+FloatPartsN partsN(round_to_int)(const FloatPartsN *a,
+                                 FloatRoundMode rmode,
                                  int scale, float_status *s,
                                  const FloatFmt *fmt)
 {
     switch (a->cls) {
     case float_class_qnan:
     case float_class_snan:
-        *a = partsN(return_nan)(a, s);
-        break;
+        return partsN(return_nan)(a, s);
     case float_class_zero:
     case float_class_inf:
-        break;
+        return *a;
     case float_class_normal:
     case float_class_denormal:
-        if (partsN(round_to_int_normal)(a, rmode, scale, fmt->frac_size)) {
-            float_raise(float_flag_inexact, s);
+        {
+            FloatPartsN r = *a;
+            if (partsN(round_to_int_normal)(&r, rmode, scale, fmt->frac_size)) {
+                float_raise(float_flag_inexact, s);
+            }
+            return r;
         }
-        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


