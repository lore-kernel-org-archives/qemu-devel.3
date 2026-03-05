Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB61F47CD4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFg6-0006ZD-MT; Thu, 05 Mar 2026 15:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg2-0006YG-Tf
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:10 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFfz-000666-Pw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:10 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-89a000f5adeso84692536d6.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743926; x=1773348726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31jlvN5wVwa4G/7vyDJs7qSCTlgMRWD/K+uKL2YBkfI=;
 b=vinssO22YF930Ag97yzyZzrNGHhoN8ByojUDIuYrJvXji6VBPnTZhb48y1EdSDjNZ2
 O7BGV4minj7ornjNF0XSOguSD2JJchmwe2d+Rm8ObZtMu3mYXM33mZXnliLmIPn4IsBr
 N/3YsKJgDh81l3hcKTCVBjPM+2bGenlBeUB0jmYf/Z0CyzKnDm0mmh4CT5eO8I9aKmDx
 Hsu1d20pkCnvB2zW+UQLqybkXDOl2BN0c7levTmZqaCFMPc7eZxKIkWxJxeJzxPh5DKI
 mquJgNu/6BUcxenxx+S9I0C7sKPu8u3yEjok7R6muhwmood0Z/G58jwwaAYYO+Hq2146
 FnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743926; x=1773348726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=31jlvN5wVwa4G/7vyDJs7qSCTlgMRWD/K+uKL2YBkfI=;
 b=EfGG5m25dV2BIXMuL6ld6kxQiW2aiNlCIqG9xRLZy8LjgFVcP2dpVod6i6zcMaCNRu
 S429V2ItUIeQ14KOyYD+MVF5Lt7h6kXeDW0im4sS3TaQa1EETjKSH24cs8sz/VSXFKS5
 Q7UKYJ/zQnTFGTc93ELZfMzvXRo78fYFb8ZEM0HX7ydRQ02mjer9SKsqTshbN6U+cbcS
 Ota+Dq/YPHG4R0n+jvBG762fddY6DkJaPujhG1mIgu3By74VPo3qF3yt8Kzsx1ptMAYb
 67+A1OvG+FNuXEYHG6mipCdP0LphxcmZYzUwysFPENi7I+vRrOTWM7Bkcdvjp2p9aAIH
 CW1Q==
X-Gm-Message-State: AOJu0Yw67MVEbl2Y4CyXcrWerL4DVSwX/Qd5PtWOMkYI3VmOOefxe45W
 y081H1v0U+ELmd1sRYM6mTjp4gAD1B4JLj1WnC96qhlmnRJs4G2KZQDBAfGgjZDWBXwei/NM/f9
 MxBih
X-Gm-Gg: ATEYQzwc00ZlrBEucs++ukfTJM4Lc4Xdgmb+MP3sLFycQHdIm9i+W4UhUlrarRziCES
 +o3F5E6zX5q3aOrfl77sLiQCgqRHDPRryG7S0+PWVtnzqHn0FDVJTbIfxZ8RhKKB0GJssEf+oas
 zAFEj8k7KmtG3Z1Cjt+lAh4UzmxGr+/WTMQbb3Y3tMaGmMLwDJGDAweMtZCZ6AFJyaeOV6A3jzL
 1fX7rxN/ANKgFZySsby0iQW1VQJpbOQw84Vt48J5DkeH3tlU/oRa01rkqzknvEqmJKzHWzb2mZB
 5U0sWzyqW6SxDzk6rNxO3Qa606tVpRawPh+Subo9KM8xiBEBJXGJvVYzoxwXtKY0ZgrtAEv7856
 L6wtmr22xmxlVARt38q8gt3YOOcTASZBhDiyktrtM21VFrO+Jv7Ewo6anhiDdl/yiGPAJvDLIdS
 7MLQ+kFa1snaof17aKBMT7vpFv8ofS5FQCxZmMSiBBrsRDM0p5M9yjaTeVm8JKXVdihC0PVS5sp
 LA4
X-Received: by 2002:ad4:5cc6:0:b0:89a:929:9e4e with SMTP id
 6a1803df08f44-89a1998b83dmr107621166d6.14.1772743925710; 
 Thu, 05 Mar 2026 12:52:05 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:05 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 03/12] linux-user: make syscall emulation interruptible
Date: Thu,  5 Mar 2026 12:51:43 -0800
Message-ID: <20260305205152.2121854-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf34.google.com
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

From: Florian Hofhammer <florian.hofhammer@epfl.ch>

The syscall emulation code previously wasn't interruptible via
cpu_loop_exit(), as this construct relies on a longjmp target that is not
live anymore in the syscall handling code. Consequently, longjmp() would
operate on a (potentially overwritten) stale jump buffer. This patch adds an additional
setjmp and the necessary handling around it to make longjmp() (and by
proxy cpu_loop_exit() safe to call even within a syscall context.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
Link: https://lore.kernel.org/qemu-devel/20260305-setpc-v5-v7-3-4c3adba52403@epfl.ch
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 linux-user/include/special-errno.h |  8 ++++++++
 linux-user/aarch64/cpu_loop.c      |  2 +-
 linux-user/alpha/cpu_loop.c        |  2 +-
 linux-user/arm/cpu_loop.c          |  2 +-
 linux-user/hexagon/cpu_loop.c      |  2 +-
 linux-user/hppa/cpu_loop.c         |  1 +
 linux-user/i386/cpu_loop.c         |  8 +++++---
 linux-user/loongarch64/cpu_loop.c  |  5 +++--
 linux-user/m68k/cpu_loop.c         |  2 +-
 linux-user/microblaze/cpu_loop.c   |  2 +-
 linux-user/mips/cpu_loop.c         |  9 ++++++---
 linux-user/or1k/cpu_loop.c         |  2 +-
 linux-user/ppc/cpu_loop.c          | 10 +++++++---
 linux-user/riscv/cpu_loop.c        |  2 +-
 linux-user/s390x/cpu_loop.c        |  2 +-
 linux-user/sh4/cpu_loop.c          |  2 +-
 linux-user/sparc/cpu_loop.c        |  4 +++-
 linux-user/syscall.c               | 16 ++++++++++++++++
 linux-user/xtensa/cpu_loop.c       |  1 +
 19 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/linux-user/include/special-errno.h b/linux-user/include/special-errno.h
index 4120455baaf..1db757241a3 100644
--- a/linux-user/include/special-errno.h
+++ b/linux-user/include/special-errno.h
@@ -29,4 +29,12 @@
  */
 #define QEMU_ESIGRETURN   513
 
+/*
+ * This is returned after a plugin has used the qemu_plugin_set_pc API, to
+ * indicate that the plugin deliberately changed the PC and potentially
+ * modified the register values. The main loop should not touch the guest
+ * registers for this reason.
+ */
+#define QEMU_ESETPC       514
+
 #endif /* SPECIAL_ERRNO_H */
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 7f66a879ea9..e7f643d69d5 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -181,7 +181,7 @@ void cpu_loop(CPUARMState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->xregs[0] = ret;
             }
             break;
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index f93597c400d..bef196b1f56 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -82,7 +82,7 @@ void cpu_loop(CPUAlphaState *env)
                     env->pc -= 4;
                     break;
                 }
-                if (sysret == -QEMU_ESIGRETURN) {
+                if (sysret == -QEMU_ESIGRETURN || sysret == -QEMU_ESETPC) {
                     break;
                 }
                 /* Syscall writes 0 to V0 to bypass error check, similar
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 40aefc4c1d7..19874f4c727 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -399,7 +399,7 @@ void cpu_loop(CPUARMState *env)
                                      0, 0);
                     if (ret == -QEMU_ERESTARTSYS) {
                         env->regs[15] -= env->thumb ? 2 : 4;
-                    } else if (ret != -QEMU_ESIGRETURN) {
+                    } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                         env->regs[0] = ret;
                     }
                 }
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 5711055aff2..9464246e9e3 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -56,7 +56,7 @@ void cpu_loop(CPUHexagonState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->gpr[HEX_REG_PC] -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[0] = ret;
             }
             break;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 972e85c487d..4b4b663052b 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -124,6 +124,7 @@ void cpu_loop(CPUHPPAState *env)
                 break;
             case -QEMU_ERESTARTSYS:
             case -QEMU_ESIGRETURN:
+            case -QEMU_ESETPC:
                 break;
             }
             break;
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index f3f58576af5..fe922fceb5a 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -181,7 +181,9 @@ static void emulate_vsyscall(CPUX86State *env)
     if (ret == -TARGET_EFAULT) {
         goto sigsegv;
     }
-    env->regs[R_EAX] = ret;
+    if (ret != -QEMU_ESETPC) {
+        env->regs[R_EAX] = ret;
+    }
 
     /* Emulate a ret instruction to leave the vsyscall page.  */
     env->eip = caller;
@@ -234,7 +236,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
@@ -253,7 +255,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 26a5ce3a936..603fcc39c7f 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -44,9 +44,10 @@ void cpu_loop(CPULoongArchState *env)
                 env->pc -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
                 /*
-                 * Returning from a successful sigreturn syscall.
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
                  * Avoid clobbering register state.
                  */
                 break;
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 2c9f628241f..b98ca8ff7b9 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -66,7 +66,7 @@ void cpu_loop(CPUM68KState *env)
                                  0, 0);
                 if (ret == -QEMU_ERESTARTSYS) {
                     env->pc -= 2;
-                } else if (ret != -QEMU_ESIGRETURN) {
+                } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                     env->dregs[0] = ret;
                 }
             }
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 78506ab23d9..06d92c0b90d 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -54,7 +54,7 @@ void cpu_loop(CPUMBState *env)
             if (ret == -QEMU_ERESTARTSYS) {
                 /* Wind back to before the syscall. */
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[3] = ret;
             }
             /* All syscall exits result in guest r14 being equal to the
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 2365de1de1a..fa264b27ec5 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -140,9 +140,12 @@ done_syscall:
                 env->active_tc.PC -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
-                /* Returning from a successful sigreturn syscall.
-                   Avoid clobbering register state.  */
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
+                /*
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
+                 * Avoid clobbering register state.
+                 */
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)-1133) {
diff --git a/linux-user/or1k/cpu_loop.c b/linux-user/or1k/cpu_loop.c
index 2167d880d55..e7e9929e6f5 100644
--- a/linux-user/or1k/cpu_loop.c
+++ b/linux-user/or1k/cpu_loop.c
@@ -48,7 +48,7 @@ void cpu_loop(CPUOpenRISCState *env)
                              cpu_get_gpr(env, 8), 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 cpu_set_gpr(env, 11, ret);
             }
             break;
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index b0b0cb14b41..1f9ee20bd0c 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -340,9 +340,13 @@ void cpu_loop(CPUPPCState *env)
                 env->nip -= 4;
                 break;
             }
-            if (ret == (target_ulong)(-QEMU_ESIGRETURN)) {
-                /* Returning from a successful sigreturn syscall.
-                   Avoid corrupting register state.  */
+            if (ret == (target_ulong)(-QEMU_ESIGRETURN) ||
+                ret == (target_ulong)(-QEMU_ESETPC)) {
+                /*
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
+                 * Avoid corrupting register state.
+                 */
                 break;
             }
             if (ret > (target_ulong)(-515)) {
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index ce542540c28..eecc8d15178 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -65,7 +65,7 @@ void cpu_loop(CPURISCVState *env)
             }
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[xA0] = ret;
             }
             if (cs->singlestep_enabled) {
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 4929b32e1fc..67d2a803fbc 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -83,7 +83,7 @@ void cpu_loop(CPUS390XState *env)
                              env->regs[6], env->regs[7], 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->psw.addr -= env->int_svc_ilen;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[2] = ret;
             }
 
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 0c9d7e9c46b..ee2958d0d93 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -50,7 +50,7 @@ void cpu_loop(CPUSH4State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gregs[0] = ret;
             }
             break;
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7391e2add8d..ab633eeae3f 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
                               env->regwptr[2], env->regwptr[3],
                               env->regwptr[4], env->regwptr[5],
                               0, 0);
-            if (ret == -QEMU_ERESTARTSYS || ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ERESTARTSYS ||
+                ret == -QEMU_ESIGRETURN ||
+                ret == -QEMU_ESETPC) {
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)(-515)) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d466d0e32f1..99e1ed97d9f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -43,6 +43,7 @@
 #include <linux/capability.h>
 #include <sched.h>
 #include <sys/timex.h>
+#include <setjmp.h>
 #include <sys/socket.h>
 #include <linux/sockios.h>
 #include <sys/un.h>
@@ -600,6 +601,9 @@ const char *target_strerror(int err)
     if (err == QEMU_ESIGRETURN) {
         return "Successful exit from sigreturn";
     }
+    if (err == QEMU_ESETPC) {
+        return "Successfully redirected control flow";
+    }
 
     return strerror(target_to_host_errno(err));
 }
@@ -14410,6 +14414,18 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
         return -QEMU_ESIGRETURN;
     }
 
+    /*
+     * Set up a longjmp target here so that we can call cpu_loop_exit to
+     * redirect control flow back to the main loop even from within
+     * syscall-related plugin callbacks.
+     * For other types of callbacks or longjmp call sites, the longjmp target
+     * is set up in the cpu loop itself but in syscalls the target is not live
+     * anymore.
+     */
+    if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
+        return -QEMU_ESETPC;
+    }
+
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index a0ff10eff82..d2b4ccdfade 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -186,6 +186,7 @@ void cpu_loop(CPUXtensaState *env)
                     break;
 
                 case -QEMU_ESIGRETURN:
+                case -QEMU_ESETPC:
                     break;
                 }
                 break;
-- 
2.47.3


