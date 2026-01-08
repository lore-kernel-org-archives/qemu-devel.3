Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E50D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrlG-0000so-Uz; Thu, 08 Jan 2026 10:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlB-0000pV-Eb
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:13 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrl9-0003J8-A4
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:13 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7ade456b6abso2244517b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885429; x=1768490229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vyktvm0RmttvVgoRBYPAO0Ic1eC1BnrJQnOZaxYFalU=;
 b=Thu1a4dlT1fsODptS2XxUMJVUfzpjieIfnN/+RUD34ACG6tcqGi1rLcK66ch7SAepX
 i7ZM2Z2VY/Rv/ES9Q3VjOwV+DMTkVvSLwF1mXor2DpsZuJXRrQ5mKodloI/usHDNmsks
 zkrYhFPp/jOp51jk6Zu99h6dNQsclFYIlE1U0IQ4V8ttVq9jU3vvsFFZ8f4+A7D1X6rt
 cuV3CoOGTluyuKtqTK05CrDnenuYSH8ryGlRNgIfxLLKsRItUqAVsSOvGCfxRA1Y3ANk
 uI6RQAJrTXn0GjCEGA2b5Bd2AfWQNEvTIks6f9U3BNkkK7Z3+xG0jXkIxEittv0wtFTX
 2XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885429; x=1768490229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vyktvm0RmttvVgoRBYPAO0Ic1eC1BnrJQnOZaxYFalU=;
 b=QO/BWFbWC1K1nHGyhWiXejdO4ufkKwfYp/YExQsQZRJeyA404Y+qMypvHXHpDTBg/F
 0U6ytsp5BBdBpYCJUfcMNL8o0Iid43WdOLZG3ijrxmh1KkdTy1YLalolkOoUMW0oui9R
 6D3RSaWvBlLmJ2dLI5Bv3SOapmBZala0HhQ0wq8yPauLjBV/GL2eSfoo2eicgC+JEmwS
 KVV5dFEmQ3tL8Rraf2lb86O38GeRPx5U25fjUuWZggcK6SHNzcRPoERFzlOs+8y38625
 qORJ57wp06lIZEC5C7Y/NCAJHVqX7eWN7npzvL4NzaAYKV+4TebZGguGM7s3a/2ENqMg
 RZ9A==
X-Gm-Message-State: AOJu0Yyge4JHdeQK9xxENdKgdDeLMmk7DYWqsYd7EkMWVcI4mCQUjxpE
 OalAEvKPNVQC9GiWCqji0gIfIZMaAWe6VgMhFFN8TnkNwWMBQpe5RehXxwxIRWBd/q1B4r+BYt0
 K8IOJA5ZUtQMB4LfXxgwUWBHI3uHbU4dnxsYV2k23RIZJullrzFvOriIG6YVT8ne4DhVP2CPq1H
 BHuyzI5+iLZZcyFUZMG9715VjYktDUjoAoC6jYmqI=
X-Gm-Gg: AY/fxX5D3gX+XqJC6qbvLyS1+5fDOhQCGH+ve7O+74qoK6xAjlB8sxg1zZmo/bSoI2Y
 Dv97uSJkJP0wv/i1kAs6QyK/lK+gjbPm6Mjq7JXlh077wWUTUFivC5tGBlOkztWRZArvO1LKa5h
 JynR094qI7Kte2jlQ5Lg/VN07i5AWQB+PHv3YbmPYLvNE6c07HJOaNn6+P4C6tDjhf3TO5NUtWF
 5yIhG4gw/1ZnfkLn2DQ8CjHObW7msya5s3rdpu/n4w0dVGSS05MsCjraMhPnhbEVvwzSAdKogcF
 cMXjZPXIVyP2Rt7K8cmuhfjhebj8dK5LtrY97bh9CROcF8p/eqbKDl+1LMfEmx9X2ywhWirLpVA
 PhFXsl8pbI70ru2heHIWCZBfkaWrnYq0pA73kd2I7Erxlv3+H7qMXMcScuPTuqiLWroAw3yQzrp
 k2QUvRN8Th07eA9iPh2HGsxLFqnHpuHlOw99aNG6CcFd83BoNwwbYA4Ko=
X-Google-Smtp-Source: AGHT+IEC24OWiX2NyG0T3pT6AEVygdtU7ucwuC4lvBktpU7qQ2CmD/A/689X356OBP7EkJUXyq+n5g==
X-Received: by 2002:a05:6a00:1d19:b0:7e8:4471:8cf with SMTP id
 d2e1a72fcca58-81b7f6df21dmr5956743b3a.48.1767885428881; 
 Thu, 08 Jan 2026 07:17:08 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:08 -0800 (PST)
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
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 04/18] fpu/softfloat: Add OCP(Open Compute Project) OFP4 data
 type
Date: Thu,  8 Jan 2026 23:16:35 +0800
Message-ID: <20260108151650.16329-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42e.google.com
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
List-Id: <qemu-devel.nongnu.org>
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
 include/fpu/softfloat-types.h |  7 +++++-
 include/fpu/softfloat.h       | 45 +++++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 835dd33bf1..82a54e9e6d 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -120,7 +120,7 @@ typedef struct {
 typedef uint16_t bfloat16;
 
 /*
- * Software OCP(Open Compute Project) 8-bit floating point types
+ * Software OCP(Open Compute Project) floating point types
  */
 typedef uint8_t float8_e4m3;
 typedef uint8_t float8_e5m2;
@@ -131,6 +131,11 @@ typedef uint8_t float8_e5m2;
 #define const_float8_e4m3(x) (x)
 #define const_float8_e5m2(x) (x)
 
+typedef uint8_t float4_e2m1;
+#define float4_e2m1_val(x) (x & 0xf)
+#define make_float4_e2m1(x) (x & 0xf)
+#define const_float4_e2m1(x) (x & 0xf)
+
 /*
  * Software IEC/IEEE floating-point underflow tininess-detection mode.
  */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 7ab585bfc8..13b882bc67 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -190,7 +190,7 @@ float128 uint64_to_float128(uint64_t, float_status *status);
 float128 uint128_to_float128(Int128, float_status *status);
 
 /*----------------------------------------------------------------------------
-| Software OCP FP8 conversion routines.
+| Software OCP FP conversion routines.
 *----------------------------------------------------------------------------*/
 
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3, float_status *status);
@@ -201,7 +201,7 @@ float8_e4m3 float32_to_float8_e4m3(float32, bool saturate, float_status *status)
 float8_e5m2 float32_to_float8_e5m2(float32, bool saturate, float_status *status);
 
 /*----------------------------------------------------------------------------
-| Software OCP FP8 operations.
+| Software OCP FP operations.
 *----------------------------------------------------------------------------*/
 
 bool float8_e4m3_is_quiet_nan(float8_e4m3, float_status *status);
@@ -270,6 +270,47 @@ static inline bool float8_e5m2_is_normal(float8_e5m2 a)
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
2.43.7


