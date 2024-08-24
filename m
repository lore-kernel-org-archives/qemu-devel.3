Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9305C5472C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 04:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shipj-0006V0-G3; Sat, 24 Aug 2024 00:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shiph-0006Pn-LP
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:01 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipg-0002FC-0m
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:01 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5dca9cc71b2so1889951eaf.2
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 21:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724475418; x=1725080218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8SeRNxqA0kdGYXuMPPKRU3j4MVX/4+712bEYl1oABA=;
 b=TkRmMzNMaK/2rBtB88m1V+WpQR9XvMmoBFDDzEJ+/wbjhMNhxz1+534jusz1I8P9G9
 LPt/6r+/lxZ7qi1J+hzwn91gLzCMyHemHLY7CRS/CIAiBr0ZgZhU+0cfmzqRoKcq/yCa
 BlPsTx2wrSLyMUWY0C8fNor2AkhEv9liBBSFRTcTTo06AMMWAVC5VFtC+j84VF6lBXY0
 2KZ8LMeJ8G8kTWjsMFGDHQ+9pChS+nQxdhbfF8XeQYkLc14vod956jKML3zl5Y7zejHi
 mnJHqgWuvMWDzec5LPJsoigvNH+Pq8JptZ+nvDRioXnx62evnP8a3aZnMm/ITzkOHdWK
 0lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724475418; x=1725080218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8SeRNxqA0kdGYXuMPPKRU3j4MVX/4+712bEYl1oABA=;
 b=F946qzewvG2MBx5g/wtaPe5hUnef/qvQ80RmFmKtoC2tkObAlNEDVhJUBZ2OaTurqj
 qCZoyog4l0lAv5Xjt3pR0BWFWCAEci/zDIJskJQxavQpxM10H20m8P7XJ8ymFBwrxyzQ
 GHq1Qlkqx6WxEZDHWnFLjGCGmG3E/rHARiSlwfLmw4EgzEdZiJy64jHb2zLWjqAC+O7y
 tJOW+BbE8C7lesWWJpZkOb6hyzPCz2zVYzVCfEsqJYyh5x4761kLzQfq9Puk68vLqihJ
 g3Az2ft3TTG6YiOwGjweC3Pk4+STS/Vht/LB4kA4obyhE8IbiD6C6gnxayCaXpn02Xuw
 kRzw==
X-Gm-Message-State: AOJu0YyzYXU2g4W9x77D0jCx8g2oXZWzzllurqvuBVhodM1AfEC7fqLG
 j1tScnGwIknuzplnU/PmROd6X1P6RQfP7MduQqXaaPquYJk+d/ijNu/3hIs6uvU=
X-Google-Smtp-Source: AGHT+IFTeZ9CLa/lZJpRSjrvpKue5t9QJa5YqYVz1J9IntD/mgLut8Y8Ij7aXYahJbrEwjQBIyhGWg==
X-Received: by 2002:a05:6359:4124:b0:1ac:671a:f39f with SMTP id
 e5c5f4694b2df-1b5c2140578mr512613255d.11.1724475418349; 
 Fri, 23 Aug 2024 21:56:58 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ecedsm3805934b3a.25.2024.08.23.21.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 21:56:57 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 04/17] bsd-user: Implement RISC-V TLS register setup
Date: Sat, 24 Aug 2024 14:56:22 +1000
Message-Id: <20240824045635.8978-5-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824045635.8978-1-itachis@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=itachis6234@gmail.com; helo=mail-oo1-xc2c.google.com
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

Included the prototype for the 'target_cpu_set_tls' function in the
'target_arch.h' header file. This function is responsible for setting
the Thread Local Storage (TLS) register for RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch.h     | 27 +++++++++++++++++++++++++++
 bsd-user/riscv/target_arch_cpu.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch.h
 create mode 100644 bsd-user/riscv/target_arch_cpu.c

diff --git a/bsd-user/riscv/target_arch.h b/bsd-user/riscv/target_arch.h
new file mode 100644
index 0000000000..26ce07f343
--- /dev/null
+++ b/bsd-user/riscv/target_arch.h
@@ -0,0 +1,27 @@
+/*
+ * RISC-V specific prototypes
+ *
+ * Copyright (c) 2019 Mark Corbin <mark.corbin@embecsom.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_H
+#define TARGET_ARCH_H
+
+#include "qemu.h"
+
+void target_cpu_set_tls(CPURISCVState *env, target_ulong newtls);
+
+#endif /* TARGET_ARCH_H */
diff --git a/bsd-user/riscv/target_arch_cpu.c b/bsd-user/riscv/target_arch_cpu.c
new file mode 100644
index 0000000000..44e25d2ddf
--- /dev/null
+++ b/bsd-user/riscv/target_arch_cpu.c
@@ -0,0 +1,29 @@
+/*
+ *  RISC-V CPU related code
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
+#include "qemu/osdep.h"
+
+#include "target_arch.h"
+
+#define TP_OFFSET       16
+
+/* Compare with cpu_set_user_tls() in riscv/riscv/vm_machdep.c */
+void target_cpu_set_tls(CPURISCVState *env, target_ulong newtls)
+{
+    env->gpr[xTP] = newtls + TP_OFFSET;
+}
-- 
2.34.1


