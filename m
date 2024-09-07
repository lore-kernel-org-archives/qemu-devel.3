Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451E5E6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smm1l-000776-LK; Fri, 06 Sep 2024 23:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzZ-0003UB-2s
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzX-0004tR-5k
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:04 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-718d79fb6f7so1269130b3a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679201; x=1726284001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhgZSr77cs856626csVUMKafDNElH2DCETLtbp74JlY=;
 b=HIt7zlN9TwX9VNSZ9iXBxdku/wKcv5F1kBa+W/S7XJ2HScD1GAVNo9UMCvO+GK7ii/
 BgMN0rhiXbHZ4gJ44YgX8hhBuQ5VyeeKYsLdR9skOCoYqhbQuupGQuxoLVsdmBI7PxGr
 3fVVjXwEYsPPVusITgkuG3TGJ+1fly86VWWAjm0y6PSVIHlz09uLegmq02fv8l2X9H85
 NSEskOTJIXp3c9FeDnHb5x9zyPsUpPoS6K3r8pjoLo5DFW/0kcZ8NNWNiDVGg2i7htY2
 CW0ki/tUoWBLUfDX87twgMRcDJ9bO0jKDYw/UOVB5iXmqVqHCd9axrxXy6GSAiTcAvLu
 G7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679201; x=1726284001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhgZSr77cs856626csVUMKafDNElH2DCETLtbp74JlY=;
 b=vxEv1EBEE+J0XdLr1QahdGN2zHN4RjXmc6dbFtVoJOTJwc9ztXuLeTXkGFRLn1jkmU
 NPq5e4jm1y4cRLA0r8E/fArbGP1AEDoG+sX4LCqgFvD70KaNtLOwJ4SitlkgWFtnIzKg
 ZdrmmXVF6/BbwjIKPWTvZTz/Y1WT1f193ucCmpHVoLPQFDDc6lVjU+SWeb0y3QbOU5pp
 HTrhIJXyxNrPV4p7uebGiDLcf3F1Rk9IwFNHvnP/Dm/CR11tZQLKiUz+bobOedWFGDOV
 OwiLcFBuORT9A6vFrSsVkxKIh/f2KH/DrE76o4TmpJHMGKPvlkNjzrPjkYXWm3j7LkfW
 oedQ==
X-Gm-Message-State: AOJu0Yw43o4iXttaqwJyRtLNhtjfhf7xm6JRItknf8lr48h7I5feVo5Z
 +o9kgJNIKHFsG3hNYHys3IjYr6kzWNFAHMW/fksnl0hHf2eEHD9dQCF0/HSb
X-Google-Smtp-Source: AGHT+IFGXLjjbfflLgm8LWYWRQa6AWQPNCfY9vh9gNK/nUCaaPDtT5MSQTeQ/dgnSlrxLYw5NuQHRA==
X-Received: by 2002:a05:6a20:2d23:b0:1cf:2ba0:c36d with SMTP id
 adf61e73a8af0-1cf2ba0c374mr1142481637.3.1725679201242; 
 Fri, 06 Sep 2024 20:20:01 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:20:01 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 09/17] bsd-user: Add RISC-V thread setup and initialization
 support
Date: Sat,  7 Sep 2024 13:19:19 +1000
Message-Id: <20240907031927.1908-10-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_thread.h | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_thread.h

diff --git a/bsd-user/riscv/target_arch_thread.h b/bsd-user/riscv/target_arch_thread.h
new file mode 100644
index 0000000000..95cd0b6ad7
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
+    sp = ROUND_DOWN(stack_base + stack_size, 16);
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
+    regs->regs[xSP] = ROUND_DOWN(infop->start_stack, 16);
+}
+
+#endif /* TARGET_ARCH_THREAD_H */
-- 
2.34.1


