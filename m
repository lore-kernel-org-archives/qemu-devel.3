Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760D8C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZM-0007HD-FA; Sun, 26 May 2024 20:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZA-00077l-Tb
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:22 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ3-0003bO-RL
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:19 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-60585faa69fso3174630a12.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771012; x=1717375812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VUA0H1FqSwLKp/HJjCgFsX8ntjk+Qvs0JjKKwjJR0Q=;
 b=ZCKmIlj6yrJmsnhHpblDmK1J4ooYomLfIokbVF84DRuFJkE+IyVsj+jORpqaix8Rtr
 C4FJ29gTsuusLVHyhZXCjJqWkGxb8icn6S2xydD6A+YFXjFk1aLOQCXp5TZ9D4NWo23e
 zDak7rlgQ9QSTq33vcLp5l9Vf17P50Stzp/70egSIxnpn1KwaV8bYQCXNfU4MDKW7sil
 ivBZSFzpQ9eA20lkRW9anC7I6wq2Pu2MoCv4HDXtOFLuO2DXiTQMqSj/faCpDIphj8GW
 0z6OXjksk2y3HSzYvPY9/F2BADzuqYrX2SBBXGL3+5fAfD9+JGCV4iu/hA+HzLi0w0dA
 a3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771012; x=1717375812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3VUA0H1FqSwLKp/HJjCgFsX8ntjk+Qvs0JjKKwjJR0Q=;
 b=DZ81qcrbp/2FpE0lE4cNDAuJE1reqcZK+K1yvWGCaYYCfcfIa5+kYTffRxiL96lrB/
 IVZ9+YU8S0c2L3dNi8a1fi3RWfUce16AwRathH0eYcA15b4KjmisM9s+CwbHnSjw8zKv
 vRpGFFsF40sNln/zml2R1OYbOAxHr04prwTRRcRZKVOid2NZDZn69ZlrFswrjpbwiiCL
 jIgQdU/8OBxBiOmC6IhSHNGLUcbyxRjzrOawtFpd7eD9q16+Fe88cczjRFL38ghEayGU
 r04NzMSTcIU3WJ8+ueowUNpmrg7y/1jDkWw+fBCTv2Gjrj098xRriwSOzRhJiGgcx1xR
 2lAw==
X-Gm-Message-State: AOJu0YzpJicL7bKw02e9hcD6ui5eXagIzYAtoRovzl2sDugOuIzeBt62
 vmPNC72rmdhfnCXIelJ5fyULS4y4FO7TseY0YkiwaCpMgFRLtdLOUB/X8kwELDAwag6MoZPVuGM
 S
X-Google-Smtp-Source: AGHT+IFy5Km30Q98986e+5tVTnXU9tktojgubxmVGg5KyJX7Br5v1jkJg6lz3ZaTCrO+68zlks2ULQ==
X-Received: by 2002:a05:6a20:2453:b0:1aa:965d:1332 with SMTP id
 adf61e73a8af0-1b212e135b8mr11059924637.26.1716771012038; 
 Sun, 26 May 2024 17:50:12 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 12/28] target/i386: Split out do_xsave_chk
Date: Sun, 26 May 2024 17:49:45 -0700
Message-Id: <20240527005001.642825-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

This path is not required by user-only, and can in fact
be shared between xsave and xrstor.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 51 +++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 7796688514..6a319dadf2 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2675,16 +2675,6 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
     X86Access ac;
     unsigned size;
 
-    /* The OS must have enabled XSAVE.  */
-    if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
-        raise_exception_ra(env, EXCP06_ILLOP, ra);
-    }
-
-    /* The operand must be 64 byte aligned.  */
-    if (ptr & 63) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
-
     /* Never save anything not enabled by XCR0.  */
     rfbm &= env->xcr0;
     opt &= rfbm;
@@ -2721,15 +2711,35 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
     access_stq(&ac, ptr + XO(header.xstate_bv), new_bv);
 }
 
+static void do_xsave_chk(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+{
+    /* The OS must have enabled XSAVE.  */
+    if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
+        raise_exception_ra(env, EXCP06_ILLOP, ra);
+    }
+
+    /* The operand must be 64 byte aligned.  */
+    if (ptr & 63) {
+        raise_exception_ra(env, EXCP0D_GPF, ra);
+    }
+}
+
 void helper_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xsave(env, ptr, rfbm, get_xinuse(env), -1, GETPC());
+    uintptr_t ra = GETPC();
+
+    do_xsave_chk(env, ptr, ra);
+    do_xsave(env, ptr, rfbm, get_xinuse(env), -1, ra);
 }
 
 void helper_xsaveopt(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    uint64_t inuse = get_xinuse(env);
-    do_xsave(env, ptr, rfbm, inuse, inuse, GETPC());
+    uintptr_t ra = GETPC();
+    uint64_t inuse;
+
+    do_xsave_chk(env, ptr, ra);
+    inuse = get_xinuse(env);
+    do_xsave(env, ptr, rfbm, inuse, inuse, ra);
 }
 
 static void do_xrstor_fpu(X86Access *ac, target_ulong ptr)
@@ -2900,16 +2910,6 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
 
     rfbm &= env->xcr0;
 
-    /* The OS must have enabled XSAVE.  */
-    if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
-        raise_exception_ra(env, EXCP06_ILLOP, ra);
-    }
-
-    /* The operand must be 64 byte aligned.  */
-    if (ptr & 63) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
-
     size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
     access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, ra);
 
@@ -3004,7 +3004,10 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
 
 void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xrstor(env, ptr, rfbm, GETPC());
+    uintptr_t ra = GETPC();
+
+    do_xsave_chk(env, ptr, ra);
+    do_xrstor(env, ptr, rfbm, ra);
 }
 
 #if defined(CONFIG_USER_ONLY)
-- 
2.34.1


