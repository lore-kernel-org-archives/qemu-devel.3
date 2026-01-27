Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAFCD2594E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkchs-0002oC-9J; Tue, 27 Jan 2026 01:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchq-0002nd-Lt
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:42 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkcho-0006hO-Ld
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:42 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so56396615ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495859; x=1770100659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IB2c/ii+7jIx2lVcfBPzX5OfuRwjeJn1wLXM2b0V/+s=;
 b=nlsYluX0vmlkKstgHRRzgWH2DL6EiELbsoNbws5wTxtXWzjSjgL3obWKYhPJQus07M
 wiUGxNJhj8jtppcSwtRwsB1W4ZlUmBGygSu5adGibg+HFCby5hYm0s/NSypMGAmpWDoZ
 0Rb4JymmURW824D0ptQ0HOGzu1arMpDKYFlc3Xkz5Rc+3QCg9tE4HkUwSkQxfPVir7Ks
 RTW07/EoxLiceFYMHqBVirxEwhcYXsxQvsF35ijT/0uFL1YX/TpI3FM9cEXlvpoEEBmY
 Jvg4XBzDwMqM2zHIu121re/UjiCyjgUAQ9MA/oFdwyPzoHh1qfJQo7hmBCy+LFqPU+Od
 8SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495859; x=1770100659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IB2c/ii+7jIx2lVcfBPzX5OfuRwjeJn1wLXM2b0V/+s=;
 b=WSx98coygN1KfkpOSriTypojMp7KZFRzmq3JQeAmY46qxlZA2Gz9P1ZW/LcEdlKiTO
 XD6ucT+ikiPAolmCxRlmrE3U3xddYDsM8hNnntKrK9vFM95EICpcbR4PI+S4JKAPeVF9
 MjrNNa3JrC5/fepty+jwc25U8VCoFD/p4Ux8C+KPYq9yRAdzPZURC+BSAt5B1hFp8OCc
 YbEaThiuprgOaG7FgwdX8mZ67yu+cj/H3cNSYfGepm+xcq4FV8vmOdBTYnYeyvE9M6iM
 W20vkkOMVwsovw3NYv5vE70qxa0XkxVBjCUy2fp8oSBZ19lwHmvDPmN5IkasM5Vpmo2o
 QGHg==
X-Gm-Message-State: AOJu0YwJnXmkjsHQU7BBprRl2C7+0qfq/23Ul6NtyI30Bk5tedWJfvU6
 AS094x9NnhPmrTcbHwZVY+joK5dX+YEvMVcsDg3G5xvtM2NJCFRyI4w81KAkFdgG1AnBqMZgyb0
 q5alintkt7ZEXRR71nyUWDehbvWVeFUNVtPPtBBxLdhyvSS67QOvymp480c5opwqkBCkOFCFkid
 J7fs4IUSB8DcSUTZpOdhjZyLl9NDbU13BM3WMLmc+GBQ==
X-Gm-Gg: AZuq6aK5GG7ACRfRYBqEuNKlH1goFwJaTLowUn2eP5Cyn0dBqIZT7K7MQTEozeOcKJL
 TTEOfZBd/AtlW9mHIWMGXARWoMma4H79faimGxoBjEdtKsPOTUJWxIUD+AvVvGkjxvppv825iuV
 hppkAKJJCxuAjXGZ5G/l05k1O2phu1txJmfpqFADKW4MHTKBvPhrGDLHaocx6SIplwiZs1wTtlD
 D9gTI7aF8C3h3Nj9LONEvvOKeFV6wNOw2clskzEtycfCr6HHHzpWdmEZwMyYvn3/rYP5EFimUyB
 53yEBTlBOFsksyoc/xb1+4ws+XXOdhgOmar1oEmEamD57+0AnsIBg6BrJoFOgWAXmW011WavH7J
 MyBFoHQ3huRBfAw0UZRSUUnjytM0hJDwRK7SOUsNNeSVLYutZSGRpt6BClU+zvE+0OhjiFt23oa
 0j2oJDUSjENZH8Yo53/5cg6bW84wVd6IPrLMaoYkjBU3ueq73LKplS/0an3S4Y0yJye2vnwCeoP
 z0cWJa4Q+w6Vo8=
X-Received: by 2002:a17:903:1a88:b0:2a0:f828:24a3 with SMTP id
 d9443c01a7336-2a870e18d4amr8755935ad.28.1769495859332; 
 Mon, 26 Jan 2026 22:37:39 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:39 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 04/17] fpu/softfloat: Support OCP(Open Compute Project)
 OFP4 data type
Date: Tue, 27 Jan 2026 14:37:10 +0800
Message-ID: <20260127063723.442734-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x631.google.com
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

This commit provides the basic operation support for the OCP float4 data
type(e2m1).

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat.c               | 29 +++++++++++++++++++++++
 include/fpu/softfloat-types.h |  5 ++++
 include/fpu/softfloat.h       | 43 +++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 533f96dcda..96845e86df 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -595,6 +595,13 @@ static inline bool fmt_has_nan_encoding(const FloatFmt *fmt)
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
+static const FloatFmt float4_e2m1_params = {
+    FLOAT_PARAMS(2, 1),
+    .no_infinity = true,
+    .limited_nan = true,
+    .normal_frac_max = NORMAL_FRAC_MAX_ALL,
+};
+
 static const FloatFmt float8_e4m3_params = {
     FLOAT_PARAMS(4, 3),
     .no_infinity = true,
@@ -663,6 +670,11 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
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
@@ -1745,6 +1757,13 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
+static void float4_e2m1_unpack_canonical(FloatParts64 *p, float4_e2m1 f,
+                                       float_status *s)
+{
+    float4_e2m1_unpack_raw(p, f);
+    parts_canonicalize(p, s, &float4_e2m1_params);
+}
+
 static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
                                          float_status *s)
 {
@@ -2938,6 +2957,16 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     }
 }
 
+float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float4_e2m1_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+
+    return float8_e4m3_round_pack_canonical(&p, s, &float8_e4m3_params, false);
+}
+
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
 {
     FloatParts64 p;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index b781bf10b7..f8cadffff4 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -131,6 +131,11 @@ typedef uint8_t float8_e5m2;
 #define const_float8_e4m3(x) (x)
 #define const_float8_e5m2(x) (x)
 
+typedef uint8_t float4_e2m1;
+#define float4_e2m1_val(x) ((x) & 0xf)
+#define make_float4_e2m1(x) ((x) & 0xf)
+#define const_float4_e2m1(x) ((x) & 0xf)
+
 /*
  * Software IEC/IEEE floating-point underflow tininess-detection mode.
  */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 30aca23057..4566257c09 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -200,6 +200,8 @@ float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, bool saturate, float_status *statu
 float8_e4m3 float32_to_float8_e4m3(float32, bool saturate, float_status *status);
 float8_e5m2 float32_to_float8_e5m2(float32, bool saturate, float_status *status);
 
+float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1, float_status *status);
+
 /*----------------------------------------------------------------------------
 | Software OCP operations.
 *----------------------------------------------------------------------------*/
@@ -270,6 +272,47 @@ static inline bool float8_e5m2_is_normal(float8_e5m2 a)
     return (((float8_e5m2_val(a) >> 2) + 1) & 0x1f) >= 2;
 }
 
+static inline bool float4_e2m1_is_quiet_nan(float4_e2m1 a, float_status *status)
+{
+    return false;
+}
+
+static inline bool float4_e2m1_is_signaling_nan(float4_e2m1 a, float_status *status)
+{
+    return false;
+}
+
+static inline bool float4_e2m1_is_any_nan(float4_e2m1 a)
+{
+    return false;
+}
+
+static inline bool float4_e2m1_is_neg(float4_e2m1 a)
+{
+    return float4_e2m1_val(a) >> 3;
+}
+
+static inline bool float4_e2m1_is_infinity(float4_e2m1 a)
+{
+    return false;
+}
+
+static inline bool float4_e2m1_is_zero(float4_e2m1 a)
+{
+    return (float4_e2m1_val(a) & 0x7) == 0;
+}
+
+static inline bool float4_e2m1_is_zero_or_denormal(float4_e2m1 a)
+{
+    return (float4_e2m1_val(a) & 0x6) == 0;
+}
+
+static inline bool float4_e2m1_is_normal(float4_e2m1 a)
+{
+    uint8_t em = float4_e2m1_val(a) & 0x7;
+    return em >= 0x2 && em <= 0x7;
+}
+
 /*----------------------------------------------------------------------------
 | Software half-precision conversion routines.
 *----------------------------------------------------------------------------*/
-- 
2.52.0


