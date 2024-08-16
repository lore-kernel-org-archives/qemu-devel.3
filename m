Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9694C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0TL-0006cA-NC; Fri, 16 Aug 2024 13:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TB-0005Sj-Gn
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:35 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0T5-0007O2-Qk
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:33 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7a0e8b76813so1682103a12.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828226; x=1724433026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BISuETtEj/uI6CddQsRG+h5xaQo8IxKpbRWv0bTNq7U=;
 b=HhZqQwVp0n7UZ968VHzXQ4/CHdUu2LBP16Pr9FyJFSkBy8TSE1wttt0Mez1C6+tav6
 G372QeBMBHOr6lgwLEF+NmiWK4PpT2mcQ4n/JMGvVD+koE665gp9wllrRvL+FaLlbzrz
 VtUX25bJ5X4TSuC+vOLaCxuU02mc/157t/JaeuIt/ZmlX2VrDehho7PbN7KUuLnFUwTf
 iUkPSLt91KooLR00nOXVyp5res5SxOD3VeNYQSkOYK2UopsvBdw/Fr/VJKEJqvrMqJIC
 6617x3uzQfYvkQAw8TJc1zUpirEpjVAswfj6NdXGwwRdHWR87d+0J/re0VJ3ECiKZoN/
 vOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828226; x=1724433026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BISuETtEj/uI6CddQsRG+h5xaQo8IxKpbRWv0bTNq7U=;
 b=fbxsqmnWU25pwroWl8yK9zngnbqiPZSGRuqA79j04Hqoj+JUzO7+uv/MWuCS7bPlBQ
 H1Batslr9kbwYnxfkNHcOIIgfy9z/+k6vc2zCgtLi9QJy5WnJl1avLL2XDCBO7ArHv4r
 J2C11HMZ6XvrjB65j85liLKOsGpzpi/mbE9yPs04CehY5FwxhGqCYekDeOJBUEMM3OsL
 94yedIuYZ01+KV+QXDw3l10q2ao+XRFT0zpLPGrPTuDTHKW1EUz/YuVpHYOl38QCdcU6
 vPTf7zYj82I+0YasX0wvMlZoSfLAcBjCBg3PR6x1kMHaGDY6S1ZN7cprWwZUfeKu5AKx
 yx0Q==
X-Gm-Message-State: AOJu0YxKP7mT5r02wEQECSeAF8BNC1XCqlGjflO472O07DUhQbLUSBNh
 xPHIpM4Rrow6A+tUwOFMxy8ST4AKSJv0gC6fU4xKghDoTX6aK8FchauSFGUSTpQ=
X-Google-Smtp-Source: AGHT+IF1yYR0Sae4Vw6kxwVQcRJd3WWOzyfpmjw/yIsrtpQw32iabsxSA9glBQP07QNIPj9zeRlICQ==
X-Received: by 2002:a17:90b:4b47:b0:2ca:5a46:cbc8 with SMTP id
 98e67ed59e1d1-2d3e00f01c2mr4008337a91.26.1723828226022; 
 Fri, 16 Aug 2024 10:10:26 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:25 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 10/17] bsd-user: Define RISC-V VM parameters and helper
 functions
Date: Sat, 17 Aug 2024 03:09:42 +1000
Message-Id: <20240816170949.238511-11-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=itachis6234@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


