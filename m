Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78527CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJMv-00085J-1C; Mon, 12 Oct 2026 12:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMR-0007yz-H7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 12:58:52 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1xGJMO-0006CJ-Rj
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 12:58:51 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4j3Nw13jnTzBqfW;
 Mon, 12 Oct 2026 18:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1791824321;
 bh=uqTbvuo/zJtXTe+rLQT9ZSufS6hh+dOK1T9kqU6JZMU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oVG4TEBXSbqHadUom3zQl9B+tcufIqCA0DPeAcSaQcikbKjrtE//7Sv4qxURDmM7N
 6iEY2T1PUorh4FG58nSReHD07A1xgNumGQtG2yqAIpQcjJB8TRGyBeSht/SMlfqjfj
 xsUE4rLqNHnzTJchCw+Mjo31EJAw/p46BH81lDUhza56EOs0oZPKAQnpSe0DU5bsNX
 sfr7D4tTTO+VrhbQASeE5MxUZUm//rMAHYl13Asd6qJxZNyX8tykkgxm81+by9xr7t
 W7RI3WJ7W1hfw2XpXJ2RTgxayM9XjzEIKh90lB9T4VNXfVg9XaPKJ3A27/C3rIQrPE
 ztHRLvz1YLF/Q==
Received: from localhost.localdomain (unknown [134.206.205.113])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4j3Nw12ztDz83nY;
 Mon, 12 Oct 2026 18:58:41 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [RFC PATCH 2/9] hw/misc: add common RP2040 peripheral definitions
Date: Mon, 12 Oct 2026 18:58:32 +0200
Message-ID: <20261012165840.99050-3-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
References: <20261012165840.99050-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RP2040 APB peripherals share atomic XOR, SET and CLEAR alias windows.
Add common constants and an inline update helper so individual device
models do not duplicate this behavior.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 include/hw/misc/rp2040.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 include/hw/misc/rp2040.h

diff --git a/include/hw/misc/rp2040.h b/include/hw/misc/rp2040.h
new file mode 100644
index 0000000000..13e05c9526
--- /dev/null
+++ b/include/hw/misc/rp2040.h
@@ -0,0 +1,32 @@
+/*
+ * RP2040 common peripheral helpers
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_H
+#define HW_MISC_RP2040_H
+
+#include "exec/hwaddr.h"
+
+#define RP2040_ATOMIC_ALIAS_MASK 0x3000
+#define RP2040_ATOMIC_XOR        0x1000
+#define RP2040_ATOMIC_SET        0x2000
+#define RP2040_ATOMIC_CLR        0x3000
+
+static inline uint32_t rp2040_atomic_update(uint32_t old, uint32_t value,
+                                            hwaddr alias)
+{
+    switch (alias) {
+    case RP2040_ATOMIC_XOR:
+        return old ^ value;
+    case RP2040_ATOMIC_SET:
+        return old | value;
+    case RP2040_ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+#endif
-- 
2.55.0


