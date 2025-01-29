Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975D7C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx32-0000vV-5Y; Tue, 28 Jan 2025 20:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2z-0000tO-Ib
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:17 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2x-0003Yy-Og
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:17 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21634338cfdso44093865ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114754; x=1738719554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQXFLumUgBbRiy8BtW3KvH3FB2G39x8TUOHn6sQx/Go=;
 b=fsrAwtHO3Gir1MYSrWFr2nL6AL8joc9UHdHEeIOdgBhLCFCuP7vUH2PvnLEUx7fBN3
 kauKPjsn4P00+LcrQzEV1qV5TAYdg92g4d2/F58L7jSXd+3rgoEKwlSXH7h+ebJusEFd
 hsWTIzXXu51aJGwst4fzXPFVAwOAz4PjhmwbS8dojQi+MwWF7AouorASQuCa/5P2KbR+
 KppWzAPkpecyDgaJXtEt+YWen735iwhc4LeMGLf4K1Dy+aa0X0AGaXcnA+tJIILgmRen
 huYbdiLcZn+QjlWpSZKO2pLbVuxFQmNB2uqzRe1AknFMHnBxT0lw4h6o6D82Txu8cpBU
 Ji4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114754; x=1738719554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQXFLumUgBbRiy8BtW3KvH3FB2G39x8TUOHn6sQx/Go=;
 b=vMCxlyFfqw+PGNHlva+eoV7+h7/Iee0qqWjNBbxGKQEYh3hleJozdhsBHdPVtiVoC0
 +dCetnAau2yu2txf5ibD8aI+mPnwVD11KMobiSJlguEQTSqn7ySXrjOu7Mk+IAhQLdAh
 kgBxIy8Beo9WW/kdLcfjuvwo/sTiSjNZcj7WWtdE+ZGtVSGPvte071ABKysNuPbH9TKk
 DU4fdWuC4xtBP6QpxmZSgFaoh1HBA1zHYZeDp3QMfkZ01AEgLwH9pBUZ23mPInicZ4mC
 ZqgVg47uxgFl2HWgWM/kCmcQiG3uIvkVmne9VXGwl3UTHrsAP7aY7dKbmLcqSPmNu8tW
 Dvpg==
X-Gm-Message-State: AOJu0YzENSUKj9MIhKHwlJlqfAZcLjIn96K5j0yK1K2Zcz6FuqOKu95b
 lGQfPpdRBye4jQY2VUX+GO3YEEbUe2d4lX3lAt1UO7aLbUtudKSIw3fPLC8C/OmdmbxoXXMpngt
 W
X-Gm-Gg: ASbGncvQMLx9Hpwg6dvVjyoPVztNGxMpGQZ54aEcjpwSNYFKkm5y+phbCvSfPMlP2kS
 u4CqvKIr2h86SeJd4yH/PEre+B92EPAj/F01ukWzNF7CklfEJis04gZ6R3+5at3zLodGpOHaqXM
 +b3a5+v0289uPBhBSKqRZm1DZC+LvwqzUVf9QFvX1oRq+R9GIBK+S5J7wswA9h2s11jVTfcFPYS
 1Mv/BGlE1TyItFciGK7Xe/mlC8Fy6TIFSwvQ3NtvIeC5Y4e2mWc0J/0JX/LIw5/i1VzXYc1B1Kg
 jlm6fmc7KQopLnu2sWmw3ds5B04TRXMUGEEgkQ+A6QEyr7O+Sw==
X-Google-Smtp-Source: AGHT+IEw2hFSwq1VkiJYmyKAUsz4MsToHRcu3D3kFvVGA3ru93gmvzIsPrVnnRSpD6+DFUpYdpzKrA==
X-Received: by 2002:a17:902:f70f:b0:212:996:353a with SMTP id
 d9443c01a7336-21dd7c653acmr23480455ad.12.1738114754551; 
 Tue, 28 Jan 2025 17:39:14 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 23/34] target/arm: Use flags for AH negation in sve_ftmad_*
Date: Tue, 28 Jan 2025 17:38:46 -0800
Message-ID: <20250129013857.135256-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Because the operand is known to be negative, negating the operand
is the same as taking the absolute value.  Defer this to the muladd
operation via flags, so that it happens after NaN detection, which
is correct for FPCR.AH.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a01613f079..c12b2600bd 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5137,16 +5137,21 @@ void HELPER(sve_ftmad_h)(void *vd, void *vn, void *vm,
     intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
     bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float16 *d = vd, *n = vn, *m = vm;
+
     for (i = 0; i < opr_sz; i++) {
         float16 mm = m[i];
         intptr_t xx = x;
+        int flags = 0;
+
         if (float16_is_neg(mm)) {
-            if (!(fpcr_ah && float16_is_any_nan(mm))) {
+            if (fpcr_ah) {
+                flags = float_muladd_negate_product;
+            } else {
                 mm = float16_abs(mm);
             }
             xx += 8;
         }
-        d[i] = float16_muladd(n[i], mm, coeff[xx], 0, s);
+        d[i] = float16_muladd(n[i], mm, coeff[xx], flags, s);
     }
 }
 
@@ -5163,16 +5168,21 @@ void HELPER(sve_ftmad_s)(void *vd, void *vn, void *vm,
     intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
     bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float32 *d = vd, *n = vn, *m = vm;
+
     for (i = 0; i < opr_sz; i++) {
         float32 mm = m[i];
         intptr_t xx = x;
+        int flags = 0;
+
         if (float32_is_neg(mm)) {
-            if (!(fpcr_ah && float32_is_any_nan(mm))) {
+            if (fpcr_ah) {
+                flags = float_muladd_negate_product;
+            } else {
                 mm = float32_abs(mm);
             }
             xx += 8;
         }
-        d[i] = float32_muladd(n[i], mm, coeff[xx], 0, s);
+        d[i] = float32_muladd(n[i], mm, coeff[xx], flags, s);
     }
 }
 
@@ -5193,16 +5203,21 @@ void HELPER(sve_ftmad_d)(void *vd, void *vn, void *vm,
     intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
     bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float64 *d = vd, *n = vn, *m = vm;
+
     for (i = 0; i < opr_sz; i++) {
         float64 mm = m[i];
         intptr_t xx = x;
+        int flags = 0;
+
         if (float64_is_neg(mm)) {
-            if (!(fpcr_ah && float64_is_any_nan(mm))) {
+            if (fpcr_ah) {
+                flags = float_muladd_negate_product;
+            } else {
                 mm = float64_abs(mm);
             }
             xx += 8;
         }
-        d[i] = float64_muladd(n[i], mm, coeff[xx], 0, s);
+        d[i] = float64_muladd(n[i], mm, coeff[xx], flags, s);
     }
 }
 
-- 
2.43.0


