Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154C1D1D47A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrlG-0000sl-Q5; Thu, 08 Jan 2026 10:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlD-0000rH-9j
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:15 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlB-0003KX-K5
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:15 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso2883136b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885432; x=1768490232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MIQqhHGiHjK31A9q/v8kSxQcCEoWSWeinQC9NCVaBA=;
 b=HV5hJ7N2yZQzeZ062Lq+pyNzJ+fs/Kg36FyNB27d03gilZKiIMJBcd4b4/iHUzbgDh
 203Zr3mE6EAvKalVbY9LI+1J5jnFUuCJmLE1q0HRrqlqf9MBiQ5ClQ40v4JMoFAESHdM
 8p/Sy8f0imZjSpO1YtlcP2mnLTEJ7kfQKBEygxnAeNKTkRMt7/EW1AVFcv1KCD5Lx9fM
 d+O/S7YmbmRqATdFlwU5wgwZNrSPLnpxs82a7gIPI9ZhhbuwYujQN8vd+HeypczgB802
 9SfbDIT58e6t4G6JuuIQsxpJx3VpBZpjMDLkWM3dM53r0atE/zSgWJV0Pjhzz1/UwDiA
 u+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885432; x=1768490232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7MIQqhHGiHjK31A9q/v8kSxQcCEoWSWeinQC9NCVaBA=;
 b=anN6NEehl/Jvfo2QmdrBfP4SDDtcHBdLdp17XUM22l3bo5NFyVdSi3IYIHrdO9iW5y
 OEtxgNKqkrKqWLH6lLXMz7qK1zVDjbIpG9Q8psql055chJv/He4brjX/V4Tq236rwRFr
 LjZ0T0dVBt0tRgxUxCxm66QuTdKgfCBHD9xXCEJEb3v1r4VYqN0FE7c21fP6JSHju58G
 kOPw1HKqcaCQGaxmj2ki3XwiqQd2ryvV/g/jxZzkSlJEzncFiwqHCyZLMTU6bOPFTTRS
 AfUyVP6bQBncZzxJpk/iyCQ2B5ErV6FKllux7yCy/94yDNz/QMRPmNflXj66TuqH6au3
 Xctg==
X-Gm-Message-State: AOJu0Yw4FyIICg5STdv1VJEeitLICsX92UTGwRbNiWrltwU32lH8Nr4z
 VevcJ+ar55w0JTQ0zDnv7s6zrkJphl+5+X3/P0JJ/vvg4tqowK89lxYCGZjKpqyfVtw1zN/c6aa
 quGQU2L1q2FP8Ftlx1he69ntIGoM2ut4ndgwnMZeXRKE1P5lVAbaFLfqdfom2sgyldqx44K6D7h
 ZiqBkdiiwb1wRQFeKv/Ym9CjPtWukk1Tqd9xHqt70=
X-Gm-Gg: AY/fxX6U+wFLOvIeaDXE3ENhLCcbwsN/llhGNhPIFXZS5fAQPK96dw7mVw1ojHriLP5
 osz7lI0QIx8bqTpILmY3fOSL0vRGQeUVInEf1tSB3m0DrNQlrix5UthENEL+nKqtHs62qblCrlb
 CJD1VcMeM4RNB16xCOJdCdI+HaxViMz9IW24OY78zjxv+NEaY1UX0qivUJ+ANo+p+PKY2q49+3/
 dxZlD315UV1CmaNMMv3rmBdnznv69OyTV/KAcSBHkGIOb8BcaHHHuraPMTg4B1wD7yhoblMdmRx
 eMcC9cPMxhq8THTpXCl2UokSTz9ZCRh7fzPWCKSqj9o75ZKCb1HlhezOQ2LHdbUM2pGxq/VNGwS
 X1tBDeuzQRTSPtVIF+oHgoIVMJIicXQghnBZxz5ezw8uCQ7J13MiXXfH2ev6Im6zUoQEeA7ChIb
 qajBouW+iBkKROzgoudMs/DGJK+oYP/iy58b0LpM7ZKneyifYXcwqyo1j6oOxfeysRpg==
X-Google-Smtp-Source: AGHT+IG+G97CoNDLH0W2icvGl5v99TskNlotma6+6wLfhhFqoVfmmwccKgls9tMh4ekb5n+qQU8fpQ==
X-Received: by 2002:a05:6a00:f0d:b0:7e8:450c:6196 with SMTP id
 d2e1a72fcca58-81b7f6ec189mr6111863b3a.45.1767885432053; 
 Thu, 08 Jan 2026 07:17:12 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:11 -0800 (PST)
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
Subject: [PATCH 05/18] fpu/softfloat: Add OCP FP4 E2M1 to OCP FP8 E4M3 convert
 operation
Date: Thu,  8 Jan 2026 23:16:36 +0800
Message-ID: <20260108151650.16329-6-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x429.google.com
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

This commit provides the OCP FP4 E2M1 to OCP FP8 E4M3 covert operation
for the Zvfofp4min extension.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat.c         | 37 +++++++++++++++++++++++++++++++++++--
 include/fpu/softfloat.h |  2 ++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0c7f052ec0..30ba6d6c09 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -562,6 +562,11 @@ typedef struct {
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
+static const FloatFmt float4_e2m1_params = {
+    FLOAT_PARAMS(2, 1),
+    .ocpfp = true
+};
+
 static const FloatFmt float8_e4m3_params = {
     FLOAT_PARAMS(4, 3),
     .ocpfp = true
@@ -638,6 +643,11 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
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
@@ -1664,7 +1674,11 @@ static bool ocpfp64_is_normal(const FloatParts64 *a, const FloatFmt *fmt,
     }
 
     if (fmt->ocpfp) {
-        if (fmt->exp_size == 4 && fmt->frac_size == 3) {
+        if (fmt->exp_size == 2 && fmt->frac_size == 1) {
+            if (input.exp <= fmt->exp_max) {
+                return true;
+            }
+        } else if (fmt->exp_size == 4 && fmt->frac_size == 3) {
             /*
              * The OCP E4M3 format uses only two bit patterns for NaN (a
              * single mantissa-exponent bit pattern with the sign bit) in
@@ -1704,7 +1718,11 @@ static bool ocpfp128_is_normal(const FloatParts128 *a, const FloatFmt *fmt,
     }
 
     if (fmt->ocpfp) {
-        if (fmt->exp_size == 4 && fmt->frac_size == 3) {
+        if (fmt->exp_size == 2 && fmt->frac_size == 1) {
+            if (input.exp <= fmt->exp_max) {
+                return true;
+            }
+        } else if (fmt->exp_size == 4 && fmt->frac_size == 3) {
             /*
              * The OCP E4M3 format uses only two bit patterns for NaN (a
              * single mantissa-exponent bit pattern with the sign bit) in
@@ -1791,6 +1809,13 @@ static const uint16_t rsqrt_tab[128] = {
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
@@ -2999,6 +3024,14 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     }
 }
 
+float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float4_e2m1_unpack_canonical(&p, a, s);
+    parts_float_to_ofp8(&p, s, &float8_e4m3_params);
+    return float8_e4m3_round_pack_canonical(&p, s, &float8_e4m3_params);
+}
 
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
 {
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 13b882bc67..b199a029b0 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -200,6 +200,8 @@ float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, bool saturate, float_status *statu
 float8_e4m3 float32_to_float8_e4m3(float32, bool saturate, float_status *status);
 float8_e5m2 float32_to_float8_e5m2(float32, bool saturate, float_status *status);
 
+float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1, float_status *status);
+
 /*----------------------------------------------------------------------------
 | Software OCP FP operations.
 *----------------------------------------------------------------------------*/
-- 
2.43.7


