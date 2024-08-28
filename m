Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D02C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMh-0002qu-GX; Wed, 28 Aug 2024 05:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMg-0002ls-9l
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:22 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMe-0001pl-72
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:22 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3db1e4219f8so1039622b6e.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838799; x=1725443599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPq6C7QoOX3nfkGLM/R7pqXc/B3Uq/1K4kEgtZxBVyo=;
 b=e7osteoyyAX4ITPQ2oaW1GxPJiyjPRBDKz3qPpl3BjD9wBLuTrDNTdG3Slf42WhIPP
 HkT9cUqmflAZD2bhhxkRae4WRJjFlRlMWvLxuJob8KAfFD09mtU+S4ooSQ3vgq4z6zNK
 DhBgegADeYOmfhDJj/UP1NR9i7SNHLQ++p6wWV7yjleooBONE64EJBE+VTWr3rbGf3ue
 0yJ99NBcaOKyFfgU6eLrettEMCEamSXXr+rNr70/GOwR51Y8LxT7I65b3nYFSRIIrBOd
 ps1DZQdUuU5BdBPBQGxAThu0g9hiUtJYI21BL7bEW5gUSeOPJWfEe8PmHUahZ13K68Bg
 mIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838799; x=1725443599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPq6C7QoOX3nfkGLM/R7pqXc/B3Uq/1K4kEgtZxBVyo=;
 b=c+PhG7FHhu2jcaEKpF6oD3vv+N+8KYt0nNQPpsLbt5kUIGsrqlZK5s5AyO0emGs5Iw
 DGPgoay29u0x/jvffeXlDT2n7Q4mi/bRYSjI9xerDVsGsgCzlmIgaRQfqpCiwqtnWvb2
 US1O7TV97PB2475+fuqwys6Iy2pnzaBNxrOEjjp4sPcMOdMFqwTBDy5IwVKuRaBEBgQS
 +TZbKWhOhtlej9nqbg4PY4ucqaPSj944q2rYqiS6/6e/+35GFCbdW5j4MO71ZCQK5wLn
 yL/ak+IUJ7eEw+AMDCSzXWZZTEy+xYouRcA63E7pAIvDoGycN8A+AiFb2rhbLuOdthIl
 1X0A==
X-Gm-Message-State: AOJu0YxqUkB6URzbblsrtnVCgkF5m9qys5b5ZJLO8il0ix1n6tF/VQUX
 +cIAYl4BLqm0OKxkGHSKGGDXHzor9oQIzDnx9tuC60wSdi/hkRtbInmvb9Bt
X-Google-Smtp-Source: AGHT+IHH5SQPjDOWMAEw23Z2mhEvqhRxVbVyav43MXN79zxxTrU20Yqgu7eJ8BdHmkvBDVbmiBnuVw==
X-Received: by 2002:a05:6871:3297:b0:261:e19:458d with SMTP id
 586e51a60fabf-273e646d7b8mr17435410fac.4.1724838798470; 
 Wed, 28 Aug 2024 02:53:18 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:53:18 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 09/17] bsd-user: Add RISC-V thread setup and initialization
 support
Date: Wed, 28 Aug 2024 19:52:35 +1000
Message-Id: <20240828095243.90491-10-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=itachis6234@gmail.com; helo=mail-oi1-x234.google.com
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


