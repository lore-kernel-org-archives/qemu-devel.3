Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0C0C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE1p-0000zI-AC; Mon, 16 Sep 2024 11:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1T-0008Bq-Fb; Mon, 16 Sep 2024 11:52:19 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1Q-0000WU-2q; Mon, 16 Sep 2024 11:52:17 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2057835395aso53623285ad.3; 
 Mon, 16 Sep 2024 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501934; x=1727106734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/upld7cTqaC/atkB+nu7yGsbOxCVGK3zsoQHBJP0niw=;
 b=IFW5nnJoqhH6pkgPhEKHwUF6VsrVpYDudI6kh0IHElvu0L0xZD1jK/4csvvSyjIPey
 RDB5YmRkkLah55zmt4hxNmI1tdeslj32NgDyx4zgkY8zmfuv7cpgE6Wp06QW4AwVg2F+
 P3Wer+j5eJvdX6emig8zR2FBhUsUKDcyimnmDC3B9NVyAloMDC6/Vr0LBDnWqa2ZAnKP
 GqI4dET8bzHACF0SI4/zhqnPa1ahjcl0WbiH8AygLgzC/cl0mNPSiKc50ol5eWNMw/II
 boXW3ds1WcrA8ME95dzym3Y/HwhumH87v6DBxWvDqZBUq7UmsltifYsOh+tc0ZvSUuk2
 yqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501934; x=1727106734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/upld7cTqaC/atkB+nu7yGsbOxCVGK3zsoQHBJP0niw=;
 b=O0S8gFr3Tme5RFKlBb7RXZzt+7sPJ7FPqhLIhGRj8mAwEgBHC7ShQQRIIVAYxbGmBz
 psPXgRiuJj4lZqzvSs2u2l1Je7BTKKrjdHzky2pugboyBZfKjK5+3fvlgurBMipe+8ZH
 GbvGtLcL7P0wQBmyPx6I5Acc+aaIFOyQt+VlKm8pLnRSSHpE1M4PzHr8v8AbeJKSRC/l
 pfXCEhavjtnejhtQhhad0O2RCJXoCifgeENN8ORWue2MwQMDmbwOcJZvLffAN64E8kO7
 EPdxW6i09kpWejqjPIVNWwEtdcE371jVqxU0khDgz7FXmW7jXDj6Q1bm5G00QGYoVGMd
 ckUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlAXbhQMIrZrQOJs6uwy3FuJCeefmzS7Gj//QB/MCXNJ8reu+4clHGUdKC75eqksr/rUTGp1RH7EU4@nongnu.org
X-Gm-Message-State: AOJu0YznWF8b2/UtP46mIRaJtt7Ud1WixwCT56VpIiiGR1ehiLQe6b4T
 bAAsVWgzVysHt6nEWFFE5QscSbtT8HAO1EIw2izVn6HyhQU+xb+qtdqzfWGL
X-Google-Smtp-Source: AGHT+IH9NX4eKuyjBx+CXBOPqskHw6LepNBWwIZYET67alIbSRM8IgOyTfuxnWN85+xC5W4DLHE9hA==
X-Received: by 2002:a17:903:32c8:b0:207:15f4:2637 with SMTP id
 d9443c01a7336-2076e30666dmr28698055ad.12.1726501933797; 
 Mon, 16 Sep 2024 08:52:13 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:52:13 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 11/17] bsd-user: Define RISC-V system call structures and
 constants
Date: Tue, 17 Sep 2024 01:51:13 +1000
Message-Id: <20240916155119.14610-12-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
References: <20240916155119.14610-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62a.google.com
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


