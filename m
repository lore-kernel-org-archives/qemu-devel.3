Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8A8EE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socQx-0006V9-Ah; Thu, 12 Sep 2024 01:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQP-0003v2-1m
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:28 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQN-00036A-0v
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:24 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7179069d029so372263b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119081; x=1726723881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YVK9TI3s4BFy65/tNanCHqrpz7AQul+OpsDeLsd5Jhg=;
 b=awS8w8Qmi6CP3FT//LU3xKRetvCH8LGhOFE+yNU5uz7y3SrTjbe3DNIGT773gK8p1w
 2tPc1phPN+cQFC5q46qXMkYZBFbRjVC8IYq3hEhFZPEW5lMcsn7FNOpbT9U7DpP6kNVC
 PbgpY2hpv6+zZJf5VtLRh/m0R0DZyq+3q++GZUPi5HKhsPrD5kNJ3k+WUDXKGh10Z6fJ
 RzFUoOeyIvSMXT1kfOdE3OEIdSKC6FebVdxmbrEDb5XhcCGZVO9d4FUQ4pSoN0vMIyAY
 1spf1g/JI2OokNJdS+kPTBIfr08fgJnn8rv6MKJPcRgcpLXUbzCNH5vzgtzsI4P2iKzY
 UdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119081; x=1726723881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YVK9TI3s4BFy65/tNanCHqrpz7AQul+OpsDeLsd5Jhg=;
 b=jdLdSj+l72cOuPcMVbuT/OjtTj9yqsHhID4I6npimpWQJ2ko9bRNhaHkpJ7c55JZju
 mFh1ujaAVmeq6PqvuUx/4CCE2L4BKZ9x83ZIOXoCFIj8PIHUGk/24Q6LFFLRP52njlm1
 Hge6YOKpvyLML7DiBJTqCr20MG+HNJefvUq39DWjpWAtTs6HiJACd8KRpZYystUedEGY
 CACBlZccDeLg9KcSD8b1TTtYKFogAp3a1E+AVxpEw7zrphr6rREWNREkuKbC9UKeJLZz
 WYFGKpANMEqyoi2Hm/uBxbB8tul8E5la6lbrPCSuVz+321xMOrruLiBwGlzvt62tjUwU
 rPNw==
X-Gm-Message-State: AOJu0Yyg3OJXbsXXWw3zDsjUXFEYNT4szxfuQrBRTH1Y9mLVtgPB2tOh
 kjW1G2F9c0jQ0xTYSaERJGmCf2nNPyJbSXDDm8I2m4xU4nBbZO78sWcoqw==
X-Google-Smtp-Source: AGHT+IEVoM5te6rM3HJ2Ot5U9uDXTKZRhUfY6u7/I8ETDgpBHJkylQcM1KIW9fWM2EoX0A3mw73oTA==
X-Received: by 2002:a05:6a00:1804:b0:70d:1dcf:e2b4 with SMTP id
 d2e1a72fcca58-71926059119mr2673129b3a.1.1726119081211; 
 Wed, 11 Sep 2024 22:31:21 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/47] bsd-user: Implement RISC-V CPU initialization and main
 loop
Date: Thu, 12 Sep 2024 15:29:31 +1000
Message-ID: <20240912052953.2552501-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

Added the initial implementation for RISC-V CPU initialization and main
loop. This includes setting up the general-purpose registers and
program counter based on the provided target architecture definitions.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240907031927.1908-2-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target_arch_cpu.h | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_cpu.h

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
new file mode 100644
index 0000000000..e17c910ae9
--- /dev/null
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -0,0 +1,39 @@
+/*
+ *  RISC-V CPU init and loop
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
+#ifndef TARGET_ARCH_CPU_H
+#define TARGET_ARCH_CPU_H
+
+#include "target_arch.h"
+
+#define TARGET_DEFAULT_CPU_MODEL "max"
+
+static inline void target_cpu_init(CPURISCVState *env,
+        struct target_pt_regs *regs)
+{
+    int i;
+
+    for (i = 1; i < 32; i++) {
+        env->gpr[i] = regs->regs[i];
+    }
+
+    env->pc = regs->sepc;
+}
+
+#endif /* TARGET_ARCH_CPU_H */
-- 
2.46.0


