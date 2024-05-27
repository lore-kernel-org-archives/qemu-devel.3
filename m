Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783EDC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZL-0007Gb-Rf; Sun, 26 May 2024 20:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZA-00077m-U4
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:22 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ2-0003ad-VK
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:19 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so3300345b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771009; x=1717375809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDW8kJImre1GGGvGAhRzSp3Q8czb8IIa/mCnb39qel0=;
 b=jOUZyPh/C0TCDcd7chLbOU7wmjugsoyv0JIUmirNiTEnfBwtqfuUp9O3GdXI7bTqdo
 D4YxWVn0Qq75vVLmrmfj78Eq8mRcVzkK+lU3TyekXdRzBNmVRYGXQ7VI5x1SJ6McrcIM
 4nEhP0cezTWYOCBnpIQbU3MGH8T35sDBzSloL2lMARc/+dtIpkdXL9OZtFUSYNjaCYjC
 YA5QA9ZWb9iLi9PWlQ+w7R9nd0JFfByZsKwjRgdCKas3DE2dcCaoCf0Mt5Nawkk/4fjD
 2jo2FWLPYWiKa/BLNkudhjRu7QCBdve9BUAkcu1cG1KXMHd49xQPFuDSX1JzTOCdfMFn
 1LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771009; x=1717375809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDW8kJImre1GGGvGAhRzSp3Q8czb8IIa/mCnb39qel0=;
 b=BdrzY4KyTIfIrSqYVRx+MXQLZS0F0M75ASO9XGGW+5cuSdss4ScUN0wJHoii3XYIwa
 /TjjsP3BBBBW3rwBNlLDe1B43uDNeHleHegPkB36oEgfeiiIIeA4ukMGP4ABCjkNOcu2
 sD/wR6iINYEn/VsNNjPwWESv4F0u2HORtFw1Q8S2WAU7p/YCAKoc0E+huVYs3QhXweD6
 aw/jJYOpXEOyFGJ/PBSPpn+4+RssmTgWjGkOzoX0kxuatwnTffU5KG6fA5aLF67LkdhT
 BZBkV8tHTS7TyUuxK+RLBReyy43vbMgCGVv9ZmRcK3fDHop2fNockIQlQ1gCHvAQ2the
 bSZA==
X-Gm-Message-State: AOJu0Ywh8c0r++NKJBJX9WVrrzxpNer6aVEoupoXC474Kmt/Ezn7XnRg
 MwGnCDNMj1yCBHXGsSKW7g2K4NC4OktdUHCT0vmBqg86kx+3BwtC0SI2IhQieijOxZrBTxJPWpl
 b
X-Google-Smtp-Source: AGHT+IHOvIVI9rhIxYwHMBZL2cFu32FJ3XXN1Dc+YJHAPHbUcviJo9gkpzJMSV5HJhgbvpsJ4FP0UA==
X-Received: by 2002:a05:6a00:301c:b0:6f3:eb71:af90 with SMTP id
 d2e1a72fcca58-6f8e924aa5amr11299924b3a.4.1716771008553; 
 Sun, 26 May 2024 17:50:08 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/28] target/i386: Convert do_xrstor_{fpu, mxcr,
 sse} to X86Access
Date: Sun, 26 May 2024 17:49:41 -0700
Message-Id: <20240527005001.642825-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 target/i386/tcg/fpu_helper.c | 46 ++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 8fbe6e00ce..f21cdb45ea 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2725,39 +2725,41 @@ void helper_xsaveopt(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
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
-    access_prepare(&ac, env, addr, 8 * 16, MMU_DATA_LOAD, ra);
 
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
 
@@ -2769,8 +2771,8 @@ static void do_xrstor_sse(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
     addr = ptr + XO(legacy.xmm_regs);
     for (i = 0; i < nb_xmm_regs; i++) {
-        env->xmm_regs[i].ZMM_Q(0) = cpu_ldq_data_ra(env, addr, ra);
-        env->xmm_regs[i].ZMM_Q(1) = cpu_ldq_data_ra(env, addr + 8, ra);
+        env->xmm_regs[i].ZMM_Q(0) = access_ldq(ac, addr);
+        env->xmm_regs[i].ZMM_Q(1) = access_ldq(ac, addr + 8);
         addr += 16;
     }
 }
@@ -2850,20 +2852,24 @@ static void do_xrstor_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
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
@@ -2876,6 +2882,7 @@ void helper_fxrstor(CPUX86State *env, target_ulong ptr)
 static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr_t ra)
 {
     uint64_t xstate_bv, xcomp_bv, reserve0;
+    X86Access ac;
 
     rfbm &= env->xcr0;
 
@@ -2914,9 +2921,12 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
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
@@ -2925,9 +2935,9 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
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


