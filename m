Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC45D73E81
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyO-0004Xj-2y; Thu, 29 Jan 2026 12:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyM-0004Ub-0Y
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:26 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyK-0000e6-4T
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:25 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c626bd75628so431512a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708302; x=1770313102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkr6OhmguPw2oxi7sD8m2/kHKNvzaRIhXU0XNXX+ZdA=;
 b=iIy4ty7RPnDZImnVusUFpWL8UWcAXgkpjTX2vJ9DNo6lL2Stxyqy59RQJEH7vBArZL
 3oTXk6wV7sXrrWZqcu/GnNAoPz6ng4RYu+ksj7zKVbj+NSudbgrhFmlklzDRdUfDK7sP
 A185lOVofpyLBn1Pv1F3hD38Ixn8o3i4IzYC8yR96HIZD8way3sqhsf2A4DWwSzjAGTR
 iwH2teK0ASkzmtLgmiRXdsCUmBQaevYf9SLc3UI9Hl0X2Pns7/KAA2D938Ctor4f0GpB
 7pPZcVvbdhlikwuHZgggcwnG5poDGrNSG4Lst4JSIqSL7xh++5Eon35zpSViENufsZRs
 NFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708302; x=1770313102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lkr6OhmguPw2oxi7sD8m2/kHKNvzaRIhXU0XNXX+ZdA=;
 b=lRMww2zqAX+kSDuUb5TXIypN4hnzqv0CIS3WQFnjD5z5g2lPAIGjXRPdVF4uXypOew
 ZPuEaMykzKeJWlNTxejsflIq5Gi/bkrI00Qkw8jFGTqluOmknCUqXcUtkyfi++OhrzSY
 kK81h7YW9WLf39sSBGQRLYic5LclWfXpgAI31B4jNnmU+M5eWBUDiWEhSptS+QqAVDvr
 0U9Ap3EfDJs8XPqWHShpZBofBHzzSFE1hFKU4oPBR+RnLVnOvSzi971vtRucbrW06ri3
 aHtJ2ZaVJmrSdOD6cyZG4MBdWLFVECY0SAAQIjJlfD8EFtaErplM5NB/42c2uXBbTFeb
 e3PQ==
X-Gm-Message-State: AOJu0Yzz4NCaoX0M+/+c/gg/MrMBZLe9O2NHJc/6VeJN6M+sgwXhRc0W
 pFC047gn1FXx99XwZvpD0Mc24IfKMxmd/Wal6DZazRayJXgOVu6tlMJ0ESBTJuCSkSROz2rg3B3
 2EQFu
X-Gm-Gg: AZuq6aLKaQ6xfSsbs6IfCfXBaKF6A1HtGKGirpN3ISpPVSQZSUd9jmxXQ35ZZM6uC/8
 fZlzNAmqu+88XmgFU+TD55C+K1M8Ss9YFE/1pBxUwZGyJeR/6m/XGLLz9lUjMeokC0uAFaC+9pL
 MOpr1OR+1IyjxW+E1LWiUaIvHS+OoeFJ8uZCU/1pnHybSvD+SFH3lfNiNYyZjD62XehVab9gFsz
 6PosVzKj6EyegdWXEYfJqk8k0bxW7sISl8UyFVW22/ceiSypjUGcsJPIwU+ctqUlrJlzBiXMfs8
 OJv1zQT25E2pdkDrSxBKyMRMIYH6r4xTbhEmesp+TWFX78NZLVQBTbtOU+YRG7lsxElthObsNrA
 mWrChHrtc+hy2hlGgP3EgaljXU+sddrE/s+uuT9GEEDsuef1qphVR2Fm7s0QRl8F/glADe4wrKq
 geVSUYuMhqcZF8kwF3lHCw57nRqqQxiuT3JPfZZdqR1TZUMm5jlZImfMt8bxNE9jxz
X-Received: by 2002:a17:90b:5587:b0:34c:7182:cf9d with SMTP id
 98e67ed59e1d1-3543b3d64f2mr202462a91.25.1769708302268; 
 Thu, 29 Jan 2026 09:38:22 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:21 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/21] linux-user: move user/syscall-trace.h to
 linux-user/syscall.c
Date: Thu, 29 Jan 2026 09:37:52 -0800
Message-ID: <20260129173811.138036-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For now, only linux-user supports plugin syscall API, so restrict the
scope of these functions to linux-user/syscall.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260129013134.3956938-7-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/user/syscall-trace.h  | 43 -----------------------------------
 bsd-user/freebsd/os-syscall.c |  1 -
 linux-user/syscall.c          | 20 +++++++++++++++-
 3 files changed, 19 insertions(+), 45 deletions(-)
 delete mode 100644 include/user/syscall-trace.h

diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
deleted file mode 100644
index 9bd7ca19c84..00000000000
--- a/include/user/syscall-trace.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * Common System Call Tracing Wrappers for *-user
- *
- * Copyright (c) 2019 Linaro
- * Written by Alex Bennée <alex.bennee@linaro.org>
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef SYSCALL_TRACE_H
-#define SYSCALL_TRACE_H
-
-#include "user/abitypes.h"
-#include "gdbstub/user.h"
-#include "qemu/plugin.h"
-#include "trace/trace-root.h"
-
-/*
- * These helpers just provide a common place for the various
- * subsystems that want to track syscalls to put their hooks in. We
- * could potentially unify the -strace code here as well.
- */
-
-static inline void record_syscall_start(CPUState *cpu, int num,
-                                        abi_long arg1, abi_long arg2,
-                                        abi_long arg3, abi_long arg4,
-                                        abi_long arg5, abi_long arg6,
-                                        abi_long arg7, abi_long arg8)
-{
-    qemu_plugin_vcpu_syscall(cpu, num,
-                             arg1, arg2, arg3, arg4,
-                             arg5, arg6, arg7, arg8);
-    gdb_syscall_entry(cpu, num);
-}
-
-static inline void record_syscall_return(CPUState *cpu, int num, abi_long ret)
-{
-    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
-    gdb_syscall_return(cpu, num);
-}
-
-
-#endif /* SYSCALL_TRACE_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index ca2f6fdb66e..4c1191b8f47 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -31,7 +31,6 @@
 
 #include "qemu.h"
 #include "signal-common.h"
-#include "user/syscall-trace.h"
 
 /* BSD independent syscall shims */
 #include "bsd-file.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3944004568f..b4b551ad148 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -132,6 +132,7 @@
 #include "uname.h"
 
 #include "qemu.h"
+#include "gdbstub/user.h"
 #include "user-internals.h"
 #include "strace.h"
 #include "signal-common.h"
@@ -142,7 +143,6 @@
 #include "user/signal.h"
 #include "qemu/guest-random.h"
 #include "qemu/selfmap.h"
-#include "user/syscall-trace.h"
 #include "special-errno.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
@@ -14334,6 +14334,24 @@ static bool sys_dispatch(CPUState *cpu, TaskState *ts)
     return true;
 }
 
+static void record_syscall_start(CPUState *cpu, int num,
+                                 abi_long arg1, abi_long arg2,
+                                 abi_long arg3, abi_long arg4,
+                                 abi_long arg5, abi_long arg6,
+                                 abi_long arg7, abi_long arg8)
+{
+    qemu_plugin_vcpu_syscall(cpu, num,
+                             arg1, arg2, arg3, arg4,
+                             arg5, arg6, arg7, arg8);
+    gdb_syscall_entry(cpu, num);
+}
+
+static void record_syscall_return(CPUState *cpu, int num, abi_long ret)
+{
+    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
+    gdb_syscall_return(cpu, num);
+}
+
 abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
-- 
2.47.3


