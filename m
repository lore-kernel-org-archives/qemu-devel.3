Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813BCCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1JN-0002jO-QX; Thu, 07 May 2026 12:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ii-0001nC-BI
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:16 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ig-00088Z-A8
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:12 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4be94eeacso1098922a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778170209; x=1778775009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pu3TZxm2iTRUBoR9MHlryIG9+4ZyXp6ZsL5bLZgQwto=;
 b=XPHKj26G0JkTzVy94fTDonGduw+79dNMa2hehHLaoCpaXHEZmjctIok8AsHmXdogrb
 +O8IWplsw/a836ua72vp8EUy7z/+meBy2st3RoPnX6AFBZPAIBEKyviKafw9e6RvJspe
 L6JPS2fRX70Z/UVH1bRRiPLYEpvTHe5IW+XV39W6JQlpluMufCYZHTMGgYpRMhIJ/8eB
 2Oum0AfWxmVv50eQ4P2Vp6JdJxYCDzHHwqs8w6eE+kchI0IWk0juKfJ9C40g11kx1vAw
 rClY1/QmMe9EC+WwEY0mGKkik/TU+p4Mz3nSzPyuJr1Hg8Ujpx9gzWTzVQgFbTJVCGDP
 Rosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778170209; x=1778775009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Pu3TZxm2iTRUBoR9MHlryIG9+4ZyXp6ZsL5bLZgQwto=;
 b=php8frzNAgpawhuX5G1TJngUf7VpLcRIxC689qVgj/XklMkDYfLhErdgmAuVMgDHn7
 C9YCPV9xgrdSyXPJ0t5k0qGzgG/JFdqQnMQRz58p2H3LDe58A+0mKurkOsK1ri74q5Gx
 ZVg074rq2IKPhlFUP+8C3o3SdcLZM+IDEb0AxblEHyCb+LbexYQ1nit0XVLnH4dw4YdI
 FsrNxmOuS5O1qt6PE1FmwUxu0GArN2nsEqQCX2UEsOaW0cSTbmZThwdREung26g+Tfhg
 tvNFcWRF1UZijl+QBoo9uTTRrV2RucKuf44uXJYCn5WbV1pDg6aV8/nT0rOLKnChJHnJ
 suoA==
X-Gm-Message-State: AOJu0YxMc/IpZnoGd62LldOhIn1FuddUlviqOGRMdhpBFwM59qafqE0+
 /jhe9HLj9YA+S7qR0NCqrbX+N3kCQqEfrwuxWbC1HfJDBu76GCshExkc4x1QwS+x8G6VwaQpUUS
 IJOWv
X-Gm-Gg: AeBDiesOPR2s4hC5qDPuuRoa21gndrN9Lm3m0ER2MvHklgyAhl2DRt+rOBlBvHJH/r4
 YMCrFl74Op4qsvQw/Uzz3ZiVDlivIPOSttcnEvmhHhX0gNTuqMmMrBcecJ+20L5ilWA67Y5GrX1
 VM1qf1fj/tTJdRfVA0s84Fn6yAWZ0NZyYgATLQowDNGKU13YJx56kkNJpIIxXAaNzy7vfoJCoyS
 Qld8Im97gPgTP6k1jSIQDIbbmYHGZU7UentWLp471HR6C5l+z/yznKRJ/xZjsQZPGblCkt+93sc
 d4Q7SqUq0bBszwDbxhNKwv4eEs4R0EOsaO72JvBsCkdfAt3pS5k/EnVYNpo4eNSzXP57bcEbP2o
 6duNTHegFzAI8JFZePRc72lsEk68GJ1eOWbbM9mnAkTxik/VoPerTp49M7bF7uuPccwV6RYhJpD
 lNajnFh3PunqOPqJZ+S41+AQYKMFoBAyUedgrlC96fVFpvhw==
X-Received: by 2002:a05:6830:b95:b0:7de:d056:19d with SMTP id
 46e09a7af769-7e1dea1fffemr5393173a34.0.1778170209039; 
 Thu, 07 May 2026 09:10:09 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e302462fb1sm16415a34.11.2026.05.07.09.10.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:10:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/11] target/arm: Use FloatParts64 in bfdotadd_ebf
Date: Thu,  7 May 2026 11:09:55 -0500
Message-ID: <20260507160959.449170-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160959.449170-1-richard.henderson@linaro.org>
References: <20260507160959.449170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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


