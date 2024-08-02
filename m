Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1169BC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkr-0001PL-Oc; Fri, 02 Aug 2024 04:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkp-0001BP-NP
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:15 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkn-0006im-N3
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:15 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d23caf8ddso6837149b3a.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587712; x=1723192512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8FE/Ll6DBKsEYjAGjQqiBF49MXeOY1ZfpH4syYlI+1c=;
 b=OOHt6Z6ZL1ta7xCM+07Vh/wg3Snvc+B4GdNWOFwcvV2Iq55q4UA2vTu9AUG+BYzGdx
 A4GMW8pnQllndvr6vnFO7CQ+pm7w59M1ZiGg2TCryu4atACpUcs63JiP/WSRPoxaX6hn
 BXp/wiD+HjRHyIeJ/QnIPL/3x8LYHA2QurCWWGVi84OawfuGlczCCWnO1+LbsYUk5e4j
 Ok8/vF9nHLm8GKlffYzgVf2ZZrSlpA42hKHllgRTIZFUInHa/J8TaZW4nLsKS1zNP0Hr
 n4otZ8I2c3MwaMri4DLqXrS1YEceyNDBV3G35jfiwC48pd0ZxJNgy6WvHCAM+8/jeRby
 4fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587712; x=1723192512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FE/Ll6DBKsEYjAGjQqiBF49MXeOY1ZfpH4syYlI+1c=;
 b=dKZC/vMSWVgHXxmqAt7B7FWbBtRAu195nEwegllQ2LKSt8tlyaSSi67k4HOxuLGznB
 4Y+7iWWK/pkJ3BwgN28BUTucyMG6lhAuGEOtK/xfVtLcXz2PtAmfOlo5rGkftYakHWHH
 g7KG6vuiaRbhJnYUS01LeDFs0CjxXlSDrlA5g5uOnuST7SmgjeRPdvAxfPoiyekewsbL
 of0qhbL2EQ1PG9U3uki3JWOCPd8QOOEAZuYxzBmHo0wqdZbPNPihL3o8sPbebZGMtSMc
 MTX9LchMhBc7XndICFxEqtvMh5wu6PdejPBzomcpArq6C6Ypkcfhg/gaPbmS4nOPaVyp
 OoPQ==
X-Gm-Message-State: AOJu0YzA0DqbJ3eQNGsdgH2wFAJJoUErNlVrUqgH7IUCGUKq2Df4F16A
 D+khIqhmdMWixtMoQCctxgRdQQSjxnpTXsxhctAqEpzAsYUV+iiamOj0fKDPIvA=
X-Google-Smtp-Source: AGHT+IHCpxxPM7YAo1h8iPbX7p9XkmUVkXpgSRKGMNZhOgjhu7R0NvAKdxiyVCfDRLvw40kpfLmWTw==
X-Received: by 2002:a05:6a00:845:b0:706:5d85:61a5 with SMTP id
 d2e1a72fcca58-7106cf9e266mr3398986b3a.8.1722587711649; 
 Fri, 02 Aug 2024 01:35:11 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:35:11 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 15/18] bsd-user: Implement RISC-V signal trampoline setup
 functions
Date: Fri,  2 Aug 2024 18:34:20 +1000
Message-Id: <20240802083423.142365-16-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42a.google.com
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

From: Mark Corbin <mark.corbin@embecsom.com>

Added functions for setting up the RISC-V signal trampoline and signal
frame:

'set_sigtramp_args()': Configures the RISC-V CPU state with arguments
for the signal handler. It sets up the registers with the signal
number,pointers to the signal info and user context, the signal handler
address, and the signal frame pointer.

'setup_sigframe_arch()': Initializes the signal frame with the current
machine context.This function copies the context from the CPU state to
the signal frame, preparing it for the signal handler.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Co-authored-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/riscv/signal.c | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 bsd-user/riscv/signal.c

diff --git a/bsd-user/riscv/signal.c b/bsd-user/riscv/signal.c
new file mode 100644
index 0000000000..005eb53cab
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
+     regs->gpr[10] = sig;
+     regs->gpr[11] = frame_addr +
+         offsetof(struct target_sigframe, sf_si);
+     regs->gpr[12] = frame_addr +
+         offsetof(struct target_sigframe, sf_uc);
+     regs->pc = ka->_sa_handler;
+     regs->gpr[2] = frame_addr;
+     regs->gpr[1] = TARGET_PS_STRINGS - TARGET_SZSIGCODE;
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


