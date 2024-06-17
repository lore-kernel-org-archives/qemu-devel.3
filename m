Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C50C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYx-0004Xe-Ca; Mon, 17 Jun 2024 14:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYq-0004O6-2x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:36 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYn-0004xQ-Fc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:35 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-705c739b878so3731769b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650712; x=1719255512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZAkE2x+3rn50ou2R0RV1RQgcl9m9dXIeubdRtD95RA=;
 b=D2VvmA/HxodUXhiR52QsmwJHMoU4RI1ql9lkLKZQys1O1bq7Sijt70VmWjCmVb24ED
 RlFHra5jIwvNtEkvDAUDLHs31p5DG3pDRvl+GOCjf464uFoad62cUcrug6z9ruEZiEW3
 tYvR3AyJqC3uu3Be2UI3Y73N30UXmO8gys7uYRmBYMmo0uBz7lHdyzjGG3X1B4WdB7ps
 5SS6fPk5Rqi7qgSNYqABk4YRDmNgpVENTVjk8gf0mdodXzhyW9QTPeI6+LU2564xnkeB
 h5Tl6FIzV/Z2ABGkgYD0gMNI/A2T2VYMiltL2F7yoa5oyAgohDxsfS5SM4c3jrn+ZWUk
 9CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650712; x=1719255512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZAkE2x+3rn50ou2R0RV1RQgcl9m9dXIeubdRtD95RA=;
 b=kJgK3pwUiJGc1RYizGFwzxW/v6oQ7SqCnI0Shgt9JGI3wx76aJMTQu6gTOHVi9wbz1
 FXVQdqikjErre/UfHSOQxgkhGwbeVC4SCg3fHYPJo2RNojzx1hNPCZ2bZFEK1uBV6xNI
 WD6VUfwRESXmfXKcAak65oA52eTcJ1Qc2YE7VjXCpUdRawNPEU4T/UvgzFGPMra/57qE
 2SrHMIrTwTUiV3fwHBljBHrae1tdr7QsKwS7+TLrqdeT549ejl+Gk2LN01gMIcoBt6Lo
 yNkaeSCCBUlpFhKwUA43SA5AIAbfv+F5YUGlm6WNk/BxvITFy8WxeE7lepcXvA07HU1/
 MnyQ==
X-Gm-Message-State: AOJu0YwJM6oPh6BcOq0YhcKFncFZ6fbTPD59ue/Kq5qnHX6ZAn0y9WYQ
 M9bSvbFc1TjFKtqj+SHV/O/iUORQwpGuwLSXRzE71WbWr9QIsr3jx8gv+BuqKr0=
X-Google-Smtp-Source: AGHT+IHRbFlCvKBEpVFR2cz9r34zw2KyjxSwv+TKD93wEBRq+yIk2O0b4TwQXgKzQAag03a9z2GYnw==
X-Received: by 2002:a05:6a20:aa82:b0:1b7:bdb3:7bb6 with SMTP id
 adf61e73a8af0-1bcaadd3da5mr741610637.0.1718650711553; 
 Mon, 17 Jun 2024 11:58:31 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:31 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Sean Bruno <sbruno@freebsd.org>
Subject: [PATCH 05/23] Managing CPU register for BSD-USER
Date: Tue, 18 Jun 2024 00:27:46 +0530
Message-Id: <20240617185804.25075-6-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42a.google.com
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

Added structure for storing register states

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Sean Bruno <sbruno@freebsd.org>
---
 bsd-user/aarch64/target_syscall.h | 51 +++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 bsd-user/aarch64/target_syscall.h

diff --git a/bsd-user/aarch64/target_syscall.h b/bsd-user/aarch64/target_syscall.h
new file mode 100644
index 0000000000..08ae913c42
--- /dev/null
+++ b/bsd-user/aarch64/target_syscall.h
@@ -0,0 +1,51 @@
+/*
+ * ARM AArch64 specific CPU for bsd-user
+ *
+ * Copyright (c) 2015 Stacey D. Son <sson at Freebsd>
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
+#ifndef BSD_USER_AARCH64_TARGET_SYSCALL_H
+#define BSD_USER_AARCH64_TARGET_SYSCALL_H
+
+/*
+ * The aarch64 registers are named:
+ *
+ * x0 through x30 - for 64-bit-wide access (same registers)
+ * Register '31' is one of two registers depending on the instruction context:
+ *  For instructions dealing with the stack, it is the stack pointer, named rsp
+ *  For all other instructions, it is a "zero" register, which returns 0 when
+ *  read and discards data when written - named rzr (xzr, wzr)
+ *
+ * Usage during syscall/function call:
+ * r0-r7 are used for arguments and return values
+ * For syscalls, the syscall number is in r8
+ * r9-r15 are for temporary values (may get trampled)
+ * r16-r18 are used for intra-procedure-call and platform values (avoid)
+ * The called routine is expected to preserve r19-r28
+ * r29 and r30 are used as the frame register and link register (avoid)
+ * See the ARM Procedure Call Reference for details.
+ */
+struct target_pt_regs {
+    uint64_t    regs[31];
+    uint64_t    sp;
+    uint64_t    pc;
+    uint64_t    pstate;
+};
+
+#define TARGET_HW_MACHINE       "arm64"
+#define TARGET_HW_MACHINE_ARCH  "aarch64"
+
+#endif /* BSD_USER_AARCH64_TARGET_SYSCALL_H */
-- 
2.34.1


