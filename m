Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C12CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLY0-0000Tk-Ir; Wed, 10 Jun 2026 12:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXo-00087B-NI
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXm-0005a1-Qa
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-46015dc517aso5625646f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107961; x=1781712761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kk5yPmaEwbU+tK815yLwz23ZBvPuXDa1/0rsNRgsUl0=;
 b=CxshXtzOA+t+Yusa9pg61gJLjROM026QsBqmDUCvpAHvdpfbaC9HP2By/A0hyEaU9l
 ldrnqjzF9J0QC+hJY1uSR8iQfy/08+MDP4CX8cdu2Rug3NLw8KU9YPJ2+TEbv882Jz/d
 0kd91uDlIqR5nN3yhUBY+CI6ptGo3P3tE1GoXHL4qRC8IuiT0EUNiCcK0d354AXJw3B9
 d8no9XyUU3yJqqF7mhnnYsy1yUHakl5bn13Gb3EULJoVC6XdywOP0LD3HzemEnmR53x+
 yO+LKd9AGwRcfq7j3+tFVWU2UikF4YmjK1PEBgPUGI4QBZuSs+USR6t4pKr0mNi5EEHo
 J9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107961; x=1781712761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kk5yPmaEwbU+tK815yLwz23ZBvPuXDa1/0rsNRgsUl0=;
 b=GC0FIez58N693pD8oGkb8amcP9IB/iSUQidxhNl3HJ+2Zs5K/4E4SahwMglfU77pRA
 2RSNk2q/cDcj2LfqgYR0t46H2lr0dFF5L/HjRYcuv/x5YTn4wKiRrR/YPf/+G9yvS44L
 fnDOOj8jPov7FFxYad+Pflt9Ui3iWf5eT+H/R8n1ZqaZMkzbu9Z9a/uweH7r3hdZnmuP
 35T0cGVjka9jjb+hxFERxZvVwwTK9unU3RzlqsHaGOse5IeH3MCVCqTZHowZVcVHZAXD
 +vyHDZWrS5FmAEAKroPozLoayqBX9l1LIqipgfMq+nT4f1EJ/wWXi6l15XIy6+5Rl5S8
 5PTg==
X-Gm-Message-State: AOJu0YwuucwdmmCkaNfW1X8ZPwbP9MCr/csPf8okb170LUHbmbysUq8B
 DpjBbFa/3Yyah+Ph0MwPwAHM39qcPwTk4/oqR/7SZOLWAMsn2rAhiDnW3HWfnH8XNVYeigvZdUP
 /09Cq
X-Gm-Gg: Acq92OGF1oEtkCAC0z0/82jveREFT7t45Vw66lS9egflHSCFozjqapgVedCleZtwCic
 ZwOw3IXH+8C/l83zuGCVWI6PvkpnCqjZp3v5MCqBfC+YJeCNgg4iHIHKfx7In9w0jEouIgLChU4
 m7DyaMguUlVjkwjIUm+BZK2LIM8LOY8wTrDccO9hLP8FRPfz+zaZJyfJ5gd17DCE/SYQKx704IY
 /DtekTRzRDgf8AWkJ5BtyzRNQ+wxpH0m4+l8CqQc64PUcapy2ANI7mfsih8uthSCBL+zdRXZxQB
 P2+pe7DmwqXzM+mfHRIZEhZ0I6u1ZjRgHefdwtCpWOY6RNO4h3ZrkbsQfGKut60UCG2QI9AKzdt
 dcWHFDYkW8+pnixhq+Aib6ditW8ECqJLL3rr0hxAv46Pq/xl0IJJOU/1pk9FH4PQMh2kR8IBWk+
 0+T9vYLVcjCdMGQ6DOzR6Or2tV6ZgJWXE7ZoN32O88O/fUHDfrDbi2hBbd1Gs0SS2W2FK4IY+Cg
 vE8kxw5AAnVfoCcNnaRXlVwrcpy+dNAAjJelGAaDf4=
X-Received: by 2002:a5d:4e03:0:b0:43d:740:fb37 with SMTP id
 ffacd0b85a97d-46030641a81mr30626698f8f.24.1781107961126; 
 Wed, 10 Jun 2026 09:12:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/71] target/arm: Use FloatParts64 in bfdotadd_ebf
Date: Wed, 10 Jun 2026 17:11:18 +0100
Message-ID: <20260610161202.2235298-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Use softfloat-parts.h so that we can more naturally
perform the required operations witha single rounding step.
This happens to also simplify the NaN detection step.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260609192110.752384-2-richard.henderson@linaro.org
Message-Id: <20260517002550.321291-9-richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


