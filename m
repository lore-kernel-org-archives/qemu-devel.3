Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7309FC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 02:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYFS3-0004cP-7H; Wed, 15 Jan 2025 21:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tYFRz-0004b6-I5
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tYFRx-0006Cv-9g
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:39 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_3M_bIhnezJkAA--.11009S3;
 Thu, 16 Jan 2025 10:17:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAx+8QnbIhnhWokAA--.14648S8;
 Thu, 16 Jan 2025 10:17:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PULL 6/8] hw/intc/loongarch_ipi: Remove property num-cpu
Date: Thu, 16 Jan 2025 10:17:08 +0800
Message-Id: <20250116021710.251648-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250116021710.251648-1-maobibo@loongson.cn>
References: <20250116021710.251648-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx+8QnbIhnhWokAA--.14648S8
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

Since cpu number can be acquired from possible_cpu_arch_ids(),
num-cpu property is not necessary. Here remove num-cpu property
for object TYPE_LOONGARCH_IPI object.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c | 5 -----
 hw/loongarch/virt.c     | 1 -
 2 files changed, 6 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 49b4595d90..41d9625dcb 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -79,10 +79,6 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static const Property loongarch_ipi_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, 1),
-};
-
 static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
 {
     LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
@@ -91,7 +87,6 @@ static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
 
     device_class_set_parent_realize(dc, loongarch_ipi_realize,
                                     &lic->parent_realize);
-    device_class_set_props(dc, loongarch_ipi_properties);
     licc->get_iocsr_as = get_iocsr_as;
     licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index db37ed6a71..63fa0f4e32 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -899,7 +899,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
 
     /* Create IPI device */
     ipi = qdev_new(TYPE_LOONGARCH_IPI);
-    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
     /* IPI iocsr memory region */
-- 
2.43.5


