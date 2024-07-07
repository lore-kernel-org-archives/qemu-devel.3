Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F94C3DA44
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 19:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQXIW-0000l8-Pf; Sun, 07 Jul 2024 15:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIV-0000kY-82
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIT-00057t-13
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70b09cb7776so1441094b3a.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720379499; x=1720984299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCBCigvlBMlmY53QeNLfiWH5Dizfub67u6tmw1h+Ik8=;
 b=mJ5dat3ElVBm7zU/K5HDV8JgfvQNNzIzXNatz0ngkSdzwTC9UHVL4ZmQOPvRLSGDuB
 eKXouoD30Dk28Gjn9uyPbsV4k4NfbzBMork0+fJL9CQYRscUi2xpPHgd2bnjYdcwU6Cx
 Nh3GljjAOzXFbQgEFnr5NRSXGjZU8HBSg9iAmTLZGZY2m7qInLze4/Q2A/lPuZKpbDRi
 isbOXlVgc2FJD3jQAq8EW/dUAmC2XuYucu6yFHd2c0ioH+1IaY3zPbXVwOCc7RahqHGN
 9lA3S9lJBXJnmD8S8UtFLo2+/uyaZRpfdpe5KCwJmWs2GNWgEhTG5nz7lN5f/r9I4b0A
 NonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720379499; x=1720984299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCBCigvlBMlmY53QeNLfiWH5Dizfub67u6tmw1h+Ik8=;
 b=OzO/XcuJnhixMzcUiOYY1vUbmwYRejkNRvIROEFdJfJ1IpcmCSLOmbIKa+PsKkIRLY
 74PBhqXr3ZF7cIz/GwKr7OsLnfs6h9v4bny/DrDIF0RExCF28YA2C/5gCIn1ilQcg5Oh
 gMWgvxX9InGMixfgqT2cPSEjiV/qk9hDCWKEoBzS2bYqX3zlHn5rYBZFYie/ZQAZG9Ye
 cG/K34zQLYiWrzlAG5tg70jGx4DnODn2d6UBtApbmaHRr+rRpwQcwP1zR2X3JMItbqeg
 aLSnelK8npuNeQxl4v1kzELNl8SVJELMfgnxirNUMMKQD9G33rAf9F3GpKxBQcMF6Y6X
 kaIw==
X-Gm-Message-State: AOJu0YyBud7AqZXIZOOjBebtso9SUZPEvhHIDcb73gSlfNsqAD0JGKmD
 YmgL0HFWD4dNoTUb3JOqMfNMpszM2zQp2+zpyCv/bA4Tz2OotT+fO+YrixNx
X-Google-Smtp-Source: AGHT+IGtMjVZ9yuHJHUd+95VYSAHndOwJ7sXf7c/6fTLCYLrhe3FIbFs6WglJck/lwK9T8OD3pK5vQ==
X-Received: by 2002:a05:6a20:1596:b0:1bd:2ce9:9e41 with SMTP id
 adf61e73a8af0-1c0cc8c95dfmr8392389637.46.1720379499106; 
 Sun, 07 Jul 2024 12:11:39 -0700 (PDT)
Received: from localhost.localdomain ([106.222.220.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac11d8a70sm172156725ad.118.2024.07.07.12.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 12:11:38 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Ajeet Singh <itachis@FreeBSD.org>, Kyle Evans <kevans@freebsd.org>,
 Sean Bruno <sbruno@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/8] bsd-user:Add CPU initialization and management
 functions
Date: Mon,  8 Jul 2024 00:41:21 +0530
Message-Id: <20240707191128.10509-2-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240707191128.10509-1-itachis@FreeBSD.org>
References: <20240707191128.10509-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Added function to initialize ARM CPU and check if it supports 64-bit mode.
Implemented CPU loop function to handle exceptions and emulate execution of instructions.
Added function to clone CPU state to create a new thread.
Included AArch64 specific CPU functions for bsd-user to set and receive thread-local-storage
value from the tpidr_el0 register.
Introduced structure for storing CPU register states for BSD-USER.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Kyle Evans <kevans@freebsd.org>
Co-authored-by: Sean Bruno <sbruno@freebsd.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/target_arch_cpu.c |  31 +++++
 bsd-user/aarch64/target_arch_cpu.h | 191 +++++++++++++++++++++++++++++
 bsd-user/aarch64/target_syscall.h  |  51 ++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch_cpu.c
 create mode 100644 bsd-user/aarch64/target_arch_cpu.h
 create mode 100644 bsd-user/aarch64/target_syscall.h

diff --git a/bsd-user/aarch64/target_arch_cpu.c b/bsd-user/aarch64/target_arch_cpu.c
new file mode 100644
index 0000000000..b2fa59efaf
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_cpu.c
@@ -0,0 +1,31 @@
+/*
+ * ARM AArch64 specific CPU for bsd-user
+ *
+ * Copyright (c) 2015 Stacey Son
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "target_arch.h"
+
+/* See cpu_set_user_tls() in arm64/arm64/vm_machdep.c */
+void target_cpu_set_tls(CPUARMState *env, target_ulong newtls)
+{
+    env->cp15.tpidr_el[0] = newtls;
+}
+
+target_ulong target_cpu_get_tls(CPUARMState *env)
+{
+    return env->cp15.tpidr_el[0];
+}
diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
new file mode 100644
index 0000000000..4e950305d3
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -0,0 +1,191 @@
+/*
+ *  ARM AArch64 cpu init and loop
+ *
+ * Copyright (c) 2015 Stacey Son
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_CPU_H
+#define TARGET_ARCH_CPU_H
+
+#include "target_arch.h"
+#include "target/arm/syndrome.h"
+
+#define TARGET_DEFAULT_CPU_MODEL "any"
+
+static inline void target_cpu_init(CPUARMState *env,
+    struct target_pt_regs *regs)
+{
+    int i;
+
+    if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
+        fprintf(stderr, "The selected ARM CPU does not support 64 bit mode\n");
+        exit(1);
+    }
+    for (i = 0; i < 31; i++) {
+        env->xregs[i] = regs->regs[i];
+    }
+    env->pc = regs->pc;
+    env->xregs[31] = regs->sp;
+}
+
+
+static inline void target_cpu_loop(CPUARMState *env)
+{
+    CPUState *cs = env_cpu(env);
+    int trapnr, ec, fsc, si_code, si_signo;
+    uint64_t code, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8;
+    uint32_t pstate;
+    abi_long ret;
+
+    for (;;) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        switch (trapnr) {
+        case EXCP_SWI:
+            /* See arm64/arm64/trap.c cpu_fetch_syscall_args() */
+            code = env->xregs[8];
+            if (code == TARGET_FREEBSD_NR_syscall ||
+                code == TARGET_FREEBSD_NR___syscall) {
+                code = env->xregs[0];
+                arg1 = env->xregs[1];
+                arg2 = env->xregs[2];
+                arg3 = env->xregs[3];
+                arg4 = env->xregs[4];
+                arg5 = env->xregs[5];
+                arg6 = env->xregs[6];
+                arg7 = env->xregs[7];
+                arg8 = 0;
+            } else {
+                arg1 = env->xregs[0];
+                arg2 = env->xregs[1];
+                arg3 = env->xregs[2];
+                arg4 = env->xregs[3];
+                arg5 = env->xregs[4];
+                arg6 = env->xregs[5];
+                arg7 = env->xregs[6];
+                arg8 = env->xregs[7];
+            }
+            ret = do_freebsd_syscall(env, code, arg1, arg2, arg3,
+                    arg4, arg5, arg6, arg7, arg8);
+            /*
+             * The carry bit is cleared for no error; set for error.
+             * See arm64/arm64/vm_machdep.c cpu_set_syscall_retval()
+             */
+            pstate = pstate_read(env);
+            if (ret >= 0) {
+                pstate &= ~PSTATE_C;
+                env->xregs[0] = ret;
+            } else if (ret == -TARGET_ERESTART) {
+                env->pc -= 4;
+                break;
+            } else if (ret != -TARGET_EJUSTRETURN) {
+                pstate |= PSTATE_C;
+                env->xregs[0] = -ret;
+            }
+            pstate_write(env, pstate);
+            break;
+
+        case EXCP_INTERRUPT:
+            /* Just indicate that signals should be handle ASAP. */
+            break;
+
+        case EXCP_UDEF:
+            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc);
+            break;
+
+
+        case EXCP_PREFETCH_ABORT:
+        case EXCP_DATA_ABORT:
+            /* We should only arrive here with EC in {DATAABORT, INSNABORT}. */
+            ec = syn_get_ec(env->exception.syndrome);
+            assert(ec == EC_DATAABORT || ec == EC_INSNABORT);
+
+            /* Both EC have the same format for FSC, or close enough. */
+            fsc = extract32(env->exception.syndrome, 0, 6);
+            switch (fsc) {
+            case 0x04 ... 0x07: /* Translation fault, level {0-3} */
+                si_signo = TARGET_SIGSEGV;
+                si_code = TARGET_SEGV_MAPERR;
+                break;
+            case 0x09 ... 0x0b: /* Access flag fault, level {1-3} */
+            case 0x0d ... 0x0f: /* Permission fault, level {1-3} */
+                si_signo = TARGET_SIGSEGV;
+                si_code = TARGET_SEGV_ACCERR;
+                break;
+            case 0x11: /* Synchronous Tag Check Fault */
+                si_signo = TARGET_SIGSEGV;
+                si_code = /* TARGET_SEGV_MTESERR; */ TARGET_SEGV_ACCERR;
+                break;
+            case 0x21: /* Alignment fault */
+                si_signo = TARGET_SIGBUS;
+                si_code = TARGET_BUS_ADRALN;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            force_sig_fault(si_signo, si_code, env->exception.vaddress);
+            break;
+
+        case EXCP_DEBUG:
+        case EXCP_BKPT:
+            force_sig_fault(TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->pc);
+            break;
+
+        case EXCP_ATOMIC:
+            cpu_exec_step_atomic(cs);
+            break;
+
+        case EXCP_YIELD:
+            /* nothing to do here for user-mode, just resume guest code */
+            break;
+        default:
+            fprintf(stderr, "qemu: unhandled CPU exception 0x%x - aborting\n",
+                    trapnr);
+            cpu_dump_state(cs, stderr, 0);
+            abort();
+        } /* switch() */
+        process_pending_signals(env);
+        /*
+         * Exception return on AArch64 always clears the exclusive
+         * monitor, so any return to running guest code implies this.
+         * A strex (successful or otherwise) also clears the monitor, so
+         * we don't need to specialcase EXCP_STREX.
+         */
+        env->exclusive_addr = -1;
+    } /* for (;;) */
+}
+
+
+/* See arm64/arm64/vm_machdep.c cpu_fork() */
+static inline void target_cpu_clone_regs(CPUARMState *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->xregs[31] = newsp;
+    }
+    env->regs[0] = 0;
+    env->regs[1] = 0;
+    pstate_write(env, 0);
+}
+
+static inline void target_cpu_reset(CPUArchState *env)
+{
+}
+
+
+#endif /* TARGET_ARCH_CPU_H */
diff --git a/bsd-user/aarch64/target_syscall.h b/bsd-user/aarch64/target_syscall.h
new file mode 100644
index 0000000000..08ae913c42
--- /dev/null
+++ b/bsd-user/aarch64/target_syscall.h
@@ -0,0 +1,51 @@
+/*
+ * ARM AArch64 specific CPU for bsd-user
+ *
+ * Copyright (c) 2015 Stacey D. Son <sson at Freebsd>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef BSD_USER_AARCH64_TARGET_SYSCALL_H
+#define BSD_USER_AARCH64_TARGET_SYSCALL_H
+
+/*
+ * The aarch64 registers are named:
+ *
+ * x0 through x30 - for 64-bit-wide access (same registers)
+ * Register '31' is one of two registers depending on the instruction context:
+ *  For instructions dealing with the stack, it is the stack pointer, named rsp
+ *  For all other instructions, it is a "zero" register, which returns 0 when
+ *  read and discards data when written - named rzr (xzr, wzr)
+ *
+ * Usage during syscall/function call:
+ * r0-r7 are used for arguments and return values
+ * For syscalls, the syscall number is in r8
+ * r9-r15 are for temporary values (may get trampled)
+ * r16-r18 are used for intra-procedure-call and platform values (avoid)
+ * The called routine is expected to preserve r19-r28
+ * r29 and r30 are used as the frame register and link register (avoid)
+ * See the ARM Procedure Call Reference for details.
+ */
+struct target_pt_regs {
+    uint64_t    regs[31];
+    uint64_t    sp;
+    uint64_t    pc;
+    uint64_t    pstate;
+};
+
+#define TARGET_HW_MACHINE       "arm64"
+#define TARGET_HW_MACHINE_ARCH  "aarch64"
+
+#endif /* BSD_USER_AARCH64_TARGET_SYSCALL_H */
-- 
2.34.1


