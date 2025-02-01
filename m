Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96781C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYY-000737-Ax; Sat, 01 Feb 2025 11:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYU-0006s7-5Q
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:14 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYR-0001Gd-Tm
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:13 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso30919265e9.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428070; x=1739032870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ayRctYXCTiKB54pe99hiltIMpcbOdgZRWtck3crpBoI=;
 b=hEU85cvkGdZtywsJ7fmfF3Z4YaihkMRT0pTNsHDUZVebjTMLWwtE8RIaLxYMf4c7DA
 s3k1TD3RcyrkKZO2fR6vDbG6e9Rcdn9hGozkiCXiwLrswAIB0xVjaFu8ihYfl+gIXLHM
 sTswObv2EImjJGE9ouB5OU7q7JbWmSjfkJmZKICs7KxaE0GnBiQMJn95p0xQQ32beid0
 EQWz97hnBuAnkZ7RcDxuUtodU+yL8xtlxZSpb9dbm+WGy5GG/ZO3oms/uxEWJoAnTW8p
 FxpH7ZMb6gSMpPwfp3uMMMyhcr0pmIaWxSshXqmDpz4QA1b88wSqrIOdLoScCWFICVF3
 FTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428070; x=1739032870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ayRctYXCTiKB54pe99hiltIMpcbOdgZRWtck3crpBoI=;
 b=Wx72kK24+bOTEKe4wsVFNF0ZFFb+TgntGN7SxSGeLvxMzojjzMiHFV4pb2Mlc3tU0a
 JcKPZ76cQHjepEevVjCpX1gzVz9JuoTd1tBnoYEhRF6CrmuoMNrUCMV/0gDZnpguW8Dc
 Egy8k9MU6K1dV5f+PIST+QshWW0dAeGBF6oZGdu3r1+vMPPQ6Hfr1mhTkzq71AC4fycg
 sg3P29mC3qii23bU+dcpNRjzVtCt2CRoq/u34EaUOxn6hg2EGms/OkHOrNEd4EUX4uDA
 xMiRAtekfZrAnZcqf7LvsRrSrg9jMkiXXEBkg19vI3GHQ7GBn/vQNsD1HGavMh09/rnY
 XqMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU542w+itKcw2qLKkkt4+rH360lJpKcmJvaw9DVGo5LRNc4N6nKSISl1sVd3ptMn4UbG0hMVk/jAzMQ@nongnu.org
X-Gm-Message-State: AOJu0Yx/VqSJcAfgzegZVOk954ZewOunJVR7GaJbmhmcaLB5da5hbw24
 5bGQNkyiSsY55rk0sNwex+EYAPSSnpCUt7VQ1/gK1hoQHfHXR09tOQnekGA/ea6SiyWCPFzI5Y5
 q
X-Gm-Gg: ASbGncsxfzWTMKq52DMbUXet/cGzKTf89Jl2fHbG2r/z8/V+du7xt425wGj01/VwiS1
 +LQYGWn3znI8CtxHVajyZMVaTykMkoEQDBsjL/5qtsxvZO+2wNKeKN3XR11VXySRxpxr2xvZtZz
 a4fgSn0mBTLR3K/yiuf/vHfj4jkkw3YIWaBTnUzxMwSC8w6utCw1547W5RIz2GmcWki0Gj2aC8M
 GbZ7I8x92qtzsDN7gX8mHu86RONg8Ls6D7bh9o0L8cyorbqY+Nxi5xnHtTzpAW2cQ6eZQgSyoMu
 PXE56zer+ZEqcSPA4igs
X-Google-Smtp-Source: AGHT+IHy0NO1sAV4fgF6qWCzDoOOeciAZj8RDXb20AFYxfIU1butNjRPL46xr2cAECvT/WljuLbOPw==
X-Received: by 2002:a05:600c:4fc1:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-438dc40d46amr127434555e9.23.1738428070104; 
 Sat, 01 Feb 2025 08:41:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 43/69] target/arm: Handle FPCR.AH in negation step in SVE
 FMLS (vector)
Date: Sat,  1 Feb 2025 16:39:46 +0000
Message-Id: <20250201164012.1660228-44-peter.maydell@linaro.org>
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

Handle the FPCR.AH "don't negate the sign of a NaN" semantics fro the
SVE FMLS (vector) insns, by providing new helpers for the AH=1 case
which end up passing fpcr_ah = true to the do_fmla_zpzzz_* functions
that do the work.

The float*_muladd functions have a flags argument that can
perform optional negation of various operand.  We don't use
that for "normal" arm fmla, because the muladd flags are not
applied when an input is a NaN.  But since FEAT_AFP does not
negate NaNs, this behaviour is exactly what we need.

The non-AH helpers pass in a zero flags argument and control the
negation via the neg1 and neg3 arguments; the AH helpers always pass
in neg1 and neg3 as zero and control the negation via the flags
argument.  This allows us to avoid conditional branches within the
inner loop.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 21 ++++++++
 target/arm/tcg/sve_helper.c    | 99 +++++++++++++++++++++++++++-------
 target/arm/tcg/translate-sve.c | 18 ++++---
 3 files changed, 114 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index a2e96a498dd..0b1b5887834 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1475,6 +1475,27 @@ DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_7(sve_ah_fmls_zpzzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fmls_zpzzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fmls_zpzzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_7(sve_ah_fnmla_zpzzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fnmla_zpzzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fnmla_zpzzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_7(sve_ah_fnmls_zpzzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fnmls_zpzzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_7(sve_ah_fnmls_zpzzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 770945a2c6a..90d4defc0d5 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4802,7 +4802,7 @@ DO_ZPZ_FP(flogb_d, float64, H1_8, do_float64_logb_as_int)
 
 static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint16_t neg1, uint16_t neg3)
+                            uint16_t neg1, uint16_t neg3, int flags)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4817,7 +4817,7 @@ static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
                 e1 = *(uint16_t *)(vn + H1_2(i)) ^ neg1;
                 e2 = *(uint16_t *)(vm + H1_2(i));
                 e3 = *(uint16_t *)(va + H1_2(i)) ^ neg3;
-                r = float16_muladd(e1, e2, e3, 0, status);
+                r = float16_muladd(e1, e2, e3, flags, status);
                 *(uint16_t *)(vd + H1_2(i)) = r;
             }
         } while (i & 63);
@@ -4827,30 +4827,51 @@ static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000, 0);
 }
 
 void HELPER(sve_fnmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000);
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000, 0);
+}
+
+void HELPER(sve_ah_fmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
+                              void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product);
+}
+
+void HELPER(sve_ah_fnmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product | float_muladd_negate_c);
+}
+
+void HELPER(sve_ah_fnmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_c);
 }
 
 static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint32_t neg1, uint32_t neg3)
+                            uint32_t neg1, uint32_t neg3, int flags)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4865,7 +4886,7 @@ static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
                 e1 = *(uint32_t *)(vn + H1_4(i)) ^ neg1;
                 e2 = *(uint32_t *)(vm + H1_4(i));
                 e3 = *(uint32_t *)(va + H1_4(i)) ^ neg3;
-                r = float32_muladd(e1, e2, e3, 0, status);
+                r = float32_muladd(e1, e2, e3, flags, status);
                 *(uint32_t *)(vd + H1_4(i)) = r;
             }
         } while (i & 63);
@@ -4875,30 +4896,51 @@ static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000, 0);
 }
 
 void HELPER(sve_fnmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000);
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000, 0);
+}
+
+void HELPER(sve_ah_fmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
+                              void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product);
+}
+
+void HELPER(sve_ah_fnmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product | float_muladd_negate_c);
+}
+
+void HELPER(sve_ah_fnmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_c);
 }
 
 static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
-                            uint64_t neg1, uint64_t neg3)
+                            uint64_t neg1, uint64_t neg3, int flags)
 {
     intptr_t i = simd_oprsz(desc);
     uint64_t *g = vg;
@@ -4913,7 +4955,7 @@ static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
                 e1 = *(uint64_t *)(vn + i) ^ neg1;
                 e2 = *(uint64_t *)(vm + i);
                 e3 = *(uint64_t *)(va + i) ^ neg3;
-                r = float64_muladd(e1, e2, e3, 0, status);
+                r = float64_muladd(e1, e2, e3, flags, status);
                 *(uint64_t *)(vd + i) = r;
             }
         } while (i & 63);
@@ -4923,25 +4965,46 @@ static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
 void HELPER(sve_fmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0, 0);
 }
 
 void HELPER(sve_fmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                               void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0, 0);
 }
 
 void HELPER(sve_fnmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN, 0);
 }
 
 void HELPER(sve_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
                                void *vg, float_status *status, uint32_t desc)
 {
-    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN);
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN, 0);
+}
+
+void HELPER(sve_ah_fmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
+                              void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product);
+}
+
+void HELPER(sve_ah_fnmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_product | float_muladd_negate_c);
+}
+
+void HELPER(sve_ah_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0,
+                    float_muladd_negate_c);
 }
 
 /* Two operand floating-point comparison controlled by a predicate.
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e81e996c56e..17016854d87 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3927,19 +3927,25 @@ TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
            a->rd, a->rn, a->rm, a->pg, a->rot | (s->fpcr_ah << 1),
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
-#define DO_FMLA(NAME, name) \
+#define DO_FMLA(NAME, name, ah_name)                                    \
     static gen_helper_gvec_5_ptr * const name##_fns[4] = {              \
         NULL, gen_helper_sve_##name##_h,                                \
         gen_helper_sve_##name##_s, gen_helper_sve_##name##_d            \
     };                                                                  \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_zzzzp, name##_fns[a->esz], \
+    static gen_helper_gvec_5_ptr * const name##_ah_fns[4] = {           \
+        NULL, gen_helper_sve_##ah_name##_h,                             \
+        gen_helper_sve_##ah_name##_s, gen_helper_sve_##ah_name##_d      \
+    };                                                                  \
+    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_zzzzp,                     \
+               s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz], \
                a->rd, a->rn, a->rm, a->ra, a->pg, 0,                    \
                a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
-DO_FMLA(FMLA_zpzzz, fmla_zpzzz)
-DO_FMLA(FMLS_zpzzz, fmls_zpzzz)
-DO_FMLA(FNMLA_zpzzz, fnmla_zpzzz)
-DO_FMLA(FNMLS_zpzzz, fnmls_zpzzz)
+/* We don't need an ah_fmla_zpzzz because fmla doesn't negate anything */
+DO_FMLA(FMLA_zpzzz, fmla_zpzzz, fmla_zpzzz)
+DO_FMLA(FMLS_zpzzz, fmls_zpzzz, ah_fmls_zpzzz)
+DO_FMLA(FNMLA_zpzzz, fnmla_zpzzz, ah_fnmla_zpzzz)
+DO_FMLA(FNMLS_zpzzz, fnmls_zpzzz, ah_fnmls_zpzzz)
 
 #undef DO_FMLA
 
-- 
2.34.1


