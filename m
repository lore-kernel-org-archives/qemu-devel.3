Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426C7C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYUz-0006Wi-6B; Mon, 27 Jan 2025 18:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUj-0006My-3z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:19 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUf-0005YJ-4b
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:16 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee51f8c47dso6926210a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020372; x=1738625172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/o3PZF+VYx9BlUZcSvSihlV0semqIWO9oR/VySJrxZU=;
 b=Rzb15ux/7EOLJ3GAR4OQv5DXtEUzx+sKvE0HQsvA/vo8y7OjpdxGAkmWgw2zNN3XGO
 IE7sacTamWvdFFKryOu/X6KXYehsKLvuTEaaTOOAq+ToZjZsrRtCN1cCV1zzE5/Wf6NB
 +j4JA5If9jhRM6OcW/vB4qM/4x1+ta/AsaTeJQfiP+Lo7x3oqitgsIHJwJpZ/WuzEgZk
 OBPDUsIcGPmi1zcCJzDFTvhd8f+4MUdoKVBuK5IwugNVM69dDdFQ9CPBfpc7EdUDWTH9
 2jhbTiSv4+BkBtCdRA5QZWG/yLkA9FR4Wk9bNWgL6Q2TBNxE49J6UhYisUiToRVtY481
 3Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020372; x=1738625172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/o3PZF+VYx9BlUZcSvSihlV0semqIWO9oR/VySJrxZU=;
 b=xLGTg8EMwljLI13IRXB8qjzFFhhf9MILbAXJ/oCccGZXJOIJhYCld2bdEO0O1lS+O2
 tBlni/CEvUvzyf12xm+EEY1JxUeWgPLtwsv+VL+dcUtSL9VRve3Srs21JC1U/vey68y/
 pp99zJJnf93264bNitYA+ECixLM8f2RbkTSw0vctLtI/TmSqUFSL5QB05OIDTy/AwEfw
 b7yFG9KityrhY0e798ZIzK3Ep/8rdmCgp+x9fHUxH+83JNU5HeGSapiBzPm8JrhTDDGt
 OIrh/CF1mluxvFN9H1/RKT3YbeW3bgSeskPQaIehDqlLs1BudYt6mWdCIRj6nmSQguQR
 VHvw==
X-Gm-Message-State: AOJu0Yw9MXPbro0Fr9WAyaucmzlNZMjP9o/SFaL0hcE22IAHk8bXvxHH
 dStJI6Aaj/4eH3jTdDwuflc1UEUNbiPav93Aq91L5UDtG5OcsyjKm7bkVpM9qrLGcq+8AkbqDqc
 U
X-Gm-Gg: ASbGncvDYfjuOlyH/vd64W/cLSpzSEMYqoTYm1datLr3VTArdlV+UtHmeS/jnBxL8HN
 e9sJx98Vciajm/ZuH2I/vDj7e1OJk4PX865ESap/JiOysotwHbRclRtQ+Hn2zf32Fu5ts1WKfMA
 kJt/tzugcBnJ4ojNbPE9nSSS1iHGnsO6DFpNX3NSsAd0t80u9pNks8hT/cMOE66ZubCKDlrXSos
 ku4308usC52IESeFrECzv1Pfw3beo4ioeciJIBH0ZGS7HgjftugQ9G+iLFnnHK3qFWSEgt3eZnE
 FTt2bd56nYigRd/JQCe5lHP6JU3ayFOJYbVIKMA=
X-Google-Smtp-Source: AGHT+IH7TBJjTp6DCa6a22TxYNYi94VAUyT1XNZBPMy8+Iuum2pNOlFPxVRwgEQ6d4L0ds1gYIy8uw==
X-Received: by 2002:a17:90b:17d0:b0:2ee:e518:c1d8 with SMTP id
 98e67ed59e1d1-2f782d972b9mr62185463a91.30.1738020371729; 
 Mon, 27 Jan 2025 15:26:11 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 08/22] target/arm: Remove standard_fp_status
Date: Mon, 27 Jan 2025 15:25:50 -0800
Message-ID: <20250127232604.20386-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Replace with fp_status[FPST_STD].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            |  1 -
 target/arm/cpu.c            |  8 ++++----
 target/arm/tcg/mve_helper.c | 28 ++++++++++++++--------------
 target/arm/tcg/vec_helper.c |  4 ++--
 target/arm/vfp_helper.c     |  4 ++--
 5 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 893a2cdd0a..18afff8509 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -696,7 +696,6 @@ typedef struct CPUArchState {
                 float_status fp_status_f16_a64;
                 float_status ah_fp_status;
                 float_status ah_fp_status_f16;
-                float_status standard_fp_status;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b887edf1d1..26e3465a4b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -546,13 +546,13 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->sau.ctrl = 0;
     }
 
-    set_flush_to_zero(1, &env->vfp.standard_fp_status);
-    set_flush_inputs_to_zero(1, &env->vfp.standard_fp_status);
-    set_default_nan_mode(1, &env->vfp.standard_fp_status);
+    set_flush_to_zero(1, &env->vfp.fp_status[FPST_STD]);
+    set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
+    set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_a64);
-    arm_set_default_fp_behaviours(&env->vfp.standard_fp_status);
+    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a32);
     arm_set_default_fp_behaviours(&env->vfp.fp_status_f16_a64);
     arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 911a53a23a..3763d71e20 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -2815,7 +2815,7 @@ DO_VMAXMINA(vminaw, 4, int32_t, uint32_t, DO_MIN)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2889,7 +2889,7 @@ DO_2OP_FP_ALL(vminnma, minnuma)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(tm & 1)) {                                            \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2927,7 +2927,7 @@ DO_VCADD_FP(vfcadd270s, 4, float32, float32_add, float32_sub)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2965,7 +2965,7 @@ DO_VFMA(vfmss, 4, float32, true)
                 continue;                                               \
             }                                                           \
             fpst0 = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :  \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             fpst1 = fpst0;                                              \
             if (!(mask & 1)) {                                          \
                 scratch_fpst = *fpst0;                                  \
@@ -3050,7 +3050,7 @@ DO_VCMLA(vcmla270s, 4, float32, 3, DO_VCMLAS)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3085,7 +3085,7 @@ DO_2OP_FP_SCALAR_ALL(vfmul_scalar, mul)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3118,7 +3118,7 @@ DO_2OP_FP_ACC_SCALAR(vfmas_scalars, 4, float32, DO_VFMAS_SCALARS)
         TYPE ra = (TYPE)ra_in;                                  \
         float_status *fpst = (ESIZE == 2) ?                     \
             &env->vfp.fp_status[FPST_STD_F16] :                 \
-            &env->vfp.standard_fp_status;                       \
+            &env->vfp.fp_status[FPST_STD];                       \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {      \
             if (mask & 1) {                                     \
                 TYPE v = m[H##ESIZE(e)];                        \
@@ -3169,7 +3169,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3203,7 +3203,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3268,7 +3268,7 @@ DO_VCMP_FP_BOTH(vfcmples, vfcmple_scalars, 4, float32, !DO_GT32)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3302,7 +3302,7 @@ DO_VCVT_FIXED(vcvt_fu, 4, uint32_t, helper_vfp_touls_round_to_zero)
         float_status scratch_fpst;                                      \
         float_status *base_fpst = (ESIZE == 2) ?                        \
             &env->vfp.fp_status[FPST_STD_F16] :                         \
-            &env->vfp.standard_fp_status;                               \
+            &env->vfp.fp_status[FPST_STD];                               \
         uint32_t prev_rmode = get_float_rounding_mode(base_fpst);       \
         set_float_rounding_mode(rmode, base_fpst);                      \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
@@ -3347,7 +3347,7 @@ static void do_vcvt_sh(CPUARMState *env, void *vd, void *vm, int top)
     unsigned e;
     float_status *fpst;
     float_status scratch_fpst;
-    float_status *base_fpst = &env->vfp.standard_fp_status;
+    float_status *base_fpst = &env->vfp.fp_status[FPST_STD];
     bool old_fz = get_flush_to_zero(base_fpst);
     set_flush_to_zero(false, base_fpst);
     for (e = 0; e < 16 / 4; e++, mask >>= 4) {
@@ -3377,7 +3377,7 @@ static void do_vcvt_hs(CPUARMState *env, void *vd, void *vm, int top)
     unsigned e;
     float_status *fpst;
     float_status scratch_fpst;
-    float_status *base_fpst = &env->vfp.standard_fp_status;
+    float_status *base_fpst = &env->vfp.fp_status[FPST_STD];
     bool old_fiz = get_flush_inputs_to_zero(base_fpst);
     set_flush_inputs_to_zero(false, base_fpst);
     for (e = 0; e < 16 / 4; e++, mask >>= 4) {
@@ -3428,7 +3428,7 @@ void HELPER(mve_vcvtt_hs)(CPUARMState *env, void *vd, void *vm)
                 continue;                                               \
             }                                                           \
             fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.standard_fp_status;                           \
+                &env->vfp.fp_status[FPST_STD];                           \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index b369c9f45b..60839ae560 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2177,7 +2177,7 @@ static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
 void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
-    do_fmlal(vd, vn, vm, &env->vfp.standard_fp_status, desc,
+    do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
@@ -2239,7 +2239,7 @@ static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
 void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
-    do_fmlal_idx(vd, vn, vm, &env->vfp.standard_fp_status, desc,
+    do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 28c2b40bd8..93db713a40 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -118,7 +118,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     uint32_t a32_flags = 0, a64_flags = 0;
 
     a32_flags |= get_float_exception_flags(&env->vfp.fp_status_a32);
-    a32_flags |= get_float_exception_flags(&env->vfp.standard_fp_status);
+    a32_flags |= get_float_exception_flags(&env->vfp.fp_status[FPST_STD]);
     /* FZ16 does not generate an input denormal exception.  */
     a32_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a32)
           & ~float_flag_input_denormal_flushed);
@@ -157,7 +157,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status_a64);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a32);
     set_float_exception_flags(0, &env->vfp.fp_status_f16_a64);
-    set_float_exception_flags(0, &env->vfp.standard_fp_status);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
     set_float_exception_flags(0, &env->vfp.ah_fp_status);
     set_float_exception_flags(0, &env->vfp.ah_fp_status_f16);
-- 
2.43.0


