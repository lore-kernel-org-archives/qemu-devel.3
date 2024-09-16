Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF66C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE1r-0001MR-70; Mon, 16 Sep 2024 11:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1e-0008PX-17; Mon, 16 Sep 2024 11:52:31 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1b-0000XI-Js; Mon, 16 Sep 2024 11:52:29 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2068acc8b98so41073755ad.3; 
 Mon, 16 Sep 2024 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501945; x=1727106745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+bsO6A/4UIjh+UAI8JcbcWlILl99UyeWUeQ1BHs21E=;
 b=nlKjiSdP+4HJwblDeNkYylJVNc3t7CPxKRcW+NWhbwcl9mLEHjtqNQGOwfvIptRW+r
 pqEeZst1LE6tloYcnD2ZewSqHvqmrW72q2iA3n0XRbjoDzoAyu0utLMvf0sqzYWLzJHe
 ixqsuxuDa8bzYY378PI0ICVbNFar98nXuUK170jbY/iAHB8kMxebyeZB14xEERCAXyqM
 dZY7rYshbeMrqF3fhQW97YQtJBs7+DHh8XaYXmmUF9evGz2hGfkmAw8G7zkv4AFDLmPs
 k/vFjSaNN9Zf3GspziM5P2YHAjvsLznE+9CXgNcK1B8Fkprs6I90btMPiXse9wQSvgrf
 bGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501945; x=1727106745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+bsO6A/4UIjh+UAI8JcbcWlILl99UyeWUeQ1BHs21E=;
 b=RE/DRJI+pJhoJNqY4P71ly6aLQczCNvnDNqjhsp3wqE3OKBtwpKovCksyvnsUXQaeJ
 +w5TE+d6078ksJUGYwHaJsWwqtlcDNYJCTf4zV6foK1EaO7+uKTU+N63nBks9XoLuCZs
 tIKJyKBHsfyM0fNq3Utr6tk5x1bf1FUP22z7W+MQR+7nmtKWpv7Lnj1fzBrRETNdU4U7
 fH64TJi+Kbxy8a03gh9+3QSzmyCcNqhV3qBtVig7O+FjBZDfR1M5N8g/xAOizxQrPXa9
 QrvEnBkgLF2Ag2uk9N/vTmPYfzHZZk3lEoCodyDi8VKaIinUfQdJldHW8HUoRWymX4Ls
 C+SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmoh3SNxeTjIg8ExsAWAXBwvt55EMT8aAs2s1MkJMe5jwosAwefwgk83a2qQkO9YbfKbVvP5hhw2Qq@nongnu.org
X-Gm-Message-State: AOJu0Yw7MEvnNPm58RH7eZJ4+3UuzL/3575EsLmFc+3XqILNjKYJo4np
 g3xA//yXTQfzgG/PJ0sfHkDCndyLxnrpaxHAfF0vnjv3RWdN8+obEH4+K0xq
X-Google-Smtp-Source: AGHT+IE+lLUO/w4LSP+HO92NTOEzp4eSgI9EbsewCkTijnq722+MSZfHXVfs0xn0/PvDHLXpnECwWw==
X-Received: by 2002:a17:902:da92:b0:207:1696:6ee1 with SMTP id
 d9443c01a7336-2076e31f057mr243423705ad.10.1726501945236; 
 Mon, 16 Sep 2024 08:52:25 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:52:24 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 14/17] bsd-user: Implement RISC-V signal trampoline setup
 functions
Date: Tue, 17 Sep 2024 01:51:16 +1000
Message-Id: <20240916155119.14610-15-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
References: <20240916155119.14610-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x635.google.com
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


