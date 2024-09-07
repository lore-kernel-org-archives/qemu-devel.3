Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3E8E6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smlzb-0003WX-Ai; Fri, 06 Sep 2024 23:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzN-00037v-Bw
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:53 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzK-0004rG-U4
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:52 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7cd8d2731d1so2029845a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679188; x=1726283988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8SeRNxqA0kdGYXuMPPKRU3j4MVX/4+712bEYl1oABA=;
 b=Og5eTAW5uyMtQ7VxE5G6HY5SnKobbtffP7LNWjbelKgpr8L1b60ELn6UcXW7NGVI7f
 uAE6W+dyoMEHsMh9B7eErSTprVUbstBASYw7wwbLwhT8A3+WA1ymOk28BPoastqOfOYr
 /fV7RfScAFgI5AyLw5aTo9DpNmsCJ4BDReaspf9Owz8Sq0Ks5HJmoeSDF83zZvcoTnFT
 OovzpFbPWiaMMe2T+dGRF/WhnjbbLDtHfbT0Wn92k8MA2OJAZzbmWybCKbD7qySkMhqH
 HTgalZiBnUcj7EX346al+fiP211Hn8bVAv77ZBXA1HI+08GI5h51prLbWcPia69svEhX
 4RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679188; x=1726283988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8SeRNxqA0kdGYXuMPPKRU3j4MVX/4+712bEYl1oABA=;
 b=Y0kmyHplvWEOpz5qjaZZVnyvTzt6n6DSq3ExXbVYxAPsDoPYCcvx3zwH+jZyfjmaw4
 OwUxCyHRNpSV4De5CIXtS3Lx6cvCjLh7bb6K+LH6EFOFS4FPQp9+QntN3fEd4I5q5EMK
 73wRPZmC6I6B6mcUntljcTvsQu82hnCTqtqJxxj6Q0mNoS/xk04aUI5PQ5H/LDDDy3yG
 cU56lTMzGtQffXeZ6uuw9LIBgAE0EdRUUwauM2ZHiDwzClkmYrDr9V7vSK3Z8Lk9hDkO
 ZSHQXGn3ZJJS20cyX2ydbfYvfzIfK20h59gDC1+J5eLgEOIG/NVspEpB9VfhrEI0su+P
 4Ffg==
X-Gm-Message-State: AOJu0YwlKD0Kxl09P+CU3YfwsW4bPUl2fnSs24J1WF4pRKPngJ8jPnuo
 CGqK+14VqNy7FJnsBh11IXuH4iW09nV3f1Pg5LGzN+gBiomBuMrYNqRexA==
X-Google-Smtp-Source: AGHT+IGG+sUJbGYq9NZ/S4VOpzdVfNd51bWx/3F/4gNI1C9rXjp68Fyry7pFPGEsfNr+KKnovNtNyg==
X-Received: by 2002:a17:902:ce10:b0:206:96bf:b0cf with SMTP id
 d9443c01a7336-206f0358aa2mr57348135ad.0.1725679187833; 
 Fri, 06 Sep 2024 20:19:47 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:19:47 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 04/17] bsd-user: Implement RISC-V TLS register setup
Date: Sat,  7 Sep 2024 13:19:14 +1000
Message-Id: <20240907031927.1908-5-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=itachis6234@gmail.com; helo=mail-pg1-x52b.google.com
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


