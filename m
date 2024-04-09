Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAE0CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3df-00038b-HE; Tue, 09 Apr 2024 01:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3de-00038D-Pn
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dd-0005FG-1l
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:18 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ecf8ebff50so3128155b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638995; x=1713243795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JofZgc4oYeIfJmBDMO4CGM8MdcaFZQ0RyhmTRyn19x0=;
 b=uO78aQI1M0bbTkv7VY23Ig5pVnQywFJf9kYein/UoY4hmYk/cm7LodRrBqw50b/Cxx
 CdH+F2xtI1HnsckxwolPNxwk3PrbD3F6Y66OgsEciNRKlwOd3eOVyH/zbGQtFUBcOCiR
 /0Nq0upBmVPshW41s/gWdCgPPIISmmMiihnltyh/RiA+FsXJGX0sX1LVGvMQBbGIHbKk
 MhTye/GzKoaZJh6XYYv67zWV2ZUp9fCvWbgIsMyhGhvAU96XfdT/v340kmmVTD3g+j+o
 1AkGK0KgzAel6N9yylgiwIfoDyj0VO1YlCDpXI2vPE1P2mls4ZoXGUs3oGnVeYmfyoPq
 YdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638995; x=1713243795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JofZgc4oYeIfJmBDMO4CGM8MdcaFZQ0RyhmTRyn19x0=;
 b=ortx8wqvY/7JpnU83pnd4lczUQwp0H9zLPbxHnIAu95Ctl+GHYF4SLdKL2Iq4VR8mT
 LVylMZdwiMmrRfU4jFrAgWWf0T0CAFv1IQAB+HVMf7YGt17S+iZM/SFXlbXuhVYILcFF
 FMwHLATKQZs7nKJ5ZJ25qMaiFuB5qr+Oj/KCM4yh5J2zu6o6uXwsF1Di6Y9xCRhB34Ku
 84KL8SEvaUZ+ZdYjYhl9aP4Y+XGbTnrSBmedSeMDQP5gv1fTnnsa3PnGjGAW9goZXcsU
 NBKJgeHe8htPXdmGSfSSqUGgIilQNrQct/MmyDaoiEEB9VYNAu1VyK9d4N/z8MqADtD/
 E3Kg==
X-Gm-Message-State: AOJu0YzyPsK39N5ltIRModqeZE9SfVZow54KYESGDhGTjfgIS3fK5qYh
 mfkWErtoO9x2YvZzDvQq5qYITWlfjHBtQxZjhjd3hqPaeCefAGnep+31lI/DgFGI/+EfYO2D+MJ
 9
X-Google-Smtp-Source: AGHT+IEIV+n52jVODPK7A/2hs5hbAwjvV+996Yj0yAbYmIfxhhevAqW0mDwS8HdOUEQbxyE+U9Qk+A==
X-Received: by 2002:a05:6a00:4fd2:b0:6ed:4b2d:a764 with SMTP id
 le18-20020a056a004fd200b006ed4b2da764mr2489755pfb.11.1712638995469; 
 Mon, 08 Apr 2024 22:03:15 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/28] target/i386: Convert do_xrstor_{fpu, mxcr,
 sse} to X86Access
Date: Mon,  8 Apr 2024 19:02:42 -1000
Message-Id: <20240409050302.1523277-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/i386/tcg/fpu_helper.c | 46 ++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 643e017bef..59f73ad075 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2724,39 +2724,41 @@ void helper_xsaveopt(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
     do_xsave(env, ptr, rfbm, inuse, inuse, GETPC());
 }
 
-static void do_xrstor_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_fpu(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     int i, fpuc, fpus, fptag;
     target_ulong addr;
-    X86Access ac;
 
-    fpuc = cpu_lduw_data_ra(env, ptr + XO(legacy.fcw), ra);
-    fpus = cpu_lduw_data_ra(env, ptr + XO(legacy.fsw), ra);
-    fptag = cpu_lduw_data_ra(env, ptr + XO(legacy.ftw), ra);
+    fpuc = access_ldw(ac, ptr + XO(legacy.fcw));
+    fpus = access_ldw(ac, ptr + XO(legacy.fsw));
+    fptag = access_ldw(ac, ptr + XO(legacy.ftw));
     cpu_set_fpuc(env, fpuc);
     cpu_set_fpus(env, fpus);
+
     fptag ^= 0xff;
     for (i = 0; i < 8; i++) {
         env->fptags[i] = ((fptag >> i) & 1);
     }
 
     addr = ptr + XO(legacy.fpregs);
-    access_prepare(&ac, env, addr, 8 * 16, MMU_DATA_LOAD, GETPC());
 
     for (i = 0; i < 8; i++) {
-        floatx80 tmp = do_fldt(&ac, addr);
+        floatx80 tmp = do_fldt(ac, addr);
         ST(i) = tmp;
         addr += 16;
     }
 }
 
-static void do_xrstor_mxcsr(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_mxcsr(X86Access *ac, target_ulong ptr)
 {
-    cpu_set_mxcsr(env, cpu_ldl_data_ra(env, ptr + XO(legacy.mxcsr), ra));
+    CPUX86State *env = ac->env;
+    cpu_set_mxcsr(env, access_ldl(ac, ptr + XO(legacy.mxcsr)));
 }
 
-static void do_xrstor_sse(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_sse(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     int i, nb_xmm_regs;
     target_ulong addr;
 
@@ -2768,8 +2770,8 @@ static void do_xrstor_sse(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
     addr = ptr + XO(legacy.xmm_regs);
     for (i = 0; i < nb_xmm_regs; i++) {
-        env->xmm_regs[i].ZMM_Q(0) = cpu_ldq_data_ra(env, addr, ra);
-        env->xmm_regs[i].ZMM_Q(1) = cpu_ldq_data_ra(env, addr + 8, ra);
+        env->xmm_regs[i].ZMM_Q(0) = access_ldq(ac, addr);
+        env->xmm_regs[i].ZMM_Q(1) = access_ldq(ac, addr + 8);
         addr += 16;
     }
 }
@@ -2849,20 +2851,24 @@ static void do_xrstor_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
 static void do_fxrstor(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 {
+    X86Access ac;
+
     /* The operand must be 16 byte aligned */
     if (ptr & 0xf) {
         raise_exception_ra(env, EXCP0D_GPF, ra);
     }
 
-    do_xrstor_fpu(env, ptr, ra);
+    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
+                   MMU_DATA_LOAD, ra);
+    do_xrstor_fpu(&ac, ptr);
 
     if (env->cr[4] & CR4_OSFXSR_MASK) {
-        do_xrstor_mxcsr(env, ptr, ra);
+        do_xrstor_mxcsr(&ac, ptr);
         /* Fast FXRSTOR leaves out the XMM registers */
         if (!(env->efer & MSR_EFER_FFXSR)
             || (env->hflags & HF_CPL_MASK)
             || !(env->hflags & HF_LMA_MASK)) {
-            do_xrstor_sse(env, ptr, ra);
+            do_xrstor_sse(&ac, ptr);
         }
     }
 }
@@ -2875,6 +2881,7 @@ void helper_fxrstor(CPUX86State *env, target_ulong ptr)
 static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr_t ra)
 {
     uint64_t xstate_bv, xcomp_bv, reserve0;
+    X86Access ac;
 
     rfbm &= env->xcr0;
 
@@ -2913,9 +2920,12 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
         raise_exception_ra(env, EXCP0D_GPF, ra);
     }
 
+    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
+                   MMU_DATA_LOAD, ra);
+
     if (rfbm & XSTATE_FP_MASK) {
         if (xstate_bv & XSTATE_FP_MASK) {
-            do_xrstor_fpu(env, ptr, ra);
+            do_xrstor_fpu(&ac, ptr);
         } else {
             do_fninit(env);
             memset(env->fpregs, 0, sizeof(env->fpregs));
@@ -2924,9 +2934,9 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     if (rfbm & XSTATE_SSE_MASK) {
         /* Note that the standard form of XRSTOR loads MXCSR from memory
            whether or not the XSTATE_BV bit is set.  */
-        do_xrstor_mxcsr(env, ptr, ra);
+        do_xrstor_mxcsr(&ac, ptr);
         if (xstate_bv & XSTATE_SSE_MASK) {
-            do_xrstor_sse(env, ptr, ra);
+            do_xrstor_sse(&ac, ptr);
         } else {
             do_clear_sse(env);
         }
-- 
2.34.1


