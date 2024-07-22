Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669C4C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0q8-0005YI-VA; Mon, 22 Jul 2024 17:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0py-00052u-BO
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:44:55 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0pt-0004JK-BY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:44:54 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-8076cee8607so187339139f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721684687; x=1722289487;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3XlKNMv+/RjVBRuGDBQWo+adXw6lKr/2b70+lGZd98=;
 b=ihEaJ8WYzg5Y2hA7H0SnRhB2UWxrXfl+A37SudlDv4KzVjerFf30o08M9RX1/NjawL
 TjlU7Q6PTVNYG1+CofEI8hVdGI9EdDXIpRht3+TMTG2te7cMoKwEa3FhYLqWouhdyU+0
 ha736t6QKoQ+zN6CArbqdytO/d9eVNf7QpLMniGeKpViRtATQSFd+7GRah6Bb/7Ur84N
 gdgX2vH4eTqlv0qOKWzAHCnDgvp2vQiuyUSSWHDlXEURtspCmY8nqXgpBnTwalUyMb/E
 mgcvlLZPLACL9yJviNxqmxyc9cR33j1yiMvRjySnfU4rd0W89rrY08R5nKaJmc8P9U/H
 wZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721684687; x=1722289487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3XlKNMv+/RjVBRuGDBQWo+adXw6lKr/2b70+lGZd98=;
 b=nQXxMQekDEDuifG3W1aZD+DdJ72mh/eyF0UyuGuyxkasSsi3SyooM51sEW2xjs+jYF
 gh2N4k9lA2g86HnKvhaKy5tsfzi49s6i8KwN6PgCrDzYbdo/qeIjhYjGyzPVsY6znYqC
 bObq7qzXpXbcx376NbmSqyubU2a0bDNtcm4cmr76ZUkhbvPOibKy5EL5OHGs9Dqlsg0G
 c+j5E54T74qPyYuufZp0u8l9M0DP0cH0wcJhJh+ZAVKOkgBxUjRSBUkfPGacFQGXsDPx
 +doncRa+s6KLJ6Q4pfiDLWyvoZWyfKTNtoUevRrpAEpdYOsz3AcuwsDgdcY7FHTJuqwo
 j94Q==
X-Gm-Message-State: AOJu0YxUlnKwi+c50EP48SXk8xzY5jRxnGqy6NMc30oGXt5jhDcj9c5e
 CpdaEdFB1IBp/wOhRsEUiMtr+h0BznnTRVkCFGQ3ywzamc2P/MszNrekVu0TwJPRrW7WWhH155Z
 g09I=
X-Google-Smtp-Source: AGHT+IFLRWZtjPPVCHQMops76WOqugv56agD1sdefR5GPJ2ZQfmb27VRYKYSh6ZDtC5F1/89bHvc7A==
X-Received: by 2002:a05:6602:640d:b0:80f:81f5:b46c with SMTP id
 ca18e2360f4ac-81aab6d5260mr1017056039f.15.1721684687032; 
 Mon, 22 Jul 2024 14:44:47 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c2343d2ff3sm1816830173.128.2024.07.22.14.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 14:44:46 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 04/14] bsd-user:Add ARM AArch64 signal handling support
Date: Mon, 22 Jul 2024 15:43:03 -0600
Message-ID: <20240722214313.89503-5-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240722214313.89503-1-imp@bsdimp.com>
References: <20240722214313.89503-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Added sigcode setup function for signal trampoline which initializes a sequence of instructions
to handle signal returns and exits, copying this code to the target offset.
Defined ARM AArch64 specific signal definitions including register indices and sizes,
and introduced structures to represent general purpose registers, floating point registers, and machine context.
Added function to set up signal handler arguments, populating register values in `CPUARMState`
based on the provided signal, signal frame, signal action, and frame address.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Co-authored-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240707191128.10509-5-itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/signal.c               | 53 ++++++++++++++++
 bsd-user/aarch64/target_arch_signal.h   | 80 +++++++++++++++++++++++++
 bsd-user/aarch64/target_arch_sigtramp.h | 48 +++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 bsd-user/aarch64/signal.c
 create mode 100644 bsd-user/aarch64/target_arch_signal.h
 create mode 100644 bsd-user/aarch64/target_arch_sigtramp.h

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
new file mode 100644
index 00000000000..98861f9ab3b
--- /dev/null
+++ b/bsd-user/aarch64/signal.c
@@ -0,0 +1,53 @@
+/*
+ * ARM AArch64 specific signal definitions for bsd-user
+ *
+ * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
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
+
+#include "qemu.h"
+
+/*
+ * Compare to sendsig() in sys/arm64/arm64/machdep.c
+ * Assumes that target stack frame memory is locked.
+ */
+abi_long set_sigtramp_args(CPUARMState *regs, int sig,
+                           struct target_sigframe *frame,
+                           abi_ulong frame_addr,
+                           struct target_sigaction *ka)
+{
+    /*
+     * Arguments to signal handler:
+     *  x0 = signal number
+     *  x1 = siginfo pointer
+     *  x2 = ucontext pointer
+     *  pc/elr = signal handler pointer
+     *  sp = sigframe struct pointer
+     *  lr = sigtramp at base of user stack
+     */
+
+    regs->xregs[0] = sig;
+    regs->xregs[1] = frame_addr +
+        offsetof(struct target_sigframe, sf_si);
+    regs->xregs[2] = frame_addr +
+        offsetof(struct target_sigframe, sf_uc);
+
+    regs->pc = ka->_sa_handler;
+    regs->xregs[TARGET_REG_SP] = frame_addr;
+    regs->xregs[TARGET_REG_LR] = TARGET_PS_STRINGS - TARGET_SZSIGCODE;
+
+    return 0;
+}
diff --git a/bsd-user/aarch64/target_arch_signal.h b/bsd-user/aarch64/target_arch_signal.h
new file mode 100644
index 00000000000..df171733166
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_signal.h
@@ -0,0 +1,80 @@
+/*
+ * ARM AArch64 specific signal definitions for bsd-user
+ *
+ * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
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
+#ifndef TARGET_ARCH_SIGNAL_H
+#define TARGET_ARCH_SIGNAL_H
+
+#include "cpu.h"
+
+#define TARGET_REG_X0   0
+#define TARGET_REG_X30  30
+#define TARGET_REG_X31  31
+#define TARGET_REG_LR   TARGET_REG_X30
+#define TARGET_REG_SP   TARGET_REG_X31
+
+#define TARGET_INSN_SIZE    4       /* arm64 instruction size */
+
+/* Size of the signal trampolin code. See _sigtramp(). */
+#define TARGET_SZSIGCODE    ((abi_ulong)(9 * TARGET_INSN_SIZE))
+
+/* compare to sys/arm64/include/_limits.h */
+#define TARGET_MINSIGSTKSZ  (1024 * 4)                  /* min sig stack size */
+#define TARGET_SIGSTKSZ     (TARGET_MINSIGSTKSZ + 32768)  /* recommended size */
+
+/* struct __mcontext in sys/arm64/include/ucontext.h */
+
+struct target_gpregs {
+    uint64_t    gp_x[30];
+    uint64_t    gp_lr;
+    uint64_t    gp_sp;
+    uint64_t    gp_elr;
+    uint32_t    gp_spsr;
+    uint32_t    gp_pad;
+};
+
+struct target_fpregs {
+    __uint128_t fp_q[32];
+    uint32_t    fp_sr;
+    uint32_t    fp_cr;
+    uint32_t    fp_flags;
+    uint32_t    fp_pad;
+};
+
+struct target__mcontext {
+    struct target_gpregs mc_gpregs;
+    struct target_fpregs mc_fpregs;
+    uint32_t    mc_flags;
+#define TARGET_MC_FP_VALID  0x1
+    uint32_t    mc_pad;
+    uint64_t    mc_spare[8];
+};
+
+typedef struct target__mcontext target_mcontext_t;
+
+#define TARGET_MCONTEXT_SIZE 880
+#define TARGET_UCONTEXT_SIZE 960
+
+#include "target_os_ucontext.h"
+
+struct target_sigframe {
+    target_siginfo_t    sf_si;  /* saved siginfo */
+    target_ucontext_t   sf_uc;  /* saved ucontext */
+};
+
+#endif /* TARGET_ARCH_SIGNAL_H */
diff --git a/bsd-user/aarch64/target_arch_sigtramp.h b/bsd-user/aarch64/target_arch_sigtramp.h
new file mode 100644
index 00000000000..8cdd33b621d
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_sigtramp.h
@@ -0,0 +1,48 @@
+/*
+ * ARM AArch64 sigcode for bsd-user
+ *
+ * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
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
+#ifndef TARGET_ARCH_SIGTRAMP_H
+#define TARGET_ARCH_SIGTRAMP_H
+
+/* Compare to ENTRY(sigcode) in arm64/arm64/locore.S */
+static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf_uc,
+        unsigned sys_sigreturn)
+{
+    int i;
+    uint32_t sys_exit = TARGET_FREEBSD_NR_exit;
+
+    uint32_t sigtramp_code[] = {
+    /* 1 */ 0x910003e0,                 /* mov x0, sp */
+    /* 2 */ 0x91000000 + (sigf_uc << 10), /* add x0, x0, #SIGF_UC */
+    /* 3 */ 0xd2800000 + (sys_sigreturn << 5) + 0x8, /* mov x8, #SYS_sigreturn */
+    /* 4 */ 0xd4000001,                 /* svc #0 */
+    /* 5 */ 0xd2800028 + (sys_exit << 5) + 0x8, /* mov x8, #SYS_exit */
+    /* 6 */ 0xd4000001,                 /* svc #0 */
+    /* 7 */ 0x17fffffc,                 /* b -4 */
+    /* 8 */ sys_sigreturn,
+    /* 9 */ sys_exit
+    };
+
+    for (i = 0; i < 9; i++) {
+        tswap32s(&sigtramp_code[i]);
+    }
+
+    return memcpy_to_target(offset, sigtramp_code, TARGET_SZSIGCODE);
+}
+#endif /* TARGET_ARCH_SIGTRAMP_H */
-- 
2.45.1


