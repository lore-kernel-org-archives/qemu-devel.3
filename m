Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F09CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDsq-00032F-8w; Tue, 24 Sep 2024 18:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsn-0002ib-5g
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:45 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsk-0001jz-Vz
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:44 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7198de684a7so4534520b3a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216381; x=1727821181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzG01aHXw7yeNXEAJhp2gjtzILa7gZunpsgZJfY4oeo=;
 b=LQm1U0ggaz9phUVrakmOtv3L/9BKrFjjAUXItRXOu3awwsUyK8M3O/BdUtKk7TBo8H
 oJm5YT98NMcEwfpvIfZPKgnFEh6z/KlruCecDiFjQiscw0ssOvEfWIEpI/y5JNCVNSCK
 T1A/Gx/iZLBtqiAIXgqQgKd1nYtHexc63qgXhZNrlLXBWvnWOcZaMCaTK+WAKv0wjm3C
 JlKCcR/J9BYNKGOLh4go7167mlvwYU7WCjy/X71iFbsxcvHlptptaDE7l9PT9JDCr6yT
 iaI3Rza/4j03gghOYGJNk6NnYUQxIpogr7VoHakfK3KbBekgJuoTwhKZqUtzH/zfHgVG
 OkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216381; x=1727821181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzG01aHXw7yeNXEAJhp2gjtzILa7gZunpsgZJfY4oeo=;
 b=VHhwfvSBSJUesse+L9uZPS9UNZqWQbZ1gZp6X5B7hhLREDYFx7URnraEWm1koOF3LV
 vDriy94dY0XwlWmQPBVun43CFO85a8IXqaaRM4UA4HvOFwHl33c6dsC53VUKdUMjmzEF
 sRFCqEWp8S1m1/j4fP/yNEnJWHLA2mvWP1mNhC1J4ToW5/6a5AIahSzCeRj5KUAG5g3M
 pUQLay2tfGQnt34Mx5BV1gq7xeu4vicqPlxIwGWQSStUOt6IBZJbHUNOPWVyIOe4vOPS
 21hwYrbYD0xAkGQDAuKRMJHcM/WsxhGzCq1HZjIJSjn+gF/A7HiXP3dgEPnoK2XTKY4S
 yixw==
X-Gm-Message-State: AOJu0YwNt1wcmFnonrEklQamWf9SotIGRnTqI3n1oDdWHnxumO8Jx1vu
 y2fUxpElFKwjatxhMKwNbxsLLMQRDQk45jsonWdAavORatYdI+aTS4a7JA==
X-Google-Smtp-Source: AGHT+IEEb5v8r26HmfIh57cWIBH2h+wmcj6l1aPk/VkhfY37kYXYllKcybHp0b8g8rNoXFhxw4wevw==
X-Received: by 2002:a05:6a00:1798:b0:70e:a42e:3417 with SMTP id
 d2e1a72fcca58-71b0aab4686mr962136b3a.10.1727216381325; 
 Tue, 24 Sep 2024 15:19:41 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:19:40 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 32/47] bsd-user: Add RISC-V CPU execution loop and syscall
 handling
Date: Wed, 25 Sep 2024 08:17:33 +1000
Message-ID: <20240924221751.2688389-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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
Message-ID: <20240916155119.14610-3-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.1


