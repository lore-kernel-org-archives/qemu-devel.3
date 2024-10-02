Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11758CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHI-0006Op-Mf; Wed, 02 Oct 2024 01:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHH-0006MP-2g
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:59 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHF-0004uB-CU
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:58 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20bcae5e482so2573925ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848314; x=1728453114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yn+cm4ym2epVgTo4WgtcW7AtRv+/gP6vj8Ibil2PIwI=;
 b=YVV0vNstd/7bTp+N+KXpA96eH+vJ1a5zUbvLrpbVER45ETDRz0Q+vCJDixuEbs9Hvp
 BQ4XLOJlY3zzBZBhaLBwLxBRceBbQxBgJ+7T6gsh3WN/Gz04msjjXE3qvVjb4NfMV/HG
 9P4BptjY+TocmcrDWmY2q+vSxKiPzChdoSbQ+hLP81t3AewCVlC3rP7YVEc3+VHeleVy
 5ci4VVyqKEcrsBE8lyx3DH08P3mqQW7275IrTVtbZZ9VMzXxTIpyvgfRt9lry/05gJaW
 R8wvIWFE9IBoL31LIdj6GNW4hOeYo5ZGQoB2MinbYDBsjDzRUjZUbOz0cDthqyUoYAjM
 MgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848314; x=1728453114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yn+cm4ym2epVgTo4WgtcW7AtRv+/gP6vj8Ibil2PIwI=;
 b=E33nlwystzY7bDRltblgf5t1LwzXVxPqWXKoYfOT5apnzAcL8/lrFGAGWBnA4zTMYL
 G/trJp3qr0BMXdj6Gv9HO4H04Vs2u46tzML7EUzvpLF/Yu1l5bu1wnB5C+Nn+9AYHZ9A
 9TOvo/KzmTyK9jmTs+bQshrAPzMmlxAIXBeLm9jP1azgYjWtvq8hstHyXvKinqS60xa2
 iQzQlySLeCKXarEsYfbB+ZbdgkosWxj9yQGpYEGrIgGwGVxy00kwO/SF7Z2LnDCmGcjz
 5DAHRADdHyXvILBeRNdY3pngWeQyFkDCL6N0fw2HrSGArkI2CFBO4mWkk+nTrqVTF6/Q
 Iz7Q==
X-Gm-Message-State: AOJu0YzAsojwfAqJ0RvBpmWZqnS5N1oieJgyEV98IPoD7aYBQPu/jNJI
 wjq/jFUAQM548JCuKMW2I2lfMbWfECQQF7RW0FrvjS7lV1vNG3t2ULb/PxBq
X-Google-Smtp-Source: AGHT+IH7wfigb9dL/CNuc0VPZ2FeTJI093f3Wllpl7+RgAVVM0fVVuFjhM0N6Nc6QQhrxlvIM5PiWg==
X-Received: by 2002:a17:902:ce8a:b0:20b:61ec:7d3c with SMTP id
 d9443c01a7336-20bc5a76182mr31263455ad.49.1727848314537; 
 Tue, 01 Oct 2024 22:51:54 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:54 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 19/35] bsd-user: Implement RISC-V CPU initialization and
 main loop
Date: Wed,  2 Oct 2024 15:50:32 +1000
Message-ID: <20241002055048.556083-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

Added the initial implementation for RISC-V CPU initialization and main
loop. This includes setting up the general-purpose registers and
program counter based on the provided target architecture definitions.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-2-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target_arch_cpu.h | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_cpu.h

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
new file mode 100644
index 0000000000..f8d85e01ad
--- /dev/null
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -0,0 +1,40 @@
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
+#include "signal-common.h"
+
+#define TARGET_DEFAULT_CPU_MODEL "max"
+
+static inline void target_cpu_init(CPURISCVState *env,
+        struct target_pt_regs *regs)
+{
+    int i;
+
+    for (i = 1; i < 32; i++) {
+        env->gpr[i] = regs->regs[i];
+    }
+
+    env->pc = regs->sepc;
+}
+
+#endif /* TARGET_ARCH_CPU_H */
-- 
2.46.2


