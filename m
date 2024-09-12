Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991B8EE57FD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZgW-00042M-Lp; Wed, 11 Sep 2024 22:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1soZgU-0003zI-0I
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:35:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1soZgQ-0003WQ-EE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:35:49 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxB+l+U+JmZmMFAA--.11546S3;
 Thu, 12 Sep 2024 10:35:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxHeR5U+JmelsEAA--.25141S5;
 Thu, 12 Sep 2024 10:35:41 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 bibo mao <maobibo@loongson.cn>
Subject: [PATCH 3/5] include: Add loongarch_pic_common header file
Date: Thu, 12 Sep 2024 10:35:35 +0800
Message-Id: <20240912023537.1004979-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240912023537.1004979-1-maobibo@loongson.cn>
References: <20240912023537.1004979-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHeR5U+JmelsEAA--.25141S5
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: bibo mao <maobibo@loongson.cn>

For header file hw/intc/loongarch_pch_pic.h, add common file
hw/intc/loongarch_pic_common.h and remove duplicated macro definition
in file loongarch_pch_pic.h

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 include/hw/intc/loongarch_pch_pic.h | 36 +++++------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index d5437e88f2..c71ee59de2 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -5,42 +5,16 @@
  * Copyright (c) 2021 Loongson Technology Corporation Limited
  */
 
+#ifndef HW_LOONGARCH_PCH_PIC_H
+#define HW_LOONGARCH_PCH_PIC_H
+
 #include "hw/sysbus.h"
+#include "hw/intc/loongarch_pic_common.h"
 
 #define TYPE_LOONGARCH_PCH_PIC "loongarch_pch_pic"
 #define PCH_PIC_NAME(name) TYPE_LOONGARCH_PCH_PIC#name
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHPIC, LOONGARCH_PCH_PIC)
 
-#define PCH_PIC_INT_ID_VAL              0x7000000UL
-#define PCH_PIC_INT_ID_VER              0x1UL
-
-#define PCH_PIC_INT_ID_LO               0x00
-#define PCH_PIC_INT_ID_HI               0x04
-#define PCH_PIC_INT_MASK_LO             0x20
-#define PCH_PIC_INT_MASK_HI             0x24
-#define PCH_PIC_HTMSI_EN_LO             0x40
-#define PCH_PIC_HTMSI_EN_HI             0x44
-#define PCH_PIC_INT_EDGE_LO             0x60
-#define PCH_PIC_INT_EDGE_HI             0x64
-#define PCH_PIC_INT_CLEAR_LO            0x80
-#define PCH_PIC_INT_CLEAR_HI            0x84
-#define PCH_PIC_AUTO_CTRL0_LO           0xc0
-#define PCH_PIC_AUTO_CTRL0_HI           0xc4
-#define PCH_PIC_AUTO_CTRL1_LO           0xe0
-#define PCH_PIC_AUTO_CTRL1_HI           0xe4
-#define PCH_PIC_ROUTE_ENTRY_OFFSET      0x100
-#define PCH_PIC_ROUTE_ENTRY_END         0x13f
-#define PCH_PIC_HTMSI_VEC_OFFSET        0x200
-#define PCH_PIC_HTMSI_VEC_END           0x23f
-#define PCH_PIC_INT_STATUS_LO           0x3a0
-#define PCH_PIC_INT_STATUS_HI           0x3a4
-#define PCH_PIC_INT_POL_LO              0x3e0
-#define PCH_PIC_INT_POL_HI              0x3e4
-
-#define STATUS_LO_START                 0
-#define STATUS_HI_START                 0x4
-#define POL_LO_START                    0x40
-#define POL_HI_START                    0x44
 struct LoongArchPCHPIC {
     SysBusDevice parent_obj;
     qemu_irq parent_irq[64];
@@ -67,3 +41,5 @@ struct LoongArchPCHPIC {
     MemoryRegion iomem8;
     unsigned int irq_num;
 };
+
+#endif /* HW_LOONGARCH_PCH_PIC_H */
-- 
2.39.3


