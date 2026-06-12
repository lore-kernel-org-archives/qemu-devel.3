Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24668CD98D8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY2eK-0008LC-Mf; Fri, 12 Jun 2026 10:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wY2eI-0008Kw-T4
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:14:18 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wY2eH-0007wF-6C
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:14:18 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7e8833c99fcso10727307b3.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781273655; x=1781878455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HflSwLhhHhLqdJU/yngYyzyHzq4rZCGqbgjTj+XX7OI=;
 b=aBCvNEbvjO1aOsvggFEJACqyjGcbhoVbuBdnSmT5VfdDTrpU1Fb4U1JhohIxWLoxqs
 VSzaSJqxarp/3LDdfR1ppp9HWvfaAe6MB7GEvZ2H5YUJ9w89qCqoTHs8zEa8DivV4kAd
 NunAaVXuOzcez5xA2UvV9giGeVFV/C/t4vh/2/WPeCdY7aGPtAHU4TZwjCkL+UcyYVk6
 nttfouub9Wok6rFnEVfDP5h0VnnrtnMTJ/QOmYdf0AhV5BhHhFJ1r778yJux3iTRRxbM
 RouqLNvonc2ZbLSm4tSykZfBCni1C0EtaHx+gJc6WRPvTuNPGX+b2NEWA4uNIHAItrbS
 FRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781273655; x=1781878455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HflSwLhhHhLqdJU/yngYyzyHzq4rZCGqbgjTj+XX7OI=;
 b=sj1YIFKzOps2oC4XbrkFSSwl6XPoiJUqewSaEyp5nCMRJfQxjqVUJLpGvCSS+qHMwR
 U/RCnOruGNG5SoC7Nybqr6zyE8CInVfhXO+78aJgD6YdMwEzvRKZGD3cx39a9cofNIU+
 ldGa6kW3+d08bKirqqrs6ZMK8kG2CUfpjvL5KhO/Nojm6nILeyV/EfOXWnNxBrZ9MBTe
 /hvVJq13BW18qXGNJLeCv9JIebtoTYrqocl6Rq/ow+ZbbJcKkR5eDEztkiMiNwe9Unrk
 fGR62a7wBkSXTNj8zANelkBty5rFakQ97x9RaCrqFz/8IODOGSOBSvIKEryDpTa/6liS
 n+sg==
X-Gm-Message-State: AOJu0Ywz5h44+qg6MJGqGCCtPqso4EBw4G88J3qSehbphfjZ+HdY4X1m
 gDnyiBscEQ2sElIZGiS73alpmH040n4MX8JNE7kUn24+uODebkJP2JI/H7gB5Pw2
X-Gm-Gg: Acq92OGAY9FwI2dmkrWksqYEUtfesI/T4GDYMM9XlUaq2uQLw/G1KsI+LND0XymWSMk
 aQi3r/Kg03+z+bmNoAXVJ/T2kMPIzYBXQnGtD1CAnFpJe1nXgB4vlWMx7ipoYgJX0XXaa8Ggooj
 Szor/nDqEfqbZ3CZ6DxzHnG5mFRrwJ51V0G+vDegXkVuGk50M/XoH8Y9xQ5e9kgY7pwsyXATye6
 FFFWkACd9Na//36oLo4eXvO10cDnlAb2LFdxJGDlyrebUhS6zEFJPcs+7U3xEv8Cw9qH+0zKNFm
 Q5kWcGiBTBpfFYRR5LGaku2h/S62qZ9IGu4QZgGtsNV3Tv5G18hGM1mAckMjMYLAQR9H0WjVrPZ
 /G0C/wmJ1d1t4cthLaVlUu6aXbB55gMw0guI3OO82/27BecQKWua/J//OyIYLll8E627E8uNHiY
 x6rUVvFwqggvG1wV6Ob1PzXkM=
X-Received: by 2002:a05:690c:3693:b0:7dd:3f36:59ef with SMTP id
 00721157ae682-7f7bac02ca4mr28007947b3.3.1781273655235; 
 Fri, 12 Jun 2026 07:14:15 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7f76e994813sm10443277b3.14.2026.06.12.07.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 07:14:13 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 2/2] linux-user/xtensa: save/restore FP registers across
 signal delivery
Date: Fri, 12 Jun 2026 10:14:06 -0400
Message-ID: <20260612141406.1211912-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610152648.677463-2-mattst88@gmail.com>
References: <20260610152648.677463-2-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add support for saving and restoring f0-f15 across signal delivery.
The target_xtensa_xtregs_fp struct carries 32-bit f-regs for cores
with XTENSA_OPTION_FP_COPROCESSOR; target_xtensa_xtregs_dfp carries
64-bit f-regs for cores with XTENSA_OPTION_DFP_COPROCESSOR.

Lock the xtregs region via lock_user before reading on sigreturn,
since sc_xtregs is a user-space pointer that may lie outside the
locked sigframe.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/xtensa/signal.c | 96 ++++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 8 deletions(-)

diff --git ./linux-user/xtensa/signal.c ./linux-user/xtensa/signal.c
index ef8b0c3a27..e3f9da322b 100644
--- ./linux-user/xtensa/signal.c
+++ ./linux-user/xtensa/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "target/xtensa/cpu.h"
 
 struct target_sigcontext {
     abi_ulong sc_pc;
@@ -43,10 +44,25 @@ struct target_ucontext {
     target_sigset_t tuc_sigmask;
 };
 
+struct target_xtensa_xtregs_fp {
+    uint32_t f[16];
+    uint32_t fcr;
+    uint32_t fsr;
+};
+
+struct target_xtensa_xtregs_dfp {
+    uint64_t f[16];
+    uint32_t fcr;
+    uint32_t fsr;
+};
+
 struct target_rt_sigframe {
     target_siginfo_t info;
     struct target_ucontext uc;
-    /* TODO: xtregs */
+    union {
+        struct target_xtensa_xtregs_fp fp;
+        struct target_xtensa_xtregs_dfp dfp;
+    } xtregs;
     uint8_t retcode[6];
     abi_ulong window[4];
 };
@@ -107,6 +123,7 @@ static int flush_window_regs(CPUXtensaState *env)
 }
 
 static int setup_sigcontext(struct target_rt_sigframe *frame,
+                            abi_ulong frame_addr,
                             CPUXtensaState *env)
 {
     struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
@@ -123,8 +140,25 @@ static int setup_sigcontext(struct target_rt_sigframe *frame,
     for (i = 0; i < 16; ++i) {
         __put_user(env->regs[i], sc->sc_a + i);
     }
-    __put_user(0, &sc->sc_xtregs);
-    /* TODO: xtregs */
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_DFP_COPROCESSOR)) {
+        for (i = 0; i < 16; ++i) {
+            __put_user(env->fregs[i].f64, &frame->xtregs.dfp.f[i]);
+        }
+        __put_user(env->uregs[FCR], &frame->xtregs.dfp.fcr);
+        __put_user(cpu_get_fsr(env), &frame->xtregs.dfp.fsr);
+        __put_user(frame_addr + offsetof(struct target_rt_sigframe, xtregs),
+                   &sc->sc_xtregs);
+    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR)) {
+        for (i = 0; i < 16; ++i) {
+            __put_user(env->fregs[i].f32[FP_F32_LOW], &frame->xtregs.fp.f[i]);
+        }
+        __put_user(env->uregs[FCR], &frame->xtregs.fp.fcr);
+        __put_user(cpu_get_fsr(env), &frame->xtregs.fp.fsr);
+        __put_user(frame_addr + offsetof(struct target_rt_sigframe, xtregs),
+                   &sc->sc_xtregs);
+    } else {
+        __put_user(0, &sc->sc_xtregs);
+    }
     return 1;
 }
 
@@ -190,7 +224,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
     target_save_altstack(&frame->uc.tuc_stack, env);
-    if (!setup_sigcontext(frame, env)) {
+    if (!setup_sigcontext(frame, frame_addr, env)) {
         unlock_user_struct(frame, frame_addr, 0);
         goto give_sigsegv;
     }
@@ -243,8 +277,8 @@ give_sigsegv:
     force_sigsegv(sig);
 }
 
-static void restore_sigcontext(CPUXtensaState *env,
-                               struct target_rt_sigframe *frame)
+static int restore_sigcontext(CPUXtensaState *env,
+                              struct target_rt_sigframe *frame)
 {
     struct target_sigcontext *sc = &frame->uc.tuc_mcontext;
     uint32_t ps;
@@ -266,7 +300,51 @@ static void restore_sigcontext(CPUXtensaState *env,
     for (i = 0; i < 16; ++i) {
         __get_user(env->regs[i], sc->sc_a + i);
     }
-    /* TODO: xtregs */
+    {
+        abi_ulong xtregs_addr;
+
+        __get_user(xtregs_addr, &sc->sc_xtregs);
+        if (xtregs_addr) {
+            if (xtensa_option_enabled(env->config,
+                                      XTENSA_OPTION_DFP_COPROCESSOR)) {
+                struct target_xtensa_xtregs_dfp *xtregs;
+                uint32_t fcr, fsr;
+
+                xtregs = lock_user(VERIFY_READ, xtregs_addr,
+                                   sizeof(*xtregs), 1);
+                if (!xtregs) {
+                    return 0;
+                }
+                for (i = 0; i < 16; ++i) {
+                    __get_user(env->fregs[i].f64, &xtregs->f[i]);
+                }
+                __get_user(fcr, &xtregs->fcr);
+                __get_user(fsr, &xtregs->fsr);
+                unlock_user(xtregs, xtregs_addr, 0);
+                cpu_set_fcr(env, fcr);
+                cpu_set_fsr(env, fsr);
+            } else if (xtensa_option_enabled(env->config,
+                                             XTENSA_OPTION_FP_COPROCESSOR)) {
+                struct target_xtensa_xtregs_fp *xtregs;
+                uint32_t fcr, fsr;
+
+                xtregs = lock_user(VERIFY_READ, xtregs_addr,
+                                   sizeof(*xtregs), 1);
+                if (!xtregs) {
+                    return 0;
+                }
+                for (i = 0; i < 16; ++i) {
+                    __get_user(env->fregs[i].f32[FP_F32_LOW], &xtregs->f[i]);
+                }
+                __get_user(fcr, &xtregs->fcr);
+                __get_user(fsr, &xtregs->fsr);
+                unlock_user(xtregs, xtregs_addr, 0);
+                cpu_set_fcr(env, fcr);
+                cpu_set_fsr(env, fsr);
+            }
+        }
+    }
+    return 1;
 }
 
 long do_rt_sigreturn(CPUXtensaState *env)
@@ -282,7 +360,9 @@ long do_rt_sigreturn(CPUXtensaState *env)
     target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
     set_sigmask(&set);
 
-    restore_sigcontext(env, frame);
+    if (!restore_sigcontext(env, frame)) {
+        goto badframe;
+    }
     target_restore_altstack(&frame->uc.tuc_stack, env);
 
     unlock_user_struct(frame, frame_addr, 0);
-- 
2.53.0


