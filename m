Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E55C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZW-0007Oc-9d; Sun, 26 May 2024 20:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZL-0007Fq-B7
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:31 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZA-0003fV-Kv
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso3556813b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771016; x=1717375816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXRJWnawluUaMF/jqhQVfylOquOPm+Y6SErtNaXDicY=;
 b=b4O1nudJtOFX0Zi7e6V9/QJLssi+HOCxowJoIkkZfIvi+VSsY8UsmfuueVmsuayeXC
 jZCnDo4SvvvQZZp3wQD4DEMr8Ejl9SN4JB1ESkVdcFYW4nu3KYANOzHkoEEmQWLRHDVH
 rwhOnTxA0u4X9T8Co+os44hBjtaS3ym/8kZV/NnMMm7mfuUw0NxQn8d9L/7QEq8k/y5r
 7/D4m62J5fWXCmIQFJQInipDxds8hszZABgYxWlHO0534vOJ+gKbcUJqPOYhU7y6N6/7
 w83PGPDqw9kLY1xIEzO12UPWuasLbxUimBYkVev1t45KG4q02GnwVrOVT9qua2Ta5mHl
 Fc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771016; x=1717375816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xXRJWnawluUaMF/jqhQVfylOquOPm+Y6SErtNaXDicY=;
 b=iYOI8L8Mx/SU4gBq43Z0a/5dciUD0lQafj9mhc9UCCMc38zdo2FoObMTWYUd3dd1XS
 e3g9OgGI6EEEp3/fbAZY9KH6jTJ8ymThDlyEi9VUFBNeDC7EDtICYysxBQbp4UAl27xV
 GaImCRpNjzyZWkGuEsJRbBDvuyUynFrGz+w/zJ6WV34U5HBI7HJBuGKq2+r9L+dSf3OA
 YC8BE+23n4vCA7kJP2hkOKQVeunpiipFO0qW+gjzYP1OSAq2k5goEN1L4ZGqbQV2zZy7
 T1N6PvxSZ9692QJ9mYtLI5WbTGdqOoGv3MvzWOvlQuIu94ZuyfmpQj9N2OpvlCYGbyGJ
 E3MA==
X-Gm-Message-State: AOJu0Yw9ogQGI8zcPjk2pjIzPHQGSOdw0Jrd4rJWCibRBSjnbzpQGH6P
 TKgrr/+pk3UQkcweYYWxJw5qLXLMZHn1LrdmpbkB3ne/tgHtZ8dcTflOf+SNbdrYZ4C3nPVx+47
 T
X-Google-Smtp-Source: AGHT+IFlSB1uWWNm6vGyD5Nx/TfmbrkXZaTUY/z/Hgh1WtM4E4YRok4FTNNUuq1QylamrsOPu63asA==
X-Received: by 2002:a05:6a00:2988:b0:6f3:ee23:3c39 with SMTP id
 d2e1a72fcca58-6f8e955aabfmr9721662b3a.7.1716771016140; 
 Sun, 26 May 2024 17:50:16 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 17/28] linux-user/i386: Replace target_fpstate_fxsave with
 X86LegacyXSaveArea
Date: Sun, 26 May 2024 17:49:50 -0700
Message-Id: <20240527005001.642825-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Use the structure definition from target/i386/cpu.h.
The only minor quirk is re-casting the sw_reserved
area to the OS specific struct target_fpx_sw_bytes.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 71 +++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 45 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index f8064691c4..5b1c570bff 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -34,16 +34,6 @@ struct target_fpreg {
     uint16_t exponent;
 };
 
-struct target_fpxreg {
-    uint16_t significand[4];
-    uint16_t exponent;
-    uint16_t padding[3];
-};
-
-struct target_xmmreg {
-    uint32_t element[4];
-};
-
 struct target_fpx_sw_bytes {
     uint32_t magic1;
     uint32_t extended_size;
@@ -53,25 +43,6 @@ struct target_fpx_sw_bytes {
 };
 QEMU_BUILD_BUG_ON(sizeof(struct target_fpx_sw_bytes) != 12*4);
 
-struct target_fpstate_fxsave {
-    /* FXSAVE format */
-    uint16_t cw;
-    uint16_t sw;
-    uint16_t twd;
-    uint16_t fop;
-    uint64_t rip;
-    uint64_t rdp;
-    uint32_t mxcsr;
-    uint32_t mxcsr_mask;
-    uint32_t st_space[32];
-    uint32_t xmm_space[64];
-    uint32_t hw_reserved[12];
-    struct target_fpx_sw_bytes sw_reserved;
-};
-#define TARGET_FXSAVE_SIZE   sizeof(struct target_fpstate_fxsave)
-QEMU_BUILD_BUG_ON(TARGET_FXSAVE_SIZE != 512);
-QEMU_BUILD_BUG_ON(offsetof(struct target_fpstate_fxsave, sw_reserved) != 464);
-
 struct target_fpstate_32 {
     /* Regular FPU environment */
     uint32_t cw;
@@ -84,7 +55,7 @@ struct target_fpstate_32 {
     struct target_fpreg st[8];
     uint16_t  status;
     uint16_t  magic;          /* 0xffff = regular FPU data only */
-    struct target_fpstate_fxsave fxsave;
+    X86LegacyXSaveArea fxsave;
 };
 
 /*
@@ -97,7 +68,7 @@ QEMU_BUILD_BUG_ON(offsetof(struct target_fpstate_32, fxsave) & 15);
 # define target_fpstate target_fpstate_32
 # define TARGET_FPSTATE_FXSAVE_OFFSET offsetof(struct target_fpstate_32, fxsave)
 #else
-# define target_fpstate target_fpstate_fxsave
+# define target_fpstate X86LegacyXSaveArea
 # define TARGET_FPSTATE_FXSAVE_OFFSET 0
 #endif
 
@@ -241,15 +212,17 @@ struct rt_sigframe {
  * Set up a signal frame.
  */
 
-static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxsave,
+static void xsave_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
                              abi_ulong fxsave_addr)
 {
+    struct target_fpx_sw_bytes *sw = (void *)&fxsave->sw_reserved;
+
     if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
         /* fxsave_addr must be 16 byte aligned for fxsave */
         assert(!(fxsave_addr & 0xf));
 
         cpu_x86_fxsave(env, fxsave_addr);
-        __put_user(0, &fxsave->sw_reserved.magic1);
+        __put_user(0, &sw->magic1);
     } else {
         uint32_t xstate_size = xsave_area_size(env->xcr0, false);
 
@@ -267,10 +240,10 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
         /* Zero the header, XSAVE *adds* features to an existing save state.  */
         memset(fxsave + 1, 0, sizeof(X86XSaveHeader));
         cpu_x86_xsave(env, fxsave_addr, -1);
-        __put_user(TARGET_FP_XSTATE_MAGIC1, &fxsave->sw_reserved.magic1);
-        __put_user(extended_size, &fxsave->sw_reserved.extended_size);
-        __put_user(env->xcr0, &fxsave->sw_reserved.xfeatures);
-        __put_user(xstate_size, &fxsave->sw_reserved.xstate_size);
+        __put_user(TARGET_FP_XSTATE_MAGIC1, &sw->magic1);
+        __put_user(extended_size, &sw->extended_size);
+        __put_user(env->xcr0, &sw->xfeatures);
+        __put_user(xstate_size, &sw->xstate_size);
         __put_user(TARGET_FP_XSTATE_MAGIC2,
                    (uint32_t *)((void *)fxsave + xstate_size));
     }
@@ -384,9 +357,9 @@ get_sigframe(struct target_sigaction *ka, CPUX86State *env, size_t fxsave_offset
     }
 
     if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
-        return (esp - (fxsave_offset + TARGET_FXSAVE_SIZE)) & -8ul;
+        return (esp - (fxsave_offset + sizeof(X86LegacyXSaveArea))) & -8ul;
     } else if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
-        return ((esp - TARGET_FXSAVE_SIZE) & -16ul) - fxsave_offset;
+        return ((esp - sizeof(X86LegacyXSaveArea)) & -16ul) - fxsave_offset;
     } else {
         size_t xstate_size =
                xsave_area_size(env->xcr0, false) + TARGET_FP_XSTATE_MAGIC2_SIZE;
@@ -552,21 +525,29 @@ give_sigsegv:
     force_sigsegv(sig);
 }
 
-static int xrstor_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxsave,
+static int xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
                              abi_ulong fxsave_addr)
 {
+    struct target_fpx_sw_bytes *sw = (void *)&fxsave->sw_reserved;
+
     if (env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE) {
-        uint32_t extended_size = tswapl(fxsave->sw_reserved.extended_size);
-        uint32_t xstate_size = tswapl(fxsave->sw_reserved.xstate_size);
+        uint32_t magic1 = tswapl(sw->magic1);
+        uint32_t extended_size = tswapl(sw->extended_size);
+        uint32_t xstate_size = tswapl(sw->xstate_size);
+        uint32_t minimum_size = (TARGET_FPSTATE_FXSAVE_OFFSET
+                                 + TARGET_FP_XSTATE_MAGIC2_SIZE
+                                 + xstate_size);
+        uint32_t magic2;
 
         /* Linux checks MAGIC2 using xstate_size, not extended_size.  */
-        if (tswapl(fxsave->sw_reserved.magic1) == TARGET_FP_XSTATE_MAGIC1 &&
-            extended_size >= TARGET_FPSTATE_FXSAVE_OFFSET + xstate_size + TARGET_FP_XSTATE_MAGIC2_SIZE) {
+        if (magic1 == TARGET_FP_XSTATE_MAGIC1
+            && extended_size >= minimum_size) {
             if (!access_ok(env_cpu(env), VERIFY_READ, fxsave_addr,
                            extended_size - TARGET_FPSTATE_FXSAVE_OFFSET)) {
                 return 1;
             }
-            if (tswapl(*(uint32_t *)((void *)fxsave + xstate_size)) == TARGET_FP_XSTATE_MAGIC2) {
+            magic2 = tswapl(*(uint32_t *)((void *)fxsave + xstate_size));
+            if (magic2 == TARGET_FP_XSTATE_MAGIC2) {
                 cpu_x86_xrstor(env, fxsave_addr, -1);
                 return 0;
             }
-- 
2.34.1


