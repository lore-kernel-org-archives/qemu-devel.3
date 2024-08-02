Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94853C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkb-0008VI-RW; Fri, 02 Aug 2024 04:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnka-0008Oo-A7
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:00 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkY-0006TB-DM
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:59 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-65cd720cee2so61113877b3.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587697; x=1723192497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FU+b6dUoBjsocz/d/5vk6kGzu16116lUTmnWX1JCuIo=;
 b=SiGTP7xYkDszBvALk6facfMxTH6bpE8rOG//0t0VVTyh97is+vSIK5DnEavOBoYcaF
 OQoj71jiLl1Ymuy5XKIkM01zoErflvZbWXOtSX8RCOJ/vz8CBTFFAbZLOeN0PkQPKLvh
 CFe/WpRForytcywpvXVfHOkYSrQZnm1NTZPk2bdcAf/UI041/lxhKhxvKpoaESttIwy7
 W5aCWYaWPHYDPTroICHMZ25uvFwBJXzlQQgWSsMM6/DwBnwSDxv1n8Jz08iOgOgXG6KH
 oeELIlyMERveKVR50XThKc9kE1xsOZze48GossPsUG/21VN8oj4tnYJbDd/kfDArZIn1
 IMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587697; x=1723192497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FU+b6dUoBjsocz/d/5vk6kGzu16116lUTmnWX1JCuIo=;
 b=H9s5p+4XBOqCnX9p+aSX603a3fLK7Qezt6CjDGNpSzLz/GjtAUaRHDCzxQZABpHXNN
 Kmyh4Clp8JCchU/hKx2MZAGChx91FIUtXAG6uM0mSNbGWnGchR/4hRrIwqA3qBpZ6bnC
 Wmi/frV0m4X+PMK/yIDQn0WXBl4yRemrpJDbYCs/bql1PNPMxEb1HDKF5iBoeQH0dwQH
 RIu8/iJI9KGmdd9PAdIyoim29+XlfuDFyyWgPYMuoCFqx9U34hCPRA9XYU0jGlUQbV/l
 6ETM5hyAccKGZHi5bxFiSu10DR6sajLtz7XA4xYl/MqzMx9fLbsC+X/lsARYkEOeZEf8
 T0yw==
X-Gm-Message-State: AOJu0YyjGXYKgY5OZDIS8q49RzUuGO3uicCa+B8MKP47IameTjMlaybE
 v2W8ZJhjv7UzQqNpLuszCEj3o1g/yTpIaYUVxVmRlGR2PitmGES7C3Lh3hoI/t8=
X-Google-Smtp-Source: AGHT+IGIqkAghGdOn23+5A5TG6f6wulvnGyN/zzSEfG0O94EftkTa8rgHJE/5lkBRCAM9qOU24C50w==
X-Received: by 2002:a0d:fd42:0:b0:64b:4f90:ced1 with SMTP id
 00721157ae682-689601a6edamr30760477b3.12.1722587696966; 
 Fri, 02 Aug 2024 01:34:56 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:34:56 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 09/18] bsd-user: Implement RISC-V sysarch system call emulation
Date: Fri,  2 Aug 2024 18:34:14 +1000
Message-Id: <20240802083423.142365-10-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=itachis6234@gmail.com; helo=mail-yw1-x112d.google.com
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

Added the 'do_freebsd_arch_sysarch' function to emulate the 'sysarch'
system call for the RISC-V architecture.
Currently, this function returns '-TARGET_EOPNOTSUPP' to indicate that
the operation is not supported.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
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


