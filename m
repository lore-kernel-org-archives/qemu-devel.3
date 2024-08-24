Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CB0C54731
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 04:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shipd-00068J-EE; Sat, 24 Aug 2024 00:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipb-000622-M9
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:56:55 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipa-0002EX-3L
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:56:55 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5d5b850d969so1918308eaf.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 21:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724475412; x=1725080212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHayX5ojJN5/ahyBORPFkIjjx3JTNZK/Yv3Y1gMyMGw=;
 b=A6KqbVz3xd253HtSiKjauQyqZg0MlX1r8y4IOFsNPqc8l+LGO6vYfhsLpJuqU3+qio
 jdOofypMsHPXg96kWAVtkEu0UOnQPKdM75h4M8W03a6UueAWbymlMKryX/yEX9gleopT
 853zj/ynVfXvMX0PpsKJ5P11z7kKqvmwCRAIKmIDFZi9FNt0Fmz5t2Dg+0I+5WjLBtyQ
 bv7estiAj7WSVOpx2l/o8njfwpaQ3ava/kaEemOxTbb6JA9LodCJmpoNJeuVR8JnErb7
 y/nJ2oe27DM2ePbAsND40p5o8JFWt+bjEcFDr3JXBn+Re7f2oN3QwHe6BCfce/Sy/3j8
 5G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724475412; x=1725080212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHayX5ojJN5/ahyBORPFkIjjx3JTNZK/Yv3Y1gMyMGw=;
 b=GbOBoUJeNt3D9IELma0WDdVl6Y+jRASmusZS6BzmmNn+Jf+UTN0wUFerofIXuHJMs4
 uOQvQGfWqZAIREo7B6+/hcW6qrfB8TdwFGrPXb/1UUdqTlEuLGeeT0QpQiPA78ROlTKL
 iJdXphsQbZMPdq70Yj4c2kJ8h+waPgyZidCDG110fkHITdjIZQzzwfNbFBxcavm3eXwg
 O0Wq56QVDp2QwoQCit+4NfC02AGPDNnFEmoFCbJPdSpqls4Vwk1IvYqGHkeubnDTBm2l
 Y937EooGveA900YD0RwSPtyoTeptN574OtjfuoWi6si566+PV08Fb3dYP3wLnJWdzYGp
 E3Hw==
X-Gm-Message-State: AOJu0YxR8kGby8qsPSTxDzKo9TT07HXmKdHNyNmTv9IK233MCfuwLgMO
 egM/gNaU7jNWBQdomsl0/pnLRIu+pt5gLtyY3T+1NOdSJopZQ6NooqMUbg+2PSU=
X-Google-Smtp-Source: AGHT+IEj/RAL1erF/4+uqPWjU2yLO6irBlqlEoQ5ZAXbSfyCVtKoaGRngg+60On/7cgTQLpatj7C6A==
X-Received: by 2002:a05:6358:948f:b0:1a6:799b:b06c with SMTP id
 e5c5f4694b2df-1b5c21ede3amr580932055d.23.1724475412244; 
 Fri, 23 Aug 2024 21:56:52 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ecedsm3805934b3a.25.2024.08.23.21.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 21:56:51 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 02/17] bsd-user: Add RISC-V CPU execution loop and syscall
 handling
Date: Sat, 24 Aug 2024 14:56:20 +1000
Message-Id: <20240824045635.8978-3-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824045635.8978-1-itachis@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=itachis6234@gmail.com; helo=mail-oo1-xc2d.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Implemented the RISC-V CPU execution loop, including handling various
exceptions and system calls. The loop continuously executes CPU
instructions,processes exceptions, and handles system calls by invoking
FreeBSD syscall handlers.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_cpu.h | 94 ++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index e17c910ae9..eb37b062a3 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -36,4 +36,98 @@ static inline void target_cpu_init(CPURISCVState *env,
     env->pc = regs->sepc;
 }
 
+static inline void target_cpu_loop(CPURISCVState *env)
+{
+    CPUState *cs = env_cpu(env);
+    int trapnr;
+    abi_long ret;
+    unsigned int syscall_num;
+    int32_t signo, code;
+
+    for (;;) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        signo = 0;
+
+        switch (trapnr) {
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        case EXCP_ATOMIC:
+            cpu_exec_step_atomic(cs);
+            break;
+        case RISCV_EXCP_U_ECALL:
+            syscall_num = env->gpr[xT0]; /* t0 */
+            env->pc += TARGET_INSN_SIZE;
+            /* Compare to cpu_fetch_syscall_args() in riscv/riscv/trap.c */
+            if (TARGET_FREEBSD_NR___syscall == syscall_num ||
+                TARGET_FREEBSD_NR_syscall == syscall_num) {
+                ret = do_freebsd_syscall(env,
+                                         env->gpr[xA0], /* a0 */
+                                         env->gpr[xA1], /* a1 */
+                                         env->gpr[xA2], /* a2 */
+                                         env->gpr[xA3], /* a3 */
+                                         env->gpr[xA4], /* a4 */
+                                         env->gpr[xA5], /* a5 */
+                                         env->gpr[xA6], /* a6 */
+                                         env->gpr[xA7], /* a7 */
+                                         0);
+            } else {
+                ret = do_freebsd_syscall(env,
+                                         syscall_num,
+                                         env->gpr[xA0], /* a0 */
+                                         env->gpr[xA1], /* a1 */
+                                         env->gpr[xA2], /* a2 */
+                                         env->gpr[xA3], /* a3 */
+                                         env->gpr[xA4], /* a4 */
+                                         env->gpr[xA5], /* a5 */
+                                         env->gpr[xA6], /* a6 */
+                                         env->gpr[xA7]  /* a7 */
+                    );
+            }
+
+            /*
+             * Compare to cpu_set_syscall_retval() in
+             * riscv/riscv/vm_machdep.c
+             */
+            if (ret >= 0) {
+                env->gpr[xA0] = ret; /* a0 */
+                env->gpr[xT0] = 0;   /* t0 */
+            } else if (ret == -TARGET_ERESTART) {
+                env->pc -= TARGET_INSN_SIZE;
+            } else if (ret != -TARGET_EJUSTRETURN) {
+                env->gpr[xA0] = -ret; /* a0 */
+                env->gpr[xT0] = 1;   /* t0 */
+            }
+            break;
+        case RISCV_EXCP_ILLEGAL_INST:
+            signo = TARGET_SIGILL;
+            code = TARGET_ILL_ILLOPC;
+            break;
+        case RISCV_EXCP_BREAKPOINT:
+            signo = TARGET_SIGTRAP;
+            code = TARGET_TRAP_BRKPT;
+            break;
+        case EXCP_DEBUG:
+            signo = TARGET_SIGTRAP;
+            code = TARGET_TRAP_BRKPT;
+            break;
+        default:
+            fprintf(stderr, "qemu: unhandled CPU exception "
+                "0x%x - aborting\n", trapnr);
+            cpu_dump_state(cs, stderr, 0);
+            abort();
+        }
+
+        if (signo) {
+            force_sig_fault(signo, code, env->pc);
+        }
+
+        process_pending_signals(env);
+    }
+}
+
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.34.1


