Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C962C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx31-0000vC-P6; Tue, 28 Jan 2025 20:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2y-0000sg-A4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:16 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2w-0003Ya-KD
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:16 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21634338cfdso44093605ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114753; x=1738719553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jiXguVQC6dDvcAbzQwFiYdwMzQqKONGTAhmuc/kbWio=;
 b=t4W4sPQjn91WE6oZuDWcBsitNtDTxpRVRFRT49lZrED7HDd1kaz8+Kb3xENFkJ2xsj
 FaVDcPthgJ6kGFYxC4gtCoRI4rTtLHgTMZTno4oyk53VxI3Wyas5YDDuZ8yQdHlQErMp
 ijzGBVOuAPSVpgUSvwWjDJJJuf963wVIOLr7fpJpqpyd9h7CFRG71z+2/KbH7lmK/cqF
 CC8tC1bSbVPuKKi9jY2GyQVwInVhloEbOQftVvhR0g3tb2hV4Eht+L197DwLWtJtEcH7
 YnxIsU29j0fUYjkpWiuXi7GmA9WOFiK6g0Fk2iWOHAohGBEZjIQDVp/axD32y8AerIuF
 NaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114753; x=1738719553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jiXguVQC6dDvcAbzQwFiYdwMzQqKONGTAhmuc/kbWio=;
 b=Mc0yhecV/uQ2LpmHtRQIipuVO2FbgiThkIV8WRhJVkNAv3m8u8yPEUImhQQRe+WEXM
 DClYdepx3qDHYenvhy+T7HSq1Gha29Q2j1rXVZbs97yXOsSw3+TH6bhgrkVAwWR3K361
 AfSggxHWm456S04181Lxf9EhWh8UVgpqOstNcGVGvECwE/eCYrQ54NMmx2OPVv5CPeeS
 ojrZI/byHJHqYFSpXI89ng7frRDVBLe6BldDx6bCX5L/iQu31qgdC0alXHqVUoVszgq7
 olhBYcGlkwfuGpCRdNtgaBV6/f7vS3UmamiS9ck6kF/RAib9TudHLXqCE2EB1aJvOnMc
 EeDA==
X-Gm-Message-State: AOJu0YyTsVGWoAvIJD53FJO1ygR7kMqgeLexisA4dImiopLLlAK5zsE6
 VciLGqS0xinAHxAAADad24CxCW9bQ0Yg29GUxuvoo3NFP/vgDkbWeG71IlFEnx77EWoQJ2wUHbE
 X
X-Gm-Gg: ASbGncvGAnBrl2lFlge/UCwEWqcndirAaSEW7Vf6WAe9Ugse0s96cyQNpLLA2xkgZ/k
 9BLnaQt7TI6koO+faXqH8UIF3d/XZG/PxWianrSwCD2kVRFt0mkQ4kA5yzVr8nVOAPK3F+qCCe1
 ElfcVpEa9PhxJYLjG/fIk3lRewHUI19VewLqcGNpLPorRqmKanlIUR52JxpMcoz4OON2vlNWW3Y
 6rTLdiqsXst3gNeUhxBFGvvBemcFE0Wx8cmbkz90EXvmmd1gwurl1LDUduC089ke5yoyFdPD/U1
 Ec7tDMqUOKUP2R8eBVoipxRwR5C8xQWUePjvTNpC48bYAnczxw==
X-Google-Smtp-Source: AGHT+IGrMUNjR0mriOdUsayqQ+CMjaE4W8kLh4f4GBQtBT0pNOn5z9TY/WuPuY3e5maxgkp+6qObQw==
X-Received: by 2002:a17:902:eccb:b0:216:48dd:d15c with SMTP id
 d9443c01a7336-21dd7d78dcfmr18805595ad.27.1738114753354; 
 Tue, 28 Jan 2025 17:39:13 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 21/34] target/arm: Use float*_maybe_ah_chs in sve_fcadd_*
Date: Tue, 28 Jan 2025 17:38:44 -0800
Message-ID: <20250129013857.135256-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

The construction of neg_imag and neg_real were done to make it easy
to apply both in parallel with two simple logical operations.  This
changed with FPCR.AH, which is more complex than that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 51 +++++++++++--------------------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 9ed04b1b0a..55bac9536f 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -879,27 +879,20 @@ void HELPER(gvec_fcaddh)(void *vd, void *vn, void *vm,
     float16 *d = vd;
     float16 *n = vn;
     float16 *m = vm;
-    uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = neg_real ^ 1;
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
     bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 15;
-    neg_imag <<= 15;
-
     for (i = 0; i < opr_sz / 2; i += 2) {
         float16 e0 = n[H2(i)];
         float16 e1 = m[H2(i + 1)];
         float16 e2 = n[H2(i + 1)];
         float16 e3 = m[H2(i)];
 
-        /* FPNeg() mustn't flip sign of a NaN if FPCR.AH == 1 */
-        if (!(fpcr_ah && float16_is_any_nan(e1))) {
-            e1 ^= neg_imag;
-        }
-        if (!(fpcr_ah && float16_is_any_nan(e3))) {
-            e3 ^= neg_real;
+        if (rot) {
+            e3 = float16_maybe_ah_chs(e3, fpcr_ah);
+        } else {
+            e1 = float16_maybe_ah_chs(e1, fpcr_ah);
         }
 
         d[H2(i)] = float16_add(e0, e1, fpst);
@@ -915,27 +908,20 @@ void HELPER(gvec_fcadds)(void *vd, void *vn, void *vm,
     float32 *d = vd;
     float32 *n = vn;
     float32 *m = vm;
-    uint32_t neg_real = extract32(desc, SIMD_DATA_SHIFT, 1);
-    uint32_t neg_imag = neg_real ^ 1;
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
     bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 31;
-    neg_imag <<= 31;
-
     for (i = 0; i < opr_sz / 4; i += 2) {
         float32 e0 = n[H4(i)];
         float32 e1 = m[H4(i + 1)];
         float32 e2 = n[H4(i + 1)];
         float32 e3 = m[H4(i)];
 
-        /* FPNeg() mustn't flip sign of a NaN if FPCR.AH == 1 */
-        if (!(fpcr_ah && float32_is_any_nan(e1))) {
-            e1 ^= neg_imag;
-        }
-        if (!(fpcr_ah && float32_is_any_nan(e3))) {
-            e3 ^= neg_real;
+        if (rot) {
+            e3 = float32_maybe_ah_chs(e3, fpcr_ah);
+        } else {
+            e1 = float32_maybe_ah_chs(e1, fpcr_ah);
         }
 
         d[H4(i)] = float32_add(e0, e1, fpst);
@@ -951,27 +937,20 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
     float64 *d = vd;
     float64 *n = vn;
     float64 *m = vm;
-    uint64_t neg_real = extract64(desc, SIMD_DATA_SHIFT, 1);
-    uint64_t neg_imag = neg_real ^ 1;
+    bool rot = extract32(desc, SIMD_DATA_SHIFT, 1);
     bool fpcr_ah = extract64(desc, SIMD_DATA_SHIFT + 1, 1);
     uintptr_t i;
 
-    /* Shift boolean to the sign bit so we can xor to negate.  */
-    neg_real <<= 63;
-    neg_imag <<= 63;
-
     for (i = 0; i < opr_sz / 8; i += 2) {
         float64 e0 = n[i];
         float64 e1 = m[i + 1];
         float64 e2 = n[i + 1];
         float64 e3 = m[i];
 
-        /* FPNeg() mustn't flip sign of a NaN if FPCR.AH == 1 */
-        if (!(fpcr_ah && float64_is_any_nan(e1))) {
-            e1 ^= neg_imag;
-        }
-        if (!(fpcr_ah && float64_is_any_nan(e3))) {
-            e3 ^= neg_real;
+        if (rot) {
+            e3 = float64_maybe_ah_chs(e3, fpcr_ah);
+        } else {
+            e1 = float64_maybe_ah_chs(e1, fpcr_ah);
         }
 
         d[i] = float64_add(e0, e1, fpst);
-- 
2.43.0


