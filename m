Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2EFC3ABA5
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr8l-0005gd-JL; Sun, 15 Sep 2024 11:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8i-0005Wl-QB
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8h-0008AB-8I
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20696938f86so29635155ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726413973; x=1727018773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoqI+GcSD10KH5RTtszxpTTAXwPzAPqtWGKQJfPieeI=;
 b=fKkOlI1bmWl3WS0NjnQrM0LV1dFB6hirV+CJVGHoUKJdGIeUQpfP/5qA5GzeEHkQo7
 IMwGUkZ68PFgW8tBsXsi76gtgsggFfgRbvfEpAw4ctgyGxwu9Z/0JDq6xOQ63lJMwOjF
 SGC5xFmTZUAPhN35+2MuIkI632KL0F5P2pKnUsYBo6FIEpd2da8PTSfbO8U8sMMuh++e
 fDErpUL991k9+sa3LwaoMo306mHfnimcKEhFEm1tj1esdF+Rgey4VTu5UqbplcBb8nbX
 lYhEA73Kv8DVkSmtMiJTL/zWIrXtppp/a09cgaMv92sDXUHjxZ7CwbYbvZ0kJWLmU8MK
 sdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726413973; x=1727018773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qoqI+GcSD10KH5RTtszxpTTAXwPzAPqtWGKQJfPieeI=;
 b=neJot/w2ESjkhaBCdRksi2bkVFFk89tYPkxuYI5G8sFZrTX9BODAeXVsj2jCwYNwGl
 RI///xcj+ePb1SVOftWsftb3Z6a7kMgf6kTYVjX+j0kQ579jO4bFbTYk+H1suGJWBjik
 aYGggY+Rsu2LtMkFKm2ysPqimwAXak3hPjtFHEDhL2sNoFaAUup1Ct9gTAP8iT/YoqkM
 /RhL8XGnhpCUpW2F/1nw2/gaF+FJCmNFEOfBMYCkVbSxnrvJlWA6OZrtmV7G9aUqRjRe
 Hb4r1h4dd1dStSKioN0L6QnJ1YTxNYjAPcf1ORbE8qzZYR/RGNKuFL3XN1jOKiRxaPEz
 kAIg==
X-Gm-Message-State: AOJu0YxhUbfv/A62tBaxV/yXAWDl/UjMagwFNQmgvipVNK0SULU+gDDO
 P7oPoByaGC45m/2OBoiOzyf/CnJwElEwaeQE2iK50UASdF/vVt+d5Fe+OqUS
X-Google-Smtp-Source: AGHT+IHO9pFIXm7amjysosxqUs6kD+WxMWaHhMRQmGJ4+VNXyJ01PHzUC3tTNSnzShnv8MCzboszQQ==
X-Received: by 2002:a17:903:2306:b0:206:c75a:29d4 with SMTP id
 d9443c01a7336-2076e43eee4mr204994325ad.50.1726413973305; 
 Sun, 15 Sep 2024 08:26:13 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:12 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 02/17] bsd-user: Add RISC-V CPU execution loop and syscall
 handling
Date: Mon, 16 Sep 2024 01:25:39 +1000
Message-Id: <20240915152554.8394-3-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x636.google.com
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


