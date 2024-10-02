Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89099CF3198
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHi-0007Xm-Qj; Wed, 02 Oct 2024 01:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHe-00071l-2t
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:22 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHc-0004vk-AR
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:21 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20bcae5e482so2575355ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848338; x=1728453138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drXIiOQ5yRtcgvcq+XQ7DCOItl4A81F1hwBi7cDjjJU=;
 b=KmpfZJgwYmfEtNiGZQfUchOPsiH9K++pyF7rJUqFWDxbF1koCR60/RK0Dp2p+5UEiD
 AEjUQbmKHJ6/AUA0xeckR67vN/u7pWKJ3tCyScuNEY0K0/FY6jOn3VrWW/iRhkJo2Wvy
 Sm6cx2zKQXo49JUrrMh01mFgHxqKwv8alCzXQGnwxzSkR21pZKvlCaOc+jNra+DyvCqk
 jz0LJ1XHJrHifIbyldTrGua7rcjIS5srJElxsHMY1O8C3c6m7+3uT71Qh8sOWwSZO+NO
 3u3P0pgD4K73fFpDt6p0uY5/HyzwWtrxqX9Q6nGDOhNNGlqpBF8IB8kzRycbC86j/r9B
 cT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848338; x=1728453138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=drXIiOQ5yRtcgvcq+XQ7DCOItl4A81F1hwBi7cDjjJU=;
 b=qOZHqOzN4H/JwXgt0fNmICFE6WFUoiCkcfhoDYl2Ou3eL6gkC7gaBw99yl/QTbV4UB
 670z7eFmHdVDnCL/XaYJ7e54nLJbDKIjtnyvCJs7wX/UFeXyMntNm/CPeDGKhi8+t9Fp
 BH+yZQTT2WHQttzecXVp4/R9kYiBG1FBbMS58IV55KiWaILWQCkUok8K6NTeFKiF7Hle
 DyAR2p7mFkjYMtiXV1PzvDQmofZfQCiHfzn03QPrEqFuEEyEgPnbaxqKi+1uuKGTt2YM
 dJrXGBdpZfwQSScUVP0EDlugUBdVVynELZdvdqvBH6rhaFbdqZNW/6KFGoJapTdh5Ivn
 7Uew==
X-Gm-Message-State: AOJu0YzykRCsQE6Xn6Kvz3GPM5h07Eu+KgOOdGOtLRh/HdLdjjI4f66O
 /obG1DVFl1IlF0Qtq1ajMYCqvF0SW5tYynPpbXlNGGe7/kZGcPK5juVNyonT
X-Google-Smtp-Source: AGHT+IHHOQNOsRuY1O0HvxwaKIYk5aIQp2rmQdorhIcC1eMlHxSvVN/I+//XXxug0KCHG7Qe/yRIdQ==
X-Received: by 2002:a17:902:c40b:b0:20b:af36:ead with SMTP id
 d9443c01a7336-20bc5a5d3a5mr27631585ad.44.1727848338286; 
 Tue, 01 Oct 2024 22:52:18 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:52:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 26/35] bsd-user: Implement RISC-V sysarch system call
 emulation
Date: Wed,  2 Oct 2024 15:50:39 +1000
Message-ID: <20241002055048.556083-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

Added the 'do_freebsd_arch_sysarch' function to emulate the 'sysarch'
system call for the RISC-V architecture.
Currently, this function returns '-TARGET_EOPNOTSUPP' to indicate that
the operation is not supported.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-9-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.2


