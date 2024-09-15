Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A08C3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr9D-0007As-S0; Sun, 15 Sep 2024 11:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr9C-00077E-JZ
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:46 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr9B-0008EG-1D
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:46 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2053a0bd0a6so36503845ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726414003; x=1727018803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/upld7cTqaC/atkB+nu7yGsbOxCVGK3zsoQHBJP0niw=;
 b=Ul+JuZGaF+8MDRLQVI44yM3vKIHMyXMhdOm/tnz06HlRyl4IB+O9PqnUkWXvw0kD+r
 RzqlCRJcF/AbwOPVQU8jn9rAbnjlcQ6KA3Xt+qj11MkHZhNKPhpC7JIChi5M/cSK1Gxr
 O3L13WMkzKgysGhGVqum7oHEQ29Mowd3Aapxq1p0LxjtNrcS7py37xIbGV19tEE18vfv
 KCcGHxxrZ6/KtL5epxsKtjMyFB/n3KjCxw/7Joo48UL+K87uuMLj1OwZD322PCBkSE9k
 A/4hxFVDf9ryskMAF3pgGs6jlV4HbfUO9Ds2bO/nRAIIfrV7WAYIg2SFtn5yhncSwY8O
 4/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726414003; x=1727018803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/upld7cTqaC/atkB+nu7yGsbOxCVGK3zsoQHBJP0niw=;
 b=h/muUx1uEYh+jrEVPKabyY8X8N3EGvBtkR4LFXpHdh7GFRUVco09GVKtr2u+Om8RzM
 Jr7zkw+nA6oqIeJTADbcUcR/IJt/frwtLxQe8nOsDcoKAPZmDub4FB5fTqfieAmyuCpl
 I8HvwwFIVkE7UMwDjXJfcQFi55I+odFrOjBHn2OpSlF49Zlz3u/dK0N7A1Sgm4peccT0
 Hvsbx5kDaWJ83BgnvxwkIK+tBIyTPqJLewSl4rvoNup993oEGCqCy7CClhD/s+5b5/AG
 oMgzRz91V/ARXDs5ZsIxHW5lqxsBnXK6dN4O+zUjE9oGWABWYsmVfgdySngg0GzJgJbV
 oQHA==
X-Gm-Message-State: AOJu0YwU+E4WLU3CL72/9KIQG2xhhA6bxIwx3oatnUn1MSowH3byPZ4C
 sOGhWgZHpOvmVhBjweqp6o2MtUYK9yzr9uiqkqDvxFoGHuOR+nJHA/vw0A==
X-Google-Smtp-Source: AGHT+IEQZJ+leut+oi7X1I2C9eEhvP2omnO/jT4qqiVwZ1GNm3hRCT8RaZEe+kYaTxPMYcnwd9iwBA==
X-Received: by 2002:a17:903:11ce:b0:205:5dad:a89 with SMTP id
 d9443c01a7336-2076e363a7bmr202607775ad.24.1726414002428; 
 Sun, 15 Sep 2024 08:26:42 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:41 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 11/17] bsd-user: Define RISC-V system call structures and
 constants
Date: Mon, 16 Sep 2024 01:25:48 +1000
Message-Id: <20240915152554.8394-12-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x632.google.com
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

Introduced definitions for the RISC-V system call interface, including
the 'target_pt_regs' structure that outlines the register storage
layout during a system call.
Added constants for hardware machine identifiers.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_syscall.h | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 bsd-user/riscv/target_syscall.h

diff --git a/bsd-user/riscv/target_syscall.h b/bsd-user/riscv/target_syscall.h
new file mode 100644
index 0000000000..e7e5231309
--- /dev/null
+++ b/bsd-user/riscv/target_syscall.h
@@ -0,0 +1,38 @@
+/*
+ *  RISC-V system call definitions
+ *
+ *  Copyright (c) Mark Corbin
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
+#ifndef BSD_USER_RISCV_TARGET_SYSCALL_H
+#define BSD_USER_RISCV_TARGET_SYSCALL_H
+
+/*
+ * struct target_pt_regs defines the way the registers are stored on the stack
+ * during a system call.
+ */
+
+struct target_pt_regs {
+    abi_ulong regs[32];
+    abi_ulong sepc;
+};
+
+#define UNAME_MACHINE "riscv64"
+
+#define TARGET_HW_MACHINE       "riscv"
+#define TARGET_HW_MACHINE_ARCH  UNAME_MACHINE
+
+#endif /* BSD_USER_RISCV_TARGET_SYSCALL_H */
-- 
2.34.1


