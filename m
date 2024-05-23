Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E31C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYA-0007OY-SL; Thu, 23 May 2024 19:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXy-0007J9-BC; Thu, 23 May 2024 19:08:33 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXw-0005hY-7U; Thu, 23 May 2024 19:08:30 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-36ddf683ad7so21767375ab.2; 
 Thu, 23 May 2024 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505706; x=1717110506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSCEzO7J34nTWA53rTvjSjhvpcnEIboLFhAR9zzIBDk=;
 b=emlynGHAIswTjyiUte/yfa45t6mAMWMNJYLln4Wh+uLTKZSAfthDlzBfC9ZR95GmGm
 wc2i0gswUd2EpPNiWmp5CdjAKEH5A2pPJfbXu99SZuuUNhuVu0PHRs+EkS7CvNo8KwJI
 l6yd5YI+EgegQW6WkMlFMbfquZFne7wnWNztVXvW/i0r4bb50n7mw/IDvwwVzngfPfdt
 p7Mux7qHUTcZFkK/2CU4+aPp1Itp0Hfr6SC6uebT+756AdrpBek0pT8caE73TZWewWE6
 jrxbcUemRgKJapNvfUta07SIe0gkbkbh5UNq/stbfQ1CjgDY2p0CURkAo18vru2i9DN1
 8eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505706; x=1717110506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSCEzO7J34nTWA53rTvjSjhvpcnEIboLFhAR9zzIBDk=;
 b=GVgnKKWcQbu3XoLb6Xtt0ca/aRQVvXf29DKdo5I9ae++uxpq3TC3/DWM1uG58j9s3p
 RKD74mU8SGuT+6CnKn8FnY+SyEM8jeYuAgdjT26GV/tKt/8eB0GZoBXGcqvfQ4jEJRXL
 1gySvmVrTO8lPBIuEVgj8/9J9CQZ77qMCWCYpa4jhpdqKqftNHAYLhePWArzOMR10WXc
 3Yn3xXgcfPbZsZ7KYWKdGEp4mbUjQzko++kuUxvkD6HuoSh/5t1+vT1aoOlgTT519EkD
 wgCp5xiUyfRcR1bFPrACOeI1pI1D8IHFDPEAHPaGAM+YetjsumYt0lCkxPT8NGULJtgw
 S8KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpd4hZBmhzyvBWgm09fK4a7XaXyCqKugyYyZmP1AkqrUhm4nmxkQGdYQxpHPZ+oQRdCuU3pVt/O3SodjXnqOutcyE/
X-Gm-Message-State: AOJu0Yy2XCTmM9uaww5opO9SbYCgFunAw6LFDCcrBcuoGaplH3/H5n51
 sqJ+01wb93rPiF7t29I4WkOubqvyNYCb5mOCbWdzcoMN2kinxBQ5BeDOzQ==
X-Google-Smtp-Source: AGHT+IE4qTMMM6uXqF6H2HUbSMBY+POz3kwpoupkUr4tXTB4mdn5FtvvHEjdRF32Y57yceVMLI6W+Q==
X-Received: by 2002:a05:6e02:20c9:b0:36b:3ac1:5853 with SMTP id
 e9e14a558f8ab-3737b34e2aamr7631225ab.27.1716505705575; 
 Thu, 23 May 2024 16:08:25 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 09/72] target/ppc: Merge various fpu helpers
Date: Fri, 24 May 2024 09:06:42 +1000
Message-ID: <20240523230747.45703-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

This patch merges the definitions of the following set of fpu helper methods,
which are similar, using macros :

1. f{add, sub, mul, div}(s)
2. fre(s)
3. frsqrte(s)

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/fpu_helper.c | 221 +++++++++++-----------------------------
 1 file changed, 62 insertions(+), 159 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 4b3dcad5d1..8d0cbe27e7 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -490,54 +490,12 @@ static void float_invalid_op_addsub(CPUPPCState *env, int flags,
     }
 }
 
-/* fadd - fadd. */
-float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
+static inline void addsub_flags_handler(CPUPPCState *env, int flags,
+                                        uintptr_t ra)
 {
-    float64 ret = float64_add(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_addsub(env, flags, 1, GETPC());
-    }
-
-    return ret;
-}
-
-/* fadds - fadds. */
-float64 helper_fadds(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64r32_add(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_addsub(env, flags, 1, GETPC());
-    }
-    return ret;
-}
-
-/* fsub - fsub. */
-float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64_sub(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
     if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_addsub(env, flags, 1, GETPC());
+        float_invalid_op_addsub(env, flags, 1, ra);
     }
-
-    return ret;
-}
-
-/* fsubs - fsubs. */
-float64 helper_fsubs(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64r32_sub(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_addsub(env, flags, 1, GETPC());
-    }
-    return ret;
 }
 
 static void float_invalid_op_mul(CPUPPCState *env, int flags,
@@ -550,29 +508,11 @@ static void float_invalid_op_mul(CPUPPCState *env, int flags,
     }
 }
 
-/* fmul - fmul. */
-float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64_mul(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_mul(env, flags, 1, GETPC());
-    }
-
-    return ret;
-}
-
-/* fmuls - fmuls. */
-float64 helper_fmuls(CPUPPCState *env, float64 arg1, float64 arg2)
+static inline void mul_flags_handler(CPUPPCState *env, int flags, uintptr_t ra)
 {
-    float64 ret = float64r32_mul(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
     if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_mul(env, flags, 1, GETPC());
+        float_invalid_op_mul(env, flags, 1, ra);
     }
-    return ret;
 }
 
 static void float_invalid_op_div(CPUPPCState *env, int flags,
@@ -587,36 +527,14 @@ static void float_invalid_op_div(CPUPPCState *env, int flags,
     }
 }
 
-/* fdiv - fdiv. */
-float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
-{
-    float64 ret = float64_div(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_div(env, flags, 1, GETPC());
-    }
-    if (unlikely(flags & float_flag_divbyzero)) {
-        float_zero_divide_excp(env, GETPC());
-    }
-
-    return ret;
-}
-
-/* fdivs - fdivs. */
-float64 helper_fdivs(CPUPPCState *env, float64 arg1, float64 arg2)
+static inline void div_flags_handler(CPUPPCState *env, int flags, uintptr_t ra)
 {
-    float64 ret = float64r32_div(arg1, arg2, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
     if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_div(env, flags, 1, GETPC());
+        float_invalid_op_div(env, flags, 1, ra);
     }
     if (unlikely(flags & float_flag_divbyzero)) {
-        float_zero_divide_excp(env, GETPC());
+        float_zero_divide_excp(env, ra);
     }
-
-    return ret;
 }
 
 static uint64_t float_invalid_cvt(CPUPPCState *env, int flags,
@@ -812,81 +730,66 @@ float64 helper_##name(CPUPPCState *env, float64 arg)                          \
 FPU_FSQRT(FSQRT, float64_sqrt)
 FPU_FSQRT(FSQRTS, float64r32_sqrt)
 
-/* fre - fre. */
-float64 helper_fre(CPUPPCState *env, float64 arg)
-{
-    /* "Estimate" the reciprocal with actual division.  */
-    float64 ret = float64_div(float64_one, arg, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid_snan)) {
-        float_invalid_op_vxsnan(env, GETPC());
-    }
-    if (unlikely(flags & float_flag_divbyzero)) {
-        float_zero_divide_excp(env, GETPC());
-        /* For FPSCR.ZE == 0, the result is 1/2.  */
-        ret = float64_set_sign(float64_half, float64_is_neg(arg));
-    }
-
-    return ret;
+#define FPU_FRE(name, op)                                                     \
+float64 helper_##name(CPUPPCState *env, float64 arg)                          \
+{                                                                             \
+    /* "Estimate" the reciprocal with actual division.  */                    \
+    float64 ret = op(float64_one, arg, &env->fp_status);                      \
+    int flags = get_float_exception_flags(&env->fp_status);                   \
+                                                                              \
+    if (unlikely(flags & float_flag_invalid_snan)) {                          \
+        float_invalid_op_vxsnan(env, GETPC());                                \
+    }                                                                         \
+    if (unlikely(flags & float_flag_divbyzero)) {                             \
+        float_zero_divide_excp(env, GETPC());                                 \
+        /* For FPSCR.ZE == 0, the result is 1/2.  */                          \
+        ret = float64_set_sign(float64_half, float64_is_neg(arg));            \
+    }                                                                         \
+                                                                              \
+    return ret;                                                               \
 }
 
-/* fres - fres. */
-uint64_t helper_fres(CPUPPCState *env, uint64_t arg)
-{
-    /* "Estimate" the reciprocal with actual division.  */
-    float64 ret = float64r32_div(float64_one, arg, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid_snan)) {
-        float_invalid_op_vxsnan(env, GETPC());
-    }
-    if (unlikely(flags & float_flag_divbyzero)) {
-        float_zero_divide_excp(env, GETPC());
-        /* For FPSCR.ZE == 0, the result is 1/2.  */
-        ret = float64_set_sign(float64_half, float64_is_neg(arg));
-    }
-
-    return ret;
+#define FPU_FRSQRTE(name, op)                                                 \
+float64 helper_##name(CPUPPCState *env, float64 arg)                          \
+{                                                                             \
+    /* "Estimate" the reciprocal with actual division.  */                    \
+    float64 rets = float64_sqrt(arg, &env->fp_status);                        \
+    float64 retd = op(float64_one, rets, &env->fp_status);                    \
+    int flags = get_float_exception_flags(&env->fp_status);                   \
+                                                                              \
+    if (unlikely(flags & float_flag_invalid)) {                               \
+        float_invalid_op_sqrt(env, flags, 1, GETPC());                        \
+    }                                                                         \
+    if (unlikely(flags & float_flag_divbyzero)) {                             \
+        /* Reciprocal of (square root of) zero.  */                           \
+        float_zero_divide_excp(env, GETPC());                                 \
+    }                                                                         \
+                                                                              \
+    return retd;                                                              \
 }
 
-/* frsqrte  - frsqrte. */
-float64 helper_frsqrte(CPUPPCState *env, float64 arg)
-{
-    /* "Estimate" the reciprocal with actual division.  */
-    float64 rets = float64_sqrt(arg, &env->fp_status);
-    float64 retd = float64_div(float64_one, rets, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_sqrt(env, flags, 1, GETPC());
-    }
-    if (unlikely(flags & float_flag_divbyzero)) {
-        /* Reciprocal of (square root of) zero.  */
-        float_zero_divide_excp(env, GETPC());
-    }
-
-    return retd;
+#define FPU_HELPER(name, op, flags_handler)                                   \
+float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)           \
+{                                                                             \
+    float64 ret = op(arg1, arg2, &env->fp_status);                            \
+    int flags = get_float_exception_flags(&env->fp_status);                   \
+    uintptr_t ra = GETPC();                                                   \
+    flags_handler(env, flags, ra);                                            \
+    return ret;                                                               \
 }
 
-/* frsqrtes  - frsqrtes. */
-float64 helper_frsqrtes(CPUPPCState *env, float64 arg)
-{
-    /* "Estimate" the reciprocal with actual division.  */
-    float64 rets = float64_sqrt(arg, &env->fp_status);
-    float64 retd = float64r32_div(float64_one, rets, &env->fp_status);
-    int flags = get_float_exception_flags(&env->fp_status);
-
-    if (unlikely(flags & float_flag_invalid)) {
-        float_invalid_op_sqrt(env, flags, 1, GETPC());
-    }
-    if (unlikely(flags & float_flag_divbyzero)) {
-        /* Reciprocal of (square root of) zero.  */
-        float_zero_divide_excp(env, GETPC());
-    }
-
-    return retd;
-}
+FPU_FRE(fre, float64_div)
+FPU_FRE(fres, float64r32_div)
+FPU_FRSQRTE(frsqrte, float64_div)
+FPU_FRSQRTE(frsqrtes, float64r32_div)
+FPU_HELPER(fadd, float64_add, addsub_flags_handler)
+FPU_HELPER(fadds, float64r32_add, addsub_flags_handler)
+FPU_HELPER(fsub, float64_sub, addsub_flags_handler)
+FPU_HELPER(fsubs, float64r32_sub, addsub_flags_handler)
+FPU_HELPER(fmul, float64_mul, mul_flags_handler)
+FPU_HELPER(fmuls, float64r32_mul, mul_flags_handler)
+FPU_HELPER(fdiv, float64_div, div_flags_handler)
+FPU_HELPER(fdivs, float64r32_div, div_flags_handler)
 
 /* fsel - fsel. */
 uint64_t helper_FSEL(uint64_t a, uint64_t b, uint64_t c)
-- 
2.43.0


