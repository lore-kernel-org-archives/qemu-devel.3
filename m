Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0BCC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0TJ-0006KW-KO; Fri, 16 Aug 2024 13:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TD-0005hO-Pp
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:36 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TA-0007Om-0C
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:34 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d1cbbeeaeso1938799b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828229; x=1724433029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/upld7cTqaC/atkB+nu7yGsbOxCVGK3zsoQHBJP0niw=;
 b=SQB6EHjOzuPZdOJluSQiL+C/PFlkLcnNHjvxyvrTOd0hetJqdA43Xu/6ICI8iKSHfs
 KZ97nKkfJ5Siv5vAAaTcan2LUwh8uNKj0i4wRubtXlickVm5FLpQeIJP+ieMaAuQmMof
 8kv52F1+uqinem8LO3l98OsY6FDG0kHz4R9DLTqYuKjEpt5ByUD4A9X7RR2YOsMhulWu
 jCkjg0wvbKCUEd5BNYUYciSDwFdMZiPIzyHg90F92AI/kqShmH0C5YL6OiHW/fvRRrzs
 7f67z8y+VvXzFvEchyISvJKQkIvnQer5w+KAY+2eD6l1K4C3zjeXFMvIFQ3kfoMyTqMS
 ZgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828229; x=1724433029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/upld7cTqaC/atkB+nu7yGsbOxCVGK3zsoQHBJP0niw=;
 b=V07UbDAABxY/Ei12od25BbQovCT7uFqMaCWWXYPbv+AnYavmt8KY1XzauBYj0D2OmG
 CXtc1DjvcqLHKkuEzE1lnWOkJSA1NwtlNGAYhaXpErqXgm6GAEsKUSs19/1jzgWX+6tv
 Dqs7vW3GlolUagkZLKXvHsVR4nYWUTepKJXJd9/L8xhr9HhxkzHru3opZASLiwJ9vwXR
 BQL3YN5Y2pOten0rPnx/IDHzbBtXPF0RkEJQOtl306BVbcWT/BMtKJ3uQdzE1A9wlzL4
 D7w2/GZpQ2Dk0SR7j5TKVrUxRwR7M9A/NUOpjZiScMxp+E7GuatCBhW0FbhbKPI8JQmr
 pzSQ==
X-Gm-Message-State: AOJu0YzwxfaMzOkXFwFa5ugpK4Ht3Oyk6H24/VMPPdkFByOqf8O73HZD
 2n45qY7Y4uJGLQBlBkTqitBvKSlMtXlQMRrQG4ASgR3SjpyYR4s21dsU5ADcJcM=
X-Google-Smtp-Source: AGHT+IEBvnsGbg5j6vlYUt3za/l1EpcKuqKM4GIZU1u9ZzDeUTWZT2H5DNan6Zp6s0wzWSYtpvTPuQ==
X-Received: by 2002:a17:90a:ac0c:b0:2c8:647:1600 with SMTP id
 98e67ed59e1d1-2d3dfc37c6emr3669525a91.9.1723828228797; 
 Fri, 16 Aug 2024 10:10:28 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:28 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 11/17] bsd-user: Define RISC-V system call structures and
 constants
Date: Sat, 17 Aug 2024 03:09:43 +1000
Message-Id: <20240816170949.238511-12-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42f.google.com
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


