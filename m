Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDD5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0Su-0004Dy-MJ; Fri, 16 Aug 2024 13:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0St-0004DG-Dn
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:15 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0Sl-0007M1-TT
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:09 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d3bd8784d3so1629529a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828205; x=1724433005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JX4fMSWYAeIvZxxe4ZWzsUZ5Z4cADcMR98comH+Msg=;
 b=ZA+pnVRxRzvrVW/stIIWTdxRfj0wZbXxuFKxCnLkI3CjWmKJx9MVD/CxkIMXtQaPSB
 fXdvq6YhnxxHTiuS/C4ga/IW+WU3+2wBduyAJgdlRxh74T+R/zjWrSWcoaXws4w7sJ+w
 aRJ2YwSD76BOe13tSRbiy5DMQ6K9NioK3rqTNaFK3veaSdENXBDiqgnsM0+Hi4oNoUtK
 m38O+M3+yM2RMhKEjPTa5peUtKtsXnpFKfUwnGCIxeuaK5yiRVacl0GZeWqWQxW35mD3
 hgbwNyhGw2Y/KvzBreZtxFQB2SCGTPIICCJhKJLXtljzTQ5zzfuQ8FFvWwl6DzBKnL+H
 LCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828205; x=1724433005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JX4fMSWYAeIvZxxe4ZWzsUZ5Z4cADcMR98comH+Msg=;
 b=NOd2/W7+Zb6E0IY79VRn7gvF5S+FQ2KPY+t3kVocDPywpbnIgcsLlhCfjcj1WhOL7a
 GAGNeLDhsWutlSUv2MJhlBmChKrAcORwWN1zW2vi6NPkuVqsB1yt2QhkZwmK92gen6U/
 LxC35yy741Yu39j4jbwgduRYm+uu5XLmaztLiwCvUswV0YfkWwucw6mtIsSgPqCruanL
 eGX88gWv06ky4vCOnWbuBr+wesksveA9NSoMjV96P4xrdEGkpDCs59EkBoDGKHOyytxK
 kdzD78sdytkjESgM/M968pWT/QnlQ7mpSlgMMDSymrMYEj+lY5ZvUc3eJE1CC8HQIH3d
 FmXQ==
X-Gm-Message-State: AOJu0YypB1njSbl/RfTCJSoanxgHbp2kmKUaKOBnnsxpPKQQINQZL4Us
 JFzJjOCuohB9oK93CrKrSjojZ9XmlxRISBSxcNleV0jbMK5pPsBklyRQd1FsNVs=
X-Google-Smtp-Source: AGHT+IEBzu9hMrO/SZuCyTgRZ+IjMCHP23Ulq8fmEaVfLwqUr1meFQhPEF5536nF8fnPglpHKXzELQ==
X-Received: by 2002:a17:90a:8a02:b0:2d3:d0b7:da4 with SMTP id
 98e67ed59e1d1-2d40569bc90mr129772a91.19.1723828205026; 
 Fri, 16 Aug 2024 10:10:05 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:04 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 02/17] bsd-user: Add RISC-V CPU execution loop and syscall
 handling
Date: Sat, 17 Aug 2024 03:09:34 +1000
Message-Id: <20240816170949.238511-3-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=itachis6234@gmail.com; helo=mail-pj1-x102f.google.com
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


