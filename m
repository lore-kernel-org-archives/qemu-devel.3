Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F199CD25950
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkchn-0002mQ-6w; Tue, 27 Jan 2026 01:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchl-0002ls-Sd
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:37 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkchk-0006gl-1j
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:37:37 -0500
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-34be2be4b7cso2842013a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495854; x=1770100654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXeb82MfeyWHVGXBNCmWOgTZPBr/H/1jUT/Lwlynhzs=;
 b=RGCdXMFTuBj+TdgcSzZxw1qVkNcopUOQ2hIdkOjLfc0In9zo2U6sjEaIE6viltUrDV
 4SEOvwHgvGB78bePUYFX1NSZkYy5tY1FVyLUPKo64/b7fWhPOPOxJWfRmZnwT8IuWgSt
 EqYViYijG2DGzCrj583Z51mS9NA8xDXSdhwM7uStl+KZ7o364JMTIDpzVQKQc2Io2G9s
 FN6SwaUzs3uthMUZmxwAAj/CnF14bKSeYCazBxbf8Ee/S/bZTXgzhK8dGcFDV+gdQD/0
 C5ecJF+c6/fq7G0c6yoWGvXdpa30RVE+hZaqaxazNsXi/CEmdxDkHaM/qhmfv0NIVriJ
 QYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495854; x=1770100654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QXeb82MfeyWHVGXBNCmWOgTZPBr/H/1jUT/Lwlynhzs=;
 b=gZxO2+mLRiA5t7A4VkAxZL2+qgmtrhRnqhysdIsu1syDilGh9TbtpisIhkbQT/lACp
 lZDcom8Xp+U1fUzq23TPKWQdMN8J9wL6oE32gREc9jp7iAPTiLLOaGnPhj4MTSqfobzK
 uLv+NkNSCp28wBH5yro1e2+QQNibsAWrHqrJ/jWeQGapEJnvY6URvYjP+kgbQ1FVOB1G
 uP5TvXc9Vk8ueGf97aSkezZYqRGBoFq8Q/oEmTAJG2cIZQdV3q5/REbyrDyS6Et50Zjd
 6jVHZLVvwekQQcB4bfGF50uuh+9zNGcXZNH9qkVCt9B8dMx0sOg1wqRyAaKYCZk4pM1p
 Rt8Q==
X-Gm-Message-State: AOJu0YxBuNp3GwRKMtgLhzrKDRofQ0iMifq4iZzysrLqFKceagEH9wzE
 yzWzCKwEzZC8A4NiGdF+HfT/k4BpuTRI5NAEjmCZS2qdat0cK4ksj9FP1MFIEnyx9C6vG5q25mq
 6MiE2r0SJZbSG6CQ+2MLKI5SEQXIxMVEZXH2TSv81jDG9/wqHelJQDbz2Cc2frvBsL3GB7sqntC
 Nm2l/axZgDbfhalhAeImGI2RWUwYfog2GGk7E0nDI0sw==
X-Gm-Gg: AZuq6aLGKc8XkbsENEKIt1R003VA2qXaSyDbTnSOSTWevip8BRJ89p85Kob+jqHwyeO
 VgJr1+6QYgZNasdMC5EADGdTJ/TehM7QqUmjXfevrU30J+DwTIPegoLxSeFysFKIssdJkZOtoyh
 WsMGtYkUZCm7NVeGvTxj/aZHBWyxiS7xT5rSZOGB/0qJHAbGYKGmymIqdnyzFUFB4WBHnrsAKZB
 KlOdTVeP+e5yVDe7VufzPIZWsxgjNcm3t5ku5V61z6FvrbtsAuo6NFztyLbbvtDBcLpI/UKwaF5
 NELsSoT/unvcTCNj8c0Th/MauAcZO8+ctbU5xYv8fLhMeCG6DWtAkZiV7r+SfRHKwsvOET1T+Aj
 Bq486B9JzQ4mr8KTSpTMKLjqIoIL2/EmZY6jmf9bK/G8Ag/+YUey4huFYcRBVCBIdQFehKfzYfU
 DWE8s4imYRigDgU7Z87CIzSHt2GyJZLrQ39iUchfC5/Kqy0azWMaMXVHZNmMeT4rLMiU/5KIbMA
 8tvt6vtcewd0O0=
X-Received: by 2002:a17:90a:f950:b0:340:f05a:3ed3 with SMTP id
 98e67ed59e1d1-353fed75832mr1176571a91.17.1769495854201; 
 Mon, 26 Jan 2026 22:37:34 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:37:33 -0800 (PST)
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
Subject: [PATCH v2 02/17] fpu/softfloat: Refactor IEEE format NaN
 classification to share code
Date: Tue, 27 Jan 2026 14:37:08 +0800
Message-ID: <20260127063723.442734-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1041.google.com
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

The floatN_is_[quiet|signaling]_nan functions for IEEE formats
(float16, bfloat16, float32, float64) contain duplicated logic that
should be shared.
This commit introduces internal helper functions:
[float16|bfloat16|float32|float64]_is_snan_internal
that determine if a NaN is signaling.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat-specialize.c.inc | 152 +++++++++++++++++----------------
 1 file changed, 78 insertions(+), 74 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ba4fa08b7b..ce7315c996 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -225,6 +225,22 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
     bool z = status->floatx80_behaviour & floatx80_default_inf_int_bit_is_zero;
     return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
 }
+/*----------------------------------------------------------------------------
+| Internal helper: Determine if float16 NaN is signaling.
+*----------------------------------------------------------------------------*/
+
+static bool float16_is_snan_internal(float16 a, float_status *status)
+{
+    if (!float16_is_any_nan(a)) {
+        return false;
+    }
+    if (no_signaling_nans(status)) {
+        return false;
+    }
+    uint16_t frac = float16_val(a) & 0x3FF;
+    bool frac_msb = (frac >> 9) & 1;
+    return frac_msb == snan_bit_is_one(status);
+}
 
 /*----------------------------------------------------------------------------
 | Returns 1 if the half-precision floating-point value `a' is a quiet
@@ -233,17 +249,27 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
 
 bool float16_is_quiet_nan(float16 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return float16_is_any_nan(a_);
-    } else {
-        uint16_t a = float16_val(a_);
-        if (snan_bit_is_one(status)) {
-            return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
-        } else {
+    if (!float16_is_any_nan(a_)) {
+        return false;
+    }
+    return !float16_is_snan_internal(a_, status);
+}
 
-            return ((a >> 9) & 0x3F) == 0x3F;
-        }
+/*----------------------------------------------------------------------------
+| Internal helper: Determine if bfloat16 NaN is signaling.
+*----------------------------------------------------------------------------*/
+
+static bool bfloat16_is_snan_internal(bfloat16 a, float_status *status)
+{
+    if (!bfloat16_is_any_nan(a)) {
+        return false;
+    }
+    if (no_signaling_nans(status)) {
+        return false;
     }
+    uint16_t frac = a & 0x7F;
+    bool frac_msb = (frac >> 6) & 1;
+    return frac_msb == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
@@ -253,16 +279,10 @@ bool float16_is_quiet_nan(float16 a_, float_status *status)
 
 bool bfloat16_is_quiet_nan(bfloat16 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return bfloat16_is_any_nan(a_);
-    } else {
-        uint16_t a = a_;
-        if (snan_bit_is_one(status)) {
-            return (((a >> 6) & 0x1FF) == 0x1FE) && (a & 0x3F);
-        } else {
-            return ((a >> 6) & 0x1FF) == 0x1FF;
-        }
+    if (!bfloat16_is_any_nan(a_)) {
+        return false;
     }
+    return !bfloat16_is_snan_internal(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -272,16 +292,7 @@ bool bfloat16_is_quiet_nan(bfloat16 a_, float_status *status)
 
 bool float16_is_signaling_nan(float16 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint16_t a = float16_val(a_);
-        if (snan_bit_is_one(status)) {
-            return ((a >> 9) & 0x3F) == 0x3F;
-        } else {
-            return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
-        }
-    }
+    return float16_is_snan_internal(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -291,16 +302,24 @@ bool float16_is_signaling_nan(float16 a_, float_status *status)
 
 bool bfloat16_is_signaling_nan(bfloat16 a_, float_status *status)
 {
+    return bfloat16_is_snan_internal(a_, status);
+}
+
+/*----------------------------------------------------------------------------
+| Internal helper: Determine if float32 NaN is signaling.
+*----------------------------------------------------------------------------*/
+
+static bool float32_is_snan_internal(float32 a, float_status *status)
+{
+    if (!float32_is_any_nan(a)) {
+        return false;
+    }
     if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint16_t a = a_;
-        if (snan_bit_is_one(status)) {
-            return ((a >> 6) & 0x1FF) == 0x1FF;
-        } else {
-            return (((a >> 6) & 0x1FF) == 0x1FE) && (a & 0x3F);
-        }
+        return false;
     }
+    uint32_t frac = float32_val(a) & 0x7FFFFF;
+    bool frac_msb = (frac >> 22) & 1;
+    return frac_msb == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
@@ -310,16 +329,10 @@ bool bfloat16_is_signaling_nan(bfloat16 a_, float_status *status)
 
 bool float32_is_quiet_nan(float32 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return float32_is_any_nan(a_);
-    } else {
-        uint32_t a = float32_val(a_);
-        if (snan_bit_is_one(status)) {
-            return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
-        } else {
-            return ((uint32_t)(a << 1) >= 0xFF800000);
-        }
+    if (!float32_is_any_nan(a_)) {
+        return false;
     }
+    return !float32_is_snan_internal(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -329,16 +342,24 @@ bool float32_is_quiet_nan(float32 a_, float_status *status)
 
 bool float32_is_signaling_nan(float32 a_, float_status *status)
 {
+    return float32_is_snan_internal(a_, status);
+}
+
+/*----------------------------------------------------------------------------
+| Internal helper: Determine if float64 NaN is signaling.
+*----------------------------------------------------------------------------*/
+
+static bool float64_is_snan_internal(float64 a, float_status *status)
+{
+    if (!float64_is_any_nan(a)) {
+        return false;
+    }
     if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint32_t a = float32_val(a_);
-        if (snan_bit_is_one(status)) {
-            return ((uint32_t)(a << 1) >= 0xFF800000);
-        } else {
-            return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
-        }
+        return false;
     }
+    uint64_t frac = float64_val(a) & 0xFFFFFFFFFFFFFULL;
+    bool frac_msb = (frac >> 51) & 1;
+    return frac_msb == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
@@ -348,17 +369,10 @@ bool float32_is_signaling_nan(float32 a_, float_status *status)
 
 bool float64_is_quiet_nan(float64 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return float64_is_any_nan(a_);
-    } else {
-        uint64_t a = float64_val(a_);
-        if (snan_bit_is_one(status)) {
-            return (((a >> 51) & 0xFFF) == 0xFFE)
-                && (a & 0x0007FFFFFFFFFFFFULL);
-        } else {
-            return ((a << 1) >= 0xFFF0000000000000ULL);
-        }
+    if (!float64_is_any_nan(a_)) {
+        return false;
     }
+    return !float64_is_snan_internal(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -368,17 +382,7 @@ bool float64_is_quiet_nan(float64 a_, float_status *status)
 
 bool float64_is_signaling_nan(float64 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint64_t a = float64_val(a_);
-        if (snan_bit_is_one(status)) {
-            return ((a << 1) >= 0xFFF0000000000000ULL);
-        } else {
-            return (((a >> 51) & 0xFFF) == 0xFFE)
-                && (a & UINT64_C(0x0007FFFFFFFFFFFF));
-        }
-    }
+    return float64_is_snan_internal(a_, status);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.52.0


