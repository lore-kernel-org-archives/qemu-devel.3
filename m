Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BE0C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkj-0000c2-II; Fri, 02 Aug 2024 04:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnki-0000XH-4o
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:08 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkg-0006g9-Ea
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:07 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7106cf5771bso905869b3a.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587705; x=1723192505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ri3RI2bN+2/bfatht0VNZ2Vy9dAEUCw1SwYHsuC+xHc=;
 b=FIUJDuiPfFoKJ5XU2Ww1PziNmFmtZOx9uy00aZPBvgEDXIOhS9TyuRVWaH7dBwde0V
 oKUrQQeoti1mJQnkwJzvkcQO4INIXHRIM6pI4kR4X3OzMf1kEjAX7gnkwUvq55TMPKhh
 TbX38wKO+hIYjiDnApKie7MvSKeR565uyxonQXvx8a4YcY/6d8hRgsjICX4MptNmMWFy
 Lq0r+J4AdKU2+I6Qvhv+VMFuxntTvEdvH6dkNC1jnUKEoHtTU5mH7J+1Nz8bRwAj5VTT
 1GKLnh04pwtHPYz17K71+WzMqlJbyUaNxaGhIPBBXly7AibCQlwMgXi6it9mkDeTpITt
 vQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587705; x=1723192505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ri3RI2bN+2/bfatht0VNZ2Vy9dAEUCw1SwYHsuC+xHc=;
 b=km6s0NjNLQP8Qlxg9JbiJXa2ryve05WGCUwLd4VCHPtPknM8pRioJCLjCId0bdCvuJ
 sAEYEjJTSQL1AzUb1IPElk3UNNxnC7NUposlQX5b9BXsDMYAvi8+RbjgylsAw6159JqN
 TTpSKy4QnQ9pB0fTgDolUdgY561Br6V/mgFq0NcQoL/nXFVHASsY5Aq/WTtDoDdPVm99
 9/M8KHgP75NoBxh8H203WBjroIMaKKFkl+FhniKy/lcA++TLS1xD6eL9svtSCINCVlyb
 jBLgvUbimH3LJgnHEsdPFkWWtdzO6BlXWCQKEiR3VNRPK2PiMAn+7hR4RmCeN/IJFGXi
 LKoA==
X-Gm-Message-State: AOJu0YxnjZYLOBP+zbKG/Fdt5vQJ7CSZLvQvgvIy9iSNWq+PxICKU4dE
 0xiXFrsaKjvyphrfSFRnaawgOR4gqorqqUq3rV1FM02qBBoJO/iYN0AAVuGNRVw=
X-Google-Smtp-Source: AGHT+IGt5UhRFvUfmAifiLEwg0jMj/CR8ex6jRks1ygxG2Up0mAkehwnth3fUlThO/CalZJjMEsZ5g==
X-Received: by 2002:a05:6a00:cd4:b0:706:7943:b9cc with SMTP id
 d2e1a72fcca58-7106cfbd6dfmr3680408b3a.12.1722587704751; 
 Fri, 02 Aug 2024 01:35:04 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:35:04 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 12/18] bsd-user: Define RISC-V system call structures and
 constants
Date: Fri,  2 Aug 2024 18:34:17 +1000
Message-Id: <20240802083423.142365-13-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x435.google.com
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

Introduced definitions for the RISC-V system call interface, including
the 'target_pt_regs' structure that outlines the register storage
layout during a system call.
Added constants for hardware machine identifiers.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
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


