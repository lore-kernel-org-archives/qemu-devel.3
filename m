Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E82CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDtd-0006qs-57; Tue, 24 Sep 2024 18:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtH-00055G-7L
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:17 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtD-0001yK-9R
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:14 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-719b17b2da1so2459655b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216409; x=1727821209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUaBAQ2R0O3HskPzaR10RqZVIGyIUjyGLR24zdWubmM=;
 b=VIuJNgpxomEWxhLo+FG/m+4x+ZqqmCTs95miujchAq8G1QzOiKKyomf6NuVoH7aAM2
 OwFuvYr3GCPYrJKRLFRyod898aJoidduESFGrMdAD0JaWvf6lEjvh5D4TVq5SQ/wU7ou
 oHXM05eHRzpwS5S4FABYX5vzcVXEh+HYIqjD8e98p8tRsGoqR+A48j54uVHBTO7tsuAL
 41e2uOrI5Xny147AEXaKRDEJ1BTOV6LSr+dZdV0Qg0kN7UCWzbJ5bnDN5rM3oYPkIQVK
 vT8UwZzZuFbIi86SPHjZNClDHhhx+QBbhZzNFn1SURZtHOiOv4FmSfu0aqCXZnpFtYVO
 e8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216409; x=1727821209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUaBAQ2R0O3HskPzaR10RqZVIGyIUjyGLR24zdWubmM=;
 b=DHHdlzTg+xlo/qh+ckd/FAuTYaJyjppHeKgHoHG+6CHCO9AkmGx8K4zGdfoz+O/18Z
 8KpKx2Zq3vliTrKJTJCB6iXMo1hP6QJpe0YjG+tNj9L+tVu4t8yhwai40F2ZVbFO+sMR
 XM6duPfTPx9ewgW+BHCcEXhV1vfKWY2x8ewoYZahi5kkRRM67BuYzSBJhoEr/LKPtyQl
 RHCgSosNJMMBNEKsnrDns+INxVzgB1w6pVRQGzN/S2mxDXRpm83TsVTRSdcbQ2E8R4iS
 uZpLzB6NTJbKFAMPEHF2hTzUAjy9gAMtHWwhE4bjddtnGacNNolRhV3A24d/UMsp+DqW
 foXg==
X-Gm-Message-State: AOJu0YyiRBj9H34d4rmycDUlaJeZSyAahdXg/kKSSoqte87314Vc6XUD
 9o0Qf1yQQe51m7EHrH7CngrTl+LdGSEthLgPw0SHsKXE1AmOGrWHkzqX5w==
X-Google-Smtp-Source: AGHT+IGNg30UR6iBPo6YYJ9zedCf2irbM55i7PaOCaX9KjSDd30it1SdWzc1ELq3dkWshLNn1FyVXw==
X-Received: by 2002:a05:6a00:4606:b0:718:ea3c:35c3 with SMTP id
 d2e1a72fcca58-71b0aae9553mr836565b3a.15.1727216409234; 
 Tue, 24 Sep 2024 15:20:09 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:20:08 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 39/47] bsd-user: Add RISC-V thread setup and initialization
 support
Date: Wed, 25 Sep 2024 08:17:40 +1000
Message-ID: <20240924221751.2688389-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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
Message-ID: <20240916155119.14610-10-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.1


