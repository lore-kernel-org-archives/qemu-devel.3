Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32D1EFB806
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vulF3-0004ZR-VO; Tue, 24 Feb 2026 00:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulES-00047S-0Y
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:45:23 -0500
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulEK-0002UZ-GF
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:45:11 -0500
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2baab3137bcso4285374eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 21:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771911906; x=1772516706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GrQzbaecMpge8pvlLhr8Mj9BD4e/GVJtWS3a7jCbeWo=;
 b=chXcZZSFse8AlGJ2UUVdD9viPVuKhpV2B0yDYjp12keFRnUX6FxlIim4rhrtR38gG2
 uwnJCJaCBeye88MCM9vhlA5cZZFLmuDZ/lWFvdiPD+Kylhq23tBEUf/ks9C/rJ5G87bu
 GkYL4uij03a8yXznYF/cF6hHdz3tic2NE7NtciFk52k+e1d622GqKAOE2NWHem32OIAU
 8Prk8SOI/20PmipcB92lBBwXIIxUFk/WxvON2P+EzgCQ/RQlLT/49uVOgDsldWsdIwAO
 it/XdsOC5ABmNrUj1Q2geycJfFxYpXLIBVZKhbmpgIsiG4f+pBBsCRA9OV7UkrRAhyle
 9/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771911906; x=1772516706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GrQzbaecMpge8pvlLhr8Mj9BD4e/GVJtWS3a7jCbeWo=;
 b=G2nM+tNkQge96HxxddVBg0xgOKSyUKjUHHTaZAPZWaoKUT3uXcdjeIoARrR/8ytjBM
 SjdkCyTA7y3ZWF60hbhk1qOf0pQ3FZ1+Wq3c1JWkdSFV1bSCRuQ+iQvPuHuO6NwPfk7F
 SIyoUvphPn0iuNARJKMr/p15UQl6jLIxABT6lDb+vWGhMnOiqeuvEf1T7KpfMiESq72+
 Dw5wYwKhKiO1oEwvRUsxC6S9lEeE+GrxAKDlOJ9fNBZO2c5tctTEQW/HGuLxHndFtTbj
 lm5xN9kXBy+o2yb1lWK8LL6SAw6xY0/yupMwcWCo8KFaK4p1tMsXBX/hqjjXuxxgvvfO
 6pqQ==
X-Gm-Message-State: AOJu0Yx4FcIlXelD3cpR5FRtQ49dKJfuaGQgC3c02Y6AkbTfqnXGhtML
 yRbZFxRdQRMN0Jt3aypYZfzJ6zo3UkGtkaq9v2i4JPhgMHujUQztQW30o6KOBaoxpLqS4HHlRgO
 nFExz/jw=
X-Gm-Gg: ATEYQzwxmTK5U80NtNwth/CATUpWDxathaPYMIRovOyjVemYMOIOpXi9l6P61jpnUrc
 0vf9o42vnv+Ccl9sN4W8YlEhj/TMI9mKl8KimotjIrwajf3WKSlJ8i4+HexK5NjXDfQ7+Znn1RH
 u5qgpasZrvpJJEwVTj1C9f/xN/i80DxwStuvhRcgLE+Jsa/+Wb4c7mgbiF43CzmZDhUWqBvrb39
 USMnVNoASMGqmKomulLk6g8ydKNvoYkcPMnDm6XnpIpmoBTsePjGcCig/7Vmt6HMguYFmN/hkOm
 g1lqPgkCBckAgMCRhrPuDwljnRql7JWlSEK3mBCfndGxEFQc/DR1aeRPsO7k6tvlTWDgSzRYYhm
 fUVh0FOJUv2qOIkwmo4xB1J0BtD+A/Vdof2xGlYmivGI/LnXhU1GH8Afyg5N1cWcpJb8V9+0kBD
 dhvhOECNnalDLtPq9A9DStRmqJ3a3MMcelKkKzamOt7EG9+iaPGF48
X-Received: by 2002:a05:7300:cb13:b0:2ba:9350:d8ba with SMTP id
 5a478bee46e88-2bd7b9eddb3mr4129243eec.10.1771911906246; 
 Mon, 23 Feb 2026 21:45:06 -0800 (PST)
Received: from stoup.. ([172.56.177.223]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7daa37c7sm5958093eec.12.2026.02.23.21.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 21:45:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 9/9] fpu: Add conversion routines for OCP FP4 E2M1
Date: Tue, 24 Feb 2026 16:44:17 +1100
Message-ID: <20260224054417.32430-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224054417.32430-1-richard.henderson@linaro.org>
References: <20260224054417.32430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=richard.henderson@linaro.org; helo=mail-dy1-x1332.google.com
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

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
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
index 31d3f76d3f..8389a07b04 100644
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
index 6e21882ab2..91c34307c8 100644
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
@@ -2929,6 +2946,15 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
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


