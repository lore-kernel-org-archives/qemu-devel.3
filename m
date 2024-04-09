Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D91C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3du-0003DK-7E; Tue, 09 Apr 2024 01:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3ds-0003D8-Lm
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:32 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dr-0005LT-2c
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:32 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so3408112b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639010; x=1713243810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ywDEWaMPHCkZHNZHZvDhBEB+D4W5S61RGKLaVoHCr7o=;
 b=CF2bkEmh2up95Lwedu0z6rIg10INFCUnGDgZL3GsGZWRYwjkgpHbfrgDKoCfih+RWX
 9PCNICrWKyrWp0hH34ENm0rjQmSJWU6TrEOg9lmlQXP2E2Wj2BH5+V9U4+r4v5ViEWp9
 3GsBhO9/g1Ac9d0MgsSVE5dC27Or33Ep5ikHBlq/22/Ij8uRz268CtISFIzG0nEgIA/J
 0GtNmk91oOEloPjiaCPdKQaNB/VcM0z6BlCRhVzzJzPFFniu+ajuUECkCLrjEiLW1Ef4
 f3wvh2cbzm/S3/Alnn+zR85XFO0P0FHqtVuRPvNjgT9JU5nCy3ckDetA3VbDjQHGC/bt
 XZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639010; x=1713243810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ywDEWaMPHCkZHNZHZvDhBEB+D4W5S61RGKLaVoHCr7o=;
 b=MkffxL8TLAny2bxAGFG1dy1dhTj3PVmUSt9TX9m7uB7H5ZAfzhN+ywk+0iBGteX1GB
 bc5GXp2y2bSnuE9u2rd2VhcGouqIkgUrALKM9xA0S+xmX1FJcp+eAC9qb011T5Q2LO/P
 Igo/gde08inzNyV0c5vicLMqM6PIiSOhzmgBRuR/3tcgJra1k6SMemmftUW8M0DI02JS
 yftsGE0Ob+/N8BzSeW+ncjwV4lHbFYAB8ep51g3wvNaOqlU/TKz1eQikCw08Nd/u/pYE
 KTkNcijUimSw4388zeW/s2cMPTZyYZxhsXRpfuqNdyIc9E1l4vZc+cAFDaHvc7DILHGR
 vDMg==
X-Gm-Message-State: AOJu0YzR3csnmsZJY7tsDZVzHXoxdybo7xI2DxsBbs1SjslZRtZRX2Jh
 x1lE+E647jZJV83kSghkqyegD47qvFOwRi/6k+2fzZUcGeCTk1GIzRcd/OghLI1/PBk5IsrVuJ3
 c
X-Google-Smtp-Source: AGHT+IFahfqIH6bHTJ8goWtmwgDDYAW8DEothdAseTbCofPfg0zpqv+K7mJVdB0ExThwkwKps58RTw==
X-Received: by 2002:a05:6a00:852:b0:6ec:f28b:659f with SMTP id
 q18-20020a056a00085200b006ecf28b659fmr14320620pfk.3.1712639009803; 
 Mon, 08 Apr 2024 22:03:29 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/28] linux-user/i386: Return boolean success from
 restore_sigcontext
Date: Mon,  8 Apr 2024 19:02:54 -1000
Message-Id: <20240409050302.1523277-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Invert the sense of the return value and use bool.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 51 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index f8cc0cff07..1571ff8553 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -563,12 +563,12 @@ static int xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
     return 0;
 }
 
-static int
-restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
+static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
 {
-    int err = 1;
     abi_ulong fpstate_addr;
     unsigned int tmpflags;
+    struct target_fpstate *fpstate;
+    bool ok;
 
 #ifndef TARGET_X86_64
     cpu_x86_load_seg(env, R_GS, tswap16(sc->gs));
@@ -616,29 +616,27 @@ restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
     //          regs->orig_eax = -1;            /* disable syscall checks */
 
     fpstate_addr = tswapl(sc->fpstate);
-    if (fpstate_addr != 0) {
-        struct target_fpstate *fpstate;
-        if (!lock_user_struct(VERIFY_READ, fpstate, fpstate_addr,
-                              sizeof(struct target_fpstate))) {
-            return err;
-        }
-#ifndef TARGET_X86_64
-        if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
-            cpu_x86_frstor(env, fpstate_addr, 1);
-            err = 0;
-        } else {
-            err = xrstor_sigcontext(env, &fpstate->fxstate,
-                                    fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
-        }
-#else
-        err = xrstor_sigcontext(env, fpstate, fpstate_addr);
-#endif
-        unlock_user_struct(fpstate, fpstate_addr, 0);
-    } else {
-        err = 0;
+    if (fpstate_addr == 0) {
+        return true;
     }
+    if (!lock_user_struct(VERIFY_READ, fpstate, fpstate_addr,
+                          sizeof(struct target_fpstate))) {
+        return false;
+    }
+#ifndef TARGET_X86_64
+    if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
+        cpu_x86_frstor(env, fpstate_addr, 1);
+        ok = true;
+    } else {
+        ok = !xrstor_sigcontext(env, &fpstate->fxstate,
+                                fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
+    }
+#else
+    ok = !xrstor_sigcontext(env, fpstate, fpstate_addr);
+#endif
+    unlock_user_struct(fpstate, fpstate_addr, 0);
 
-    return err;
+    return ok;
 }
 
 /* Note: there is no sigreturn on x86_64, there is only rt_sigreturn */
@@ -664,8 +662,9 @@ long do_sigreturn(CPUX86State *env)
     set_sigmask(&set);
 
     /* restore registers */
-    if (restore_sigcontext(env, &frame->sc))
+    if (!restore_sigcontext(env, &frame->sc)) {
         goto badframe;
+    }
     unlock_user_struct(frame, frame_addr, 0);
     return -QEMU_ESIGRETURN;
 
@@ -689,7 +688,7 @@ long do_rt_sigreturn(CPUX86State *env)
     target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
     set_sigmask(&set);
 
-    if (restore_sigcontext(env, &frame->uc.tuc_mcontext)) {
+    if (!restore_sigcontext(env, &frame->uc.tuc_mcontext)) {
         goto badframe;
     }
 
-- 
2.34.1


