Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FC5CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPl-0008Gd-Lt; Sat, 16 May 2026 20:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOp-0007FR-3H
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:36 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOh-000521-W3
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:29 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso476907b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977820; x=1779582620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ab0YMMyLPu3b50iAah8B/e/2jI2Hs3Msxzymw79EzNY=;
 b=qkn91hdwMkDHCiAHRRGKHbfNQtrVUtm+7ucEaxhEWqujBDnhhBAN/hgLZwP75JWRwe
 aO6Iec60MBbjIrl7byx1WODeAVB1JTQttnFTfSb00AU+IIJAF41eSzhdZUpcAqrngdkB
 W49c+wQaGS8wBhN50iK0RZOL/HYkOlPxJNx15OBGRTbor3ZMPtGPxFUXFF47WjQbQivg
 TR9I4FqMq2JYXCaC+v/zW4GcAMyiYOLR6gouFMen0AhgoCgD+xGGhGM5+XGizIgCA2Rm
 sDEy22VonEGjLDGTamXmx4ZF1cABs2oADzdpBbHVyXKBuo/iLB7dbTMT0/oKLNkQf/sm
 zTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977820; x=1779582620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ab0YMMyLPu3b50iAah8B/e/2jI2Hs3Msxzymw79EzNY=;
 b=ZvOVsMIznSnFn0kUQ/8UYyzv6jw/TTCsgooJ5hTn880ibTwaj2EjStgTbFaJzvQidr
 6kls5diVOFWwTapMw3Bps7dGQ+GWjO2vq7Gd46SAslrXH2zMmjwQ056q0EyLbs53KF+U
 KEgu4EFz0HwaFJ6r+NbXOg2kH4/MkzTFi8yXE2Re7pc1XwevfmnU0SowNxAJRYQY9802
 nQxIejEHyxyqgdZY/1Gw+RANrI1+UUEaOq0JFtpNUIjKCzHmx0cTqcx7lA8nid/8V31K
 VtNxj5ZOCV1C6Ppv7p5OE5Hi+dEhVsaZpWfXlwjH0whfV1XLzUfc7MF7T8PmJ4aX5JL0
 55dg==
X-Gm-Message-State: AOJu0YzjYORBxVr13oral/PmKR0fcfa4/cEUXjewmXCIUI77SV51glV+
 9T+rhyEo+9wpe8OubMh30UYCijlTj16WUS3T3yuZKMma6zHqwfCgLR3s6ehX8DVozPsK8STAn4K
 5IeE8
X-Gm-Gg: Acq92OGzolQB7ElmdALJHBUZmf1Av8cMf/qWzR6XF17zI2pp1owwugOrPNfKzBB602M
 2zYR0LC8clwX47gtZOda8TO6tDJh+isrMRIHEHYEroD4LwJ8DdlE8YA0ZE/2LdVixNm4PisSO5E
 jNUQAk46B6u32lBsXd4JqoCPrBEDU0Is2W1TghQ3+LxQzw65D81E2KufYF2gUOimIWxlmA8Zrlv
 CGTDom0y0wPZI4KG8jggA/hfwOfZ7NxMzy963139NSS2n/94iIjv0EqkHGkZddvVgOmoWArcEZn
 yHS5XAgHotmDK5AJDkyXgEN4oLDDQx8T/cyXSpMVjt2tt9GqnkGhgN3sSCLraZGJALoeZFnKPrG
 DJrqruJFp8sdDO/QFAYSH0dOqOVz/7wNxWeyCXEADBjGnaoto7XVhYvfH91mthrpBB8HPQgzJ4e
 WxBuIhAp/wce53P0kr8aIr0jGZrvRouXzHUBK/g90=
X-Received: by 2002:a05:6a00:a257:b0:83b:b0c2:17ea with SMTP id
 d2e1a72fcca58-83f33de53e6mr10153314b3a.37.1778977820431; 
 Sat, 16 May 2026 17:30:20 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 19/63] target/arm: Implement FSCALE for AdvSIMD
Date: Sat, 16 May 2026 17:29:18 -0700
Message-ID: <20260517003002.321430-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h |  4 ++++
 target/arm/tcg/vec_internal.h    |  4 ++++
 target/arm/tcg/translate-a64.c   |  7 +++++++
 target/arm/tcg/vec_helper64.c    | 16 ++++++++++++++++
 target/arm/tcg/a64.decode        |  3 +++
 5 files changed, 34 insertions(+)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 215df1201b..b7880f773e 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -152,6 +152,10 @@ DEF_HELPER_FLAGS_5(gvec_famin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32
 DEF_HELPER_FLAGS_5(gvec_famax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_famin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fscale_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fscale_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fscale_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_2(exception_return, void, env, i64)
 #endif
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index cc2691b2f6..68b1116171 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -345,6 +345,10 @@ float32 float32_famin(float32, float32, float_status *);
 float64 float64_famax(float64, float64, float_status *);
 float64 float64_famin(float64, float64, float_status *);
 
+#define float16_fscale  float16_scalbn
+#define float32_fscale  float32_scalbn
+float64 float64_fscale(float64, int64_t, float_status *);
+
 /*
  * Decode helper functions for predicate as counter.
  */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d2a4b0fadc..ac18ceeeab 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6496,6 +6496,13 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[3] = {
 };
 TRANS_FEAT(FAMIN, aa64_faminmax, do_fp3_vector, a, 0, f_vector_famin)
 
+static gen_helper_gvec_3_ptr * const f_vector_fscale[3] = {
+    gen_helper_gvec_fscale_h,
+    gen_helper_gvec_fscale_s,
+    gen_helper_gvec_fscale_d,
+};
+TRANS_FEAT(FSCALE, aa64_f8cvt, do_fp3_vector, a, 0, f_vector_fscale)
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index 4a5b0782d1..2f481ac489 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -174,3 +174,19 @@ DO_3OP(gvec_famax_s, float32_famax, float32)
 DO_3OP(gvec_famin_s, float32_famin, float32)
 DO_3OP(gvec_famax_d, float64_famax, float64)
 DO_3OP(gvec_famin_d, float64_famin, float64)
+
+float64 float64_fscale(float64 n, int64_t m, float_status *s)
+{
+    /*
+     * Given the 'int' parameter of float64_scalbn, we have to saturate
+     * the 'int64_t' parameter of the operation to some value.  Since
+     * float64 has an 11-bit exponent, saturating to 12 bits is sufficient
+     * to ensure that DBL_TRUE_MIN can be made to overflow.
+     */
+    int sat_m = MIN(MAX(m, -0xfff), 0xfff);
+    return float64_scalbn(n, sat_m, s);
+}
+
+DO_3OP(gvec_fscale_h, float16_fscale, int16_t)
+DO_3OP(gvec_fscale_s, float32_fscale, int32_t)
+DO_3OP(gvec_fscale_d, float64_fscale, int64_t)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 666a293540..02c7264cb9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1198,6 +1198,9 @@ FAMAX           0.00 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
 FAMIN           0.10 1110 110 ..... 00011 1 ..... ..... @qrrr_h
 FAMIN           0.10 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
 
+FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
+FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


