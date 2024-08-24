Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E971C52D6F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 04:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shipx-00078i-6L; Sat, 24 Aug 2024 00:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipv-00073N-Pk
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:15 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipu-0002GU-4q
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:15 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70949118d26so2465987a34.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 21:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724475433; x=1725080233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lh8KOQwJMj+hbdZDJmsAuuccSG6XdRdYqvYltME6/k8=;
 b=HVSgsSiewx57ea8OauCF9763hKW57R6A3AxChR5HTkr9Qys/xDCeaf/ULV0b8cfUC4
 xM7MYX8FvfQBa8ihO7km2+8Vlc8JhOQDmQ9hTyurzKJZnWMMDoCur31Lo/r1px+mSeFN
 XXUKG6nl3aWGp7QsyEA9Ov2Lsd3HcR5tN+gFqhc2qWpnNGA4W1PsT8b71XTK6oGEEvmD
 2M4u248oezOEVn84CLxE0lamtFVTCLCGZ43QQt8IIcnhhXT2PbD3kGdqovXVW1SIQwxA
 aQ4WBmxb9qpTFz1j7/akxcyi1j3byWOvGqK4S5+z9mCYlDWWm8E6u4KlPCPNEyYb4cK0
 d0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724475433; x=1725080233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lh8KOQwJMj+hbdZDJmsAuuccSG6XdRdYqvYltME6/k8=;
 b=prJ/JKR96PWCBx697qQE3/pnoLM1zcEtfaU6Kh435v6XKUYeZCQsXzqiH1FXuVQMzE
 aYC+OZkvw9BIsDiqWCPKtyjGX9lf0DZ+vMlf3qEzXXKRBX1UEYQIyuanpVjMwGMnOSTo
 R+iRFCVQApA7i+ngz4ByLSHdmN9rD5JFleJwBxPFvL49Adnz9zb0u149LTU3TJsZizzD
 th1v3/xjT2YzzD5hy+qa0L0uGMWbdzfy59TtqFoY/rYIRqNM/u+Q5xsjVS/lBT7SyMve
 247Cc9efWonFBq8nmqBhKVcrsUHxmZ7ZeuAKzWMLGRtfSTDJ5o1tPspaB0xxvEKv/ubM
 78Qg==
X-Gm-Message-State: AOJu0YxD9dbSoCL+2xKujSfoZnW+ivnmLxYLvZGSG36S5D/Bz4srUZSc
 i5qs4Jk9Os2dZ38x+c9KGblRxTMsKsigPfyeEtpNRu5miKw3Tn3j1DPkvSe+mWk=
X-Google-Smtp-Source: AGHT+IH8Jk34/i/Y/t8CeVyVP3fRCUM/J/MBSPgh954fOBCJOhuAGCp2zKRd2WQljIOLEbBdzQMNFA==
X-Received: by 2002:a05:6808:150b:b0:3da:b35d:52e0 with SMTP id
 5614622812f47-3de2a8d671amr4980815b6e.43.1724475432650; 
 Fri, 23 Aug 2024 21:57:12 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ecedsm3805934b3a.25.2024.08.23.21.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 21:57:12 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH v3 09/17] bsd-user: Add RISC-V thread setup and initialization
 support
Date: Sat, 24 Aug 2024 14:56:27 +1000
Message-Id: <20240824045635.8978-10-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824045635.8978-1-itachis@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=itachis6234@gmail.com; helo=mail-ot1-x336.google.com
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

Implemented functions for setting up and initializing threads in the
RISC-V architecture.
The 'target_thread_set_upcall' function sets up the stack pointer,
program counter, and function argument for new threads.
The 'target_thread_init' function initializes thread registers based on
the provided image information.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
---
 bsd-user/riscv/target_arch_thread.h | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_thread.h

diff --git a/bsd-user/riscv/target_arch_thread.h b/bsd-user/riscv/target_arch_thread.h
new file mode 100644
index 0000000000..db0f9eb52c
--- /dev/null
+++ b/bsd-user/riscv/target_arch_thread.h
@@ -0,0 +1,47 @@
+/*
+ *  RISC-V thread support
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
+
+#ifndef TARGET_ARCH_THREAD_H
+#define TARGET_ARCH_THREAD_H
+
+/* Compare with cpu_set_upcall() in riscv/riscv/vm_machdep.c */
+static inline void target_thread_set_upcall(CPURISCVState *regs,
+    abi_ulong entry, abi_ulong arg, abi_ulong stack_base,
+    abi_ulong stack_size)
+{
+    abi_ulong sp;
+
+    sp = ROUND_DOWN(stack_base + stack_size,16);
+
+    regs->gpr[xSP] = sp;
+    regs->pc = entry;
+    regs->gpr[xA0] = arg;
+}
+
+/* Compare with exec_setregs() in riscv/riscv/machdep.c */
+static inline void target_thread_init(struct target_pt_regs *regs,
+    struct image_info *infop)
+{
+    regs->sepc = infop->entry;
+    regs->regs[xRA] = infop->entry;
+    regs->regs[xA0] = infop->start_stack;               
+    regs->regs[xSP] = ROUND_DOWN(infop->start_stack,16);
+}
+
+#endif /* TARGET_ARCH_THREAD_H */
-- 
2.34.1


