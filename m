Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB7DC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYk-00044W-0H; Mon, 17 Jun 2024 14:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYj-00042K-2d
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:29 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYh-0004wP-8M
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:28 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-704189f1225so4131483b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650705; x=1719255505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXJTs0J9+UWD2AkXsLlcdFj04Dwj/u1B6kCGoJ8H+e8=;
 b=D5zkQnmuYOaXmsFgffK3pY2E7kvLCYl6bdTjhztEPNfY7ci3jfpHMqpcR2GGHFblUi
 3E3bito/vmQ99yc4Rshpj/3TzOVPbDpy5cFpVgv35ABRgSVmkCsHQ3SXXJyAEfABtUS4
 KNuBgRc9Th3cg+c+pLSQKVbTYXgw+xBbac/Df6vvulX8Sf3gI/YGtlNwYHmuOpCgj83H
 oUdW/27c3GcvR5z8Ks8hXCYWtVhyPPE2eYtFYgGUAkgeXv5Z/xFeeSsupxwQe3D3gsvW
 olFXdRuNJFOad/1XW5uJZRCndrxOXFZpd9NGM/ha59AdTwBu4vnBlj9Yw4oANrT+J+wH
 ZgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650705; x=1719255505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXJTs0J9+UWD2AkXsLlcdFj04Dwj/u1B6kCGoJ8H+e8=;
 b=ZB8G1SaMVwTKJtRX8ae+6ykA2c2Kp3qhIzC8IF3K4JkbKCsGf5+l63nLMjIboY9a2Z
 GkE/uuhUqPBtSnbFYGXzfjtld2xFb67ve2DUZvytUaxzxVeRw/g9m0NPSr75kEpicOHL
 ZHdBo0oxKd7kOxhkK3W8GtII5+I8abCyL/rrng24PR96EEFVm/DiPg5ZXSXDVqM5Klrc
 6GFtvZjB//5xR30RqX9C/ZjJKyWrZD6KmL5PAjdSQ5Sofbui37vGBMCRmpwU5SHMbGnK
 J/heFHaQGYILGRbd/6bBPC0UerovEAybYV/qA/QmOM7VNqyIHnla7ilokbGP/gMZmH0U
 B6lg==
X-Gm-Message-State: AOJu0Yx2wG3uRr/gGufx19THYh9jYxYJHn3hOU23tqJ7YGzgn7XCSuK7
 o4gPHoXiwsRh33wy7qI7YiU2/WtROXL/TblydyRuczOIM2VEp1Aa9swCdhAk4Gc=
X-Google-Smtp-Source: AGHT+IF9YCPk869H7ThvJc0nHDnSauwHqFWHmlzQDT8wBpY6zC6pDQldExWTVNIpbwmLdyTx/1mzHA==
X-Received: by 2002:aa7:8e92:0:b0:705:a450:a9a9 with SMTP id
 d2e1a72fcca58-705d70e3e1emr10489681b3a.1.1718650705172; 
 Mon, 17 Jun 2024 11:58:25 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:24 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Kyle Evans <kevans@freebsd.org>, Sean Bruno <sbruno@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 02/23] Added CPU loop function
Date: Tue, 18 Jun 2024 00:27:43 +0530
Message-Id: <20240617185804.25075-3-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Stacey Son <sson@FreeBSD.org>

CPU loop function to handle exceptions
and emulate execution of instructions

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Kyle Evans <kevans@freebsd.org>
Co-authored-by: Sean Bruno <sbruno@freebsd.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 bsd-user/aarch64/target_arch_cpu.h | 132 +++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
index db5c7062b9..1962d2c99b 100644
--- a/bsd-user/aarch64/target_arch_cpu.h
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -40,3 +40,135 @@ static inline void target_cpu_init(CPUARMState *env,
     env->pc = regs->pc;
     env->xregs[31] = regs->sp;
 }
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
+#endif /* TARGET_ARCH_CPU_H */
-- 
2.34.1


