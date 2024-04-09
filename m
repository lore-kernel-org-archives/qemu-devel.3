Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CA5CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3e1-0003GJ-Sk; Tue, 09 Apr 2024 01:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3e0-0003Fp-Lr
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:40 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dz-0005Ol-25
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:40 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ed01c63657so3079746b3a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639018; x=1713243818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Anvecy/e2tvOY5sGb/v0c6reXmQKZCwnsUl0b7ikqas=;
 b=vcfgRo3HZQkGgHrMSJhS0d35utihgTktNzFr1Jfpu33El1iOFGITZS8WYVYJ/7EggS
 8MwqYGPdbf4C27xfUjVn90OG/GcY2+KkFFo4l4CWRalv9DAvLetNPbDDC0hNNHKLv6uk
 er+HmZZwjS6N1Vhg3KNk4mnhozZDUca44IBFeI1g7cPTRjv1Dtf6JY0kLn60XttErzU3
 OojLzinK8yXl7AERfvm+0bwOUQDKRD9Q6U2hWL/IzW/ytrrS5s4CTcDa/2umKBKuA4KC
 ce0wZD4T26hxmgXDMDbEMTRWvxMBOkBE4v1/bUL/pDm7AshtQOidVsNRdbSFp9pZG9aI
 BFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639018; x=1713243818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Anvecy/e2tvOY5sGb/v0c6reXmQKZCwnsUl0b7ikqas=;
 b=mfEy4gWUoKOTIyC2cw8jWUSa9559fIKKnji0hWHY//4k5OJcwqVvtrdMPI8uCcCFeM
 V+8sD+ORknu62kFUigmQ45XF2H36dTmh4W7Hf1Njm4B4flqm7pBoF8NB7zcSUgMMmnm/
 HwHKWo235vsM9zzJ86RhR3GB+iOWgAyMHwDa6q9wQ106suK8QmrpdINxZTsHlF7ILHnG
 JqR87Zt+4Fv7QjgF9UYFN6hkBTG0OBo33f89dtNZCZMOss7fXQAdRpP8whDSJxUQnddE
 iJvX37wjDaHIEx9sWLvEIWqLey0go5STIFCGyVFAR63JfJNSExxRfYtbdP7yy/F3iC6P
 jaqw==
X-Gm-Message-State: AOJu0YzoqbAiNOITZznW7r6OyKUYOrUVe/qLV1nAsvO5nJxTJghbAAY7
 jfAYdIUcrVtpVEBpyhAPww+N1S1Au86VnP2q08jsN8ByhhyigMy1HjiOdcLtZn1GgV9DUCGUNON
 J
X-Google-Smtp-Source: AGHT+IEgTGH2iLV+PKbnpvjlKzzQUUE1/JXOAuhKWEvulij5bDU1wuSEMBJ8vt5d+BBTV+iBdalSMg==
X-Received: by 2002:a05:6a00:2285:b0:6ed:9493:bc6d with SMTP id
 f5-20020a056a00228500b006ed9493bc6dmr43465pfe.12.1712639017667; 
 Mon, 08 Apr 2024 22:03:37 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 26/28] target/i386: Pass host pointer and size to
 cpu_x86_{fsave, frstor}
Date: Mon,  8 Apr 2024 19:03:00 -1000
Message-Id: <20240409050302.1523277-27-richard.henderson@linaro.org>
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

We have already validated the memory region in the course of
validating the signal frame.  No need to do it again within
the helper function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            | 10 ++++++----
 linux-user/i386/signal.c     |  4 ++--
 target/i386/tcg/fpu_helper.c | 26 ++++++++++++++++----------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5f9c420084..8eb97fdd7a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2227,11 +2227,13 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
 /* used for debug or cpu save/restore */
 
 /* cpu-exec.c */
-/* the following helpers are only usable in user mode simulation as
-   they can trigger unexpected exceptions */
+/*
+ * The following helpers are only usable in user mode simulation.
+ * The host pointers should come from lock_user().
+ */
 void cpu_x86_load_seg(CPUX86State *s, X86Seg seg_reg, int selector);
-void cpu_x86_fsave(CPUX86State *s, target_ulong ptr, int data32);
-void cpu_x86_frstor(CPUX86State *s, target_ulong ptr, int data32);
+void cpu_x86_fsave(CPUX86State *s, void *host, size_t len);
+void cpu_x86_frstor(CPUX86State *s, void *host, size_t len);
 void cpu_x86_fxsave(CPUX86State *s, target_ulong ptr);
 void cpu_x86_fxrstor(CPUX86State *s, target_ulong ptr);
 void cpu_x86_xsave(CPUX86State *s, target_ulong ptr, uint64_t rbfm);
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index ba17d27219..7178440d67 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -372,7 +372,7 @@ static void setup_sigcontext(CPUX86State *env,
     __put_user(env->regs[R_ESP], &sc->esp_at_signal);
     __put_user(env->segs[R_SS].selector, (uint32_t *)&sc->ss);
 
-    cpu_x86_fsave(env, fpstate_addr, 1);
+    cpu_x86_fsave(env, fpstate, sizeof(*fpstate));
     fpstate->status = fpstate->swd;
     magic = (fpkind == FPSTATE_FSAVE ? 0 : 0xffff);
     __put_user(magic, &fpstate->magic);
@@ -701,7 +701,7 @@ static bool frstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
      * the merge within ENV by loading XSTATE/FXSTATE first, then
      * overriding with the FSTATE afterward.
      */
-    cpu_x86_frstor(env, fpstate_addr, 1);
+    cpu_x86_frstor(env, fpstate, sizeof(*fpstate));
     return true;
 }
 #endif
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 909da05f91..0a91757690 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3016,22 +3016,28 @@ void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 }
 
 #if defined(CONFIG_USER_ONLY)
-void cpu_x86_fsave(CPUX86State *env, target_ulong ptr, int data32)
+void cpu_x86_fsave(CPUX86State *env, void *host, size_t len)
 {
-    int size = (14 << data32) + 80;
-    X86Access ac;
+    X86Access ac = {
+        .haddr1 = host,
+        .size = 4 * 7 + 8 * 10,
+        .env = env,
+    };
 
-    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, 0);
-    do_fsave(&ac, ptr, data32);
+    assert(ac.size <= len);
+    do_fsave(&ac, 0, true);
 }
 
-void cpu_x86_frstor(CPUX86State *env, target_ulong ptr, int data32)
+void cpu_x86_frstor(CPUX86State *env, void *host, size_t len)
 {
-    int size = (14 << data32) + 80;
-    X86Access ac;
+    X86Access ac = {
+        .haddr1 = host,
+        .size = 4 * 7 + 8 * 10,
+        .env = env,
+    };
 
-    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, 0);
-    do_frstor(&ac, ptr, data32);
+    assert(ac.size <= len);
+    do_frstor(&ac, 0, true);
 }
 
 void cpu_x86_fxsave(CPUX86State *env, target_ulong ptr)
-- 
2.34.1


