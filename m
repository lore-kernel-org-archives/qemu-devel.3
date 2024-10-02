Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9832CF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHf-000773-Df; Wed, 02 Oct 2024 01:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHR-0006cj-HG
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:10 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHO-0004um-SY
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:09 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20bb610be6aso15600525ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848325; x=1728453125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9q8o1rqxr0ztdJ6JFR1Lgtcsz6qa9Ata3gYfSSUHnU=;
 b=jJmwI6yARVEuscCMhaRbCrI/jl6vFSEbnqrdaa0XJLjCCmilvD3N4lgQWbytoAWArH
 ZaWAb7jyigyPZPJ2MsCm8Xu+rRQFEAv3GpyuvI7vxi3LWgqag/XHcIfV2dfR4Zk49WUH
 yf2IZO0ORDvzneEqQ7DwXoSyxggQEjO4yGFwugNzgdvsLaKibr7kqpb5zBBQjpNk7Z1m
 ii2aN5f3AnhOT0sTZ+ef1HDVp8a2719xrmaa0YQjKCFNxzvEkgB5zixvEFM3+wRXGTwd
 yoCJtzCpUuFkShPTYjXvxTISSpxOKEHmXFNwjxVNDxURCbVWNMfiKYpfJIWYVrrDsp29
 FI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848325; x=1728453125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9q8o1rqxr0ztdJ6JFR1Lgtcsz6qa9Ata3gYfSSUHnU=;
 b=KpjInLtCDZU1Wq07ZJa8Mcrf33X1EFPTRwcXkrrHCC8j9QbzwpY4Hc1DjyiLbg7EWl
 moVZ2isFrJYROykbYG6bOOg+tsg+6Cc+mvjMBb1MgxWFC5xp9wue3abnTJWNSkkwf9sh
 p4e0zd8rDVG99bnkCY2KANSxDJoS7za7x1JjJO3wN8jcfFN9OJAoo9L2Jzrgg9wdyKcx
 6E+IIDZdCKBVJeLkft760Pj3xG5Ix7hEtBa6iuH/WblFuRllq5OEIrvxHbF0BGh2V7jJ
 aVaNN8nchASLTYCF7Qwvg9GXmk4lPFor8rZKlqtLKFFDagN7z1B9HgCLACuN0S52qjLK
 xY8A==
X-Gm-Message-State: AOJu0YxWT0k3Eptd6nF1DmSw2jymg+lZ5AVztRBUzCvbrD6rRb8CFkO1
 erva6L0bI6GJ9xxGXkD4seUWiksyp065fsrZV7tYHZEtd5GUdv8INPkfaIOe
X-Google-Smtp-Source: AGHT+IFCbG3QMi8BMfBp88QxxixZ1Desvk/ExKDaLrpb6EgRcmiGobHgwTROCDnLZFrEQpDlRhhUHQ==
X-Received: by 2002:a17:902:da8f:b0:20b:5231:cd61 with SMTP id
 d9443c01a7336-20bc5a20b08mr29326885ad.24.1727848324947; 
 Tue, 01 Oct 2024 22:52:04 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:52:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 22/35] bsd-user: Implement RISC-V TLS register setup
Date: Wed,  2 Oct 2024 15:50:35 +1000
Message-ID: <20241002055048.556083-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

Included the prototype for the 'target_cpu_set_tls' function in the
'target_arch.h' header file. This function is responsible for setting
the Thread Local Storage (TLS) register for RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-5-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target_arch.h     | 27 +++++++++++++++++++++++++++
 bsd-user/riscv/target_arch_cpu.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch.h
 create mode 100644 bsd-user/riscv/target_arch_cpu.c

diff --git a/bsd-user/riscv/target_arch.h b/bsd-user/riscv/target_arch.h
new file mode 100644
index 0000000000..26ce07f343
--- /dev/null
+++ b/bsd-user/riscv/target_arch.h
@@ -0,0 +1,27 @@
+/*
+ * RISC-V specific prototypes
+ *
+ * Copyright (c) 2019 Mark Corbin <mark.corbin@embecsom.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_H
+#define TARGET_ARCH_H
+
+#include "qemu.h"
+
+void target_cpu_set_tls(CPURISCVState *env, target_ulong newtls);
+
+#endif /* TARGET_ARCH_H */
diff --git a/bsd-user/riscv/target_arch_cpu.c b/bsd-user/riscv/target_arch_cpu.c
new file mode 100644
index 0000000000..44e25d2ddf
--- /dev/null
+++ b/bsd-user/riscv/target_arch_cpu.c
@@ -0,0 +1,29 @@
+/*
+ *  RISC-V CPU related code
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
+#include "qemu/osdep.h"
+
+#include "target_arch.h"
+
+#define TP_OFFSET       16
+
+/* Compare with cpu_set_user_tls() in riscv/riscv/vm_machdep.c */
+void target_cpu_set_tls(CPURISCVState *env, target_ulong newtls)
+{
+    env->gpr[xTP] = newtls + TP_OFFSET;
+}
-- 
2.46.2


