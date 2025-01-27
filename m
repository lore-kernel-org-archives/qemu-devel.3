Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27B7C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYV5-0006d0-7U; Mon, 27 Jan 2025 18:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUs-0006SX-FB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:27 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUq-0005fA-5L
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:26 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so8527885a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020383; x=1738625183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GDxHDUfDEHJ5sXsQfC9s6zGTEGY5YOTfZmfjmgVvKc=;
 b=prK1VNR1Bor4WZCUyYx9DU4xyvR00YL0GnhicrBUeY4R1TCa0sgMP1bw+IesUr/4vx
 KxkmrzOBPCh/XxI1niKFGBgZY7/i03mfaTAKaF/U7xED0mHhC/VGAK+dIerMyjhADH8p
 ciA431Kb+JEYGxqoQw0tD0HWFw3K2TpA7o2YKNLlaFnpWhUx1lXTpfuOOdh7KytqkW60
 4fwl2m/zfEdwvOlnABf66gJ7mQYIwAAfDOYt1tgmfU1S0t/ex+Ia1g+kBfgL3TcDYfm1
 ax2oiSH/3fxHeUGDcuzj1dtVZ8OzjwsSTtJxbyPIVD+/l47i+1wKCqGFDb/TUUwcxgUZ
 bHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020383; x=1738625183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2GDxHDUfDEHJ5sXsQfC9s6zGTEGY5YOTfZmfjmgVvKc=;
 b=toru4VDLWaJ3pYNJ9kxvL5lIH8rsvlp3JxZ4AnEFS8ZFLvpXFc0rVka4XvvTp20oI8
 MsbgpEbBVP+0Em/63VJRZhR57WNI4JsNrkIO77y/4RstaBPhxvD6614PKEd0lO0uWid0
 cxTSvriE9ExGsch/UL64f0SXtQNEj/UYss4/QHHGjo05LZVyVcJPKLhfTdc2yPRSEnhZ
 jT0kFERAdIcjleGt0AJXlCLAHKUHUu4v4bfzrLjwWWCcNfLS9YiipKQneAsbr16qI97r
 qCSRSSUOIqSm8Ya7hInZMfV5nZHlxA23vXacegDFppEFDQjXZwrNEmWCA3j4azFuGGlF
 8eAg==
X-Gm-Message-State: AOJu0Yze3xV5rq5kqL0644X/x6LnfcSEFo0lSi1ECKC3JNk0Dbv+86QS
 GLAzkCKngbCtAuZM3EiXV/CbNcSH0xmGpiB8l6Bp7i42M3X8lJl5a9Uk8z43HdzVh1TftUZpr6K
 b
X-Gm-Gg: ASbGnctfUx2GKaV8wHXNhmY/98ATX8D4aInqKc7tlo/9K5sOIY5y/X/DN5uOML3yY5z
 DIdO9gORmOO7ReoocU7s/z6Ppt/bYaKSOXTRRf/ytqh0ZEicDk/z0xobbXu4aDqEVY/sR60NLxY
 hXJRa0IRUNG6aApDK+6EgOZJYaaO5cxBWSn3DJg0KDFAXh0H+BUGpZ9Kie2A055bcvEnHwjGZiW
 rmlLewqUdU9oJv/mJdmsuxY7Psodxnkl5DrSlLX0RSOk3JsSCTii3jjjeXnw/kwbRM3MUj7WHDl
 NyfA9Uwcd0FMbGDw/Ultp+6VotKETt+ED4DmHjo=
X-Google-Smtp-Source: AGHT+IHKf3uTi6cSuwONfZTM1K59JVIlwX422STFHcUgztz/I5UJHTZPI6jaBk2P4+PsO2N8Dyk/hQ==
X-Received: by 2002:a17:90b:2dc2:b0:2ee:6db1:21d3 with SMTP id
 98e67ed59e1d1-2f782d323a6mr59729663a91.25.1738020382797; 
 Mon, 27 Jan 2025 15:26:22 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 22/22] target/arm: Use flags for AH negation in do_fmla_zpzzz_*
Date: Mon, 27 Jan 2025 15:26:04 -0800
Message-ID: <20250127232604.20386-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

The float*_muladd functions have a flags argument that can
perform optional negation of various operand.  We don't use
that for "normal" arm fmla, because the muladd flags are not
applied when an input is a NaN.  But since FEAT_AFP does not
negate NaNs, this behaviour is exactly what we need.

Since we have separate helper entry points for the various
fmla, fmls, fnmla, fnmls instructions, it's easy to just
pass down the exact values required so that no conditional
branch is required within the inner loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 93 +++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 51 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 6a5bfa0e59..4fdc98cd98 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4814,7 +4814,7 @@ DO_ZPZ_FP(flogb_d, float64, H1_8, do_float64_logb_as_int)
 
 static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint16_t neg1, uint16_t neg3, bool fpcr_ah)
+                            uint16_t neg1, uint16_t neg3, int flags)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4826,16 +4826,10 @@ static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
             if (likely((pg >> (i & 63)) & 1)) {
                 float16 e1, e2, e3, r;
 
-                e1 = *(uint16_t *)(vn + H1_2(i));
+                e1 = *(uint16_t *)(vn + H1_2(i)) ^ neg1;
                 e2 = *(uint16_t *)(vm + H1_2(i));
-                e3 = *(uint16_t *)(va + H1_2(i));
-                if (neg1 && !(fpcr_ah && float16_is_any_nan(e1))) {
-                    e1 ^= neg1;
-                }
-                if (neg3 && !(fpcr_ah && float16_is_any_nan(e3))) {
-                    e3 ^= neg3;
-                }
-                r = float16_muladd(e1, e2, e3, 0, status);
+                e3 = *(uint16_t *)(va + H1_2(i)) ^ neg3;
+                r = float16_muladd(e1, e2, e3, flags, status);
                 *(uint16_t *)(vd + H1_2(i)) = r;
             }
         } while (i & 63);
@@ -4845,48 +4839,51 @@ static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0, false);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0, false);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000, false);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000, 0);
 }
 
 void HELPER(sve_fnmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000, false);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000, 0);
 }
 
 void HELPER(sve_ah_fmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0, true);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product);
 }
 
 void HELPER(sve_ah_fnmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000, true);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product | float_muladd_negate_c);
 }
 
 void HELPER(sve_ah_fnmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000, true);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_c);
 }
 
 static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint32_t neg1, uint32_t neg3, bool fpcr_ah)
+                            uint32_t neg1, uint32_t neg3, int flags)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4898,16 +4895,10 @@ static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
             if (likely((pg >> (i & 63)) & 1)) {
                 float32 e1, e2, e3, r;
 
-                e1 = *(uint32_t *)(vn + H1_4(i));
+                e1 = *(uint32_t *)(vn + H1_4(i)) ^ neg1;
                 e2 = *(uint32_t *)(vm + H1_4(i));
-                e3 = *(uint32_t *)(va + H1_4(i));
-                if (neg1 && !(fpcr_ah && float32_is_any_nan(e1))) {
-                    e1 ^= neg1;
-                }
-                if (neg3 && !(fpcr_ah && float32_is_any_nan(e3))) {
-                    e3 ^= neg3;
-                }
-                r = float32_muladd(e1, e2, e3, 0, status);
+                e3 = *(uint32_t *)(va + H1_4(i)) ^ neg3;
+                r = float32_muladd(e1, e2, e3, flags, status);
                 *(uint32_t *)(vd + H1_4(i)) = r;
             }
         } while (i & 63);
@@ -4917,48 +4908,51 @@ static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0, false);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0, false);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000, false);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000, 0);
 }
 
 void HELPER(sve_fnmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000, false);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000, 0);
 }
 
 void HELPER(sve_ah_fmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0, true);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product);
 }
 
 void HELPER(sve_ah_fnmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000, true);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product | float_muladd_negate_c);
 }
 
 void HELPER(sve_ah_fnmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000, true);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_c);
 }
 
 static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint64_t neg1, uint64_t neg3, bool fpcr_ah)
+                            uint64_t neg1, uint64_t neg3, int flags)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4970,16 +4964,10 @@ static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
             if (likely((pg >> (i & 63)) & 1)) {
                 float64 e1, e2, e3, r;
 
-                e1 = *(uint64_t *)(vn + i);
+                e1 = *(uint64_t *)(vn + i) ^ neg1;
                 e2 = *(uint64_t *)(vm + i);
-                e3 = *(uint64_t *)(va + i);
-                if (neg1 && !(fpcr_ah && float64_is_any_nan(e1))) {
-                    e1 ^= neg1;
-                }
-                if (neg3 && !(fpcr_ah && float64_is_any_nan(e3))) {
-                    e3 ^= neg3;
-                }
-                r = float64_muladd(e1, e2, e3, 0, status);
+                e3 = *(uint64_t *)(va + i) ^ neg3;
+                r = float64_muladd(e1, e2, e3, flags, status);
                 *(uint64_t *)(vd + i) = r;
             }
         } while (i & 63);
@@ -4989,43 +4977,46 @@ static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0, false);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0, false);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN, false);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN, 0);
 }
 
 void HELPER(sve_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN, false);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN, 0);
 }
 
 void HELPER(sve_ah_fmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0, true);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product);
 }
 
 void HELPER(sve_ah_fnmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN, true);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product | float_muladd_negate_c);
 }
 
 void HELPER(sve_ah_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN, true);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_c);
 }
 
 /* Two operand floating-point comparison controlled by a predicate.
-- 
2.43.0


