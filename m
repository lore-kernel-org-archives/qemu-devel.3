Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A949AC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkJ-00079l-55; Fri, 02 Aug 2024 04:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkG-00074I-Sp
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:40 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkE-0006PT-Pp
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:40 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7093efbade6so5391112a34.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587677; x=1723192477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKv9xiOVV6+VnNuJ9lX0dls3TGSqh4I+AxciJ2mFhjc=;
 b=QSpkano7FgwmxXKj3LTuldPO49Db30JZKFf4+Idk1IuezOO7CaBnw7d+NFD5ZNcQX7
 jbygaNzwI+90opVAnnt9DmrxT0aphloGyVIF+ZFXllNSINQK8NaN2pmiXA7f1ktVd3q0
 mfgcKqK1kpPrcEz9u0pfu1Mngum/zI7ocZYjycHwpQYquWO8m2y5wiGh75z4O1WcdXuZ
 Y8woKmydG6vmklXSQSgJDYm/8phKuvwh9F0nsDcFgEUiqBiPnuBpWLzWJIBOWyPvOluF
 8OUd1X5p4nEL60YFUKeAM8FIpYqrAYRXsey+gPu1wjMSXpYl9P6zUbmlIpMEga62j8ac
 klnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587677; x=1723192477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oKv9xiOVV6+VnNuJ9lX0dls3TGSqh4I+AxciJ2mFhjc=;
 b=JeK/hmYvjim3c2PiBq7iV9Sirp5RgM+Kc4qlT/jz1b31C+mDsfy1Y/jLEh88TzJQ35
 Dnfw0063ce/5WqYMrnj8t3O6q3XbgUqgsW59NELApRrJLFfnqXiNVVf7uZ10drvkyON/
 pGp84+RUp/7QzwcPKt+lMn+jtgj7ilrwis2OF33H0+PGIS/LNJO6XN1szaU2VgX1XDa9
 hXK9oXn+orXWvrfqrm1nNtYdaHO7SQpKc7IKZcvwAObOQ7ZQ2d9r6Hub1BlLwHUvIo37
 dxgxaMsWvxFg4sYXV6BLhX7thMmPEkARtEJRObGjYzVIpqBFMMdjcD6g47EV2B0F49kq
 twFg==
X-Gm-Message-State: AOJu0Yyvr+ivWiYUdx40l261nFDlYwY7mFQAq5q+mJLhD9PunjVRH8Hd
 el2WstYsgsb1bZHfvVeSVF1JP9PzLpiGqfVMCU4xQO8Mumvab1OOALKIS4/FLz4=
X-Google-Smtp-Source: AGHT+IG65VEVvDDMcPKii9bN+qt4SP9AQvBmLGDulGgpHSMIM9Fq45TPV5WcQkTmyhH4qQQeXOnK9w==
X-Received: by 2002:a05:6830:6e0b:b0:6f9:6577:71c3 with SMTP id
 46e09a7af769-709b31fcaf9mr3500725a34.6.1722587677116; 
 Fri, 02 Aug 2024 01:34:37 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:34:36 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 01/18] bsd-user: Implement RISC-V CPU initialization and main
 loop
Date: Fri,  2 Aug 2024 18:34:06 +1000
Message-Id: <20240802083423.142365-2-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=itachis6234@gmail.com; helo=mail-ot1-x335.google.com
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

From: Mark Corbin <mark.corbin@embecsom.com>

Added the initial implementation for RISC-V CPU initialization and main
loop. This includes setting up the general-purpose registers and
program counter based on the provided target architecture definitions.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 bsd-user/riscv/target_arch_cpu.h | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_cpu.h

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
new file mode 100644
index 0000000000..28f56560e0
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
+    for (i = 0; i < 32; i++) {
+        env->gpr[i] = regs->regs[i];
+    }
+
+    env->pc = regs->sepc;
+}
+
+#endif /* TARGET_ARCH_CPU_H */
-- 
2.34.1


