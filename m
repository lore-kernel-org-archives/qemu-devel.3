Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4998BCD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX23h-0004aA-BA; Tue, 09 Jun 2026 15:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21Z-0003KQ-Sq
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21G-0003z5-P2
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:00 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2bf20f6be6bso46963205ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032872; x=1781637672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhdSt/yYvJaGMbP1xd4fHeyPmVI1491cJ0UqIh8obAI=;
 b=kXRlwwS3WHmDg23tHwMHGpjoqbgLeGBwUh0jH1mhXS71LjNhbQZqKyw17JyZ/g+0ip
 A2L2FijJFv5E0uV5iDyfP4Qa9e1Tl4iO8tSo/Reyc/Q2yYYy1Q0P7sqtN6usGIajHqm/
 ibfn3MzO9XwRITKbfC1L9wQDxksg08cnePEdWOyiaD9bgbQCkjHk7bZg3A5KmHetUcN4
 Ou0iVALQc1qqKp3e1ScwP66ZXUu3XsFqpRBOJWAIxQqF3sqc56aeTZ89cjnsrGePEThb
 ChWA6mPTBM899PauMqPGNfhlwPVIMnqxOnj+brRjq1irXKIkhakcC/diVK6vsX3QTGAS
 dAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032872; x=1781637672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QhdSt/yYvJaGMbP1xd4fHeyPmVI1491cJ0UqIh8obAI=;
 b=Vpto8ChSe4Eoj77bqDMZ6EQYspbFle//u9UZ7I2Or/mt493OdMk7D6almU4cX4Z9Nc
 604811geL4HQTywWHFubQgFvy8yF6ckuEci1/Kqcfsyzzybj+FfkqbCf79CgeMBGu90I
 aiiC2nSHxgicpRlA9owD6dB6WZFakL92qjux/Y5pz41oByFHPluOi0kGbaQSAMn83mVC
 YQhPEYUBSsTs+SEoVYKRdMLg6fvGQTqGY5uE4EyFyvesbbK2VSnbWCpLXJgS5U5P8lk7
 1kJJgWRT+aw+7FPLNx+VBtZ9FWf2N9nXlgnizGSnUtXq3PYFvSgIyDDbOsiQjT8hjzbL
 5hOA==
X-Gm-Message-State: AOJu0Yxu7d/DtgoRsKq1N/7Ff/VAEYi25R5VHe4AkYj9K3luBUUa3Jgv
 uC1KDwwsnsZ/CpzRQtzuB++oHlpxNPmcIOldLF+hWQB4TO2dLdqSvPjy7r30SDIVWV0RqS94Gl8
 eJfOvFbA=
X-Gm-Gg: Acq92OHRKSFtRwEq6NbtEi2mJDLvDi7XgkChDyyMM70IlhOekRJc/QveqiDMR3+AvJR
 bs2y/M8OoayR6SmjojhbmnbRHP7vF9nDRqC4dSBD/wxF8ClDTAW1gLfS7W5zkwwTC2UsnYE+tb9
 dXbI8I0cpNCRoOngOMcPdiQmb07Dx1iqTHOBo6N7n8Mx3DsqrORzCT9Jv8vyTiHUJkKRjr4ieXg
 lg0OPzXbfdPogEGxLyyKk9QxqVDGRsDSeHccS3Wh8nQH5t6Gc31GNsop2+RXHgaqK4meg2J/eB6
 ozHxzNuM+PbkfvPfz+0Nq0wENUMcq9+GQ5yWsHpm30c9tCv0jrbqeQ+kVaxpEPIR6FDpl5N6tx8
 eE8YB6kUAGyydxhT+qSbMIKOvtSL+Ax9eIagOgmQmiOqNwapQ7XJldN+MZRq6WUmu3i3mryn1iH
 qeYNt3HAitoHXSBhJwaIojqgeWqmUw7ptkOn5oSeM=
X-Received: by 2002:a17:903:1aed:b0:2c2:245a:3364 with SMTP id
 d9443c01a7336-2c2245a35e2mr171679575ad.32.1781032871887; 
 Tue, 09 Jun 2026 12:21:11 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 01/45] target/arm: Use FloatParts64 in bfdotadd_ebf
Date: Tue,  9 Jun 2026 12:20:25 -0700
Message-ID: <20260609192110.752384-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Use softfloat-parts.h so that we can more naturally
perform the required operations witha single rounding step.
This happens to also simplify the NaN detection step.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260517002550.321291-9-richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 78 +++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 91e98d28ae..12fb62958f 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -22,6 +22,7 @@
 #include "helper.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
+#include "fpu/softfloat-parts.h"
 #include "qemu/int128.h"
 #include "crypto/clmul.h"
 #include "vec_internal.h"
@@ -2895,61 +2896,62 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
 float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
                      float_status *fpst, float_status *fpst_odd)
 {
+    /* Unpack two BFloat16 into two Float32, trivially. */
     float32 s1r = e1 << 16;
     float32 s1c = e1 & 0xffff0000u;
     float32 s2r = e2 << 16;
     float32 s2c = e2 & 0xffff0000u;
     float32 t32;
 
+    /*
+     * Compare f16_dotadd() in sme_helper.c, but here we have
+     * bfloat16 inputs. In particular that means that we do not
+     * want the FPCR.FZ16 flush semantics, so we use the normal
+     * float_status for the input handling here.
+     */
+    FloatParts64 p1r = float32_unpack_canonical(s1r, fpst);
+    FloatParts64 p1c = float32_unpack_canonical(s1c, fpst);
+    FloatParts64 p2r = float32_unpack_canonical(s2r, fpst);
+    FloatParts64 p2c = float32_unpack_canonical(s2c, fpst);
+
+    int all_mask = (float_cmask(p1r.cls) | float_cmask(p1c.cls) |
+                    float_cmask(p2r.cls) | float_cmask(p2c.cls));
+
     /* C.f. FPProcessNaNs4 */
-    if (float32_is_any_nan(s1r) || float32_is_any_nan(s1c) ||
-        float32_is_any_nan(s2r) || float32_is_any_nan(s2c)) {
-        if (float32_is_signaling_nan(s1r, fpst)) {
-            t32 = s1r;
-        } else if (float32_is_signaling_nan(s1c, fpst)) {
-            t32 = s1c;
-        } else if (float32_is_signaling_nan(s2r, fpst)) {
-            t32 = s2r;
-        } else if (float32_is_signaling_nan(s2c, fpst)) {
-            t32 = s2c;
-        } else if (float32_is_any_nan(s1r)) {
-            t32 = s1r;
-        } else if (float32_is_any_nan(s1c)) {
-            t32 = s1c;
-        } else if (float32_is_any_nan(s2r)) {
-            t32 = s2r;
+    if (unlikely(all_mask & float_cmask_anynan)) {
+        if (unlikely(all_mask & float_cmask_snan)) {
+            if (p1r.cls == float_class_snan) {
+                t32 = s1r;
+            } else if (p1c.cls == float_class_snan) {
+                t32 = s1c;
+            } else if (p2r.cls == float_class_snan) {
+                t32 = s2r;
+            } else {
+                t32 = s2c;
+            }
         } else {
-            t32 = s2c;
+            if (p1r.cls == float_class_qnan) {
+                t32 = s1r;
+            } else if (p1c.cls == float_class_qnan) {
+                t32 = s1c;
+            } else if (p2r.cls == float_class_qnan) {
+                t32 = s2r;
+            } else {
+                t32 = s2c;
+            }
         }
         /*
          * FPConvertNaN(FPProcessNaN(t32)) will be done as part
          * of the final addition below.
          */
     } else {
-        /*
-         * Compare f16_dotadd() in sme_helper.c, but here we have
-         * bfloat16 inputs. In particular that means that we do not
-         * want the FPCR.FZ16 flush semantics, so we use the normal
-         * float_status for the input handling here.
-         */
-        float64 e1r = float32_to_float64(s1r, fpst);
-        float64 e1c = float32_to_float64(s1c, fpst);
-        float64 e2r = float32_to_float64(s2r, fpst);
-        float64 e2c = float32_to_float64(s2c, fpst);
-        float64 t64;
-
         /*
          * The ARM pseudocode function FPDot performs both multiplies
-         * and the add with a single rounding operation.  Emulate this
-         * by performing the first multiply in round-to-odd, then doing
-         * the second multiply as fused multiply-add, and rounding to
-         * float32 all in one step.
+         * and the add with a single rounding operation.
          */
-        t64 = float64_mul(e1r, e2r, fpst_odd);
-        t64 = float64r32_muladd(e1c, e2c, t64, 0, fpst);
-
-        /* This conversion is exact, because we've already rounded. */
-        t32 = float64_to_float32(t64, fpst);
+        FloatParts64 tmp = parts64_mul(&p1r, &p2r, fpst);
+        tmp = parts64_muladd(&p1c, &p2c, &tmp, 0, fpst);
+        t32 = float32_round_pack_canonical(&tmp, fpst);
     }
 
     /* The final accumulation step is not fused. */
-- 
2.43.0


