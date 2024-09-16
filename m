Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BB9C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE1S-00088k-0l; Mon, 16 Sep 2024 11:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1L-00085o-Ad; Mon, 16 Sep 2024 11:52:11 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1I-0000W2-AT; Mon, 16 Sep 2024 11:52:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-207115e3056so41536585ad.2; 
 Mon, 16 Sep 2024 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501926; x=1727106726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhgZSr77cs856626csVUMKafDNElH2DCETLtbp74JlY=;
 b=EVBs03mRzhJ6j6soJGWVZZ9Xjb8kk6vRxvBAN/UcSrNbHvtdHUaDeFcuVN6IckCOSg
 IMS5rntgEUu+g5rsVGOdVK9gsQzuD2m0dfsyHiSm8JU8dLw3BnxG7S89oMlNWbZZVKtP
 Cz6cJ7KsiWbEb3U2ya9GsFi6UKJ7W+SiztPJyDyTjN7QmkI2+fQvEKnrKdekkdhoQmko
 x0k6duufueJ2gkodC2dOSPlaZ/V3IWAaBKYM7Ry5h+2t9I8ebu0FsueUQKRRsiiYe4KW
 dyrAERDMLxnC8EP3RnIhbb2worzdET2+nAL5kYQZQvSvkXUPMmhFdzKDZBS1g+K2lsZ8
 Vg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501926; x=1727106726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhgZSr77cs856626csVUMKafDNElH2DCETLtbp74JlY=;
 b=qjzBFekKI2H7xOHsx6nRDDtT1MBXxlynOtxcDze9yByef7RqTO71KzHvobs6Nl9zdi
 2yHftJxPw2uaofBKWH4DrRQhFSTS8MnKiXXlGYgmdpzFKVFydPgNM4P3+rnJWqBEIiC9
 pe4dqILnQ8Az0yt24T/c6fRtRpHDBFWBq4bP8UQS6Jk/6c4yshHPGGHyg0K/HO0ANeJn
 rbJDguptcYTTwy8ceFxDecGEDoX8oiRi9ai+Fpz0mPfhzVUWHBkkqOY23CKMeYnpVb8D
 fHowqRkwlsoc3EOvs3wc6krMD/O7P5x5p9P8LcFQvQhDzfLIgCNMVYJf+DbZ4z0OV6G5
 3CiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEByYxqX1NyfCIL/a4Q+D5tMrAgyNdHVE0k/Bhu25FnUFSSBiGkCMbQVA3irtjWspnkuYBdBzwiCFF@nongnu.org
X-Gm-Message-State: AOJu0YxLWwdfNypdlV8lDVolwaiq1fIS3DWi6FtCSuNl4h43MF9IFOql
 MMx2msSTt4yEwojSQoPBMlh9p/5QTDyrQHU4x/4Shk+LK7DSbmpn8Baa1gXW
X-Google-Smtp-Source: AGHT+IHsP1tJLDPo5pa8Vm+5zmPCTcfhgWn001I1rw6IUBRZ51e+rdV5bYM+vnTET+qL12xFete3Gw==
X-Received: by 2002:a17:902:d491:b0:205:56e8:4a4c with SMTP id
 d9443c01a7336-2076e3d584bmr224174715ad.26.1726501925889; 
 Mon, 16 Sep 2024 08:52:05 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:52:05 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 09/17] bsd-user: Add RISC-V thread setup and initialization
 support
Date: Tue, 17 Sep 2024 01:51:11 +1000
Message-Id: <20240916155119.14610-10-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
References: <20240916155119.14610-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x629.google.com
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


