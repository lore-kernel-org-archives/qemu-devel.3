Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE9BC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZK-0006ob-Jg; Mon, 17 Jun 2024 14:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZI-0006PC-1p
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:04 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZG-00052S-5x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:59:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-704313fa830so3580891b3a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650740; x=1719255540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/fzCyFPBesaMQSSyYvgJsbwN+BoXVnIEOpNMGEgrfSA=;
 b=cOJVpLSf4tHTxdk8R0MeulafszTUDb6PhKpzy6kzmqhiEERVoeo/hE/ZvsBmjsC9sZ
 mY3/lW+mtgNWlYqu7aJTc72mV9/YGYuGduejpfTTV1QxP4ADnbQ2pFLMXjpiggWa0NfS
 Sduw+CJIC1MsLDvQHK7BfjQb3l7+Xh1A/Y23GiKj4SOe/CXQY+mmt3N3h/6VEkO8aMiZ
 AtVgI32USGVYuglne8y+ThRPRNuw9Juvapia4pIr89t4WqC6u52AkhqpGAa5xLaA7JAI
 17WZqp6IVHgXSIZ314TKkImISEcJEl6hsMVgybfajlGalJ+ho8NsFcWZfAw3GiP1fvAd
 gTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650740; x=1719255540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/fzCyFPBesaMQSSyYvgJsbwN+BoXVnIEOpNMGEgrfSA=;
 b=GrO9XLVtHin2j+Bq4XNp69ActFOkEEMpaepA9fkBqo6r/WDkQjXd4iUH2F+TEfPoGY
 DkWaDOGpKZ99Ckt3+ysgQbwk1avHYt4LH4NJO9if4pneAX2ttUzNlMcPtvSXpHrk1h99
 KZjfK2wFCj/wIkS95s0yObxycuJ6qYNgfZoXI/Ms1M9Tn9w8A9MfKdnOSwF3c3K4qEKJ
 RTlA0zSDbK0IrstJpPn4wqqSBQuSB/20Uv3hCe+zNlPFV5BCNI55k/U9Ihkw1jqYPwI6
 Yq65dFBy/yOKHi7JNFyfb57V/EipMdRHMljpREpZDayTw4y504+QDnbE1BxBtaF7P4Vw
 8oqw==
X-Gm-Message-State: AOJu0YyEGQ6cXctnR/nAvwyqM1GpXAhaDNGun3LfGFlxCwdvc0xNF7dr
 VpqiVRv9PIxGXyjZGGJIG5JdS/CRTWvjZJF+BxkzZnbXWsUrIW4eahsYTTKPzn0=
X-Google-Smtp-Source: AGHT+IF6tGJ9xx3DM92CnTu3HnUjTzh/CkVIZXgzKdcEiMU9asbEsj7uVr4kPJO5tMp1CK/HIHwNSQ==
X-Received: by 2002:a05:6a20:2584:b0:1b7:8fe2:439f with SMTP id
 adf61e73a8af0-1bae828ee1cmr11545410637.38.1718650740317; 
 Mon, 17 Jun 2024 11:59:00 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:59:00 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 19/23] Add ARM AArch64 signal trampoline argument setup for
 bsd-user
Date: Tue, 18 Jun 2024 00:28:00 +0530
Message-Id: <20240617185804.25075-20-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Stacey Son <sson@FreeBSD.org>

function to set up signal handler arguments it populates
register values in `CPUARMState` based on the provided
signal, signal frame, signal action, and frame address

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/signal.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 bsd-user/aarch64/signal.c

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
new file mode 100644
index 0000000000..98861f9ab3
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
-- 
2.34.1


