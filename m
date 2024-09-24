Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB8BCF9C74
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDsl-0002Nv-4o; Tue, 24 Sep 2024 18:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsh-000284-TV
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:40 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsg-0001jf-0X
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:39 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7db637d1e4eso4426747a12.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216376; x=1727821176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NpLwXmiI9pWqjhROMmRmzba4bQXSWO9US9Anawe7Nw=;
 b=AEF62NhKDyCHGEWl1ytxvUxBiUWZVNjaeiIHD2BbgseWwSWaE2ZRPCbgAfqcbyLA/i
 atqgZXzAN3ptZIvhuNH0dhsXqTnXM9zPmNdyJ6hVTBCXUCIRel+tKtmsoUQJWvYDr+09
 eNoZcDpe9nLJj7t02CjyV426WWfF9FtygfFkuu3Le6JZ2wjdEZoRcwci4MCxGv1GAKb/
 T3H8goRoH0n27zfL4Pa0yVFxT8luUozGBAr8sxlWbgU+4UyO9Fr2jVfwGztOvSoGB72+
 6gfCln03hsfKMAJMRX1wkiVfvHIp8khev0tsyNSM5CxcyvdG5YHLYCBEByB6l1932awl
 neeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216376; x=1727821176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NpLwXmiI9pWqjhROMmRmzba4bQXSWO9US9Anawe7Nw=;
 b=n5Q7refV21ZayTpekbzmISNeqD8DNOrxHNkK4tF51oUPogXmIS72WfGSkRb3O3gA9U
 e1byPe1p5S4q03U7u78H3xYok7s+WHQhPZjQxDJDa573U8HSmVX0n170Qp5nAhRo/WcE
 Jhc17xyjIO9pWCx+A5oqvZmSN2PELKj7Wfm1WBXAv7mU2JdxRAdJtJ85CUhdV4zq44LY
 Y6fXgalO8Q60rwZU+KBQPkAANpLkvfwAW0iQUnCkWH1JqtehCOs/Mt3miQkN4CYKQlvP
 hQooCtSwMJYoyof4djSTw5Leej+HKiYbiNJnbHbYqT7VJ+QJIWn2pru7HpTxyhvYHatm
 fXlw==
X-Gm-Message-State: AOJu0YzzOG+GR8B/d/J13j9I1kP8XhNy7fpKDj696ZEiE+a2L5V4A9e7
 S/yF46hzf7b3QiAKJEHun1uan8onl1RwJOq84VoUdTxV+fhjcIcOFtyXvw==
X-Google-Smtp-Source: AGHT+IFjffdHGYG7DN6m9bUcb/pXjwFyfpN4l629kf/WB2RmvZELIASXTUndVOey625YHDrRzky0zA==
X-Received: by 2002:a05:6a21:1693:b0:1d2:e84a:2cb0 with SMTP id
 adf61e73a8af0-1d4c6f2f22amr763823637.10.1727216376335; 
 Tue, 24 Sep 2024 15:19:36 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:19:35 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 31/47] bsd-user: Implement RISC-V CPU initialization and
 main loop
Date: Wed, 25 Sep 2024 08:17:32 +1000
Message-ID: <20240924221751.2688389-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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
Message-ID: <20240916155119.14610-2-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target_arch_cpu.h | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_cpu.h

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
new file mode 100644
index 0000000000..f8d85e01ad
--- /dev/null
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -0,0 +1,40 @@
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
+#include "signal-common.h"
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
2.46.1


