Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73429EE6442
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socR9-00086Y-Lm; Thu, 12 Sep 2024 01:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQq-0005tY-0y
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:53 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQo-00039T-5m
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:51 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7191ee537cbso412534b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119109; x=1726723909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P36rIm3k+ox30i3dfuK/oNDXOR5kab8ZxM5c1Oh0acY=;
 b=R5VuzJum2b+o+gCL6ks5V3ifePn0uxBaPjZ9a2rpLP98dPgki4t1nMqjsRTl7weIAC
 4k/gHm8Jn7Ftig+vAsi3xzDzAJNT0S64hX4O+zX3m6deD1cZjgON0KMZ66oAzDVrrWIL
 r/AEO8tAZCksLQD11vUrW3xbC0VkuUnoQDj15pjAhgYs+m4EjIL6mNLMpnHr7uKEHR9i
 hrvhaH3V0fSfCn0fX/qlTQS76EhPiKcCncrhTf4fk90p2toO+jZOaT3IO479Z7fGG4XM
 UlArBi42SGzwo3/f9lKL43YO26jnR6MMHZsQnRnoUd9B7uXsXyh72HPQSAY4uTAX/bnS
 7A9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119109; x=1726723909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P36rIm3k+ox30i3dfuK/oNDXOR5kab8ZxM5c1Oh0acY=;
 b=g4xY+SulPO7k0L4Clvo14z3+kMdG8lRlMjXXxcstQTDKzJxQdSm33Nx7a9f2yYnynE
 NF6Th5hKPVUPh2UFahyOh/mYm+x664Kt0PePA4SFnffM5huHt/GyOKqTnJsWtJUSCO5e
 YqFDCxjkCsxSiOLsx/eQjQH2OvMhr2K3c2XMhs778PQy3ggeOacBAE4Hrfz4mLOCkTCY
 58OQObWHQISUdqzm9l70h8UuMHpZny9eGAWh9S9Vjn8zvXIF2qgVEFOhgvkPXUZpXXD7
 KfHkPIrkaX4Ydnwpj1cQuCm1pkU0lCVsemanEGQd4QehVrka8hKu55wPBOBIoGmTrO+D
 kusQ==
X-Gm-Message-State: AOJu0YyXX4sMRPhjwSlewBopBVoo1EcCVcXT4ROF4xSX92q+TFtMeRwS
 1ysNlHH3tIaTCXrpclGUYiJAe+o759OHq7MRhgs7tIm954i5IqInuoLH8w==
X-Google-Smtp-Source: AGHT+IEXhm7ZfeSw24XnS1aTL+zEA3e2Y04XgXO3rA16g3/ig6Fif+MQAaSQW6XJP5cD6vp3NU0jhg==
X-Received: by 2002:a05:6a21:e8e:b0:1bd:2214:e92f with SMTP id
 adf61e73a8af0-1cf75eaeaedmr2309668637.14.1726119108624; 
 Wed, 11 Sep 2024 22:31:48 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:48 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/47] bsd-user: Add RISC-V thread setup and initialization
 support
Date: Thu, 12 Sep 2024 15:29:39 +1000
Message-ID: <20240912052953.2552501-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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
Message-ID: <20240907031927.1908-10-itachis@FreeBSD.org>
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
2.46.0


