Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AE0C54E75
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMU-00020o-Qi; Wed, 28 Aug 2024 05:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMM-0001vc-Qh
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMK-0001nq-Np
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:02 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7142448aaf9so316332b3a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838779; x=1725443579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ea8ovjK2oeupU9Y/oJRULt03XSKHKyefcQa3mNq/zsw=;
 b=kMZ1rcs5PKdGVIpFyASkOPvxGcgLZYLXWqnVdpcMTxuu4RDT8bzurduTWTJjMRzOW+
 CQo3bOMCRRTmFKClBwbgxgzzpMp5ySALry2uWoUAAcrmaPuaUy48KVE2sD45r8mrPCWz
 m5ckvUpSnRAwTWAzbhI1ol+q9B4OQTArJfDQV/Z1W4+ylNDWxmzDuIHe98AV8XztBnnI
 rCcdW9TO6wqrbZp92wly1DH7dhHGZWHjWUndwgccsto7IgGQn7WpaAyuH8tHWHYK2ZS4
 dWo4Kv2sS7KzSsHEJnci1BG3FiXg1nXBVeMT5pRnpIuALQG4+WRPyb7D8rsrX9ymYQC5
 HXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838779; x=1725443579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ea8ovjK2oeupU9Y/oJRULt03XSKHKyefcQa3mNq/zsw=;
 b=f/JwWj6pHTWUnbRYDN2N+H878WVIGnwjdwd9E0XYgVXytP4ZKgLcwq5FvKlh3gTz6v
 sfe+cN1h71DecQdTIrrSBPYi0BFHudv1hWhW16ROlPI4TOoBa9mT7vCA1fcWGwJKnJBV
 5aUKzcVhKzhWW+nvMylEiyKz9rIvwMLBoRHHmBxwz+1P/1f/eBAwNLrFT72A5W1WlFA4
 gBQlyoJTPi7eshuK7pkpLd9scIEtNoeHPD79W56zdsy3JrJWj6BJI+AbalSfe2PnyRzf
 oMcZQMnkuXY4f+BSidIvc0EmE6KsAc5ieyqLAI3DH0xDimQIZNl9WjWs7SWn3O4BoVIK
 OC4Q==
X-Gm-Message-State: AOJu0Yy4NRZBUmzTynYgdwgAetl8s/ImvlBwTaOlr8F9Ip8X23vCHAdt
 c3VpY+kkDTWEhE3D2xy3j7Nx20zgumGH0ZT9bJ5xO0jrn5dD5oYyY0SICzuI
X-Google-Smtp-Source: AGHT+IH0AQRPFgL9dAcobhunXaLuMIt7QmPPoAGPCON3Qz4yZ9ygm79S59HGYez5pgCy5xmjTJHflA==
X-Received: by 2002:a05:6a00:9196:b0:714:2371:7a02 with SMTP id
 d2e1a72fcca58-715d10be662mr2331015b3a.5.1724838778885; 
 Wed, 28 Aug 2024 02:52:58 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:52:58 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 02/17] bsd-user: Add RISC-V CPU execution loop and syscall
 handling
Date: Wed, 28 Aug 2024 19:52:28 +1000
Message-Id: <20240828095243.90491-3-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42c.google.com
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
index e17c910ae9..ba589909e2 100644
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


