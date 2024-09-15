Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D1FC3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr8i-0005WT-Qy; Sun, 15 Sep 2024 11:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8g-0005Og-Qe
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8d-00089r-VL
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:13 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2068acc8a4fso21996805ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726413970; x=1727018770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFvdTr8ItVOjTzK94rYNt0BNQVSxcF+DNvHDFPsSwO0=;
 b=Od/Z0ivfHhJsiiURFVeF9KfFe5AjPJIEyPNml5ZW9+MZ0rFP3j4GAnpDtfPMZF8tdB
 Qe3F/DeKus1k1UkRz+TAKrtoXFvQmngkekp3Fff+rvBWxB5j8gGIgF8i1DS4Nz8QidbC
 RXKCKbGC1wQ4EWSQTgfhAIfP8lQ/a9whdcAidnQHeu6JUpdNNCM77VIlXi+YcCeZn0zg
 WRxCDmveakc5fdMlw5ZHIf/iPv8dcTCXZL1OzoLlSnAsYJrkqA8sSgTjnOGZu2+zDg+M
 3apLzMSXKAIZ9hRSBGgMqHVFM0IXspFCK3JCg2t5XBcZnhnjvd8+XiMOKasrR2Buyq68
 MoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726413970; x=1727018770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFvdTr8ItVOjTzK94rYNt0BNQVSxcF+DNvHDFPsSwO0=;
 b=wooyu5aSjmtk3ZQm4qbVcYO2Ig3edll0+aCYXK53+hMiIhbolmcucrFFAdbRSkI2K8
 pIKKJBniJdZhs/zKjIFJ9OV5J96PicZjsbM+EVVcH4T/+tPqa0d3LMIcU/zqtN9uFON9
 0bcWxKLUWfxrv5py+8y5o25ZVHj9U0qt7m42P9BXSOU4+Y10RCo57g49JiXo7NY+sjoU
 EAgj0sN7vO+jqjMABZu9eiaweU4oYoJA4cz6rwa6Jf95h3hEgdg1xEAzRh5fl6VZZF59
 P0dkfJd7QbI3cQWJGS8s0oS/3xAGBqnxkUhEDhfZJTcfjocTWBoV4sPlzN7BubH7JWPN
 4s5Q==
X-Gm-Message-State: AOJu0Yw19y6aYYB71LYIKOWqHk0qLnzvTxc2YFAqhNjjZPkrSidH/B9Q
 RzD20+p4a5um7QzXr5alYna39pM7qE1X75b44NL6xhPdGqnD8dTbTOPHOw==
X-Google-Smtp-Source: AGHT+IEsaIeS3tMoyDuPZurlIfEMT6TeUCDffowmWzoTAmEJZE05FmkL33WaMdGc1OW7jv6ESk5H2A==
X-Received: by 2002:a17:902:d2ca:b0:202:2f0:3bb2 with SMTP id
 d9443c01a7336-20782c201e0mr89645235ad.60.1726413969687; 
 Sun, 15 Sep 2024 08:26:09 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:09 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 01/17] bsd-user: Implement RISC-V CPU initialization and
 main loop
Date: Mon, 16 Sep 2024 01:25:38 +1000
Message-Id: <20240915152554.8394-2-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
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

Added the initial implementation for RISC-V CPU initialization and main
loop. This includes setting up the general-purpose registers and
program counter based on the provided target architecture definitions.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


