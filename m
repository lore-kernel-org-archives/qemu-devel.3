Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10583CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDtZ-0006I6-DK; Tue, 24 Sep 2024 18:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsw-0003VV-Kd
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:56 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDst-0001kX-WD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:53 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718d91eef2eso236291b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216389; x=1727821189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0LatF5oNXluukNXkZ5PRTtc9NBz8bSdXxQ7YY+8+Dg=;
 b=eLcglmomd0XoDt1j17wXFtVcFgyEYm/kdT1730ET7q9Alisy9FBCwA3yOJrcju518M
 e9XFoNiMtDxRXNMsxfb19G1ING9Vhv9+AF78d25g6LzyHVX9hv0b+Yu4hscm62BHFOTN
 BT2vM5LcJKshMpWjinmZcRVuMT8rXnUHiSi/AOUqH+uzpHLF7LxtCeAgmKYJKEKRFRYu
 JoaTmnbvgJX2BAWBLPBvbA/ZRpy0ngd0SNLvOhPx2upM0ZfZYQ1ck9TyGn/aqDQROezY
 TBktlPypziVUx87xGr5BbeueFDDAjSGSZO7K778O9hw4JBrHl4MwusvtWvOz8YGfnmHO
 EutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216389; x=1727821189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0LatF5oNXluukNXkZ5PRTtc9NBz8bSdXxQ7YY+8+Dg=;
 b=Fld6g03rrvdmGtZXI9WE5B6a+pqI+xLGduQUNp7DOkfF1kjnlsKXyFTAueR94AUypR
 qxEVVAVJDKixL2HzjeyGL51s6elmEDBr20M+ei+F9ajIW1ncc/y/2AoV7smYKYVSj52F
 ykoPfOEh4k0idhtZQPuJhkvcwSXxkBCh61JWaM0QD1k1M8a/drAmYYQoihHdEGyKh8p6
 apdARZEF5K7Zh3QJQQDI1kQQ0B9gUS1gsTqqYKNjGPb5wa89s9OYBNd63AAfrvIxrP4m
 mqeByiEvqCpec6EkSfXs7ylXk4CwPXyTaJwsYx5w+xVVjwiPaYuMKy6Uc0covEefaVP2
 vPfQ==
X-Gm-Message-State: AOJu0YzsWb79YSZexhP+3Y3VnU3l6MOluzRjngjKXgcaGVvEzMzbCvW5
 kV0E1Cegm3odeX3TAN2NJ+6dSfzzlKuc1nmZ5uYaIjeyVdqmOsksu3E/YA==
X-Google-Smtp-Source: AGHT+IGU7lnrlV1MjNNMtJhVNFity1oLUV+qG4zyrW6S7o7PqpRGTy06ezriO5c85rH5njyyOXUbtQ==
X-Received: by 2002:a05:6a00:8a04:b0:714:21cd:a4e3 with SMTP id
 d2e1a72fcca58-71afa29c2e2mr6614259b3a.13.1727216389088; 
 Tue, 24 Sep 2024 15:19:49 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:19:48 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 34/47] bsd-user: Implement RISC-V TLS register setup
Date: Wed, 25 Sep 2024 08:17:35 +1000
Message-ID: <20240924221751.2688389-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
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
2.46.1


