Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F507C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZU-0007ON-HX; Sun, 26 May 2024 20:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ8-000773-Rm
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:18 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ0-0003aN-2r
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:17 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f8ea563a46so429443a34.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771007; x=1717375807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qu8at7vOdb1WvbcdbtxhwbQTz1oNXGTTdYMgD98z5zw=;
 b=hLa0gj0X21EUzCDc1ptPVtwS6nitnrpVfUgfZ5ERk5kC9Gw9VKnHhvbXiRXxwpkpIH
 9AYxObYXAQu7NddxZgVYmoP7DU9RbfqXDt9ib464TvSu4Oj8P1FseQcaijht/on1YN3x
 R27wKBSu4Ags1RDJbM03DZ2V9X9r7c7/GFtp8KE9KOAdCJgsr/tDXWvdTM+h/oLQNUVq
 7UcuHAIM1/76DqBOtKk5jVUKK7W0LaU2HkXHCkEy6JyNxRQsHruIA1bgPeiuvFmw8Xhv
 Mh+ROzbLeYbA5OK94HsK7uBFiQ5gcuS9NS/+gZIG4EQlOXUULTH8r7gqh+1PEiejlMud
 Rkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771007; x=1717375807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qu8at7vOdb1WvbcdbtxhwbQTz1oNXGTTdYMgD98z5zw=;
 b=G3QjxZYsjHh8iHbs7ldhItH7oH8Zwl9O2sJ5hAxPx5Wd/0MZMgQ05yVpzvfw86e4Ps
 6JBr2jr9XA2XKASV6kBoo02DDNQy0VRD2Pj/I4dbEX4PhUMbycQvVMNMDxGZlVDLzrpk
 GzBAo2NLG2vycYv5bFzuOOuRHlWAtQWXKyWL7TIgCCf/UwO053Wz5H0maNVjO4FXzIrz
 mSwMKLjj1qLYFPXjUBuAh4MjUisSxCjKHntMlEcA+xi3pl+wutqRrVVgUK0ZZEpIlLXq
 qUr6XSC519ihPMCiuzX41O78IiiGDQ4mRIweld3P9pXXA59Nd5zE9COMw0oQAD8y2aZT
 xBSw==
X-Gm-Message-State: AOJu0YwuoTnmWSEb12YNUP3AQM3/y9bPN4VdFqMrrbeGYy3m8Jybj+TL
 siAuFH2ZTXIhCUu212gUbkxkW6J4hXkWte9rCFAASYydKMdVefSyW1dh9QZ4TL801wNdk1qkjw1
 9
X-Google-Smtp-Source: AGHT+IEXi4th3ga0PuRAIH/7Eia65m7dTqrWDfBezVYjE3vyD8HmiVB8kkRUM7IxuHOWxBxwq7r4Kw==
X-Received: by 2002:a05:6870:71d3:b0:24f:c7cf:17fb with SMTP id
 586e51a60fabf-24fc7cf1b69mr5517830fac.22.1716771007046; 
 Sun, 26 May 2024 17:50:07 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/28] target/i386: Convert do_fsave, do_frstor to X86Access
Date: Sun, 26 May 2024 17:49:39 -0700
Message-Id: <20240527005001.642825-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
 target/i386/tcg/fpu_helper.c | 60 ++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 01e9a1fbbf..df12eac71e 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2469,21 +2469,16 @@ void helper_fldenv(CPUX86State *env, target_ulong ptr, int data32)
     do_fldenv(&ac, ptr, data32);
 }
 
-static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
-                     uintptr_t retaddr)
+static void do_fsave(X86Access *ac, target_ulong ptr, int data32)
 {
-    X86Access ac;
-    floatx80 tmp;
-    int i, envsize = 14 << data32;
+    CPUX86State *env = ac->env;
 
-    access_prepare(&ac, env, ptr, envsize + 80, MMU_DATA_STORE, retaddr);
+    do_fstenv(ac, ptr, data32);
+    ptr += 14 << data32;
 
-    do_fstenv(&ac, ptr, data32);
-    ptr += envsize;
-
-    for (i = 0; i < 8; i++) {
-        tmp = ST(i);
-        do_fstt(&ac, ptr, tmp);
+    for (int i = 0; i < 8; i++) {
+        floatx80 tmp = ST(i);
+        do_fstt(ac, ptr, tmp);
         ptr += 10;
     }
 
@@ -2492,23 +2487,22 @@ static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
 
 void helper_fsave(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_fsave(env, ptr, data32, GETPC());
+    int size = (14 << data32) + 80;
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, GETPC());
+    do_fsave(&ac, ptr, data32);
 }
 
-static void do_frstor(CPUX86State *env, target_ulong ptr, int data32,
-                      uintptr_t retaddr)
+static void do_frstor(X86Access *ac, target_ulong ptr, int data32)
 {
-    X86Access ac;
-    floatx80 tmp;
-    int i, envsize = 14 << data32;
+    CPUX86State *env = ac->env;
 
-    access_prepare(&ac, env, ptr, envsize + 80, MMU_DATA_LOAD, retaddr);
+    do_fldenv(ac, ptr, data32);
+    ptr += 14 << data32;
 
-    do_fldenv(&ac, ptr, data32);
-    ptr += envsize;
-
-    for (i = 0; i < 8; i++) {
-        tmp = do_fldt(&ac, ptr);
+    for (int i = 0; i < 8; i++) {
+        floatx80 tmp = do_fldt(ac, ptr);
         ST(i) = tmp;
         ptr += 10;
     }
@@ -2516,7 +2510,11 @@ static void do_frstor(CPUX86State *env, target_ulong ptr, int data32,
 
 void helper_frstor(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_frstor(env, ptr, data32, GETPC());
+    int size = (14 << data32) + 80;
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, GETPC());
+    do_frstor(&ac, ptr, data32);
 }
 
 #define XO(X)  offsetof(X86XSaveArea, X)
@@ -2972,12 +2970,20 @@ void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 #if defined(CONFIG_USER_ONLY)
 void cpu_x86_fsave(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_fsave(env, ptr, data32, 0);
+    int size = (14 << data32) + 80;
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, 0);
+    do_fsave(&ac, ptr, data32);
 }
 
 void cpu_x86_frstor(CPUX86State *env, target_ulong ptr, int data32)
 {
-    do_frstor(env, ptr, data32, 0);
+    int size = (14 << data32) + 80;
+    X86Access ac;
+
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, 0);
+    do_frstor(&ac, ptr, data32);
 }
 
 void cpu_x86_fxsave(CPUX86State *env, target_ulong ptr)
-- 
2.34.1


