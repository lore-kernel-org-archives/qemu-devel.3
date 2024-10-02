Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3263CF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHn-0007ue-Pn; Wed, 02 Oct 2024 01:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHl-0007f2-0F
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHi-0004wG-UQ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:28 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20ba8d92af9so17070335ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848345; x=1728453145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cs65BOUZnAMv1/dOLhnxk7feIAkFBiN/lWv69o0EM74=;
 b=ZkRSQpHDkWZPKtoaeOjPRXKpimFTd3qkdZ1Zxg5w4yhKJmcZsrYvMBijCUhneXeseI
 mqyQvo/dPB3WZhdV+lbc/RZQMxWfRr8n1AIKTp2jlH4h0rF1OX+q3EL82VkUytK2ZxJY
 bwn5YQxguy6Urd4EFP5+ELsNF3wyN0KfjySyOdB8PiKqbbBSJAtT/AT9JH6hIrNCVgWW
 d5oehw4Qbs9r0l01k2RcSZJCoF2BreeAnzlSKjQLq56pPsdwcA5tzzfD4MTGAf85tC6E
 SzHhPIqZi/aIKEtWasixj6WZNuJw/OyBk6W0M5n9dIh+O/3lFdtGZL+QXG7ZBG+BYpm9
 VWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848345; x=1728453145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cs65BOUZnAMv1/dOLhnxk7feIAkFBiN/lWv69o0EM74=;
 b=F6lLzMq/GRaksnbsKggRuAxlL+o7DWqu0qc3FmPIng3eY5GiKDZ6SpLc964XrxmU91
 +6OiSabeCzkSH/XhA2FDMYB0ZMAChw1Pb5E0yVRpCnsH3C4e1crSvi/TtUpDMYOUxGQo
 BSnJurWOX8XtZuzEex1MOKh4Ylz2Ag6JRh/CmY+jWTxFa3AQtiYYeu6/exWA3Or+V0pt
 p+3Ohz0ROhaO2TUcE8FzlfC2YC76BpyOVc1De/0H/PQhiUloR1CRQ3hZwlx5LL6EeARm
 46TYpE3R6ZxNZ+t8GNdv/GevDAKH63JEmlQPSJ1dhcKx0YRzRD8gz7hx0qeV/NVAb4s+
 YkXg==
X-Gm-Message-State: AOJu0Ywz6kmcd9HnrUJBugYvpPGUp8YUvp6gu79iQe6wTNIU9N6wOnnv
 imCCrrgWtO7DCZPZRhmfYqVvhzWRS/u7cmxUi1+1AQ/iW5aCgfUi/Y7Bx7/V
X-Google-Smtp-Source: AGHT+IHun6KFFI02wKjQUVGK0KOKG2/3qytwyHHtYaLeClnIuInCDlEmyuwU2Foxed7RyyzQeYbIMA==
X-Received: by 2002:a17:902:ecce:b0:20b:8642:9863 with SMTP id
 d9443c01a7336-20bc5a1a4b0mr25400665ad.18.1727848345310; 
 Tue, 01 Oct 2024 22:52:25 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:52:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 28/35] bsd-user: Define RISC-V VM parameters and helper
 functions
Date: Wed,  2 Oct 2024 15:50:41 +1000
Message-ID: <20241002055048.556083-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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
Message-ID: <20240916155119.14610-11-itachis@FreeBSD.org>
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
2.46.2


