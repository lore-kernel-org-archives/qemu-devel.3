Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA9FC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 02:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7mkm-0000fU-NE; Wed, 23 Apr 2025 22:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u7mkN-0000ZU-Ny
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:55:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u7mkK-00004s-GY
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 22:55:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxXWscqAlokQbFAA--.64545S3;
 Thu, 24 Apr 2025 10:55:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxrhsVqAlogNaSAA--.53120S3;
 Thu, 24 Apr 2025 10:55:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, peter.maydell@linaro.org, richard.henderson@linaro.org,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 01/13] hw/intc/loongarch_pch_msi: Remove gpio input handler
Date: Thu, 24 Apr 2025 10:33:05 +0800
Message-Id: <20250424023317.3980755-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250424023317.3980755-1-gaosong@loongson.cn>
References: <20250424023317.3980755-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhsVqAlogNaSAA--.53120S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

MSI interrupt is triggered by writing message on specified memory address.
In generic it is used by PCI devices, and no device is connected pch MSI
irqchip with GPIO pin line method, here remove gpio input setting for MSI
controller.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250410085004.3577627-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_msi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/intc/loongarch_pch_msi.c b/hw/intc/loongarch_pch_msi.c
index 66b5c1e660..bc93504ff7 100644
--- a/hw/intc/loongarch_pch_msi.c
+++ b/hw/intc/loongarch_pch_msi.c
@@ -42,13 +42,6 @@ static const MemoryRegionOps loongarch_pch_msi_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void pch_msi_irq_handler(void *opaque, int irq, int level)
-{
-    LoongArchPCHMSI *s = LOONGARCH_PCH_MSI(opaque);
-
-    qemu_set_irq(s->pch_msi_irq[irq], level);
-}
-
 static void loongarch_pch_msi_realize(DeviceState *dev, Error **errp)
 {
     LoongArchPCHMSI *s = LOONGARCH_PCH_MSI(dev);
@@ -59,9 +52,7 @@ static void loongarch_pch_msi_realize(DeviceState *dev, Error **errp)
     }
 
     s->pch_msi_irq = g_new(qemu_irq, s->irq_num);
-
     qdev_init_gpio_out(dev, s->pch_msi_irq, s->irq_num);
-    qdev_init_gpio_in(dev, pch_msi_irq_handler, s->irq_num);
 }
 
 static void loongarch_pch_msi_unrealize(DeviceState *dev)
-- 
2.34.1


