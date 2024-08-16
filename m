Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E24C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0Sl-0003te-Uo; Fri, 16 Aug 2024 13:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0Sk-0003r4-U3
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:06 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0Sh-0007Ew-WE
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:06 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2d3bae081efso1637051a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828202; x=1724433002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ym/1RGtoz5BJkkD8ymj93z+ybr4lmWN9RxIP/TytMpQ=;
 b=UeAkpH1yiI8/TSbLCQ3pEjkmb5xKMllXmDWRQrDxSGnSwt5Gzj9T9e0O8aMgg1HQNc
 KaaOdawCpCiUta+6cE9Dw+lKmlNZQrXK7xewASNChnMdLyu6C83Kg+oUstodjT60DsQz
 OmU7zrqvfKURPRv81kyyNoy5arRc1OYzDvr/zyuxi6BMI0IV13Qsm34bQHadlvVfUelt
 EKtp0YwTiOg6no+aQve2MsflaG7Y/S8b9Lm/be3FC5Al2GDXd+10yqB5NuFLiosj3btu
 5BDHPLXqkNV0A2GDxGJpuaS7ToVV8Bic3n1WIITsR91RMCd64odvAkCVY2LCNV1natEi
 bGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828202; x=1724433002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ym/1RGtoz5BJkkD8ymj93z+ybr4lmWN9RxIP/TytMpQ=;
 b=Czgzm4eCucI0QU25/LGfiHfAoDLr4ZLfHIkH1DWpEi+byR6vA5Vexu5YDlDCv4Jo1e
 rKgKIrS5VjNN64F+l2yHdXI+IWmPzPYuF2+MwgnTKeW4dayg5e3xb8sygEdtUW2KM+S2
 TgdouNN6fhX8Mwu0ce/Hc2yXnqf49jLHWSbDhP98J0xsYvn0vJdoUZfQ7NKBwI3lg9k1
 fFZ7lGm80Ork48pECYGLB1teFuatbcogz5qOJuicV0qctUzRUemp9YednuYTF/YerCVk
 oqJEpUPcze7D0MzLQRC0/kgso8T4zr64XzXx2VUFDe41PRXy2KKzpRaY6lrB+owqKv0o
 Z8oQ==
X-Gm-Message-State: AOJu0YySjiIg3o8yDZCzjI6bYHipzIfiJoawet5ZFkD92IpjCR24jjvk
 nc6H43itdLLeuYN3VwQuhC8YT6jCdQox+da3qWxSDRBYBoC7ISCufP3DBjvLVbU=
X-Google-Smtp-Source: AGHT+IFPOSG5WmbWALNMXblVLepNJLE9RHUaLRJqUL5zDZEGt8TDp8xS0TtlYRZvjwVl17mF5FhC6w==
X-Received: by 2002:a17:90b:897:b0:2d3:b83f:75a with SMTP id
 98e67ed59e1d1-2d40569bda7mr130197a91.21.1723828202045; 
 Fri, 16 Aug 2024 10:10:02 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:01 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH v2 01/17] bsd-user: Implement RISC-V CPU initialization and
 main loop
Date: Sat, 17 Aug 2024 03:09:33 +1000
Message-Id: <20240816170949.238511-2-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=itachis6234@gmail.com; helo=mail-pj1-x102d.google.com
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


