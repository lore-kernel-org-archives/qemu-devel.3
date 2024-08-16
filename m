Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE86C531DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0TP-000769-5J; Fri, 16 Aug 2024 13:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TI-000698-KO
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:40 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TG-0007Pj-E2
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:40 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7c6b4222fe3so1404927a12.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828237; x=1724433037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+bsO6A/4UIjh+UAI8JcbcWlILl99UyeWUeQ1BHs21E=;
 b=iuIru8regYdy64/oH/ZmhA6zBWnfOZQA2a8n6yvfhRiliHAeDmxsgzFrkrAISuELXG
 aPLQe4mQQ1RNfHyO46Lzagu8rXcqCvjWJsDy1wkel1jaf6eXYm8s7ZQksGIYNqqWqR/K
 RHT1RRuULON/USd/EfQQQ8h+HDdwmB1FlBdWyqc8rzgSBuxhWtg71T2zxdqCOPAREtAL
 mSE0m1N/YX7pHBxmZA1x8fXQXOpo7N1VxlBozdSxgNjsvwunX8NKyjvRsbjfQH/yuqD/
 Nv7OHc6gMJh9pumRIJcj/BiVt2HoLa3YyKk162ov4fThfJjaE6A842dM93AH1xx5qqXy
 D+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828237; x=1724433037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+bsO6A/4UIjh+UAI8JcbcWlILl99UyeWUeQ1BHs21E=;
 b=cFuLjCydxljMAiG6a/qd+18R8SdY4JcjD6rWIHAMycPnfxcSw5s2aqvswb0uoQLFUK
 ZJUgL+m1ew0gPlcK/WcoW4I6w3GXUdTFRyWI+pm+U/gg8UJWenf0kyYQWCQHJGpgES+B
 G3TcqVMa/wuS/aQX6SeRnSFhB81QLf5BPPbStT9vJAlBZ6YGovC0hL1/DyV3goTdNw59
 MqwfOpa6jyxY34f2Cv/czRcwmloqhVBT1L2fQpgc7ShhAwocKrlgP5z8cs8oeR/BU5Sz
 7AQ4i9MzQ+4+ZJseL9y7jaiAh0jrMOKnpw4yF+5xoJv8SeKcA+gHm4lHKulx7AQwvUHo
 WpdQ==
X-Gm-Message-State: AOJu0Yyuu1p6quBDKaffxW8aWAgFFpEJlhMEJ8nR5/7rsG18NalSxgB1
 qR1tHWMD8A5Q2DHO2CiWVnfNX4Fz7kjX72SaXZlLX6rq0y1CqXXmvQpZqAn/mRU=
X-Google-Smtp-Source: AGHT+IH7ao67LJ4flg23yJUplV/POt3Du98roKvuaxnAGrwEhqb0IemDYsCi09oGXaNKTC2VHDDUnA==
X-Received: by 2002:a17:90b:4d8f:b0:2d3:da82:28e0 with SMTP id
 98e67ed59e1d1-2d3dfc37993mr3646517a91.9.1723828236482; 
 Fri, 16 Aug 2024 10:10:36 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:36 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 14/17] bsd-user: Implement RISC-V signal trampoline setup
 functions
Date: Sat, 17 Aug 2024 03:09:46 +1000
Message-Id: <20240816170949.238511-15-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=itachis6234@gmail.com; helo=mail-pg1-x535.google.com
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


