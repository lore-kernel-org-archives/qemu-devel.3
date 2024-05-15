Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EBAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFi-00040s-2T; Wed, 15 May 2024 11:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFd-0003xn-Bd
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFa-0003Bc-Oe
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42016c8db2aso23233075e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785738; x=1716390538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zyx2EtmnSzQ0QjFq1CHW7l9aXx9O2qNwb9GB2WJR34=;
 b=H0LpIS14Sja7lCSoP6ox5qt+vlMc3cTUk+sRNb8aPwtoiEFXy2vFJ7Fo24S8iXbqec
 7lgCK3w5uvc53U/o1cZCM3kZUMZ1WX1A9OyAdyygoVJoINSQB9+CuYoK37ejwtCEnFnj
 vngTxdp6beuFU9XXBbwSVzJq9js6AY7Fr7z9ijTnoRAiqAmygcsJkpKbthluyRRDDHsp
 3x3V5ujkkyH5P8jHSJPrJ4i1OBWSXpbwaGZvgQCqjXmVKCdn6jjOxxAi+AcGO0A4/NoA
 NbqEEyorFBOIQZBZA10IlvxcE7bbvvbdWvQFn/fWRoOL3UkFl29CSA28VucEuhZQ5tqR
 9XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785738; x=1716390538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zyx2EtmnSzQ0QjFq1CHW7l9aXx9O2qNwb9GB2WJR34=;
 b=jnIszuGvREGQwlwFQCCjblNuFvyDn3zD8YWbYmoenVoDLTH5t6FAkXFkf4GCj8lD8o
 o+CxEUZk1/al6vTjIA4Yx1mGCmOepU7SQA2IKA5lQuL4BfMBpQe9GgKORz3A8nnTT1Kv
 xtDNuXvYDsfuQgFdNIl9r0JdcAYGKEQC8tAOsEgjlRJ1yMKaWwIWtJ+A12uRTJPqsvPr
 9kjQtgjLNvduUBZeBbZ7Kmvz8yFyQTDmDKwYMkb8de1QQW1z8ERmhJz8ktowH2diJR73
 qhe+nW7MItPTcdL35gTTWiM209KPDjaiatsM0qF0hzE4xwGmb3zG+i03eNiZf6kWgxuQ
 b1uw==
X-Gm-Message-State: AOJu0YzrhPkoQT4TNH8bzwA0NHnHN8ZawtiMQawQgqiYNkdE1u2SdcMW
 JSu6B4dbH3Qcc9wBeNAYCXb0E6T6h2ije3NMoGJrbVdAqsSkhPn4N/aq6BrKdDK3DLLcpfKe7Cp
 BxVo=
X-Google-Smtp-Source: AGHT+IGCwPWC2lMYJh5My0Wt7cdOah154LvUTiF2JtB1ybtdOgWp490pQZtGNBpX5A5jJk3N1oTWkQ==
X-Received: by 2002:a05:600c:5605:b0:41c:7ac7:17f5 with SMTP id
 5b1f17b1804b1-41feab42b76mr118210255e9.24.1715785738554; 
 Wed, 15 May 2024 08:08:58 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 24/28] target/i386: Convert do_xsave to X86Access
Date: Wed, 15 May 2024 17:08:33 +0200
Message-Id: <20240515150837.259747-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c     |  2 +-
 target/i386/tcg/fpu_helper.c | 72 +++++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index c2826a707d..2f93342ade 100644
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


