Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1C2C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZD-0005c4-I6; Mon, 17 Jun 2024 14:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYy-0004ju-BM
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:47 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYw-00050R-Hs
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70423e8e6c9so4092860b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650720; x=1719255520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzNcNJmcxrM8qrvXWwUv5T4AhCFaFoLPFz7e7Bb3WVY=;
 b=AyCRXuhbDPtECBCyEtb96Yk/+EPvkAv62BFu5b/jY+M27mA6Jh73FOVdvXVNP3Kg5e
 8rlsszRnbfkEEykVknJKiEsus4IyTBh0TniSEJizINODJeQGVurb1L9Kwol7wxt2e09w
 vclqYNJ41nJoJ5KSOOe872qsZYxdcBYhZ754g2hXJFsJOGvWthAN1q+fHts5boRB16dO
 PeZIyLANDTaEnAja9eXtZZhTvolbiSxjgA4pHNtcJ49/rAmr8Bwx8fAeRncu1e6+jzvc
 LtJTP5PIhE3P5ViHsePfeJpaxLkKW1QKJPS0+gzJR31znHJWBJFd2t3IKpCmHUnGbGWs
 tr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650720; x=1719255520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bzNcNJmcxrM8qrvXWwUv5T4AhCFaFoLPFz7e7Bb3WVY=;
 b=NjNaIwu4K/VBL4p4Dk83lv4vfROIIEzMg2DluC1A7xIUcO3mdxYrlsGqVJF6aogE3m
 BJ4jzYQLp3rd023BGOlvGZaMTNHr+hKs4S+JEzGHvzVrJgJq/ValLNbWynohYwQwnr3f
 Y4hz2JOHjDa5jXrwVW6l9aTn8pnkVZjXZCv/g0wJgPkJeIWpUNXfKafWNIWI8X5k51RE
 6ThbSfedKfsfdWLke9rcaLHG2jzeCwJQaGWdodotjq+NTxK+bCMHS19neIQNWWGK9WZc
 X5RQdePk0XECHXx1frWFWOOi6RJB7gOV046uLoyTMUNiKflnCOc+K3PHDUxhl9KadLcL
 Gc2g==
X-Gm-Message-State: AOJu0YyiawcnqUIn+WNj0fsXUznIgduy4tWUiFIPMbcYA48I0Z1ezofL
 PEJ8lfP0b62UeIEgXAcqasNWLgtrUnttjIqPICU4jrAb7A1XikpYsvNbGFW8ynU=
X-Google-Smtp-Source: AGHT+IHlNMDpZ/3SvXQxrUSYTW3x5sB9I83m8tDse7ckkDNvuGf1DVXq2GPJanDwmYAOQoadSpH+Ww==
X-Received: by 2002:a05:6a00:1310:b0:705:dddf:bb46 with SMTP id
 d2e1a72fcca58-705dddfbdaemr9720103b3a.14.1718650720045; 
 Mon, 17 Jun 2024 11:58:40 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:39 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 09/23] Add thread setup for BSD-USER
Date: Tue, 18 Jun 2024 00:27:50 +0530
Message-Id: <20240617185804.25075-10-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x431.google.com
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

Function for setting up thread upcall which will
add thread support to BSD-User

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 bsd-user/aarch64/target_arch_thread.h | 45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch_thread.h

diff --git a/bsd-user/aarch64/target_arch_thread.h b/bsd-user/aarch64/target_arch_thread.h
new file mode 100644
index 0000000000..d2f2dea7ce
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_thread.h
@@ -0,0 +1,45 @@
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
+    sp = (abi_ulong)(stack_base + stack_size) & ~(16 - 1);
+
+    /* sp = stack base */
+    regs->xregs[31] = sp;
+    /* pc = start function entry */
+    regs->pc = entry;
+    /* r0 = arg */
+    regs->xregs[0] = arg;
+
+    pstate_write(regs, PSTATE_MODE_EL0t);
+}
+
+#endif /* TARGET_ARCH_THREAD_H */
-- 
2.34.1


