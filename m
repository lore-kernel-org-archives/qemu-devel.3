Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4F7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZQ-0007Ki-HY; Sun, 26 May 2024 20:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZJ-0007Cu-B3
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:29 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ8-0003gB-VF
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:25 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f8d0b1ccaaso1542387a34.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771018; x=1717375818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8IG0If/b6VQnjtJdCAv7RGvLxbc+5Pp5q/Lqtx4PykE=;
 b=iVrM/WD2g65tknkzf3E5/0q7d3H3yJWmlQ1u6LJu4OYTmcFx51WT1ehEI1Y/ZlwztK
 hYK+G5T+lU6HIp7UcpAf5pmMob1yXCMGnDR3YQJXOCbIS0q2VgZhwP3t6+q8MBpNADoE
 DXQESb3+6jn9FOTci9j+Pqpn9bOyhi2de5AQ3yI100tmdr+JWQEBEo29ols/qZg2CFNM
 Y43bnBxBqQ0Q+YDlqlI7iaZT/8y5xWeIIIh14n3Mv13lsJ+Xw4pKfumNwzUQJJVS95aX
 Ug2hF91CfgUwyXim276VgqJatklQKj+ZuOHJZ1SiZrChHtOMSSjkp/bhtjKeX80yQf71
 ui2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771018; x=1717375818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IG0If/b6VQnjtJdCAv7RGvLxbc+5Pp5q/Lqtx4PykE=;
 b=wPMz8DUO83F35egoHhmppPTLJ34PGYzvjmgITJ1sxSLGjlhweOH8uV6OTPK/+2tHjw
 UnTvQAQ1muEuT12DCqeXgfzcqj/qXVsxX3/SABYDFNw2x2KWe2Eugqr3N1ztZ8GdNiXd
 owtk0x82ogsd4nUgkgYAvKIb+vP8KZIKwLMV3ypFaxWVVFO0Wxgn4iBce/tzdZWoJJGj
 CN0lMiOoROm3alfoNh0G2gO49FO8op9PiBE7/TWs7uz2IjjrfdDNB+GmAlEbNHLW3fC/
 kQLgYlBXoDQJH9GNxQTfQcgh2gOZNXqFmLA0j6QGRN3Y97BO3g+CqSfT/ewnn3isACAP
 pHdg==
X-Gm-Message-State: AOJu0YweXY0uNTio3iG6OQpFytZ9VYf0K+O7Vf7yU42ML30Yl7vKaJcd
 Z2Avjfg6Otq+zuSkvBKeXrU2vs0nZJ8kPRaqGTyKgIepEhRuE2id0N9ZGmZwVfgFOf6+eLXNEfT
 c
X-Google-Smtp-Source: AGHT+IHOzXSGAkfuVgvrA0NDzYacDioxZLv89OVsnHJQaYwrXhdgQ+OZVWQgtV1ayusHK2YJnYHcTA==
X-Received: by 2002:a05:6870:958f:b0:23c:ffe8:a80c with SMTP id
 586e51a60fabf-24ca14860bfmr8722713fac.52.1716771017675; 
 Sun, 26 May 2024 17:50:17 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/28] linux-user/i386: Fix -mregparm=3 for signal delivery
Date: Sun, 26 May 2024 17:49:52 -0700
Message-Id: <20240527005001.642825-20-richard.henderson@linaro.org>
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

Since v2.6.19, the kernel has supported -mregparm=3.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 3271ebd333..6763b4bda8 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -405,8 +405,6 @@ void setup_frame(int sig, struct target_sigaction *ka,
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
         goto give_sigsegv;
 
-    __put_user(sig, &frame->sig);
-
     setup_sigcontext(&frame->sc, &frame->fpstate, env, set->sig[0],
             frame_addr + offsetof(struct sigframe, fpstate));
 
@@ -428,6 +426,13 @@ void setup_frame(int sig, struct target_sigaction *ka,
     env->regs[R_ESP] = frame_addr;
     env->eip = ka->_sa_handler;
 
+    /* Store argument for both -mregparm=3 and standard. */
+    env->regs[R_EAX] = sig;
+    __put_user(sig, &frame->sig);
+    /* The kernel clears EDX and ECX even though there is only one arg. */
+    env->regs[R_EDX] = 0;
+    env->regs[R_ECX] = 0;
+
     cpu_x86_load_seg(env, R_DS, __USER_DS);
     cpu_x86_load_seg(env, R_ES, __USER_DS);
     cpu_x86_load_seg(env, R_SS, __USER_DS);
@@ -449,9 +454,6 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_sigset_t *set, CPUX86State *env)
 {
     abi_ulong frame_addr;
-#ifndef TARGET_X86_64
-    abi_ulong addr;
-#endif
     struct rt_sigframe *frame;
     int i;
 
@@ -461,14 +463,6 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
         goto give_sigsegv;
 
-    /* These fields are only in rt_sigframe on 32 bit */
-#ifndef TARGET_X86_64
-    __put_user(sig, &frame->sig);
-    addr = frame_addr + offsetof(struct rt_sigframe, info);
-    __put_user(addr, &frame->pinfo);
-    addr = frame_addr + offsetof(struct rt_sigframe, uc);
-    __put_user(addr, &frame->puc);
-#endif
     if (ka->sa_flags & TARGET_SA_SIGINFO) {
         frame->info = *info;
     }
@@ -508,9 +502,13 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->eip = ka->_sa_handler;
 
 #ifndef TARGET_X86_64
+    /* Store arguments for both -mregparm=3 and standard. */
     env->regs[R_EAX] = sig;
+    __put_user(sig, &frame->sig);
     env->regs[R_EDX] = frame_addr + offsetof(struct rt_sigframe, info);
+    __put_user(env->regs[R_EDX], &frame->pinfo);
     env->regs[R_ECX] = frame_addr + offsetof(struct rt_sigframe, uc);
+    __put_user(env->regs[R_ECX], &frame->puc);
 #else
     env->regs[R_EAX] = 0;
     env->regs[R_EDI] = sig;
-- 
2.34.1


