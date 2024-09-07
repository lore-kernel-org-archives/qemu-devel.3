Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24170CD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smm1l-00079i-Pl; Fri, 06 Sep 2024 23:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzt-00045J-1h
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:31 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzk-00055h-J8
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:19 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fee6435a34so24979445ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679214; x=1726284014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+bsO6A/4UIjh+UAI8JcbcWlILl99UyeWUeQ1BHs21E=;
 b=nCMfsn7AxDRj5Kr/Fzv2XBtRMTVE8zODKQl5uGHJ/miNVcdrZklfdfvqZERHdo2/Nn
 xl1Gw9xAkp+N5Lwi5U5PGXugYsURYlaqnGf0EnxLVaW2hYCD9tlTjA/ppaO/KXQqOdCV
 maFs3hBkZwTqFa730hMzJsghsYoex2/J/sPuOW6LgXJLJfx0Agii9OS8wKBLS67zSBgf
 +jl7lI8qnMga3yiVlQi+Kz7ZkMJeELnUv+XOJcyBNJUlU/g5RUhI7zgZKzXDwt3Cmhp0
 FZY90e/DjWZ0ZtoSRYzil3wQWIToSWs0wFNosqWtRaibLZH6D4nJXnLEwV0xUWTCcLeB
 J4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679214; x=1726284014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+bsO6A/4UIjh+UAI8JcbcWlILl99UyeWUeQ1BHs21E=;
 b=FFJYoE4+rcVkqU1cuqrhC9vdOLXd5mIMgDCMM3yla1qXeb+6G3GytUuCV6e3jiy+Wq
 a4BBIQgtggWgB4nE8sTnD+Mqtl/GLpRWvgzxJByvKNz03zhepH265bdH1yOgANtZg1UQ
 BQhWwbwAZgSS6j2iCZn6vfdXoiYbdFnDAVNo0flltvMUVsPwoPlh4h9wOjNoVb8p1blM
 /QgBS83f1L4+9kLJAmw8FuNZwo+kdmAEP0Xw/f+swTTYOwS37jGlOWoR7MKGY04NGA8D
 bOvVFC5f4yg+CdiTvxr4NTvg7/cO78uOCN5oHBAyalZJAB76WTZvV7k68ybzIp3EIKkl
 mdqw==
X-Gm-Message-State: AOJu0Yz6vCbOt5kLFHZu7Il4E29MFyU7vcTZ4cAw4ea8Y3Mqd7PsV+nL
 XSt68+SeW12Pt9elze7PVW6/IADH3/KUPzq6oFcuoUHbfAd+tShHgKBjfg==
X-Google-Smtp-Source: AGHT+IEwsGaz9Z7qOId82Iuv1c7ez+ds6Smp1uwfYAK1bd9I2UVzrJkTPOpSEuwv6IZ9b3snINHfxA==
X-Received: by 2002:a17:902:f78f:b0:201:f0c7:6a00 with SMTP id
 d9443c01a7336-206f062306emr55056325ad.53.1725679214089; 
 Fri, 06 Sep 2024 20:20:14 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:20:13 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 14/17] bsd-user: Implement RISC-V signal trampoline setup
 functions
Date: Sat,  7 Sep 2024 13:19:24 +1000
Message-Id: <20240907031927.1908-15-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62b.google.com
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
2.34.1


