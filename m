Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0EFC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE0v-0006hP-DH; Mon, 16 Sep 2024 11:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE0s-0006Zk-TB; Mon, 16 Sep 2024 11:51:42 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE0r-0000Tg-9K; Mon, 16 Sep 2024 11:51:42 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-206f9b872b2so41786665ad.3; 
 Mon, 16 Sep 2024 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501899; x=1727106699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTvqmRJjCBmmQsqoIM7XAGZfiD8autBgUlGw18dRGRE=;
 b=RamcKIBnEaEngPmAbAvjx7/iAqCH7QvaivcQi7/hoeo00hCh0LCKTI10g33V0BAexG
 GxNufUfbEGobqR9lQVdyWhXvZZsQzsQqPjFNJ+UVRY8AeiiVFL1dcqY9mz9lNK3na8GK
 RHTbShMFjnnHcfbPOe+X2b8QE65D+P9o18Xwh/Fbm5HcMHMmxI0KNnToM6jUOb4CeWde
 7xpXQMeDZ8wqgz4ioh736HJTThcp0gdyNhbXc/D0tDLdB3TOYRceEIz0oX1DdyeGO9k/
 UBosZigybUI4B0i/jtLOlefGeGOhmQAKJ+sLTkGlAAYQot98B45Pya8+ZKkpdR62ra9A
 r0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501899; x=1727106699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTvqmRJjCBmmQsqoIM7XAGZfiD8autBgUlGw18dRGRE=;
 b=CCOblTx68PMAK41ez8JsA088iCnYHcChdDNBds3kIWQXIkB9C8MbvwK/4Fh3Op9fPm
 IjDHcbjq1TUVtZqdE1TGwGMaROJRfW2aGtAbhYMdp3WtNo9uyCSf3x9bcIvgHGhECbft
 XXQcL3mdn+5a3QHU8USPdLljCPa7l8A5G/1GCv6Up81mJa+MksIFvLKAEDL/hkiaB/hO
 G/SUmfbjJRe6F9SXP/X+bbM5yCZ8fAFTNzuiJGKjUM2s9bds1mLQh9XQNymJd0tXDlSW
 UDLzk1Xw90J452pMHFLRMVh/BiEMtgoNfDGe9fX/pSs2cKo0dkw0OPqSwkAGxqOwSGmx
 wSaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAu5EatYhICXqqI98bkkjPzR/xaQlbqdgTqQcOq4hHPCqY+uf92vFxevsb+T7ZNrIdc0aTNRxhUHzf@nongnu.org
X-Gm-Message-State: AOJu0YwQxwYbaCpeud89yW4qFRLXYVfPEpAgEy29WsQwFsd1rFOlLKJq
 krvLOk5Ta2iWc1j/+M8iplJJ9GZqGduq7FLT8N1erUJlLuQbz93NmCQGNHh1
X-Google-Smtp-Source: AGHT+IF9pU7/Z5xK+JkHH4+aN6lAbbuxA8xbDiGb0/8wVvgAUciROjQePtLbm8OXWdap21CL4vZ6oA==
X-Received: by 2002:a17:903:41cc:b0:207:6d2:2645 with SMTP id
 d9443c01a7336-2076e46177cmr234336705ad.47.1726501898795; 
 Mon, 16 Sep 2024 08:51:38 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:51:38 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 02/17] bsd-user: Add RISC-V CPU execution loop and syscall
 handling
Date: Tue, 17 Sep 2024 01:51:04 +1000
Message-Id: <20240916155119.14610-3-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
References: <20240916155119.14610-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x633.google.com
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
index f8d85e01ad..9c31d9dc4c 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -37,4 +37,98 @@ static inline void target_cpu_init(CPURISCVState *env,
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


