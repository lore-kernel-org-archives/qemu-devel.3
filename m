Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AA4C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 03:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLajD-000328-8m; Sun, 23 Jun 2024 23:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1sLajA-00030N-WD
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 23:50:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1sLaj8-0004jP-20
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 23:50:48 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx7eoQ7XhmY2kJAA--.38458S3;
 Mon, 24 Jun 2024 11:50:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxJMUQ7XhmhaYuAA--.35201S2; 
 Mon, 24 Jun 2024 11:50:40 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	Song Gao <gaosong@loongson.cn>
Subject: [PATCH] hw/loongarch: Modify  flash block size to 256K
Date: Mon, 24 Jun 2024 11:33:19 +0800
Message-Id: <20240624033319.999631-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxJMUQ7XhmhaYuAA--.35201S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

loongarch added a common library for edk2 to
parse flash base addresses through fdt.
For compatibility with other architectures,
the flash block size in qemu is now changed to 256k.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>

 include/hw/loongarch/virt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 8fdfacf268..603c1cebdb 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -20,7 +20,7 @@
 #define VIRT_FWCFG_BASE         0x1e020000UL
 #define VIRT_BIOS_BASE          0x1c000000UL
 #define VIRT_BIOS_SIZE          (16 * MiB)
-#define VIRT_FLASH_SECTOR_SIZE  (128 * KiB)
+#define VIRT_FLASH_SECTOR_SIZE  (256 * KiB)
 #define VIRT_FLASH0_BASE        VIRT_BIOS_BASE
 #define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE
 #define VIRT_FLASH1_BASE        0x1d000000UL
-- 
2.39.1


