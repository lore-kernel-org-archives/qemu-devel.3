Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D85CC3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJxe-0003jI-Sj; Tue, 23 Jul 2024 14:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwo-0001AC-Nl
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:18 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwb-0001C4-4p
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:03 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-397c57e5f36so9320205ab.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721758139; x=1722362939;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3XlKNMv+/RjVBRuGDBQWo+adXw6lKr/2b70+lGZd98=;
 b=h9pPkifFGIec36Sv9PwCZNkEAtfNXIwYxEML0W/ZDVKnSzUSrJIwLEAChT5KKSx6rk
 +NykBUDopeZvjI1ueOr8CtSauEWhVVWLvaohyNi0aFk1p/HZVDwbE7Lc1XqTPLyx1/s3
 zzp+JpKYlT89Z7noLggZq/DmBbo8NgWqkzOGyRoyZEPZYutqCbE6l3sS1z9ImXiw4ugZ
 U82Vk2lTUVoMR1kftYlekwcMN8jk62Ybo7Fcba/gP0K2bfMnkWURPI9qE6tjYCfoozto
 b2N+sCK1WZc1vUlNNsy/v0QbdKmSUOh2wQziPLPzJ+ZVU8K7tyGBNCjVv6VFqu3+gdEx
 n+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758139; x=1722362939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3XlKNMv+/RjVBRuGDBQWo+adXw6lKr/2b70+lGZd98=;
 b=BNq7q6qh3cC0DS2QXiPuMUX6X4ITVuR4qrVOrX9ppWaq/oJP+auoGBE1MhaMcJM9OM
 AB+uetLp8bT/0GBZEBi+XW1EWFxVYVg2JQLhuoHzImh3UwNJFSEpIkjngd0AAV4bCHOG
 bp5HndHQLy1DQ6M7s5nP0Qcxe8o4Q29Avdb5OsQuAEChxsIDljGN5mcy3cVJ0JBV85ce
 RsSz1lP3xzvfNyvOSNMljdk81aJuct4wckbQH8t1poBQcbQ2R0ir3y4bmAMwSTT7aHdi
 Ragu4pmnnFwXtw3T70kajyzUMtS5d6AU28Nbzw5ZqyDLdH5WMYW77+Lx84bq89/TfC5s
 k5vg==
X-Gm-Message-State: AOJu0Yxy1s6aRaZIC7EU70VGsgfI71u4kIGP+Zr9dVyS95wF+aQ2fcpW
 vUabjNgG+ZBQHqw65bQbwhfgW7LED5nwtrN6cuVHirR/s/Ntblyj3dCxP0fx254x7EWaZZJStnc
 71j4=
X-Google-Smtp-Source: AGHT+IFPAlFauNAURLJ23Vy4cXtZ1E2xfTTWcOoGqDHDgplwOXTQaxTv2jqy4kUAbpK9MAch8V7mzA==
X-Received: by 2002:a05:6e02:17c8:b0:382:64aa:d8d2 with SMTP id
 e9e14a558f8ab-39a16d2d219mr9219785ab.25.1721758139531; 
 Tue, 23 Jul 2024 11:08:59 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a2827csm33361775ab.53.2024.07.23.11.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:08:58 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/14] bsd-user:Add ARM AArch64 signal handling support
Date: Tue, 23 Jul 2024 12:07:15 -0600
Message-ID: <20240723180725.99114-5-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723180725.99114-1-imp@bsdimp.com>
References: <20240723180725.99114-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::136;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x136.google.com
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


