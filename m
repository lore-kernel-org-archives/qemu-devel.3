Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1234C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0TI-00064h-FY; Fri, 16 Aug 2024 13:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0T7-000556-Ob
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:32 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0St-0007Md-5o
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:28 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2cb53da06a9so1523546a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828210; x=1724433010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8SeRNxqA0kdGYXuMPPKRU3j4MVX/4+712bEYl1oABA=;
 b=iscvKFrjt/A5EF61wo4QtDkKgIZPKZ+n4fZDDdZFHFGilP4wxO2zPTnjbH+wO7dotb
 KtyrT4b8J2A1mQt0h38oMVvn853qeLYUOI0A4CP+J+xJslPkWmGYkCDNov0jLHUW9n9b
 1SnOqAyv0rZEB4fYZ5tepwQNcDOJLHAXQJjw42i8F61Qhz2isO42GHnfucetJ4uEhwl+
 SDgENmnEZ7TG1JtATC40e6TYwZTPkap0nlpCzozxMhQDG97p6hllgrlva+mQPpeuDh9b
 t2N29Eqv0gItTmeA/7gyjC4Fgib5AKUk8/7RFRztKXJ4O60cZrWXJ+JE69TCLfV+1K2r
 4PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828210; x=1724433010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8SeRNxqA0kdGYXuMPPKRU3j4MVX/4+712bEYl1oABA=;
 b=TD986ETRwwv348oyDH7d/Ri+7ywmI5PXst7gocXLbgTTI6JCBOijNjON6QXOsKZHjC
 Kvcsjt8Fev0bd9q3M9RrDEZFWYjti0mhwiekX52yTee4MDYy2/hXzmio3AFNkVMcULS2
 QdqiPmh8eKlec6ePRU/iO1b94NbSbgY62WfEoTpTXTMzCuNytVQ5yuu6WaSPrHjXQJZt
 Yc6ktxp7PLnw4ZTt5In44GL7Op22zaRQIv4QueY8fbKFOqcIVODEhgCkHFzVRU38uPEv
 WG7cm1o96qBXRXmXv2A91GGdF4Nq4LVZqIP8YhN4KuayvQc4lXz8W5cH2ATfvF+cTLw/
 N44A==
X-Gm-Message-State: AOJu0Yxl06CENfhhJESgt2uD8GeIKrrkkMROFsBqhjg0yVWJP9oJ8Sbc
 ZnwbO5JPIXiHkT1fYI2qZ0yndtvYiyiPesTummOzkLN/gne15LTPPD5Ks0VdYY4=
X-Google-Smtp-Source: AGHT+IEw9LlDo44bKLnPOtesVidS+Ec1LUqo9j3zhj+z2q6c3fiV6l1i9W36UfJHYLb6SUZws76t1Q==
X-Received: by 2002:a17:90a:43a2:b0:2d3:ca71:dbb3 with SMTP id
 98e67ed59e1d1-2d3ca71e1b8mr8889183a91.17.1723828210168; 
 Fri, 16 Aug 2024 10:10:10 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:09 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 04/17] bsd-user: Implement RISC-V TLS register setup
Date: Sat, 17 Aug 2024 03:09:36 +1000
Message-Id: <20240816170949.238511-5-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=itachis6234@gmail.com; helo=mail-pj1-x102b.google.com
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

Included the prototype for the 'target_cpu_set_tls' function in the
'target_arch.h' header file. This function is responsible for setting
the Thread Local Storage (TLS) register for RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


