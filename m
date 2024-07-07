Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C0CC3DA41
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 19:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQXIZ-0000lj-6h; Sun, 07 Jul 2024 15:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIX-0000lL-O4
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIV-000589-CL
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fb0d7e4ee9so20861075ad.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720379502; x=1720984302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FbnoTBSKIDJs2zVqo6kHAJTCsCuXr7TaJjTdy5frhH8=;
 b=AHyARD+JlPAK3embU+MPYi5xyaa04mfZgeLgDIuxpN7dRLY5rzJfHd0MbFG+2Adzar
 wzcvknxCANjkpZTZWJ13vtF/ubeNoNiAzKWn3Hhdk8N9PxA1x/5XLWSapcB2Ck8YIFdu
 hgAY30qVXL7wvAM29zMnEP4+ZKCUQm/chjyXHDgKIx19Q18jEPv6rwaVdvY6Jr/q437D
 tqbwKhuz33ueFbDF5GCds40E5ZMrz7ZMr/UcFYqwezCbjIGMXXDPR+I4nC9oDZhyPXnP
 1WPeeBC5AKy631XVOu3iuloEUTlu4RfZfV3treEsMvettPrJ+3lvEvu3IoIyElRKuy5X
 bklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720379502; x=1720984302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FbnoTBSKIDJs2zVqo6kHAJTCsCuXr7TaJjTdy5frhH8=;
 b=NB8n1811ewtgdggQlObSL45pnDtmDUHXJ4qFFcfHmyeVKwk21vmhNxRsgniRcxxdM3
 Z2VWHqTFZIlhfHIG81FvJhMQIHaSxp6q/fk4oqvTn62G7uoxvMP/e4lKp84/Gu7wknhn
 zLwUoF234ev9zEZ2G++v+Bv+dfNfVc8bWtYw2IO7BrXbNyj0/qhFt0hsjLOw1lkQ0BxX
 vXbU/gGU5ACgO0CRDRFFpFuZeoBwDfZsAz40FGXAgAtLsZTVzWD1vVIujilahWce1k5T
 c6zgnjP8XfYjcIMbMS5X1+qiHzjfI9L08pIqjfH1ueW0YBoGou7hoQKFDwB5aWvJJnP8
 9gjw==
X-Gm-Message-State: AOJu0YyEPwxG4c/DKmRLIPL+jarb/F8XnJ2t5XczInQs0hTgOOM40aZm
 aTl7XV2xZuoMHqtzrgW1ZNCgLM7vFF57ZakMWa2DcvWUVopWJjGDzKt5YNqy
X-Google-Smtp-Source: AGHT+IHDWtNujByHJWSSnbiLcx/hpE2FYpYT2WHNUaEWmYpamxmE1ePywrCCo4RRVW59Os8psFEmJw==
X-Received: by 2002:a17:903:41d0:b0:1f9:b16d:f94f with SMTP id
 d9443c01a7336-1fb33ed08bbmr71434795ad.39.1720379501566; 
 Sun, 07 Jul 2024 12:11:41 -0700 (PDT)
Received: from localhost.localdomain ([106.222.220.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac11d8a70sm172156725ad.118.2024.07.07.12.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 12:11:41 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Sean Bruno <sbruno@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/8] bsd-user:Add AArch64 register handling and related
 functions
Date: Mon,  8 Jul 2024 00:41:22 +0530
Message-Id: <20240707191128.10509-3-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240707191128.10509-1-itachis@FreeBSD.org>
References: <20240707191128.10509-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Added header file for managing CPU register states in FreeBSD user mode.
Introduced prototypes for setting and getting thread-local storage (TLS).
Implemented AArch64 sysarch() system call emulation and a printing function.
Added function for setting up thread upcall to add thread support to BSD-USER.
Initialized thread's register state during thread setup.
Updated ARM AArch64 VM parameter definitions for bsd-user, including address spaces for FreeBSD/arm64 and
a function for getting the stack pointer from CPU and setting a return value.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Co-authored-by: Sean Bruno <sbruno@freebsd.org>
Co-authored-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/target_arch.h         | 28 +++++++++++
 bsd-user/aarch64/target_arch_reg.h     | 56 +++++++++++++++++++++
 bsd-user/aarch64/target_arch_sysarch.h | 42 ++++++++++++++++
 bsd-user/aarch64/target_arch_thread.h  | 61 +++++++++++++++++++++++
 bsd-user/aarch64/target_arch_vmparam.h | 68 ++++++++++++++++++++++++++
 5 files changed, 255 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch.h
 create mode 100644 bsd-user/aarch64/target_arch_reg.h
 create mode 100644 bsd-user/aarch64/target_arch_sysarch.h
 create mode 100644 bsd-user/aarch64/target_arch_thread.h
 create mode 100644 bsd-user/aarch64/target_arch_vmparam.h

diff --git a/bsd-user/aarch64/target_arch.h b/bsd-user/aarch64/target_arch.h
new file mode 100644
index 0000000000..27f47de8eb
--- /dev/null
+++ b/bsd-user/aarch64/target_arch.h
@@ -0,0 +1,28 @@
+/*
+ * ARM AArch64 specific prototypes for bsd-user
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
+#ifndef TARGET_ARCH_H
+#define TARGET_ARCH_H
+
+#include "qemu.h"
+
+void target_cpu_set_tls(CPUARMState *env, target_ulong newtls);
+target_ulong target_cpu_get_tls(CPUARMState *env);
+
+#endif /* TARGET_ARCH_H */
diff --git a/bsd-user/aarch64/target_arch_reg.h b/bsd-user/aarch64/target_arch_reg.h
new file mode 100644
index 0000000000..5c7154f0c1
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_reg.h
@@ -0,0 +1,56 @@
+/*
+ *  FreeBSD arm64 register structures
+ *
+ *  Copyright (c) 2015 Stacey Son
+ *  All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_REG_H
+#define TARGET_ARCH_REG_H
+
+/* See sys/arm64/include/reg.h */
+typedef struct target_reg {
+    uint64_t        x[30];
+    uint64_t        lr;
+    uint64_t        sp;
+    uint64_t        elr;
+    uint64_t        spsr;
+} target_reg_t;
+
+typedef struct target_fpreg {
+    __uint128_t     fp_q[32];
+    uint32_t        fp_sr;
+    uint32_t        fp_cr;
+} target_fpreg_t;
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+static inline void target_copy_regs(target_reg_t *regs, CPUARMState *env)
+{
+    int i;
+
+    for (i = 0; i < 30; i++) {
+        regs->x[i] = tswapreg(env->xregs[i]);
+    }
+    regs->lr = tswapreg(env->xregs[30]);
+    regs->sp = tswapreg(env->xregs[31]);
+    regs->elr = tswapreg(env->pc);
+    regs->spsr = tswapreg(pstate_read(env));
+}
+
+#undef tswapreg
+
+#endif /* TARGET_ARCH_REG_H */
diff --git a/bsd-user/aarch64/target_arch_sysarch.h b/bsd-user/aarch64/target_arch_sysarch.h
new file mode 100644
index 0000000000..b003015daf
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_sysarch.h
@@ -0,0 +1,42 @@
+/*
+ * ARM AArch64 sysarch() system call emulation for bsd-user.
+ *
+ * Copyright (c) 2015 <sson at FreeBSD>
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
+#ifndef TARGET_ARCH_SYSARCH_H
+#define TARGET_ARCH_SYSARCH_H
+
+#include "target_syscall.h"
+#include "target_arch.h"
+
+/* See sysarch() in sys/arm64/arm64/sys_machdep.c */
+static inline abi_long do_freebsd_arch_sysarch(CPUARMState *env, int op,
+        abi_ulong parms)
+{
+    int ret = -TARGET_EOPNOTSUPP;
+
+    fprintf(stderr, "sysarch");
+    return ret;
+}
+
+static inline void do_freebsd_arch_print_sysarch(
+        const struct syscallname *name, abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
+{
+}
+
+#endif /* TARGET_ARCH_SYSARCH_H */
diff --git a/bsd-user/aarch64/target_arch_thread.h b/bsd-user/aarch64/target_arch_thread.h
new file mode 100644
index 0000000000..4c911e605a
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_thread.h
@@ -0,0 +1,61 @@
+/*
+ * ARM AArch64 thread support for bsd-user.
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
+#ifndef TARGET_ARCH_THREAD_H
+#define TARGET_ARCH_THREAD_H
+
+/* Compare to arm64/arm64/vm_machdep.c cpu_set_upcall_kse() */
+static inline void target_thread_set_upcall(CPUARMState *regs, abi_ulong entry,
+    abi_ulong arg, abi_ulong stack_base, abi_ulong stack_size)
+{
+    abi_ulong sp;
+
+    /*
+     * Make sure the stack is properly aligned.
+     * arm64/include/param.h (STACKLIGN() macro)
+     */
+    sp = ROUND_DOWN(stack_base + stack_size, 16);
+
+    /* sp = stack base */
+    regs->xregs[31] = sp;
+    /* pc = start function entry */
+    regs->pc = entry;
+    /* r0 = arg */
+    regs->xregs[0] = arg;
+
+    
+}
+
+static inline void target_thread_init(struct target_pt_regs *regs,
+        struct image_info *infop)
+{
+    abi_long stack = infop->start_stack;
+
+    /*
+     * Make sure the stack is properly aligned.
+     * arm64/include/param.h (STACKLIGN() macro)
+     */
+
+    memset(regs, 0, sizeof(*regs));
+    regs->regs[0] = infop->start_stack;
+    regs->pc = infop->entry;
+    regs->sp = ROUND_DOWN(stack, 16);
+}
+
+#endif /* TARGET_ARCH_THREAD_H */
diff --git a/bsd-user/aarch64/target_arch_vmparam.h b/bsd-user/aarch64/target_arch_vmparam.h
new file mode 100644
index 0000000000..dc66e1289b
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_vmparam.h
@@ -0,0 +1,68 @@
+/*
+ * ARM AArch64 VM parameters definitions for bsd-user.
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
+#ifndef TARGET_ARCH_VMPARAM_H
+#define TARGET_ARCH_VMPARAM_H
+
+#include "cpu.h"
+
+/**
+ * FreeBSD/arm64 Address space layout.
+ *
+ * ARMv8 implements up to a 48 bit virtual address space. The address space is
+ * split into 2 regions at each end of the 64 bit address space, with an
+ * out of range "hole" in the middle.
+ *
+ * We limit the size of the two spaces to 39 bits each.
+ *
+ * Upper region:        0xffffffffffffffff
+ *                      0xffffff8000000000
+ *
+ * Hole:                0xffffff7fffffffff
+ *                      0x0000008000000000
+ *
+ * Lower region:        0x0000007fffffffff
+ *                      0x0000000000000000
+ *
+ * The upper region for the kernel, and the lower region for userland.
+ */
+
+
+/* compare to sys/arm64/include/vmparam.h */
+#define TARGET_MAXTSIZ      (1 * GiB)           /* max text size */
+#define TARGET_DFLDSIZ      (128 * MiB)         /* initial data size limit */
+#define TARGET_MAXDSIZ      (1 * GiB)           /* max data size */
+#define TARGET_DFLSSIZ      (128 * MiB)         /* initial stack size limit */
+#define TARGET_MAXSSIZ      (1 * GiB)           /* max stack size */
+#define TARGET_SGROWSIZ     (128 * KiB)         /* amount to grow stack */
+
+                /* KERNBASE - 512 MB */
+#define TARGET_VM_MAXUSER_ADDRESS   (0x00007fffff000000ULL - (512 * MiB))
+#define TARGET_USRSTACK             TARGET_VM_MAXUSER_ADDRESS
+
+static inline abi_ulong get_sp_from_cpustate(CPUARMState *state)
+{
+    return state->xregs[31]; /* sp */
+}
+
+static inline void set_second_rval(CPUARMState *state, abi_ulong retval2)
+{
+    state->xregs[1] = retval2; /* XXX not really used on 64-bit arch */
+}
+#endif /* TARGET_ARCH_VMPARAM_H */
-- 
2.34.1


