Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5485CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKpX-0004Gs-Bq; Wed, 10 Jun 2026 11:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wXKpV-0004GI-RY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 11:26:57 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wXKpU-0006PC-6X
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 11:26:57 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7dc6fbf3e86so73682097b3.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781105215; x=1781710015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/heamZD5FySft1PPbwb+WuDt6wl2aG464IoZc2T/Ivg=;
 b=SoCoQ9CGRXQmlIXsULllp1ExR0bOIHaZMtxVvd3hDGMRCywrKT8hs7FlKts0C1i9dj
 5O4/tf94MjPKf48KweJVSDH7T7/e8zRHiukkr4ZFicaLXWGdmzZrA595XdNRoODOPx0v
 qtSKRSIFQblbz3Uo9lsOAHVTJPqou68LhATPn9G6JWlnRX2o2vZjmLdbqotlpz+shFWN
 mbndc9Vir4Xt9xkXi+N7g9oB3B9D3yLdeUBaW7xxpFdXFcRfCPvDrwqUMC3cAdNKnh1u
 feELiqz8+jPd5lHAXF83xX1ljqEJdPixlFnQ5pHO2UXUwm5myOC9nnGu8ICJa7a7yBOw
 O2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781105215; x=1781710015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/heamZD5FySft1PPbwb+WuDt6wl2aG464IoZc2T/Ivg=;
 b=mwMRkVy8HHvIiLt5LMbGely19CFuUsL+RIzxrzfoD6YA9L7VvTp18sRh5GZIx8Rcg2
 NcLNkFy2SgmeGNwTj7Pam4ojanFSV4iqwcFxJsrp0aqYZpyFAkdPNZlLMTgO1rlzlhtZ
 F50pO69EQyNItcWCRk2XtIyCKR5uPA1ik0fjWEMzFIcG1iQfWPjXL1Q/6UVOAHFHms4q
 YsA1Q6jjwBoMSNy5hShQboyP/vkz+34XxmsGU3zTzJMGY61QyoiQwAwM2cRMmliUbjvx
 d5NQ31Pv3VjpxdNpv3vAr8X8c2D0TCshzSb1zhwtR/iruHZO8b3jGDh2xRMmirPzxEf9
 no1Q==
X-Gm-Message-State: AOJu0YwYt9wNbV9omTcLO6H1aU20ncRdtuXBjTD8wcc5OsmLWIiMgpbO
 WieidXi1txUh38lFyczFGTTNOzLmgCPm2yl3/1l2L/OfUKMKq2W8+oUSCf7fiQ==
X-Gm-Gg: Acq92OFwt3Hnbx3Bww460MvB+6HDq3fi/vuCaMG3ARod++XcjAolvsprwDtOB9XIrX3
 8WPP8Evxzc0XBag/RaSa5Z3iFRg3CsFtKzqj43se2ZR5e800+ND3uAxFoJATS/cS0M612lAbrfs
 8mJy7wyMyQG6WtGkQH2EbaR1HIAGJi8OA+EIU+fNXChZ+qTn35uHp/F8T/XWPRDXrPbLr0Cq0A6
 0CP8knx+ldHMj4AkwS20amkZigqv9XoCgQurKGqhIwBl67KTi3uhrWfbV6lhZ9rFKXU3hBjjP+K
 nBzsEX6qLU8gW5CTwRhEQpLZxAPbdcT0Dy1FBJxNkIYC1mGiPeRO3jd75YPFI3gIMKXVtSZBptB
 HFYq/uk+LGpVN35KiRNUZzAa7w2HzpxtnaumYtcVAT+qCkjW+8uBmo0bwsey77PyGpujjjvFLi1
 0GdG9ZS7lig4Tg3bpS3ijMAw+vUB0cKUQZ/w==
X-Received: by 2002:a05:690c:dc4:b0:7db:ccda:a40a with SMTP id
 00721157ae682-7ed0ef49f3bmr278061387b3.15.1781105214702; 
 Wed, 10 Jun 2026 08:26:54 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea23a9a421sm111981727b3.39.2026.06.10.08.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 08:26:54 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH 2/2] linux-user/xtensa: save/restore FP registers across
 signal delivery
Date: Wed, 10 Jun 2026 11:25:37 -0400
Message-ID: <20260610152648.677463-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610152648.677463-1-mattst88@gmail.com>
References: <20260610152648.677463-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112a.google.com
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

The Xtensa FCR rounding-mode (RM) bits are not held only in
env->uregs[FCR]: they are also reflected into env->fp_status via
set_float_rounding_mode().  Similarly, FSR exception flags are mirrored
into env->fp_status.  Every write to FCR/FSR goes through
helper_wur_fpu{2k,}_fcr / helper_wur_fpu_fsr which keep the two in sync.

restore_sigcontext() previously wrote nothing back for xtregs, leaving
env->fp_status with whatever rounding mode and exception flags the
signal handler last installed.  Any FP instruction in the interrupted
code could then operate with the wrong mode.  FP data registers f0-f15
were also not saved, so any FP operation in the signal handler would
silently corrupt them.

Add target_xtensa_xtregs_fp (f[16] as float32, FCR, FSR) for
XTENSA_OPTION_FP_COPROCESSOR cores (e.g. dsp3400) and
target_xtensa_xtregs_dfp (f[16] as float64, FCR, FSR) for
XTENSA_OPTION_DFP_COPROCESSOR cores (e.g. de233_fpu), unioned in the
signal frame.  setup_sigcontext() saves all FP registers and points
sc_xtregs at the sub-frame.  restore_sigcontext() restores f0-f15 then
calls cpu_set_fcr()/cpu_set_fsr() so fp_status round-trips correctly
across signal delivery.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Worth noting that the ABI layout issue remains open: QEMU's xtregs
structure is self-consistent but doesn't match the real kernel's
core-specific opt+user+cp layout, and fixing it properly would require
exposing the XCHAL SA list sizes in XtensaConfig.

 linux-user/xtensa/signal.c | 73 +++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git ./linux-user/xtensa/signal.c ./linux-user/xtensa/signal.c
index ef8b0c3a27..b8d73468d0 100644
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
@@ -266,7 +300,36 @@ static void restore_sigcontext(CPUXtensaState *env,
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
+                uint32_t fcr, fsr;
+
+                for (i = 0; i < 16; ++i) {
+                    __get_user(env->fregs[i].f64, &frame->xtregs.dfp.f[i]);
+                }
+                __get_user(fcr, &frame->xtregs.dfp.fcr);
+                __get_user(fsr, &frame->xtregs.dfp.fsr);
+                cpu_set_fcr(env, fcr);
+                cpu_set_fsr(env, fsr);
+            } else if (xtensa_option_enabled(env->config,
+                                             XTENSA_OPTION_FP_COPROCESSOR)) {
+                uint32_t fcr, fsr;
+
+                for (i = 0; i < 16; ++i) {
+                    __get_user(env->fregs[i].f32[FP_F32_LOW], &frame->xtregs.fp.f[i]);
+                }
+                __get_user(fcr, &frame->xtregs.fp.fcr);
+                __get_user(fsr, &frame->xtregs.fp.fsr);
+                cpu_set_fcr(env, fcr);
+                cpu_set_fsr(env, fsr);
+            }
+        }
+    }
 }
 
 long do_rt_sigreturn(CPUXtensaState *env)
-- 
2.53.0


