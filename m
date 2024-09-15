Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3BCC3ABA2
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr93-0006gV-SM; Sun, 15 Sep 2024 11:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr91-0006XT-Gk
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:35 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8z-0008CR-Qb
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-201d5af11a4so41090375ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726413992; x=1727018792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfzjBG7+9yzLMDJFHDoCCaXekwfn4Gr8dayPzH/NfvM=;
 b=mYiUGENVX9N3JOJzhMEftM/MFL6GnNYVbOiCL9Cgv2arSsXndJYZh2XTzaQT/ol+v9
 vhnMb8mvh5DzIJvy5+3TD4pB4zN+h6pYCCbznwD1kLpEcKbj+a59qKvdPRRYSDsCmfd1
 4VZYG07AI3SJ+vBXV5qnW6EtDvB8WH4rxSicVMx8d14lCQwQc+AoQPCFoWn2SduLuvGc
 z8kaJH4zPuwEcC86WtgGeubV97lAzYhbbWJsHNMCVovq4cHei0kBsCtXlN124Of17ZyL
 qgFdXalD4kecXY5edfdWGymAEqbDTnMznDXAbgKccB5m6pJZ6EdfmA9bzv6elZt+Uckc
 zsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726413992; x=1727018792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfzjBG7+9yzLMDJFHDoCCaXekwfn4Gr8dayPzH/NfvM=;
 b=O62Q+TIuUimN+93JXg/QZwhQiU1HgRiloliRlUHu0dYUkIxSaFtU0mwH4bwbRMfCAQ
 cf1E810wJmvyETm2yNiBRNMVhgGH9L4eVxjO+JQGIjUZh43NH5KQ5YhTocxVwEQeo/DN
 /OJ9ScgXA7q3pTA3Yif44+mep/61M4En061JKSjZqGmuPib3KK/ElQXLZIk8sOzqGM27
 uULmtN3t7jV3iKya1k78ybHmOD/gTdcp5fcIL9J+4f1+kOuhuu/NXFwsy99R6oSnFZt4
 kkWKZ16i0XybeQYHs6BzC2aoySlIvVZ5l38ENZYrZKXCdvZiexGP77Ihx/ABQrJE3rbd
 zEOw==
X-Gm-Message-State: AOJu0YycfhpCuVgBq+vJaWlhp7i9wsDHIiRviZhhbQPBDY9WvMD/zuMM
 +iG92KaxQgxlELeO1MUT0T0xYoVZik32JBYzTjdmyC3zvHeT6Sj2x1MN1g==
X-Google-Smtp-Source: AGHT+IHaB4mud7yoqdw4or23bS3jHCICb7+UxubYnzi7cZZCtZSD8IMDC1lbbCqFppOGr0apuSCrkQ==
X-Received: by 2002:a17:902:d502:b0:207:7eaa:d6bb with SMTP id
 d9443c01a7336-2077eaad810mr129842065ad.29.1726413991963; 
 Sun, 15 Sep 2024 08:26:31 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:31 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 08/17] bsd-user: Implement RISC-V sysarch system call
 emulation
Date: Mon, 16 Sep 2024 01:25:45 +1000
Message-Id: <20240915152554.8394-9-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x632.google.com
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


