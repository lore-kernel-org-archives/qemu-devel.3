Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DDCCD129A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dh-00039C-4w; Tue, 09 Apr 2024 01:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3df-00038f-OP
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:19 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3de-0005FX-0v
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:19 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-22fa18566adso121512fac.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638996; x=1713243796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lp1ipweNADN/6K9dE0kz0Ja73YaJ/vSstA3RIvGr8kM=;
 b=bGVWqD60NjJM/0SL2FCs5WeHp9OQhyuHbwyG+WkNwqlu/g3ydJBOx/IMFMgY7vcRYk
 NNWmyWTqxm7Bp/C4CQmZ5rkhICt+5ukRoH4vNCcjGK69PbjL5sHhU9swEPyQNvhLnZOE
 xMruL8Xy84zWJxEqsdpP/4CqsnbpiFm+PVLtXxc4qISXvXOXAsdXT2MaF3YXw5+uobuq
 PxarYji448fn3sMbHKDGzVEjepVD1lGfZKSDEaIR8U/qTII1L7NLyTmOK/uOBS1NZtCB
 k6vvBx+TqJBBBxgq8yaubnfk+xp9Naet/aCI9dXsd0eyVeDbWVLRynKVNO4q1ROm9pfu
 3etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638996; x=1713243796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lp1ipweNADN/6K9dE0kz0Ja73YaJ/vSstA3RIvGr8kM=;
 b=Y+gLNH1FY64rNZ1VWVj0mtEYwAJIIgRNLPzmtlkEP9V8pfZogZKve+TIHyJOv91tOJ
 QdXPVMTgsE80jd6gUsTS6yelFkA11/J8aDQBgpkBOGqwSZ8iIZLzxamuWDXWO93nz57k
 z91JT5rtUGFgAekQlFpJDduV0odnnnYn4xRKfwzswG6aaWMj9KtO4kOMNNUpH9h7+5CJ
 cvgwx/L/flg2CBBHAoZdVqHhm7G2Vv/PZDHWbbW6dShS+ZRnek+1TdkEPux40ITBQLC8
 bpKU/EkSp5tGHLtKN0kJ28sZ97kpHe8UTDZ6cRrk25dmWzW6niHVIE5Z1V6g26RDoBUD
 8QAA==
X-Gm-Message-State: AOJu0YwDUTFbLO93OSmNjqxg74foIauetUmkJ6+2stfglX21jCpjxybW
 atTXQnyXVtK/xYixiUUOLXl0heXE3Cs3hzs6OfA/pKaarH9VkP5H8fPSBXhbnKs664MKJgh7Cci
 e
X-Google-Smtp-Source: AGHT+IE1EjXWqERMqHuixMbS+d0ZzVL/NyFNelP5PQYT7yl4XEAk59u+sW8kp2QE9vL20D8VVvYcLw==
X-Received: by 2002:a05:6870:15c4:b0:22a:107c:4dd6 with SMTP id
 k4-20020a05687015c400b0022a107c4dd6mr11849811oad.40.1712638996599; 
 Mon, 08 Apr 2024 22:03:16 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/28] tagret/i386: Convert do_fxsave,
 do_fxrstor to X86Access
Date: Mon,  8 Apr 2024 19:02:43 -1000
Message-Id: <20240409050302.1523277-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

Move the alignment fault from do_* to helper_*, as it need
not apply to usage from within user-only signal handling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 84 ++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 59f73ad075..23e22e4521 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2618,8 +2618,25 @@ static void do_xsave_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     cpu_stq_data_ra(env, ptr, env->pkru, ra);
 }
 
-static void do_fxsave(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_fxsave(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
+
+    do_xsave_fpu(ac, ptr);
+    if (env->cr[4] & CR4_OSFXSR_MASK) {
+        do_xsave_mxcsr(ac, ptr);
+        /* Fast FXSAVE leaves out the XMM registers */
+        if (!(env->efer & MSR_EFER_FFXSR)
+            || (env->hflags & HF_CPL_MASK)
+            || !(env->hflags & HF_LMA_MASK)) {
+            do_xsave_sse(ac, ptr);
+        }
+    }
+}
+
+void helper_fxsave(CPUX86State *env, target_ulong ptr)
+{
+    uintptr_t ra = GETPC();
     X86Access ac;
 
     /* The operand must be 16 byte aligned */
@@ -2629,22 +2646,7 @@ static void do_fxsave(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
     access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
                    MMU_DATA_STORE, ra);
-    do_xsave_fpu(&ac, ptr);
-
-    if (env->cr[4] & CR4_OSFXSR_MASK) {
-        do_xsave_mxcsr(&ac, ptr);
-        /* Fast FXSAVE leaves out the XMM registers */
-        if (!(env->efer & MSR_EFER_FFXSR)
-            || (env->hflags & HF_CPL_MASK)
-            || !(env->hflags & HF_LMA_MASK)) {
-            do_xsave_sse(&ac, ptr);
-        }
-    }
-}
-
-void helper_fxsave(CPUX86State *env, target_ulong ptr)
-{
-    do_fxsave(env, ptr, GETPC());
+    do_fxsave(&ac, ptr);
 }
 
 static uint64_t get_xinuse(CPUX86State *env)
@@ -2849,8 +2851,25 @@ static void do_xrstor_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     env->pkru = cpu_ldq_data_ra(env, ptr, ra);
 }
 
-static void do_fxrstor(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_fxrstor(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
+
+    do_xrstor_fpu(ac, ptr);
+    if (env->cr[4] & CR4_OSFXSR_MASK) {
+        do_xrstor_mxcsr(ac, ptr);
+        /* Fast FXRSTOR leaves out the XMM registers */
+        if (!(env->efer & MSR_EFER_FFXSR)
+            || (env->hflags & HF_CPL_MASK)
+            || !(env->hflags & HF_LMA_MASK)) {
+            do_xrstor_sse(ac, ptr);
+        }
+    }
+}
+
+void helper_fxrstor(CPUX86State *env, target_ulong ptr)
+{
+    uintptr_t ra = GETPC();
     X86Access ac;
 
     /* The operand must be 16 byte aligned */
@@ -2860,22 +2879,7 @@ static void do_fxrstor(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
     access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
                    MMU_DATA_LOAD, ra);
-    do_xrstor_fpu(&ac, ptr);
-
-    if (env->cr[4] & CR4_OSFXSR_MASK) {
-        do_xrstor_mxcsr(&ac, ptr);
-        /* Fast FXRSTOR leaves out the XMM registers */
-        if (!(env->efer & MSR_EFER_FFXSR)
-            || (env->hflags & HF_CPL_MASK)
-            || !(env->hflags & HF_LMA_MASK)) {
-            do_xrstor_sse(&ac, ptr);
-        }
-    }
-}
-
-void helper_fxrstor(CPUX86State *env, target_ulong ptr)
-{
-    do_fxrstor(env, ptr, GETPC());
+    do_fxrstor(&ac, ptr);
 }
 
 static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr_t ra)
@@ -3007,12 +3011,20 @@ void cpu_x86_frstor(CPUX86State *env, target_ulong ptr, int data32)
 
 void cpu_x86_fxsave(CPUX86State *env, target_ulong ptr)
 {
-    do_fxsave(env, ptr, 0);
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
+                   MMU_DATA_STORE, 0);
+    do_fxsave(&ac, ptr);
 }
 
 void cpu_x86_fxrstor(CPUX86State *env, target_ulong ptr)
 {
-    do_fxrstor(env, ptr, 0);
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
+                   MMU_DATA_LOAD, 0);
+    do_fxrstor(&ac, ptr);
 }
 
 void cpu_x86_xsave(CPUX86State *env, target_ulong ptr)
-- 
2.34.1


