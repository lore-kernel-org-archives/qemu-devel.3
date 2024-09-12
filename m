Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9C9EE644E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socR8-00081R-UC; Thu, 12 Sep 2024 01:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQt-0006Al-Ll
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:55 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQr-00039i-OO
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:55 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71798661a52so408076b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119112; x=1726723912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0zFg4BSTwNx23YXwcuWcDUOiXr3L+CnToybFG8Q9/0=;
 b=Np4zR3ueQiKn28+a4JF16eC3O6xq8zTPqHWzDY+djVbCHuoyjEkOJSCe108RlYpV8T
 2Kb3tycxfZa1zZZZCfc0KA4TZ8oVXREUFB3jPBkBbQUmW2EXUkeNDoz/VyiDt7d4zVYF
 5AdhmKlZ+DNtEZn045n1WJqUHOJ0qUGsUze16ob5RrdMD+3SPQLoMWvgVopVGBtIwuoF
 XtdnEFRt+cRvOTZPEF9HMxMuyy45HxTbjY+1OWke3Pa2eaXld19aCVtdRZdiExV9GvbU
 Wzoei9CnOQ/CMJ+MGzo1W+omfLnQ+OB61fwCqT/GWEYwLK9PwA4kSBCGOmS/SwUGOMEP
 NIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119112; x=1726723912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0zFg4BSTwNx23YXwcuWcDUOiXr3L+CnToybFG8Q9/0=;
 b=IIhq8n4a+p6K2IzfpS20q3skqY560IeB3dOec8PN5WTdekZmUQK3WaL9f9tORvnntE
 g5oLj408RH8B4ysKpef97UKBcC+U4w8vRLlDmXy1AA9ov1O7dDY4O6lz18ew0sbaMOc7
 aak7umkiN8NgRz0fsqRxPn2BPKYlX9DAS7/5zEGPOeMf9kvw28/GV8xpZUNgAMrZGEUS
 YByYaWS7zZo4K1cwapSRUgvuElUq7fxBFofI0LU0sIfdB5d49g/8WkxMKXZFosiUREp/
 SLu4D54S4n62cYFXtYtd1Ji+6SuXNMrznkZoj2zOltjICkw/QZ77YPO0MQagT3gxwiw0
 2RjQ==
X-Gm-Message-State: AOJu0YwGh7KoA4aUHc3f3JvC6Z7k4rrkwwbjzk808IzCWCxIyG/i0nJF
 IHtnrFC9AQOcVI+DIYRH0zKoF3ORUzGP6HZrgpl9DbJGUB4wguqub9CQJw==
X-Google-Smtp-Source: AGHT+IGUMS4qPyLS3tw7iI+P2ToT0GUS5jMurzfsYMe0uj7VpqpClgRy+zwZ2daqSgeS1Ryq/Emu/w==
X-Received: by 2002:a05:6a00:17a7:b0:708:41c4:8849 with SMTP id
 d2e1a72fcca58-7192643cd9cmr2439478b3a.9.1726119111844; 
 Wed, 11 Sep 2024 22:31:51 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:51 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/47] bsd-user: Define RISC-V VM parameters and helper
 functions
Date: Thu, 12 Sep 2024 15:29:40 +1000
Message-ID: <20240912052953.2552501-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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
Message-ID: <20240907031927.1908-11-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.0


