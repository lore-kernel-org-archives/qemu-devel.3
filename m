Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B2DD1D47A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrlG-0000sP-2T; Thu, 08 Jan 2026 10:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrl9-0000oq-Rp
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:13 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrl6-0003IA-O2
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:11 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b89c1ce9easo2344357b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885426; x=1768490226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOScBP11dw49/DS+SpDPvEYrZpV2teBxGPTI7IfF9QQ=;
 b=CYLAtfKDNJeG1z00PaU5LKi8ynwc49IqR+hsfYx3I+lllkQe+i2mvjv7+rU3GeF2z/
 BU8KGhHynp+Ln+XC9aYJkj3HSyrbIl+kmpDZHdakxLD4XGvgV77M6aY22biCalcFvdFl
 TRKL+Kwiw1d70kXnQX86jbbAwsF2PYjbw2diQlQVgtceZ1siFZYEtZo4pBgg3egebTeA
 NfRnRRHRObp7ACYCM3Z+Uz/LsDe3UKzWde3nCDhXccpodSJWaUm6GKBIKD6MZlfZsort
 9xJusUNJE7vvnOg45n5esd2EADbRHHoIJfLyi1OuV+piJ2fmXZjmei6MAezCBc+77dyT
 L3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885426; x=1768490226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hOScBP11dw49/DS+SpDPvEYrZpV2teBxGPTI7IfF9QQ=;
 b=nl4UywI9XVK6T/5k3YUde1M+wxeU/SfGeNetZw4WX7Cf+ABIKxjU8C5EJXEdwncVG3
 NeGtBJZlcUqqzedANQact+VJ8h1v9ySVi28mIMScskIeYkLLQLEpC39VNnHjOz8CZHu8
 rycq4bKjOWuXuOseJTQ8GxyTxTOxEa0JcdEydAsVg2a5F+2JtcFx8ihU0Nj9ME57WzCb
 yLCFUMgJVwGFj3JRkFLY9jaH88Xx2ggITxdnaW92ptpZcMv2BtAjCtZcxRY1Wc4CVKj2
 S2OIeXDKplep4Ig9D4X282rfW1s573IN5sbEHj5xvigr0ZUILAHwM/1RocSN49sD6cuc
 nWeA==
X-Gm-Message-State: AOJu0YxdpKPDcfPeAXF7VA6SPwWFq3ay7GrdpcG/uF7BohunCHsyi9lg
 Fm0fxx3Q6WDy6DQKKj+Fc/KDob6kS3DjPVzsqZNVp9peYot9yXMt4Xc0II7tEXiRfJ8ry35C8Nn
 erC9/qw1R5tDiVzq8fVIS3M6PT7AJnGl3ErPwIqpucZJBxV+IC3UKlSYvT8TaGYXwJJWv3fh+TG
 dgj/Ac3nNR1tMlPw1zENWZ0SsVeE5eXQehM6rj4Ms=
X-Gm-Gg: AY/fxX4x0vaKiCqknbACh2IN8ap0X6vRIwUGR/ImIgyAdjnsCpwNojz9NffMy9iiuPJ
 h7ctsFB8tPkoCW6v0r4HA7nZ1CcabrJ8hWKc5geKu0xUctcRSHD0gnyrhTQzHiS/dm94V4uo+Wx
 jQ/RFFs8wlF/NJWVkWzUTX8nrsMGfIbBYhNjLNcdWSA4HV1W4KR2FXUgyXBqiCXroxKqmwYqSvb
 0oUxTwZ5Yorns9XJL5kzeSJYHiW6MzeebqDMwRPdnwtWLIQCPdp188vnF6QEsHLy7n6UCvfzz6d
 Hd7Jmiy97hLEv6t6jc6NXmAaiGPzhq8PWVUsoXzSQeT1UwXh4MwDhsXMaAwlp3nYcaB0LJsIjaW
 jCKbR7hlqEYO/G03GaSCcRix6rNRxZBUUOjP9YDnPTr36n2JWD9lGo+4mrKffgMfVhX6X4KMKOA
 c9Q5LEtbJC0IRXvpQYRsg/F/pgGPiDMZRL8t9JYMuEMFBhSXYfSly4hpE=
X-Google-Smtp-Source: AGHT+IH/eD10GUyWo6It5+yFpJASyvjTvHzdgJWokFe3VB7iEMxdktUzuc/tMT2M+W6l/aTWifKwtA==
X-Received: by 2002:a05:6a00:4390:b0:81a:bd0e:fe41 with SMTP id
 d2e1a72fcca58-81b7f6e3b67mr4987584b3a.43.1767885425848; 
 Thu, 08 Jan 2026 07:17:05 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:05 -0800 (PST)
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
Subject: [PATCH 03/18] fpu/softfloat: Add convert operations(bf16,
 fp32) for OFP8 data types
Date: Thu,  8 Jan 2026 23:16:34 +0800
Message-ID: <20260108151650.16329-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42c.google.com
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

This commit provides the covert operations for ofp8(e4m3, e5m2) with
following implementation defined behaviors required by RISC-V Zvfofp8min
extension:
- The canonical NaN of OFP8 e4m3 and e5m2 is 0x7f (ocpfp8_same_cnan)
- All of the NaNs of OFP8 are quiet NaNs (ocpfp8_only_qnan)

According to the definition in OFP8 spec, the conversion from a wider
format infinity depends on the saturation mode defined in the spec.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat-parts.c.inc |  77 +++++++++++-
 fpu/softfloat.c           | 241 ++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h   |  11 ++
 3 files changed, 323 insertions(+), 6 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5e0438fc0b..d9ec3ca8ae 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -227,7 +227,8 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
             p->exp = fmt->frac_shift - fmt->exp_bias
                    - shift + !has_pseudo_denormals;
         }
-    } else if (likely(p->exp < fmt->exp_max) || fmt->arm_althp) {
+    } else if (likely(p->exp < fmt->exp_max) || fmt->arm_althp ||
+               ocpfp_is_normal(p, fmt, false)) {
         p->cls = float_class_normal;
         p->exp -= fmt->exp_bias;
         frac_shl(p, fmt->frac_shift);
@@ -236,8 +237,12 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
         p->cls = float_class_inf;
     } else {
         frac_shl(p, fmt->frac_shift);
-        p->cls = (parts_is_snan_frac(p->frac_hi, status)
-                  ? float_class_snan : float_class_qnan);
+        if (parts_is_snan_frac(p->frac_hi, status) == false ||
+            (fmt->ocpfp && status->ocp_fp8e5m2_no_signal_nan)) {
+            p->cls = float_class_qnan;
+        } else {
+            p->cls = float_class_snan;
+        }
     }
 }
 
@@ -313,8 +318,40 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             }
             p->frac_lo &= ~round_mask;
         }
+        p->exp = exp;
 
-        if (fmt->arm_althp) {
+        if (fmt->ocpfp) {
+            if (ocpfp_is_normal(p, fmt, true) == false) {
+                flags |= float_flag_overflow;
+                flags |= float_flag_inexact;
+                if (fmt->exp_size == 4) {
+                    if (fmt->ocpfp_sat || overflow_norm) {
+                        /* S.1111.110 */
+                        exp = exp_max;
+                        frac_clear(p);
+                        frac_addi(p, p, 0b110);
+                        frac_shl(p, frac_shift);
+                    } else {
+                        /* S.1111.111 NaN */
+                        p->cls = float_class_qnan;
+                        p->sign = (s->ocp_fp8_same_canonical_nan ? 0 : p->sign);
+                        exp = exp_max;
+                        frac_allones(p);
+                    }
+                } else if (fmt->exp_size == 5) {
+                    if (fmt->ocpfp_sat || overflow_norm) {
+                        /* S.11110.11 */
+                        exp = exp_max - 1;
+                        frac_allones(p);
+                    } else {
+                        /* S.11111.00 Inf */
+                        p->cls = float_class_inf;
+                        exp = exp_max;
+                        frac_clear(p);
+                    }
+                }
+            }
+        } else if (fmt->arm_althp) {
             /* ARM Alt HP eschews Inf and NaN for a wider exponent.  */
             if (unlikely(exp > exp_max)) {
                 /* Overflow.  Return the maximum normal.  */
@@ -435,8 +472,36 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
             return;
         case float_class_inf:
             g_assert(!fmt->arm_althp);
-            p->exp = fmt->exp_max;
-            frac_clear(p);
+            if (fmt->ocpfp) {
+                if (fmt->ocpfp_sat) {
+                    if (fmt->exp_size == 4) {
+                        /* S.1111.110 */
+                        p->exp = fmt->exp_max;
+                        frac_clear(p);
+                        frac_addi(p, p, 0x6);
+                    } else {
+                        /* S.11110.11 */
+                        p->exp = fmt->exp_max - 1;
+                        frac_allones(p);
+                    }
+                } else {
+                    if (fmt->exp_size == 4) {
+                        /* S.1111.111 NaN */
+                        p->cls = float_class_qnan;
+                        p->sign = (s->ocp_fp8_same_canonical_nan ? 0 : p->sign);
+                        p->exp = fmt->exp_max;
+                        frac_allones(p);
+                    } else {
+                        /* S.11111.00 Inf */
+                        p->cls = float_class_inf;
+                        p->exp = fmt->exp_max;
+                        frac_clear(p);
+                    }
+                }
+            } else {
+                p->exp = fmt->exp_max;
+                frac_clear(p);
+            }
             return;
         case float_class_qnan:
         case float_class_snan:
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8094358c2e..0c7f052ec0 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -544,6 +544,8 @@ typedef struct {
     int frac_shift;
     bool arm_althp;
     bool has_explicit_bit;
+    bool ocpfp;
+    bool ocpfp_sat;
     uint64_t round_mask;
 } FloatFmt;
 
@@ -560,6 +562,28 @@ typedef struct {
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
+static const FloatFmt float8_e4m3_params = {
+    FLOAT_PARAMS(4, 3),
+    .ocpfp = true
+};
+
+static const FloatFmt float8_e4m3_params_sat = {
+    FLOAT_PARAMS(4, 3),
+    .ocpfp = true,
+    .ocpfp_sat = true
+};
+
+static const FloatFmt float8_e5m2_params = {
+    FLOAT_PARAMS(5, 2),
+    .ocpfp = true
+};
+
+static const FloatFmt float8_e5m2_params_sat = {
+    FLOAT_PARAMS(5, 2),
+    .ocpfp = true,
+    .ocpfp_sat = true
+};
+
 static const FloatFmt float16_params = {
     FLOAT_PARAMS(5, 10)
 };
@@ -614,6 +638,16 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
     };
 }
 
+static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
+{
+    unpack_raw64(p, &float8_e4m3_params, f);
+}
+
+static void QEMU_FLATTEN float8_e5m2_unpack_raw(FloatParts64 *p, float8_e5m2 f)
+{
+    unpack_raw64(p, &float8_e5m2_params, f);
+}
+
 static void QEMU_FLATTEN float16_unpack_raw(FloatParts64 *p, float16 f)
 {
     unpack_raw64(p, &float16_params, f);
@@ -671,6 +705,16 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
+static float8_e4m3 QEMU_FLATTEN float8_e4m3_pack_raw(const FloatParts64 *p)
+{
+    return make_float8_e4m3(pack_raw64(p, &float8_e4m3_params));
+}
+
+static float8_e5m2 QEMU_FLATTEN float8_e5m2_pack_raw(const FloatParts64 *p)
+{
+    return make_float8_e5m2(pack_raw64(p, &float8_e5m2_params));
+}
+
 static float16 QEMU_FLATTEN float16_pack_raw(const FloatParts64 *p)
 {
     return make_float16(pack_raw64(p, &float16_params));
@@ -1604,6 +1648,91 @@ static void frac128_widen(FloatParts256 *r, FloatParts128 *a)
 
 #define frac_widen(A, B)  FRAC_GENERIC_64_128(widen, B)(A, B)
 
+#define OCPFP_GENERIC_64_128(NAME, P) \
+    _Generic((P), FloatParts64 *: ocpfp64_##NAME, \
+                  FloatParts128 *: ocpfp128_##NAME)
+
+static bool ocpfp64_is_normal(const FloatParts64 *a, const FloatFmt *fmt,
+                              bool is_normalized)
+{
+    FloatParts64 input;
+    input.exp = a->exp;
+    input.frac = a->frac;
+    if (!is_normalized) {
+        frac64_shl(&input, fmt->frac_shift);
+        input.frac_hi |= DECOMPOSED_IMPLICIT_BIT;
+    }
+
+    if (fmt->ocpfp) {
+        if (fmt->exp_size == 4 && fmt->frac_size == 3) {
+            /*
+             * The OCP E4M3 format uses only two bit patterns for NaN (a
+             * single mantissa-exponent bit pattern with the sign bit) in
+             * order to increase emax to 8 and thus to increase the dynamic
+             * range by one binade.
+             */
+            FloatParts64 tmp;
+            frac64_clear(&tmp);
+            tmp.frac_lo = 0b110;
+            frac64_shl(&tmp, fmt->frac_shift);
+            tmp.frac_hi |= DECOMPOSED_IMPLICIT_BIT;
+            if (!(input.exp > fmt->exp_max ||
+                  (input.exp == fmt->exp_max &&
+                   frac64_cmp(&input, &tmp) == float_relation_greater))) {
+                return true;
+            }
+        } else if (fmt->exp_size == 5 && fmt->frac_size == 2) {
+            if (input.exp < fmt->exp_max) {
+                return true;
+            }
+        }
+    }
+
+    return false;
+}
+
+static bool ocpfp128_is_normal(const FloatParts128 *a, const FloatFmt *fmt,
+                              bool is_normalized)
+{
+    FloatParts128 input;
+    input.exp = a->exp;
+    input.frac_hi = a->frac_hi;
+    input.frac_lo = a->frac_lo;
+    if (!is_normalized) {
+        frac128_shl(&input, fmt->frac_shift);
+        input.frac_hi |= DECOMPOSED_IMPLICIT_BIT;
+    }
+
+    if (fmt->ocpfp) {
+        if (fmt->exp_size == 4 && fmt->frac_size == 3) {
+            /*
+             * The OCP E4M3 format uses only two bit patterns for NaN (a
+             * single mantissa-exponent bit pattern with the sign bit) in
+             * order to increase emax to 8 and thus to increase the dynamic
+             * range by one binade.
+             */
+            FloatParts128 tmp;
+            frac128_clear(&tmp);
+            tmp.frac_lo = 0b110;
+            frac128_shl(&tmp, fmt->frac_shift);
+            tmp.frac_hi |= DECOMPOSED_IMPLICIT_BIT;
+            if (!(input.exp > fmt->exp_max ||
+                  (input.exp == fmt->exp_max &&
+                   frac128_cmp(&input, &tmp) == float_relation_greater))) {
+                return true;
+            }
+        } else if (fmt->exp_size == 5 && fmt->frac_size == 2) {
+            if (input.exp < fmt->exp_max) {
+                return true;
+            }
+        }
+    }
+
+    return false;
+}
+
+#define ocpfp_is_normal(A, F, N)  OCPFP_GENERIC_64_128(is_normal, A)(A, F, N)
+
 /*
  * Reciprocal sqrt table.  1 bit of exponent, 6-bits of mantessa.
  * From https://git.musl-libc.org/cgit/musl/tree/src/math/sqrt_data.c
@@ -1662,6 +1791,20 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
+static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
+                                         float_status *s)
+{
+    float8_e4m3_unpack_raw(p, f);
+    parts_canonicalize(p, s, &float8_e4m3_params);
+}
+
+static void float8_e5m2_unpack_canonical(FloatParts64 *p, float8_e5m2 f,
+                                         float_status *s)
+{
+    float8_e5m2_unpack_raw(p, f);
+    parts_canonicalize(p, s, &float8_e5m2_params);
+}
+
 static void float16a_unpack_canonical(FloatParts64 *p, float16 f,
                                       float_status *s, const FloatFmt *params)
 {
@@ -1682,6 +1825,22 @@ static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
     parts_canonicalize(p, s, &bfloat16_params);
 }
 
+static float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p,
+                                                    float_status *status,
+                                                    const FloatFmt *params)
+{
+    parts_uncanon(p, status, params);
+    return float8_e4m3_pack_raw(p);
+}
+
+static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
+                                                    float_status *status,
+                                                    const FloatFmt *params)
+{
+    parts_uncanon(p, status, params);
+    return float8_e5m2_pack_raw(p);
+}
+
 static float16 float16a_round_pack_canonical(FloatParts64 *p,
                                              float_status *s,
                                              const FloatFmt *params)
@@ -2759,6 +2918,23 @@ static void parts_float_to_ahp(FloatParts64 *a, float_status *s)
     }
 }
 
+static void parts_float_to_ofp8(FloatParts64 *a, float_status *s,
+                                const FloatFmt *fmt)
+{
+    if (is_nan(a->cls)) {
+        if (s->ocp_fp8_same_canonical_nan) {
+            if (a->cls == float_class_snan) {
+                float_raise(float_flag_invalid | float_flag_invalid_snan, s);
+            }
+            a->sign = 0;
+            a->exp = fmt->exp_max;
+            frac_allones(a);
+        } else {
+            parts_return_nan(a, s);
+        }
+    }
+}
+
 static void parts64_float_to_float(FloatParts64 *a, float_status *s)
 {
     if (is_nan(a->cls)) {
@@ -2823,6 +2999,71 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     }
 }
 
+
+bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float8_e4m3_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+
+    return bfloat16_round_pack_canonical(&p, s);
+}
+
+bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float8_e5m2_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+
+    return bfloat16_round_pack_canonical(&p, s);
+}
+
+float8_e4m3 bfloat16_to_float8_e4m3(bfloat16 a, bool saturate, float_status *s)
+{
+    const FloatFmt *fmt = saturate ? &float8_e4m3_params_sat
+                                   : &float8_e4m3_params;
+    FloatParts64 p;
+
+    bfloat16_unpack_canonical(&p, a, s);
+    parts_float_to_ofp8(&p, s, fmt);
+    return float8_e4m3_round_pack_canonical(&p, s, fmt);
+}
+
+float8_e5m2 bfloat16_to_float8_e5m2(bfloat16 a, bool saturate, float_status *s)
+{
+    const FloatFmt *fmt = saturate ? &float8_e5m2_params_sat
+                                   : &float8_e5m2_params;
+    FloatParts64 p;
+
+    bfloat16_unpack_canonical(&p, a, s);
+    parts_float_to_ofp8(&p, s, fmt);
+    return float8_e5m2_round_pack_canonical(&p, s, fmt);
+}
+
+float8_e4m3 float32_to_float8_e4m3(float32 a, bool saturate, float_status *s)
+{
+    const FloatFmt *fmt = saturate ? &float8_e4m3_params_sat
+                                   : &float8_e4m3_params;
+    FloatParts64 p;
+
+    float32_unpack_canonical(&p, a, s);
+    parts_float_to_ofp8(&p, s, fmt);
+    return float8_e4m3_round_pack_canonical(&p, s, fmt);
+}
+
+float8_e5m2 float32_to_float8_e5m2(float32 a, bool saturate, float_status *s)
+{
+    const FloatFmt *fmt = saturate ? &float8_e5m2_params_sat
+                                   : &float8_e5m2_params;
+    FloatParts64 p;
+
+    float32_unpack_canonical(&p, a, s);
+    parts_float_to_ofp8(&p, s, fmt);
+    return float8_e5m2_round_pack_canonical(&p, s, fmt);
+}
+
 float32 float16_to_float32(float16 a, bool ieee, float_status *s)
 {
     const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 6f7259f9dd..7ab585bfc8 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -189,6 +189,17 @@ float128 int128_to_float128(Int128, float_status *status);
 float128 uint64_to_float128(uint64_t, float_status *status);
 float128 uint128_to_float128(Int128, float_status *status);
 
+/*----------------------------------------------------------------------------
+| Software OCP FP8 conversion routines.
+*----------------------------------------------------------------------------*/
+
+bfloat16 float8_e4m3_to_bfloat16(float8_e4m3, float_status *status);
+bfloat16 float8_e5m2_to_bfloat16(float8_e5m2, float_status *status);
+float8_e4m3 bfloat16_to_float8_e4m3(bfloat16, bool saturate, float_status *status);
+float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, bool saturate, float_status *status);
+float8_e4m3 float32_to_float8_e4m3(float32, bool saturate, float_status *status);
+float8_e5m2 float32_to_float8_e5m2(float32, bool saturate, float_status *status);
+
 /*----------------------------------------------------------------------------
 | Software OCP FP8 operations.
 *----------------------------------------------------------------------------*/
-- 
2.43.7


