Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C01E6FE4D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smlzJ-0002y4-Gh; Fri, 06 Sep 2024 23:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzF-0002wi-GF
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzC-0004qW-PW
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20696938f86so25347665ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679180; x=1726283980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFvdTr8ItVOjTzK94rYNt0BNQVSxcF+DNvHDFPsSwO0=;
 b=F/ngugUIyh4Qwfx0KCTh7w9+UyapXmlmGml2QB7gYJYSdcG5Sqb3kvmirKscLxypLK
 RMVZiOZsVu8oXCE97MvbkJRthpGZVhIga26MLkw8kHlJT9V9ZX870Aa6IWzIvfjRqlIn
 Uvhm2wOflFT4RduiBlwPjBUplkzTFod3gB9e2Y8BcTU40pxlnPBpTzzKHdx9A2FpXft9
 QQogNt47YpxeqRf2wfOxt9W1pvg2tCblLONSsjxnSoHVmxvZUvN54zRvXw/suQZJ6nvL
 4IIuoWW/FIp+c8sd1HG3+aoEF5Gl21hU8Wviw6P+YBsCJPbcgijLCVQ1wA6iuAUBTSix
 jWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679180; x=1726283980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFvdTr8ItVOjTzK94rYNt0BNQVSxcF+DNvHDFPsSwO0=;
 b=J0dvg3VzueW7BqmoTNeelIKrlcx3UY/Rf3WmXwMlxcy3zsmblrMzrVT29N+6ZkJ0A7
 NNtcI43s5sq7hcVmLKhHWube50fLBweY8UY0jxyAmkCP7nhVCZ0Q52/hZnvZeG0ipTSZ
 V6EM36M3hf8LbB6Qc6o8R1wF3TuRgpa0pYJ1ClxO+ySCYFBZuhOAzaeKuf6xaUj5Eiol
 1ZL8OXi6uaSN2wJayLkMeNQMhvdjeBRF26q//BE/jYD40bMsrp5M0h1k2QWR+0j+7oWJ
 iYo7xyr/3LkNptvP7J35/wxSZcLjXcZERdgHE2LtxjcwB0GjP9o0kVK4zqP39VXDLIX7
 fNaQ==
X-Gm-Message-State: AOJu0YyyJftK18X/+9sXltXoasiy9W7sMwjBfcLqG0VtCCY4PcjZZeCf
 5CVmLX7JBYJICR9jS8KgXthe3X/1yPEwH3/AYC5+fjxBWlgBscfoK/gGQw==
X-Google-Smtp-Source: AGHT+IEyVziJZhjBmfDUXH5hcLiDJsDOU+q7+X89ET6HM/SxLsfdSDXpKxv5qWYH9MBB/2TwpnyPDg==
X-Received: by 2002:a17:902:bd41:b0:206:b960:2e97 with SMTP id
 d9443c01a7336-206f0612ed5mr55560995ad.45.1725679179770; 
 Fri, 06 Sep 2024 20:19:39 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:19:39 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 01/17] bsd-user: Implement RISC-V CPU initialization and
 main loop
Date: Sat,  7 Sep 2024 13:19:11 +1000
Message-Id: <20240907031927.1908-2-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62f.google.com
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


