Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F94C3DA45
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 19:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQXIk-0000ou-Dt; Sun, 07 Jul 2024 15:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIi-0000oT-NU
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIg-0005AC-V4
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:56 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb05b0be01so18836575ad.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720379513; x=1720984313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xg27xgnLi4xIfFOcGoXylyDerzXo9C4ECzAbWCiXwIs=;
 b=NJYYOXUCC2zJ/5I8HntuqygmN5LY6JXGksE9PkGOtzHbquitntfBM2N5qpW0Xh0MIu
 onD5jHMiFIvpFp0itqH0ObQTO27wfuUwGA7FWE47kicJcUbcHfcvxZvVXLno7TOrqcnE
 Ku2SdFKxqZgJijCh/p7VAh8ZTiFH0R/hyFuxiPCCvNmMimM2nD1NsE60JjrDVdUZB23U
 P2AGPNdKz0pYMOcDV3NYjCm2NoC/NKhgPcxEGAn/ecRhOK+OfarbVkKwaB/0bbUywjVI
 yhRG5H4jDNNdIccwrQfJ8GdAUhSuUiCaJIhWL+m1VZwSXgwkDhfW3cseK8Zo3RX9xv/U
 /Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720379513; x=1720984313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xg27xgnLi4xIfFOcGoXylyDerzXo9C4ECzAbWCiXwIs=;
 b=NoNiNsILprM5+yWrxM7c84lKCTCT0mhESZkJbp54XF4jeUJ1nw/HMy/IUvYt3TcnBv
 tALc6e8CFhjGl6jSgSZ/j+K01xtQsqkwRtzDwPHs9hcKAEy04NFVtC0pv7VMaofdnjwy
 +5fQCsESnrbN5O5lc8ZWWG3TE3kGyxSPGYlX6wPB+XnU3vjRvfwId01GBG8UAYj/r7eK
 L+lU/765GOGhEzY8qjBChCij98dXYn2PkSqILWHfjBidrWmQA3fglcWPUq6txF0Zb0uM
 a91LaKcKmtFvgR9EJbaLQACj7QphDTGEBv9YsQfyZTCVdjUURBvnIqR7798REsD0v/eJ
 9WBA==
X-Gm-Message-State: AOJu0YwYUzH13jAH7Cu4ycRl/gpdg9BEldOmXZs45YSOp7FkR7n4Ylic
 K0VJQVO5Y0W6SeJSSf0im8iu1Anr2TOTfLxjeUgcILnWllxVm/n5NzVYD26j
X-Google-Smtp-Source: AGHT+IEEoH0C9spPE58kwVarAh8KAIyTPsXjq8q7V0TLneUbUXCeurdn5sx+Vddq+nituF8jAqLXRg==
X-Received: by 2002:a17:902:da86:b0:1fb:80a3:5833 with SMTP id
 d9443c01a7336-1fb80a35b3emr29724305ad.47.1720379513456; 
 Sun, 07 Jul 2024 12:11:53 -0700 (PDT)
Received: from localhost.localdomain ([106.222.220.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac11d8a70sm172156725ad.118.2024.07.07.12.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 12:11:53 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH v2 8/8] bsd-user:Add AArch64 improvements and signal handling
 functions
Date: Mon,  8 Jul 2024 00:41:28 +0530
Message-Id: <20240707191128.10509-9-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240707191128.10509-1-itachis@FreeBSD.org>
References: <20240707191128.10509-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x630.google.com
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

Added get_ucontext_sigreturn function to check processor state ensuring current execution mode is EL0 and no flags
indicating interrupts or exceptions are set.
Updated AArch64 code to use CF directly without reading/writing the entire processor state, improving efficiency.
Changed FP data structures to use Int128 instead of __uint128_t, leveraging QEMU's generic mechanism for referencing this type.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/signal.c             | 20 +++++++++++++++++++-
 bsd-user/aarch64/target_arch_cpu.h    |  7 ++-----
 bsd-user/aarch64/target_arch_reg.h    |  2 +-
 bsd-user/aarch64/target_arch_signal.h |  2 +-
 bsd-user/qemu.h                       |  3 +++
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index 13faac8ce6..6bc73a798f 100644
--- a/bsd-user/aarch64/signal.c
+++ b/bsd-user/aarch64/signal.c
@@ -21,7 +21,7 @@
 #include "qemu.h"
 
 /*
- * Compare to sendsig() in sys/arm64/arm64/machdep.c
+ * Compare to sendsig() in sys/arm64/arm64/exec_machdep.c
  * Assumes that target stack frame memory is locked.
  */
 abi_long set_sigtramp_args(CPUARMState *regs, int sig,
@@ -117,3 +117,21 @@ abi_long set_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int srflag)
 
     return err;
 }
+
+/* Compare to sys_sigreturn() in  arm64/arm64/machdep.c */
+abi_long get_ucontext_sigreturn(CPUARMState *regs, abi_ulong target_sf,
+                                abi_ulong *target_uc)
+{
+    uint32_t pstate = pstate_read(regs);
+
+    *target_uc = 0;
+
+    if ((pstate & PSTATE_M) != PSTATE_MODE_EL0t  ||
+        (pstate & (PSTATE_F | PSTATE_I | PSTATE_A | PSTATE_D)) != 0) {
+        return -TARGET_EINVAL;
+    }
+
+    *target_uc = target_sf;
+
+    return 0;
+}
diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
index 4e950305d3..408aef2bb5 100644
--- a/bsd-user/aarch64/target_arch_cpu.h
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -47,7 +47,6 @@ static inline void target_cpu_loop(CPUARMState *env)
     CPUState *cs = env_cpu(env);
     int trapnr, ec, fsc, si_code, si_signo;
     uint64_t code, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8;
-    uint32_t pstate;
     abi_long ret;
 
     for (;;) {
@@ -87,18 +86,16 @@ static inline void target_cpu_loop(CPUARMState *env)
              * The carry bit is cleared for no error; set for error.
              * See arm64/arm64/vm_machdep.c cpu_set_syscall_retval()
              */
-            pstate = pstate_read(env);
             if (ret >= 0) {
-                pstate &= ~PSTATE_C;
+                env->CF = 0;
                 env->xregs[0] = ret;
             } else if (ret == -TARGET_ERESTART) {
                 env->pc -= 4;
                 break;
             } else if (ret != -TARGET_EJUSTRETURN) {
-                pstate |= PSTATE_C;
+                env->CF = 1;
                 env->xregs[0] = -ret;
             }
-            pstate_write(env, pstate);
             break;
 
         case EXCP_INTERRUPT:
diff --git a/bsd-user/aarch64/target_arch_reg.h b/bsd-user/aarch64/target_arch_reg.h
index 5c7154f0c1..b53302e7f7 100644
--- a/bsd-user/aarch64/target_arch_reg.h
+++ b/bsd-user/aarch64/target_arch_reg.h
@@ -31,7 +31,7 @@ typedef struct target_reg {
 } target_reg_t;
 
 typedef struct target_fpreg {
-    __uint128_t     fp_q[32];
+    Int128          fp_q[32];
     uint32_t        fp_sr;
     uint32_t        fp_cr;
 } target_fpreg_t;
diff --git a/bsd-user/aarch64/target_arch_signal.h b/bsd-user/aarch64/target_arch_signal.h
index df17173316..bff752a67a 100644
--- a/bsd-user/aarch64/target_arch_signal.h
+++ b/bsd-user/aarch64/target_arch_signal.h
@@ -49,7 +49,7 @@ struct target_gpregs {
 };
 
 struct target_fpregs {
-    __uint128_t fp_q[32];
+    Int128      fp_q[32];
     uint32_t    fp_sr;
     uint32_t    fp_cr;
     uint32_t    fp_flags;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 9d2fc7148e..3736c41786 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -17,6 +17,9 @@
 #ifndef QEMU_H
 #define QEMU_H
 
+#include <sys/param.h>
+
+#include "qemu/int128.h"
 #include "cpu.h"
 #include "qemu/units.h"
 #include "exec/cpu_ldst.h"
-- 
2.34.1


