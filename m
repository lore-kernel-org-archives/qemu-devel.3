Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968D1CD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dj-00039x-UQ; Tue, 09 Apr 2024 01:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3di-00039W-75
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:22 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dg-0005Gh-BX
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:21 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ecf8ebff50so3128190b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638999; x=1713243799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eNES/6ErEss0F0rb0ZQ2Omi0ZiA4KOev3GgtB2/SY/g=;
 b=tXfcdMOdaZpLq2gep0SOTC0F6qeAm8bLPfoaiESQyo9/dpTBuK9rygzVRij6aXbHC3
 2PsV4vrRsy6/dONL0hMeP6TlXqwPKfVtN5z/lbMiqyp1lGTff5WDjOrKEGB9r8yNdS40
 lenNhx+7l8E9b7l25d/qE+W0Wqb+LtC11ElMSGKvmYP4EGOSxEryojXRYIgvMpcKUQr7
 h0gL2O60bi1jWAM5lXbcs5C5ezGxAW6Q9+iXrWD8bZ5W9eifu14szZk3PhmLPJBAwA7v
 RAcEnvY8er0mI+vOKEUJNdn8j4iAMOfdNAO/HTT3WaeO0hUI/Ib5gZOze/tmVviKFzx6
 qq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638999; x=1713243799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNES/6ErEss0F0rb0ZQ2Omi0ZiA4KOev3GgtB2/SY/g=;
 b=OjY49t7L1d1We6+u2pFACcN7qb+kMNfcDKRvI6NFo4ke6Ww3pYWtAIYsuyeaLglB7g
 nK+XiXuTctXF6ZAAUoJMWyl5hnSmVf+5OGudRnajsXUpOZtxE3B7j+vzQM2NDemaqz+P
 g/7fGIE7xzCVsG9pVZJ62yeodq/2Ude2zzi/Wn0S54oOB5j073ukRyVKW0U8+xSJhsiS
 nvB6qxAuRYKX38c6nOpQG9HUglm+pqlDEBr0OztZrEPUvPDWcBfDFeu6ymGof8t3ipJY
 97duVWCvflEWJ+1i3sKIbKi89Mh3CBU5OzAyIYhTLObvolGCIQf+dYPfh3Ycs8+eBBVG
 /4uw==
X-Gm-Message-State: AOJu0YwHdHeA+sudoEMIUdwwWp0+ooEKbB1C8uxPEqa3kGwUB1ediezl
 4Y/dcBQEQSXTxYt323OY2j/A817y+AieGuuJbPsOi2ey95JPfalfhCAVv+YhymZthzHPPvcixuU
 i
X-Google-Smtp-Source: AGHT+IGJNBtypAw1cqmHGnmzfhwzuOi9O8sZKDf7kPxx+EEgsCW8wm61B877ttd+t3WZmS76SfRQvg==
X-Received: by 2002:a05:6a00:4b13:b0:6e6:fb9a:fb45 with SMTP id
 kq19-20020a056a004b1300b006e6fb9afb45mr2160227pfb.1.1712638999119; 
 Mon, 08 Apr 2024 22:03:19 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/28] target/i386: Convert do_xrstor_* to X86Access
Date: Mon,  8 Apr 2024 19:02:45 -1000
Message-Id: <20240409050302.1523277-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

The body of do_xrstor is now fully converted.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 51 ++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 82a041f4bf..883002dc22 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2799,8 +2799,9 @@ static void do_clear_sse(CPUX86State *env)
     }
 }
 
-static void do_xrstor_ymmh(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_ymmh(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     int i, nb_xmm_regs;
 
     if (env->hflags & HF_CS64_MASK) {
@@ -2810,8 +2811,8 @@ static void do_xrstor_ymmh(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     }
 
     for (i = 0; i < nb_xmm_regs; i++, ptr += 16) {
-        env->xmm_regs[i].ZMM_Q(2) = cpu_ldq_data_ra(env, ptr, ra);
-        env->xmm_regs[i].ZMM_Q(3) = cpu_ldq_data_ra(env, ptr + 8, ra);
+        env->xmm_regs[i].ZMM_Q(2) = access_ldq(ac, ptr);
+        env->xmm_regs[i].ZMM_Q(3) = access_ldq(ac, ptr + 8);
     }
 }
 
@@ -2831,29 +2832,32 @@ static void do_clear_ymmh(CPUX86State *env)
     }
 }
 
-static void do_xrstor_bndregs(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_bndregs(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     target_ulong addr = ptr + offsetof(XSaveBNDREG, bnd_regs);
     int i;
 
     for (i = 0; i < 4; i++, addr += 16) {
-        env->bnd_regs[i].lb = cpu_ldq_data_ra(env, addr, ra);
-        env->bnd_regs[i].ub = cpu_ldq_data_ra(env, addr + 8, ra);
+        env->bnd_regs[i].lb = access_ldq(ac, addr);
+        env->bnd_regs[i].ub = access_ldq(ac, addr + 8);
     }
 }
 
-static void do_xrstor_bndcsr(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_bndcsr(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
+
     /* FIXME: Extend highest implemented bit of linear address.  */
     env->bndcs_regs.cfgu
-        = cpu_ldq_data_ra(env, ptr + offsetof(XSaveBNDCSR, bndcsr.cfgu), ra);
+        = access_ldq(ac, ptr + offsetof(XSaveBNDCSR, bndcsr.cfgu));
     env->bndcs_regs.sts
-        = cpu_ldq_data_ra(env, ptr + offsetof(XSaveBNDCSR, bndcsr.sts), ra);
+        = access_ldq(ac, ptr + offsetof(XSaveBNDCSR, bndcsr.sts));
 }
 
-static void do_xrstor_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_pkru(X86Access *ac, target_ulong ptr)
 {
-    env->pkru = cpu_ldq_data_ra(env, ptr, ra);
+    ac->env->pkru = access_ldq(ac, ptr);
 }
 
 static void do_fxrstor(X86Access *ac, target_ulong ptr)
@@ -2891,6 +2895,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
 {
     uint64_t xstate_bv, xcomp_bv, reserve0;
     X86Access ac;
+    unsigned size, size_ext;
 
     rfbm &= env->xcr0;
 
@@ -2904,7 +2909,10 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
         raise_exception_ra(env, EXCP0D_GPF, ra);
     }
 
-    xstate_bv = cpu_ldq_data_ra(env, ptr + XO(header.xstate_bv), ra);
+    size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, ra);
+
+    xstate_bv = access_ldq(&ac, ptr + XO(header.xstate_bv));
 
     if ((int64_t)xstate_bv < 0) {
         /* FIXME: Compact form.  */
@@ -2923,14 +2931,17 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
        describes only XCOMP_BV, but the description of the standard form
        of XRSTOR (Vol 1, Sec 13.8.1) checks bytes 23:8 for zero, which
        includes the next 64-bit field.  */
-    xcomp_bv = cpu_ldq_data_ra(env, ptr + XO(header.xcomp_bv), ra);
-    reserve0 = cpu_ldq_data_ra(env, ptr + XO(header.reserve0), ra);
+    xcomp_bv = access_ldq(&ac, ptr + XO(header.xcomp_bv));
+    reserve0 = access_ldq(&ac, ptr + XO(header.reserve0));
     if (xcomp_bv || reserve0) {
         raise_exception_ra(env, EXCP0D_GPF, ra);
     }
 
-    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
-                   MMU_DATA_LOAD, ra);
+    size_ext = xsave_area_size(rfbm & xstate_bv, false);
+    if (size < size_ext) {
+        /* TODO: See if existing page probe has covered extra size. */
+        access_prepare(&ac, env, ptr, size_ext, MMU_DATA_LOAD, ra);
+    }
 
     if (rfbm & XSTATE_FP_MASK) {
         if (xstate_bv & XSTATE_FP_MASK) {
@@ -2952,14 +2963,14 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     }
     if (rfbm & XSTATE_YMM_MASK) {
         if (xstate_bv & XSTATE_YMM_MASK) {
-            do_xrstor_ymmh(env, ptr + XO(avx_state), ra);
+            do_xrstor_ymmh(&ac, ptr + XO(avx_state));
         } else {
             do_clear_ymmh(env);
         }
     }
     if (rfbm & XSTATE_BNDREGS_MASK) {
         if (xstate_bv & XSTATE_BNDREGS_MASK) {
-            do_xrstor_bndregs(env, ptr + XO(bndreg_state), ra);
+            do_xrstor_bndregs(&ac, ptr + XO(bndreg_state));
             env->hflags |= HF_MPX_IU_MASK;
         } else {
             memset(env->bnd_regs, 0, sizeof(env->bnd_regs));
@@ -2968,7 +2979,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     }
     if (rfbm & XSTATE_BNDCSR_MASK) {
         if (xstate_bv & XSTATE_BNDCSR_MASK) {
-            do_xrstor_bndcsr(env, ptr + XO(bndcsr_state), ra);
+            do_xrstor_bndcsr(&ac, ptr + XO(bndcsr_state));
         } else {
             memset(&env->bndcs_regs, 0, sizeof(env->bndcs_regs));
         }
@@ -2977,7 +2988,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     if (rfbm & XSTATE_PKRU_MASK) {
         uint64_t old_pkru = env->pkru;
         if (xstate_bv & XSTATE_PKRU_MASK) {
-            do_xrstor_pkru(env, ptr + XO(pkru_state), ra);
+            do_xrstor_pkru(&ac, ptr + XO(pkru_state));
         } else {
             env->pkru = 0;
         }
-- 
2.34.1


