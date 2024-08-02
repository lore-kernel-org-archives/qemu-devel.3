Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314A8C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkL-0007Kp-Oh; Fri, 02 Aug 2024 04:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkJ-0007B8-Cf
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkH-0006QE-MR
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:43 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70eec5f2401so5131345b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587680; x=1723192480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqP2HRfmEKXhwmwZ84x84Ag03XjyC0nsXMjh0MRN8OE=;
 b=OlTqw5AKH/K1zjJtK5mrcs7UZ4BWgbf+CChFtU1Js/c67APWGATN3+/P8Gy8qeUGg1
 AnOG0k8aJq99LYlg0gzXmkmspkQ45wMN4nDPMpsl9dvG50Pqy3grDyK1q1kBLsXIQaLc
 fUg9/pppOYldiRVVCiDPU/2acYoLnLcVbPmh9NE+tzBzAIuByaGTTc5ahN0ELtzRqTRG
 ZKVWTMKsV0RL7fqpPm0D6V+5m0m0ODkVhbjSOfSmJWBQvag4kgDMJI95JwLqzm6DlNwb
 4Emrb8ZPn+mR1KnLJBiiQeDnMsoBoW0goQOKz4ykCpAsebkACllOMfo5cog2RErQ94hQ
 Rw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587680; x=1723192480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XqP2HRfmEKXhwmwZ84x84Ag03XjyC0nsXMjh0MRN8OE=;
 b=v50+qDJhtoTdbd5UIOZYMJl1vk4LIc+o7a/8HjVwAOUEhRh/YN62Kxy1D69VEvI6Wx
 VH3UsIYEz8mRavsMAINX8/fi+CNw5vQaoxFyu0NVjqgWnn4JuzMqtRfjlb6wNPhW/eO9
 0TypAD1TQQPuBrK1ZukSavNd+RaOJ1+xEMNpUf8pzLWR8PKBIyQruNnule39uwcn1a5d
 wQx1HPTHSKAmGJ5qxGsd6JI8djKFqVR+9FRDEFpMSrCdN9fnJ1ZQb303wFLFMX3dbtji
 GAUsaPQ75Qhl6+YLyl+JtuGUUO0e99EXr3ipWK9w2LQERunuVQ99jPB+zg/4JvcQnoIj
 1LNg==
X-Gm-Message-State: AOJu0Ywao1JY5h2Y3KR2QlcJ6mceFlzCoJSy4bVB/nIYR8nwQ9kmg8aH
 s++9/SxlhzSipCNDASyQ4LHT+oHrozaMyz/98GvDkWMJMrMDf6fIcGh11x1UbZM=
X-Google-Smtp-Source: AGHT+IHdl/mr9NWFBXU8mf+TmTu4XNupoLSHIdsg9DPQ2CLYH0eG9Yzp/y3wNvoiRhkQnAXs1jirCA==
X-Received: by 2002:a05:6a00:4b11:b0:70d:2b95:d9c0 with SMTP id
 d2e1a72fcca58-7106cfd2249mr3882858b3a.14.1722587679998; 
 Fri, 02 Aug 2024 01:34:39 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:34:39 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH 02/18] bsd-user: Add RISC-V CPU execution loop and syscall
 handling
Date: Fri,  2 Aug 2024 18:34:07 +1000
Message-Id: <20240802083423.142365-3-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42b.google.com
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

From: Mark Corbin <mark.corbin@embecsom.com>

Implemented the RISC-V CPU execution loop, including handling various
exceptions and system calls. The loop continuously executes CPU
instructions,processes exceptions, and handles system calls by invoking
FreeBSD syscall handlers.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
---
 bsd-user/riscv/target_arch_cpu.h | 94 ++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index 28f56560e0..5b436b2ac9 100644
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


