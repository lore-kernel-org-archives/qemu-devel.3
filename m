Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63160C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dz-0003FN-AM; Tue, 09 Apr 2024 01:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dy-0003F0-8L
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dw-0005Nv-IM
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:38 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so4832519b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639015; x=1713243815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WQH+lbdw0Skr3IWU6+iU1d7e+abJeDKYaSWCKRgQQbA=;
 b=Wy7fmNxbYjEouulHNYoG0lertne92TWzsczIaeve0TpNbQXmEHXdsnuTugT3bBWcaH
 ACXJObwI53vpOH6E3Bkrhu4k9NzN7VudMq6dUA9ukdtYnwPUyT7dnOlh0uMKHx3GFKe9
 o0uGe/Jnrs06TsKMItR8Re+wgbk84UU6adIDIT7ig5dhaq5Dj5fgihUFrVgNMIJyHkXs
 rUbc/7jL6hUXKyVAL23orBXe1xhxIlzWANHKV+SCe2bDSAtLAV+xQe9n89FtxX67du2P
 IyQ/wqJ/BjiWu320vHzdKTxW9PQWj50fDhlaKz+coX/dXKy3/DbG/EeJLVyXljaQI6cm
 wD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639015; x=1713243815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQH+lbdw0Skr3IWU6+iU1d7e+abJeDKYaSWCKRgQQbA=;
 b=bGulfWPGaCQxyhVmPv9eHj8psAOULfmoJH9wS34/67ih0n5Um9/+Zh25pSAN3IqUNP
 PmfKqTPNvn+yasmZNei2IIC4gJSh2H8OotjmFfbMILgJMH1t22QB6MlTGLJ76MOIgh0q
 TeZcDd+dX++hQ7CmOOFuoTum0zoKQr+3WXPvp2+SR1Ujiv3enTZraVzgDKs6cQC04zbr
 p1FhiUOhi6hbsjQIAP0sjDxegjV/OeYujmGknR7dHoidXPVcte2I1EyWNySTXk0me8gY
 cpzY5FvETg+TOpXwepk9o8rUfE9lhWIIu3sVm6gKIaj4xaszSxlAzTEhRVNy7m8sCuGS
 tRvg==
X-Gm-Message-State: AOJu0YzzwzrQrqJ+NhpFC1i37OM0pYv9OYynMPzU+FAcQwUmaY7jGGn0
 ZnyDzW09inQkvp69Q83g5PAU9kEA7SsmyLtXak8n8S7Eb4+FRN1DCaP7JPK9dK4Tbn42T6jKHyr
 h
X-Google-Smtp-Source: AGHT+IFLNl9WcABZm52Q0j78Y4Q6hNHeKo5mpZEdmx6i7cLvQFMFS2LzKaAVxYfghtxkm7OLDzq2ow==
X-Received: by 2002:a05:6a20:3241:b0:1a7:807:ca2 with SMTP id
 hm1-20020a056a20324100b001a708070ca2mr11029045pzc.29.1712639015114; 
 Mon, 08 Apr 2024 22:03:35 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 24/28] target/i386: Convert do_xsave to X86Access
Date: Mon,  8 Apr 2024 19:02:58 -1000
Message-Id: <20240409050302.1523277-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 linux-user/i386/signal.c     |  2 +-
 target/i386/tcg/fpu_helper.c | 72 +++++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index fd09c973d4..ba17d27219 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -328,7 +328,7 @@ static void xsave_sigcontext(CPUX86State *env,
 
     /* Zero the header, XSAVE *adds* features to an existing save state.  */
     memset(fxstate + 1, 0, sizeof(X86XSaveHeader));
-    cpu_x86_xsave(env, xstate_addr, -1);
+    cpu_x86_xsave(env, xstate_addr, env->xcr0);
 
     __put_user(TARGET_FP_XSTATE_MAGIC1, &sw->magic1);
     __put_user(extended_size, &sw->extended_size);
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index dbc1e5d8dd..d4dd09dc95 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2667,47 +2667,38 @@ static uint64_t get_xinuse(CPUX86State *env)
     return inuse;
 }
 
-static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
-                     uint64_t inuse, uint64_t opt, uintptr_t ra)
+static void do_xsave_access(X86Access *ac, target_ulong ptr, uint64_t rfbm,
+                            uint64_t inuse, uint64_t opt)
 {
     uint64_t old_bv, new_bv;
-    X86Access ac;
-    unsigned size;
-
-    /* Never save anything not enabled by XCR0.  */
-    rfbm &= env->xcr0;
-    opt &= rfbm;
-
-    size = xsave_area_size(opt, false);
-    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, ra);
 
     if (opt & XSTATE_FP_MASK) {
-        do_xsave_fpu(&ac, ptr);
+        do_xsave_fpu(ac, ptr);
     }
     if (rfbm & XSTATE_SSE_MASK) {
         /* Note that saving MXCSR is not suppressed by XSAVEOPT.  */
-        do_xsave_mxcsr(&ac, ptr);
+        do_xsave_mxcsr(ac, ptr);
     }
     if (opt & XSTATE_SSE_MASK) {
-        do_xsave_sse(&ac, ptr);
+        do_xsave_sse(ac, ptr);
     }
     if (opt & XSTATE_YMM_MASK) {
-        do_xsave_ymmh(&ac, ptr + XO(avx_state));
+        do_xsave_ymmh(ac, ptr + XO(avx_state));
     }
     if (opt & XSTATE_BNDREGS_MASK) {
-        do_xsave_bndregs(&ac, ptr + XO(bndreg_state));
+        do_xsave_bndregs(ac, ptr + XO(bndreg_state));
     }
     if (opt & XSTATE_BNDCSR_MASK) {
-        do_xsave_bndcsr(&ac, ptr + XO(bndcsr_state));
+        do_xsave_bndcsr(ac, ptr + XO(bndcsr_state));
     }
     if (opt & XSTATE_PKRU_MASK) {
-        do_xsave_pkru(&ac, ptr + XO(pkru_state));
+        do_xsave_pkru(ac, ptr + XO(pkru_state));
     }
 
     /* Update the XSTATE_BV field.  */
-    old_bv = access_ldq(&ac, ptr + XO(header.xstate_bv));
+    old_bv = access_ldq(ac, ptr + XO(header.xstate_bv));
     new_bv = (old_bv & ~rfbm) | (inuse & rfbm);
-    access_stq(&ac, ptr + XO(header.xstate_bv), new_bv);
+    access_stq(ac, ptr + XO(header.xstate_bv), new_bv);
 }
 
 static void do_xsave_chk(CPUX86State *env, target_ulong ptr, uintptr_t ra)
@@ -2723,22 +2714,32 @@ static void do_xsave_chk(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     }
 }
 
-void helper_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
+static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
+                     uint64_t inuse, uint64_t opt, uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
+    X86Access ac;
+    unsigned size;
 
     do_xsave_chk(env, ptr, ra);
-    do_xsave(env, ptr, rfbm, get_xinuse(env), -1, ra);
+
+    /* Never save anything not enabled by XCR0.  */
+    rfbm &= env->xcr0;
+    opt &= rfbm;
+    size = xsave_area_size(opt, false);
+
+    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, ra);
+    do_xsave_access(&ac, ptr, rfbm, inuse, opt);
+}
+
+void helper_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
+{
+    do_xsave(env, ptr, rfbm, get_xinuse(env), rfbm, GETPC());
 }
 
 void helper_xsaveopt(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    uintptr_t ra = GETPC();
-    uint64_t inuse;
-
-    do_xsave_chk(env, ptr, ra);
-    inuse = get_xinuse(env);
-    do_xsave(env, ptr, rfbm, inuse, inuse, ra);
+    uint64_t inuse = get_xinuse(env);
+    do_xsave(env, ptr, rfbm, inuse, inuse, GETPC());
 }
 
 static void do_xrstor_fpu(X86Access *ac, target_ulong ptr)
@@ -3048,7 +3049,18 @@ void cpu_x86_fxrstor(CPUX86State *env, target_ulong ptr)
 
 void cpu_x86_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xsave(env, ptr, rfbm, get_xinuse(env), -1, 0);
+    X86Access ac;
+    unsigned size;
+
+    /*
+     * Since this is only called from user-level signal handling,
+     * we should have done the job correctly there.
+     */
+    assert((rfbm & ~env->xcr0) == 0);
+    size = xsave_area_size(rfbm, false);
+
+    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, 0);
+    do_xsave_access(&ac, ptr, rfbm, get_xinuse(env), rfbm);
 }
 
 void cpu_x86_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
-- 
2.34.1


