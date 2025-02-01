Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F93C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYa-00075n-A8; Sat, 01 Feb 2025 11:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYX-0006xi-3e
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:17 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYV-0001Hk-EZ
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:16 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so35180435e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428074; x=1739032874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gc/WKGJaQOfEqTZHfevAkr0JFxIIMAK6obndN8mIWus=;
 b=agY4vQMe1AxsGel79PTMxKaWsTiGRMf7YYLw7E0czqlYO/N2RhpGcWD7HCyt6Czhc+
 qx3P4hP5+sQHonY8BSHeIr//FF9TP9v3wkc4rUOsX5Y//Gvlt4pq9ybp4Qz5x1Xg8nks
 4CkgGwGPWpjdC/pXSNzeyv4MrtZfglXi9wxxNhwrZwrn0tIM9ixoHHzTYUVp0RAD/V03
 SQUriMDFlVN14s77KMi7qLnQUcTxt4bq2ACNllTqMOpvsgFfaE5Ex+oIuodN//mvM8wq
 1GcpZGnUx8/Vg0yu1VGVm1Gij0Fp2RA5vwmxCcsAKrgRDIZF6haf/Q8QaTZrgve5W0Em
 JTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428074; x=1739032874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gc/WKGJaQOfEqTZHfevAkr0JFxIIMAK6obndN8mIWus=;
 b=PYn3mugh2de5J5gy7iKECB6VWwCyibMAa/XzDUI9qcRUjVMAZOjvZ0kS9EVch7fjod
 LjvVnzNKYCV2K+lA7CdqEPmoL2Zw5ZLbcg4qi5XXC+9TjOUJcnwQH4qOhejKPetRwL19
 3AviqhXJQi8YqfnXkfRAJR1EYcnf2ZVdpTfN+84VnYCvMI/sT3ciPc8Z6q9c2kAYtwTm
 7YAHi4fB8EdQf1t9AU0iZ+6zQGwrI+7OXbF4rJG/SjgZD7drwrLcX3P5mn/yXXc4TGE6
 AjvW2zzyIxRSvc81p4GtBhxz7uNPifuLBcDGUXIzw5DTUiUeyrPrLfMtytiIIDz9ZsEv
 Yw5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8Xb+m3zp4LskZPtBf2ymsNFtZ4qx+0NV9KqXroD5pQHwHuoYYs0Ky/9aBMhQVH2jLIyjR4Rs4uY8o@nongnu.org
X-Gm-Message-State: AOJu0YzG+F2YLPgRGbt3YRD77OZPdGFRtYeyboZbXxiwMqwnG4+4yNr4
 m+yo8ZHTDu2e4PWhwRzC9w0XlWVJLfxfJeh+aHJ1jhwshSMWBUjUp3Y5sVIpK6g=
X-Gm-Gg: ASbGncuP+ruzjhUiromR5PvDQv7i2WtOOauy0Ajm9scZ0V43O0NJ3YFxcJa1ajK+5/s
 VUijwkgVLooxqxILdvO6K27zvxOsYKbJgWeSl0tF+HucakcuDYK9MCKP4YKup8waDOAEQWoDKlz
 +ngJmuymHcOrxuCz60fVdNcFsYXls7lpeyEM/SHNV2CE4k4q0d03pqfPwX/kwE3/sGA9iouulQl
 hONb3MTkncHMgNha54yMwztMGGpu9MMM1XVuskNQOt48Xu9VRN5f4xukxOWLPKUm+lLT8rcb5qo
 mqv8V2mEBChqfwV4Bdeb
X-Google-Smtp-Source: AGHT+IFX6qFmwmySjo/08ZXxwuX+bTHtrEX56AHFEFfM2KBKOsX4NpCnmEP/oAgpsRp9T1vH3MnzEw==
X-Received: by 2002:a05:600c:4692:b0:434:fec5:4ed1 with SMTP id
 5b1f17b1804b1-438dc4223a3mr141818195e9.26.1738428073967; 
 Sat, 01 Feb 2025 08:41:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 45/69] target/arm: Handle FPCR.AH in SVE FTMAD
Date: Sat,  1 Feb 2025 16:39:48 +0000
Message-Id: <20250201164012.1660228-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The negation step in the SVE FTMAD insn mustn't negate a NaN when
FPCR.AH is set.  Pass FPCR.AH to the helper via the SIMD data field,
so we can select the correct behaviour.

Because the operand is known to be negative, negating the operand
is the same as taking the absolute value.  Defer this to the muladd
operation via flags, so that it happens after NaN detection, which
is correct for FPCR.AH.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Squsahed in RTH's patch to use muladd flags
---
 target/arm/tcg/sve_helper.c    | 42 ++++++++++++++++++++++++++--------
 target/arm/tcg/translate-sve.c |  3 ++-
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index bf88bde8a31..c12b2600bd7 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5134,16 +5134,24 @@ void HELPER(sve_ftmad_h)(void *vd, void *vn, void *vm,
         0x3c00, 0xb800, 0x293a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
     };
     intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float16);
-    intptr_t x = simd_data(desc);
+    intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float16 *d = vd, *n = vn, *m = vm;
+
     for (i = 0; i < opr_sz; i++) {
         float16 mm = m[i];
         intptr_t xx = x;
+        int flags = 0;
+
         if (float16_is_neg(mm)) {
-            mm = float16_abs(mm);
+            if (fpcr_ah) {
+                flags = float_muladd_negate_product;
+            } else {
+                mm = float16_abs(mm);
+            }
             xx += 8;
         }
-        d[i] = float16_muladd(n[i], mm, coeff[xx], 0, s);
+        d[i] = float16_muladd(n[i], mm, coeff[xx], flags, s);
     }
 }
 
@@ -5157,16 +5165,24 @@ void HELPER(sve_ftmad_s)(void *vd, void *vn, void *vm,
         0x37cd37cc, 0x00000000, 0x00000000, 0x00000000,
     };
     intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float32);
-    intptr_t x = simd_data(desc);
+    intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float32 *d = vd, *n = vn, *m = vm;
+
     for (i = 0; i < opr_sz; i++) {
         float32 mm = m[i];
         intptr_t xx = x;
+        int flags = 0;
+
         if (float32_is_neg(mm)) {
-            mm = float32_abs(mm);
+            if (fpcr_ah) {
+                flags = float_muladd_negate_product;
+            } else {
+                mm = float32_abs(mm);
+            }
             xx += 8;
         }
-        d[i] = float32_muladd(n[i], mm, coeff[xx], 0, s);
+        d[i] = float32_muladd(n[i], mm, coeff[xx], flags, s);
     }
 }
 
@@ -5184,16 +5200,24 @@ void HELPER(sve_ftmad_d)(void *vd, void *vn, void *vm,
         0x3e21ee96d2641b13ull, 0xbda8f76380fbb401ull,
     };
     intptr_t i, opr_sz = simd_oprsz(desc) / sizeof(float64);
-    intptr_t x = simd_data(desc);
+    intptr_t x = extract32(desc, SIMD_DATA_SHIFT, 3);
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT + 3, 1);
     float64 *d = vd, *n = vn, *m = vm;
+
     for (i = 0; i < opr_sz; i++) {
         float64 mm = m[i];
         intptr_t xx = x;
+        int flags = 0;
+
         if (float64_is_neg(mm)) {
-            mm = float64_abs(mm);
+            if (fpcr_ah) {
+                flags = float_muladd_negate_product;
+            } else {
+                mm = float64_abs(mm);
+            }
             xx += 8;
         }
-        d[i] = float64_muladd(n[i], mm, coeff[xx], 0, s);
+        d[i] = float64_muladd(n[i], mm, coeff[xx], flags, s);
     }
 }
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2dd4605bb2f..410087c3fbd 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3685,7 +3685,8 @@ static gen_helper_gvec_3_ptr * const ftmad_fns[4] = {
     gen_helper_sve_ftmad_s, gen_helper_sve_ftmad_d,
 };
 TRANS_FEAT_NONSTREAMING(FTMAD, aa64_sve, gen_gvec_fpst_zzz,
-                        ftmad_fns[a->esz], a->rd, a->rn, a->rm, a->imm,
+                        ftmad_fns[a->esz], a->rd, a->rn, a->rm,
+                        a->imm | (s->fpcr_ah << 3),
                         a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 /*
-- 
2.34.1


