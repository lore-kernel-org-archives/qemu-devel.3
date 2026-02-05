Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DC9EC1EA0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxMV-00053p-MN; Thu, 05 Feb 2026 06:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLy-0004nA-9E
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:55 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLv-0003pP-1u
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:54 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so5117275ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770290209; x=1770895009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUJkPxJTWqwWbdY7PIHOQlggOr8hkqng9fCkzzSfwBk=;
 b=fa8rCJPMx8UO4qCl+/anMYgrqBzU0KqwOwcegwQ2+x65LGt0uYmRx3GKH+w7vBPccR
 7tUIqpwrQS3Q2huXTPVCcyfQZSfpLk5wg/9NQKPvMWvBSL0Rl4XmObN5IsTl1Wv0d0Ra
 OOIqFdpLgsz1dOBV9gXMODjB34AHZ19SUReLJ/iIEMC8QaPjUUCteDhapR45fTOcaEi3
 x/EEoeIGuqEthB0AyYXk03xxXkTuSzSASb6VSUQWbYEe4Vav+NVo3MXblrAQPQSlwjNS
 VdSiYoRXImpkfLT5xULGkMZ/RiLbHYOc2b2EF+5aR2rCcFPMvFv5I8f4fItmBoH6odoI
 9riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770290209; x=1770895009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GUJkPxJTWqwWbdY7PIHOQlggOr8hkqng9fCkzzSfwBk=;
 b=PnOTsYrbwrexmjaxswpy+8bsT8vsWQ0IUGrJlscwS1EklKUNy748+EtaEOk7HFqKH5
 6q3gOj5dRaxbDEGgQ0A8d654w+zBPECxsFW9dzrEvli9B/sLPPCDe1m0kwy9fWDHJD82
 hWpp6uL2uhFGhBlQwRSNFXHR71uRq03qxLiXNjRVtwMF/Y7kjuqZmSDqgPJ30dVoENr3
 hzuqQKfJrxWtdgAN9VgGgWzijn3quShHP7pMy9WWmxgZVLYahNlm8pIP9KaVgPrglNla
 APlW9F0f1mxxltUQxoPlDpWCz0GNKio8JIs38V+CAZEcJoe987l+g5OqzkQfmrV0barm
 cfhQ==
X-Gm-Message-State: AOJu0Yzr8BLrd5AHTb4LtZfj8zMc4P+essf8mc9VX5HlqXFAahaBmXwW
 1RmQyb8adI9+irWk06P/lpsCfgUdor91BN+1acl8Qc4m/eqqcKlbo5VYuhongFa/bgVXH743KIN
 K1Tpq7DUsJw==
X-Gm-Gg: AZuq6aJSb1ZpgpTXGrR8I77kWyyngPJStGq771CHwAY9oV4rGiGonfoXGsmDzuaDYWl
 GwpL3k30BnamjLlBG5eUxzbwUvhkzijRApm+R7Mx12NajPz1YvksRd/rCYPH9SSqYUexGUXvwtF
 BWe4xG9salrPLXMDgZDFYfNItQxa00fNDrJe1ku9Sp/Y8UR0FcB3KVF+mC+bDt8fjKLVFBxjIHW
 Akkxo2LuVp6igsFbhGsCtP+RmcxydGjQ46P9TuQFwpXzzorRQE6oO/0NxiV7Ith9nRKXyvquonQ
 tcbDTWWyX8YnN+58dur1LuBFyN+r2ZkyfY49zPoFQpZM6XGx+EUD+Wri4ljRU9RJHv31q4HKHql
 3cuS88HPoa5aVk3RXVxsrLiJbsvkgZTkIYVru+GtiRsFeoIbzqj8W2d5H2km1scG7U7Pv8NY9Cz
 NsffAhN7LvdyAgNhvGep4g
X-Received: by 2002:a17:902:f64e:b0:2a0:a0cc:9994 with SMTP id
 d9443c01a7336-2a9340029ebmr75232975ad.47.1770290208929; 
 Thu, 05 Feb 2026 03:16:48 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933851685sm51088435ad.13.2026.02.05.03.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 03:16:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com
Subject: [PATCH v4 9/9] fpu: Add conversion routines for OCP FP4 E2M1
Date: Thu,  5 Feb 2026 21:16:22 +1000
Message-ID: <20260205111622.461497-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205111622.461497-1-richard.henderson@linaro.org>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

From: Max Chou <max.chou@sifive.com>

Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Update for exp_max_kind]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h |  1 +
 include/fpu/softfloat.h       |  4 +++-
 fpu/softfloat.c               | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 9c84a101e5..ead146c22d 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -122,6 +122,7 @@ typedef uint16_t bfloat16;
 /*
  * Open Compute Project (OCP) Microscaling Formats
  */
+typedef uint8_t float4_e2m1;
 typedef uint8_t float8_e4m3;
 typedef uint8_t float8_e5m2;
 
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index e45260f52d..1580d956d5 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -190,9 +190,11 @@ float128 uint64_to_float128(uint64_t, float_status *status);
 float128 uint128_to_float128(Int128, float_status *status);
 
 /*----------------------------------------------------------------------------
-| OCP FP8 conversion routines.
+| OCP FP{4,8} conversion routines.
 *----------------------------------------------------------------------------*/
 
+float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1, float_status *status);
+
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3, float_status *status);
 float8_e4m3 bfloat16_to_float8_e4m3(bfloat16, bool sat, float_status *status);
 float8_e4m3 float32_to_float8_e4m3(float32, bool sat, float_status *status);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9e31ddd85a..a8ba3cbdd1 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -574,6 +574,11 @@ typedef struct {
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
+static const FloatFmt float4_e2m1_params = {
+    FLOAT_PARAMS(2, 1),
+    .exp_max_kind = float_expmax_normal,
+};
+
 static const FloatFmt float8_e4m3_params = {
     FLOAT_PARAMS(4, 3),
     .exp_max_kind = float_expmax_e4m3
@@ -641,6 +646,11 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
     };
 }
 
+static void QEMU_FLATTEN float4_e2m1_unpack_raw(FloatParts64 *p, float4_e2m1 f)
+{
+    unpack_raw64(p, &float4_e2m1_params, f);
+}
+
 static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
 {
     unpack_raw64(p, &float8_e4m3_params, f);
@@ -1709,6 +1719,13 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
+static void float4_e2m1_unpack_canonical(FloatParts64 *p, float4_e2m1 f,
+                                         float_status *s)
+{
+    float4_e2m1_unpack_raw(p, f);
+    parts_canonicalize(p, s, &float4_e2m1_params);
+}
+
 static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
                                          float_status *s)
 {
@@ -2900,6 +2917,15 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     }
 }
 
+float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float4_e2m1_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return float8_e4m3_round_pack_canonical(&p, s, false);
+}
+
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
 {
     FloatParts64 p;
-- 
2.43.0


