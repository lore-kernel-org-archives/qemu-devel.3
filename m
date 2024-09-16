Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B12C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE0r-0006PU-L9; Mon, 16 Sep 2024 11:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE0p-0006N1-OC; Mon, 16 Sep 2024 11:51:39 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE0n-0000TK-53; Mon, 16 Sep 2024 11:51:38 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2053a0bd0a6so47334015ad.3; 
 Mon, 16 Sep 2024 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501895; x=1727106695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1KFG92kwoPlVG9dxy986kWUrQduvgUC7zyhRIEoQhk=;
 b=VlgGzkKHO+B7M14BB7/h6tPaL9sK5lsvxsmbb3YhBOVVoudolreHrT6BqHrD0l/yvh
 ne44TViz2ZWK+SGhJO7YCwdQcXlMRjc2ep6t+fdAvp3thrCfG/hRAhuCm7K5+ZSeuTA/
 lchTewityhLVB1ME/hfl6XOJtK5/fViikFHaRqJYKrIhzPwyUcCzQTNYB9pDANBDJpQU
 abCHmWBNpqqK/LrbYLy4KPyspcbJy+gYX2xzhbhXaZDx4OWto+tRwhFP/RvovSWtk8A/
 87hQeINvT3DQRBl40ZMzZV2wKxbBAC4SonLupLBHKPaKkav0FJpDTvG0nkkm+4sM/PB5
 DgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501895; x=1727106695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1KFG92kwoPlVG9dxy986kWUrQduvgUC7zyhRIEoQhk=;
 b=JWNfMv3vs7Gtpn+qWAJQxtXQFq0Q8h5X6KurAzqrJjB8kf1Jkrk4zWEzT7X0Zq2bpd
 3nxAPcLmzm0pJa51qt6NaYhum8Ba0ZkYXjxX3TmjKuTovPx9bu8Sq76WV8GBAUhVTWqv
 lC0teUJ5u9J3Bw+hAb81f5V2ct9X73BSi/G5tDVx6MWBF3lFTTH6wv7pCNysfsgyLfaW
 V9onxc8enod8+NNSNNxlRetio61Kg5M60VC5602Dvyak1hFEBuXGuTy7GhmImukfcdWn
 t1mNCy3WX9ehX2hDnhr+odFQXpvZ6oxEdgRtqcnaxPH2oVNPYxI4uKO9/5loh7bq9GL9
 SsyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh9aycayH03bIpI8E0DaV3q8WYdEy8OHiwIsNyuxPePFj5Zhyu+pGuHNHeCy92z67qFa6+xvWD4Iwy@nongnu.org
X-Gm-Message-State: AOJu0Yycwviu9FX3moIlUZcInniPWIYoMEnEGthVpf6SQ+zIQm7g0CGq
 4d2m5gD1W8n0EqseMeS+1gg5D2NfFZpxOHHknO9NffY7CWsbB1CcFvzPMsnc
X-Google-Smtp-Source: AGHT+IE4SUpBba5G2Qo7kBxcfaGhqPthQ7uMUWZhCX7zMRQDXHuzfja9wtKLa76ydzJ9Wd+DIZqCfQ==
X-Received: by 2002:a17:903:234b:b0:206:b8b7:85f with SMTP id
 d9443c01a7336-2076e315600mr69421395ad.3.1726501894555; 
 Mon, 16 Sep 2024 08:51:34 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:51:34 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 01/17] bsd-user: Implement RISC-V CPU initialization and
 main loop
Date: Tue, 17 Sep 2024 01:51:03 +1000
Message-Id: <20240916155119.14610-2-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
References: <20240916155119.14610-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62c.google.com
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
2.34.1


