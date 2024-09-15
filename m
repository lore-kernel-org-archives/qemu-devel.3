Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E31C3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr9B-00071b-1o; Sun, 15 Sep 2024 11:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr99-00070H-1h
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:43 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr97-0008Dp-4W
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:42 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20536dcc6e9so17594765ad.2
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726413999; x=1727018799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BISuETtEj/uI6CddQsRG+h5xaQo8IxKpbRWv0bTNq7U=;
 b=QzvOlAz6nxcUE/S32bIzaAJH24aUgCnQ5lso9vmYWZt/8+EXdzZFvsOG62QkkWuhSt
 AGnwHtuXgo1LuI9Cv8ebc7Ro6NHJlKXQ1AO0bO7oG0RrF+Bz0u3W08ExsrMxAss3EtJ3
 f9cR5MTg7u0EVW8bGnlVgJo8PNc0mdXgAAgBtW8BIGL/oJfLhyHgpr0wOlX7RBjszdGX
 tRCSO1TkU5OAwDnTBdExOkjye3O375fYVpgHplXRNntSEzgmmUuB91UaqUk0JQTYqtXt
 9bl2dWZDFi0029RPP2H+J6O3Ung0s1J+m+S46Bov2GrV1Z7WzstG3pnG7Y8NQGXCzD4h
 KdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726413999; x=1727018799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BISuETtEj/uI6CddQsRG+h5xaQo8IxKpbRWv0bTNq7U=;
 b=u0e3mn/LVVJfP3mxhvEuw8z7GrJYERao6k/1YwkCSQx4cGocMiaYM9hUUMrXdhmdyh
 ++Fbx1Ch4ZRcDS2735A5lZhA2NBnpf1bWuybHk/ohnO+gt9gcG+/na60Klvqd4ozN2YW
 H6McUpwqjIGo18MmGCdklqnv7cnoZtbiJeY2hSK3tQfXDyMYcC4qiEBPfQEwYFnVHknc
 T+mEvn5RdoOJU98lHRDpdQRGv9A/Q3bvhUh+BQMl0vf4hvBuxFBUPaKm7hMhUzer+Wh8
 eK2r+HeW7fZ7Hf9zmqyiZynCMLU0H5dAFR/MgsiHV47coWO6WNyvqF7rjRf9K1nL9WPp
 egbA==
X-Gm-Message-State: AOJu0Yx7AW1wctlJAtDzzl91uJRfd8qrmhX4eAY/waX7tuvWFcJ7McY/
 nfd5IrfFzfZKDR5/zNI5u5NamRHE57FoXlilBwXyohz/M16UsANejrP0Og==
X-Google-Smtp-Source: AGHT+IFR82IUU2zfi3g1Tl/RsKGQG9U75SCHRfcpF53yvPAVLV9ZxkXxsJVT4ajUrPQeUaVOS8QMLA==
X-Received: by 2002:a17:903:22c4:b0:205:73d9:9ce9 with SMTP id
 d9443c01a7336-2078193f82emr133660525ad.0.1726413999221; 
 Sun, 15 Sep 2024 08:26:39 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:37 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 10/17] bsd-user: Define RISC-V VM parameters and helper
 functions
Date: Mon, 16 Sep 2024 01:25:47 +1000
Message-Id: <20240915152554.8394-11-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x629.google.com
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

Added definitions for RISC-V VM parameters, including maximum and
default sizes for text, data, and stack, as well as address space
limits.
Implemented helper functions for retrieving and setting specific
values in the CPU state, such as stack pointer and return values.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_vmparam.h | 53 ++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_vmparam.h

diff --git a/bsd-user/riscv/target_arch_vmparam.h b/bsd-user/riscv/target_arch_vmparam.h
new file mode 100644
index 0000000000..0f2486def1
--- /dev/null
+++ b/bsd-user/riscv/target_arch_vmparam.h
@@ -0,0 +1,53 @@
+/*
+ *  RISC-V VM parameters definitions
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
+#ifndef TARGET_ARCH_VMPARAM_H
+#define TARGET_ARCH_VMPARAM_H
+
+#include "cpu.h"
+
+/* Compare with riscv/include/vmparam.h */
+#define TARGET_MAXTSIZ      (1 * GiB)           /* max text size */
+#define TARGET_DFLDSIZ      (128 * MiB)         /* initial data size limit */
+#define TARGET_MAXDSIZ      (1 * GiB)           /* max data size */
+#define TARGET_DFLSSIZ      (128 * MiB)         /* initial stack size limit */
+#define TARGET_MAXSSIZ      (1 * GiB)           /* max stack size */
+#define TARGET_SGROWSIZ     (128 * KiB)         /* amount to grow stack */
+
+#define TARGET_VM_MINUSER_ADDRESS   (0x0000000000000000UL)
+#define TARGET_VM_MAXUSER_ADDRESS   (0x0000004000000000UL)
+
+#define TARGET_USRSTACK (TARGET_VM_MAXUSER_ADDRESS - TARGET_PAGE_SIZE)
+
+static inline abi_ulong get_sp_from_cpustate(CPURISCVState *state)
+{
+    return state->gpr[xSP];
+}
+
+static inline void set_second_rval(CPURISCVState *state, abi_ulong retval2)
+{
+    state->gpr[xA1] = retval2;
+}
+
+static inline abi_ulong get_second_rval(CPURISCVState *state)
+{
+    return state->gpr[xA1];
+}
+
+#endif /* TARGET_ARCH_VMPARAM_H */
-- 
2.34.1


