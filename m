Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9B6C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 07:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbDgD-0005uO-Rb; Fri, 24 Jan 2025 02:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tbDgB-0005sl-6j
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:00:35 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tbDg8-00083r-9P
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:00:34 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx7eKKOpNnJyhoAA--.11389S3;
 Fri, 24 Jan 2025 15:00:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_8eGOpNnM2ksAA--.32130S6;
 Fri, 24 Jan 2025 15:00:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 4/7] target/loongarch: Add common header file for CSR registers
Date: Fri, 24 Jan 2025 15:00:18 +0800
Message-Id: <20250124070021.800907-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250124070021.800907-1-maobibo@loongson.cn>
References: <20250124070021.800907-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_8eGOpNnM2ksAA--.32130S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Common header file csr.h is added here, it can be used by both
TCG mode and kvm mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/csr.h                        | 25 +++++++++++++++++++
 .../tcg/insn_trans/trans_privileged.c.inc     | 16 +-----------
 2 files changed, 26 insertions(+), 15 deletions(-)
 create mode 100644 target/loongarch/csr.h

diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
new file mode 100644
index 0000000000..20d4bf5dc7
--- /dev/null
+++ b/target/loongarch/csr.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Loongson Technology Corporation Limited
+ */
+
+#ifndef TARGET_LOONGARCH_CSR_H
+#define TARGET_LOONGARCH_CSR_H
+
+#include "cpu-csr.h"
+
+typedef void (*GenCSRFunc)(void);
+enum {
+    CSRFL_READONLY = (1 << 0),
+    CSRFL_EXITTB   = (1 << 1),
+    CSRFL_IO       = (1 << 2),
+};
+
+typedef struct {
+    int offset;
+    int flags;
+    GenCSRFunc readfn;
+    GenCSRFunc writefn;
+} CSRInfo;
+
+#endif /* TARGET_LOONGARCH_CSR_H */
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 0513cac577..87506ec0dc 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -5,7 +5,7 @@
  * LoongArch translation routines for the privileged instructions.
  */
 
-#include "cpu-csr.h"
+#include "csr.h"
 
 #ifdef CONFIG_USER_ONLY
 
@@ -44,20 +44,6 @@ GEN_FALSE_TRANS(idle)
 
 typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env);
 typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src);
-typedef void (*GenCSRFunc)(void);
-
-typedef struct {
-    int offset;
-    int flags;
-    GenCSRFunc readfn;
-    GenCSRFunc writefn;
-} CSRInfo;
-
-enum {
-    CSRFL_READONLY = (1 << 0),
-    CSRFL_EXITTB   = (1 << 1),
-    CSRFL_IO       = (1 << 2),
-};
 
 #define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
     [LOONGARCH_CSR_##NAME] = {                             \
-- 
2.43.5


