Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D820C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYh-0003yI-N3; Mon, 17 Jun 2024 14:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYg-0003y4-B9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:26 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHYe-0004vt-J8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:26 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-705e9e193caso1749147b3a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650703; x=1719255503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RYBeS7YMWG5zCOUP6t7XOOwmqZaXoAkyXHOLEzgJdI=;
 b=bV5RjFcq7BBUkxSZ1ezRBHzcKCsRjQfW8Q0GV4OtZCAcFYaU7eGMCkT4+wWNjhBaZ3
 U22x4XD0vDrlWD1JOvQRFkw2pLg8HXuXhhA/javLI+MPwklZELTqeIYJbWjTKFL3mjoG
 4gzxzBVDiWvOIfakKMguRAUQGZoqC1E+hk1Oa9UhMYwTK2T7EVEfAQRE28vB8WRY3Yrs
 0+h4mvGLhmnUIsjrM+9llpbX+EBylIDxRxhyIFqbiCjNzkxjQlHxhBpPRJ3rYYhKSHo3
 ZJTrz5MN9+Sa81Vw/fgzDCl0m1AUnmkncONxNbNedkOIem5wsTtc62Z4yHalvsj8Z1QJ
 aO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650703; x=1719255503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/RYBeS7YMWG5zCOUP6t7XOOwmqZaXoAkyXHOLEzgJdI=;
 b=JTlZ+DDftKBBbLLXRvrJEYInVzu4BD+5PRtvbPA7AUbnAnrEe6hljw7Ownl8CtLX3J
 MA59IlPo87ScTQg9uZYg+PDlHYh/yhIPQnupnMUjkjb1jqOfoaMMZoSr+/tFwkHnGfNO
 i0UgWy4nwO/P5gyAD9mitYwokB0FTgx+kFR9zoywDaL2Ar4AEmoUjdazNz6/H4Pugo2e
 RHrnyoJTUzLExPMJWEgQ6Tl/Pi2cjYflXHgo8PzMaD6wRBjenZ4qMmyQIImeAYXUTvys
 2sKP29Ieis+ey3apzh+rao4R00jx8Ar5EoRFvSzhKBINL1EvuBAS9AUoJGKRTXhXoSBn
 vRtg==
X-Gm-Message-State: AOJu0Ywv+a7M9Lw/sVt1/gbelfkJAgNg4MuMnTGhNYzB0PkP3EClit5z
 be5vhZqHi5H7RTr1dGaH+6iINQvxMyfxdta2WYOPbFkgBvMaDEFRVagQ2VzHufE=
X-Google-Smtp-Source: AGHT+IF5LB5NTjbLsChGJTJVAn6dQkh1KOyI3qYI/CPKzkhkA4UbiluEtO7/wRCxmPq7juRzYBf1rw==
X-Received: by 2002:a05:6a00:cc:b0:705:9cf6:bc21 with SMTP id
 d2e1a72fcca58-705d70f7276mr9973918b3a.12.1718650702418; 
 Mon, 17 Jun 2024 11:58:22 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:22 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 01/23] Add CPU initialization function
Date: Tue, 18 Jun 2024 00:27:42 +0530
Message-Id: <20240617185804.25075-2-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Addded function to initialize ARM CPU
and to check if it supports 64 bit mode

Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
---
 bsd-user/aarch64/target_arch_cpu.h | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch_cpu.h

diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
new file mode 100644
index 0000000000..db5c7062b9
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -0,0 +1,42 @@
+/*
+ *  ARM AArch64 cpu init and loop
+ *
+ * Copyright (c) 2015 Stacey Son
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
+#ifndef TARGET_ARCH_CPU_H
+#define TARGET_ARCH_CPU_H
+
+#include "target_arch.h"
+#include "target/arm/syndrome.h"
+
+#define TARGET_DEFAULT_CPU_MODEL "any"
+
+static inline void target_cpu_init(CPUARMState *env,
+    struct target_pt_regs *regs)
+{
+    int i;
+
+    if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
+        fprintf(stderr, "The selected ARM CPU does not support 64 bit mode\n");
+        exit(1);
+    }
+    for (i = 0; i < 31; i++) {
+        env->xregs[i] = regs->regs[i];
+    }
+    env->pc = regs->pc;
+    env->xregs[31] = regs->sp;
+}
-- 
2.34.1


