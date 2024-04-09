Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3173DC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3e0-0003Fo-Bq; Tue, 09 Apr 2024 01:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dz-0003FP-D3
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:39 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dx-0005O7-FL
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:39 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ed20fb620fso1748011b3a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639016; x=1713243816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4uWY1NxVcrV95bV5MVGH7iWV55UiyAePqOvtwTyZGwY=;
 b=bmHw5UapAfnfdkg6Vb8NHbpHvm75YWcYqCiDKa2fPrj57mcXYDEqysyPLtrBcBNHgS
 p9SQw5Nv5g4Kr3ZBXe1J+gotSOtzJi72IIGX+w2jEOSJo9xWUNNJBMJjId7BWw6c79Ze
 L1MMHv0XZFxx73tLY3W6MwxuKpa0r2TkD8DHgzPthlC0VcLt7CBxLT19dtu8qw5y9wFS
 6LDJ5M2UrSlXGLcBSaPz8sdHsUcR+MW26Y8VpzIUxpeuKJMw9TiZ0XoF0XDrmR9CIvFq
 z2yWVLzoO341hWnPsh59qt3Ps0hx01pgQR4nG41+QTFDMFjpbqTZzo8zQ91b00WtOfBi
 Q25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639016; x=1713243816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4uWY1NxVcrV95bV5MVGH7iWV55UiyAePqOvtwTyZGwY=;
 b=kne85MlQJGA2Pyd1ypOojhPidNPIyYGTcCMbpL5v1PB1CL9H4cwn59WfixAL1fpnEj
 9I/ZZnQT6h52ZNAMpWAckpqsauQHv8sCRsAIsbAsz2A/7RK4wFqMKAm1SPWy4xaUYBC2
 6irGVAc5wTHFb3KhcN034V/8OhUye29nan+0oU3BveuKo4UUECpOKqiHpSNn402IG5kI
 jauQfpySVVkzlp6KvzaXIKEufaRSWN5ynWrRUPEf7K0mxXJ1b9kby0F+ZgEoq3ucbW68
 cO94rvM9TqEtJLoYCneY+4aa9a7C2LQQAaZ6T3qdCHy9r1unKoLLdkcdgm+c6nnE6jN0
 BVdA==
X-Gm-Message-State: AOJu0Yxug0nQdtavZ/2dt/or1K4WNGN1aks4vb04O+SIryo6ZgKilaH1
 rjkLdWsY5MpNI4Mwl/ZiBhjbgtmKV1dyq/2TotaFjGM1Pm5LZFiiflTFE+ZHfECatl8DoXQmgbp
 T
X-Google-Smtp-Source: AGHT+IEtRvNJPm3vyyUvCk6Qf3s74yNYJmcA9Nd+vh1Ec8YUIe3wI4/YA9C88uvsT4hVzvGPbzGAUA==
X-Received: by 2002:a05:6a00:1888:b0:6ea:baf6:5720 with SMTP id
 x8-20020a056a00188800b006eabaf65720mr11160918pfh.3.1712639016224; 
 Mon, 08 Apr 2024 22:03:36 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 25/28] target/i386: Convert do_xrstor to X86Access
Date: Mon,  8 Apr 2024 19:02:59 -1000
Message-Id: <20240409050302.1523277-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 106 +++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 42 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index d4dd09dc95..909da05f91 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2902,51 +2902,38 @@ void helper_fxrstor(CPUX86State *env, target_ulong ptr)
     do_fxrstor(&ac, ptr);
 }
 
-static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr_t ra)
+static bool valid_xrstor_header(X86Access *ac, uint64_t *pxsbv,
+                                target_ulong ptr)
 {
     uint64_t xstate_bv, xcomp_bv, reserve0;
-    X86Access ac;
-    unsigned size, size_ext;
 
-    rfbm &= env->xcr0;
+    xstate_bv = access_ldq(ac, ptr + XO(header.xstate_bv));
+    xcomp_bv = access_ldq(ac, ptr + XO(header.xcomp_bv));
+    reserve0 = access_ldq(ac, ptr + XO(header.reserve0));
+    *pxsbv = xstate_bv;
 
-    size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
-    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, ra);
-
-    xstate_bv = access_ldq(&ac, ptr + XO(header.xstate_bv));
-
-    if ((int64_t)xstate_bv < 0) {
-        /* FIXME: Compact form.  */
-        raise_exception_ra(env, EXCP0D_GPF, ra);
+    /*
+     * XCOMP_BV bit 63 indicates compact form, which we do not support,
+     * and thus must raise #GP.  That leaves us in standard form.
+     * In standard form, bytes 23:8 must be zero -- which is both
+     * XCOMP_BV and the following 64-bit field.
+     */
+    if (xcomp_bv || reserve0) {
+        return false;
     }
 
-    /* Standard form.  */
-
     /* The XSTATE_BV field must not set bits not present in XCR0.  */
-    if (xstate_bv & ~env->xcr0) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
+    return (xstate_bv & ~ac->env->xcr0) == 0;
+}
 
-    /* The XCOMP_BV field must be zero.  Note that, as of the April 2016
-       revision, the description of the XSAVE Header (Vol 1, Sec 13.4.2)
-       describes only XCOMP_BV, but the description of the standard form
-       of XRSTOR (Vol 1, Sec 13.8.1) checks bytes 23:8 for zero, which
-       includes the next 64-bit field.  */
-    xcomp_bv = access_ldq(&ac, ptr + XO(header.xcomp_bv));
-    reserve0 = access_ldq(&ac, ptr + XO(header.reserve0));
-    if (xcomp_bv || reserve0) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
-
-    size_ext = xsave_area_size(rfbm & xstate_bv, false);
-    if (size < size_ext) {
-        /* TODO: See if existing page probe has covered extra size. */
-        access_prepare(&ac, env, ptr, size_ext, MMU_DATA_LOAD, ra);
-    }
+static void do_xrstor(X86Access *ac, target_ulong ptr,
+                      uint64_t rfbm, uint64_t xstate_bv)
+{
+    CPUX86State *env = ac->env;
 
     if (rfbm & XSTATE_FP_MASK) {
         if (xstate_bv & XSTATE_FP_MASK) {
-            do_xrstor_fpu(&ac, ptr);
+            do_xrstor_fpu(ac, ptr);
         } else {
             do_fninit(env);
             memset(env->fpregs, 0, sizeof(env->fpregs));
@@ -2955,23 +2942,23 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     if (rfbm & XSTATE_SSE_MASK) {
         /* Note that the standard form of XRSTOR loads MXCSR from memory
            whether or not the XSTATE_BV bit is set.  */
-        do_xrstor_mxcsr(&ac, ptr);
+        do_xrstor_mxcsr(ac, ptr);
         if (xstate_bv & XSTATE_SSE_MASK) {
-            do_xrstor_sse(&ac, ptr);
+            do_xrstor_sse(ac, ptr);
         } else {
             do_clear_sse(env);
         }
     }
     if (rfbm & XSTATE_YMM_MASK) {
         if (xstate_bv & XSTATE_YMM_MASK) {
-            do_xrstor_ymmh(&ac, ptr + XO(avx_state));
+            do_xrstor_ymmh(ac, ptr + XO(avx_state));
         } else {
             do_clear_ymmh(env);
         }
     }
     if (rfbm & XSTATE_BNDREGS_MASK) {
         if (xstate_bv & XSTATE_BNDREGS_MASK) {
-            do_xrstor_bndregs(&ac, ptr + XO(bndreg_state));
+            do_xrstor_bndregs(ac, ptr + XO(bndreg_state));
             env->hflags |= HF_MPX_IU_MASK;
         } else {
             memset(env->bnd_regs, 0, sizeof(env->bnd_regs));
@@ -2980,7 +2967,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     }
     if (rfbm & XSTATE_BNDCSR_MASK) {
         if (xstate_bv & XSTATE_BNDCSR_MASK) {
-            do_xrstor_bndcsr(&ac, ptr + XO(bndcsr_state));
+            do_xrstor_bndcsr(ac, ptr + XO(bndcsr_state));
         } else {
             memset(&env->bndcs_regs, 0, sizeof(env->bndcs_regs));
         }
@@ -2989,7 +2976,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     if (rfbm & XSTATE_PKRU_MASK) {
         uint64_t old_pkru = env->pkru;
         if (xstate_bv & XSTATE_PKRU_MASK) {
-            do_xrstor_pkru(&ac, ptr + XO(pkru_state));
+            do_xrstor_pkru(ac, ptr + XO(pkru_state));
         } else {
             env->pkru = 0;
         }
@@ -3005,9 +2992,27 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
 void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
     uintptr_t ra = GETPC();
+    X86Access ac;
+    uint64_t xstate_bv;
+    unsigned size, size_ext;
 
     do_xsave_chk(env, ptr, ra);
-    do_xrstor(env, ptr, rfbm, ra);
+
+    /* Begin with just the minimum size to validate the header. */
+    size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, ra);
+    if (!valid_xrstor_header(&ac, &xstate_bv, ptr)) {
+        raise_exception_ra(env, EXCP0D_GPF, ra);
+    }
+
+    rfbm &= env->xcr0;
+    size_ext = xsave_area_size(rfbm & xstate_bv, false);
+    if (size < size_ext) {
+        /* TODO: See if existing page probe has covered extra size. */
+        access_prepare(&ac, env, ptr, size_ext, MMU_DATA_LOAD, ra);
+    }
+
+    do_xrstor(&ac, ptr, rfbm, xstate_bv);
 }
 
 #if defined(CONFIG_USER_ONLY)
@@ -3065,7 +3070,24 @@ void cpu_x86_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 
 void cpu_x86_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xrstor(env, ptr, rfbm, 0);
+    X86Access ac;
+    uint64_t xstate_bv;
+    unsigned size;
+
+    /*
+     * Since this is only called from user-level signal handling,
+     * we should have done the job correctly there.
+     */
+    assert((rfbm & ~env->xcr0) == 0);
+    size = xsave_area_size(rfbm, false);
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, 0);
+
+    if (!valid_xrstor_header(&ac, &xstate_bv, ptr)) {
+        /* TODO: Report failure to caller. */
+        xstate_bv &= env->xcr0;
+    }
+
+    do_xrstor(&ac, ptr, rfbm, xstate_bv);
 }
 #endif
 
-- 
2.34.1


