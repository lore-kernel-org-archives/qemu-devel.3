Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037D6CD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smlzN-000398-Ld; Fri, 06 Sep 2024 23:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzH-0002xk-CH
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzF-0004qf-EH
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2053a0bd0a6so29768375ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679183; x=1726283983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoqI+GcSD10KH5RTtszxpTTAXwPzAPqtWGKQJfPieeI=;
 b=Pz7cBylT0LyCPEbwPSoqXDdVS+m/RaIYfcLC69kCqj5zjBqSOvUnzV6WUHt2gds0Fg
 Tw1MV0OaqkOuWBBOqcVdpeHrBr2wKraWshGLy/Kz11ahOX24u0edB9wuS5VtY6T4mkjd
 wDNsiQStNB/ALVpAgKsnIUbb1NAh+ReJcMhCb7lcd+K496fm2SK1VT7QW8o1mKkogK8o
 Z1g3ZZHqxXglnb6hBuLExO1TE1YEfocffY5PDj4ibDSdGfkK7dnJQZ6g5oqxLnbJBmoR
 jMuk4hfkQ81Je8PKcwg5YYv1sKuNeJ9NABX0zEyejo6eflkV2b/0Yq23R1oHdCIUTPE3
 JQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679183; x=1726283983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qoqI+GcSD10KH5RTtszxpTTAXwPzAPqtWGKQJfPieeI=;
 b=Fd6J5mFzEUeSLqayiUJhKj3vivncd0qvKtl1EbHAqzCl2TFIdsQvjLZuUSoV3b0JVO
 rfj5iJ0m2LiNykI9jKnxp6h77wEyHmXbMr6rL7VYo1q7IBaL0e9idbhacm1g2LAF/fAQ
 YNcqNkLgdRT1K28iq5gzt8nl/JUssiNRWv2uObs8z5K9/Nmt019gCLeK/IQ76Hl4oOxB
 IORKsk9k+1EO9xUcXflPSL4WvFRHktTP0RvYCWKsr2waWd+FRnH2u9+WaFn4qye+0pdg
 +9vt+DNTvMEyh0p+0/Iaa1vb4MjTmAS/omUvRFFOcbTRp0kp2R42wigPq59Hi/A+Ol6/
 eoBA==
X-Gm-Message-State: AOJu0YwhC+M3Bom0woOxg38+cjJJo0QZQg8g0QTLD/TfYfHOV36axYN7
 eGfUGB7cEqMbAeoq9aEx29B6/X/crPtVtnhMAuzA4FhJxc2hMiYqkR3eJo9H
X-Google-Smtp-Source: AGHT+IEN+8AFlk71jBgNBcQtyEne8mptmnoBTjCRvrYTgw+a/DUOd2itX5oFmhdYiHSTHrsEQZeniw==
X-Received: by 2002:a17:902:e550:b0:1fd:9a23:90cc with SMTP id
 d9443c01a7336-206f052e09bmr52678905ad.26.1725679182823; 
 Fri, 06 Sep 2024 20:19:42 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:19:42 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 02/17] bsd-user: Add RISC-V CPU execution loop and syscall
 handling
Date: Sat,  7 Sep 2024 13:19:12 +1000
Message-Id: <20240907031927.1908-3-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62a.google.com
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
index e17c910ae9..ea2a8d1ace 100644
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
+            syscall_num = env->gpr[xT0];
+            env->pc += TARGET_INSN_SIZE;
+            /* Compare to cpu_fetch_syscall_args() in riscv/riscv/trap.c */
+            if (TARGET_FREEBSD_NR___syscall == syscall_num ||
+                TARGET_FREEBSD_NR_syscall == syscall_num) {
+                ret = do_freebsd_syscall(env,
+                                         env->gpr[xA0],
+                                         env->gpr[xA1],
+                                         env->gpr[xA2],
+                                         env->gpr[xA3],
+                                         env->gpr[xA4],
+                                         env->gpr[xA5],
+                                         env->gpr[xA6],
+                                         env->gpr[xA7],
+                                         0);
+            } else {
+                ret = do_freebsd_syscall(env,
+                                         syscall_num,
+                                         env->gpr[xA0],
+                                         env->gpr[xA1],
+                                         env->gpr[xA2],
+                                         env->gpr[xA3],
+                                         env->gpr[xA4],
+                                         env->gpr[xA5],
+                                         env->gpr[xA6],
+                                         env->gpr[xA7]
+                    );
+            }
+
+            /*
+             * Compare to cpu_set_syscall_retval() in
+             * riscv/riscv/vm_machdep.c
+             */
+            if (ret >= 0) {
+                env->gpr[xA0] = ret;
+                env->gpr[xT0] = 0;
+            } else if (ret == -TARGET_ERESTART) {
+                env->pc -= TARGET_INSN_SIZE;
+            } else if (ret != -TARGET_EJUSTRETURN) {
+                env->gpr[xA0] = -ret;
+                env->gpr[xT0] = 1;
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


