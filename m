Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3990CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsIX-0000dg-7p; Wed, 02 Oct 2024 01:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsIB-0008Ro-Pi
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:57 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsIA-0004x5-0l
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:55 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b6458ee37so45293735ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848359; x=1728453159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQJqHR+gWZxuzK+vQrtW2RpEvFkaW/mAAuxKLl+w/L8=;
 b=hfqnVJf85mh6yxFOMPr74UkANMqtG899G5p1kcZiYuaf5fiVpSz+KF9fhdF2MreCXh
 55Crvv7SrlxZLedQIjTLQwEyB5ztomwh/9pVVxPYsEGjil6LITqvJW705XwcuQGz9BqB
 mrivKyCwcrfFaau+O5MBqU5bpILxesy7iOYOFIzK1aX4fPQOQOybFOlN43jftmX+ZkKR
 heMZsRmrS68UdSOaqXy64rSglrRh9//Vl+HR634O040FntvJTOOGTAi9pHUuJSDSpn9A
 4lPgmJjHKbjM7Xr1kN5VHUQfWo2ysAP/u0drAqaYmcQwGr9hJC9e0OxEDb9o3dqIYwpu
 XtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848359; x=1728453159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQJqHR+gWZxuzK+vQrtW2RpEvFkaW/mAAuxKLl+w/L8=;
 b=amCwv9St9tzgCWaHo86224PTfOY/u2XYJLBc/httVA/TJHTg3GKqvGnEk+IzstQ+pd
 7zrnQ71yHNlEHyyq2XcPcjj3QxoNpq86DNEb9PMAzw/AkrLY3CBvr7fLLFYwFlEf8g+D
 X5Gl0m5cqY5+oIN+g2kOi/EsbwW2W/POaYdWLFL8D4Xt55My9Rwl8rR2YtWvjOOH7z8L
 UdFQ0fEwoIUUi35Gkr5Jan54q5e5/I4fgmgtoiKOEfgH6QxwTD+dbcsHiUstgM+C05Wo
 4lmKerJOCJ7biEYgQujsGIE8swgXYAiTeKcBvmAIhgEVWmVGZxnQWJ+0UEQwq2/D2kiL
 b17w==
X-Gm-Message-State: AOJu0Yy6v3qx3B+dzzZ4Try5TxbePKsB8AyTwPn0nIdo7jHCBTjQxgk8
 oLLXMkvPLRzaY2YjzsisBUyWFu+fhMYgsV+o54Nm7rM6MO0oOxzLQMJxTqLA
X-Google-Smtp-Source: AGHT+IHqLxBfAu022n2/7lVX74QDleaNgK+dfc88R9b0sBs5PzeCGX8h+WeVo5vlY5hHsnHpFqZiig==
X-Received: by 2002:a17:903:1103:b0:20b:9078:707b with SMTP id
 d9443c01a7336-20bc5a10233mr29586565ad.30.1727848359026; 
 Tue, 01 Oct 2024 22:52:39 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:52:38 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 32/35] bsd-user: Implement RISC-V signal trampoline setup
 functions
Date: Wed,  2 Oct 2024 15:50:45 +1000
Message-ID: <20241002055048.556083-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

Added functions for setting up the RISC-V signal trampoline and signal
frame:

'set_sigtramp_args()': Configures the RISC-V CPU state with arguments
for the signal handler. It sets up the registers with the signal
number,pointers to the signal info and user context, the signal handler
address, and the signal frame pointer.

'setup_sigframe_arch()': Initializes the signal frame with the current
machine context.This function copies the context from the CPU state to
the signal frame, preparing it for the signal handler.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Co-authored-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-15-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/signal.c | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 bsd-user/riscv/signal.c

diff --git a/bsd-user/riscv/signal.c b/bsd-user/riscv/signal.c
new file mode 100644
index 0000000000..2597fec2fd
--- /dev/null
+++ b/bsd-user/riscv/signal.c
@@ -0,0 +1,63 @@
+/*
+ *  RISC-V signal definitions
+ *
+ *  Copyright (c) 2019 Mark Corbin
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
+#include "qemu/osdep.h"
+
+#include "qemu.h"
+
+/*
+ * Compare with sendsig() in riscv/riscv/exec_machdep.c
+ * Assumes that target stack frame memory is locked.
+ */
+abi_long
+set_sigtramp_args(CPURISCVState *regs, int sig, struct target_sigframe *frame,
+    abi_ulong frame_addr, struct target_sigaction *ka)
+{
+    /*
+     * Arguments to signal handler:
+     *  a0 (10) = signal number
+     *  a1 (11) = siginfo pointer
+     *  a2 (12) = ucontext pointer
+     *  pc      = signal pointer handler
+     *  sp (2)  = sigframe pointer
+     *  ra (1)  = sigtramp at base of user stack
+     */
+
+     regs->gpr[xA0] = sig;
+     regs->gpr[xA1] = frame_addr +
+         offsetof(struct target_sigframe, sf_si);
+     regs->gpr[xA2] = frame_addr +
+         offsetof(struct target_sigframe, sf_uc);
+     regs->pc = ka->_sa_handler;
+     regs->gpr[xSP] = frame_addr;
+     regs->gpr[xRA] = TARGET_PS_STRINGS - TARGET_SZSIGCODE;
+     return 0;
+}
+
+/*
+ * Compare to riscv/riscv/exec_machdep.c sendsig()
+ * Assumes that the memory is locked if frame points to user memory.
+ */
+abi_long setup_sigframe_arch(CPURISCVState *env, abi_ulong frame_addr,
+                             struct target_sigframe *frame, int flags)
+{
+    target_mcontext_t *mcp = &frame->sf_uc.uc_mcontext;
+
+    get_mcontext(env, mcp, flags);
+    return 0;
+}
-- 
2.46.2


