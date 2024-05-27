Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7F1C25B7D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZQ-0007Kw-KU; Sun, 26 May 2024 20:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZM-0007HE-Fe
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:32 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZJ-0003hb-0P
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:31 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6f8d0a00a35so1885284a34.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771022; x=1717375822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dEL/f+WNN/VTjMYU3HO0zXd0qrm2vxSZ2F42AN8L34=;
 b=jgfvDqGjm9AHBYH6Fh1qi8PX6ynqBVlXn9FElDcZKlHnrI/QVcWKPn/Alf6IjkrjJm
 08deR+jlmryh/xRQIIV75R+2G1xaHlS2hPPravi1y6v0PNQj63/PdM+d+32exJriDp6c
 l0WnaXO5bUQpvWmzPqQ/tCghFn1iKEBSpXIPf846gHq7jvBjxKFJRp9A9co2RF6fMt1d
 Jo8ZXxjpzPSctJ43W5ID8/8CaODScCU2NXU9JVCnLr5el1jV0hGHnQDDjdXlwJ1p8l/w
 8Q8/EbwXpjsyin4GTivXykD3IoI6qSIYDuxFjLOtureeGiZk5DQz5x+iOyYuNcrVvDwP
 HJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771022; x=1717375822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dEL/f+WNN/VTjMYU3HO0zXd0qrm2vxSZ2F42AN8L34=;
 b=lSO6iiL3V6K/yf8I+d/7b5xVkJKMhyTlgJ/xpEzLnpewX12tfLDe6v08r0waPaTqiS
 3Bb5Ny1AHDsxVi+Ew5jr/Nzb3pSeLWKId9xDA93nObI3DAAwR+3OUf8Z6zQgXaUjdLQ2
 RWXcs+JjrvXo65/b+OAKXISWuc6NUsEExkqzYNqQWyQ+nIwhUv8pw/4ZkOhAFllCmtNk
 d/19QirkPw9IFTGusDLTzYMRCc5LuN25yLKeD6atBQJRPkYDpPB4XKS6QIpBkD27DNWD
 JUzi3/64g90LltMi/XSLHTOTgEgnTBPc1zBctTmaXZjgBWwsVPtioV1luQrqv+2+KoNF
 +ErQ==
X-Gm-Message-State: AOJu0Ywy1lvWYrcgdD0vOhdp1idGgaEgfOUro6icu7y3T81p+tiC9JHQ
 vvrJ2A/T1+Fl1+rNfG0xTvjC5QJ2UIYEvixEzFoKXvw+3HQc3JrrWnQG45Eeiiz/du9G6cFA59b
 /
X-Google-Smtp-Source: AGHT+IHUh4o1CAGPD8lNl4NH9jKcpH/qlnGEhZDnQCR5a8+MrTwEzV2H1cBdbZOSIXzC5splEHMbsA==
X-Received: by 2002:a05:6870:808a:b0:24f:e6a4:9921 with SMTP id
 586e51a60fabf-24fe6a4d0b3mr3162965fac.5.1716771021891; 
 Sun, 26 May 2024 17:50:21 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 24/28] target/i386: Convert do_xsave to X86Access
Date: Sun, 26 May 2024 17:49:57 -0700
Message-Id: <20240527005001.642825-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c     |  2 +-
 target/i386/tcg/fpu_helper.c | 72 +++++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index e716ec8989..ab760db5ea 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -329,7 +329,7 @@ static void xsave_sigcontext(CPUX86State *env,
 
     /* Zero the header, XSAVE *adds* features to an existing save state.  */
     memset(fxstate + 1, 0, sizeof(X86XSaveHeader));
-    cpu_x86_xsave(env, xstate_addr, -1);
+    cpu_x86_xsave(env, xstate_addr, env->xcr0);
 
     __put_user(TARGET_FP_XSTATE_MAGIC1, &sw->magic1);
     __put_user(extended_size, &sw->extended_size);
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index a09d6aaf07..f5748b72b8 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2668,47 +2668,38 @@ static uint64_t get_xinuse(CPUX86State *env)
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
@@ -2724,22 +2715,32 @@ static void do_xsave_chk(CPUX86State *env, target_ulong ptr, uintptr_t ra)
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
@@ -3049,7 +3050,18 @@ void cpu_x86_fxrstor(CPUX86State *env, target_ulong ptr)
 
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


