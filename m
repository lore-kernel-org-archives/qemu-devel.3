Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAD2CD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smm3b-0007aA-4y; Fri, 06 Sep 2024 23:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzW-0003Sz-Ha
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:05 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzU-0004s7-S2
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-206f9b872b2so9372965ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679198; x=1726283998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfzjBG7+9yzLMDJFHDoCCaXekwfn4Gr8dayPzH/NfvM=;
 b=lcNoGQFrW3gLbDUmbnbq7BYJ0WFzf9gfLqMtu/JOn9X5VHjQNktApWbUaiM1bUvSD/
 ttuYvv0dvRbbS8CjqYx+6FTsVg0mqOLFDZTwzHLYo5Ssn+khPcgGZPPsq1wl7ohlnmRW
 DSjwDFImioo8gRteonpW3CYLvH6YDGBvTWueRrNMs2Mplgts6e+X12TbLHrmgecAnQGz
 V5JnFKCar167AJUnEQsgGI0NdOEq/fPv0M7+WeTiarOLZWeLhgJYUQ9uEMr7q4ASckKv
 VaX4gQw+/7YQc2AFX+BwDcsV46J5ue0ns99X71LwknuXJwPwH1Gg4oUwZGYrVDl+GR7K
 oCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679198; x=1726283998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfzjBG7+9yzLMDJFHDoCCaXekwfn4Gr8dayPzH/NfvM=;
 b=szY/uAXFZZOMYUzaFp/OyVFeFPOho/avdZ/ZhufAffHfSZibdoIAv/nC+rzhafy9rC
 1PxsOjqiV7+H8qoqoBp/yHF1rOyjAteCJ94AV/g1LZCGYZObare3Mhopgxp3roOKz3bx
 LxV9yeosvHe2zWz65842L5DhrDYqUt6/if+qqaMxr6r+xcahi4/u6x98GgsJmudhDWF8
 Z1IqsojhRll39yF7DPLIXr6ZbkwjYRlWhrIw1bV4FSTIvEC/k1pdyzBKZMfae2eyPJXM
 Lt7pgfngwYPq9NQI3lk8zGG1eI5fJqvnjRH4xeXDaKmJrktGYQ44ermtRvT4JozBddBC
 cu9Q==
X-Gm-Message-State: AOJu0Yzt4jE9Iav54UlOF+Z3Fq0nl8GAHhn5Ii5R09M3+rkiWlVLKtVw
 XjGE1HB9QBGEXsB9LwwBPr9yGCNuoXjrSOfzMxyiKSHgmNUcfJ1nqPEd0Q==
X-Google-Smtp-Source: AGHT+IGSeYqIFIa4hrro7X+zn+FU2KWPVOF61BLwTRfHbF+DzhN/hcffOKZeZnDMZHMLDeysf+DwAA==
X-Received: by 2002:a17:903:181:b0:1fd:aac9:a72e with SMTP id
 d9443c01a7336-206f05e782fmr53928005ad.43.1725679198243; 
 Fri, 06 Sep 2024 20:19:58 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:19:58 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 08/17] bsd-user: Implement RISC-V sysarch system call
 emulation
Date: Sat,  7 Sep 2024 13:19:18 +1000
Message-Id: <20240907031927.1908-9-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62b.google.com
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

Added the 'do_freebsd_arch_sysarch' function to emulate the 'sysarch'
system call for the RISC-V architecture.
Currently, this function returns '-TARGET_EOPNOTSUPP' to indicate that
the operation is not supported.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_sysarch.h | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_sysarch.h

diff --git a/bsd-user/riscv/target_arch_sysarch.h b/bsd-user/riscv/target_arch_sysarch.h
new file mode 100644
index 0000000000..9af42331b4
--- /dev/null
+++ b/bsd-user/riscv/target_arch_sysarch.h
@@ -0,0 +1,41 @@
+/*
+ *  RISC-V sysarch() system call emulation
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
+#ifndef TARGET_ARCH_SYSARCH_H
+#define TARGET_ARCH_SYSARCH_H
+
+#include "target_syscall.h"
+#include "target_arch.h"
+
+static inline abi_long do_freebsd_arch_sysarch(CPURISCVState *env, int op,
+        abi_ulong parms)
+{
+
+    return -TARGET_EOPNOTSUPP;
+}
+
+static inline void do_freebsd_arch_print_sysarch(
+        const struct syscallname *name, abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
+{
+
+    gemu_log("UNKNOWN OP: %d, " TARGET_ABI_FMT_lx ")", (int)arg1, arg2);
+}
+
+#endif /* TARGET_ARCH_SYSARCH_H */
-- 
2.34.1


