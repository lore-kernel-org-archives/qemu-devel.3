Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65075FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEwO-0001pX-H8; Wed, 29 Apr 2026 20:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvc-0008Eg-4O
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:57 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvZ-0001xV-4A
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82f6b592fc7so143258b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507606; x=1778112406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pu3TZxm2iTRUBoR9MHlryIG9+4ZyXp6ZsL5bLZgQwto=;
 b=b3GRJzBLv7zF9txX1X8KGbjNffeFCwZeOzEm6oRSCSHq1vYoPg2uFtSpybUmFveEzn
 qBAfrTV8pNJ14kiaunKcA22zA080i7Pwg35DHoPpb/dNbPAjLaCWy16wQYsXy4asUoqG
 Uc3pmYN81UH0aeSt3TZBcKkkmhKK3EoMne7JSiemiHd+Bv2T5ypRqBmW3OdsZsIaXKqr
 o5y6YSsDAGYFdOYYFj9w3djrdnHqyp41W4k6eNLd0iOIr6j6UiYrlGPqzjL2Zuo875bi
 6Ha3Vnb55wsXMzRZEQBbiNcnlMfD3N3i7VTii+XrtX/JXR7k5gXHHBU9kkolKjPaUAq2
 mG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507606; x=1778112406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pu3TZxm2iTRUBoR9MHlryIG9+4ZyXp6ZsL5bLZgQwto=;
 b=fmpNiPWh5wi7l4exw5tVkrjqA8m53Df1MXDMoPpx7xYh3hPBUe0cAz/G36OfNXR1ov
 9ZcmxRtFs6iqUBEHuKdyzFxODTWVF5ONAgEBYDQQsXreH2C79gxEhCoJdsfwvuFLkYuA
 OqGgcFdeUp7RjCUN5SLFjbtAQRAzYXnzxFudfOFKlwvPqtSQVrorXib8LoTNetueME6n
 4CZgr+cQBKAYiE4Bn8iXO/BdnKvUqHdJ12//Mm8/+XYmRpmFe975hXbi3nFebcGEOBCT
 /9rujDMV2def1bmGPkBoVvc2SN4S5Jm6mBx2hs2vCC4uDskelRwDGXV+FlXPBHoOad8l
 gH1Q==
X-Gm-Message-State: AOJu0YwJUgsOXd0gZbLrZn+VxAGNIMaQ+G80l3/91AMI+pzRhO7nOkkv
 0H1kpMExPbnBSWc4hG1au1VwZ/JTKkpRX7iVRoffcsYIasmWKOlxwMKM/pCz9qSkp7SX/9tm1Xo
 8f8p8sgs=
X-Gm-Gg: AeBDietxxObbLlKEkjDXgImuPq65IGRBH7gT30fSGxRRlKkYbgkhXBq27F4E8kmTrH/
 UpFA8o4vV0S7AhkibCZ+l/xPh7ovupOO8n4kcsmmdgOScVIbUgzw6H2tcVG3g7v7ajLw4X/Nxj4
 1H/kW6g88cwA2ipejXYVeBAlHfSKdsccUL3N/v3o/SIdsRi0E4pP8IJkseYHrPAVaYZ8OQag4WF
 QPpSah3ZcUGavRVJ4DerZ0j48vJkSgT36jo4a4g4b/cq1p1HR4stFbyfD9Cofffm6Uq6Xg4L0n2
 gGwG2yOa4ah1iYjCcgwYqH5MlCrQMRlqabYIOvtsaox+V6Lk9H017lKup7SRvWyM4O25OOot4JG
 ddCd/k8Njim5RRl9GwaudmI62pUPdR9snAjuoCT0M280LciK82XYWopD42/wXk1DaOpshRj7CZ8
 Lh8i0zv2B/MiS4Vjbm0d2sRKLrMNMDcoFDhR4rrJXZ
X-Received: by 2002:a05:6a00:228e:b0:834:df57:9d67 with SMTP id
 d2e1a72fcca58-834fdc16541mr779425b3a.32.1777507605997; 
 Wed, 29 Apr 2026 17:06:45 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 34/40] target/arm: Use FloatParts64 in bfdotadd_ebf
Date: Thu, 30 Apr 2026 10:05:17 +1000
Message-ID: <20260430000524.56046-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
---
 target/arm/tcg/vec_helper.c | 77 +++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 91e98d28ae..85bcaac3d1 100644
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
@@ -2895,61 +2896,63 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
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
+                    float_cmask(p1r.cls) | float_cmask(p1c.cls));
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
+        FloatParts64 tmp = parts64_mul(&p1r, &p2r, fpst);
+        tmp = parts64_muladd(&p1c, &p2c, &tmp, 0, fpst);
 
-        /* This conversion is exact, because we've already rounded. */
-        t32 = float64_to_float32(t64, fpst);
+        t32 = float32_round_pack_canonical(&tmp, fpst);
     }
 
     /* The final accumulation step is not fused. */
-- 
2.43.0


